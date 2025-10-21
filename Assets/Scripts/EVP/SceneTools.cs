using UnityEngine;
using UnityEngine.SceneManagement;

namespace EVP
{
	public class SceneTools : MonoBehaviour
	{
		public bool slowTimeMode;

		public float slowTime = 0.3f;

		public KeyCode hotkeyReset = KeyCode.R;

		public KeyCode hotkeyTime = KeyCode.T;

		private void Start()
		{
		}

		private void Update()
		{
			if (UnityEngine.Input.GetKeyDown(hotkeyReset))
			{
				SceneManager.LoadScene(0, LoadSceneMode.Single);
			}
			if (UnityEngine.Input.GetKeyDown(hotkeyTime))
			{
				slowTimeMode = !slowTimeMode;
			}
			Time.timeScale = ((!slowTimeMode) ? 1f : slowTime);
		}
	}
}
