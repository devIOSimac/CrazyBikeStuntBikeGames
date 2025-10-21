using UnityEngine;

public class truckflip : MonoBehaviour
{
	private float resetTime;

	private GameControllerScript gameManager;

	private GameObject gameController;

	private GameObject player;

	private bool playerRotationCheckActivate;

	private void Start()
	{
		playerRotationCheckActivate = false;
		Invoke("instantiation", 10f);
	}

	private void instantiation()
	{
		resetTime = 0f;
		gameController = GameObject.FindGameObjectWithTag("GameController");
		player = GameObject.FindGameObjectWithTag("Player");
		gameManager = gameController.GetComponent<GameControllerScript>();
		playerRotationCheckActivate = true;
	}

	private void Update()
	{
		if (PlayerPrefs.GetInt("mode") != 1 || !playerRotationCheckActivate)
		{
			return;
		}
		Vector3 eulerAngles = player.transform.eulerAngles;
		if (eulerAngles.z < 300f)
		{
			Vector3 eulerAngles2 = player.transform.eulerAngles;
			if (eulerAngles2.z > 60f)
			{
				resetTime += Time.deltaTime;
				if (resetTime > 4f)
				{
					UnityEngine.Debug.Log("level fail due to rotation");
				}
			}
		}
		Vector3 eulerAngles3 = player.transform.eulerAngles;
		if (!(eulerAngles3.x < 300f))
		{
			return;
		}
		Vector3 eulerAngles4 = player.transform.eulerAngles;
		if (eulerAngles4.x > 60f)
		{
			resetTime += Time.deltaTime;
			if (resetTime > 4f)
			{
				UnityEngine.Debug.Log("level fail due to rotation");
			}
		}
	}
}
