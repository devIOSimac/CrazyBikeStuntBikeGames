using UnityEngine;

public class Checkpoints : MonoBehaviour
{
	public static int checkpointCount;

	public lookAtDest arrowScript;

	private int counter;

	public GameObject[] parkingSpot;

	private bool isActivated;

	private void Start()
	{
		isActivated = false;
		activateParkingSpot(isActivated);
		if (arrowScript == null)
		{
			arrowScript = UnityEngine.Object.FindObjectOfType<lookAtDest>();
		}
		checkpointCount = base.transform.childCount;
		arrowScript.Target = base.transform.GetChild(counter).transform;
	}

	public void activateParkingSpot(bool isActive)
	{
		parkingSpot[0].GetComponent<BoxCollider>().enabled = isActive;
		parkingSpot[0].GetComponent<MeshRenderer>().enabled = isActive;
		parkingSpot[2].GetComponent<MeshRenderer>().enabled = isActive;
	}

	public void changeTarget()
	{
		if (base.transform.childCount > counter)
		{
			UnityEngine.Debug.Log(base.transform.childCount);
			checkpointCount--;
			arrowScript.Target = base.transform.GetChild(counter + 1).transform;
			if (arrowScript.Target.GetComponent<FinalDestination>() != null)
			{
				UnityEngine.Debug.Log("DONE");
				activateParkingSpot(isActive: true);
			}
		}
	}

	private void Update()
	{
		if (checkpointCount == 1)
		{
			isActivated = true;
			activateParkingSpot(isActivated);
		}
	}
}
