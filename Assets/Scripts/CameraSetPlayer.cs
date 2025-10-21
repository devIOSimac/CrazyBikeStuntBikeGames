using UnityEngine;

public class CameraSetPlayer : MonoBehaviour
{
	public Transform PlayerBiker;

	public Transform View1;

	public Transform View2;

	public Transform View3;

	public GameObject Hneedle;

	public GameObject Hspeed;

	private void Update()
	{
		if (BikeCamera.HudFlag)
		{
			Hneedle.gameObject.SetActive(value: true);
			Hspeed.gameObject.SetActive(value: true);
		}
		else
		{
			Hneedle.gameObject.SetActive(value: false);
			Hspeed.gameObject.SetActive(value: false);
		}
	}
}
