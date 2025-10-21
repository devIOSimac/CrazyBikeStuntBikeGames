using UnityEngine;

public class FinalDestination : MonoBehaviour
{
	public static bool reached;

	public GameObject parkingSign;

	public bool reverseParking;

	private bool startTimer;

	private float timer;

	private int time;

	public GameObject[] upDownCubes;

	public string desiredTag;

	public GameControllerScript gameManagerScript;

	private void Start()
	{
		timer = 0f;
		reached = false;
		startTimer = false;
		InvokeRepeating("CheckParking", 5f, 1f);
	}

	private void CheckParking()
	{
		if (startTimer)
		{
			parkingSign.SetActive(value: true);
			GameObject[] array = upDownCubes;
			foreach (GameObject gameObject in array)
			{
				gameObject.SetActive(value: false);
			}
		}
		else
		{
			parkingSign.SetActive(value: false);
		}
	}

	private void Update()
	{
		if (startTimer)
		{
			timer += Time.deltaTime;
			if (timer >= 1.7f)
			{
				startTimer = false;
				reached = true;
				base.gameObject.SetActive(value: false);
				if (UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex >= 6 && UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex <= 10)
				{
					if (PlayerPrefs.GetInt("TotalSpeed") > 370)
					{
						gameManagerScript.LevelClear();
						UnityEngine.Debug.Log("Next Objective");
					}
					else
					{
						gameManagerScript.gameOver();
					}
				}
				gameManagerScript.LevelClear();
				UnityEngine.Debug.Log("Next Objective");
			}
		}
		time = Mathf.FloorToInt(1f - timer);
	}

	private void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.tag == desiredTag)
		{
			UnityEngine.Debug.Log(Vector3.Angle(base.transform.forward * -1f, other.transform.forward));
			if (!reverseParking)
			{
				startTimer = true;
				GetComponent<AudioSource>().Play();
			}
			else if ((Vector3.Angle(base.transform.forward * -1f, other.transform.forward) >= 0f && Vector3.Angle(base.transform.forward * -1f, other.transform.forward) < 45f) || (Vector3.Angle(base.transform.forward * -1f, other.transform.forward) > 315f && Vector3.Angle(base.transform.forward * -1f, other.transform.forward) <= 360f))
			{
				startTimer = true;
				GetComponent<AudioSource>().Play();
			}
		}
	}

	private void OnTriggerExit(Collider other)
	{
		if (other.gameObject.tag == desiredTag)
		{
			startTimer = false;
			timer = 0f;
		}
	}
}
