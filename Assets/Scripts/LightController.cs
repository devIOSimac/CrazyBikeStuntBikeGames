using UnityEngine;

public class LightController : MonoBehaviour
{
	private enum IndState
	{
		LeftInd,
		RightInd,
		DoubleInd,
		None
	}

	private IndState indicatorState;

	public GameObject leftInd;

	public GameObject rightInd;

	public GameObject frontLights;

	private int radioChatterCounter;

	private bool isLeft;

	private bool isRight;

	private bool isDouble;

	private bool isLightOn;

	public AudioClip reverseClip;

	public AudioClip brakeClip;

	public AudioClip windShieldClip;

	public AudioClip hornClip;

	public AudioClip indicatorClip;

	public AudioClip lightsOnClip;

	public AudioClip parkClip;

	private AudioSource reverseSource;

	private AudioSource brakeSource;

	private AudioSource windShieldSource;

	private AudioSource hornSource;

	private AudioSource radioChatter;

	private AudioSource indicatorSource;

	private AudioSource lightsOnSource;

	private AudioSource parkSource;

	public AudioClip[] radioChatterClips;

	public void playHornSound()
	{
		if (PlayerPrefs.GetInt("Sound") == 0 && hornSource == null)
		{
			hornSource = CreateAudioSource("hornSound", 5f, 1f, hornClip, loop: true, playNow: true, destroyAfterFinished: true);
		}
	}

	public void playWiperSound()
	{
		if (PlayerPrefs.GetInt("Sound") == 0)
		{
			if (windShieldSource == null)
			{
				windShieldSource = CreateAudioSource("windShieldSound", 5f, 1f, windShieldClip, loop: true, playNow: true, destroyAfterFinished: false);
			}
			else
			{
				UnityEngine.Object.Destroy(windShieldSource.gameObject);
			}
		}
	}

	public void playIndicatorSound()
	{
		if (PlayerPrefs.GetInt("Sound") == 0)
		{
			if (indicatorSource == null)
			{
				indicatorSource = CreateAudioSource("indicatorSound", 5f, 1f, indicatorClip, loop: true, playNow: true, destroyAfterFinished: false);
			}
			else if (indicatorState == IndState.None)
			{
				UnityEngine.Object.Destroy(indicatorSource.gameObject);
			}
		}
	}

	public void playRadioChatter()
	{
		if (PlayerPrefs.GetInt("Sound") == 0 && radioChatter == null)
		{
			radioChatter = CreateAudioSource("radioChatter", 5f, 1f, radioChatterClips[radioChatterCounter], loop: true, playNow: true, destroyAfterFinished: true);
			if (radioChatterCounter == 4)
			{
				radioChatterCounter = 0;
			}
			else
			{
				radioChatterCounter++;
			}
		}
	}

	public void playBrakeSound()
	{
		if (PlayerPrefs.GetInt("Sound") == 0)
		{
			brakeSource = CreateAudioSource("brakeSound", 5f, 0f, brakeClip, loop: true, playNow: true, destroyAfterFinished: false);
		}
	}

	public void lightsOnSound()
	{
		if (PlayerPrefs.GetInt("Sound") == 0 && lightsOnSource == null)
		{
			lightsOnSource = CreateAudioSource("lightsOnSound", 5f, 1f, lightsOnClip, loop: true, playNow: true, destroyAfterFinished: true);
		}
	}

	public void handbrakeSound()
	{
	}

	public void playParkSound()
	{
		if (PlayerPrefs.GetInt("Sound") == 0)
		{
			if (parkSource == null)
			{
				parkSource = CreateAudioSource("parkSound", 5f, 1f, parkClip, loop: true, playNow: true, destroyAfterFinished: true);
				return;
			}
			UnityEngine.Object.Destroy(parkSource);
			parkSource = CreateAudioSource("parkSound", 5f, 1f, parkClip, loop: true, playNow: true, destroyAfterFinished: true);
		}
	}

	public AudioSource CreateAudioSource(string audioName, float minDistance, float volume, AudioClip audioClip, bool loop, bool playNow, bool destroyAfterFinished)
	{
		GameObject gameObject = new GameObject(audioName);
		gameObject.transform.position = base.transform.position;
		gameObject.transform.rotation = base.transform.rotation;
		gameObject.transform.parent = base.transform;
		gameObject.AddComponent<AudioSource>();
		gameObject.GetComponent<AudioSource>().minDistance = minDistance;
		gameObject.GetComponent<AudioSource>().volume = volume;
		gameObject.GetComponent<AudioSource>().clip = audioClip;
		gameObject.GetComponent<AudioSource>().loop = loop;
		gameObject.GetComponent<AudioSource>().spatialBlend = 1f;
		if (playNow)
		{
			gameObject.GetComponent<AudioSource>().Play();
		}
		if (destroyAfterFinished)
		{
			UnityEngine.Object.Destroy(gameObject, audioClip.length);
		}
		return gameObject.GetComponent<AudioSource>();
	}

	public void frontLightsToggle()
	{
		lightsOnSound();
		isLightOn = !isLightOn;
		frontLights.SetActive(isLightOn);
	}

	public void doubleIndicators()
	{
		if (indicatorState != IndState.DoubleInd)
		{
			indicatorState = IndState.DoubleInd;
			playIndicatorSound();
			return;
		}
		leftInd.SetActive(value: false);
		rightInd.SetActive(value: false);
		indicatorState = IndState.None;
		playIndicatorSound();
	}

	public void leftIndOn()
	{
		if (indicatorState != 0)
		{
			indicatorState = IndState.LeftInd;
			playIndicatorSound();
		}
		else
		{
			indicatorState = IndState.None;
			leftInd.SetActive(value: false);
			playIndicatorSound();
		}
	}

	public void rightIndOn()
	{
		if (indicatorState != IndState.RightInd)
		{
			indicatorState = IndState.RightInd;
			playIndicatorSound();
		}
		else
		{
			indicatorState = IndState.None;
			rightInd.SetActive(value: false);
			playIndicatorSound();
		}
	}

	public void playReverseSound()
	{
		reverseSource = CreateAudioSource("reverseSound", 5f, 0f, reverseClip, loop: true, playNow: true, destroyAfterFinished: false);
	}

	private void Start()
	{
		indicatorState = IndState.None;
		isRight = false;
		isLeft = false;
		isDouble = false;
		InvokeRepeating("IndicatorFunction", 1f, 0.5f);
		radioChatterCounter = 0;
	}

	private void IndicatorFunction()
	{
		switch (indicatorState)
		{
		case IndState.LeftInd:
			if (!leftInd.activeInHierarchy)
			{
				leftInd.SetActive(value: true);
			}
			else
			{
				leftInd.SetActive(value: false);
			}
			break;
		case IndState.RightInd:
			if (!rightInd.activeInHierarchy)
			{
				rightInd.SetActive(value: true);
			}
			else
			{
				rightInd.SetActive(value: false);
			}
			break;
		case IndState.DoubleInd:
			if (!leftInd.activeInHierarchy)
			{
				leftInd.SetActive(value: true);
				rightInd.SetActive(value: true);
			}
			else
			{
				leftInd.SetActive(value: false);
				rightInd.SetActive(value: false);
			}
			break;
		default:
			leftInd.SetActive(value: false);
			rightInd.SetActive(value: false);
			break;
		}
	}

	private void Update()
	{
	}
}
