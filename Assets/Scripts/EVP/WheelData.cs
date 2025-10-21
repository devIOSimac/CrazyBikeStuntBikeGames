using UnityEngine;

namespace EVP
{
	public class WheelData
	{
		public Wheel wheel;

		public WheelCollider collider;

		public Transform transform;

		public Vector3 origin;

		public float forceDistance;

		public float steerAngle;

		public bool grounded;

		public WheelHit hit;

		public GroundMaterial groundMaterial;

		public float suspensionCompression;

		public float downforce;

		public Vector3 velocity = Vector3.zero;

		public Vector2 localVelocity = Vector2.zero;

		public Vector2 localRigForce = Vector2.zero;

		public bool isBraking;

		public float finalInput;

		public Vector2 tireSlip = Vector2.zero;

		public Vector2 tireForce = Vector2.zero;

		public Vector2 dragForce = Vector2.zero;

		public float angularVelocity;

		public float angularPosition;

		public PhysicMaterial lastPhysicMaterial = new PhysicMaterial();

		public RaycastHit rayHit;

		public float positionRatio;

		public bool isWheelChildOfCaliper;

		public float combinedTireSlip;

		public float downforceRatio;
	}
}
