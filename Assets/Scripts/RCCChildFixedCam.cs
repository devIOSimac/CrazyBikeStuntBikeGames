using UnityEngine;

public class RCCChildFixedCam : MonoBehaviour
{
	[HideInInspector]
	public Transform player;

	private void Start()
	{
	}

	private void Update()
	{
		base.transform.LookAt(player);
	}
}
