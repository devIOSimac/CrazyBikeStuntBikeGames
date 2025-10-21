using UnityEngine.UI;
using UnityEngine;

namespace UnityEngine.UI.Extensions
{
	public class ImageExtended : MaskableGraphic
	{
		public enum Type
		{
			Simple = 0,
			Sliced = 1,
			Tiled = 2,
			Filled = 3,
		}

		public enum FillMethod
		{
			Horizontal = 0,
			Vertical = 1,
			Radial90 = 2,
			Radial180 = 3,
			Radial360 = 4,
		}

		public enum Rotate
		{
			Rotate0 = 0,
			Rotate90 = 1,
			Rotate180 = 2,
			Rotate270 = 3,
		}

		[SerializeField]
		private Sprite m_Sprite;
		[SerializeField]
		private Type m_Type;
		[SerializeField]
		private bool m_PreserveAspect;
		[SerializeField]
		private bool m_FillCenter;
		[SerializeField]
		private FillMethod m_FillMethod;
		[SerializeField]
		private float m_FillAmount;
		[SerializeField]
		private bool m_FillClockwise;
		[SerializeField]
		private int m_FillOrigin;
		[SerializeField]
		private Rotate m_Rotate;
	}
}
