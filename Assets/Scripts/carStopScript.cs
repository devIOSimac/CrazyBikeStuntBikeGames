using UnityEngine;

public class carStopScript : MonoBehaviour
{
	public Transform raycastPoint;

	private AICar_Script VelocityScript;

	private Antiroll_Bar WheelRollScript;

	public float temp;

	private int layerGround;

	private int layerTraffic;

	private void Start()
	{
		VelocityScript = GetComponent<AICar_Script>();
		WheelRollScript = GetComponent<Antiroll_Bar>();
		InvokeRepeating("lookForObstacles", 3f, 0.1f);
		temp = VelocityScript.EngineTorque;
		layerGround = LayerMask.NameToLayer("Player");
		layerTraffic = LayerMask.NameToLayer("Traffic");
	}

	private void Update()
	{
	}

	private void OnCollisionEnter(Collision col)
	{
		if (col.gameObject.tag == "Player")
		{
			VelocityScript.enabled = false;
			WheelRollScript.enabled = false;
		}
	}

	private void lookForObstacles()
	{
		if (Physics.Raycast(raycastPoint.transform.position, 1f * raycastPoint.transform.forward, out RaycastHit hitInfo, 15f))
		{
			if (hitInfo.collider.gameObject.layer == layerGround || hitInfo.collider.gameObject.layer == layerTraffic)
			{
				VelocityScript.BrakePower = 500f;
				VelocityScript.EngineTorque = 0f;
				UnityEngine.Debug.Log("Player");
			}
			else
			{
				VelocityScript.BrakePower = 0f;
				VelocityScript.EngineTorque = temp;
			}
		}
		else
		{
			VelocityScript.BrakePower = 0f;
			VelocityScript.EngineTorque = temp;
		}
		UnityEngine.Debug.DrawRay(raycastPoint.transform.position, 1f * raycastPoint.transform.forward * 15f);
	}
}
