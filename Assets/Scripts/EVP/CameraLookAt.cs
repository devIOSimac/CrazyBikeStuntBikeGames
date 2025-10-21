using System;
using UnityEngine;

namespace EVP
{
	[Serializable]
	public class CameraLookAt : CameraMode
	{
		public float damping = 6f;

		[Space(5f)]
		public float minFov = 10f;

		public float maxFov = 60f;

		public float fovSpeed = 20f;

		public float fovDamping = 4f;

		public bool autoFov;

		public string fovAxis = "Mouse ScrollWheel";

		[Space(5f)]
		public bool enableMovement;

		public float movementSpeed = 2f;

		public float movementDamping = 5f;

		public string forwardAxis = string.Empty;

		public string sidewaysAxis = string.Empty;

		public string verticalAxis = string.Empty;

		private Camera m_camera;

		private Vector3 m_position;

		private float m_fov;

		private float m_savedFov;

		public override void Initialize(Transform self)
		{
			m_camera = self.GetComponentInChildren<Camera>();
		}

		public override void OnEnable(Transform self, Transform target, Vector3 targetOffset)
		{
			m_position = self.position;
			if (m_camera != null)
			{
				m_fov = m_camera.fieldOfView;
				m_savedFov = m_camera.fieldOfView;
			}
		}

		public override void Update(Transform self, Transform target, Vector3 targetOffset)
		{
			if (enableMovement)
			{
				float num = movementSpeed * Time.deltaTime;
				Vector3 position = m_position;
				float d = CameraMode.GetInputForAxis(forwardAxis) * num;
				Vector3 forward = self.forward;
				float x = forward.x;
				Vector3 forward2 = self.forward;
				Vector3 vector = new Vector3(x, 0f, forward2.z);
				m_position = position + d * vector.normalized;
				m_position += CameraMode.GetInputForAxis(sidewaysAxis) * num * self.right;
				m_position += CameraMode.GetInputForAxis(verticalAxis) * num * self.up;
			}
			self.position = Vector3.Lerp(self.position, m_position, movementDamping * Time.deltaTime);
			if (target != null)
			{
				Quaternion b = Quaternion.LookRotation(target.position + targetOffset - self.position);
				self.rotation = Quaternion.Slerp(self.rotation, b, damping * Time.deltaTime);
			}
			if (m_camera != null)
			{
				m_fov -= CameraMode.GetInputForAxis(fovAxis) * fovSpeed;
				m_fov = Mathf.Clamp(m_fov, minFov, maxFov);
				m_camera.fieldOfView = Mathf.Lerp(m_camera.fieldOfView, m_fov, fovDamping * Time.deltaTime);
			}
		}

		public override void OnDisable(Transform self, Transform target, Vector3 targetOffset)
		{
			if (m_camera != null)
			{
				m_camera.fieldOfView = m_savedFov;
			}
		}
	}
}
