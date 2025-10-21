using DG.Tweening;
using UnityEngine;
using UnityEngine.UI;

public class raceResults : MonoBehaviour
{
	private bool playerReached;

	private bool opponentReached;

	public Text WiningText;

	public Text FailureText;

	public DOTweenAnimation WiningTextAnim;

	public DOTweenAnimation FailureTextAnim;

	private GameControllerScript _gameManager;

	private void Start()
	{
		playerReached = false;
		opponentReached = false;
		_gameManager = UnityEngine.Object.FindObjectOfType<GameControllerScript>();
	}

	private void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.CompareTag("Player"))
		{
			playerReached = true;
			if (!opponentReached)
			{
				WiningText.GetComponent<Text>().enabled = true;
				WiningTextAnim.DOPlay();
				Invoke("CallLevelClear", 3f);
			}
		}
		else if (other.gameObject.CompareTag("Opponent"))
		{
			opponentReached = true;
			if (!playerReached)
			{
				FailureText.GetComponent<Text>().enabled = true;
				FailureTextAnim.DOPlay();
				Invoke("CallLevelFailed", 3f);
			}
		}
	}

	private void CallLevelClear()
	{
		_gameManager.LevelClear();
		WiningText.GetComponent<Text>().enabled = false;
	}

	private void CallLevelFailed()
	{
		_gameManager.gameOver();
		FailureText.GetComponent<Text>().enabled = false;
	}
}
