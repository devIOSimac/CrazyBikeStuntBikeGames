using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class MainMenuScript : MonoBehaviour
{
	public enum MainMenuState
	{
		PlayScreen,
		SettingsScreen,
		ModeSelectionScreen,
		LevelSelectionScreen,
		VehicleSelectionScreen,
		LoadingScreen
	}

	[Header("Ads stuff")]
	private const int ON = 0;

	private const int OFF = 1;

	[Header("Ads Panels")]
	public GameObject noInternetConnection;

	public GameObject rewardFailedCanvas;

	public GameObject rewardUnavailibleCanvas;

	[Header("InApp Messages")]
	public GameObject ClaimCashMessage;

	public GameObject ClaimBikeMessage;

	[Header("Sound Clips")]
	public AudioClip click;

	public AudioClip bgMusic;

	public AudioSource musicSource;

	public AudioSource clickSource;

	[Header("Links")]
	public string bundleID;

	public string developerAccountID;

	public string instagramLink;

	public string twitterLink;

	private int soundStatus;

	private int musicStatus;

	[Header("Main Menu State")]
	public MainMenuState currentState;

	[Header("Canvas Elements")]
	public GameObject playScreenCanvas;

	public GameObject settingsScreenCanvas;

	public GameObject ModeSelectionCanvas;

	public GameObject levelScreenCanvas;

	public GameObject vehicleSelectionCanvas;

	public GameObject loadingScrenCanvas;

	public GameObject adCashCanvas;

	public GameObject grantedcanvas;

	[Header("Settings Panel")]
	public GameObject[] soundOnOff;

	public GameObject[] musicOnOff;

	public Slider qualitySlider;

	[Header("Levels Panel")]
	public Text levelSelectionText;

	public Text levelNumberText;

	public int selectedLevel;

	public GameObject freeRoamLevelSelectionPanel;

	public Text cashText;

	[Header("Vehicles Panel")]
	public GameObject[] vehicles;

	public string[] vehicleNames;

	public string[] handling;

	public string[] topSpeed;

	public string[] acceleration;

	public Text topSpeedPlaceHolder;

	public Text accelerationPlaceHolder;

	public Text handlingPlaceHolder;

	public Text vehicleNameText;

	private int vehicleCounter;

	public string[] vehiclePrices;

	public Text vehiclePricePlaceHolder;

	public Text cashPlaceHolder;

	public Text cashPlaceHolder2;

	public GameObject buyButton;

	public GameObject displayMessageText;

	public string lessCashMessage;

	public string selectVehicleMessage;

	public int CurCash;

	public Text AdCashText;

	public bool AdHasFinished;

	public Material[] mats;

	private Material tempMat;

	public Image[] PaintButtons;

	[Header("Loading Screen")]
	public Texture truck;

	public Texture blackBG;

	public Texture blueBG;

	[Header("In-App Buttons")]
	public GameObject RemoveAds;

	public GameObject Premium;

	public GameObject RestoreAds;

	public GameObject UnlockLevels;

	public GameObject UnlockLevels2;

	public GameObject UnlockCars;

	public GameObject UnlockCars2;

	public GameObject LevelSelectCash;

	private bool LevelsUnlockPurchased;

	public GameObject UnlockLevelsBtn;

	public GameObject UnlockLevelsBtn2;

	public GameObject UnlockBikesBtn;

	public GameObject UnlockBikesBtn2;

	public GameObject RemoveAdsBtn;

	public GameObject PremiumBtn;

	private bool unlockCarOnce = true;

	private bool unlockLevelOnce = true;

	public Text levelSelectedText;

	private AsyncOperation loadingProgress;

	private float counter;

	[Header("Level Selection Images ")]
	public Image[] levelSelectionImages;

	private IEnumerator showProgress()
	{
		while (!loadingProgress.isDone)
		{
			if (counter < 60f)
			{
				counter += 0.5f;
			}
			else if (counter < 80f)
			{
				counter += 0.05f;
			}
			else if (counter < 100f)
			{
				counter += 0.01f;
			}
			yield return null;
		}
		counter = 100f;
	}

	public void playScreenOptions(int option)
	{
		buttonClick();
		switch (option)
		{
		case 0:
			Application.Quit();
			break;
		case 1:
			currentState = MainMenuState.ModeSelectionScreen;
			playScreenCanvas.SetActive(value: false);
			ModeSelectionCanvas.SetActive(value: true);
			break;
		case 2:
			currentState = MainMenuState.SettingsScreen;
			playScreenCanvas.SetActive(value: false);
			settingsScreenCanvas.SetActive(value: true);
			soundOnOff[soundStatus].SetActive(value: true);
			musicOnOff[musicStatus].SetActive(value: true);
			break;
		case 3:
			Application.OpenURL("https://play.google.com/store/apps/developer?id=TW+Games+Studios");
			break;
		case 4:
			Application.OpenURL("https://www.facebook.com/sharer/sharer.php?u=https://play.google.com/store/apps/details?id=com.TopWinGames.RealStuntBikeRaceMotoMasterGame");
			break;
		case 5:
			Application.OpenURL("https://web.facebook.com/TWGamesStudio/?_rdc=1&_rdr");
			break;
		case 6:
			Application.OpenURL(string.Empty);
			break;
		case 7:
			Application.OpenURL(string.Empty);
			break;
		case 8:
			Application.OpenURL("https://play.google.com/store/apps/details?id=com.TopWinGames.RealStuntBikeRaceMotoMasterGame");
			break;
		default:
			UnityEngine.Debug.Log("Invalid argument in Play Screen Dialogue");
			break;
		}
	}

	public void settingsScreenOptions(int option)
	{
		switch (option)
		{
		case 0:
			settingsScreenCanvas.SetActive(value: false);
			currentState = MainMenuState.PlayScreen;
			playScreenCanvas.SetActive(value: true);
			break;
		case 1:
			if (PlayerPrefs.GetInt("Sound") == 0)
			{
				PlayerPrefs.SetInt("Sound", 1);
				soundStatus = 1;
				soundOnOff[1].SetActive(value: true);
			}
			else
			{
				PlayerPrefs.SetInt("Sound", 0);
				soundStatus = 0;
				soundOnOff[1].SetActive(value: false);
			}
			break;
		case 2:
			if (PlayerPrefs.GetInt("Music") == 0)
			{
				PlayerPrefs.SetInt("Music", 1);
				musicStatus = 1;
				musicOnOff[1].SetActive(value: true);
				musicSource.Stop();
			}
			else
			{
				PlayerPrefs.SetInt("Music", 0);
				musicStatus = 0;
				musicOnOff[1].SetActive(value: false);
				musicSource.Play();
			}
			break;
		}
	}

	public void modeSelectionScreenOptions(int option)
	{
		buttonClick();
		switch (option)
		{
		case 4:
			break;
		case 0:
			currentState = MainMenuState.PlayScreen;
			ModeSelectionCanvas.SetActive(value: false);
			playScreenCanvas.SetActive(value: true);
			break;
		case 1:
			if (PlayerPrefs.GetInt("mode") == 1)
			{
				updateVehicle(0);
				updateCashOptions(0);
				currentState = MainMenuState.VehicleSelectionScreen;
				vehicleSelectionCanvas.SetActive(value: true);
				ModeSelectionCanvas.SetActive(value: false);
			}
			else
			{
				currentState = MainMenuState.LevelSelectionScreen;
				ModeSelectionCanvas.SetActive(value: false);
				cashText.text = PlayerPrefs.GetInt("Cash").ToString();
				levelScreenCanvas.SetActive(value: true);
			}
			break;
		case 2:
			PlayerPrefs.SetInt("mode", 0);
			UnityEngine.Debug.Log(PlayerPrefs.GetInt("mode") + "Amateur Mode");
			currentState = MainMenuState.LevelSelectionScreen;
			updateLevels();
			ModeSelectionCanvas.SetActive(value: false);
			cashText.text = PlayerPrefs.GetInt("Cash").ToString();
			levelScreenCanvas.SetActive(value: true);
			break;
		case 3:
			PlayerPrefs.SetInt("mode", 1);
			UnityEngine.Debug.Log(PlayerPrefs.GetInt("mode"));
			updateVehicle(0);
			updateCashOptions(0);
			currentState = MainMenuState.VehicleSelectionScreen;
			vehicleSelectionCanvas.SetActive(value: true);
			ModeSelectionCanvas.SetActive(value: false);
			updateLevels();
			break;
		default:
			UnityEngine.Debug.Log("default selected");
			break;
		}
	}

	public void levelScreenOption(int option)
	{
		buttonClick();
		switch (option)
		{
		case 0:
			currentState = MainMenuState.ModeSelectionScreen;
			levelScreenCanvas.SetActive(value: false);
			ModeSelectionCanvas.SetActive(value: true);
			break;
		case 1:
			if (PlayerPrefs.GetInt("mode") == 1)
			{
				PlayerPrefs.SetInt("LoadLevel", 21);
			}
			else
			{
				PlayerPrefs.SetInt("LoadLevel", selectedLevel + 1);
			}
			currentState = MainMenuState.VehicleSelectionScreen;
			levelScreenCanvas.SetActive(value: false);
			vehicleSelectionCanvas.SetActive(value: true);
			updateVehicle(0);
			updateCashOptions(0);
			break;
		default:
			UnityEngine.Debug.Log("Invalid entry in level screen options");
			break;
		}
	}

	public void carSelectionOptions(int option)
	{
		buttonClick();
		switch (option)
		{
		case 0:
			if (PlayerPrefs.GetInt("mode") == 1)
			{
				currentState = MainMenuState.ModeSelectionScreen;
				vehicleSelectionCanvas.SetActive(value: false);
				ModeSelectionCanvas.SetActive(value: true);
			}
			else
			{
				currentState = MainMenuState.LevelSelectionScreen;
				vehicleSelectionCanvas.SetActive(value: false);
				levelScreenCanvas.SetActive(value: true);
			}
			break;
		case 1:
			if (PlayerPrefs.GetInt("Vehicle " + vehicleCounter.ToString()) == 1)
			{
				currentState = MainMenuState.LoadingScreen;
				vehicleSelectionCanvas.SetActive(value: false);
				loadingScrenCanvas.SetActive(value: true);
				PlayerPrefs.SetInt("SelectedVehicle", vehicleCounter);
				if (PlayerPrefs.GetInt("mode") == 1)
				{
					loadingProgress = Application.LoadLevelAsync(21);
					StartCoroutine(showProgress());
				}
				else
				{
					loadingProgress = Application.LoadLevelAsync(PlayerPrefs.GetInt("LoadLevel"));
					StartCoroutine(showProgress());
				}
			}
			else
			{
				displayMessageText.SetActive(value: true);
				displayMessageText.GetComponentInChildren<Text>().text = selectVehicleMessage;
			}
			break;
		case 2:
		{
			UnityEngine.Debug.Log(vehicleCounter);
			int num;
			if (vehicleCounter == 0)
			{
				vehicleCounter = vehicles.Length - 1;
				num = 0;
			}
			else
			{
				vehicleCounter--;
				num = vehicleCounter + 1;
			}
			vehicles[num].SetActive(value: false);
			vehicles[vehicleCounter].SetActive(value: true);
			updateVehicle(vehicleCounter);
			updateCashOptions(vehicleCounter);
			break;
		}
		case 3:
		{
			UnityEngine.Debug.Log(vehicleCounter);
			int num2;
			if (vehicleCounter == vehicles.Length - 1)
			{
				vehicleCounter = 0;
				num2 = vehicles.Length - 1;
			}
			else
			{
				vehicleCounter++;
				num2 = vehicleCounter - 1;
			}
			vehicles[num2].SetActive(value: false);
			vehicles[vehicleCounter].SetActive(value: true);
			updateVehicle(vehicleCounter);
			updateCashOptions(vehicleCounter);
			break;
		}
		case 4:
			if (PlayerPrefs.GetInt("Cash") >= int.Parse(vehiclePrices[vehicleCounter]))
			{
				PlayerPrefs.SetInt("Vehicle " + vehicleCounter.ToString(), 1);
				PlayerPrefs.SetInt("Cash", PlayerPrefs.GetInt("Cash") - int.Parse(vehiclePrices[vehicleCounter]));
				updateCashOptions(vehicleCounter);
			}
			else
			{
				displayMessageText.SetActive(value: true);
				displayMessageText.GetComponentInChildren<Text>().text = lessCashMessage;
				Invoke("BuyMessageDestroy", 10f);
			}
			break;
		default:
			UnityEngine.Debug.Log("Invalid argument in Level Selection Screen Dialogue");
			break;
		}
	}

	private void updateLevels()
	{
	}

	private void updateSelectedLevel(int level)
	{
		levelSelectionImages[0].gameObject.SetActive(value: false);
		levelSelectionImages[1].gameObject.SetActive(value: false);
		levelSelectionImages[2].gameObject.SetActive(value: false);
		if ((level + 1) % 3 == 0)
		{
			levelSelectionImages[2].gameObject.SetActive(value: true);
		}
		else if ((level + 1) % 3 != 0 && (level + 1) % 2 == 0)
		{
			levelSelectionImages[1].gameObject.SetActive(value: true);
		}
		else
		{
			levelSelectionImages[0].gameObject.SetActive(value: true);
		}
	}

	private void updateCashOptions(int veh)
	{
		vehiclePricePlaceHolder.text = vehiclePrices[veh];
		cashPlaceHolder.text = PlayerPrefs.GetInt("Cash").ToString();
		cashPlaceHolder2.text = PlayerPrefs.GetInt("Cash").ToString();
		if (PlayerPrefs.GetInt("Vehicle " + veh.ToString()) == 0)
		{
			buyButton.SetActive(value: true);
			Image[] paintButtons = PaintButtons;
			foreach (Image image in paintButtons)
			{
				image.gameObject.SetActive(value: false);
			}
		}
		else
		{
			buyButton.SetActive(value: false);
			tempMat = mats[veh];
			for (int j = 0; j < PaintButtons.Length; j++)
			{
				PaintButtons[j].color = vehicles[veh].GetComponent<ColorOptions>().TheColors[j];
				PaintButtons[j].gameObject.SetActive(value: true);
			}
		}
	}

	private void updateVehicle(int veh)
	{
		vehicleNameText.text = vehicleNames[veh];
		topSpeedPlaceHolder.text = topSpeed[veh];
		accelerationPlaceHolder.text = acceleration[veh];
		handlingPlaceHolder.text = handling[veh];
	}

	private void buttonClick()
	{
		clickSource.PlayOneShot(click);
	}

	private void GameStateUpdate(MainMenuState state)
	{
		switch (state)
		{
		case MainMenuState.PlayScreen:
			playScreenCanvas.SetActive(value: true);
			settingsScreenCanvas.SetActive(value: false);
			ModeSelectionCanvas.SetActive(value: false);
			levelScreenCanvas.SetActive(value: false);
			vehicleSelectionCanvas.SetActive(value: false);
			loadingScrenCanvas.SetActive(value: false);
			break;
		case MainMenuState.SettingsScreen:
			playScreenCanvas.SetActive(value: false);
			settingsScreenCanvas.SetActive(value: true);
			ModeSelectionCanvas.SetActive(value: false);
			levelScreenCanvas.SetActive(value: false);
			vehicleSelectionCanvas.SetActive(value: false);
			loadingScrenCanvas.SetActive(value: false);
			break;
		case MainMenuState.ModeSelectionScreen:
			playScreenCanvas.SetActive(value: false);
			settingsScreenCanvas.SetActive(value: false);
			ModeSelectionCanvas.SetActive(value: true);
			levelScreenCanvas.SetActive(value: false);
			vehicleSelectionCanvas.SetActive(value: false);
			loadingScrenCanvas.SetActive(value: false);
			break;
		case MainMenuState.LevelSelectionScreen:
			playScreenCanvas.SetActive(value: false);
			settingsScreenCanvas.SetActive(value: false);
			ModeSelectionCanvas.SetActive(value: false);
			levelScreenCanvas.SetActive(value: true);
			vehicleSelectionCanvas.SetActive(value: false);
			loadingScrenCanvas.SetActive(value: false);
			break;
		case MainMenuState.VehicleSelectionScreen:
			playScreenCanvas.SetActive(value: false);
			settingsScreenCanvas.SetActive(value: false);
			ModeSelectionCanvas.SetActive(value: false);
			levelScreenCanvas.SetActive(value: false);
			vehicleSelectionCanvas.SetActive(value: true);
			loadingScrenCanvas.SetActive(value: false);
			break;
		case MainMenuState.LoadingScreen:
			playScreenCanvas.SetActive(value: false);
			settingsScreenCanvas.SetActive(value: false);
			ModeSelectionCanvas.SetActive(value: false);
			levelScreenCanvas.SetActive(value: false);
			vehicleSelectionCanvas.SetActive(value: false);
			loadingScrenCanvas.SetActive(value: true);
			break;
		default:
			UnityEngine.Debug.Log("Error in GameStateUpdate Method!!!");
			break;
		}
	}

	public void selectLevel(int clickedLevel)
	{
		buttonClick();
		selectedLevel = clickedLevel;
		updateSelectedLevel(selectedLevel);
		if (PlayerPrefs.GetInt("mode") == 1)
		{
			PlayerPrefs.SetInt("LoadLevel", 21);
		}
		else
		{
			PlayerPrefs.SetInt("LoadLevel", selectedLevel + 1);
		}
		currentState = MainMenuState.VehicleSelectionScreen;
		levelScreenCanvas.SetActive(value: false);
		vehicleSelectionCanvas.SetActive(value: true);
		updateVehicle(0);
		updateCashOptions(0);
	}

	public void NetworkBackButton()
	{
		adCashCanvas.SetActive(value: false);
		currentState = MainMenuState.VehicleSelectionScreen;
		vehicleSelectionCanvas.SetActive(value: true);
	}

	public void BuyMessageDestroy()
	{
		displayMessageText.SetActive(value: false);
	}

	public void SkinChange(int _color)
	{
		tempMat.color = PaintButtons[_color].color;
	}

	private void MenuAd()
	{
		if (InternetStatus() && PlayerPrefs.GetInt("adsRemoved") != 1 && PlayerPrefs.GetInt("Premium") != 1)
		{
			PlayerPrefs.SetInt("adss_clear", 1);
			MonoBehaviour.print("Ads should be dispayed");
		}
	}

	public void ClaimCash()
	{
		PlayerPrefs.SetInt("ClaimCashGranted", 1);
	}

	public void ClaimBike()
	{
		PlayerPrefs.SetInt("ClaimBikeGranted", 1);
	}

	private void Start()
	{
		if (PlayerPrefs.GetInt("ClaimCashGranted") != 1)
		{
			ClaimCashMessage.SetActive(value: true);
		}
		else
		{
			ClaimCashMessage.SetActive(value: false);
		}
		if (PlayerPrefs.GetInt("ClaimBikeGranted") != 1)
		{
			ClaimBikeMessage.SetActive(value: true);
		}
		else
		{
			ClaimBikeMessage.SetActive(value: false);
		}
		unlockLevelOnce = false;
		Time.timeScale = 1f;
		currentState = MainMenuState.PlayScreen;
		vehicleCounter = 0;
		AudioListener.volume = 1f;
		if (!PlayerPrefs.HasKey("SecondTime"))
		{
			PlayerPrefs.SetInt("SecondTime", 1);
			PlayerPrefs.SetInt("Vehicle 0", 1);
			PlayerPrefs.SetInt("Sound", 0);
			PlayerPrefs.SetInt("Music", 0);
			PlayerPrefs.SetFloat("qualityValue", 0.5f);
			if (!PlayerPrefs.HasKey("LevelsClearedAmature"))
			{
				PlayerPrefs.SetInt("LevelsClearedAmature", 1);
				PlayerPrefs.SetInt("LevelsClearedPro", 1);
			}
			soundStatus = 0;
			musicStatus = 0;
			if (!PlayerPrefs.HasKey("Cash"))
			{
				PlayerPrefs.SetInt("Cash", 2000);
			}
		}
		else
		{
			soundStatus = PlayerPrefs.GetInt("Sound");
			musicStatus = PlayerPrefs.GetInt("Music");
		}
		musicSource.clip = bgMusic;
		if (musicStatus == 0)
		{
			musicSource.Play();
			musicSource.loop = true;
		}
		else
		{
			UnityEngine.Debug.Log("Music is off");
		}
		cashPlaceHolder.text = PlayerPrefs.GetInt("Cash").ToString();
		cashPlaceHolder2.text = PlayerPrefs.GetInt("Cash").ToString();
	}

	private void OnGUI()
	{
		MainMenuState mainMenuState = currentState;
		if (mainMenuState == MainMenuState.LoadingScreen)
		{
			float num = counter;
			GUI.DrawTexture(new Rect(0f, (float)Screen.height * 0.9f, num / 100f * (float)Screen.width, (float)Screen.height * 0.1f), blueBG);
		}
	}

	private void Awake()
	{
	}

	private void Update()
	{
		if (PlayerPrefs.GetInt("DoubleScoreApproved") == 1)
		{
			PlayerPrefs.SetInt("Cash", PlayerPrefs.GetInt("Cash") + 1000);
			cashPlaceHolder.text = PlayerPrefs.GetInt("Cash").ToString();
			PlayerPrefs.SetInt("DoubleScoreApproved", 0);
		}
		if (PlayerPrefs.GetInt("adsRemoved") == 1 || PlayerPrefs.GetInt("Premium") == 1)
		{
			RemoveAds.SetActive(value: false);
			RemoveAdsBtn.GetComponent<Button>().interactable = false;
		}
		if (PlayerPrefs.GetInt("Premium") == 1)
		{
			Premium.SetActive(value: false);
			RestoreAds.SetActive(value: false);
			RemoveAds.SetActive(value: false);
			UnlockCars.SetActive(value: false);
			UnlockCars2.SetActive(value: false);
			UnlockLevels.SetActive(value: false);
			UnlockLevels2.SetActive(value: false);
			PremiumBtn.GetComponent<Button>().interactable = false;
		}
		if (PlayerPrefs.GetInt("CarsUnlocked") == 1 || PlayerPrefs.GetInt("Premium") == 1)
		{
			UnlockBikesBtn.GetComponent<Button>().interactable = false;
			UnlockBikesBtn2.GetComponent<Button>().interactable = false;
			unlockLevelOnce = true;
			UnlockCars.SetActive(value: false);
			UnlockCars2.SetActive(value: false);
			if (PlayerPrefs.GetInt("CarsUnlocked") == 1 || PlayerPrefs.GetInt("Premium") == 1)
			{
				unlockCarOnce = false;
				for (int i = 0; i < vehicles.Length; i++)
				{
					PlayerPrefs.SetInt("Vehicle " + i.ToString(), 1);
					buyButton.SetActive(value: false);
				}
			}
		}
		if (PlayerPrefs.GetInt("levelUnlocked") == 1 || PlayerPrefs.GetInt("Premium") == 1)
		{
			UnlockLevelsBtn.GetComponent<Button>().interactable = false;
			UnlockLevelsBtn2.GetComponent<Button>().interactable = false;
			UnlockLevels.SetActive(value: false);
			UnlockLevels2.SetActive(value: false);
		}
		switch (currentState)
		{
		case MainMenuState.ModeSelectionScreen:
			break;
		case MainMenuState.PlayScreen:
			GameStateUpdate(MainMenuState.PlayScreen);
			if (UnityEngine.Input.GetKeyDown(KeyCode.Escape))
			{
				Application.Quit();
			}
			break;
		case MainMenuState.SettingsScreen:
			GameStateUpdate(MainMenuState.SettingsScreen);
			if (UnityEngine.Input.GetKeyDown(KeyCode.Escape))
			{
				settingsScreenCanvas.SetActive(value: false);
				currentState = MainMenuState.PlayScreen;
				playScreenCanvas.SetActive(value: true);
			}
			break;
		case MainMenuState.LevelSelectionScreen:
			GameStateUpdate(MainMenuState.LevelSelectionScreen);
			if (UnityEngine.Input.GetKeyDown(KeyCode.Escape))
			{
				levelScreenCanvas.SetActive(value: false);
				currentState = MainMenuState.PlayScreen;
				playScreenCanvas.SetActive(value: true);
			}
			break;
		case MainMenuState.VehicleSelectionScreen:
			GameStateUpdate(MainMenuState.VehicleSelectionScreen);
			if (UnityEngine.Input.GetKeyDown(KeyCode.Escape))
			{
				vehicleSelectionCanvas.SetActive(value: false);
				currentState = MainMenuState.LevelSelectionScreen;
				levelScreenCanvas.SetActive(value: true);
			}
			break;
		case MainMenuState.LoadingScreen:
			GameStateUpdate(MainMenuState.LoadingScreen);
			break;
		}
	}

	public void RateUs()
	{
	}

	public void purchasePremium()
	{
		PlayerPrefs.SetInt("Premium", 1);
	}

	public void purchaseRemoveAds()
	{
		PlayerPrefs.SetInt("adsRemoved", 1);
	}

	public void purchaseUnlockLevels()
	{
		PlayerPrefs.SetInt("levelUnlocked", 1);
	}

	public void purchaseUnlockCars()
	{
		PlayerPrefs.SetInt("CarsUnlocked", 1);
	}

	public void restoreRemoveAds()
	{
	}

	public static bool InternetStatus()
	{
		if (Application.internetReachability != 0)
		{
			return true;
		}
		return false;
	}

	public void FreeCash()
	{
		if (InternetStatus())
		{
			PlayerPrefs.SetInt("adss_rewardVideo", 1);
			PlayerPrefs.SetInt("DoubleScoreNeeded", 1);
		}
		else
		{
			UnityEngine.Debug.Log("No Internet Coonnection");
			noInternetConnection.SetActive(value: true);
			Invoke("OffInternetStatus", 2f);
		}
	}

	public void OffInternetStatus()
	{
		noInternetConnection.SetActive(value: false);
		rewardFailedCanvas.SetActive(value: false);
		rewardUnavailibleCanvas.SetActive(value: false);
		grantedcanvas.SetActive(value: false);
	}

	public void RewardFailed()
	{
		if (rewardUnavailibleCanvas.activeSelf)
		{
			rewardUnavailibleCanvas.SetActive(value: false);
		}
		rewardFailedCanvas.SetActive(value: true);
		Invoke("OffInternetStatus", 2f);
	}

	public void RewardUnavailibe()
	{
		if (rewardFailedCanvas.activeSelf)
		{
			rewardFailedCanvas.SetActive(value: false);
		}
		rewardUnavailibleCanvas.SetActive(value: true);
		Invoke("OffInternetStatus", 2f);
	}
}
