using System.Collections;
using UnityEngine;

public class RCCEnterExitCar : MonoBehaviour
{
	public GameObject mainCamera;

	public GameObject vehicle;

	public GameObject FPSPlayer;

	public Transform getOutPosition;

	private bool opened;

	private float waitTime = 1f;

	private bool temp;

	private void Start()
	{
		mainCamera.GetComponent<Camera>().enabled = false;
		mainCamera.GetComponent<AudioListener>().enabled = false;
		vehicle.GetComponent<RCCCarControllerV2>().canControl = false;
	}

	private void Update()
	{
		if (UnityEngine.Input.GetKeyDown(KeyCode.E) && opened && !temp)
		{
			GetOut();
			opened = false;
			temp = false;
		}
	}

	private IEnumerator Action()
	{
		if (!opened && !temp)
		{
			GetIn();
			opened = true;
			temp = true;
			yield return new WaitForSeconds(waitTime);
			temp = false;
		}
	}

	private void GetIn()
	{
		mainCamera.transform.GetComponent<RCCCarCamera>().playerCar = vehicle.transform;
		FPSPlayer.SetActive(value: false);
		FPSPlayer.transform.parent = vehicle.transform;
		FPSPlayer.transform.localPosition = Vector3.zero;
		mainCamera.GetComponent<Camera>().enabled = true;
		vehicle.GetComponent<RCCCarCameraConfig>().enabled = true;
		vehicle.GetComponent<RCCCarControllerV2>().canControl = true;
		mainCamera.GetComponent<AudioListener>().enabled = true;
		vehicle.SendMessage("KillOrStartEngine", 1);
	}

	private void GetOut()
	{
		FPSPlayer.transform.parent = null;
		FPSPlayer.transform.position = getOutPosition.transform.position;
		FPSPlayer.transform.rotation = Quaternion.identity;
		FPSPlayer.SetActive(value: true);
		mainCamera.GetComponent<Camera>().enabled = false;
		vehicle.GetComponent<RCCCarCameraConfig>().enabled = false;
		mainCamera.GetComponent<AudioListener>().enabled = false;
		vehicle.GetComponent<RCCCarControllerV2>().canControl = false;
	}
}
