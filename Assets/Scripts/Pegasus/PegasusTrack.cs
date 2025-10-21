using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Pegasus
{
	[TrackColor(0.09f, 0.45f, 0.8f)]
	[TrackMediaType(TimelineAsset.MediaType.Script)]
	[TrackClipType(typeof(PegasusClip))]
	public class PegasusTrack : TrackAsset
	{
		public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
		{
			foreach (TimelineClip clip in GetClips())
			{
				PegasusClip pegasusClip = (PegasusClip)clip.asset;
				PegasusManager pegasusManager = pegasusClip.PegasusManager.Resolve(graph.GetResolver());
				clip.displayName = ((!(pegasusManager == null)) ? pegasusManager.name : "Pegasus");
			}
			ScriptPlayable<PegasusMixerBehaviour> playable = ScriptPlayable<PegasusMixerBehaviour>.Create(graph);
			playable.SetInputCount(inputCount);
			return playable;
		}
	}
}
