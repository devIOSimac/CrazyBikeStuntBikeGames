using DG.Tweening;
using UnityEngine;
using UnityEngine.UI;

public class SpeedDectection : MonoBehaviour
{
	public BikeGUI BikeSpeedScript;

	public Text SpeedValue;

	public Text SecuredSpeed;

	public GameObject CameraFlash;

	public DOTweenAnimation[] SpeedAnim;

	private void Start()
	{
		PlayerPrefs.SetInt("TotalSpeed", 0);
		Invoke("GetPlayer", 2f);
	}

	private void GetPlayer()
	{
		BikeSpeedScript = UnityEngine.Object.FindObjectOfType<BikeGUI>();
	}

	public void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.tag == "Player")
		{
			UnityEngine.Debug.Log("Hey there. How are you guys doing?");
			UnityEngine.Debug.Log(BikeSpeedScript.speedText.text);
			SpeedValue.text = BikeSpeedScript.speedText.text;
			SpeedValue.enabled = true;
			CameraFlash.SetActive(value: true);
			DOTweenAnimation[] speedAnim = SpeedAnim;
			foreach (DOTweenAnimation dOTweenAnimation in speedAnim)
			{
				dOTweenAnimation.DOPlayForward();
			}
			PlayerPrefs.SetInt("TotalSpeed", PlayerPrefs.GetInt("TotalSpeed") + int.Parse(BikeSpeedScript.speedText.text));
			UnityEngine.Debug.Log("Speed Text  is  " + PlayerPrefs.GetInt("TotalSpeed"));
			SecuredSpeed.text = PlayerPrefs.GetInt("TotalSpeed").ToString();
		}
	}
}
