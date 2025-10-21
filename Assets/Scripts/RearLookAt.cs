using UnityEngine;

public class RearLookAt : MonoBehaviour
{
	public Transform target;

	public Vector3 position;

	private void Update()
	{
		Vector3 a = base.transform.localPosition - target.localPosition;
		Quaternion localRotation = Quaternion.LookRotation(a + position);
		base.transform.localRotation = localRotation;
	}
}
