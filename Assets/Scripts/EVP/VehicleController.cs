using System;
using UnityEngine;
using UnityEngine.Serialization;

namespace EVP
{
	[RequireComponent(typeof(Rigidbody))]
	public class VehicleController : MonoBehaviour
	{
		public enum CenterOfMassMode
		{
			Transform,
			Parametric
		}

		public enum BrakeMode
		{
			Slip,
			Ratio
		}

		public enum UpdateRate
		{
			OnUpdate,
			OnFixedUpdate,
			Disabled
		}

		public enum PositionMode
		{
			Accurate,
			Fast
		}

		public delegate void OnImpact();

		private struct VehicleFrame
		{
			public float frontPosition;

			public float rearPosition;

			public float baseHeight;

			public float frontWidth;

			public float rearWidth;

			public float middlePoint;
		}

		public Wheel[] wheels = new Wheel[0];

		[Header("Center of Mass")]
		public CenterOfMassMode centerOfMassMode = CenterOfMassMode.Parametric;

		[Range(0.1f, 0.9f)]
		public float centerOfMassPosition = 0.5f;

		[Range(-1f, 1f)]
		public float centerOfMassHeightOffset;

		[FormerlySerializedAs("centerOfMass")]
		public Transform centerOfMassTransform;

		[Header("Vehicle Setup")]
		[FormerlySerializedAs("maxSpeed")]
		public float maxSpeedForward = 27.78f;

		public float maxSpeedReverse = 12f;

		[Range(0f, 3f)]
		public float tireFriction = 1f;

		[Range(0f, 1f)]
		public float rollingResistance = 0.05f;

		[Range(0f, 1f)]
		public float antiRoll = 0.2f;

		[Range(0f, 89f)]
		public float maxSteerAngle = 35f;

		[Range(0f, 4f)]
		public float aeroDrag;

		[Range(0f, 2f)]
		public float aeroDownforce = 1f;

		[Header("Vehicle Balance")]
		[Range(0f, 1f)]
		public float driveBalance = 0.5f;

		[Range(0f, 1f)]
		public float brakeBalance = 0.5f;

		[Range(0.3f, 0.7f)]
		public float tireFrictionBalance = 0.5f;

		[Range(0f, 1f)]
		public float aeroBalance = 0.5f;

		[Range(0f, 1f)]
		public float handlingBias = 0.5f;

		[Header("Motor")]
		public float maxDriveForce = 2000f;

		[Range(0.0001f, 0.9999f)]
		public float forceCurveShape = 0.5f;

		public float maxDriveSlip = 4f;

		public float driveForceToMaxSlip = 1000f;

		[Header("Brakes")]
		public float maxBrakeForce = 3000f;

		public float brakeForceToMaxSlip = 1000f;

		public BrakeMode brakeMode;

		public float maxBrakeSlip = 2f;

		[Range(0f, 1f)]
		public float maxBrakeRatio = 0.5f;

		public BrakeMode handbrakeMode;

		public float maxHandbrakeSlip = 10f;

		[Range(0f, 1f)]
		public float maxHandbrakeRatio = 1f;

		[Header("Driving Aids")]
		[FormerlySerializedAs("tcEnabled")]
		public bool tractionControl;

		[Range(0f, 1f)]
		[FormerlySerializedAs("tcRatio")]
		public float tractionControlRatio = 1f;

		[FormerlySerializedAs("absEnabled")]
		public bool brakeAssist;

		[Range(0f, 1f)]
		[FormerlySerializedAs("absRatio")]
		public float brakeAssistRatio = 1f;

		[FormerlySerializedAs("espEnabled")]
		public bool steeringLimit;

		[Range(0f, 1f)]
		[FormerlySerializedAs("espRatio")]
		public float steeringLimitRatio = 0.5f;

		public bool steeringAssist = true;

		[Range(0f, 1f)]
		public float steeringAssistRatio = 0.5f;

		[Range(-1f, 1f)]
		public float steerInput;

		[Range(-1f, 1f)]
		public float throttleInput;

		[Range(0f, 1f)]
		public float brakeInput;

		[Range(0f, 1f)]
		public float handbrakeInput;

		[Header("Visual Wheels")]
		public UpdateRate spinUpdateRate;

		public PositionMode wheelPositionMode;

		[Header("Wheel Contact")]
		[Range(0f, 0.5f)]
		public float sleepVelocity = 0.2f;

		public float defaultGroundGrip = 1f;

		public float defaultGroundDrag;

		[Header("Optimization & Debug")]
		public bool disallowRuntimeChanges;

		public bool disableWheelHitCorrection;

		public bool disableSteerAngleCorrection;

		[FormerlySerializedAs("showContactGizmos")]
		public bool showCollisionGizmos;

		[NonSerialized]
		public bool processContacts;

		[NonSerialized]
		public float impactThreeshold = 0.6f;

		[NonSerialized]
		public float impactInterval = 0.2f;

		[NonSerialized]
		public float impactIntervalRandom = 0.4f;

		[NonSerialized]
		public float impactMinSpeed = 2f;

		[NonSerialized]
		public bool computeExtendedTireData;

		public OnImpact onImpact;

		public static VehicleController current;

		public static float RpmToW = (float)Math.PI / 30f;

		public static float WToRpm = 30f / (float)Math.PI;

		private Transform m_transform;

		private Rigidbody m_rigidbody;

		private GroundMaterialManager m_groundMaterialManager;

		private Rigidbody m_referenceBody;

		private Rigidbody m_referenceCandidate;

		private int m_referenceCandidateCount;

		[NonSerialized]
		public string debugText = string.Empty;

		private WheelData[] m_wheelData = new WheelData[0];

		private float m_speed;

		private float m_speedAngle;

		private float m_steerAngle;

		private bool m_usesHandbrake;

		private CommonTools.BiasLerpContext m_forceBiasCtx = new CommonTools.BiasLerpContext();

		private VehicleFrame m_vehicleFrame;

		private Collider[] m_colliders = new Collider[0];

		private int[] m_colLayers = new int[0];

		private WheelFrictionCurve m_colliderFriction;

		private int m_sumImpactCount;

		private Vector3 m_sumImpactPosition = Vector3.zero;

		private Vector3 m_sumImpactVelocity = Vector3.zero;

		private int m_sumImpactHardness;

		private float m_lastImpactTime;

		private Vector3 m_localDragPosition = Vector3.zero;

		private Vector3 m_localDragVelocity = Vector3.zero;

		private int m_localDragHardness;

		private float m_lastStrongImpactTime;

		private PhysicMaterial m_lastImpactedMaterial;

		private GroundMaterial m_impactedGroundMaterial;

		public Vector3 localImpactPosition => m_sumImpactPosition;

		public Vector3 localImpactVelocity => m_sumImpactVelocity;

		public bool isHardImpact => m_sumImpactHardness >= 0;

		public Vector3 localDragPosition => m_localDragPosition;

		public Vector3 localDragVelocity => m_localDragVelocity;

		public bool isHardDrag => m_localDragHardness >= 0;

		public WheelData[] wheelData => m_wheelData;

		public float speed => m_speed;

		public float speedAngle => m_speedAngle;

		public float steerAngle => m_steerAngle;

		public Transform cachedTransform => m_transform;

		public Rigidbody cachedRigidbody => m_rigidbody;

		private void OnValidate()
		{
			maxDriveSlip = Mathf.Max(maxDriveSlip, 0f);
			maxBrakeSlip = Mathf.Max(maxBrakeSlip, 0f);
			maxHandbrakeSlip = Mathf.Max(maxHandbrakeSlip, 0f);
			maxDriveForce = Mathf.Max(maxDriveForce, 0f);
			maxBrakeForce = Mathf.Max(maxBrakeForce, 0f);
			driveForceToMaxSlip = Mathf.Max(driveForceToMaxSlip, 1f);
			brakeForceToMaxSlip = Mathf.Max(brakeForceToMaxSlip, 1f);
			maxSpeedForward = Mathf.Max(maxSpeedForward, 0f);
			maxSpeedReverse = Mathf.Max(maxSpeedReverse, 0f);
			aeroDrag = Mathf.Max(aeroDrag, 0f);
		}

		private void OnEnable()
		{
			m_transform = GetComponent<Transform>();
			m_rigidbody = GetComponent<Rigidbody>();
			m_groundMaterialManager = UnityEngine.Object.FindObjectOfType<GroundMaterialManager>();
			FindColliders();
			m_rigidbody.maxAngularVelocity = 14f;
			m_rigidbody.maxDepenetrationVelocity = 8f;
			if (wheels.Length == 0)
			{
				UnityEngine.Debug.LogWarning("The wheels property is empty. You must configure wheels and WheelColliders first. Component is disabled.");
				base.enabled = false;
				return;
			}
			m_vehicleFrame = ComputeVehicleFrame();
			ConfigureCenterOfMass();
			m_usesHandbrake = false;
			m_wheelData = new WheelData[wheels.Length];
			for (int i = 0; i < m_wheelData.Length; i++)
			{
				Wheel wheel = wheels[i];
				WheelData wheelData = new WheelData();
				if (wheel.wheelCollider == null)
				{
					UnityEngine.Debug.LogError("A WheelCollider is missing in the list of wheels for this vehicle: " + base.gameObject.name);
					base.enabled = false;
					return;
				}
				if (wheel.caliperTransform != null && wheel.wheelTransform != null && wheel.caliperTransform.IsChildOf(wheel.wheelTransform))
				{
					UnityEngine.Debug.LogWarning(ToString() + ": caliper (" + wheel.caliperTransform.name + ") should not be child of wheel (" + wheel.wheelTransform.name + ").\nVisual issues will surely appear. Either make wheel child of caliper, or put both at the same level (siblings).");
				}
				wheelData.isWheelChildOfCaliper = (wheel.caliperTransform != null && wheel.wheelTransform != null && wheel.wheelTransform.IsChildOf(wheel.caliperTransform));
				wheelData.collider = wheel.wheelCollider;
				wheelData.transform = wheel.wheelCollider.transform;
				if (wheel.handbrake)
				{
					m_usesHandbrake = true;
				}
				UpdateWheelCollider(wheelData.collider);
				wheelData.forceDistance = GetWheelForceDistance(wheelData.collider);
				Vector3 vector = m_transform.InverseTransformPoint(wheelData.transform.TransformPoint(wheelData.collider.center));
				float z = vector.z;
				wheelData.positionRatio = ((!(z >= m_vehicleFrame.middlePoint)) ? 0f : 1f);
				wheelData.wheel = wheel;
				m_wheelData[i] = wheelData;
			}
			WheelCollider componentInChildren = GetComponentInChildren<WheelCollider>();
			componentInChildren.ConfigureVehicleSubsteps(1000f, 1, 1);
			Wheel[] array = wheels;
			foreach (Wheel wheel2 in array)
			{
				SetupWheelCollider(wheel2.wheelCollider);
				UpdateWheelCollider(wheel2.wheelCollider);
			}
			m_lastImpactedMaterial = new PhysicMaterial();
		}

		private void Update()
		{
			if (spinUpdateRate == UpdateRate.Disabled)
			{
				ComputeSteerAngle();
				WheelData[] wheelData = m_wheelData;
				foreach (WheelData wd in wheelData)
				{
					UpdateSteering(wd);
				}
			}
			else if (spinUpdateRate == UpdateRate.OnUpdate || wheelPositionMode == PositionMode.Accurate)
			{
				bool flag = m_rigidbody.interpolation != 0 && wheelPositionMode == PositionMode.Accurate;
				if (flag)
				{
					DisableCollidersRaycast();
				}
				ComputeSteerAngle();
				WheelData[] wheelData2 = m_wheelData;
				foreach (WheelData wd2 in wheelData2)
				{
					UpdateSteering(wd2);
					UpdateTransform(wd2);
				}
				if (flag)
				{
					EnableCollidersRaycast();
				}
			}
			if (processContacts)
			{
				UpdateDragState(Vector3.zero, Vector3.zero, m_localDragHardness);
			}
		}

		private void FixedUpdate()
		{
			if (!disallowRuntimeChanges)
			{
				ConfigureCenterOfMass();
			}
			throttleInput = Mathf.Clamp(throttleInput, -1f, 1f);
			brakeInput = Mathf.Clamp01(brakeInput);
			handbrakeInput = Mathf.Clamp01(handbrakeInput);
			if (m_referenceCandidateCount > m_wheelData.Length / 2)
			{
				m_referenceBody = m_referenceCandidate;
			}
			Vector3 vector = m_rigidbody.velocity;
			if (m_referenceBody != null)
			{
				vector -= m_referenceBody.velocity;
			}
			m_speed = Vector3.Dot(vector, m_transform.forward);
			m_speedAngle = Vector3.Angle(vector, m_transform.forward) * Mathf.Sign(Vector3.Dot(vector, m_transform.right));
			float referenceDownforce = (!computeExtendedTireData) ? 1f : (m_rigidbody.mass * Physics.gravity.magnitude / (float)m_wheelData.Length);
			bool flag = spinUpdateRate == UpdateRate.OnFixedUpdate && wheelPositionMode == PositionMode.Fast;
			int num = 0;
			m_referenceCandidateCount = 0;
			if (flag)
			{
				ComputeSteerAngle();
			}
			WheelData[] wheelData = m_wheelData;
			foreach (WheelData wheelData2 in wheelData)
			{
				if (!disallowRuntimeChanges)
				{
					UpdateWheelCollider(wheelData2.collider);
				}
				if (flag)
				{
					UpdateSteering(wheelData2);
				}
				UpdateSuspension(wheelData2);
				UpdateLocalFrame(wheelData2);
				UpdateGroundMaterial(wheelData2);
				ComputeTireForces(wheelData2);
				ApplyTireForces(wheelData2);
				UpdateWheelSleep(wheelData2);
				if (flag)
				{
					UpdateTransform(wheelData2);
				}
				if (wheelData2.grounded)
				{
					num++;
				}
				if (computeExtendedTireData)
				{
					ComputeExtendedTireData(wheelData2, referenceDownforce);
				}
			}
			float sqrMagnitude = m_rigidbody.velocity.sqrMagnitude;
			Vector3 normalized = m_rigidbody.velocity.normalized;
			float num2 = Vector3.Dot(m_transform.forward, normalized);
			Vector3 force = (0f - aeroDrag) * sqrMagnitude * normalized;
			Vector3 force2 = (0f - aeroDownforce) * sqrMagnitude * num2 * m_transform.up;
			Transform transform = m_transform;
			Vector3 centerOfMass = m_rigidbody.centerOfMass;
			Vector3 position = transform.TransformPoint(new Vector3(0f, centerOfMass.y, Mathf.Lerp(m_vehicleFrame.rearPosition, m_vehicleFrame.frontPosition, aeroBalance)));
			m_rigidbody.AddForceAtPosition(force, position);
			if (num > 0)
			{
				m_rigidbody.AddForceAtPosition(force2, position);
			}
			if (processContacts)
			{
				HandleImpacts();
			}
		}

		private void ComputeSteerAngle()
		{
			float num = maxSteerAngle * steerInput;
			float num2 = Mathf.InverseLerp(0.1f, 3f, m_speed);
			if (steeringLimit)
			{
				float num3 = m_speed * steeringLimitRatio * num2;
				float a = Mathf.Asin(Mathf.Clamp01(3f / num3)) * 57.29578f;
				float num4 = Mathf.Min(maxSteerAngle, Mathf.Max(a, Mathf.Abs(m_speedAngle)));
				num = Mathf.Clamp(num, 0f - num4, num4);
			}
			float num5 = 0f;
			if (steeringAssist)
			{
				num5 = m_speedAngle * steeringAssistRatio * num2 * Mathf.InverseLerp(2f, 3f, Mathf.Abs(m_speedAngle));
			}
			m_steerAngle = Mathf.Clamp(num + num5, 0f - maxSteerAngle, maxSteerAngle);
		}

		private void UpdateSteering(WheelData wd)
		{
			if (wd.wheel.steer)
			{
				wd.steerAngle = m_steerAngle;
			}
			else
			{
				wd.steerAngle = 0f;
			}
			wd.collider.steerAngle = ((!disableSteerAngleCorrection) ? FixSteerAngle(wd, wd.steerAngle) : wd.steerAngle);
		}

		private float FixSteerAngle(WheelData wd, float inputSteerAngle)
		{
			Quaternion rotation = Quaternion.AngleAxis(inputSteerAngle, wd.transform.up);
			Vector3 vector = rotation * wd.transform.forward;
			Vector3 vector2 = vector - Vector3.Project(vector, m_transform.up);
			return Vector3.Angle(m_transform.forward, vector2) * Mathf.Sign(Vector3.Dot(m_transform.right, vector2));
		}

		private void UpdateSuspension(WheelData wd)
		{
			wd.grounded = wd.collider.GetGroundHit(out wd.hit);
			wd.origin = wd.transform.TransformPoint(wd.collider.center);
			if (wd.grounded && !disableWheelHitCorrection && Physics.Raycast(wd.origin, -wd.transform.up, out RaycastHit hitInfo, wd.collider.suspensionDistance + wd.collider.radius, -5, QueryTriggerInteraction.Ignore))
			{
				wd.hit.point = hitInfo.point;
				wd.hit.normal = hitInfo.normal;
			}
			if (wd.grounded)
			{
				Vector3 vector = wd.transform.InverseTransformPoint(wd.hit.point);
				wd.suspensionCompression = 1f - (0f - vector.y - wd.collider.radius) / wd.collider.suspensionDistance;
				if (wd.hit.force < 0f)
				{
					wd.hit.force = 0f;
				}
				wd.downforce = wd.hit.force;
			}
			else
			{
				wd.suspensionCompression = 0f;
				wd.downforce = 0f;
			}
		}

		private void UpdateLocalFrame(WheelData wd)
		{
			if (!wd.grounded)
			{
				wd.hit.point = wd.origin - wd.transform.up * (wd.collider.suspensionDistance + wd.collider.radius);
				wd.hit.normal = wd.transform.up;
				wd.hit.collider = null;
			}
			Vector3 vector = m_rigidbody.GetPointVelocity(wd.hit.point);
			if (wd.hit.collider != null)
			{
				Rigidbody attachedRigidbody = wd.hit.collider.attachedRigidbody;
				if (attachedRigidbody != null)
				{
					vector -= attachedRigidbody.GetPointVelocity(wd.hit.point);
				}
				if (attachedRigidbody != m_referenceBody)
				{
					m_referenceCandidate = attachedRigidbody;
					m_referenceCandidateCount++;
				}
			}
			wd.velocity = vector - Vector3.Project(vector, wd.hit.normal);
			wd.localVelocity.y = Vector3.Dot(wd.hit.forwardDir, wd.velocity);
			wd.localVelocity.x = Vector3.Dot(wd.hit.sidewaysDir, wd.velocity);
			if (!wd.grounded)
			{
				wd.localRigForce = Vector2.zero;
				return;
			}
			float num = Mathf.InverseLerp(1f, 0.25f, wd.velocity.sqrMagnitude);
			Vector2 vector3 = default(Vector2);
			if (num > 0f)
			{
				float num2 = Vector3.Dot(Vector3.up, wd.hit.normal);
				Vector3 rhs;
				if (num2 > 1E-06f)
				{
					Vector3 vector2 = Vector3.up * wd.hit.force / num2;
					rhs = vector2 - Vector3.Project(vector2, wd.hit.normal);
				}
				else
				{
					rhs = Vector3.up * 100000f;
				}
				vector3.y = Vector3.Dot(wd.hit.forwardDir, rhs);
				vector3.x = Vector3.Dot(wd.hit.sidewaysDir, rhs);
				vector3 *= num;
			}
			else
			{
				vector3 = Vector2.zero;
			}
			float force = wd.hit.force;
			Vector3 gravity = Physics.gravity;
			float num3 = Mathf.Clamp(force / (0f - gravity.y), 0f, wd.collider.sprungMass) * 0.5f;
			Vector2 a = (0f - num3) * wd.localVelocity / Time.deltaTime;
			wd.localRigForce = a + vector3;
		}

		private void UpdateGroundMaterial(WheelData wd)
		{
			if (wd.grounded)
			{
				UpdateGroundMaterialCached(wd.hit.collider.sharedMaterial, ref wd.lastPhysicMaterial, ref wd.groundMaterial);
			}
		}

		private void ComputeTireForces(WheelData wd)
		{
			float f = (!wd.wheel.drive) ? 0f : throttleInput;
			float num = maxDriveSlip;
			if (Mathf.Sign(f) != Mathf.Sign(wd.localVelocity.y))
			{
				num -= wd.localVelocity.y * Mathf.Sign(f);
			}
			float num2 = 0f;
			float brakeRatio = 0f;
			float brakeSlip = 0f;
			if (wd.wheel.brake && wd.wheel.handbrake)
			{
				num2 = Mathf.Max(brakeInput, handbrakeInput);
				if (handbrakeInput >= brakeInput)
				{
					ComputeBrakeValues(wd, handbrakeMode, maxHandbrakeSlip, maxHandbrakeRatio, out brakeSlip, out brakeRatio);
				}
				else
				{
					ComputeBrakeValues(wd, brakeMode, maxBrakeSlip, maxBrakeRatio, out brakeSlip, out brakeRatio);
				}
			}
			else if (wd.wheel.brake)
			{
				num2 = brakeInput;
				ComputeBrakeValues(wd, brakeMode, maxBrakeSlip, maxBrakeRatio, out brakeSlip, out brakeRatio);
			}
			else if (wd.wheel.handbrake)
			{
				num2 = handbrakeInput;
				ComputeBrakeValues(wd, handbrakeMode, maxHandbrakeSlip, maxHandbrakeRatio, out brakeSlip, out brakeRatio);
			}
			float num3 = Mathf.Abs(f);
			float num4 = 0f - rollingResistance + num3 * (1f + rollingResistance) - num2 * (1f - rollingResistance);
			if (num4 >= 0f)
			{
				wd.finalInput = num4 * Mathf.Sign(f);
				wd.isBraking = false;
			}
			else
			{
				wd.finalInput = 0f - num4;
				wd.isBraking = true;
			}
			float num5;
			if (wd.isBraking)
			{
				num5 = wd.finalInput * GetRampBalancedValue(maxBrakeForce, brakeBalance, wd.positionRatio);
			}
			else
			{
				float rampBalancedValue = GetRampBalancedValue(maxDriveForce, driveBalance, wd.positionRatio);
				num5 = ComputeDriveForce(wd.finalInput * rampBalancedValue, rampBalancedValue, wd.grounded);
			}
			if (wd.grounded)
			{
				if (tractionControl)
				{
					num = Mathf.Lerp(num, 0.1f, tractionControlRatio);
				}
				if (brakeAssist && brakeInput > handbrakeInput)
				{
					brakeSlip = Mathf.Lerp(brakeSlip, 0.1f, brakeAssistRatio);
					brakeRatio = Mathf.Lerp(brakeRatio, brakeRatio * 0.1f, brakeAssistRatio);
				}
			}
			if (wd.grounded)
			{
				wd.tireSlip.x = wd.localVelocity.x;
				wd.tireSlip.y = wd.localVelocity.y - wd.angularVelocity * wd.collider.radius;
				float grip;
				float drag;
				if (wd.groundMaterial != null)
				{
					grip = wd.groundMaterial.grip;
					drag = wd.groundMaterial.drag;
				}
				else
				{
					grip = defaultGroundGrip;
					drag = defaultGroundDrag;
				}
				float balancedValue = GetBalancedValue(tireFriction, tireFrictionBalance, wd.positionRatio);
				float num6 = balancedValue * wd.downforce * grip;
				float num7;
				if (wd.isBraking)
				{
					float max = Mathf.Max(Mathf.Abs(wd.localVelocity.y * brakeRatio), brakeSlip);
					num7 = Mathf.Clamp(Mathf.Abs(num5 * wd.tireSlip.x) / num6, 0f, max);
				}
				else
				{
					num7 = Mathf.Min(Mathf.Abs(num5 * wd.tireSlip.x) / num6, num);
					if (num5 != 0f && num7 < 0.1f)
					{
						num7 = 0.1f;
					}
				}
				if (Mathf.Abs(wd.tireSlip.y) < num7)
				{
					wd.tireSlip.y = num7 * Mathf.Sign(wd.tireSlip.y);
				}
				Vector2 vector = (0f - num6) * wd.tireSlip.normalized;
				vector.x = Mathf.Abs(vector.x);
				vector.y = Mathf.Abs(vector.y);
				wd.tireForce.x = Mathf.Clamp(wd.localRigForce.x, 0f - vector.x, vector.x);
				if (wd.isBraking)
				{
					float num8 = Mathf.Min(vector.y, num5);
					wd.tireForce.y = Mathf.Clamp(wd.localRigForce.y, 0f - num8, num8);
				}
				else
				{
					wd.tireForce.y = Mathf.Clamp(num5, 0f - vector.y, vector.y);
				}
				wd.dragForce = (0f - num6 * wd.localVelocity.magnitude * drag * 0.001f) * wd.localVelocity;
			}
			else
			{
				wd.tireSlip = Vector2.zero;
				wd.tireForce = Vector2.zero;
				wd.dragForce = Vector2.zero;
			}
			float num9 = (!wd.isBraking) ? driveForceToMaxSlip : brakeForceToMaxSlip;
			float num10 = Mathf.Clamp01((Mathf.Abs(num5) - Mathf.Abs(wd.tireForce.y)) / num9);
			float num11 = (!wd.isBraking) ? (num10 * num * Mathf.Sign(num5)) : Mathf.Clamp((0f - num10) * wd.localVelocity.y * brakeRatio, 0f - brakeSlip, brakeSlip);
			wd.angularVelocity = (wd.localVelocity.y + num11) / wd.collider.radius;
		}

		private void ApplyTireForces(WheelData wd)
		{
			if (wd.grounded)
			{
				if (!disallowRuntimeChanges)
				{
					wd.forceDistance = GetWheelForceDistance(wd.collider);
				}
				Vector3 vector = wd.hit.forwardDir * (wd.tireForce.y + wd.dragForce.y);
				Vector3 vector2 = wd.hit.sidewaysDir * (wd.tireForce.x + wd.dragForce.x);
				Vector3 sidewaysForceAppPoint = GetSidewaysForceAppPoint(wd, wd.hit.point);
				m_rigidbody.AddForceAtPosition(vector, wd.hit.point);
				m_rigidbody.AddForceAtPosition(vector2, sidewaysForceAppPoint);
				Rigidbody attachedRigidbody = wd.hit.collider.attachedRigidbody;
				if (attachedRigidbody != null && !attachedRigidbody.isKinematic)
				{
					attachedRigidbody.AddForceAtPosition(-vector, wd.hit.point);
					attachedRigidbody.AddForceAtPosition(-vector2, sidewaysForceAppPoint);
				}
			}
		}

		public Vector3 GetSidewaysForceAppPoint(WheelData wd, Vector3 contactPoint)
		{
			Vector3 vector = contactPoint + wd.transform.up * antiRoll * wd.forceDistance;
			if (wd.wheel.steer && wd.steerAngle != 0f && Mathf.Sign(wd.steerAngle) != Mathf.Sign(wd.tireSlip.x))
			{
				vector += wd.transform.forward * (m_vehicleFrame.frontPosition - m_vehicleFrame.rearPosition) * (handlingBias - 0.5f);
			}
			return vector;
		}

		private static float ComputeSlipAngle(Vector2 localVelocity)
		{
			return (!(localVelocity.magnitude > 0.01f)) ? 0f : Mathf.Atan2(localVelocity.x, Mathf.Abs(localVelocity.y));
		}

		private static float ComputeCombinedSlip(Vector2 localVelocity, Vector2 tireSlip)
		{
			float magnitude = localVelocity.magnitude;
			if (magnitude > 0.01f)
			{
				float num = tireSlip.x * localVelocity.x / magnitude;
				float y = tireSlip.y;
				return Mathf.Sqrt(num * num + y * y);
			}
			return tireSlip.magnitude;
		}

		private void ComputeExtendedTireData(WheelData wd, float referenceDownforce)
		{
			wd.combinedTireSlip = ComputeCombinedSlip(wd.localVelocity, wd.tireSlip);
			wd.downforceRatio = wd.hit.force / referenceDownforce;
		}

		private float ComputeDriveForce(float demandedForce, float maxForce, bool grounded)
		{
			float num = Mathf.Abs(m_speed);
			float num2 = (!(m_speed >= 0f)) ? maxSpeedReverse : maxSpeedForward;
			if (num < num2)
			{
				if ((!(m_speed < 0f) || !(demandedForce > 0f)) && (!(m_speed > 0f) || !(demandedForce < 0f)))
				{
					maxForce *= CommonTools.BiasedLerp(1f - num / num2, forceCurveShape, m_forceBiasCtx);
				}
				return Mathf.Clamp(demandedForce, 0f - maxForce, maxForce);
			}
			float num3 = maxForce * Mathf.Max(1f - num / num2, -1f) * Mathf.Sign(m_speed);
			if ((m_speed < 0f && demandedForce > 0f) || (m_speed > 0f && demandedForce < 0f))
			{
				num3 = Mathf.Clamp(num3 + demandedForce, 0f - maxForce, maxForce);
			}
			return num3;
		}

		private void ComputeBrakeValues(WheelData wd, BrakeMode mode, float maxSlip, float maxRatio, out float brakeSlip, out float brakeRatio)
		{
			if (mode == BrakeMode.Slip)
			{
				brakeSlip = maxSlip;
				brakeRatio = 1f;
			}
			else
			{
				brakeSlip = Mathf.Abs(wd.localVelocity.y);
				brakeRatio = maxRatio;
			}
		}

		private void UpdateTransform(WheelData wd)
		{
			if (wd.wheel.wheelTransform != null || wd.wheel.caliperTransform != null)
			{
				wd.angularPosition = (wd.angularPosition + wd.angularVelocity * Time.deltaTime) % ((float)Math.PI * 2f);
				float d;
				if (wheelPositionMode != PositionMode.Fast)
				{
					d = ((!Physics.Raycast(wd.origin, -wd.transform.up, out wd.rayHit, wd.collider.suspensionDistance + wd.collider.radius, -5, QueryTriggerInteraction.Ignore)) ? (wd.collider.suspensionDistance + wd.collider.radius * 0.05f) : (wd.rayHit.distance - wd.collider.radius * 0.95f));
				}
				else
				{
					d = wd.collider.suspensionDistance * (1f - wd.suspensionCompression) + wd.collider.radius * 0.05f;
					wd.rayHit.point = wd.hit.point;
					wd.rayHit.normal = wd.hit.normal;
				}
				Vector3 position = wd.transform.position - wd.transform.up * d;
				if (wd.wheel.caliperTransform != null)
				{
					wd.wheel.caliperTransform.position = position;
					wd.wheel.caliperTransform.rotation = wd.transform.rotation * Quaternion.Euler(0f, wd.steerAngle, 0f);
				}
				if (wd.wheel.wheelTransform != null)
				{
					if (wd.isWheelChildOfCaliper)
					{
						wd.wheel.wheelTransform.localRotation = Quaternion.Euler(wd.angularPosition * 57.29578f, 0f, 0f);
						return;
					}
					wd.wheel.wheelTransform.position = position;
					wd.wheel.wheelTransform.rotation = wd.transform.rotation * Quaternion.Euler(wd.angularPosition * 57.29578f, wd.steerAngle, 0f);
				}
			}
			else
			{
				wd.rayHit.point = wd.hit.point;
				wd.rayHit.normal = wd.hit.normal;
			}
		}

		private void UpdateGroundMaterialCached(PhysicMaterial colliderMaterial, ref PhysicMaterial cachedMaterial, ref GroundMaterial groundMaterial)
		{
			if (m_groundMaterialManager != null)
			{
				if (colliderMaterial != cachedMaterial)
				{
					cachedMaterial = colliderMaterial;
					groundMaterial = m_groundMaterialManager.GetGroundMaterial(colliderMaterial);
				}
			}
			else
			{
				groundMaterial = null;
			}
		}

		public void ResetVehicle()
		{
			Vector3 localEulerAngles = base.transform.localEulerAngles;
			m_rigidbody.MoveRotation(Quaternion.Euler(0f, localEulerAngles.y, 0f));
			m_rigidbody.MovePosition(m_rigidbody.position + Vector3.up * 1.6f);
			m_rigidbody.velocity = Vector3.zero;
			m_rigidbody.angularVelocity = Vector3.zero;
		}

		private void FindColliders()
		{
			m_colliders = GetComponentsInChildren<Collider>();
			m_colLayers = new int[m_colliders.Length];
			int i = 0;
			for (int num = m_colliders.Length; i < num; i++)
			{
				m_colLayers[i] = m_colliders[i].gameObject.layer;
			}
		}

		private void DisableCollidersRaycast()
		{
			int i = 0;
			for (int num = m_colliders.Length; i < num; i++)
			{
				GameObject gameObject = m_colliders[i].gameObject;
				m_colLayers[i] = gameObject.layer;
				gameObject.layer = 2;
			}
		}

		private void EnableCollidersRaycast()
		{
			int i = 0;
			for (int num = m_colliders.Length; i < num; i++)
			{
				m_colliders[i].gameObject.layer = m_colLayers[i];
			}
		}

		private float GetWheelForceDistance(WheelCollider col)
		{
			Vector3 centerOfMass = m_rigidbody.centerOfMass;
			float y = centerOfMass.y;
			Vector3 vector = m_transform.InverseTransformPoint(col.transform.position);
			float num = y - vector.y + col.radius;
			JointSpring suspensionSpring = col.suspensionSpring;
			return num + (1f - suspensionSpring.targetPosition) * col.suspensionDistance;
		}

		private void UpdateWheelCollider(WheelCollider col)
		{
			if (col.enabled)
			{
				JointSpring suspensionSpring = col.suspensionSpring;
				float num = 0f - col.sprungMass;
				Vector3 gravity = Physics.gravity;
				float num2 = num * gravity.y;
				float num3 = num2 / suspensionSpring.spring;
				suspensionSpring.targetPosition = Mathf.Clamp01(num3 / col.suspensionDistance);
				float num4 = num2 / col.suspensionDistance;
				if (suspensionSpring.spring < num4)
				{
					suspensionSpring.spring = num4;
				}
				col.suspensionSpring = suspensionSpring;
			}
		}

		private void SetupWheelCollider(WheelCollider col)
		{
			m_colliderFriction.stiffness = 0f;
			col.sidewaysFriction = m_colliderFriction;
			col.forwardFriction = m_colliderFriction;
			col.motorTorque = 1E-05f;
		}

		private void UpdateWheelSleep(WheelData wd)
		{
			if (wd.localVelocity.magnitude < sleepVelocity && Time.time - m_lastStrongImpactTime > 0.2f && ((wd.isBraking && wd.finalInput > 0.01f) || (m_usesHandbrake && handbrakeInput > 0.1f)))
			{
				wd.collider.motorTorque = 0f;
			}
			else
			{
				wd.collider.motorTorque = 1E-05f;
			}
		}

		private VehicleFrame ComputeVehicleFrame()
		{
			float num = 0f;
			int num2 = 0;
			Wheel[] array = wheels;
			foreach (Wheel wheel in array)
			{
				if (wheel.wheelCollider != null)
				{
					float num3 = num;
					Vector3 vector = base.transform.InverseTransformPoint(wheel.wheelCollider.transform.TransformPoint(wheel.wheelCollider.center));
					num = num3 + vector.z;
					num2++;
				}
			}
			if (num2 > 0)
			{
				num /= (float)num2;
			}
			float num4 = 0f;
			float num5 = 0f;
			int num6 = 0;
			float num7 = 0f;
			float num8 = 0f;
			int num9 = 0;
			float num10 = 0f;
			int num11 = 0;
			Wheel[] array2 = wheels;
			foreach (Wheel wheel2 in array2)
			{
				if (wheel2.wheelCollider != null)
				{
					Vector3 vector2 = base.transform.InverseTransformPoint(wheel2.wheelCollider.transform.TransformPoint(wheel2.wheelCollider.center));
					float z = vector2.z;
					float num12 = Mathf.Abs(vector2.x);
					if (z >= num)
					{
						num4 += z;
						num5 += num12;
						num6++;
					}
					else
					{
						num7 += z;
						num8 += num12;
						num9++;
					}
					num10 += vector2.y;
					num11++;
				}
			}
			if (num6 > 0)
			{
				num4 /= (float)num6;
				num5 /= (float)num6;
			}
			if (num9 > 0)
			{
				num7 /= (float)num9;
				num8 /= (float)num9;
			}
			else
			{
				num7 = num4;
				num8 = num5;
			}
			if (num11 > 0)
			{
				num10 /= (float)num11;
			}
			VehicleFrame result = default(VehicleFrame);
			result.frontPosition = num4;
			result.rearPosition = num7;
			result.baseHeight = num10;
			result.frontWidth = num5;
			result.rearWidth = num8;
			result.middlePoint = num;
			return result;
		}

		private void ConfigureCenterOfMass()
		{
			if (centerOfMassMode == CenterOfMassMode.Parametric)
			{
				Vector3 vector = new Vector3(0f, m_vehicleFrame.baseHeight + centerOfMassHeightOffset, Mathf.Lerp(m_vehicleFrame.rearPosition, m_vehicleFrame.frontPosition, centerOfMassPosition));
				if (m_rigidbody.centerOfMass != vector)
				{
					m_rigidbody.centerOfMass = vector;
				}
			}
			else if (centerOfMassTransform != null)
			{
				Vector3 vector2 = m_transform.InverseTransformPoint(centerOfMassTransform.position);
				if (m_rigidbody.centerOfMass != vector2)
				{
					m_rigidbody.centerOfMass = vector2;
				}
			}
		}

		public static float GetBalancedValue(float value, float bias, float positionRatio)
		{
			float num = 1f - bias;
			return value * (positionRatio * bias + (1f - positionRatio) * num) * 2f;
		}

		public static float GetRampBalancedValue(float value, float bias, float positionRatio)
		{
			float num = Mathf.Clamp01(2f * bias);
			float num2 = Mathf.Clamp01(2f * (1f - bias));
			return value * (positionRatio * num + (1f - positionRatio) * num2);
		}

		private void OnCollisionEnter(Collision collision)
		{
			if (collision.relativeVelocity.magnitude > 4f)
			{
				m_lastStrongImpactTime = Time.time;
			}
			if (processContacts)
			{
				ProcessContacts(collision, forceImpact: true);
			}
		}

		private void OnCollisionStay(Collision collision)
		{
			if (processContacts)
			{
				ProcessContacts(collision, forceImpact: false);
			}
		}

		private void ProcessContacts(Collision col, bool forceImpact)
		{
			int num = 0;
			Vector3 a = Vector3.zero;
			Vector3 a2 = Vector3.zero;
			int num2 = 0;
			int num3 = 0;
			Vector3 a3 = Vector3.zero;
			Vector3 a4 = Vector3.zero;
			int num4 = 0;
			float num5 = impactMinSpeed * impactMinSpeed;
			ContactPoint[] contacts = col.contacts;
			for (int i = 0; i < contacts.Length; i++)
			{
				ContactPoint contactPoint = contacts[i];
				Collider otherCollider = contactPoint.otherCollider;
				int num6 = 0;
				UpdateGroundMaterialCached(otherCollider.sharedMaterial, ref m_lastImpactedMaterial, ref m_impactedGroundMaterial);
				if (m_impactedGroundMaterial != null)
				{
					num6 = ((m_impactedGroundMaterial.surfaceType == GroundMaterial.SurfaceType.Hard) ? 1 : (-1));
				}
				Vector3 vector = m_rigidbody.GetPointVelocity(contactPoint.point);
				if (otherCollider.attachedRigidbody != null)
				{
					vector -= otherCollider.attachedRigidbody.GetPointVelocity(contactPoint.point);
				}
				float num7 = Vector3.Dot(vector, contactPoint.normal);
				if (num7 < 0f - impactThreeshold || (forceImpact && col.relativeVelocity.sqrMagnitude > num5))
				{
					num++;
					a += contactPoint.point;
					a2 += col.relativeVelocity;
					num2 += num6;
					if (showCollisionGizmos)
					{
						UnityEngine.Debug.DrawLine(contactPoint.point, contactPoint.point + CommonTools.Lin2Log(vector), Color.red);
					}
				}
				else if (num7 < impactThreeshold)
				{
					num3++;
					a3 += contactPoint.point;
					a4 += vector;
					num4 += num6;
					if (showCollisionGizmos)
					{
						UnityEngine.Debug.DrawLine(contactPoint.point, contactPoint.point + CommonTools.Lin2Log(vector), Color.cyan);
					}
				}
				if (showCollisionGizmos)
				{
					UnityEngine.Debug.DrawLine(contactPoint.point, contactPoint.point + contactPoint.normal * 0.25f, Color.yellow);
				}
			}
			if (num > 0)
			{
				float d = 1f / (float)num;
				a *= d;
				a2 *= d;
				m_sumImpactCount++;
				m_sumImpactPosition += m_transform.InverseTransformPoint(a);
				m_sumImpactVelocity += m_transform.InverseTransformDirection(a2);
				m_sumImpactHardness += num2;
			}
			if (num3 > 0)
			{
				float d2 = 1f / (float)num3;
				a3 *= d2;
				a4 *= d2;
				UpdateDragState(m_transform.InverseTransformPoint(a3), m_transform.InverseTransformDirection(a4), num4);
			}
		}

		private void HandleImpacts()
		{
			if (Time.time - m_lastImpactTime >= impactInterval && m_sumImpactCount > 0)
			{
				float num = 1f / (float)m_sumImpactCount;
				m_sumImpactPosition *= num;
				m_sumImpactVelocity *= num;
				if (onImpact != null)
				{
					current = this;
					onImpact();
					current = null;
				}
				if (showCollisionGizmos && localImpactVelocity.sqrMagnitude > 0.001f)
				{
					UnityEngine.Debug.DrawLine(base.transform.TransformPoint(localImpactPosition), base.transform.TransformPoint(localImpactPosition) + CommonTools.Lin2Log(base.transform.TransformDirection(localImpactVelocity)), Color.red, 0.2f, depthTest: false);
				}
				m_sumImpactCount = 0;
				m_sumImpactPosition = Vector3.zero;
				m_sumImpactVelocity = Vector3.zero;
				m_sumImpactHardness = 0;
				m_lastImpactTime = Time.time + impactInterval * UnityEngine.Random.Range(0f - impactIntervalRandom, impactIntervalRandom);
			}
		}

		private void UpdateDragState(Vector3 dragPosition, Vector3 dragVelocity, int dragHardness)
		{
			if (dragVelocity.sqrMagnitude > 0.001f)
			{
				m_localDragPosition = Vector3.Lerp(m_localDragPosition, dragPosition, 10f * Time.deltaTime);
				m_localDragVelocity = Vector3.Lerp(m_localDragVelocity, dragVelocity, 20f * Time.deltaTime);
				m_localDragHardness = dragHardness;
			}
			else
			{
				m_localDragVelocity = Vector3.Lerp(m_localDragVelocity, Vector3.zero, 10f * Time.deltaTime);
			}
			if (showCollisionGizmos && localDragVelocity.sqrMagnitude > 0.001f)
			{
				UnityEngine.Debug.DrawLine(base.transform.TransformPoint(localDragPosition), base.transform.TransformPoint(localDragPosition) + CommonTools.Lin2Log(base.transform.TransformDirection(localDragVelocity)), Color.cyan, 0.05f, depthTest: false);
			}
		}

		[ContextMenu("Adjust WheelColliders to their meshes")]
		private void AdjustWheelColliders()
		{
			Wheel[] array = wheels;
			foreach (Wheel wheel in array)
			{
				if (wheel.wheelCollider != null)
				{
					AdjustColliderToWheelMesh(wheel.wheelCollider, wheel.wheelTransform);
				}
			}
		}

		private static void AdjustColliderToWheelMesh(WheelCollider wheelCollider, Transform wheelTransform)
		{
			if (wheelTransform == null)
			{
				UnityEngine.Debug.LogError(wheelCollider.gameObject.name + ": A Wheel transform is required");
				return;
			}
			wheelCollider.transform.position = wheelTransform.position + wheelTransform.up * wheelCollider.suspensionDistance * 0.5f;
			wheelCollider.transform.rotation = wheelTransform.rotation;
			MeshFilter[] componentsInChildren = wheelTransform.GetComponentsInChildren<MeshFilter>();
			if (componentsInChildren == null || componentsInChildren.Length == 0)
			{
				UnityEngine.Debug.LogWarning(wheelTransform.gameObject.name + ": Couldn't calculate radius. There are no meshes in the Wheel transform or its children");
				return;
			}
			Bounds scaledBounds = GetScaledBounds(componentsInChildren[0]);
			int i = 1;
			for (int num = componentsInChildren.Length; i < num; i++)
			{
				Bounds scaledBounds2 = GetScaledBounds(componentsInChildren[i]);
				scaledBounds.Encapsulate(scaledBounds2.min);
				scaledBounds.Encapsulate(scaledBounds2.max);
			}
			Vector3 extents = scaledBounds.extents;
			float y = extents.y;
			Vector3 extents2 = scaledBounds.extents;
			if (Mathf.Abs(y - extents2.z) > 0.01f)
			{
				UnityEngine.Debug.LogWarning(wheelTransform.gameObject.name + ": The Wheel mesh might not be a correct wheel. The calculated radius is different along forward and vertical axis.");
			}
			Vector3 extents3 = scaledBounds.extents;
			wheelCollider.radius = extents3.y;
		}

		private static Bounds GetScaledBounds(MeshFilter meshFilter)
		{
			Bounds bounds = meshFilter.sharedMesh.bounds;
			Vector3 lossyScale = meshFilter.transform.lossyScale;
			bounds.max = Vector3.Scale(bounds.max, lossyScale);
			bounds.min = Vector3.Scale(bounds.min, lossyScale);
			return bounds;
		}

		[ContextMenu("Convert Center of Mass from Transform to Parametric")]
		private void FromTransformToParametricCoM()
		{
			if (centerOfMassTransform != null)
			{
				VehicleFrame vehicleFrame = ComputeVehicleFrame();
				Vector3 vector = base.transform.InverseTransformPoint(centerOfMassTransform.position);
				centerOfMassPosition = Mathf.InverseLerp(vehicleFrame.rearPosition, vehicleFrame.frontPosition, vector.z);
				centerOfMassHeightOffset = vector.y - vehicleFrame.baseHeight;
				centerOfMassMode = CenterOfMassMode.Parametric;
			}
		}
	}
}
