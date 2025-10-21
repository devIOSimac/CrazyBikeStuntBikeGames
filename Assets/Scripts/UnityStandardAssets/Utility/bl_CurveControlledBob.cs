using System;
using UnityEngine;

namespace UnityStandardAssets.Utility
{
	[Serializable]
	public class bl_CurveControlledBob
	{
		public float HorizontalBobRange;
		public float VerticalBobRange;
		public AnimationCurve Bobcurve;
		public float VerticaltoHorizontalRatio;
	}
}
