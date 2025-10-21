using UnityEngine;

public class wheelMove : MonoBehaviour
{
	public Transform[] Wheels;

	public float WheelSpeed;

	private void Start()
	{
	}

	private void Update()
	{
		Wheels[0].localEulerAngles = new Vector3(Time.fixedTime * WheelSpeed, 0f, 0f);
		Wheels[1].localEulerAngles = new Vector3(Time.fixedTime * WheelSpeed, 0f, 0f);
		Wheels[2].localEulerAngles = new Vector3(Time.fixedTime * WheelSpeed, 0f, 0f);
		Wheels[3].localEulerAngles = new Vector3(Time.fixedTime * WheelSpeed, 0f, 0f);
	}
}
