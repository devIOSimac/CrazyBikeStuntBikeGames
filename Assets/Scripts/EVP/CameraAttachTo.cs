using System;
using UnityEngine;

namespace EVP
{
	[Serializable]
	public class CameraAttachTo : CameraMode
	{
		public Transform attachTarget;

		public override void SetViewConfig(VehicleViewConfig viewConfig)
		{
			attachTarget = viewConfig.driverView;
		}

		public override void Update(Transform self, Transform target, Vector3 targetOffset)
		{
			if (attachTarget != null)
			{
				target = attachTarget;
			}
			if (!(target == null))
			{
				self.position = target.position;
				self.rotation = target.rotation;
			}
		}
	}
}
