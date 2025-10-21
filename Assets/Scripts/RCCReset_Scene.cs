using UnityEngine;

public class RCCReset_Scene : MonoBehaviour
{
	private void Start()
	{
	}

	private void Update()
	{
		if (UnityEngine.Input.GetKeyUp(KeyCode.R))
		{
			UnityEngine.SceneManagement.SceneManager.LoadScene(UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex);
		}
	}
}
