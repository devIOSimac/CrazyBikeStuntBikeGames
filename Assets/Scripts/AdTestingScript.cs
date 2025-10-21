using UnityEngine;

public class AdTestingScript : MonoBehaviour
{
	private void Start()
	{
		PlayerPrefs.SetInt("adss_gameover", 0);
		PlayerPrefs.SetInt("adss_pause", 0);
		PlayerPrefs.SetInt("adss_clear", 0);
		PlayerPrefs.SetInt("adss_rewardVideo", 0);
		PlayerPrefs.SetInt("adss_HeyzapInter", 0);
		PlayerPrefs.SetInt("adss_HeyzapVedio", 0);
	}

	public void Unity()
	{
		PlayerPrefs.SetInt("adss_gameover", 1);
	}

	public void UnityReward()
	{
		PlayerPrefs.SetInt("adss_rewardVideo", 1);
	}

	public void Chartboost()
	{
		PlayerPrefs.SetInt("adss_pause", 1);
	}

	public void Admob()
	{
		PlayerPrefs.SetInt("adss_clear", 1);
	}

	public void HeyzapInter()
	{
		PlayerPrefs.SetInt("adss_HeyzapInter", 1);
	}

	public void HeyzapVideo()
	{
		PlayerPrefs.SetInt("adss_HeyzapVedio", 1);
	}

	public void NextScene()
	{
		UnityEngine.SceneManagement.SceneManager.LoadScene(1);
	}
}
