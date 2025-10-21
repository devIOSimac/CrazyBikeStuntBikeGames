using UnityEngine;

namespace UnityEngine.UI.Extensions
{
	public class SoftMaskScript : MonoBehaviour
	{
		public RectTransform MaskArea;
		public RectTransform maskScalingRect;
		public Texture AlphaMask;
		public float CutOff;
		public bool HardBlend;
		public bool FlipAlphaMask;
		public bool DontClipMaskScalingRect;
		public bool CascadeToALLChildren;
	}
}
