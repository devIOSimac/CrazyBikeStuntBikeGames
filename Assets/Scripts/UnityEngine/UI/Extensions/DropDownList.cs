using UnityEngine;
using System.Collections.Generic;

namespace UnityEngine.UI.Extensions
{
	public class DropDownList : MonoBehaviour
	{
		public Color disabledTextColor;
		public List<DropDownListItem> Items;
		[SerializeField]
		private float _scrollBarWidth;
		[SerializeField]
		private int _itemsToDisplay;
	}
}
