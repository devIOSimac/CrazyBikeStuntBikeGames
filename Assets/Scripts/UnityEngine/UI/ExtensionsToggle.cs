using System;
using UnityEngine.Events;
using UnityEngine;

namespace UnityEngine.UI
{
	public class ExtensionsToggle : Selectable
	{
		[Serializable]
		public class ToggleEvent : UnityEvent<bool>
		{
		}

		public enum ToggleTransition
		{
			None = 0,
			Fade = 1,
		}

		public ToggleTransition toggleTransition;
		public Graphic graphic;
		[SerializeField]
		private ExtensionsToggleGroup m_Group;
		public ToggleEvent onValueChanged;
		[SerializeField]
		private bool m_IsOn;
	}
}
