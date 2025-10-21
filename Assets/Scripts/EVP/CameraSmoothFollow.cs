using System;
using UnityEngine;

namespace EVP
{
	[Serializable]
	public class CameraSmoothFollow : CameraMode
	{
		public float distance = 10f;

		public float height = 5f;

		public float viewHeightRatio = 0.5f;

		[Space(5f)]
		public float heightDamping = 2f;

		public float rotationDamping = 3f;

		[Space(5f)]
		public bool followVelocity = true;

		public float velocityDamping = 5f;

		private Vector3 m_smoothLastPos = Vector3.zero;

		private Vector3 m_smoothVelocity = Vector3.zero;

		private float m_smoothTargetAngle;

		public override void SetViewConfig(VehicleViewConfig viewConfig)
		{
			distance = viewConfig.viewDistance;
			height = viewConfig.viewHeight;
			rotationDamping = viewConfig.viewDamping;
		}

		public override void Reset(Transform self, Transform target, Vector3 targetOffset)
		{
			if (!(target == null))
			{
				m_smoothLastPos = target.position + targetOffset;
				m_smoothVelocity = target.forward * 2f;
				Vector3 eulerAngles = target.eulerAngles;
				m_smoothTargetAngle = eulerAngles.y;
			}
		}

		public override void Update(Transform self, Transform target, Vector3 targetOffset)
		{
			if (!(target == null))
			{
				Vector3 b = (target.position + targetOffset - m_smoothLastPos) / Time.deltaTime;
				m_smoothLastPos = target.position + targetOffset;
				b.y = 0f;
				if (b.magnitude > 1f)
				{
					m_smoothVelocity = Vector3.Lerp(m_smoothVelocity, b, velocityDamping * Time.deltaTime);
					m_smoothTargetAngle = Mathf.Atan2(m_smoothVelocity.x, m_smoothVelocity.z) * 57.29578f;
				}
				if (!followVelocity)
				{
					Vector3 eulerAngles = target.eulerAngles;
					m_smoothTargetAngle = eulerAngles.y;
				}
				Vector3 position = target.position;
				float b2 = position.y + targetOffset.y + height;
				Vector3 eulerAngles2 = self.eulerAngles;
				float y = eulerAngles2.y;
				Vector3 position2 = self.position;
				float y2 = position2.y;
				y = Mathf.LerpAngle(y, m_smoothTargetAngle, rotationDamping * Time.deltaTime);
				y2 = Mathf.Lerp(y2, b2, heightDamping * Time.deltaTime);
				Quaternion rotation = Quaternion.Euler(0f, y, 0f);
				self.position = target.position + targetOffset;
				self.position -= rotation * Vector3.forward * distance;
				Vector3 position3 = self.position;
				position3.y = y2;
				self.position = position3;
				self.LookAt(target.position + targetOffset + Vector3.up * height * viewHeightRatio);
			}
		}
	}
}
