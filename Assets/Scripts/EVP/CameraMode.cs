using UnityEngine;

namespace EVP
{
	public class CameraMode
	{
		public virtual void SetViewConfig(VehicleViewConfig viewConfig)
		{
		}

		public virtual void Initialize(Transform self)
		{
		}

		public virtual void OnEnable(Transform self, Transform target, Vector3 targetOffset)
		{
		}

		public virtual void Reset(Transform self, Transform target, Vector3 targetOffset)
		{
		}

		public virtual void Update(Transform self, Transform target, Vector3 targetOffset)
		{
		}

		public virtual void OnDisable(Transform self, Transform target, Vector3 targetOffset)
		{
		}

		public static float GetInputForAxis(string axisName)
		{
			return (!string.IsNullOrEmpty(axisName)) ? UnityEngine.Input.GetAxis(axisName) : 0f;
		}
	}
}
