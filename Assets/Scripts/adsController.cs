using UnityEngine;

public class adsController : MonoBehaviour
{
	private void Start()
	{
	}

	private void Update()
	{
	}

	public void pauseAd()
	{
		PlayerPrefs.SetInt("adss_pause", 1);
	}

	public void levelClear()
	{
		PlayerPrefs.SetInt("adss_clear", 1);
	}

	public void gameOver()
	{
		PlayerPrefs.SetInt("adss_gameover", 1);
	}

	public void rewardVideo()
	{
		PlayerPrefs.SetInt("adss_rewardVideo", 1);
	}
}
