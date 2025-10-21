using UnityEngine;

public class RCCTruckTrailer : MonoBehaviour
{
	public Transform centerOfMass;

	public Transform[] wheelTransforms;

	public WheelCollider[] wheelColliders;

	private float[] rotationValues;

	private void Start()
	{
		rotationValues = new float[wheelColliders.Length];
		GetComponent<Rigidbody>().interpolation = RigidbodyInterpolation.None;
		GetComponent<Rigidbody>().interpolation = RigidbodyInterpolation.Interpolate;
		Rigidbody component = GetComponent<Rigidbody>();
		Vector3 localPosition = centerOfMass.transform.localPosition;
		float x = localPosition.x;
		Vector3 localScale = base.transform.localScale;
		float x2 = x * localScale.x;
		Vector3 localPosition2 = centerOfMass.transform.localPosition;
		float y = localPosition2.y;
		Vector3 localScale2 = base.transform.localScale;
		float y2 = y * localScale2.y;
		Vector3 localPosition3 = centerOfMass.transform.localPosition;
		float z = localPosition3.z;
		Vector3 localScale3 = base.transform.localScale;
		component.centerOfMass = new Vector3(x2, y2, z * localScale3.z);
	}

	private void Update()
	{
		WheelAlign();
	}

	private void WheelAlign()
	{
		if (wheelColliders.Length <= 0)
		{
			return;
		}
		RaycastHit hitInfo = default(RaycastHit);
		for (int i = 0; i < wheelColliders.Length; i++)
		{
			Vector3 vector = wheelColliders[i].transform.TransformPoint(wheelColliders[i].center);
			Vector3 origin = vector;
			Vector3 direction = -wheelColliders[i].transform.up;
			float num = wheelColliders[i].suspensionDistance + wheelColliders[i].radius;
			Vector3 localScale = base.transform.localScale;
			if (Physics.Raycast(origin, direction, out hitInfo, num * localScale.y))
			{
				Transform transform = wheelTransforms[i].transform;
				Vector3 point = hitInfo.point;
				Vector3 a = wheelColliders[i].transform.up * wheelColliders[i].radius;
				Vector3 localScale2 = base.transform.localScale;
				transform.position = point + a * localScale2.y;
			}
			else
			{
				Transform transform2 = wheelTransforms[i].transform;
				Vector3 a2 = vector;
				Vector3 a3 = wheelColliders[i].transform.up * wheelColliders[i].suspensionDistance;
				Vector3 localScale3 = base.transform.localScale;
				transform2.position = a2 - a3 * localScale3.y;
			}
			Transform transform3 = wheelTransforms[i].transform;
			Quaternion rotation = wheelColliders[i].transform.rotation;
			float x = rotationValues[i];
			Quaternion rotation2 = wheelColliders[i].transform.rotation;
			transform3.rotation = rotation * Quaternion.Euler(x, 0f, rotation2.z);
			rotationValues[i] += wheelColliders[i].rpm * 6f * Time.deltaTime;
		}
	}

	private void FixedUpdate()
	{
		WheelCollider[] array = wheelColliders;
		foreach (WheelCollider wheelCollider in array)
		{
			if (wheelCollider.isGrounded)
			{
				wheelCollider.motorTorque = 0.01f;
			}
			else
			{
				wheelCollider.motorTorque = 0f;
			}
		}
	}
}
