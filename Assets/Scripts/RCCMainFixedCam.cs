using UnityEngine;

public class RCCMainFixedCam : MonoBehaviour
{
	private Camera[] cams;

	private AudioListener[] listeners;

	private RCCChildFixedCam[] childCams;

	private RCCCamManager switcher;

	private float[] distances;

	private int totalActiveCams;

	public Transform player;

	public Camera mainCamera;

	public AudioListener mainListener;

	public bool canTrackNow;

	public float distanceLimit = 100f;

	public float minimumFOV = 20f;

	public float maximumFOV = 60f;

	public bool drawGizmos = true;

	private void Start()
	{
		cams = GetComponentsInChildren<Camera>();
		listeners = GetComponentsInChildren<AudioListener>();
		childCams = GetComponentsInChildren<RCCChildFixedCam>();
		switcher = mainCamera.GetComponent<RCCCamManager>();
		mainListener = mainCamera.GetComponent<AudioListener>();
		distances = new float[cams.Length];
		Camera[] array = cams;
		foreach (Camera camera in array)
		{
			camera.enabled = false;
		}
		AudioListener[] array2 = listeners;
		foreach (AudioListener audioListener in array2)
		{
			audioListener.enabled = false;
		}
		RCCChildFixedCam[] array3 = childCams;
		foreach (RCCChildFixedCam rCCChildFixedCam in array3)
		{
			rCCChildFixedCam.enabled = false;
			rCCChildFixedCam.player = player;
		}
	}

	private void Act()
	{
		RCCChildFixedCam[] array = childCams;
		foreach (RCCChildFixedCam rCCChildFixedCam in array)
		{
			rCCChildFixedCam.enabled = false;
			rCCChildFixedCam.player = player;
		}
	}

	private void Update()
	{
		if (canTrackNow)
		{
			Tracking();
		}
		else
		{
			mainCamera.enabled = true;
			mainListener.enabled = true;
			for (int i = 0; i < cams.Length; i++)
			{
				if (cams[i].enabled)
				{
					cams[i].enabled = false;
				}
				if (listeners[i].enabled)
				{
					listeners[i].enabled = false;
				}
				if (childCams[i].enabled)
				{
					childCams[i].enabled = false;
				}
			}
			totalActiveCams = 0;
		}
		RCCChildFixedCam[] array = childCams;
		foreach (RCCChildFixedCam rCCChildFixedCam in array)
		{
			if (rCCChildFixedCam.player != player)
			{
				rCCChildFixedCam.player = player;
			}
		}
	}

	private void Tracking()
	{
		for (int i = 0; i < cams.Length; i++)
		{
			if (i == 0)
			{
				totalActiveCams = 0;
			}
			distances[i] = Vector3.Distance(cams[i].transform.position, player.transform.position);
			if (distances[i] <= distanceLimit && totalActiveCams < 1)
			{
				if (!cams[i].enabled)
				{
					cams[i].enabled = true;
				}
				if (!listeners[i].enabled)
				{
					listeners[i].enabled = true;
				}
				if (!childCams[i].enabled)
				{
					childCams[i].enabled = true;
				}
				cams[i].fieldOfView = Mathf.Lerp(cams[i].fieldOfView, Mathf.Lerp(maximumFOV, minimumFOV, distances[i] * 2f / distanceLimit), Time.deltaTime * 2f);
				if (mainListener.enabled)
				{
					mainListener.enabled = false;
				}
				if (mainCamera.enabled)
				{
					mainCamera.enabled = false;
				}
				totalActiveCams++;
			}
			else
			{
				if (cams[i].enabled)
				{
					cams[i].enabled = false;
				}
				if (listeners[i].enabled)
				{
					listeners[i].enabled = false;
				}
				if (childCams[i].enabled)
				{
					childCams[i].enabled = false;
				}
				childCams[i].transform.rotation = Quaternion.identity;
			}
		}
		if (totalActiveCams < 1)
		{
			if (!mainCamera.enabled)
			{
				mainCamera.enabled = true;
			}
			if (!mainListener.enabled)
			{
				mainListener.enabled = true;
			}
			switcher.cameraChangeCount = 0;
		}
	}

	private void OnDrawGizmos()
	{
		if (drawGizmos)
		{
			cams = GetComponentsInChildren<Camera>();
			for (int i = 0; i < cams.Length; i++)
			{
				Gizmos.matrix = cams[i].transform.localToWorldMatrix;
				Gizmos.color = new Color(1f, 0f, 0f, 0.5f);
				Gizmos.DrawCube(Vector3.zero, new Vector3(distanceLimit * 2f, distanceLimit / 2f, distanceLimit * 2f));
			}
		}
	}
}
