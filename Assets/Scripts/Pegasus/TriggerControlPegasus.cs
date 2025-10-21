using UnityEngine;

namespace Pegasus
{
	public class TriggerControlPegasus : TriggerBase
	{
		public PegasusConstants.PoiPegasusTriggerAction m_actionOnStart;

		public PegasusConstants.PoiPegasusTriggerAction m_actionOnEnd = PegasusConstants.PoiPegasusTriggerAction.StopPegasus;

		public PegasusManager m_pegasus;

		public bool m_disabled;

		public bool m_disableAfterActioned = true;

		public override void OnStart(PegasusPoi poi)
		{
			if (poi == null)
			{
				UnityEngine.Debug.LogWarning($"Poi was not supplied on {base.name} - exiting");
			}
			else if (m_pegasus == null)
			{
				UnityEngine.Debug.LogWarning($"Pegasus was not supplied on {base.name} - exiting");
			}
			else
			{
				if (m_disabled || !m_triggerAtStart)
				{
					return;
				}
				switch (m_actionOnStart)
				{
				case PegasusConstants.PoiPegasusTriggerAction.PlayPegasus:
					if (poi.m_manager.m_displayDebug)
					{
						UnityEngine.Debug.Log($"Started flythrough on {poi.m_manager.name} from {poi.name}");
					}
					if (poi.m_manager.m_target != null && m_pegasus.m_target != null && poi.m_manager.m_target.GetInstanceID() == m_pegasus.m_target.GetInstanceID())
					{
						poi.m_manager.StopFlythrough();
					}
					if (m_pegasus.m_currentState == PegasusConstants.FlythroughState.Paused)
					{
						m_pegasus.ResumeFlythrough();
					}
					else
					{
						m_pegasus.StartFlythrough();
					}
					if (m_disableAfterActioned)
					{
						m_disabled = true;
					}
					break;
				case PegasusConstants.PoiPegasusTriggerAction.PausePegasus:
					if (poi.m_manager.m_displayDebug)
					{
						UnityEngine.Debug.Log($"Pausing flythrough on {poi.m_manager.name} from {poi.name}");
					}
					m_pegasus.PauseFlythrough();
					if (m_disableAfterActioned)
					{
						m_disabled = true;
					}
					break;
				case PegasusConstants.PoiPegasusTriggerAction.ResumePegasus:
					if (poi.m_manager.m_displayDebug)
					{
						UnityEngine.Debug.Log($"Resuming flythrough on {poi.m_manager.name} from {poi.name}");
					}
					m_pegasus.ResumeFlythrough();
					if (m_disableAfterActioned)
					{
						m_disabled = true;
					}
					break;
				case PegasusConstants.PoiPegasusTriggerAction.StopPegasus:
					if (poi.m_manager.m_displayDebug)
					{
						UnityEngine.Debug.Log($"Stopping flythrough on {poi.m_manager.name} from {poi.name}");
					}
					m_pegasus.StopFlythrough();
					if (m_disableAfterActioned)
					{
						m_disabled = true;
					}
					break;
				case PegasusConstants.PoiPegasusTriggerAction.DoNothing:
					if (poi.m_manager.m_displayDebug)
					{
						UnityEngine.Debug.Log($"Doing nothing on {poi.m_manager.name} from {poi.name}");
					}
					break;
				}
			}
		}

		public override void OnEnd(PegasusPoi poi)
		{
			if (poi == null)
			{
				UnityEngine.Debug.LogWarning($"Poi was not supplied on {base.name} - exiting");
			}
			else if (m_pegasus == null)
			{
				UnityEngine.Debug.LogWarning($"Pegasus was not supplied on {base.name} - exiting");
			}
			else
			{
				if (m_disabled || !m_triggerAtEnd)
				{
					return;
				}
				switch (m_actionOnEnd)
				{
				case PegasusConstants.PoiPegasusTriggerAction.PlayPegasus:
					if (poi.m_manager.m_displayDebug)
					{
						UnityEngine.Debug.Log($"Started flythrough on {poi.m_manager.name} from {poi.name}");
					}
					poi.m_manager.StopFlythrough();
					if (m_pegasus.m_currentState == PegasusConstants.FlythroughState.Paused)
					{
						m_pegasus.ResumeFlythrough();
					}
					else
					{
						m_pegasus.StartFlythrough();
					}
					if (m_disableAfterActioned)
					{
						m_disabled = true;
					}
					break;
				case PegasusConstants.PoiPegasusTriggerAction.PausePegasus:
					if (poi.m_manager.m_displayDebug)
					{
						UnityEngine.Debug.Log($"Pausing flythrough on {poi.m_manager.name} from {poi.name}");
					}
					m_pegasus.PauseFlythrough();
					if (m_disableAfterActioned)
					{
						m_disabled = true;
					}
					break;
				case PegasusConstants.PoiPegasusTriggerAction.ResumePegasus:
					if (poi.m_manager.m_displayDebug)
					{
						UnityEngine.Debug.Log($"Resuming flythrough on {poi.m_manager.name} from {poi.name}");
					}
					m_pegasus.ResumeFlythrough();
					if (m_disableAfterActioned)
					{
						m_disabled = true;
					}
					break;
				case PegasusConstants.PoiPegasusTriggerAction.StopPegasus:
					if (poi.m_manager.m_displayDebug)
					{
						UnityEngine.Debug.Log($"Stopping flythrough on {poi.m_manager.name} from {poi.name}");
					}
					m_pegasus.StopFlythrough();
					if (m_disableAfterActioned)
					{
						m_disabled = true;
					}
					break;
				case PegasusConstants.PoiPegasusTriggerAction.DoNothing:
					if (poi.m_manager.m_displayDebug)
					{
						UnityEngine.Debug.Log($"Doing nothing on {poi.m_manager.name} from {poi.name}");
					}
					break;
				}
			}
		}
	}
}
