using UnityEngine;

public class RCCCarChange : MonoBehaviour
{
	private GameObject[] objects;

	private GameObject activeObject;

	private int activeObjectIdx;

	private Camera mainCamera;

	private bool selectScreen = true;

	public Vector3 cameraOffset = new Vector3(0f, 1f, 0f);

	private void Start()
	{
		objects = GameObject.FindGameObjectsWithTag("Player");
		GameObject[] array = objects;
		foreach (GameObject gameObject in array)
		{
			gameObject.GetComponent<RCCCarControllerV2>().canControl = false;
		}
		mainCamera = Camera.main;
	}

	private void Update()
	{
		if (selectScreen)
		{
			mainCamera.transform.position = Vector3.Lerp(mainCamera.transform.position, objects[activeObjectIdx].transform.position + -mainCamera.transform.forward * 15f + cameraOffset, Time.deltaTime * 5f);
		}
	}

	private void OnGUI()
	{
		if (selectScreen)
		{
			GUIStyle style = GUI.skin.GetStyle("Button");
			style.alignment = TextAnchor.MiddleCenter;
			if (GUI.Button(new Rect(Screen.width / 2 + 65, Screen.height - 100, 120f, 50f), "Next"))
			{
				activeObjectIdx++;
				if (activeObjectIdx >= objects.Length)
				{
					activeObjectIdx = 0;
				}
			}
			if (GUI.Button(new Rect(Screen.width / 2 - 185, Screen.height - 100, 120f, 50f), "Previous"))
			{
				activeObjectIdx--;
				if (activeObjectIdx < 0)
				{
					activeObjectIdx = objects.Length - 1;
				}
			}
			if (GUI.Button(new Rect(Screen.width / 2 - 60, Screen.height - 100, 120f, 50f), "Select"))
			{
				selectScreen = false;
				objects[activeObjectIdx].GetComponent<RCCCarControllerV2>().canControl = true;
				GetComponent<RCCCamManager>().enabled = true;
				GetComponent<RCCCamManager>().target = objects[activeObjectIdx];
				GetComponent<RCCCamManager>().ChangeCamera();
			}
		}
		else if (GUI.Button(new Rect(Screen.width - 270, 350f, 240f, 50f), "Select Screen"))
		{
			selectScreen = true;
			objects[activeObjectIdx].GetComponent<RCCCarControllerV2>().canControl = false;
			GetComponent<RCCCamManager>().cameraChangeCount = 0;
			if ((bool)GetComponent<RCCCamManager>().fixedCamScript)
			{
				GetComponent<RCCCamManager>().fixedCamScript.canTrackNow = false;
			}
			GetComponent<RCCCamManager>().enabled = false;
			GetComponent<RCCCarCamera>().enabled = false;
			GetComponent<RCCCameraOrbit>().enabled = false;
			Transform transform = mainCamera.transform;
			Quaternion rotation = mainCamera.transform.rotation;
			float x = rotation.x;
			Quaternion rotation2 = mainCamera.transform.rotation;
			transform.rotation = Quaternion.Euler(x, 140f, rotation2.z);
		}
	}
}
