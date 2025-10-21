using UnityEngine;
using UnityEngine.Playables;

namespace Pegasus
{
	public class PegasusMixerBehaviour : PlayableBehaviour
	{
		public override void ProcessFrame(Playable playable, FrameData info, object playerData)
		{
			int inputCount = playable.GetInputCount();
			float num = 0f;
			float num2 = 0f;
			PegasusManager pegasusManager = null;
			for (int i = 0; i < inputCount; i++)
			{
				float inputWeight = playable.GetInputWeight(i);
				PegasusBehaviour behaviour = ((ScriptPlayable<PegasusBehaviour>)playable.GetInput(i)).GetBehaviour();
				if (pegasusManager == null)
				{
					pegasusManager = behaviour.pegasusManager;
				}
				num += behaviour.pegasusProgress * inputWeight;
				num2 += inputWeight;
			}
			if (!Mathf.Approximately(num2, 0f) && pegasusManager != null)
			{
				pegasusManager.MoveTargetTo(num);
			}
		}
	}
}
