using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class GameControllerScript : MonoBehaviour
{
	public enum GameState
	{
		isObjective,
		isControlSelection,
		isGamePlay,
		isPause,
		isLevelClear,
		isGameOver,
		isLoading
	}

	[Header("Quality Elements")]
	public int ModeNumber;

	public int LevelNumber;

	[Header("Ads stuff")]
	private int[] gameTimer = new int[38]
	{
		10,
		180,
		180,
		180,
		210,
		240,
		240,
		240,
		240,
		240,
		240,
		100,
		120,
		140,
		180,
		180,
		240,
		240,
		240,
		240,
		240,
		1200,
		90,
		80,
		80,
		60,
		40,
		80,
		80,
		230,
		200,
		40,
		80,
		80,
		230,
		200,
		1200,
		1200
	};

	public static float presentLevelTimer;

	private int mins;

	private int secs;

	public int DemoVeh;

	private string levelTime;

	private float gameScore;

	[Header("Ads Panels")]
	public GameObject noInternetConnection;

	public GameObject rewardFailedCanvas;

	public GameObject rewardUnavailibleCanvas;

	public GameObject Crash_ResetPanel;

	[HideInInspector]
	public GameState currentState;

	public GameObject playerRef;

	private LightController playerLights;

	[Header("Player Vehicles")]
	public GameObject[] truckArray;

	public bool isTrailer;

	[Header("Level Elements")]
	public Transform instPoint;

	public Transform DestinationPoint;

	public GameObject cameraObj;

	public GameObject shadow;

	public GameObject trailerShadow;

	public int cutSceneSubsTime;

	public GameObject rewardbutton;

	public GameObject NoInternetConnection;

	public GameObject beforeENVPanel;

	public FinalDestination1 DestinationScript;

	[Header("Canvas Elements")]
	public GameObject[] controls;

	public GameObject[] objectiveElements;

	public GameObject objectiveDialogue;

	public GameObject controlDialogue;

	public GameObject gameplayDialogue;

	public GameObject pauseDialogue;

	public GameObject levelClearDialogue;

	public GameObject gameOverDialogue;

	public GameObject loadingDialogue;

	[Header("Time and Score")]
	public Text ResetChances;

	public Text gameTime;

	public Text gameScoreDisplay;

	public Text pauseGameTime;

	public Text levelClearTime;

	public Text gameOverTime;

	public Text pauseScore;

	public Text levelClearScore;

	public Text levelClearScore2;

	public Text gameOverScore;

	public Text Shadows;

	public Text gameoverSpeed;

	public Text gameoverTargetSpeed;

	public Text levelClearSpeed;

	public Text levelClearTargetSpeed;

	public GameObject winningText;

	[Header("Controls Canvas Elements")]
	public GameObject buttonControls;

	public GameObject steeringControls;

	public GameObject tiltControls;

	private int typeOfControl;

	[Header("Sound/Music")]
	public AudioSource bgMusic;

	public AudioClip winningSound;

	private AudioClip tempClip;

	[Header("Loading")]
	public GameObject loadingBG;

	public Texture truck;

	public Texture blackBG;

	public Texture blueBG;

	[Header("Bike GUI")]
	public Text speed;

	public Text gear;

	public Image needle;

	public Image bar;

	public int crashesThreshold;

	public GameObject lifeBar;

	public Image lifeBarFill;

	private AsyncOperation loadingProgress;

	private float counter;

	private IEnumerator showProgress()
	{
		loadingBG.SetActive(value: true);
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

	private void SetCamera()
	{
		cameraObj.GetComponent<BikeCamera>().target = playerRef.transform;
		cameraObj.GetComponent<BikeCamera>().BikerMan = playerRef.GetComponent<CameraSetPlayer>().PlayerBiker;
		cameraObj.GetComponent<BikeCamera>().cameraSwitchView[0] = playerRef.GetComponent<CameraSetPlayer>().View1;
		cameraObj.GetComponent<BikeCamera>().cameraSwitchView[1] = playerRef.GetComponent<CameraSetPlayer>().View2;
		cameraObj.GetComponent<BikeCamera>().cameraSwitchView[2] = playerRef.GetComponent<CameraSetPlayer>().View3;
	}

	private void SetControls()
	{
		switch (typeOfControl)
		{
		case 0:
			playerRef.GetComponent<BikeControl>().controlMode = ControlMode.simple;
			break;
		case 1:
			playerRef.GetComponent<BikeControl>().controlMode = ControlMode.tilt;
			break;
		}
	}

	private void Awake()
	{
		Application.LoadLevelAdditive("Environment");
	}

	private void Start()
	{
		PlayerPrefs.SetInt("BikeRest", 3);
		beforeENVPanel.SetActive(value: true);
		Invoke("OffBeforeENVPanel", 0.3f);
		PlayerPrefs.SetInt("Score", PlayerPrefs.GetInt("Cash"));
		InvokeRepeating("UpdateTime", 0f, 1f);
		Time.timeScale = 1f;
		if (UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex == 1)
		{
			Invoke("controlSelectionFunction", cutSceneSubsTime);
			currentState = GameState.isObjective;
		}
		else
		{
			controlSelectionFunction();
		}
		PlayerPrefs.SetInt("adss_gameover", 0);
		PlayerPrefs.SetInt("adss_pause", 0);
		PlayerPrefs.SetInt("adss_clear", 0);
		if (PlayerPrefs.GetInt("Music") == 1 && PlayerPrefs.GetInt("Sound") == 1)
		{
			AudioListener.volume = 0f;
		}
		else
		{
			AudioListener.volume = 1f;
		}
		if (PlayerPrefs.GetInt("Sound") == 0)
		{
			tempClip = bgMusic.clip;
			bgMusic.Play();
			bgMusic.loop = false;
		}
		if (PlayerPrefs.GetInt("mode") == 1)
		{
			presentLevelTimer = gameTimer[UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex + 15];
		}
		else if (PlayerPrefs.GetInt("mode") == 0)
		{
			presentLevelTimer = gameTimer[UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex];
		}
		else if (PlayerPrefs.GetInt("mode") == 2)
		{
			presentLevelTimer = 1200f;
		}
		instPlayer(PlayerPrefs.GetInt("SelectedVehicle"));
	}

	public void OffBeforeENVPanel()
	{
		beforeENVPanel.SetActive(value: false);
	}

	private void clearScreen()
	{
		currentState = GameState.isLevelClear;
		winningText.SetActive(value: false);
		PlayerPrefs.SetInt("Cash", PlayerPrefs.GetInt("Cash") + (UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex + 1) * 100 + Mathf.FloorToInt(gameScore));
		PlayerPrefs.SetInt("gamescore", (UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex + 1) * 100 + Mathf.FloorToInt(gameScore));
		levelClearScore.text = PlayerPrefs.GetInt("gamescore").ToString();
		levelClearScore2.text = PlayerPrefs.GetInt("Cash").ToString();
	}

	private void ToggleControlElements(int on)
	{
		if (on == 1)
		{
			switch (typeOfControl)
			{
			case 0:
			{
				buttonControls.SetActive(value: true);
				tiltControls.SetActive(value: false);
				steeringControls.SetActive(value: false);
				GameObject[] array2 = controls;
				foreach (GameObject gameObject2 in array2)
				{
					gameObject2.SetActive(value: true);
				}
				break;
			}
			case 1:
			{
				buttonControls.SetActive(value: false);
				tiltControls.SetActive(value: true);
				steeringControls.SetActive(value: false);
				GameObject[] array3 = controls;
				foreach (GameObject gameObject3 in array3)
				{
					gameObject3.SetActive(value: true);
				}
				break;
			}
			case 2:
			{
				steeringControls.SetActive(value: true);
				buttonControls.SetActive(value: false);
				tiltControls.SetActive(value: false);
				GameObject[] array = controls;
				foreach (GameObject gameObject in array)
				{
					gameObject.SetActive(value: true);
				}
				break;
			}
			default:
				UnityEngine.Debug.Log("Problem in the ShowControlElements Funtion");
				break;
			}
		}
		else
		{
			GameObject[] array4 = controls;
			foreach (GameObject gameObject4 in array4)
			{
				gameObject4.SetActive(value: false);
			}
			buttonControls.SetActive(value: false);
			tiltControls.SetActive(value: false);
		}
	}

	private void switchToPlayMode()
	{
		if (currentState == GameState.isControlSelection)
		{
			controlDialogue.SetActive(value: false);
			ToggleControlElements(1);
			currentState = GameState.isGamePlay;
			SetControls();
			Invoke("PlayMusic", 2f);
		}
	}

	private void OnGUI()
	{
		GameState gameState = currentState;
		if (gameState == GameState.isLoading)
		{
			float num = counter;
			GUI.DrawTexture(new Rect(0f, (float)Screen.height * 0.9f, num / 100f * (float)Screen.width, (float)Screen.height * 0.1f), blueBG);
		}
	}

	private void UpdateTime()
	{
		if (currentState == GameState.isGamePlay)
		{
			gameScoreDisplay.text = PlayerPrefs.GetInt("Score").ToString();
			gameTime.text = levelTime;
			presentLevelTimer -= 1f;
			if (presentLevelTimer <= 0f)
			{
				currentState = GameState.isGameOver;
				gameOver();
				gameOverDialogue.SetActive(value: true);
				ToggleControlElements(0);
			}
		}
	}

	private void PlayMusic()
	{
		if (PlayerPrefs.GetInt("Music") == 0)
		{
			bgMusic.clip = tempClip;
			bgMusic.Play();
			bgMusic.loop = true;
		}
	}

	private void instPlayer(int index)
	{
		playerRef = UnityEngine.Object.Instantiate(truckArray[index], instPoint.position, instPoint.rotation);
		playerLights = playerRef.GetComponent<LightController>();
		playerRef.GetComponent<BikeGUI>().GearText = gear;
		playerRef.GetComponent<BikeGUI>().speedText = speed;
		playerRef.GetComponent<BikeGUI>().tachometerNeedle = needle;
		playerRef.GetComponent<BikeGUI>().barShiftGUI = bar;
		if (isTrailer)
		{
			trailerShadow.GetComponent<FollowScript>().followObject(playerRef.transform.Find("Cargo_Box").Find("TrailerShadowPoint").transform, isTrailer: true);
			UnityEngine.Debug.Log("trailerAttached");
		}
		else if ((bool)trailerShadow)
		{
			trailerShadow.GetComponent<FollowScript>().followTransform = null;
		}
		cameraObj.SetActive(value: true);
		SetCamera();
	}

	private void SwitchStates()
	{
		switch (currentState)
		{
		case GameState.isObjective:
			objectiveDialogue.SetActive(value: true);
			controlDialogue.SetActive(value: false);
			gameplayDialogue.SetActive(value: false);
			pauseDialogue.SetActive(value: false);
			levelClearDialogue.SetActive(value: false);
			gameOverDialogue.SetActive(value: false);
			loadingDialogue.SetActive(value: false);
			break;
		case GameState.isControlSelection:
			objectiveDialogue.SetActive(value: false);
			controlDialogue.SetActive(value: true);
			gameplayDialogue.SetActive(value: false);
			pauseDialogue.SetActive(value: false);
			levelClearDialogue.SetActive(value: false);
			gameOverDialogue.SetActive(value: false);
			loadingDialogue.SetActive(value: false);
			break;
		case GameState.isGamePlay:
			objectiveDialogue.SetActive(value: false);
			controlDialogue.SetActive(value: false);
			gameplayDialogue.SetActive(value: true);
			pauseDialogue.SetActive(value: false);
			levelClearDialogue.SetActive(value: false);
			gameOverDialogue.SetActive(value: false);
			loadingDialogue.SetActive(value: false);
			if (UnityEngine.Input.GetKeyDown(KeyCode.Escape))
			{
				pauseGame();
			}
			break;
		case GameState.isPause:
			objectiveDialogue.SetActive(value: false);
			controlDialogue.SetActive(value: false);
			gameplayDialogue.SetActive(value: false);
			pauseDialogue.SetActive(value: true);
			levelClearDialogue.SetActive(value: false);
			gameOverDialogue.SetActive(value: false);
			loadingDialogue.SetActive(value: false);
			if (UnityEngine.Input.GetKeyDown(KeyCode.Escape))
			{
				pauseElements(2);
			}
			break;
		case GameState.isLevelClear:
			objectiveDialogue.SetActive(value: false);
			controlDialogue.SetActive(value: false);
			gameplayDialogue.SetActive(value: false);
			pauseDialogue.SetActive(value: false);
			levelClearDialogue.SetActive(value: true);
			gameOverDialogue.SetActive(value: false);
			loadingDialogue.SetActive(value: false);
			break;
		case GameState.isGameOver:
			objectiveDialogue.SetActive(value: false);
			controlDialogue.SetActive(value: false);
			gameplayDialogue.SetActive(value: false);
			pauseDialogue.SetActive(value: false);
			levelClearDialogue.SetActive(value: false);
			gameOverDialogue.SetActive(value: true);
			loadingDialogue.SetActive(value: false);
			break;
		case GameState.isLoading:
			objectiveDialogue.SetActive(value: false);
			controlDialogue.SetActive(value: false);
			gameplayDialogue.SetActive(value: false);
			pauseDialogue.SetActive(value: false);
			levelClearDialogue.SetActive(value: false);
			gameOverDialogue.SetActive(value: false);
			loadingDialogue.SetActive(value: true);
			break;
		}
	}

	public void pauseGame()
	{
		if (InternetStatus() && PlayerPrefs.GetInt("adsRemoved") != 1 && PlayerPrefs.GetInt("Premium") != 1)
		{
			PlayerPrefs.SetInt("adss_pause", 1);
		}
		pauseDialogue.SetActive(value: true);
		currentState = GameState.isPause;
		ToggleControlElements(0);
		Time.timeScale = 0f;
		AudioListener.volume = 0f;
		pauseGameTime.text = levelTime;
		pauseScore.text = PlayerPrefs.GetInt("Score").ToString();
	}

	public void gameOver()
	{
		if (InternetStatus() && PlayerPrefs.GetInt("adsRemoved") != 1 && PlayerPrefs.GetInt("Premium") != 1)
		{
			PlayerPrefs.SetInt("adss_gameover", 1);
		}
		currentState = GameState.isGameOver;
		Time.timeScale = 0f;
		bgMusic.clip = null;
		ToggleControlElements(0);
		gameOverDialogue.SetActive(value: true);
		gameOverTime.text = levelTime;
		PlayerPrefs.SetInt("Cash", PlayerPrefs.GetInt("Score"));
		gameOverScore.text = PlayerPrefs.GetInt("Score").ToString();
		if (UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex >= 16 || UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex <= 20)
		{
			gameoverSpeed.text = PlayerPrefs.GetInt("TotalSpeed").ToString();
			if (UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex == 6 || UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex == 7 || UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex == 8 || UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex == 9 || UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex == 10)
			{
				gameoverTargetSpeed.text = DestinationScript.TargteSpeed.ToString();
			}
		}
	}

	public void LevelClear()
	{
		if (InternetStatus() && PlayerPrefs.GetInt("adsRemoved") != 1 && PlayerPrefs.GetInt("Premium") != 1)
		{
			PlayerPrefs.SetInt("adss_clear", 1);
		}
		if (ModeNumber == 0)
		{
			PlayerPrefs.SetInt("Level_" + LevelNumber.ToString() + "_Stunts", 1);
		}
		if (ModeNumber == 1)
		{
			PlayerPrefs.SetInt("Level_" + LevelNumber.ToString() + "_CameraHigh", 1);
		}
		if (ModeNumber == 2)
		{
			PlayerPrefs.SetInt("Level_" + LevelNumber.ToString() + "_Campaign", 1);
		}
		if (ModeNumber == 3)
		{
			PlayerPrefs.SetInt("Level_" + LevelNumber.ToString() + "_Racing", 1);
		}
		if (PlayerPrefs.GetInt("Music") == 0)
		{
			bgMusic.clip = winningSound;
			bgMusic.loop = false;
			bgMusic.Play();
		}
		winningText.SetActive(value: true);
		ToggleControlElements(0);
		currentState = GameState.isLevelClear;
		levelClearTime.text = levelTime;
		Invoke("clearScreen", 2f);
		levelClearSpeed.text = PlayerPrefs.GetInt("TotalSpeed").ToString();
		if (UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex == 6 || UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex == 7 || UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex == 8 || UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex == 9 || UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex == 10)
		{
			levelClearTargetSpeed.text = DestinationScript.TargteSpeed.ToString();
		}
		if (UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 2 && UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 7 && UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 12 && UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 17)
		{
		}
	}

	public void controlSelectionFunction()
	{
		if (currentState == GameState.isObjective)
		{
			currentState = GameState.isControlSelection;
			GameObject[] array = objectiveElements;
			foreach (GameObject gameObject in array)
			{
				gameObject.SetActive(value: false);
			}
			controlDialogue.SetActive(value: true);
		}
	}

	public void pauseElements(int action)
	{
		switch (action)
		{
		case 0:
			currentState = GameState.isLoading;
			loadingProgress = Application.LoadLevelAsync(0);
			StartCoroutine(showProgress());
			break;
		case 1:
			currentState = GameState.isLoading;
			loadingProgress = Application.LoadLevelAsync(UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex);
			StartCoroutine(showProgress());
			break;
		case 2:
			Time.timeScale = 1f;
			currentState = GameState.isGamePlay;
			pauseDialogue.SetActive(value: false);
			ToggleControlElements(1);
			if (PlayerPrefs.GetInt("Sound") == 0)
			{
				AudioListener.volume = 1f;
			}
			break;
		}
	}

	public void levelClearMenu(int action)
	{
		switch (action)
		{
		case 0:
			currentState = GameState.isLoading;
			loadingProgress = Application.LoadLevelAsync(0);
			StartCoroutine(showProgress());
			break;
		case 1:
			currentState = GameState.isLoading;
			loadingProgress = Application.LoadLevelAsync(UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex);
			StartCoroutine(showProgress());
			break;
		case 2:
			currentState = GameState.isLoading;
			loadingProgress = Application.LoadLevelAsync(UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex + 1);
			StartCoroutine(showProgress());
			break;
		}
	}

	public void gameOverMenu(int action)
	{
		switch (action)
		{
		case 0:
			currentState = GameState.isLoading;
			loadingProgress = Application.LoadLevelAsync(0);
			StartCoroutine(showProgress());
			break;
		case 1:
			currentState = GameState.isLoading;
			loadingProgress = Application.LoadLevelAsync(UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex);
			StartCoroutine(showProgress());
			break;
		}
	}

	public void GameplayButtons(int action)
	{
		switch (action)
		{
		case 4:
			break;
		case 0:
			controlSelectionFunction();
			break;
		case 1:
			playerLights.leftIndOn();
			break;
		case 2:
			playerLights.rightIndOn();
			break;
		case 3:
			playerLights.doubleIndicators();
			break;
		}
	}

	public void playSound(int soundToPlay)
	{
		switch (soundToPlay)
		{
		case 0:
			playerLights.playReverseSound();
			break;
		case 1:
			playerLights.playBrakeSound();
			break;
		case 2:
			playerLights.playWiperSound();
			break;
		case 3:
			playerLights.playHornSound();
			break;
		case 4:
			playerLights.playRadioChatter();
			break;
		default:
			UnityEngine.Debug.Log("Wrong entry in playSound");
			break;
		}
	}

	public void selectControls(int controlsType)
	{
		typeOfControl = controlsType;
		switchToPlayMode();
	}

	public void ShadowsManager()
	{
		if (PlayerPrefs.GetInt("shadows") == 0)
		{
			QualitySettings.SetQualityLevel(1);
			PlayerPrefs.SetInt("shadows", 1);
		}
		else if (PlayerPrefs.GetInt("shadows") == 1)
		{
			QualitySettings.SetQualityLevel(0);
			PlayerPrefs.SetInt("shadows", 0);
		}
	}

	private void Update()
	{
		if (PlayerPrefs.GetInt("DoubleScoreApproved") == 1)
		{
			PlayerPrefs.SetInt("gamescore", PlayerPrefs.GetInt("gamescore") * 2);
			PlayerPrefs.SetInt("Cash", PlayerPrefs.GetInt("Cash") + PlayerPrefs.GetInt("gamescore"));
			levelClearScore.text = PlayerPrefs.GetInt("gamescore").ToString();
			levelClearScore2.text = PlayerPrefs.GetInt("Cash").ToString();
			rewardbutton.SetActive(value: false);
			PlayerPrefs.SetInt("DoubleScoreApproved", 0);
		}
		lifeBarFill.fillAmount = 1f - (float)BikeAnimation.crashesCount / 3f;
		if (lifeBarFill.fillAmount <= 0.7f)
		{
			lifeBarFill.GetComponent<Image>().color = new Color(255f, 140f, 0f);
		}
		if (lifeBarFill.fillAmount <= 0.4f)
		{
			lifeBarFill.GetComponent<Image>().color = Color.red;
		}
		if (PlayerPrefs.GetInt("shadows") == 0)
		{
			Shadows.GetComponent<Text>().text = "Shadows: No";
		}
		else if (PlayerPrefs.GetInt("shadows") == 1)
		{
			Shadows.GetComponent<Text>().text = "Shadows: Yes";
		}
		if (currentState == GameState.isGamePlay)
		{
			mins = (int)(presentLevelTimer / 60f);
			secs = (int)(presentLevelTimer % 60f);
			levelTime = $"{mins:00}:{secs:00}";
			gameScore = Mathf.FloorToInt(presentLevelTimer * 10f);
			ResetChances.text = PlayerPrefs.GetInt("BikeRest").ToString();
		}
		SwitchStates();
	}

	public static bool InternetStatus()
	{
		if (Application.internetReachability != 0)
		{
			return true;
		}
		return false;
	}

	public void RewardVideo()
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

	public void ResetRewardDeclined()
	{
		gameOver();
	}

	public void ResetRewardVedio()
	{
		PlayerPrefs.SetInt("adss_rewardVideo", 1);
		PlayerPrefs.SetInt("ResetNeeded", 1);
	}
}
