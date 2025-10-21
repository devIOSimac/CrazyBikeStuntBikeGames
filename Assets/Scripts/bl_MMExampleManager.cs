using UnityEngine;

public class bl_MMExampleManager : MonoBehaviour
{
	public GameObject ExampleGo;

	public int MapID = 2;

	public const string MMName = "MMManagerExample";

	public GameObject[] Maps;

	private void Awake()
	{
		MapID = PlayerPrefs.GetInt("MMExampleMapID", 0);
		ApplyMap();
	}

	private void ApplyMap()
	{
		Maps[MapID].SetActive(value: true);
	}

	public void ChangeMap(int i)
	{
		PlayerPrefs.SetInt("MMExampleMapID", i);
		UnityEngine.SceneManagement.SceneManager.LoadScene(UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex);
	}
}
