using UnityEngine;

public class HudNeedleManager : MonoBehaviour
{
	public float thisAngle = -150f;

	private void Start()
	{
	}

	private void Update()
	{
		thisAngle = BikeControl.tempRPM / 20f - 175f;
		thisAngle = Mathf.Clamp(thisAngle, -180f, 90f);
		Transform transform = base.gameObject.transform;
		Vector3 eulerAngles = base.transform.localRotation.eulerAngles;
		float x = eulerAngles.x;
		Vector3 eulerAngles2 = base.transform.localRotation.eulerAngles;
		transform.localRotation = Quaternion.Euler(x, eulerAngles2.y, 0f - thisAngle);
	}
}
