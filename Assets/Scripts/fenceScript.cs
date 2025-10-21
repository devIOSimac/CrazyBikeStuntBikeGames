using UnityEngine;

public class fenceScript : MonoBehaviour
{
	private GameControllerScript gameManager;

	private GameObject gameController;

	private void Start()
	{
		Invoke("gettingPlayer", 5f);
	}

	private void gettingPlayer()
	{
		gameController = GameObject.FindGameObjectWithTag("GameController");
		gameManager = gameController.GetComponent<GameControllerScript>();
	}

	private void Update()
	{
	}

	private void OnCollisionEnter(Collision other)
	{
		if (PlayerPrefs.GetInt("mode") == 1 && other.gameObject.CompareTag("Player"))
		{
			UnityEngine.Debug.Log("Collision took place");
			gameManager.gameOver();
		}
	}
}
