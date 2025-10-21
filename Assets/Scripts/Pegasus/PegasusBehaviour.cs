using System;
using UnityEngine;
using UnityEngine.Playables;

namespace Pegasus
{
	[Serializable]
	public class PegasusBehaviour : PlayableBehaviour
	{
		[HideInInspector]
		public PegasusManager pegasusManager;

		[HideInInspector]
		public float pegasusProgress;
	}
}
