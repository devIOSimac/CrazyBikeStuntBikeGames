using UnityEngine;

public class CheckinAdPackage : MonoBehaviour
{
	private void Start()
	{
		PlayerPrefs.SetInt("adss_gameover", 0);
		PlayerPrefs.SetInt("adss_pause", 0);
		PlayerPrefs.SetInt("adss_clear", 0);
		PlayerPrefs.SetInt("adss_rewardVideo", 0);
		PlayerPrefs.SetInt("adss_AdColonyReward", 0);
	}

	private void Update()
	{
	}

	public void ShowUnityAd()
	{
		PlayerPrefs.SetInt("adss_gameover", 1);
	}

	public void ShowUnityRewardAd()
	{
		PlayerPrefs.SetInt("adss_rewardVideo", 1);
	}

	public void ShowChartboost()
	{
		PlayerPrefs.SetInt("adss_clear", 1);
	}

	public void ShowHeyzapInter()
	{
	}

	public void ShowHeyzapVedio()
	{
	}

	public void ShowAdColony()
	{
		PlayerPrefs.SetInt("adss_AdColonyReward", 1);
	}

	public void AdmobAd()
	{
		PlayerPrefs.SetInt("adss_pause", 1);
	}
}
