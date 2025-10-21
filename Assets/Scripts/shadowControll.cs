using UnityEngine;

public class shadowControll : MonoBehaviour
{
	private GameObject truckShadow;

	private GameObject trailerShadow;

	private bool activateTrigger;

	private bool activateTrailerShadow;

	private void Start()
	{
		activateTrigger = false;
		Invoke("assignGameObjects", 2f);
	}

	private void assignGameObjects()
	{
		truckShadow = GameObject.FindGameObjectWithTag("truckShadow");
		if (UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 1 && UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 2 && UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 5 && UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 7 && UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 9)
		{
			trailerShadow = GameObject.FindGameObjectWithTag("trailerShadow");
		}
		activateTrigger = true;
	}

	private void Update()
	{
	}

	private void OnTriggerEnter(Collider other)
	{
		if (activateTrigger && other.gameObject.CompareTag("cityRoad"))
		{
			truckShadow.SetActive(value: true);
			if (UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 1 && UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 2 && UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 5 && UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 7 && UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 9)
			{
				trailerShadow.SetActive(value: true);
			}
		}
	}

	private void OnTriggerExit(Collider other)
	{
		if (other.gameObject.CompareTag("cityRoad"))
		{
			truckShadow.SetActive(value: false);
			if (UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 1 && UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 2 && UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 5 && UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 7 && UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 9)
			{
				trailerShadow.SetActive(value: false);
			}
		}
	}
}
