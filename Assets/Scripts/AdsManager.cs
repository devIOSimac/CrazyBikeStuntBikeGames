using UnityEngine;

public class AdsManager : Singleton<AdsManager>
{
	public enum AdCompany
	{
		AdmobInter = 0,
		UnityVideo = 1,
		UnityRewardVideo = 2,
	}

	public AdCompany pauseAd;
	public AdCompany gameOverAd;
	public AdCompany levelClearAd;
	public AdCompany rewardVideo;
	public GameObject NoAdsAvailable;
}
