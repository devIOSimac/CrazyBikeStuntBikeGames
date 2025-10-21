using System;
using UnityEngine;

[Serializable]
public class WheelAlignScript : MonoBehaviour
{
	public WheelCollider CorrespondingCollider;

	public GameObject SlipPrefab;

	public float RotationValue;

	public void Update()
	{
		RaycastHit hitInfo = default(RaycastHit);
		Vector3 vector = CorrespondingCollider.transform.TransformPoint(CorrespondingCollider.center);
		if (Physics.Raycast(vector, -CorrespondingCollider.transform.up, out hitInfo, CorrespondingCollider.suspensionDistance + CorrespondingCollider.radius))
		{
			transform.position = hitInfo.point + CorrespondingCollider.transform.up * CorrespondingCollider.radius;
		}
		else
		{
			transform.position = vector - CorrespondingCollider.transform.up * CorrespondingCollider.suspensionDistance;
		}
		transform.rotation = CorrespondingCollider.transform.rotation * Quaternion.Euler(RotationValue, CorrespondingCollider.steerAngle, 0f);
		RotationValue += CorrespondingCollider.rpm * 6f * Time.deltaTime;
		WheelHit hit = default(WheelHit);
		CorrespondingCollider.GetGroundHit(out hit);
		if (!(Mathf.Abs(hit.sidewaysSlip) <= 1.5f) && (bool)SlipPrefab)
		{
			UnityEngine.Object.Instantiate(SlipPrefab, hit.point, Quaternion.identity);
		}
	}

	public void Main()
	{
	}
}
