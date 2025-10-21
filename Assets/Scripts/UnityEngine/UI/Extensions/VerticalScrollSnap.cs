using UnityEngine;

namespace UnityEngine.UI.Extensions
{
	public class VerticalScrollSnap : MonoBehaviour
	{
		public GameObject Pagination;
		public GameObject NextButton;
		public GameObject PrevButton;
		public float transitionSpeed;
		public bool UseFastSwipe;
		public int FastSwipeThreshold;
		[SerializeField]
		private int _currentScreen;
		public int StartingScreen;
		public int PageStep;
	}
}
