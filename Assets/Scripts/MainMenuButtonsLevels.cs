using UnityEngine;
using UnityEngine.UI;

public class MainMenuButtonsLevels : MonoBehaviour
{
	public LevelButton[] Stunts;

	public LevelButton[] CameraHigh;

	public LevelButton[] Campaign;

	public LevelButton[] Racing;

	private void Start()
	{
		LevelButton[] stunts = Stunts;
		foreach (LevelButton levelButton in stunts)
		{
			if (PlayerPrefs.GetInt("Level_" + (levelButton.LevelNumber - 1).ToString() + "_Stunts") < 1)
			{
				levelButton.GetComponent<Button>().interactable = false;
			}
			else
			{
				levelButton.GetComponent<Button>().interactable = true;
			}
		}
		LevelButton[] cameraHigh = CameraHigh;
		foreach (LevelButton levelButton2 in cameraHigh)
		{
			if (PlayerPrefs.GetInt("Level_" + (levelButton2.LevelNumber - 1).ToString() + "_CameraHigh") < 1)
			{
				levelButton2.GetComponent<Button>().interactable = false;
			}
			else
			{
				levelButton2.GetComponent<Button>().interactable = true;
			}
		}
		LevelButton[] campaign = Campaign;
		foreach (LevelButton levelButton3 in campaign)
		{
			if (PlayerPrefs.GetInt("Level_" + (levelButton3.LevelNumber - 1).ToString() + "_Campaign") < 1)
			{
				levelButton3.GetComponent<Button>().interactable = false;
			}
			else
			{
				levelButton3.GetComponent<Button>().interactable = true;
			}
		}
		LevelButton[] racing = Racing;
		foreach (LevelButton levelButton4 in racing)
		{
			if (PlayerPrefs.GetInt("Level_" + (levelButton4.LevelNumber - 1).ToString() + "_Racing") < 1)
			{
				levelButton4.GetComponent<Button>().interactable = false;
			}
			else
			{
				levelButton4.GetComponent<Button>().interactable = true;
			}
		}
		Stunts[0].GetComponent<Button>().interactable = true;
		CameraHigh[0].GetComponent<Button>().interactable = true;
		Campaign[0].GetComponent<Button>().interactable = true;
		Racing[0].GetComponent<Button>().interactable = true;
	}

	private void Update()
	{
		if (PlayerPrefs.GetInt("levelUnlocked") == 1 || PlayerPrefs.GetInt("Premium") == 1)
		{
			LevelButton[] stunts = Stunts;
			foreach (LevelButton levelButton in stunts)
			{
				levelButton.GetComponent<Button>().interactable = true;
			}
			LevelButton[] cameraHigh = CameraHigh;
			foreach (LevelButton levelButton2 in cameraHigh)
			{
				levelButton2.GetComponent<Button>().interactable = true;
			}
			LevelButton[] campaign = Campaign;
			foreach (LevelButton levelButton3 in campaign)
			{
				levelButton3.GetComponent<Button>().interactable = true;
			}
			LevelButton[] racing = Racing;
			foreach (LevelButton levelButton4 in racing)
			{
				levelButton4.GetComponent<Button>().interactable = true;
			}
		}
	}
}
