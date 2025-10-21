using CnControls;
using System;
using UnityEngine;

public class BikeControl : MonoBehaviour
{
	[Serializable]
	public class BikeWheels
	{
		public ConnectWheel wheels;

		public WheelSetting setting;
	}

	[Serializable]
	public class ConnectWheel
	{
		public Transform wheelFront;

		public Transform wheelBack;

		public Transform AxleFront;

		public Transform AxleBack;
	}

	[Serializable]
	public class WheelSetting
	{
		public float Radius = 0.3f;

		public float Weight = 1000f;

		public float Distance = 0.2f;
	}

	[Serializable]
	public class BikeLights
	{
		public Light[] brakeLights;
	}

	[Serializable]
	public class BikeSounds
	{
		public AudioSource lowCrash;

		public AudioSource nitro;

		public AudioSource switchGear;
	}

	[Serializable]
	public class BikeParticles
	{
		public GameObject brakeParticlePrefab;

		public ParticleSystem shiftParticle1;

		public ParticleSystem shiftParticle2;
	}

	[Serializable]
	public class HitGround
	{
		public string tag = "street";

		public bool grounded;

		public AudioClip brakeSound;

		public AudioClip groundSound;

		public Color brakeColor;
	}

	[Serializable]
	public class BikeSetting
	{
		public bool showNormalGizmos;

		public HitGround[] hitGround;

		public Transform MainBody;

		public Transform bikeSteer;

		public float maxWheelie = 40f;

		public float speedWheelie = 30f;

		public float slipBrake = 3f;

		public float springs = 35000f;

		public float dampers = 4000f;

		public float bikePower = 120f;

		public float shiftPower = 150f;

		public float brakePower = 8000f;

		public Vector3 shiftCentre = new Vector3(0f, -0.6f, 0f);

		public float maxSteerAngle = 30f;

		public float maxTurn = 1.5f;

		public float shiftDownRPM = 1500f;

		public float shiftUpRPM = 4000f;

		public float idleRPM = 700f;

		public float stiffness = 1f;

		public bool automatic = true;

		public float[] gears = new float[6]
		{
			-10f,
			9f,
			6f,
			4.5f,
			3f,
			2.5f
		};
	}

	private class WheelComponent
	{
		public Transform wheel;

		public Transform axle;

		public WheelCollider collider;

		public Vector3 startPos;

		public float rotation;

		public float maxSteer;

		public bool drive;

		public float pos_y;
	}

	public ControlMode controlMode = ControlMode.simple;

	public BikeWheels bikeWheels;

	public BikeLights bikeLights;

	public BikeSounds bikeSounds;

	public BikeParticles bikeParticles;

	private GameObject[] Particle = new GameObject[4];

	public BikeSetting bikeSetting;

	private Quaternion SteerRotation;

	[HideInInspector]
	public bool grounded = true;

	private float MotorRotation;

	[HideInInspector]
	public bool crash;

	[HideInInspector]
	public float steer;

	private bool brake;

	private float slip;

	[HideInInspector]
	public float steer2;

	private float accel;

	private bool shifmotor;

	[HideInInspector]
	public float curTorque = 100f;

	[HideInInspector]
	public float powerShift = 100f;

	[HideInInspector]
	public bool shift;

	private float flipRotate;

	[HideInInspector]
	public float speed;

	private float[] efficiencyTable = new float[22]
	{
		0.6f,
		0.65f,
		0.7f,
		0.75f,
		0.8f,
		0.85f,
		0.9f,
		1f,
		1f,
		0.95f,
		0.8f,
		0.7f,
		0.6f,
		0.5f,
		0.45f,
		0.4f,
		0.36f,
		0.33f,
		0.3f,
		0.2f,
		0.1f,
		0.05f
	};

	private float efficiencyTableStep = 250f;

	private float shiftDelay;

	private AudioSource audioSource;

	[HideInInspector]
	public int currentGear = 1;

	[HideInInspector]
	public float motorRPM;

	public static float tempRPM;

	public static float tempSPEED;

	private float wantedRPM;

	private float w_rotate;

	private Rigidbody myRigidbody;

	private bool shifting;

	private float Wheelie;

	private Quaternion deltaRotation1;

	private Quaternion deltaRotation2;

	private WheelComponent[] wheels;

	private float accelFwd;

	private float accelBack;

	private float steerAmount;

	private WheelComponent SetWheelComponent(Transform wheel, Transform axle, bool drive, float maxSteer, float pos_y)
	{
		WheelComponent wheelComponent = new WheelComponent();
		GameObject gameObject = new GameObject(wheel.name + "WheelCollider");
		gameObject.transform.parent = base.transform;
		gameObject.transform.position = wheel.position;
		gameObject.transform.eulerAngles = base.transform.eulerAngles;
		Vector3 localPosition = gameObject.transform.localPosition;
		pos_y = localPosition.y;
		gameObject.AddComponent(typeof(WheelCollider));
		wheelComponent.drive = drive;
		wheelComponent.wheel = wheel;
		wheelComponent.axle = axle;
		wheelComponent.collider = gameObject.GetComponent<WheelCollider>();
		wheelComponent.pos_y = pos_y;
		wheelComponent.maxSteer = maxSteer;
		wheelComponent.startPos = axle.transform.localPosition;
		return wheelComponent;
	}

	private void Awake()
	{
		myRigidbody = base.transform.GetComponent<Rigidbody>();
		SteerRotation = bikeSetting.bikeSteer.localRotation;
		wheels = new WheelComponent[2];
		WheelComponent[] array = wheels;
		Transform wheelFront = bikeWheels.wheels.wheelFront;
		Transform axleFront = bikeWheels.wheels.AxleFront;
		float maxSteerAngle = bikeSetting.maxSteerAngle;
		Vector3 localPosition = bikeWheels.wheels.AxleFront.localPosition;
		array[0] = SetWheelComponent(wheelFront, axleFront, drive: false, maxSteerAngle, localPosition.y);
		WheelComponent[] array2 = wheels;
		Transform wheelBack = bikeWheels.wheels.wheelBack;
		Transform axleBack = bikeWheels.wheels.AxleBack;
		Vector3 localPosition2 = bikeWheels.wheels.AxleBack.localPosition;
		array2[1] = SetWheelComponent(wheelBack, axleBack, drive: true, 0f, localPosition2.y);
		Transform transform = wheels[0].collider.transform;
		Vector3 localPosition3 = wheels[0].collider.transform.localPosition;
		float y = localPosition3.y;
		Vector3 localPosition4 = wheels[0].collider.transform.localPosition;
		transform.localPosition = new Vector3(0f, y, localPosition4.z);
		Transform transform2 = wheels[1].collider.transform;
		Vector3 localPosition5 = wheels[1].collider.transform.localPosition;
		float y2 = localPosition5.y;
		Vector3 localPosition6 = wheels[1].collider.transform.localPosition;
		transform2.localPosition = new Vector3(0f, y2, localPosition6.z);
		WheelComponent[] array3 = wheels;
		foreach (WheelComponent wheelComponent in array3)
		{
			WheelCollider collider = wheelComponent.collider;
			collider.suspensionDistance = bikeWheels.setting.Distance;
			JointSpring suspensionSpring = collider.suspensionSpring;
			suspensionSpring.spring = bikeSetting.springs;
			suspensionSpring.damper = bikeSetting.dampers;
			collider.suspensionSpring = suspensionSpring;
			collider.radius = bikeWheels.setting.Radius;
			collider.mass = bikeWheels.setting.Weight;
			WheelFrictionCurve forwardFriction = collider.forwardFriction;
			forwardFriction.asymptoteValue = 0.5f;
			forwardFriction.extremumSlip = 0.4f;
			forwardFriction.asymptoteSlip = 0.8f;
			forwardFriction.stiffness = bikeSetting.stiffness;
			collider.forwardFriction = forwardFriction;
			forwardFriction = collider.sidewaysFriction;
			forwardFriction.asymptoteValue = 0.75f;
			forwardFriction.extremumSlip = 0.2f;
			forwardFriction.asymptoteSlip = 0.5f;
			forwardFriction.stiffness = bikeSetting.stiffness;
			collider.sidewaysFriction = forwardFriction;
		}
		audioSource = (AudioSource)GetComponent(typeof(AudioSource));
		if (audioSource == null)
		{
			UnityEngine.Debug.Log("No audio please add one");
		}
	}

	public void ShiftUp()
	{
		float timeSinceLevelLoad = Time.timeSinceLevelLoad;
		if (!(timeSinceLevelLoad < shiftDelay) && currentGear < bikeSetting.gears.Length - 1)
		{
			if (!bikeSounds.switchGear.isPlaying)
			{
				bikeSounds.switchGear.GetComponent<AudioSource>().Play();
			}
			currentGear++;
			shiftDelay = timeSinceLevelLoad + 1f;
		}
	}

	public void ShiftDown()
	{
		float timeSinceLevelLoad = Time.timeSinceLevelLoad;
		if (!(timeSinceLevelLoad < shiftDelay) && currentGear > 0)
		{
			if (!bikeSounds.switchGear.isPlaying)
			{
				bikeSounds.switchGear.GetComponent<AudioSource>().Play();
			}
			currentGear--;
			shiftDelay = timeSinceLevelLoad + 0.1f;
		}
	}

	public void OnCollisionEnter(Collision collision)
	{
		bikeSounds.lowCrash.Play();
	}

	public void BikeAccelForward(float amount)
	{
		accelFwd = amount;
	}

	public void BikeAccelBack(float amount)
	{
		accelBack = amount;
	}

	public void BikeBrake(bool Brakeing)
	{
		brake = Brakeing;
	}

	public void BikeSteer(float amount)
	{
		steerAmount = amount;
	}

	public void BikeShift(bool ShiftingButton)
	{
		shift = ShiftingButton;
	}

	private void Update()
	{
		steer2 = Mathf.LerpAngle(steer2, steer * (0f - bikeSetting.maxSteerAngle), Time.deltaTime * 10f);
		MotorRotation = Mathf.LerpAngle(MotorRotation, steer2 * bikeSetting.maxTurn * Mathf.Clamp(speed / 100f, 0f, 1f), Time.deltaTime * 5f);
		if ((bool)bikeSetting.bikeSteer)
		{
			bikeSetting.bikeSteer.localRotation = SteerRotation * Quaternion.Euler(0f, wheels[0].collider.steerAngle, 0f);
		}
		float num;
		if (!crash)
		{
			Vector3 eulerAngles = base.transform.eulerAngles;
			if (eulerAngles.z > 90f)
			{
				Vector3 eulerAngles2 = base.transform.eulerAngles;
				if (eulerAngles2.z < 270f)
				{
					num = 180f;
					goto IL_011f;
				}
			}
			num = 0f;
			goto IL_011f;
		}
		bikeSetting.MainBody.localRotation = Quaternion.identity;
		Wheelie = 0f;
		goto IL_0263;
		IL_011f:
		flipRotate = num;
		Wheelie = Mathf.Clamp(Wheelie, 0f, bikeSetting.maxWheelie);
		if (shifting)
		{
			Wheelie += bikeSetting.speedWheelie * Time.deltaTime;
		}
		else
		{
			Wheelie = Mathf.MoveTowards(Wheelie, 0f, bikeSetting.speedWheelie * 2f * Time.deltaTime);
		}
		float x = 0f - Wheelie;
		float num2 = flipRotate;
		Vector3 localEulerAngles = base.transform.localEulerAngles;
		deltaRotation1 = Quaternion.Euler(x, 0f, num2 - localEulerAngles.z + MotorRotation);
		float num3 = flipRotate;
		Vector3 localEulerAngles2 = base.transform.localEulerAngles;
		deltaRotation2 = Quaternion.Euler(0f, 0f, num3 - localEulerAngles2.z);
		myRigidbody.MoveRotation(myRigidbody.rotation * deltaRotation2);
		bikeSetting.MainBody.localRotation = deltaRotation1;
		goto IL_0263;
		IL_0263:
		tempRPM = motorRPM;
	}

	private void FixedUpdate()
	{
		speed = myRigidbody.velocity.magnitude * 2.7f;
		tempSPEED = speed;
		if (crash)
		{
			myRigidbody.constraints = RigidbodyConstraints.None;
			myRigidbody.centerOfMass = Vector3.zero;
		}
		else
		{
			myRigidbody.constraints = RigidbodyConstraints.FreezeRotationZ;
			myRigidbody.centerOfMass = bikeSetting.shiftCentre;
		}
		if (controlMode == ControlMode.simple)
		{
			accel = 0f;
			shift = false;
			brake = false;
			if (!crash)
			{
				steer = Mathf.MoveTowards(steer, CnInputManager.GetAxis("Horizontal"), 0.1f);
				accel = CnInputManager.GetAxis("Vertical");
				brake = CnInputManager.GetButton("Jump");
				shift = CnInputManager.GetButton("Nitro");
			}
			else
			{
				steer = 0f;
			}
		}
		else if (controlMode == ControlMode.tilt)
		{
			accel = 0f;
			shift = false;
			brake = false;
			if (!crash)
			{
				float current = steer;
				Vector3 acceleration = Input.acceleration;
				steer = Mathf.MoveTowards(current, Mathf.Clamp(acceleration.x, -1f, 1f), 0.07f);
				accel = CnInputManager.GetAxis("Vertical");
				brake = CnInputManager.GetButton("Jump");
				shift = CnInputManager.GetButton("Nitro");
			}
			else
			{
				steer = 0f;
			}
		}
		Light[] brakeLights = bikeLights.brakeLights;
		foreach (Light light in brakeLights)
		{
			if (accel < 0f || speed < 1f)
			{
				light.intensity = Mathf.Lerp(light.intensity, 8f, 0.1f);
			}
			else
			{
				light.intensity = Mathf.Lerp(light.intensity, 0f, 0.1f);
			}
		}
		if (bikeSetting.automatic && currentGear == 1 && accel < 0f)
		{
			if (speed < 1f)
			{
				ShiftDown();
			}
		}
		else if (bikeSetting.automatic && currentGear == 0 && accel > 0f)
		{
			if (speed < 5f)
			{
				ShiftUp();
			}
		}
		else if (bikeSetting.automatic && motorRPM > bikeSetting.shiftUpRPM && accel > 0f && speed > 10f && !brake)
		{
			ShiftUp();
		}
		else if (bikeSetting.automatic && motorRPM < bikeSetting.shiftDownRPM && currentGear > 1)
		{
			ShiftDown();
		}
		if (currentGear == 0 && speed < bikeSetting.gears[0] * -10f)
		{
			accel = 0f - accel;
		}
		wantedRPM = 5500f * accel * 0.1f + wantedRPM * 0.9f;
		float num = 0f;
		int num2 = 0;
		bool flag = false;
		int num3 = 0;
		WheelComponent[] array = wheels;
		foreach (WheelComponent wheelComponent in array)
		{
			WheelCollider collider = wheelComponent.collider;
			if (wheelComponent.drive)
			{
				if (brake && currentGear < 2)
				{
					num += accel * bikeSetting.idleRPM;
					if (num > 1f)
					{
						bikeSetting.shiftCentre.z = Mathf.PingPong(Time.time * (accel * 10f), 0.5f) - 0.25f;
					}
					else
					{
						bikeSetting.shiftCentre.z = 0f;
					}
				}
				else
				{
					num += collider.rpm;
				}
				num2++;
			}
			if (crash)
			{
				wheelComponent.collider.enabled = false;
				wheelComponent.wheel.GetComponent<Collider>().enabled = true;
			}
			else
			{
				wheelComponent.collider.enabled = true;
				wheelComponent.wheel.GetComponent<Collider>().enabled = false;
			}
			if (brake || accel < 0f)
			{
				if (accel < 0f || (brake && wheelComponent == wheels[1]))
				{
					if (brake && accel > 0f)
					{
						slip = Mathf.Lerp(slip, bikeSetting.slipBrake, accel * 0.01f);
					}
					else if (speed > 1f)
					{
						slip = Mathf.Lerp(slip, 1f, 0.002f);
					}
					else
					{
						slip = Mathf.Lerp(slip, 0f, 0.02f);
					}
					wantedRPM = 0f;
					collider.brakeTorque = bikeSetting.brakePower;
					wheelComponent.rotation = w_rotate;
				}
			}
			else
			{
				WheelCollider wheelCollider = collider;
				float brakeTorque;
				if (accel == 0f)
				{
					float num5 = collider.brakeTorque = 1000f;
					brakeTorque = num5;
				}
				else
				{
					float num5 = collider.brakeTorque = 0f;
					brakeTorque = num5;
				}
				wheelCollider.brakeTorque = brakeTorque;
				slip = Mathf.Lerp(slip, 1f, 0.02f);
				w_rotate = wheelComponent.rotation;
			}
			WheelFrictionCurve forwardFriction = collider.forwardFriction;
			if (wheelComponent == wheels[1])
			{
				forwardFriction.stiffness = bikeSetting.stiffness / slip;
				collider.forwardFriction = forwardFriction;
				forwardFriction = collider.sidewaysFriction;
				forwardFriction.stiffness = bikeSetting.stiffness / slip;
				collider.sidewaysFriction = forwardFriction;
			}
			if (shift && currentGear > 1 && speed > 50f && shifmotor)
			{
				shifting = true;
				if (powerShift == 0f)
				{
					shifmotor = false;
				}
				powerShift = Mathf.MoveTowards(powerShift, 0f, Time.deltaTime * 10f);
				bikeSounds.nitro.volume = Mathf.Lerp(bikeSounds.nitro.volume, 1f, Time.deltaTime * 10f);
				if (!bikeSounds.nitro.isPlaying)
				{
					bikeSounds.nitro.GetComponent<AudioSource>().Play();
				}
				curTorque = ((!(powerShift > 0f)) ? bikeSetting.bikePower : bikeSetting.shiftPower);
				bikeParticles.shiftParticle1.emissionRate = Mathf.Lerp(bikeParticles.shiftParticle1.emissionRate, (powerShift > 0f) ? 50 : 0, Time.deltaTime * 10f);
				bikeParticles.shiftParticle2.emissionRate = Mathf.Lerp(bikeParticles.shiftParticle2.emissionRate, (powerShift > 0f) ? 50 : 0, Time.deltaTime * 10f);
			}
			else
			{
				shifting = false;
				if (powerShift > 20f)
				{
					shifmotor = true;
				}
				bikeSounds.nitro.volume = Mathf.MoveTowards(bikeSounds.nitro.volume, 0f, Time.deltaTime * 2f);
				if (bikeSounds.nitro.volume == 0f)
				{
					bikeSounds.nitro.Stop();
				}
				powerShift = Mathf.MoveTowards(powerShift, 100f, Time.deltaTime * 5f);
				curTorque = bikeSetting.bikePower;
				bikeParticles.shiftParticle1.emissionRate = Mathf.Lerp(bikeParticles.shiftParticle1.emissionRate, 0f, Time.deltaTime * 10f);
				bikeParticles.shiftParticle2.emissionRate = Mathf.Lerp(bikeParticles.shiftParticle2.emissionRate, 0f, Time.deltaTime * 10f);
			}
			wheelComponent.rotation = Mathf.Repeat(wheelComponent.rotation + Time.deltaTime * collider.rpm * 360f / 60f, 360f);
			wheelComponent.wheel.localRotation = Quaternion.Euler(wheelComponent.rotation, 0f, 0f);
			Vector3 localPosition = wheelComponent.axle.localPosition;
			if (collider.GetGroundHit(out WheelHit hit) && (wheelComponent == wheels[1] || (wheelComponent == wheels[0] && Wheelie == 0f)))
			{
				if ((bool)bikeParticles.brakeParticlePrefab)
				{
					if (Particle[num3] == null)
					{
						Particle[num3] = UnityEngine.Object.Instantiate(bikeParticles.brakeParticlePrefab, wheelComponent.wheel.position, Quaternion.identity);
						Particle[num3].name = "WheelParticle";
						Particle[num3].transform.parent = base.transform;
						Particle[num3].AddComponent<AudioSource>();
					}
					ParticleSystem component = Particle[num3].GetComponent<ParticleSystem>();
					bool flag2 = false;
					for (int k = 0; k < bikeSetting.hitGround.Length; k++)
					{
						if (hit.collider.CompareTag(bikeSetting.hitGround[k].tag))
						{
							flag2 = bikeSetting.hitGround[k].grounded;
							if ((brake || Mathf.Abs(hit.sidewaysSlip) > 0.5f) && speed > 1f)
							{
								Particle[num3].GetComponent<AudioSource>().clip = bikeSetting.hitGround[k].brakeSound;
							}
							else if (Particle[num3].GetComponent<AudioSource>().clip != bikeSetting.hitGround[k].groundSound && !Particle[num3].GetComponent<AudioSource>().isPlaying)
							{
								Particle[num3].GetComponent<AudioSource>().clip = bikeSetting.hitGround[k].groundSound;
							}
							Particle[num3].GetComponent<ParticleSystem>().startColor = bikeSetting.hitGround[k].brakeColor;
						}
					}
					if (flag2 && speed > 5f && !brake)
					{
						component.enableEmission = true;
						Particle[num3].GetComponent<AudioSource>().volume = 0.5f;
						if (!Particle[num3].GetComponent<AudioSource>().isPlaying)
						{
							Particle[num3].GetComponent<AudioSource>().Play();
						}
					}
					else if ((brake || Mathf.Abs(hit.sidewaysSlip) > 0.6f) && speed > 1f)
					{
						if (accel < 0f || ((brake || Mathf.Abs(hit.sidewaysSlip) > 0.6f) && wheelComponent == wheels[1]))
						{
							if (!Particle[num3].GetComponent<AudioSource>().isPlaying)
							{
								Particle[num3].GetComponent<AudioSource>().Play();
							}
							component.enableEmission = true;
							Particle[num3].GetComponent<AudioSource>().volume = Mathf.Clamp(speed / 60f, 0f, 1f);
						}
					}
					else
					{
						component.enableEmission = false;
						Particle[num3].GetComponent<AudioSource>().volume = Mathf.Lerp(Particle[num3].GetComponent<AudioSource>().volume, 0f, Time.deltaTime * 10f);
					}
				}
				localPosition.y -= Vector3.Dot(wheelComponent.wheel.position - hit.point, base.transform.TransformDirection(0f, 1f, 0f)) - collider.radius;
				localPosition.y = Mathf.Clamp(localPosition.y, wheelComponent.startPos.y - bikeWheels.setting.Distance, wheelComponent.startPos.y + bikeWheels.setting.Distance);
				flag = (flag || wheelComponent.drive);
				if (!crash)
				{
					myRigidbody.angularDrag = 10f;
				}
				else
				{
					myRigidbody.angularDrag = 0f;
				}
				grounded = true;
				if ((bool)wheelComponent.collider.GetComponent<WheelSkidmarks>())
				{
					wheelComponent.collider.GetComponent<WheelSkidmarks>().enabled = true;
				}
			}
			else
			{
				grounded = false;
				if ((bool)wheelComponent.collider.GetComponent<WheelSkidmarks>())
				{
					wheelComponent.collider.GetComponent<WheelSkidmarks>().enabled = false;
				}
				if (Particle[num3] != null)
				{
					ParticleSystem component2 = Particle[num3].GetComponent<ParticleSystem>();
					component2.enableEmission = false;
				}
				localPosition.y = wheelComponent.startPos.y - bikeWheels.setting.Distance;
				myRigidbody.angularDrag = 0f;
				myRigidbody.AddForce(0f, -1000f, 0f);
			}
			num3++;
			wheelComponent.axle.localPosition = localPosition;
		}
		if (num2 > 1)
		{
			num /= (float)num2;
		}
		motorRPM = 0.95f * motorRPM + 0.05f * Mathf.Abs(num * bikeSetting.gears[currentGear]);
		if (motorRPM > 5500f)
		{
			motorRPM = 5200f;
		}
		int num7 = (int)(motorRPM / efficiencyTableStep);
		if (num7 >= efficiencyTable.Length)
		{
			num7 = efficiencyTable.Length - 1;
		}
		if (num7 < 0)
		{
			num7 = 0;
		}
		float num8 = curTorque * bikeSetting.gears[currentGear] * efficiencyTable[num7];
		WheelComponent[] array2 = wheels;
		foreach (WheelComponent wheelComponent2 in array2)
		{
			WheelCollider collider2 = wheelComponent2.collider;
			if (wheelComponent2.drive)
			{
				if (Mathf.Abs(collider2.rpm) > Mathf.Abs(wantedRPM) || (currentGear == 0 && speed > 10f))
				{
					collider2.motorTorque = 0f;
				}
				else
				{
					float motorTorque = collider2.motorTorque;
					collider2.motorTorque = motorTorque * 0.9f + num8 * 1f;
				}
			}
			float num9 = Mathf.Clamp(speed / bikeSetting.maxSteerAngle, 1f, bikeSetting.maxSteerAngle);
			collider2.steerAngle = steer * (wheelComponent2.maxSteer / num9);
		}
		if (audioSource != null)
		{
			float pitch = Mathf.Clamp(1f + (motorRPM - bikeSetting.idleRPM) / (bikeSetting.shiftUpRPM - bikeSetting.idleRPM), 1f, 10f);
			audioSource.pitch = pitch;
			audioSource.volume = Mathf.MoveTowards(audioSource.volume, 0.5f + Mathf.Abs(accel), 0.01f);
		}
	}

	private void OnDrawGizmos()
	{
		if (bikeSetting.showNormalGizmos && !Application.isPlaying)
		{
			Matrix4x4 matrix4x2 = Gizmos.matrix = Matrix4x4.TRS(base.transform.position, base.transform.rotation, Vector3.one);
			Gizmos.color = new Color(1f, 0f, 0f, 0.5f);
			Gizmos.DrawCube(Vector3.zero, new Vector3(0.5f, 1f, 2.5f));
			Gizmos.DrawSphere(bikeSetting.shiftCentre, 0.2f);
		}
	}
}
