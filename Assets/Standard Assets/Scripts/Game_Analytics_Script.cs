using UnityEngine;

public class Game_Analytics_Script : Singleton<Game_Analytics_Script>
{
	private const string SINGLE_TIME_EVENTS = "SINGLE_TIME_EVENTS";

	private const string REOCURRING_EVENTS = "REOCCURING_EVENTS";

	private const string FIRST_TIME_OPEN = "FIRST_TIME_OPEN";

	private const string LEVEL_PREFIX = "LEVEL_";

	private const string MAIN_MENU = "MAIN_MENU";

	private const string ADS_EVENTS = "ADS_EVENTS";

	private void Start()
	{
		if (!PlayerPrefs.HasKey("FIRST_TIME_OPEN"))
		{
			PlayerPrefs.SetInt("FIRST_TIME_OPEN", 1);
		}
		if (UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex != 0)
		{
		}
	}

	public void LogEventFB(string _event)
	{
	}

	public void LogEventFB(string _eventClass, string _event)
	{
	}

	public void LevelLoading()
	{
	}

	private void OnApplicationQuit()
	{
		LevelLoading();
	}

	public void RewardedAdsCalled(string arg)
	{
	}

	public void IntAdsCalled(string arg)
	{
	}

	public void IntAdsCalled()
	{
	}
}
