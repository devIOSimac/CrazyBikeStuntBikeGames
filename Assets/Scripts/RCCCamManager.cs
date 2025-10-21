using UnityEngine;

public class RCCCamManager : MonoBehaviour
{
	private bool activateDashboard;

	private RCCCarCamera carCamera;

	private RCCCameraOrbit orbitScript;

	public GameObject mainFixedCamera;

	[HideInInspector]
	public RCCMainFixedCam fixedCamScript;

	private RCCCockpit_Camera cockpitCamera;

	private RCCWheel_Camera wheelCamera;

	[HideInInspector]
	public float dist = 10f;

	[HideInInspector]
	public float height = 5f;

	[HideInInspector]
	public int cameraChangeCount;

	[HideInInspector]
	public GameObject target;

	public GameObject dashboardUI;

	private float newDist;

	private float newHeight;

	private float lastDist;

	private float lastHeight;

	private void Awake()
	{
		activateDashboard = false;
		cameraChangeCount = 5;
		carCamera = GetComponent<RCCCarCamera>();
		orbitScript = GetComponent<RCCCameraOrbit>();
		if ((bool)mainFixedCamera)
		{
			fixedCamScript = mainFixedCamera.GetComponent<RCCMainFixedCam>();
		}
	}

	private void Update()
	{
		if (UnityEngine.Input.GetKeyDown(KeyCode.C))
		{
			ChangeCamera();
		}
	}

	private void dashboardCamera()
	{
		if (activateDashboard)
		{
			carCamera.transform.parent = target.transform;
			carCamera.transform.localPosition = cockpitCamera.transform.localPosition;
			carCamera.transform.localRotation = cockpitCamera.transform.localRotation;
			carCamera.GetComponent<Camera>().fieldOfView = 60f;
		}
	}

	public void ChangeCamera()
	{
		cameraChangeCount++;
		if (cameraChangeCount == 6)
		{
			cameraChangeCount = 0;
		}
		if (!target)
		{
			return;
		}
		carCamera.playerCar = target.transform;
		dist = target.GetComponent<RCCCarCameraConfig>().distance;
		height = target.GetComponent<RCCCarCameraConfig>().height;
		newDist = dist - dist / 10f;
		newHeight = height - height / 10f;
		lastDist = newDist - newDist / 5f;
		lastHeight = newHeight - newHeight / 5f;
		carCamera.distance = dist;
		carCamera.height = height;
		orbitScript.target = target.transform;
		orbitScript.distance = dist;
		cockpitCamera = target.GetComponentInChildren<RCCCockpit_Camera>();
		wheelCamera = target.GetComponentInChildren<RCCWheel_Camera>();
		if ((bool)fixedCamScript)
		{
			fixedCamScript.player = target.transform;
		}
		switch (cameraChangeCount)
		{
		case 0:
			orbitScript.enabled = false;
			carCamera.enabled = true;
			dashboardUI.SetActive(value: false);
			carCamera.transform.parent = null;
			if ((bool)fixedCamScript)
			{
				fixedCamScript.canTrackNow = false;
			}
			break;
		case 1:
			activateDashboard = false;
			orbitScript.enabled = false;
			carCamera.distance = newDist;
			carCamera.height = newHeight;
			carCamera.enabled = true;
			dashboardUI.SetActive(value: false);
			carCamera.transform.parent = null;
			if ((bool)fixedCamScript)
			{
				fixedCamScript.canTrackNow = false;
			}
			break;
		case 2:
			activateDashboard = false;
			orbitScript.enabled = false;
			carCamera.distance = lastDist;
			carCamera.height = lastHeight;
			carCamera.enabled = true;
			dashboardUI.SetActive(value: false);
			carCamera.transform.parent = null;
			if ((bool)fixedCamScript)
			{
				fixedCamScript.canTrackNow = false;
			}
			break;
		case 3:
			orbitScript.enabled = false;
			carCamera.enabled = false;
			dashboardUI.SetActive(value: true);
			activateDashboard = true;
			InvokeRepeating("dashboardCamera", 0.001f, 0.001f);
			carCamera.transform.parent = target.transform;
			carCamera.transform.localPosition = cockpitCamera.transform.localPosition;
			carCamera.transform.localRotation = cockpitCamera.transform.localRotation;
			carCamera.GetComponent<Camera>().fieldOfView = 60f;
			if ((bool)fixedCamScript)
			{
				fixedCamScript.canTrackNow = false;
			}
			break;
		case 4:
			orbitScript.enabled = false;
			carCamera.enabled = false;
			dashboardUI.SetActive(value: false);
			carCamera.transform.parent = target.transform;
			carCamera.transform.localPosition = wheelCamera.transform.localPosition;
			carCamera.transform.localRotation = wheelCamera.transform.localRotation;
			carCamera.GetComponent<Camera>().fieldOfView = 60f;
			if ((bool)fixedCamScript)
			{
				fixedCamScript.canTrackNow = false;
			}
			break;
		case 5:
			activateDashboard = false;
			orbitScript.enabled = false;
			carCamera.enabled = false;
			dashboardUI.SetActive(value: false);
			carCamera.transform.parent = null;
			if ((bool)fixedCamScript)
			{
				fixedCamScript.canTrackNow = true;
			}
			break;
		default:
			UnityEngine.Debug.Log("Do not know");
			break;
		}
	}
}
