using System;
using UnityEngine;

[Serializable]
public class Antiroll_Bar : MonoBehaviour
{
	public WheelCollider WheelL;

	public WheelCollider WheelR;

	public float AntiRoll;

	public Antiroll_Bar()
	{
		AntiRoll = 5000f;
	}

	public void Update()
	{
	}

	public void FixedUpdate()
	{
		WheelHit hit = default(WheelHit);
		float num = 1f;
		float num2 = 1f;
		bool groundHit = WheelL.GetGroundHit(out hit);
		if (groundHit)
		{
			Vector3 vector = WheelL.transform.InverseTransformPoint(hit.point);
			num = (0f - vector.y - WheelL.radius) / WheelL.suspensionDistance;
		}
		bool groundHit2 = WheelR.GetGroundHit(out hit);
		if (groundHit2)
		{
			Vector3 vector2 = WheelR.transform.InverseTransformPoint(hit.point);
			num2 = (0f - vector2.y - WheelR.radius) / WheelR.suspensionDistance;
		}
		float num3 = (num - num2) * AntiRoll;
		if (groundHit)
		{
			GetComponent<Rigidbody>().AddForceAtPosition(WheelL.transform.up * (0f - num3), WheelL.transform.position);
		}
		if (groundHit2)
		{
			GetComponent<Rigidbody>().AddForceAtPosition(WheelR.transform.up * num3, WheelR.transform.position);
		}
	}

	public void Main()
	{
	}
}
