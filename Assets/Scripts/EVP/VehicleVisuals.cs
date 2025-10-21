using UnityEngine;

namespace EVP
{
	[RequireComponent(typeof(VehicleController))]
	public class VehicleVisuals : MonoBehaviour
	{
		[Header("Steering wheel")]
		public Transform steeringWheel;

		public float degreesOfRotation = 420f;

		private VehicleController m_vehicle;

		private void OnEnable()
		{
			m_vehicle = GetComponent<VehicleController>();
		}

		private void Update()
		{
			if (steeringWheel != null)
			{
				Vector3 localEulerAngles = steeringWheel.localEulerAngles;
				localEulerAngles.z = -0.5f * degreesOfRotation * m_vehicle.steerAngle / m_vehicle.maxSteerAngle;
				steeringWheel.localEulerAngles = localEulerAngles;
			}
		}
	}
}
