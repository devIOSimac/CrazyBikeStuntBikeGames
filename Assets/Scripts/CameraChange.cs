using UnityEngine;

public class CameraChange : MonoBehaviour
{
	public RCCCamManager camScript;

	private void Start()
	{
	}

	private void Update()
	{
	}

	private void OnTriggerEnter(Collider other)
	{
		UnityEngine.Debug.Log("Entered");
		camScript.height = 2f;
	}
}
