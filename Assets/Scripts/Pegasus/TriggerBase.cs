using UnityEngine;

namespace Pegasus
{
	public class TriggerBase : MonoBehaviour
	{
		public bool m_triggerAtStart = true;

		public bool m_triggerOnUpdate;

		public bool m_triggerAtEnd = true;

		public virtual void OnStart(PegasusPoi poi)
		{
			if (poi != null && m_triggerAtStart && poi.m_manager.m_displayDebug)
			{
				UnityEngine.Debug.Log($"Started trigger on {poi.m_manager.name} - {poi.name}");
			}
		}

		public virtual void OnUpdate(PegasusPoi poi, float progress)
		{
			if (poi != null && m_triggerOnUpdate && poi.m_manager.m_displayDebug)
			{
				UnityEngine.Debug.Log($"Udpated trigger on {poi.m_manager.name} - {poi.name} {progress:0.00}");
			}
		}

		public virtual void OnEnd(PegasusPoi poi)
		{
			if (poi != null && m_triggerAtEnd && poi.m_manager.m_displayDebug)
			{
				UnityEngine.Debug.Log($"Ended trigger on {poi.m_manager.name} - {poi.name}");
			}
		}
	}
}
