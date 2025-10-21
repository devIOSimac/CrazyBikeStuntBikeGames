using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class BackupGameControllerScript : MonoBehaviour
{
	public enum GameState
	{
		isObjective,
		isControlSelection,
		isWaitForStart,
		isGamePlay,
		isPause,
		isLevelClear,
		isGameOver,
		isLoading
	}

	private int[] gameTimer = new int[31]
	{
		300,
		300,
		360,
		360,
		340,
		340,
		200,
		280,
		200,
		320,
		300,
		240,
		300,
		300,
		300,
		300,
		180,
		120,
		240,
		220,
		260,
		140,
		240,
		200,
		300,
		300,
		240,
		300,
		300,
		300,
		300
	};

	private float presentLevelTimer;

	private int mins;

	private int secs;

	private string levelTime;

	private float gameScore;

	[HideInInspector]
	public GameState currentState;

	private GameObject playerRef;

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

	[Header("Canvas Elements")]
	public GameObject[] controls;

	public GameObject[] objectiveElements;

	public GameObject pauseDialogue;

	public GameObject controlDialogue;

	public GameObject levelClearDialogue;

	public GameObject gameOverDialogue;

	public Text gameTime;

	public Text gameScoreDisplay;

	public Text pauseGameTime;

	public Text levelClearTime;

	public Text gameOverTime;

	public Text pauseScore;

	public Text levelClearScore;

	public Text gameOverScore;

	private float posx = 220f;

	public int cutSceneSubsTime;

	public GameObject winningText;

	public GameObject nextLevelButton;

	public GameObject sameLevelButton;

	[Header("Button Index")]
	public int engineButton;

	private int typeOfControl;

	[Header("Sound/Music")]
	public AudioSource bgMusic;

	public AudioClip winningSound;

	public AudioClip instructions;

	private AudioClip tempClip;

	[Header("Loading")]
	public GameObject loadingBG;

	public Texture truck;

	public Texture blackBG;

	public Texture blueBG;

	private AsyncOperation loadingProgress;

	public GameObject fences;

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

	private void StopEngineRCC()
	{
		playerRef.GetComponent<RCCCarControllerV2>().KillOrStartEngine(0);
	}

	private void SetRCCCamera()
	{
		cameraObj.GetComponent<RCCCarCamera>().playerCar = playerRef.transform;
		cameraObj.GetComponent<RCCCarCamera>().playerRigid = playerRef.GetComponent<Rigidbody>();
		cameraObj.GetComponent<RCCCamManager>().target = playerRef;
		cameraObj.GetComponent<RCCCamManager>().ChangeCamera();
	}

	private void SetControls()
	{
		switch (typeOfControl)
		{
		case 0:
			playerRef.GetComponent<RCCCarControllerV2>().useAccelerometerForSteer = false;
			playerRef.GetComponent<RCCCarControllerV2>().steeringWheelControl = false;
			break;
		case 1:
			playerRef.GetComponent<RCCCarControllerV2>().useAccelerometerForSteer = false;
			playerRef.GetComponent<RCCCarControllerV2>().steeringWheelControl = true;
			break;
		case 2:
			playerRef.GetComponent<RCCCarControllerV2>().useAccelerometerForSteer = true;
			playerRef.GetComponent<RCCCarControllerV2>().steeringWheelControl = false;
			break;
		default:
			playerRef.GetComponent<RCCCarControllerV2>().useAccelerometerForSteer = false;
			playerRef.GetComponent<RCCCarControllerV2>().steeringWheelControl = false;
			break;
		}
	}

	private void UIRCCControls()
	{
		RCCUIController[] uIControls = new RCCUIController[5]
		{
			controls[0].GetComponent<RCCUIController>(),
			controls[1].GetComponent<RCCUIController>(),
			controls[3].GetComponent<RCCUIController>(),
			controls[2].GetComponent<RCCUIController>(),
			controls[4].GetComponent<RCCUIController>()
		};
		playerRef.GetComponent<RCCCarControllerV2>().assignMobileControls(uIControls);
		playerRef.GetComponent<RCCCarControllerV2>().KillOrStartEngine(1);
		playerRef.GetComponent<RCCCarControllerV2>().MobileGUI();
	}

	private void SwitchStates()
	{
		switch (currentState)
		{
		case GameState.isObjective:
			break;
		case GameState.isControlSelection:
			break;
		case GameState.isWaitForStart:
			break;
		case GameState.isGamePlay:
			if (UnityEngine.Input.GetKeyDown(KeyCode.Escape))
			{
				pauseGame();
			}
			break;
		case GameState.isPause:
			if (UnityEngine.Input.GetKeyDown(KeyCode.Escape))
			{
				pauseElements(2);
			}
			break;
		}
	}

	private void clearScreen()
	{
		if (UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 1)
		{
			UnityEngine.Debug.Log("in Ad area clear level ");
		}
		winningText.SetActive(value: false);
		levelClearDialogue.SetActive(value: true);
		levelClearTime.text = levelTime;
		PlayerPrefs.SetInt("Cash", PlayerPrefs.GetInt("Cash") + (UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex + 1) * 100 + Mathf.FloorToInt(gameScore));
		levelClearScore.text = PlayerPrefs.GetInt("Cash").ToString();
	}

	private void switchToPlayMode()
	{
		if (currentState == GameState.isControlSelection)
		{
			controlDialogue.SetActive(value: false);
			GameObject[] array = controls;
			foreach (GameObject gameObject in array)
			{
				gameObject.SetActive(value: true);
			}
			SetRCCCamera();
			SetControls();
			currentState = GameState.isWaitForStart;
		}
	}

	private void OnGUI()
	{
		GameState gameState = currentState;
		if (gameState == GameState.isLoading)
		{
			float num = counter;
			GUI.DrawTexture(new Rect(0f, (float)Screen.height * 0.9f, Screen.width, (float)Screen.height * 0.1f), blackBG);
			GUI.DrawTexture(new Rect(num / 100f * (float)Screen.width, (float)Screen.height * 0.9f, (float)Screen.width * 0.1f, (float)Screen.height * 0.1f), truck);
			GUI.DrawTexture(new Rect(0f, (float)Screen.height * 0.9f, num / 100f * (float)Screen.width, (float)Screen.height * 0.1f), blueBG);
		}
	}

	private void UpdateTime()
	{
		if (currentState != GameState.isGamePlay)
		{
			return;
		}
		gameScoreDisplay.text = PlayerPrefs.GetInt("Score").ToString();
		gameTime.text = levelTime;
		presentLevelTimer -= 1f;
		if (presentLevelTimer <= 0f)
		{
			currentState = GameState.isGameOver;
			gameOver();
			gameOverDialogue.SetActive(value: true);
			GameObject[] array = controls;
			foreach (GameObject gameObject in array)
			{
				gameObject.SetActive(value: false);
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

	private void Start()
	{
		PlayerPrefs.SetInt("Score", PlayerPrefs.GetInt("Cash"));
		InvokeRepeating("UpdateTime", 0f, 1f);
		Time.timeScale = 1f;
		Invoke("controlSelectionFunction", cutSceneSubsTime);
		currentState = GameState.isObjective;
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
			bgMusic.clip = instructions;
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
		if (PlayerPrefs.GetInt("mode") == 1)
		{
			fences.SetActive(value: true);
		}
		else
		{
			fences.SetActive(value: false);
		}
		instPlayer(PlayerPrefs.GetInt("SelectedVehicle"));
	}

	private void instPlayer(int index)
	{
		playerRef = UnityEngine.Object.Instantiate(truckArray[index], instPoint.position, instPoint.rotation);
		playerLights = playerRef.GetComponent<LightController>();
		shadow.GetComponent<FollowScript>().followObject(playerRef.transform.Find("ShadowFollowPoint"), isTrailer: false);
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
	}

	public void pauseGame()
	{
		if (currentState != GameState.isWaitForStart)
		{
			PlayerPrefs.SetInt("adss_pause", 1);
			pauseDialogue.SetActive(value: true);
			currentState = GameState.isPause;
			GameObject[] array = controls;
			foreach (GameObject gameObject in array)
			{
				gameObject.SetActive(value: false);
			}
			Time.timeScale = 0f;
			AudioListener.volume = 0f;
			pauseGameTime.text = levelTime;
			pauseScore.text = PlayerPrefs.GetInt("Score").ToString();
		}
	}

	public void gameOver()
	{
		if (UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 1)
		{
			UnityEngine.Debug.Log("in Ad area Game Over");
			PlayerPrefs.SetInt("adss_gameover", 1);
		}
		currentState = GameState.isGameOver;
		StopEngineRCC();
		bgMusic.clip = null;
		GameObject[] array = controls;
		foreach (GameObject gameObject in array)
		{
			gameObject.SetActive(value: false);
		}
		gameOverDialogue.SetActive(value: true);
		gameOverTime.text = levelTime;
		PlayerPrefs.SetInt("Cash", PlayerPrefs.GetInt("Score"));
		gameOverScore.text = PlayerPrefs.GetInt("Score").ToString();
	}

	public void LevelClear()
	{
		currentState = GameState.isLevelClear;
		StopEngineRCC();
		if (PlayerPrefs.GetInt("Music") == 0)
		{
			bgMusic.clip = winningSound;
			bgMusic.loop = false;
			bgMusic.Play();
		}
		winningText.SetActive(value: true);
		if (UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex >= 15)
		{
			nextLevelButton.SetActive(value: false);
			RectTransform component = sameLevelButton.GetComponent<RectTransform>();
			float x = posx;
			Vector3 localPosition = sameLevelButton.GetComponent<RectTransform>().localPosition;
			float y = localPosition.y;
			Vector3 localPosition2 = sameLevelButton.GetComponent<RectTransform>().localPosition;
			component.localPosition = new Vector3(x, y, localPosition2.z);
		}
		if (PlayerPrefs.GetInt("mode") == 0)
		{
			if (PlayerPrefs.GetInt("LevelsClearedAmature") <= UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex + 1)
			{
				PlayerPrefs.SetInt("LevelsClearedAmature", UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex + 1);
			}
		}
		else if (PlayerPrefs.GetInt("mode") == 1 && PlayerPrefs.GetInt("LevelsClearedPro") <= UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex + 1)
		{
			PlayerPrefs.SetInt("LevelsClearedPro", UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex + 1);
		}
		Invoke("clearScreen", 6f);
		GameObject[] array = controls;
		foreach (GameObject gameObject in array)
		{
			gameObject.SetActive(value: false);
		}
	}

	public void controlSelectionFunction()
	{
		if (currentState == GameState.isObjective)
		{
			currentState = GameState.isControlSelection;
			GameObject[] array = objectiveElements;
			foreach (GameObject obj in array)
			{
				UnityEngine.Object.Destroy(obj);
			}
			controlDialogue.SetActive(value: true);
		}
	}

	public void toggleEngine()
	{
		if (currentState == GameState.isWaitForStart)
		{
			UIRCCControls();
			controls[engineButton].SetActive(value: false);
			Invoke("PlayMusic", 2f);
			currentState = GameState.isGamePlay;
		}
	}

	public void pauseElements(int action)
	{
		switch (action)
		{
		case 0:
			PlayerPrefs.SetInt("adss_pause", 1);
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
		{
			Time.timeScale = 1f;
			currentState = GameState.isGamePlay;
			pauseDialogue.SetActive(value: false);
			GameObject[] array = controls;
			foreach (GameObject gameObject in array)
			{
				if (gameObject.name != "Engine ON/OFF")
				{
					gameObject.SetActive(value: true);
				}
			}
			if (PlayerPrefs.GetInt("Sound") == 0)
			{
				AudioListener.volume = 1f;
			}
			break;
		}
		}
	}

	public void levelClearMenu(int action)
	{
		switch (action)
		{
		case 0:
			PlayerPrefs.SetInt("adss_pause", 1);
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

	public void skipCutScene()
	{
		controlSelectionFunction();
	}

	public void leftInd()
	{
		playerLights.leftIndOn();
	}

	public void rightInd()
	{
		playerLights.rightIndOn();
	}

	public void doubleInd()
	{
		playerLights.doubleIndicators();
	}

	public void frontLights()
	{
		playerLights.frontLightsToggle();
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

	private void Update()
	{
		mins = (int)(presentLevelTimer / 60f);
		secs = (int)(presentLevelTimer % 60f);
		levelTime = $"{mins:00}:{secs:00}";
		gameScore = Mathf.FloorToInt(presentLevelTimer * 10f);
		SwitchStates();
	}
}
