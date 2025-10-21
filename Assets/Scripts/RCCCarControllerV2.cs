using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Rigidbody))]
public class RCCCarControllerV2 : MonoBehaviour
{
	public enum MobileGUIType
	{
		NGUIController,
		UIController
	}

	public enum DashboardType
	{
		UnityDashboard,
		NGUIDashboard
	}

	public enum WheelType
	{
		FWD,
		RWD
	}

	private Rigidbody rigid;

	public bool mobileController;

	public MobileGUIType _mobileControllerType;

	[HideInInspector]
	public bool NGUIDashboard;

	[HideInInspector]
	public bool UnityDashboard = true;

	public DashboardType _dashboardType;

	public bool useAccelerometerForSteer;

	public bool steeringWheelControl;

	public float gyroTiltMultiplier = 2f;

	public bool demoGUI;

	public bool dashBoard;

	private Vector3 defbrakePedalPosition;

	private bool mobileHandbrake;

	public RCCNGUIController gasPedal;

	public RCCNGUIController brakePedal;

	public RCCNGUIController leftArrow;

	public RCCNGUIController rightArrow;

	public RCCNGUIController handbrakeGui;

	public RCCNGUIController boostGui;

	public RCCUIController gasPedalUI;

	public RCCUIController brakePedalUI;

	public RCCUIController leftArrowUI;

	public RCCUIController rightArrowUI;

	public RCCUIController handbrakeUI;

	public RCCUIController boostUI;

	public RCCUIController leftInd;

	public RCCUIController rightInd;

	public Transform FrontLeftWheelTransform;

	public Transform FrontRightWheelTransform;

	public Transform RearLeftWheelTransform;

	public Transform RearRightWheelTransform;

	public WheelCollider FrontLeftWheelCollider;

	public WheelCollider FrontRightWheelCollider;

	public WheelCollider RearLeftWheelCollider;

	public WheelCollider RearRightWheelCollider;

	public Transform[] ExtraRearWheelsTransform;

	public WheelCollider[] ExtraRearWheelsCollider;

	public Transform SteeringWheel;

	[HideInInspector]
	public bool rwd;

	[HideInInspector]
	public bool fwd = true;

	public WheelType _wheelTypeChoise;

	public Transform COM;

	private int steeringAssistanceDivider = 5;

	private float driftAngle;

	public bool canControl = true;

	public bool driftMode;

	public bool autoReverse;

	public bool automaticGear = true;

	private bool canGoReverseNow;

	public AnimationCurve[] engineTorqueCurve;

	[HideInInspector]
	public float[] gearSpeed;

	public float engineTorque = 2500f;

	public float maxEngineRPM = 6000f;

	public float minEngineRPM = 1000f;

	public float steerAngle = 40f;

	public float highspeedsteerAngle = 10f;

	public float highspeedsteerAngleAtspeed = 100f;

	public float antiRoll = 10000f;

	[HideInInspector]
	public float speed;

	public float brake = 4000f;

	public float maxspeed = 180f;

	public bool useDifferantial = true;

	private float differantialRatioRight;

	private float differantialRatioLeft;

	private float differantialDifference;

	private float resetTime;

	public int currentGear;

	public int totalGears = 6;

	public bool changingGear;

	public float gearShiftRate = 10f;

	private float _rotationValueFL;

	private float _rotationValueFR;

	private float _rotationValueRL;

	private float _rotationValueRR;

	private float[] RotationValueExtra;

	private float defsteerAngle;

	private float _forwardStiffnessFL;

	private float _forwardStiffnessFR;

	private float _forwardStiffnessRL;

	private float _forwardStiffnessRR;

	private float _stiffnessFL;

	private float _stiffnessFR;

	private float _stiffnessRL;

	private float _stiffnessRR;

	private bool reversing;

	private bool headLightsOn;

	private float acceleration;

	private float lastVelocity;

	private float gearTimeMultiplier;

	private AudioSource skidSound;

	public AudioClip skidClip;

	private AudioSource crashSound;

	public AudioClip[] crashClips;

	private AudioSource engineStartSound;

	public AudioClip engineStartClip;

	private AudioSource engineSound;

	public AudioClip engineClip;

	private AudioSource gearShiftingSound;

	public AudioClip[] gearShiftingClips;

	private int collisionForceLimit = 5;

	[HideInInspector]
	public float motorInput;

	[HideInInspector]
	public float steerInput;

	[HideInInspector]
	public float boostInput = 1f;

	[HideInInspector]
	public float EngineRPM;

	public RCCDashboardInputs UIInputs;

	public RectTransform RPMNeedle;

	public RectTransform KMHNeedle;

	private float RPMNeedleRotation;

	private float KMHNeedleRotation;

	private float smoothedNeedleRotation;

	public RCCDashboardInputs NGUIInputs;

	public GameObject NGUIRPMNeedle;

	public GameObject NGUIKMHNeedle;

	public float minimumRPMNeedleAngle = 20f;

	public float maximumRPMNeedleAngle = 160f;

	public float minimumKMHNeedleAngle = -25f;

	public float maximumKMHNeedleAngle = 155f;

	public GameObject wheelSlipPrefab;

	private string wheelSlipPrefabName;

	private List<ParticleSystem> _wheelParticles = new List<ParticleSystem>();

	// DEPRECATED: ParticleEmitter removed in Unity 2018.3+
	// Replaced with ParticleSystem for iOS/Xcode compatibility
	public ParticleSystem normalExhaustGas;

	public ParticleSystem heavyExhaustGas;

	public GameObject chassis;

	public float chassisVerticalLean = 4f;

	public float chassisHorizontalLean = 4f;

	private float horizontalLean;

	private float verticalLean;

	public Light[] headLights;

	public GameObject[] brakeLights;

	public GameObject[] reverseLights;

	public float steeringWheelMaximumsteerAngle = 180f;

	public float steeringWheelGuiScale = 256f;

	public float steeringWheelXOffset = 30f;

	public float steeringWheelYOffset = 30f;

	public Vector2 steeringWheelPivotPos = Vector2.zero;

	public float steeringWheelResetPosspeed = 200f;

	public Texture2D steeringWheelTexture;

	private float steeringWheelsteerAngle;

	private bool steeringWheelIsTouching;

	private Rect steeringWheelTextureRect;

	private Vector2 steeringWheelWheelCenter;

	private float steeringWheelOldAngle;

	private int touchId = -1;

	private Vector2 touchPos;

	private CameraShake cameraShakeScript;

	private RCCCamManager cameraScript;

	private int _totalGears => totalGears - 1;

	private void Start()
	{
		canControl = false;
		SoundsInitialize();
		TypeInit();
		MobileGUI();
		SteeringWheelInit();
		if ((bool)wheelSlipPrefab)
		{
			SmokeInit();
		}
		cameraShakeScript = GameObject.Find("RCCMainCamera").GetComponent<CameraShake>();
		cameraScript = GameObject.Find("RCCMainCamera").GetComponent<RCCCamManager>();
		rigid = GetComponent<Rigidbody>();
		Time.fixedDeltaTime = 0.02f;
		rigid.maxAngularVelocity = 5f;
		RotationValueExtra = new float[ExtraRearWheelsCollider.Length];
		defsteerAngle = steerAngle;
	}

	private void OnTriggerEnter(Collider other)
	{
		if (other.tag == "Building")
		{
			UnityEngine.Debug.Log("Entered");
			cameraScript.ChangeCamera();
			cameraScript.ChangeCamera();
			cameraScript.ChangeCamera();
		}
	}

	public AudioSource CreateAudioSource(string audioName, float minDistance, float volume, AudioClip audioClip, bool loop, bool playNow, bool destroyAfterFinished)
	{
		GameObject gameObject = new GameObject(audioName);
		gameObject.transform.position = base.transform.position;
		gameObject.transform.rotation = base.transform.rotation;
		gameObject.transform.parent = base.transform;
		gameObject.AddComponent<AudioSource>();
		gameObject.GetComponent<AudioSource>().minDistance = minDistance;
		gameObject.GetComponent<AudioSource>().volume = volume;
		gameObject.GetComponent<AudioSource>().clip = audioClip;
		gameObject.GetComponent<AudioSource>().loop = loop;
		gameObject.GetComponent<AudioSource>().spatialBlend = 1f;
		if (playNow)
		{
			gameObject.GetComponent<AudioSource>().Play();
		}
		if (destroyAfterFinished)
		{
			UnityEngine.Object.Destroy(gameObject, audioClip.length);
		}
		return gameObject.GetComponent<AudioSource>();
	}

	public void CreateWheelColliders()
	{
		List<Transform> list = new List<Transform>();
		list.Add(FrontLeftWheelTransform);
		list.Add(FrontRightWheelTransform);
		list.Add(RearLeftWheelTransform);
		list.Add(RearRightWheelTransform);
		if (list[0] == null)
		{
			UnityEngine.Debug.LogError("You haven't choose your Wheel Transforms. Please select all of your Wheel Transforms before creating Wheel Colliders. Script needs to know their positions, aye?");
			return;
		}
		base.transform.rotation = Quaternion.identity;
		GameObject gameObject = new GameObject("Wheel Colliders");
		gameObject.transform.parent = base.transform;
		gameObject.transform.rotation = base.transform.rotation;
		gameObject.transform.localPosition = Vector3.zero;
		gameObject.transform.localScale = Vector3.one;
		foreach (Transform item in list)
		{
			GameObject gameObject2 = new GameObject(item.transform.name);
			gameObject2.transform.position = item.transform.position;
			gameObject2.transform.rotation = base.transform.rotation;
			gameObject2.transform.name = item.transform.name;
			gameObject2.transform.parent = gameObject.transform;
			gameObject2.transform.localScale = Vector3.one;
			gameObject2.layer = LayerMask.NameToLayer("Wheel");
			gameObject2.AddComponent<WheelCollider>();
			WheelCollider component = gameObject2.GetComponent<WheelCollider>();
			Vector3 size = item.GetComponent<MeshRenderer>().bounds.size;
			float num = size.y / 2f;
			Vector3 localScale = base.transform.localScale;
			component.radius = num / localScale.y;
			gameObject2.AddComponent<RCCWheelSkidmarks>();
			gameObject2.GetComponent<RCCWheelSkidmarks>().vehicle = GetComponent<RCCCarControllerV2>();
			JointSpring suspensionSpring = gameObject2.GetComponent<WheelCollider>().suspensionSpring;
			suspensionSpring.spring = 35000f;
			suspensionSpring.damper = 2000f;
			gameObject2.GetComponent<WheelCollider>().suspensionSpring = suspensionSpring;
			gameObject2.GetComponent<WheelCollider>().suspensionDistance = 0.25f;
			gameObject2.GetComponent<WheelCollider>().forceAppPointDistance = 0.25f;
			gameObject2.GetComponent<WheelCollider>().mass = 100f;
			gameObject2.GetComponent<WheelCollider>().wheelDampingRate = 1f;
			WheelFrictionCurve sidewaysFriction = gameObject2.GetComponent<WheelCollider>().sidewaysFriction;
			WheelFrictionCurve forwardFriction = gameObject2.GetComponent<WheelCollider>().forwardFriction;
			forwardFriction.extremumSlip = 0.4f;
			forwardFriction.extremumValue = 1f;
			forwardFriction.asymptoteSlip = 0.8f;
			forwardFriction.asymptoteValue = 0.75f;
			forwardFriction.stiffness = 1.75f;
			sidewaysFriction.extremumSlip = 0.25f;
			sidewaysFriction.extremumValue = 1f;
			sidewaysFriction.asymptoteSlip = 0.5f;
			sidewaysFriction.asymptoteValue = 0.75f;
			sidewaysFriction.stiffness = 2f;
			gameObject2.GetComponent<WheelCollider>().sidewaysFriction = sidewaysFriction;
			gameObject2.GetComponent<WheelCollider>().forwardFriction = forwardFriction;
		}
		gameObject.layer = LayerMask.NameToLayer("Wheel");
		WheelCollider[] array = new WheelCollider[list.Count];
		array = GetComponentsInChildren<WheelCollider>();
		FrontLeftWheelCollider = array[0];
		FrontRightWheelCollider = array[1];
		RearLeftWheelCollider = array[2];
		RearRightWheelCollider = array[3];
	}

	public void SoundsInitialize()
	{
		engineSound = CreateAudioSource("engineSound", 5f, 0f, engineClip, loop: true, playNow: true, destroyAfterFinished: false);
		skidSound = CreateAudioSource("skidSound", 5f, 0f, skidClip, loop: true, playNow: true, destroyAfterFinished: false);
	}

	public void assignMobileControls(RCCUIController[] UIControls)
	{
		gasPedalUI = UIControls[0];
		brakePedalUI = UIControls[1];
		leftArrowUI = UIControls[2];
		rightArrowUI = UIControls[3];
		handbrakeUI = UIControls[4];
	}

	public void KillOrStartEngine(int i)
	{
		if (i == 0)
		{
			canControl = false;
			return;
		}
		canControl = true;
		StartEngineSound();
	}

	public void StartEngineSound()
	{
		engineStartSound = CreateAudioSource("engineStartAudio", 5f, 1f, engineStartClip, loop: false, playNow: true, destroyAfterFinished: true);
	}

	public void TypeInit()
	{
		switch (_wheelTypeChoise)
		{
		case WheelType.FWD:
			fwd = true;
			rwd = false;
			break;
		case WheelType.RWD:
			fwd = false;
			rwd = true;
			break;
		}
		switch (_dashboardType)
		{
		case DashboardType.NGUIDashboard:
			NGUIDashboard = true;
			UnityDashboard = false;
			break;
		case DashboardType.UnityDashboard:
			NGUIDashboard = false;
			UnityDashboard = true;
			break;
		}
	}

	public void SteeringWheelInit()
	{
		steeringWheelGuiScale = (float)Screen.width * 1f / 5f;
		steeringWheelIsTouching = false;
		float num = Screen.width / Screen.height;
		steeringWheelTextureRect = new Rect(steeringWheelGuiScale / (float)Screen.width + (float)Screen.width * 0.01f, (float)Screen.height - steeringWheelGuiScale * 1.05f, steeringWheelGuiScale, steeringWheelGuiScale);
		steeringWheelWheelCenter = new Vector2(steeringWheelTextureRect.x + steeringWheelTextureRect.width * 0.5f, (float)Screen.height - steeringWheelTextureRect.y - steeringWheelTextureRect.height * 0.5f);
		steeringWheelsteerAngle = 0f;
	}

	public void SmokeInit()
	{
		if ((bool)wheelSlipPrefab)
		{
			for (int i = 0; i < 4; i++)
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(wheelSlipPrefab, base.transform.position, base.transform.rotation);
				_wheelParticles.Add(gameObject.GetComponent<ParticleSystem>());
				gameObject.GetComponent<ParticleSystem>().enableEmission = false;
				gameObject.transform.localPosition = Vector3.zero;
			}
			_wheelParticles[0].transform.parent = FrontRightWheelCollider.transform;
			_wheelParticles[1].transform.parent = FrontLeftWheelCollider.transform;
			_wheelParticles[2].transform.parent = RearRightWheelCollider.transform;
			_wheelParticles[3].transform.parent = RearLeftWheelCollider.transform;
			_wheelParticles[0].transform.localPosition = Vector3.zero;
			_wheelParticles[1].transform.localPosition = Vector3.zero;
			_wheelParticles[2].transform.localPosition = Vector3.zero;
			_wheelParticles[3].transform.localPosition = Vector3.zero;
		}
	}

	public void MobileGUI()
	{
		if (canControl && mobileController)
		{
			if (_mobileControllerType == MobileGUIType.NGUIController)
			{
				defbrakePedalPosition = brakePedal.transform.position;
			}
			else
			{
				defbrakePedalPosition = brakePedalUI.transform.position;
			}
		}
	}

	private void Update()
	{
		if (canControl)
		{
			if (mobileController)
			{
				if (_mobileControllerType == MobileGUIType.NGUIController)
				{
					NGUIControlling();
				}
				if (_mobileControllerType == MobileGUIType.UIController)
				{
					UIControlling();
				}
				MobileSteeringInputs();
				if (steeringWheelControl)
				{
					SteeringWheelControlling();
				}
			}
			else
			{
				KeyboardControlling();
			}
			Lights();
			ResetCar();
			ShiftGears();
		}
		WheelAlign();
		SkidAudio();
		WheelCamber();
		if ((bool)chassis)
		{
			Chassis();
		}
		if (dashBoard && canControl)
		{
			DashboardGUI();
		}
	}

	private void FixedUpdate()
	{
		Braking();
		Differantial();
		AntiRollBars();
		if ((bool)wheelSlipPrefab)
		{
			SmokeInstantiateRate();
		}
		if (canControl)
		{
			Engine();
			return;
		}
		RearLeftWheelCollider.motorTorque = 0f;
		RearRightWheelCollider.motorTorque = 0f;
		FrontLeftWheelCollider.motorTorque = 0f;
		FrontRightWheelCollider.motorTorque = 0f;
		RearLeftWheelCollider.brakeTorque = brake / 12f;
		RearRightWheelCollider.brakeTorque = brake / 12f;
		FrontLeftWheelCollider.brakeTorque = brake / 12f;
		FrontRightWheelCollider.brakeTorque = brake / 12f;
		engineSound.GetComponent<AudioSource>().volume = Mathf.Lerp(engineSound.GetComponent<AudioSource>().volume, 0f, Time.deltaTime);
		engineSound.GetComponent<AudioSource>().pitch = Mathf.Lerp(engineSound.GetComponent<AudioSource>().pitch, 0f, Time.deltaTime);
	}

	public void Engine()
	{
		speed = rigid.velocity.magnitude * 3f;
		acceleration = 0f;
		Vector3 vector = base.transform.InverseTransformDirection(rigid.velocity);
		acceleration = (vector.z - lastVelocity) / Time.fixedDeltaTime;
		Vector3 vector2 = base.transform.InverseTransformDirection(rigid.velocity);
		lastVelocity = vector2.z;
		rigid.drag = Mathf.Clamp(acceleration / 50f, 0f, 1f);
		steerAngle = Mathf.Lerp(defsteerAngle, highspeedsteerAngle, speed / highspeedsteerAngleAtspeed);
		EngineRPM = Mathf.Clamp((Mathf.Abs(RearLeftWheelCollider.rpm + RearRightWheelCollider.rpm) * gearShiftRate + minEngineRPM) / (float)(currentGear + 1), minEngineRPM, maxEngineRPM);
		if (motorInput <= 0f && RearLeftWheelCollider.rpm < 20f && canGoReverseNow)
		{
			reversing = true;
		}
		else
		{
			reversing = false;
		}
		if (autoReverse)
		{
			canGoReverseNow = true;
		}
		else if (motorInput >= -0.1f && speed < 5f)
		{
			canGoReverseNow = true;
		}
		else if (motorInput < 0f)
		{
			Vector3 vector3 = base.transform.InverseTransformDirection(rigid.velocity);
			if (vector3.z > 1f)
			{
				canGoReverseNow = false;
			}
		}
		if ((bool)engineSound)
		{
			if (!reversing)
			{
				engineSound.GetComponent<AudioSource>().volume = Mathf.Lerp(engineSound.GetComponent<AudioSource>().volume, Mathf.Clamp(motorInput, 0.15f, 0.65f), Time.deltaTime * 5f);
			}
			else
			{
				engineSound.GetComponent<AudioSource>().volume = Mathf.Lerp(engineSound.GetComponent<AudioSource>().volume, Mathf.Clamp(Mathf.Abs(motorInput), 0.15f, 0.65f), Time.deltaTime * 5f);
			}
			engineSound.GetComponent<AudioSource>().pitch = Mathf.Lerp(engineSound.GetComponent<AudioSource>().pitch, Mathf.Lerp(1f, 2f, (EngineRPM - minEngineRPM / 1.5f) / (maxEngineRPM + minEngineRPM)), Time.deltaTime * 5f);
		}
		if (rwd)
		{
			if (speed > maxspeed || Mathf.Abs(RearLeftWheelCollider.rpm) > 3000f || Mathf.Abs(RearRightWheelCollider.rpm) > 3000f)
			{
				RearLeftWheelCollider.motorTorque = 0f;
				RearRightWheelCollider.motorTorque = 0f;
			}
			else if (!reversing)
			{
				RearLeftWheelCollider.motorTorque = engineTorque * (Mathf.Clamp(motorInput * differantialRatioLeft, 0f, 1f) * boostInput) * engineTorqueCurve[currentGear].Evaluate(speed);
				RearRightWheelCollider.motorTorque = engineTorque * (Mathf.Clamp(motorInput * differantialRatioRight, 0f, 1f) * boostInput) * engineTorqueCurve[currentGear].Evaluate(speed);
			}
			if (reversing)
			{
				if (speed < 30f && Mathf.Abs(RearLeftWheelCollider.rpm) < 3000f && Mathf.Abs(RearRightWheelCollider.rpm) < 3000f)
				{
					RearLeftWheelCollider.motorTorque = engineTorque * motorInput;
					RearRightWheelCollider.motorTorque = engineTorque * motorInput;
				}
				else
				{
					RearLeftWheelCollider.motorTorque = 0f;
					RearRightWheelCollider.motorTorque = 0f;
				}
			}
		}
		if (!fwd)
		{
			return;
		}
		if (speed > maxspeed || Mathf.Abs(FrontLeftWheelCollider.rpm) > 3000f || Mathf.Abs(FrontRightWheelCollider.rpm) > 3000f)
		{
			FrontLeftWheelCollider.motorTorque = 0f;
			FrontRightWheelCollider.motorTorque = 0f;
		}
		else if (!reversing)
		{
			FrontLeftWheelCollider.motorTorque = engineTorque * (Mathf.Clamp(motorInput * differantialRatioLeft, 0f, 1f) * boostInput) * engineTorqueCurve[currentGear].Evaluate(speed);
			FrontRightWheelCollider.motorTorque = engineTorque * (Mathf.Clamp(motorInput * differantialRatioRight, 0f, 1f) * boostInput) * engineTorqueCurve[currentGear].Evaluate(speed);
		}
		if (reversing)
		{
			if (speed < 30f && Mathf.Abs(FrontLeftWheelCollider.rpm) < 3000f && Mathf.Abs(FrontRightWheelCollider.rpm) < 3000f)
			{
				FrontLeftWheelCollider.motorTorque = engineTorque * motorInput;
				FrontRightWheelCollider.motorTorque = engineTorque * motorInput;
			}
			else
			{
				FrontLeftWheelCollider.motorTorque = 0f;
				FrontRightWheelCollider.motorTorque = 0f;
			}
		}
	}

	public void Braking()
	{
		if (Input.GetButton("Jump") || mobileHandbrake)
		{
			FrontLeftWheelCollider.brakeTorque = brake;
			FrontRightWheelCollider.brakeTorque = brake;
			RearLeftWheelCollider.brakeTorque = brake;
			RearRightWheelCollider.brakeTorque = brake;
		}
		else if (Mathf.Abs(motorInput) <= 0.05f && !changingGear)
		{
			RearLeftWheelCollider.brakeTorque = brake / 25f;
			RearRightWheelCollider.brakeTorque = brake / 25f;
			FrontLeftWheelCollider.brakeTorque = brake / 25f;
			FrontRightWheelCollider.brakeTorque = brake / 25f;
		}
		else if (motorInput < 0f && !reversing)
		{
			FrontLeftWheelCollider.brakeTorque = brake * Mathf.Abs(motorInput);
			FrontRightWheelCollider.brakeTorque = brake * Mathf.Abs(motorInput);
			RearLeftWheelCollider.brakeTorque = brake * Mathf.Abs(motorInput / 2f);
			RearRightWheelCollider.brakeTorque = brake * Mathf.Abs(motorInput / 2f);
		}
		else
		{
			RearLeftWheelCollider.brakeTorque = 0f;
			RearRightWheelCollider.brakeTorque = 0f;
			FrontLeftWheelCollider.brakeTorque = 0f;
			FrontRightWheelCollider.brakeTorque = 0f;
		}
	}

	public void Differantial()
	{
		if (useDifferantial)
		{
			if (fwd)
			{
				differantialDifference = Mathf.Clamp(Mathf.Abs(FrontRightWheelCollider.rpm) - Mathf.Abs(FrontLeftWheelCollider.rpm), -50f, 50f);
				differantialRatioRight = Mathf.Lerp(0f, 1f, (Mathf.Abs(FrontRightWheelCollider.rpm) + Mathf.Abs(FrontLeftWheelCollider.rpm) + 5f + differantialDifference) / (Mathf.Abs(FrontRightWheelCollider.rpm) + Mathf.Abs(FrontLeftWheelCollider.rpm)));
				differantialRatioLeft = Mathf.Lerp(0f, 1f, (Mathf.Abs(FrontRightWheelCollider.rpm) + Mathf.Abs(FrontLeftWheelCollider.rpm) + 5f - differantialDifference) / (Mathf.Abs(FrontRightWheelCollider.rpm) + Mathf.Abs(FrontLeftWheelCollider.rpm)));
			}
			if (rwd)
			{
				differantialDifference = Mathf.Clamp(Mathf.Abs(RearRightWheelCollider.rpm) - Mathf.Abs(RearLeftWheelCollider.rpm), -50f, 50f);
				differantialRatioRight = Mathf.Lerp(0f, 1f, (Mathf.Abs(RearRightWheelCollider.rpm) + Mathf.Abs(RearLeftWheelCollider.rpm) + 5f + differantialDifference) / (Mathf.Abs(RearRightWheelCollider.rpm) + Mathf.Abs(RearLeftWheelCollider.rpm)));
				differantialRatioLeft = Mathf.Lerp(0f, 1f, (Mathf.Abs(RearRightWheelCollider.rpm) + Mathf.Abs(RearLeftWheelCollider.rpm) + 5f - differantialDifference) / (Mathf.Abs(RearRightWheelCollider.rpm) + Mathf.Abs(RearLeftWheelCollider.rpm)));
			}
		}
		else
		{
			differantialRatioRight = 1f;
			differantialRatioLeft = 1f;
		}
	}

	public void AntiRollBars()
	{
		float num = 1f;
		float num2 = 1f;
		WheelHit hit;
		bool groundHit = FrontLeftWheelCollider.GetGroundHit(out hit);
		if (groundHit)
		{
			Vector3 vector = FrontLeftWheelCollider.transform.InverseTransformPoint(hit.point);
			num = (0f - vector.y - FrontLeftWheelCollider.radius) / FrontLeftWheelCollider.suspensionDistance;
		}
		bool groundHit2 = FrontRightWheelCollider.GetGroundHit(out hit);
		if (groundHit2)
		{
			Vector3 vector2 = FrontRightWheelCollider.transform.InverseTransformPoint(hit.point);
			num2 = (0f - vector2.y - FrontRightWheelCollider.radius) / FrontRightWheelCollider.suspensionDistance;
		}
		float num3 = (num - num2) * antiRoll;
		if (groundHit)
		{
			rigid.AddForceAtPosition(FrontLeftWheelCollider.transform.up * (0f - num3), FrontLeftWheelCollider.transform.position);
		}
		if (groundHit2)
		{
			rigid.AddForceAtPosition(FrontRightWheelCollider.transform.up * num3, FrontRightWheelCollider.transform.position);
		}
		float num4 = 1f;
		float num5 = 1f;
		WheelHit hit2;
		bool groundHit3 = RearLeftWheelCollider.GetGroundHit(out hit2);
		if (groundHit3)
		{
			Vector3 vector3 = RearLeftWheelCollider.transform.InverseTransformPoint(hit2.point);
			num4 = (0f - vector3.y - RearLeftWheelCollider.radius) / RearLeftWheelCollider.suspensionDistance;
		}
		bool groundHit4 = RearRightWheelCollider.GetGroundHit(out hit2);
		if (groundHit4)
		{
			Vector3 vector4 = RearRightWheelCollider.transform.InverseTransformPoint(hit2.point);
			num5 = (0f - vector4.y - RearRightWheelCollider.radius) / RearRightWheelCollider.suspensionDistance;
		}
		float num6 = (num4 - num5) * antiRoll;
		if (groundHit3)
		{
			rigid.AddForceAtPosition(RearLeftWheelCollider.transform.up * (0f - num6), RearLeftWheelCollider.transform.position);
		}
		if (groundHit4)
		{
			rigid.AddForceAtPosition(RearRightWheelCollider.transform.up * num6, RearRightWheelCollider.transform.position);
		}
		if (groundHit4 && groundHit3)
		{
			rigid.AddRelativeTorque(Vector3.up * steerInput * 5000f);
		}
	}

	public void MobileSteeringInputs()
	{
		if (useAccelerometerForSteer)
		{
			Vector3 vector = Input.acceleration;
			steerInput = vector.x * gyroTiltMultiplier;
			if (!driftMode)
			{
				FrontLeftWheelCollider.steerAngle = Mathf.Clamp(steerAngle * steerInput, 0f - steerAngle, steerAngle);
				FrontRightWheelCollider.steerAngle = Mathf.Clamp(steerAngle * steerInput, 0f - steerAngle, steerAngle);
			}
			else
			{
				FrontLeftWheelCollider.steerAngle = Mathf.Clamp(steerAngle * steerInput, 0f - steerAngle, steerAngle);
				FrontRightWheelCollider.steerAngle = Mathf.Clamp(steerAngle * steerInput, 0f - steerAngle, steerAngle);
			}
		}
		else if (!steeringWheelControl)
		{
			if (!driftMode)
			{
				FrontLeftWheelCollider.steerAngle = Mathf.Clamp(steerAngle * steerInput, 0f - steerAngle, steerAngle);
				FrontRightWheelCollider.steerAngle = Mathf.Clamp(steerAngle * steerInput, 0f - steerAngle, steerAngle);
			}
			else
			{
				FrontLeftWheelCollider.steerAngle = Mathf.Clamp(steerAngle * steerInput, 0f - steerAngle, steerAngle);
				FrontRightWheelCollider.steerAngle = Mathf.Clamp(steerAngle * steerInput, 0f - steerAngle, steerAngle);
			}
		}
		else if (!driftMode)
		{
			FrontLeftWheelCollider.steerAngle = steerAngle * ((0f - steeringWheelsteerAngle) / steeringWheelMaximumsteerAngle);
			FrontRightWheelCollider.steerAngle = steerAngle * ((0f - steeringWheelsteerAngle) / steeringWheelMaximumsteerAngle);
		}
		else
		{
			FrontLeftWheelCollider.steerAngle = steerAngle * ((0f - steeringWheelsteerAngle) / steeringWheelMaximumsteerAngle);
			FrontRightWheelCollider.steerAngle = steerAngle * ((0f - steeringWheelsteerAngle) / steeringWheelMaximumsteerAngle);
		}
	}

	public void SteeringWheelControlling()
	{
		if (steeringWheelIsTouching)
		{
			Touch[] touches = Input.touches;
			for (int i = 0; i < touches.Length; i++)
			{
				Touch touch = touches[i];
				if (touch.fingerId == touchId)
				{
					touchPos = touch.position;
					if (touch.phase == TouchPhase.Ended || touch.phase == TouchPhase.Canceled)
					{
						steeringWheelIsTouching = false;
					}
				}
			}
			float num = Vector2.Angle(Vector2.up, touchPos - steeringWheelWheelCenter);
			if (Vector2.Distance(touchPos, steeringWheelWheelCenter) > 20f)
			{
				if (touchPos.x > steeringWheelWheelCenter.x)
				{
					steeringWheelsteerAngle -= num - steeringWheelOldAngle;
				}
				else
				{
					steeringWheelsteerAngle += num - steeringWheelOldAngle;
				}
			}
			if (steeringWheelsteerAngle > steeringWheelMaximumsteerAngle)
			{
				steeringWheelsteerAngle = steeringWheelMaximumsteerAngle;
			}
			else if (steeringWheelsteerAngle < 0f - steeringWheelMaximumsteerAngle)
			{
				steeringWheelsteerAngle = 0f - steeringWheelMaximumsteerAngle;
			}
			steeringWheelOldAngle = num;
			return;
		}
		Touch[] touches2 = Input.touches;
		for (int j = 0; j < touches2.Length; j++)
		{
			Touch touch2 = touches2[j];
			if (touch2.phase == TouchPhase.Began)
			{
				ref Rect reference = ref steeringWheelTextureRect;
				Vector2 position = touch2.position;
				float x = position.x;
				float num2 = Screen.height;
				Vector2 position2 = touch2.position;
				if (reference.Contains(new Vector2(x, num2 - position2.y)))
				{
					steeringWheelIsTouching = true;
					steeringWheelOldAngle = Vector2.Angle(Vector2.up, touch2.position - steeringWheelWheelCenter);
					touchId = touch2.fingerId;
				}
			}
		}
		if (!Mathf.Approximately(0f, steeringWheelsteerAngle))
		{
			float num3 = steeringWheelResetPosspeed * Time.deltaTime;
			if (Mathf.Abs(num3) > Mathf.Abs(steeringWheelsteerAngle))
			{
				steeringWheelsteerAngle = 0f;
			}
			else if (steeringWheelsteerAngle > 0f)
			{
				steeringWheelsteerAngle -= num3;
			}
			else
			{
				steeringWheelsteerAngle += num3;
			}
		}
	}

	public void KeyboardControlling()
	{
		if (!changingGear)
		{
			motorInput = UnityEngine.Input.GetAxis("Vertical");
		}
		else
		{
			motorInput = Mathf.Clamp(UnityEngine.Input.GetAxis("Vertical"), -1f, 0f);
		}
		if (Mathf.Abs(UnityEngine.Input.GetAxis("Horizontal")) > 0.05f)
		{
			steerInput = Mathf.Lerp(steerInput, UnityEngine.Input.GetAxis("Horizontal"), Time.deltaTime * 10f);
		}
		else
		{
			steerInput = Mathf.Lerp(steerInput, UnityEngine.Input.GetAxis("Horizontal"), Time.deltaTime * 10f);
		}
		if (Input.GetButton("Fire2"))
		{
			boostInput = 1.25f;
		}
		else
		{
			boostInput = 1f;
		}
		FrontLeftWheelCollider.steerAngle = steerAngle * steerInput;
		FrontRightWheelCollider.steerAngle = steerAngle * steerInput;
	}

	public void NGUIControlling()
	{
		if (!changingGear)
		{
			motorInput = gasPedal.input + (0f - brakePedal.input);
		}
		else
		{
			motorInput = 0f - brakePedal.input;
		}
		if (!useAccelerometerForSteer && !steeringWheelControl)
		{
			steerInput = rightArrow.input + (0f - leftArrow.input);
		}
		if (handbrakeGui.input > 0.1f)
		{
			mobileHandbrake = true;
		}
		else
		{
			mobileHandbrake = false;
		}
		if ((bool)boostGui)
		{
			boostInput = Mathf.Clamp(boostGui.input * 2f, 1f, 1.25f);
		}
	}

	public void UIControlling()
	{
		if (!changingGear)
		{
			motorInput = gasPedalUI.input + (0f - brakePedalUI.input);
		}
		else
		{
			motorInput = 0f - brakePedalUI.input;
		}
		if (!useAccelerometerForSteer && !steeringWheelControl)
		{
			steerInput = rightArrowUI.input + (0f - leftArrowUI.input);
		}
		if (handbrakeUI.input > 0.1f)
		{
			mobileHandbrake = true;
		}
		else
		{
			mobileHandbrake = false;
		}
		if ((bool)boostUI)
		{
			boostInput = Mathf.Clamp(boostUI.input * 2f, 1f, 1.25f);
		}
	}

	public void ShiftGears()
	{
		if (automaticGear)
		{
			if (currentGear < _totalGears && !changingGear && speed > gearSpeed[currentGear + 1] && RearLeftWheelCollider.rpm >= 0f)
			{
				StartCoroutine("ChangingGear", currentGear + 1);
			}
			if (currentGear <= 0 || !(EngineRPM < minEngineRPM + 500f) || changingGear)
			{
				return;
			}
			for (int i = 0; i < gearSpeed.Length; i++)
			{
				if (speed > gearSpeed[i])
				{
					StartCoroutine("ChangingGear", i);
				}
			}
		}
		else
		{
			if (currentGear < _totalGears && !changingGear && Input.GetButtonDown("RCCShiftUp"))
			{
				StartCoroutine("ChangingGear", currentGear + 1);
			}
			if (currentGear > 0 && Input.GetButtonDown("RCCShiftDown"))
			{
				StartCoroutine("ChangingGear", currentGear - 1);
			}
		}
	}

	private IEnumerator ChangingGear(int gear)
	{
		changingGear = true;
		if (gearShiftingClips.Length >= 1)
		{
			gearShiftingSound = CreateAudioSource("gearShiftingAudio", 5f, 0.3f, gearShiftingClips[Random.Range(0, gearShiftingClips.Length)], loop: false, playNow: true, destroyAfterFinished: true);
		}
		yield return new WaitForSeconds(0.5f);
		changingGear = false;
		currentGear = gear;
	}

	public void WheelAlign()
	{
		Vector3 vector = FrontLeftWheelCollider.transform.TransformPoint(FrontLeftWheelCollider.center);
		FrontLeftWheelCollider.GetGroundHit(out WheelHit hit);
		Vector3 origin = vector;
		Vector3 direction = -FrontLeftWheelCollider.transform.up;
		float num = FrontLeftWheelCollider.suspensionDistance + FrontLeftWheelCollider.radius;
		Vector3 localScale = base.transform.localScale;
		RaycastHit hitInfo = default(RaycastHit);
		if (Physics.Raycast(origin, direction, out hitInfo, num * localScale.y))
		{
			if (hitInfo.transform.gameObject.layer != LayerMask.NameToLayer("Vehicle"))
			{
				Transform transform = FrontLeftWheelTransform.transform;
				Vector3 point = hitInfo.point;
				Vector3 a = FrontLeftWheelCollider.transform.up * FrontLeftWheelCollider.radius;
				Vector3 localScale2 = base.transform.localScale;
				transform.position = point + a * localScale2.y;
				Vector3 vector2 = FrontLeftWheelCollider.transform.InverseTransformPoint(hit.point);
				float num2 = (0f - vector2.y - FrontLeftWheelCollider.radius) / FrontLeftWheelCollider.suspensionDistance;
				UnityEngine.Debug.DrawLine(hit.point, hit.point + FrontLeftWheelCollider.transform.up * (hit.force / rigid.mass), (!((double)num2 <= 0.0)) ? Color.white : Color.magenta);
				UnityEngine.Debug.DrawLine(hit.point, hit.point - FrontLeftWheelCollider.transform.forward * hit.forwardSlip, Color.green);
				UnityEngine.Debug.DrawLine(hit.point, hit.point - FrontLeftWheelCollider.transform.right * hit.sidewaysSlip, Color.red);
			}
		}
		else
		{
			Transform transform2 = FrontLeftWheelTransform.transform;
			Vector3 a2 = vector;
			Vector3 a3 = FrontLeftWheelCollider.transform.up * FrontLeftWheelCollider.suspensionDistance;
			Vector3 localScale3 = base.transform.localScale;
			transform2.position = a2 - a3 * localScale3.y;
		}
		_rotationValueFL += FrontLeftWheelCollider.rpm * 6f * Time.deltaTime;
		Transform transform3 = FrontLeftWheelTransform.transform;
		Quaternion rotation = FrontLeftWheelCollider.transform.rotation;
		float rotationValueFL = _rotationValueFL;
		float y = FrontLeftWheelCollider.steerAngle + driftAngle / (float)steeringAssistanceDivider;
		Quaternion rotation2 = FrontLeftWheelCollider.transform.rotation;
		transform3.rotation = rotation * Quaternion.Euler(rotationValueFL, y, rotation2.z);
		Vector3 vector3 = FrontRightWheelCollider.transform.TransformPoint(FrontRightWheelCollider.center);
		FrontRightWheelCollider.GetGroundHit(out hit);
		Vector3 origin2 = vector3;
		Vector3 direction2 = -FrontRightWheelCollider.transform.up;
		float num3 = FrontRightWheelCollider.suspensionDistance + FrontRightWheelCollider.radius;
		Vector3 localScale4 = base.transform.localScale;
		if (Physics.Raycast(origin2, direction2, out hitInfo, num3 * localScale4.y))
		{
			if (hitInfo.transform.gameObject.layer != LayerMask.NameToLayer("Vehicle"))
			{
				Transform transform4 = FrontRightWheelTransform.transform;
				Vector3 point2 = hitInfo.point;
				Vector3 a4 = FrontRightWheelCollider.transform.up * FrontRightWheelCollider.radius;
				Vector3 localScale5 = base.transform.localScale;
				transform4.position = point2 + a4 * localScale5.y;
				Vector3 vector4 = FrontRightWheelCollider.transform.InverseTransformPoint(hit.point);
				float num4 = (0f - vector4.y - FrontRightWheelCollider.radius) / FrontRightWheelCollider.suspensionDistance;
				UnityEngine.Debug.DrawLine(hit.point, hit.point + FrontRightWheelCollider.transform.up * (hit.force / rigid.mass), (!((double)num4 <= 0.0)) ? Color.white : Color.magenta);
				UnityEngine.Debug.DrawLine(hit.point, hit.point - FrontRightWheelCollider.transform.forward * hit.forwardSlip, Color.green);
				UnityEngine.Debug.DrawLine(hit.point, hit.point - FrontRightWheelCollider.transform.right * hit.sidewaysSlip, Color.red);
			}
		}
		else
		{
			Transform transform5 = FrontRightWheelTransform.transform;
			Vector3 a5 = vector3;
			Vector3 a6 = FrontRightWheelCollider.transform.up * FrontRightWheelCollider.suspensionDistance;
			Vector3 localScale6 = base.transform.localScale;
			transform5.position = a5 - a6 * localScale6.y;
		}
		_rotationValueFR += FrontRightWheelCollider.rpm * 6f * Time.deltaTime;
		Transform transform6 = FrontRightWheelTransform.transform;
		Quaternion rotation3 = FrontRightWheelCollider.transform.rotation;
		float rotationValueFR = _rotationValueFR;
		float y2 = FrontRightWheelCollider.steerAngle + driftAngle / (float)steeringAssistanceDivider;
		Quaternion rotation4 = FrontRightWheelCollider.transform.rotation;
		transform6.rotation = rotation3 * Quaternion.Euler(rotationValueFR, y2, rotation4.z);
		Vector3 vector5 = RearLeftWheelCollider.transform.TransformPoint(RearLeftWheelCollider.center);
		RearLeftWheelCollider.GetGroundHit(out hit);
		Vector3 origin3 = vector5;
		Vector3 direction3 = -RearLeftWheelCollider.transform.up;
		float num5 = RearLeftWheelCollider.suspensionDistance + RearLeftWheelCollider.radius;
		Vector3 localScale7 = base.transform.localScale;
		if (Physics.Raycast(origin3, direction3, out hitInfo, num5 * localScale7.y))
		{
			if (hitInfo.transform.gameObject.layer != LayerMask.NameToLayer("Vehicle"))
			{
				Transform transform7 = RearLeftWheelTransform.transform;
				Vector3 point3 = hitInfo.point;
				Vector3 a7 = RearLeftWheelCollider.transform.up * RearLeftWheelCollider.radius;
				Vector3 localScale8 = base.transform.localScale;
				transform7.position = point3 + a7 * localScale8.y;
				Vector3 vector6 = RearLeftWheelCollider.transform.InverseTransformPoint(hit.point);
				float num6 = (0f - vector6.y - RearLeftWheelCollider.radius) / RearLeftWheelCollider.suspensionDistance;
				UnityEngine.Debug.DrawLine(hit.point, hit.point + RearLeftWheelCollider.transform.up * (hit.force / rigid.mass), (!((double)num6 <= 0.0)) ? Color.white : Color.magenta);
				UnityEngine.Debug.DrawLine(hit.point, hit.point - RearLeftWheelCollider.transform.forward * hit.forwardSlip, Color.green);
				UnityEngine.Debug.DrawLine(hit.point, hit.point - RearLeftWheelCollider.transform.right * hit.sidewaysSlip, Color.red);
			}
		}
		else
		{
			Transform transform8 = RearLeftWheelTransform.transform;
			Vector3 a8 = vector5;
			Vector3 a9 = RearLeftWheelCollider.transform.up * RearLeftWheelCollider.suspensionDistance;
			Vector3 localScale9 = base.transform.localScale;
			transform8.position = a8 - a9 * localScale9.y;
		}
		Transform transform9 = RearLeftWheelTransform.transform;
		Quaternion rotation5 = RearLeftWheelCollider.transform.rotation;
		float rotationValueRL = _rotationValueRL;
		Quaternion rotation6 = RearLeftWheelCollider.transform.rotation;
		transform9.rotation = rotation5 * Quaternion.Euler(rotationValueRL, 0f, rotation6.z);
		_rotationValueRL += RearLeftWheelCollider.rpm * 6f * Time.deltaTime;
		Vector3 vector7 = RearRightWheelCollider.transform.TransformPoint(RearRightWheelCollider.center);
		RearRightWheelCollider.GetGroundHit(out hit);
		Vector3 origin4 = vector7;
		Vector3 direction4 = -RearRightWheelCollider.transform.up;
		float num7 = RearRightWheelCollider.suspensionDistance + RearRightWheelCollider.radius;
		Vector3 localScale10 = base.transform.localScale;
		if (Physics.Raycast(origin4, direction4, out hitInfo, num7 * localScale10.y))
		{
			if (hitInfo.transform.gameObject.layer != LayerMask.NameToLayer("Vehicle"))
			{
				Transform transform10 = RearRightWheelTransform.transform;
				Vector3 point4 = hitInfo.point;
				Vector3 a10 = RearRightWheelCollider.transform.up * RearRightWheelCollider.radius;
				Vector3 localScale11 = base.transform.localScale;
				transform10.position = point4 + a10 * localScale11.y;
				Vector3 vector8 = RearRightWheelCollider.transform.InverseTransformPoint(hit.point);
				float num8 = (0f - vector8.y - RearRightWheelCollider.radius) / RearRightWheelCollider.suspensionDistance;
				UnityEngine.Debug.DrawLine(hit.point, hit.point + RearRightWheelCollider.transform.up * (hit.force / rigid.mass), (!((double)num8 <= 0.0)) ? Color.white : Color.magenta);
				UnityEngine.Debug.DrawLine(hit.point, hit.point - RearRightWheelCollider.transform.forward * hit.forwardSlip, Color.green);
				UnityEngine.Debug.DrawLine(hit.point, hit.point - RearRightWheelCollider.transform.right * hit.sidewaysSlip, Color.red);
			}
		}
		else
		{
			Transform transform11 = RearRightWheelTransform.transform;
			Vector3 a11 = vector7;
			Vector3 a12 = RearRightWheelCollider.transform.up * RearRightWheelCollider.suspensionDistance;
			Vector3 localScale12 = base.transform.localScale;
			transform11.position = a11 - a12 * localScale12.y;
		}
		Transform transform12 = RearRightWheelTransform.transform;
		Quaternion rotation7 = RearRightWheelCollider.transform.rotation;
		float rotationValueRR = _rotationValueRR;
		Quaternion rotation8 = RearRightWheelCollider.transform.rotation;
		transform12.rotation = rotation7 * Quaternion.Euler(rotationValueRR, 0f, rotation8.z);
		_rotationValueRR += RearRightWheelCollider.rpm * 6f * Time.deltaTime;
		if (ExtraRearWheelsCollider.Length > 0)
		{
			for (int i = 0; i < ExtraRearWheelsCollider.Length; i++)
			{
				Vector3 vector9 = ExtraRearWheelsCollider[i].transform.TransformPoint(ExtraRearWheelsCollider[i].center);
				Vector3 origin5 = vector9;
				Vector3 direction5 = -ExtraRearWheelsCollider[i].transform.up;
				float num9 = ExtraRearWheelsCollider[i].suspensionDistance + ExtraRearWheelsCollider[i].radius;
				Vector3 localScale13 = base.transform.localScale;
				if (Physics.Raycast(origin5, direction5, out hitInfo, num9 * localScale13.y))
				{
					Transform transform13 = ExtraRearWheelsTransform[i].transform;
					Vector3 point5 = hitInfo.point;
					Vector3 a13 = ExtraRearWheelsCollider[i].transform.up * ExtraRearWheelsCollider[i].radius;
					Vector3 localScale14 = base.transform.localScale;
					transform13.position = point5 + a13 * localScale14.y;
				}
				else
				{
					Transform transform14 = ExtraRearWheelsTransform[i].transform;
					Vector3 a14 = vector9;
					Vector3 a15 = ExtraRearWheelsCollider[i].transform.up * ExtraRearWheelsCollider[i].suspensionDistance;
					Vector3 localScale15 = base.transform.localScale;
					transform14.position = a14 - a15 * localScale15.y;
				}
				Transform transform15 = ExtraRearWheelsTransform[i].transform;
				Quaternion rotation9 = ExtraRearWheelsCollider[i].transform.rotation;
				float x = RotationValueExtra[i];
				Quaternion rotation10 = ExtraRearWheelsCollider[i].transform.rotation;
				transform15.rotation = rotation9 * Quaternion.Euler(x, 0f, rotation10.z);
				RotationValueExtra[i] += ExtraRearWheelsCollider[i].rpm * 6f * Time.deltaTime;
			}
		}
		RearRightWheelCollider.GetGroundHit(out WheelHit hit2);
		driftAngle = Mathf.Lerp(driftAngle, Mathf.Clamp(hit2.sidewaysSlip, -35f, 35f), Time.deltaTime * 2f);
		if ((bool)SteeringWheel)
		{
			SteeringWheel.transform.rotation = base.transform.rotation * Quaternion.Euler(0f, 0f, (FrontLeftWheelCollider.steerAngle + driftAngle / (float)steeringAssistanceDivider) * -6f);
		}
	}

	public void WheelCamber()
	{
		FrontLeftWheelCollider.GetGroundHit(out WheelHit hit);
		float num = Mathf.Lerp(-1f, 1f, hit.force / 8000f);
		FrontRightWheelCollider.GetGroundHit(out hit);
		float z = Mathf.Lerp(-1f, 1f, hit.force / 8000f);
		RearLeftWheelCollider.GetGroundHit(out hit);
		float num2 = Mathf.Lerp(-1f, 1f, hit.force / 8000f);
		RearRightWheelCollider.GetGroundHit(out hit);
		float z2 = Mathf.Lerp(-1f, 1f, hit.force / 8000f);
		Transform transform = FrontLeftWheelCollider.transform;
		Vector3 localEulerAngles = FrontLeftWheelCollider.transform.localEulerAngles;
		float x = localEulerAngles.x;
		Vector3 localEulerAngles2 = FrontLeftWheelCollider.transform.localEulerAngles;
		transform.localEulerAngles = new Vector3(x, localEulerAngles2.y, 0f - num);
		Transform transform2 = FrontRightWheelCollider.transform;
		Vector3 localEulerAngles3 = FrontRightWheelCollider.transform.localEulerAngles;
		float x2 = localEulerAngles3.x;
		Vector3 localEulerAngles4 = FrontRightWheelCollider.transform.localEulerAngles;
		transform2.localEulerAngles = new Vector3(x2, localEulerAngles4.y, z);
		Transform transform3 = RearLeftWheelCollider.transform;
		Vector3 localEulerAngles5 = RearLeftWheelCollider.transform.localEulerAngles;
		float x3 = localEulerAngles5.x;
		Vector3 localEulerAngles6 = RearLeftWheelCollider.transform.localEulerAngles;
		transform3.localEulerAngles = new Vector3(x3, localEulerAngles6.y, 0f - num2);
		Transform transform4 = RearRightWheelCollider.transform;
		Vector3 localEulerAngles7 = RearRightWheelCollider.transform.localEulerAngles;
		float x4 = localEulerAngles7.x;
		Vector3 localEulerAngles8 = RearRightWheelCollider.transform.localEulerAngles;
		transform4.localEulerAngles = new Vector3(x4, localEulerAngles8.y, z2);
	}

	public void DashboardGUI()
	{
		if (_dashboardType == DashboardType.NGUIDashboard)
		{
			if (!NGUIInputs)
			{
				UnityEngine.Debug.LogError("If you gonna use NGUI Dashboard, your NGUI Root (Dashboard GameObject) must have ''RCCNGUIDashboardInputs.cs''. First be sure your Dashboard gameobject has ''RCCNGUIDashboardInputs.cs'', then select your ''NGUI Inputs'' in editor script.");
				return;
			}
			NGUIInputs.RPM = EngineRPM;
			NGUIInputs.KMH = speed;
			NGUIInputs.Gear = ((!(FrontLeftWheelCollider.rpm > -10f)) ? (-1f) : ((float)currentGear));
			RPMNeedleRotation = Mathf.Lerp(minimumRPMNeedleAngle, maximumRPMNeedleAngle, (EngineRPM - minEngineRPM / 1.5f) / (maxEngineRPM + minEngineRPM));
			KMHNeedleRotation = Mathf.Lerp(minimumKMHNeedleAngle, maximumKMHNeedleAngle, speed / maxspeed);
			smoothedNeedleRotation = Mathf.Lerp(smoothedNeedleRotation, RPMNeedleRotation, Time.deltaTime * 5f);
			Transform transform = NGUIRPMNeedle.transform;
			Vector3 eulerAngles = NGUIRPMNeedle.transform.eulerAngles;
			float x = eulerAngles.x;
			Vector3 eulerAngles2 = NGUIRPMNeedle.transform.eulerAngles;
			transform.eulerAngles = new Vector3(x, eulerAngles2.y, 0f - smoothedNeedleRotation);
			Transform transform2 = NGUIKMHNeedle.transform;
			Vector3 eulerAngles3 = NGUIKMHNeedle.transform.eulerAngles;
			float x2 = eulerAngles3.x;
			Vector3 eulerAngles4 = NGUIKMHNeedle.transform.eulerAngles;
			transform2.eulerAngles = new Vector3(x2, eulerAngles4.y, 0f - KMHNeedleRotation);
		}
		if (_dashboardType == DashboardType.UnityDashboard)
		{
			if (!UIInputs)
			{
				UnityEngine.Debug.LogError("If you gonna use UI Dashboard, your Canvas Root must have ''RCCUIDashboardInputs.cs''. First be sure your Canvas Root has ''RCCUIDashboardInputs.cs'', then select your ''UI Inputs'' in script.");
				return;
			}
			UIInputs.RPM = EngineRPM;
			UIInputs.KMH = speed;
			UIInputs.Gear = ((!(FrontLeftWheelCollider.rpm > -10f)) ? (-1f) : ((float)currentGear));
			RPMNeedleRotation = Mathf.Lerp(minimumRPMNeedleAngle, maximumRPMNeedleAngle, (EngineRPM - minEngineRPM / 1.5f) / (maxEngineRPM + minEngineRPM));
			KMHNeedleRotation = Mathf.Lerp(minimumKMHNeedleAngle, maximumKMHNeedleAngle, speed / maxspeed);
			smoothedNeedleRotation = Mathf.Lerp(smoothedNeedleRotation, RPMNeedleRotation, Time.deltaTime * 5f);
			Transform transform3 = RPMNeedle.transform;
			Vector3 eulerAngles5 = RPMNeedle.transform.eulerAngles;
			float x3 = eulerAngles5.x;
			Vector3 eulerAngles6 = RPMNeedle.transform.eulerAngles;
			transform3.eulerAngles = new Vector3(x3, eulerAngles6.y, 0f - smoothedNeedleRotation);
			Transform transform4 = KMHNeedle.transform;
			Vector3 eulerAngles7 = KMHNeedle.transform.eulerAngles;
			float x4 = eulerAngles7.x;
			Vector3 eulerAngles8 = KMHNeedle.transform.eulerAngles;
			transform4.eulerAngles = new Vector3(x4, eulerAngles8.y, 0f - KMHNeedleRotation);
		}
	}

	public void SmokeInstantiateRate()
	{
		if (_wheelParticles.Count > 0)
		{
			FrontRightWheelCollider.GetGroundHit(out WheelHit hit);
			if (Mathf.Abs(hit.sidewaysSlip) > 0.25f || Mathf.Abs(hit.forwardSlip) > 0.5f)
			{
				if (!_wheelParticles[0].enableEmission && speed > 1f)
				{
					_wheelParticles[0].enableEmission = true;
				}
			}
			else if (_wheelParticles[0].enableEmission)
			{
				_wheelParticles[0].enableEmission = false;
			}
			FrontLeftWheelCollider.GetGroundHit(out WheelHit hit2);
			if (Mathf.Abs(hit2.sidewaysSlip) > 0.25f || Mathf.Abs(hit2.forwardSlip) > 0.5f)
			{
				if (!_wheelParticles[1].enableEmission && speed > 1f)
				{
					_wheelParticles[1].enableEmission = true;
				}
			}
			else if (_wheelParticles[1].enableEmission)
			{
				_wheelParticles[1].enableEmission = false;
			}
			RearRightWheelCollider.GetGroundHit(out WheelHit hit3);
			if (Mathf.Abs(hit3.sidewaysSlip) > 0.25f || Mathf.Abs(hit3.forwardSlip) > 0.5f)
			{
				if (!_wheelParticles[2].enableEmission && speed > 1f)
				{
					_wheelParticles[2].enableEmission = true;
				}
			}
			else if (_wheelParticles[2].enableEmission)
			{
				_wheelParticles[2].enableEmission = false;
			}
			RearLeftWheelCollider.GetGroundHit(out WheelHit hit4);
			if (Mathf.Abs(hit4.sidewaysSlip) > 0.25f || Mathf.Abs(hit4.forwardSlip) > 0.5f)
			{
				if (!_wheelParticles[3].enableEmission && speed > 1f)
				{
					_wheelParticles[3].enableEmission = true;
				}
			}
			else if (_wheelParticles[3].enableEmission)
			{
				_wheelParticles[3].enableEmission = false;
			}
		}
		if ((bool)normalExhaustGas && canControl)
		{
			var emission = normalExhaustGas.emission;
			if (speed < 20f)
			{
				emission.enabled = true;
			}
			else
			{
				emission.enabled = false;
			}
		}
		if ((bool)heavyExhaustGas && canControl)
		{
			var emission = heavyExhaustGas.emission;
			if (speed < 10f && motorInput > 0.1f)
			{
				emission.enabled = true;
			}
			else
			{
				emission.enabled = false;
			}
		}
		if (!canControl)
		{
			if ((bool)heavyExhaustGas)
			{
				var emission = heavyExhaustGas.emission;
				emission.enabled = false;
			}
			if ((bool)normalExhaustGas)
			{
				var emission = normalExhaustGas.emission;
				emission.enabled = false;
			}
		}
	}

	public void SkidAudio()
	{
		if (!skidSound)
		{
			return;
		}
		FrontRightWheelCollider.GetGroundHit(out WheelHit hit);
		RearRightWheelCollider.GetGroundHit(out WheelHit hit2);
		if (Mathf.Abs(hit.sidewaysSlip) > 0.25f || Mathf.Abs(hit2.forwardSlip) > 0.5f || Mathf.Abs(hit.forwardSlip) > 0.5f)
		{
			if (rigid.velocity.magnitude > 1f)
			{
				skidSound.volume = Mathf.Abs(hit.sidewaysSlip) + (Mathf.Abs(hit.forwardSlip) + Mathf.Abs(hit2.forwardSlip)) / 4f;
			}
			else
			{
				skidSound.volume -= Time.deltaTime;
			}
		}
		else
		{
			skidSound.volume -= Time.deltaTime;
		}
	}

	public void ResetCar()
	{
		if (!(speed < 5f) || rigid.isKinematic)
		{
			return;
		}
		Vector3 eulerAngles = base.transform.eulerAngles;
		if (eulerAngles.z < 300f)
		{
			Vector3 eulerAngles2 = base.transform.eulerAngles;
			if (eulerAngles2.z > 60f)
			{
				resetTime += Time.deltaTime;
				if (resetTime > 4f)
				{
					base.transform.rotation = Quaternion.identity;
					Transform transform = base.transform;
					Vector3 position = base.transform.position;
					float x = position.x;
					Vector3 position2 = base.transform.position;
					float y = position2.y + 3f;
					Vector3 position3 = base.transform.position;
					transform.position = new Vector3(x, y, position3.z);
					resetTime = 0f;
				}
			}
		}
		Vector3 eulerAngles3 = base.transform.eulerAngles;
		if (!(eulerAngles3.x < 300f))
		{
			return;
		}
		Vector3 eulerAngles4 = base.transform.eulerAngles;
		if (eulerAngles4.x > 60f)
		{
			resetTime += Time.deltaTime;
			if (resetTime > 4f)
			{
				base.transform.rotation = Quaternion.identity;
				Transform transform2 = base.transform;
				Vector3 position4 = base.transform.position;
				float x2 = position4.x;
				Vector3 position5 = base.transform.position;
				float y2 = position5.y + 3f;
				Vector3 position6 = base.transform.position;
				transform2.position = new Vector3(x2, y2, position6.z);
				resetTime = 0f;
			}
		}
	}

	private void OnCollisionEnter(Collision collision)
	{
		if (collision.contacts.Length > 0)
		{
			if (cameraShakeScript != null)
			{
				cameraShakeScript.DoShake();
			}
			if (collision.relativeVelocity.magnitude > (float)collisionForceLimit && crashClips.Length > 0 && collision.contacts[0].thisCollider.gameObject.transform != base.transform.parent)
			{
				crashSound = CreateAudioSource("crashSound", 5f, 1f, crashClips[Random.Range(0, crashClips.Length)], loop: false, playNow: true, destroyAfterFinished: true);
			}
		}
	}

	public void Chassis()
	{
		float a = verticalLean;
		Vector3 angularVelocity = rigid.angularVelocity;
		verticalLean = Mathf.Clamp(Mathf.Lerp(a, angularVelocity.x * chassisVerticalLean, Time.deltaTime * 3f), -3f, 3f);
		RearRightWheelCollider.GetGroundHit(out WheelHit hit);
		float num = Mathf.Clamp(hit.sidewaysSlip, -1f, 1f);
		num = ((!(num > 0f)) ? (-1f) : 1f);
		float a2 = horizontalLean;
		Vector3 vector = base.transform.InverseTransformDirection(rigid.angularVelocity);
		horizontalLean = Mathf.Clamp(Mathf.Lerp(a2, Mathf.Abs(vector.y) * (0f - num) * chassisHorizontalLean, Time.deltaTime * 3f), -3f, 3f);
		float x = verticalLean;
		Quaternion localRotation = chassis.transform.localRotation;
		float y = localRotation.y;
		Vector3 angularVelocity2 = rigid.angularVelocity;
		Quaternion localRotation2 = Quaternion.Euler(x, y + angularVelocity2.z, horizontalLean);
		chassis.transform.localRotation = localRotation2;
		Rigidbody rigidbody = rigid;
		Vector3 localPosition = COM.localPosition;
		float x2 = localPosition.x;
		Vector3 localScale = base.transform.localScale;
		float x3 = x2 * localScale.x;
		Vector3 localPosition2 = COM.localPosition;
		float y2 = localPosition2.y;
		Vector3 localScale2 = base.transform.localScale;
		float y3 = y2 * localScale2.y;
		Vector3 localPosition3 = COM.localPosition;
		float z = localPosition3.z;
		Vector3 localScale3 = base.transform.localScale;
		rigidbody.centerOfMass = new Vector3(x3, y3, z * localScale3.z);
	}

	public void Lights()
	{
		float num = Mathf.Clamp((0f - motorInput) * 2f, 0f, 1f);
		if (UnityEngine.Input.GetKeyDown(KeyCode.L))
		{
			if (headLightsOn)
			{
				headLightsOn = false;
			}
			else
			{
				headLightsOn = true;
			}
		}
		for (int i = 0; i < brakeLights.Length; i++)
		{
			if (!reversing)
			{
				if (num > 0f)
				{
					brakeLights[i].SetActive(value: true);
				}
				else
				{
					brakeLights[i].SetActive(value: false);
				}
			}
		}
		for (int j = 0; j < headLights.Length; j++)
		{
			if (headLightsOn)
			{
				headLights[j].enabled = true;
			}
			else
			{
				headLights[j].enabled = false;
			}
		}
		for (int k = 0; k < reverseLights.Length; k++)
		{
			if (!reversing)
			{
				reverseLights[k].SetActive(value: false);
			}
			else if (num > 0f)
			{
				reverseLights[k].SetActive(value: true);
			}
		}
	}

	private void OnGUI()
	{
		GUI.skin.label.fontSize = 12;
		GUI.skin.box.fontSize = 12;
		Matrix4x4 matrix = GUI.matrix;
		if (!canControl)
		{
			return;
		}
		if (useAccelerometerForSteer && mobileController)
		{
			if (_mobileControllerType == MobileGUIType.NGUIController)
			{
				leftArrow.gameObject.SetActive(value: false);
				rightArrow.gameObject.SetActive(value: false);
				handbrakeGui.gameObject.SetActive(value: true);
				brakePedal.transform.position = leftArrow.transform.position;
			}
			if (_mobileControllerType == MobileGUIType.UIController)
			{
				leftArrowUI.gameObject.SetActive(value: false);
				rightArrowUI.gameObject.SetActive(value: false);
				handbrakeUI.gameObject.SetActive(value: true);
				brakePedalUI.transform.position = leftArrowUI.transform.position;
			}
			steeringWheelControl = false;
		}
		else if (mobileController)
		{
			if (_mobileControllerType == MobileGUIType.NGUIController)
			{
				gasPedal.gameObject.SetActive(value: true);
				leftArrow.gameObject.SetActive(value: true);
				rightArrow.gameObject.SetActive(value: true);
				handbrakeGui.gameObject.SetActive(value: true);
				brakePedal.transform.position = defbrakePedalPosition;
			}
			if (_mobileControllerType == MobileGUIType.UIController)
			{
				gasPedalUI.gameObject.SetActive(value: true);
				leftArrowUI.gameObject.SetActive(value: true);
				rightArrowUI.gameObject.SetActive(value: true);
				handbrakeUI.gameObject.SetActive(value: true);
				brakePedalUI.gameObject.SetActive(value: true);
				brakePedalUI.transform.position = defbrakePedalPosition;
			}
		}
		if (steeringWheelControl && mobileController)
		{
			if (_mobileControllerType == MobileGUIType.NGUIController)
			{
				leftArrow.gameObject.SetActive(value: false);
				rightArrow.gameObject.SetActive(value: false);
			}
			if (_mobileControllerType == MobileGUIType.UIController)
			{
				leftArrowUI.gameObject.SetActive(value: false);
				rightArrowUI.gameObject.SetActive(value: false);
			}
			GUIUtility.RotateAroundPivot(0f - steeringWheelsteerAngle, steeringWheelTextureRect.center + steeringWheelPivotPos);
			GUI.DrawTexture(steeringWheelTextureRect, steeringWheelTexture);
			GUI.matrix = matrix;
		}
		if (!demoGUI)
		{
			return;
		}
		GUI.backgroundColor = Color.black;
		float num = Screen.width / 2 - 200;
		GUI.Box(new Rect((float)(Screen.width - 410) - num, 10f, 400f, 220f), string.Empty);
		GUI.Label(new Rect((float)(Screen.width - 400) - num, 10f, 400f, 150f), "Engine RPM : " + Mathf.CeilToInt(EngineRPM));
		GUI.Label(new Rect((float)(Screen.width - 400) - num, 30f, 400f, 150f), "speed : " + Mathf.CeilToInt(speed));
		Rect position = new Rect((float)(Screen.width - 400) - num, 190f, 400f, 150f);
		Vector3 vector = Input.acceleration;
		GUI.Label(position, "Horizontal Tilt : " + vector.x);
		Rect position2 = new Rect((float)(Screen.width - 400) - num, 210f, 400f, 150f);
		Vector3 vector2 = Input.acceleration;
		GUI.Label(position2, "Vertical Tilt : " + vector2.y);
		if (fwd)
		{
			GUI.Label(new Rect((float)(Screen.width - 400) - num, 50f, 400f, 150f), "Left Wheel RPM : " + Mathf.CeilToInt(FrontLeftWheelCollider.rpm));
			GUI.Label(new Rect((float)(Screen.width - 400) - num, 70f, 400f, 150f), "Right Wheel RPM : " + Mathf.CeilToInt(FrontRightWheelCollider.rpm));
			GUI.Label(new Rect((float)(Screen.width - 400) - num, 90f, 400f, 150f), "Left Wheel Torque : " + Mathf.CeilToInt(FrontLeftWheelCollider.motorTorque));
			GUI.Label(new Rect((float)(Screen.width - 400) - num, 110f, 400f, 150f), "Right Wheel Torque : " + Mathf.CeilToInt(FrontRightWheelCollider.motorTorque));
			GUI.Label(new Rect((float)(Screen.width - 400) - num, 130f, 400f, 150f), "Left Wheel brake : " + Mathf.CeilToInt(FrontLeftWheelCollider.brakeTorque));
			GUI.Label(new Rect((float)(Screen.width - 400) - num, 150f, 400f, 150f), "Right Wheel brake : " + Mathf.CeilToInt(FrontRightWheelCollider.brakeTorque));
			GUI.Label(new Rect((float)(Screen.width - 400) - num, 170f, 400f, 150f), "Steer Angle : " + Mathf.CeilToInt(FrontLeftWheelCollider.steerAngle));
		}
		if (rwd)
		{
			GUI.Label(new Rect((float)(Screen.width - 400) - num, 50f, 400f, 150f), "Left Wheel RPM : " + Mathf.CeilToInt(RearLeftWheelCollider.rpm));
			GUI.Label(new Rect((float)(Screen.width - 400) - num, 70f, 400f, 150f), "Right Wheel RPM : " + Mathf.CeilToInt(RearRightWheelCollider.rpm));
			GUI.Label(new Rect((float)(Screen.width - 400) - num, 90f, 400f, 150f), "Left Wheel Torque : " + Mathf.CeilToInt(RearLeftWheelCollider.motorTorque));
			GUI.Label(new Rect((float)(Screen.width - 400) - num, 110f, 400f, 150f), "Right Wheel Torque : " + Mathf.CeilToInt(RearRightWheelCollider.motorTorque));
			GUI.Label(new Rect((float)(Screen.width - 400) - num, 130f, 400f, 150f), "Left Wheel brake : " + Mathf.CeilToInt(RearLeftWheelCollider.brakeTorque));
			GUI.Label(new Rect((float)(Screen.width - 400) - num, 150f, 400f, 150f), "Right Wheel brake : " + Mathf.CeilToInt(RearRightWheelCollider.brakeTorque));
			GUI.Label(new Rect((float)(Screen.width - 400) - num, 170f, 400f, 150f), "Steer Angle : " + Mathf.CeilToInt(FrontLeftWheelCollider.steerAngle));
		}
		GUI.backgroundColor = Color.blue;
		GUI.Button(new Rect((float)(Screen.width - 30) - num, 165f, 10f, Mathf.Clamp((0f - motorInput) * 100f, -100f, 0f)), string.Empty);
		if (mobileController)
		{
			if (GUI.Button(new Rect(Screen.width - 275, 200f, 250f, 50f), "Use Accelerometer \n For Steer"))
			{
				if (useAccelerometerForSteer)
				{
					useAccelerometerForSteer = false;
				}
				else
				{
					useAccelerometerForSteer = true;
				}
			}
			if (GUI.Button(new Rect(Screen.width - 275, 275f, 250f, 50f), "Use Steering Wheel"))
			{
				if (steeringWheelControl)
				{
					steeringWheelControl = false;
				}
				else
				{
					steeringWheelControl = true;
				}
			}
		}
		GUI.backgroundColor = Color.red;
		GUI.Button(new Rect((float)(Screen.width - 45) - num, 165f, 10f, Mathf.Clamp(motorInput * 100f, -100f, 0f)), string.Empty);
	}
}
