using System;
using UnityEngine;

namespace EVP
{
	[Serializable]
	public class CameraMouseOrbit : CameraMode
	{
		public float distance = 10f;

		[Space(5f)]
		public float minVerticalAngle = -20f;

		public float maxVerticalAngle = 80f;

		public float horizontalSpeed = 5f;

		public float verticalSpeed = 2.5f;

		public float orbitDamping = 4f;

		[Space(5f)]
		public float minDistance = 5f;

		public float maxDistance = 50f;

		public float distanceSpeed = 10f;

		public float distanceDamping = 4f;

		[Space(5f)]
		public string horizontalAxis = "Mouse X";

		public string verticalAxis = "Mouse Y";

		public string distanceAxis = "Mouse ScrollWheel";

		private float m_orbitX;

		private float m_orbitY;

		private float m_orbitDistance;

		public override void SetViewConfig(VehicleViewConfig viewConfig)
		{
			distance = viewConfig.viewDistance;
			minDistance = viewConfig.viewMinDistance;
			minVerticalAngle = viewConfig.viewMinHeight;
		}

		public override void Initialize(Transform self)
		{
			m_orbitDistance = distance;
			Vector3 eulerAngles = self.eulerAngles;
			m_orbitX = eulerAngles.y;
			m_orbitY = eulerAngles.x;
		}

		public override void Update(Transform self, Transform target, Vector3 targetOffset)
		{
			if (!(target == null))
			{
				m_orbitX += CameraMode.GetInputForAxis(horizontalAxis) * horizontalSpeed;
				m_orbitY -= CameraMode.GetInputForAxis(verticalAxis) * verticalSpeed;
				distance -= CameraMode.GetInputForAxis(distanceAxis) * distanceSpeed;
				m_orbitY = Mathf.Clamp(m_orbitY, minVerticalAngle, maxVerticalAngle);
				distance = Mathf.Clamp(distance, minDistance, maxDistance);
				m_orbitDistance = Mathf.Lerp(m_orbitDistance, distance, distanceDamping * Time.deltaTime);
				self.rotation = Quaternion.Slerp(self.rotation, Quaternion.Euler(m_orbitY, m_orbitX, 0f), orbitDamping * Time.deltaTime);
				self.position = target.position + targetOffset + self.rotation * new Vector3(0f, 0f, 0f - m_orbitDistance);
			}
		}
	}
}
