using UnityEngine;

public class carOnTransporter : MonoBehaviour
{
	private GameObject player;

	private GameControllerScript gameManager;

	private GameObject gameController;

	private void Start()
	{
		Invoke("afterPlayerInstantiate", 2f);
	}

	private void afterPlayerInstantiate()
	{
		gameController = GameObject.FindGameObjectWithTag("GameController");
		gameManager = gameController.GetComponent<GameControllerScript>();
		player = GameObject.FindGameObjectWithTag("Player");
	}

	private void Update()
	{
	}

	private void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.CompareTag("transporterCube"))
		{
			gameManager.gameOver();
			UnityEngine.Debug.Log("Not on Trailer");
		}
	}
}
