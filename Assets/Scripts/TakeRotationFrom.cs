using UnityEngine;

public class TakeRotationFrom : MonoBehaviour
{
	public Transform RotationSnatcher;

	private Vector3 _targetRotation;

	private void LateUpdate()
	{
		Vector3 eulerAngles = RotationSnatcher.localRotation.eulerAngles;
		_targetRotation = new Vector3(0f, 0f, 0f - eulerAngles.y);
		base.transform.rotation = Quaternion.Euler(_targetRotation);
	}
}
