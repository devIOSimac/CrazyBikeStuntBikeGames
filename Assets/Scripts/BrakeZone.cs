using System;
using UnityEngine;

[Serializable]
public class BrakeZone : MonoBehaviour
{
	public GameObject AICar;

	public float brakingPower;

	public float enginePower;

	public BrakeZone()
	{
		brakingPower = 20f;
		enginePower = 20f;
	}

	public void Start()
	{
		AICar = GameObject.FindGameObjectWithTag("AI");
	}

	public void OnTriggerEnter(Collider other)
	{
		AICar.GetComponent<AICar_Script>().BrakePower = brakingPower;
		AICar.GetComponent<AICar_Script>().EngineTorque = enginePower;
	}

	public void OnTriggerExit(Collider other)
	{
		AICar.GetComponent<AICar_Script>().BrakePower = 0f;
		AICar.GetComponent<AICar_Script>().EngineTorque = Mathf.Lerp(enginePower, 600f, Time.deltaTime);
	}

	public void Main()
	{
	}
}
