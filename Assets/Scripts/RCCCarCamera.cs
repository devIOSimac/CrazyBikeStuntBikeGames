using UnityEngine;

public class RCCCarCamera : MonoBehaviour
{
	public Transform playerCar;

	public Rigidbody playerRigid;

	private Camera cam;

	public float distance = 10f;

	public float height = 5f;

	private float defaultHeight;

	public float heightOffset = 0.75f;

	public float heightDamping = 2f;

	public float rotationDamping = 3f;

	public float minimumFOV = 50f;

	public float maximumFOV = 70f;

	public float maximumTilt = 15f;

	private float tiltAngle;

	private void Start()
	{
		if ((bool)playerCar)
		{
			playerRigid = playerCar.GetComponent<Rigidbody>();
			cam = GetComponent<Camera>();
		}
	}

	private void Update()
	{
		if ((bool)playerCar)
		{
			if (playerRigid != playerCar.GetComponent<Rigidbody>())
			{
				playerRigid = playerCar.GetComponent<Rigidbody>();
			}
			float a = tiltAngle;
			Vector3 vector = playerCar.InverseTransformDirection(playerRigid.velocity);
			tiltAngle = Mathf.Lerp(a, Mathf.Clamp(vector.x * 2f, -35f, 35f), Time.deltaTime * 2f);
			if (!cam)
			{
				cam = GetComponent<Camera>();
			}
			cam.fieldOfView = Mathf.Lerp(minimumFOV, maximumFOV, playerRigid.velocity.magnitude * 3f / 150f);
		}
	}

	private void LateUpdate()
	{
		if ((bool)playerCar && (bool)playerRigid)
		{
			Vector3 vector = playerRigid.transform.InverseTransformDirection(playerRigid.velocity);
			float num = vector.z * 3f;
			Vector3 eulerAngles = playerCar.eulerAngles;
			float b = eulerAngles.y;
			Vector3 position = playerCar.position;
			float b2 = position.y + height;
			Vector3 eulerAngles2 = base.transform.eulerAngles;
			float y = eulerAngles2.y;
			Vector3 position2 = base.transform.position;
			float y2 = position2.y;
			if (num < -2f)
			{
				Vector3 eulerAngles3 = playerCar.eulerAngles;
				b = eulerAngles3.y + 180f;
			}
			y = Mathf.LerpAngle(y, b, rotationDamping * Time.deltaTime);
			y2 = Mathf.Lerp(y2, b2, heightDamping * Time.deltaTime);
			Quaternion rotation = Quaternion.Euler(0f, y, 0f);
			base.transform.position = playerCar.position;
			base.transform.position -= rotation * Vector3.forward * distance;
			Transform transform = base.transform;
			Vector3 position3 = base.transform.position;
			float x = position3.x;
			float y3 = y2 + defaultHeight;
			Vector3 position4 = base.transform.position;
			transform.position = new Vector3(x, y3, position4.z);
			Transform transform2 = base.transform;
			Vector3 position5 = playerCar.position;
			float x2 = position5.x;
			Vector3 position6 = playerCar.position;
			float y4 = position6.y + heightOffset;
			Vector3 position7 = playerCar.position;
			transform2.LookAt(new Vector3(x2, y4, position7.z));
			Transform transform3 = base.transform;
			Vector3 eulerAngles4 = base.transform.eulerAngles;
			float x3 = eulerAngles4.x;
			Vector3 eulerAngles5 = base.transform.eulerAngles;
			transform3.eulerAngles = new Vector3(x3, eulerAngles5.y, Mathf.Clamp(tiltAngle, -10f, 10f));
		}
	}
}
