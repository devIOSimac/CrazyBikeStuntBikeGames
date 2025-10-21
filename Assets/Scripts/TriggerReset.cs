using UnityEngine;

public class TriggerReset : MonoBehaviour
{
	public carReset resetScript;

	private bool limit;

	public GameObject ResetRewardCanvas;

	private void Start()
	{
		limit = true;
	}

	public void OnTriggerEnter(Collider other)
	{
		if (PlayerPrefs.GetInt("BikeRest") > 0)
		{
			limit = true;
			if (other.gameObject.CompareTag("Player"))
			{
				MonoBehaviour.print("Reset Activated");
				BikeAnimation.crashesCount++;
				resetScript.ResetCar();
			}
		}
		else if (PlayerPrefs.GetInt("BikeRest") == 0 && limit)
		{
			Time.timeScale = 0f;
			ResetRewardCanvas.SetActive(value: true);
			limit = false;
		}
	}

	private void Update()
	{
	}

	public void ResetRewardVedio()
	{
		PlayerPrefs.SetInt("adss_rewardVideo", 1);
		PlayerPrefs.SetInt("ResetNeeded", 1);
	}
}
