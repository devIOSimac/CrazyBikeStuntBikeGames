using UnityEngine;

public class enterCheckpoint : MonoBehaviour
{
	public lookAtDest arrowScript;

	public Checkpoints checkpoints;

	private void Start()
	{
		if (arrowScript == null)
		{
			arrowScript = UnityEngine.Object.FindObjectOfType<lookAtDest>();
		}
		if (checkpoints == null)
		{
			checkpoints = UnityEngine.Object.FindObjectOfType<Checkpoints>();
		}
	}

	private void ToggleAllChildGOs(bool on)
	{
		for (int i = 0; i < base.transform.childCount; i++)
		{
			base.transform.GetChild(i).gameObject.SetActive(on);
		}
	}

	private void Update()
	{
		if (arrowScript.Target != base.transform)
		{
			ToggleAllChildGOs(on: false);
			GetComponent<BoxCollider>().enabled = false;
		}
		else
		{
			ToggleAllChildGOs(on: true);
			GetComponent<BoxCollider>().enabled = true;
		}
	}

	private void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.tag == "Player")
		{
			UnityEngine.Object.Destroy(base.gameObject, 0.1f);
			checkpoints.changeTarget();
		}
	}
}
