using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Pegasus
{
	public class TriggerControlAnimation : TriggerBase
	{
		public Animation m_targetAnimation;

		public PegasusConstants.PoiAnimationTriggerAction m_actionOnStart;

		public PegasusConstants.PoiAnimationTriggerAction m_actionOnEnd = PegasusConstants.PoiAnimationTriggerAction.DoNothing;

		public int m_startAnimationIdx;

		public int m_endAnimation;

		private List<AnimationState> m_animations = new List<AnimationState>();

		private void Start()
		{
			if (m_targetAnimation != null)
			{
				IEnumerator enumerator = m_targetAnimation.GetEnumerator();
				try
				{
					while (enumerator.MoveNext())
					{
						AnimationState item = (AnimationState)enumerator.Current;
						m_animations.Add(item);
					}
				}
				finally
				{
					IDisposable disposable;
					if ((disposable = (enumerator as IDisposable)) != null)
					{
						disposable.Dispose();
					}
				}
			}
		}

		public override void OnStart(PegasusPoi poi)
		{
			if (poi == null)
			{
				UnityEngine.Debug.LogWarning($"Poi was not supplied on {base.name} - exiting");
			}
			else if (m_targetAnimation == null)
			{
				UnityEngine.Debug.LogWarning($"Animation was not supplied on {base.name} - exiting");
			}
			else if (m_triggerAtStart)
			{
				if (m_actionOnStart == PegasusConstants.PoiAnimationTriggerAction.PlayAnimation)
				{
					m_targetAnimation.Play(m_animations[m_startAnimationIdx].name);
				}
				else if (m_actionOnStart == PegasusConstants.PoiAnimationTriggerAction.StopAnimation)
				{
					m_targetAnimation.Stop();
				}
			}
		}

		public override void OnEnd(PegasusPoi poi)
		{
			if (poi == null)
			{
				UnityEngine.Debug.LogWarning($"Poi was not supplied on {base.name} - exiting");
			}
			else if (m_targetAnimation == null)
			{
				UnityEngine.Debug.LogWarning($"Animation was not supplied on {base.name} - exiting");
			}
			else if (m_triggerAtEnd)
			{
				if (m_actionOnStart == PegasusConstants.PoiAnimationTriggerAction.PlayAnimation)
				{
					m_targetAnimation.Play(m_animations[m_startAnimationIdx].name);
				}
				else if (m_actionOnStart == PegasusConstants.PoiAnimationTriggerAction.StopAnimation)
				{
					m_targetAnimation.Stop();
				}
			}
		}
	}
}
