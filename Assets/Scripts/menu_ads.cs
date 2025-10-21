//using GoogleMobileAds.Api;
//using UnityEngine;
//using UnityEngine.Advertisements;

//public class menu_ads : Singleton<menu_ads>
//{
//	public enum AdCompany
//	{
//		AdmobInter,
//		UnityVideo,
//		none
//	}

//	[Header("AD IDS")]
//	public string AdmobInterstitial = string.Empty;

//	public string AdmobBanner = string.Empty;

//	public string UnityAdsId = string.Empty;

//	public bool showBanner;

//	public AdCompany menuAd;

//	private BannerView bannerView;

//	private InterstitialAd interstitial;

//	private static bool displayedOnce;

//	[HideInInspector]
//	private static int adNumber;

//	private static AdsManager instance;

//	private void Start()
//	{
//		PlayerPrefs.SetString("Inter", AdmobInterstitial);
//		PlayerPrefs.SetString("Banner", AdmobBanner);
//		displayedOnce = false;
//		if (instance == null)
//		{
//			instance = base.gameObject.GetComponent<AdsManager>();
//			if (UnityAdsId != null && UnityAdsId.Length >= 5 && Advertisement.isSupported)
//			{
//				Advertisement.Initialize(UnityAdsId);
//			}
//		}
//		RequestBanner();
//		RequestInterstitial();
//		PlayerPrefs.SetInt("adss_gameover", 0);
//		PlayerPrefs.SetInt("adss_pause", 0);
//		PlayerPrefs.SetInt("adss_clear", 0);
//	}

//	private void Update()
//	{
//		if (showBanner)
//		{
//			bannerView.Show();
//		}
//		if (displayedOnce)
//		{
//			return;
//		}
//		switch (menuAd)
//		{
//		case AdCompany.none:
//			break;
//		case AdCompany.AdmobInter:
//			if (!loadAdmobInterstitial() && ShowUnityADS())
//			{
//			}
//			break;
//		case AdCompany.UnityVideo:
//			if (!ShowUnityADS() && loadAdmobInterstitial())
//			{
//			}
//			break;
//		default:
//			UnityEngine.Debug.Log("Error");
//			break;
//		}
//	}

//	private void RequestBanner()
//	{
//		bannerView = new BannerView(AdmobBanner, AdSize.SmartBanner, AdPosition.Top);
//		AdRequest request = new AdRequest.Builder().Build();
//		bannerView.LoadAd(request);
//	}

//	private void RequestInterstitial()
//	{
//		interstitial = new InterstitialAd(AdmobInterstitial);
//		AdRequest request = new AdRequest.Builder().Build();
//		interstitial.LoadAd(request);
//	}

//	private bool loadAdmobInterstitial()
//	{
//		if (interstitial.IsLoaded())
//		{
//			interstitial.Show();
//			displayedOnce = true;
//			return true;
//		}
//		return false;
//	}

//	public bool ShowUnityADS()
//	{
//		if (Advertisement.IsReady())
//		{
//			Advertisement.Show(null, new ShowOptions
//			{
//				resultCallback = delegate(ShowResult result)
//				{
//					switch (result)
//					{
//					}
//				}
//			});
//			displayedOnce = true;
//			return true;
//		}
//		return false;
//	}

//	public void rewardThePlayer(bool b)
//	{
//	}
//}
