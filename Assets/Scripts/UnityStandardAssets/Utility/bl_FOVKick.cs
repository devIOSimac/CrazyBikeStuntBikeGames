using System;
using UnityEngine;

namespace UnityStandardAssets.Utility
{
	[Serializable]
	public class bl_FOVKick
	{
		public Camera Camera;
		public float originalFov;
		public float FOVIncrease;
		public float TimeToIncrease;
		public float TimeToDecrease;
		public AnimationCurve IncreaseCurve;
	}
}
