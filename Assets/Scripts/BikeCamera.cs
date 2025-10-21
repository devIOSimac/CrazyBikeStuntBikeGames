using CnControls;
using UnityEngine;

public class BikeCamera : MonoBehaviour
{
	public Transform target;

	public Transform BikerMan;

	public float smooth = 0.3f;

	public float distance = 5f;

	public float height = 1f;

	public float Angle = 20f;

	public Transform[] cameraSwitchView;

	public LayerMask lineOfSightMask = 0;

	private float yVelocity;

	private int Switch;

	private GameObject snowParticlesInst;

	public static bool HudFlag;

	public void CameraSwitch()
	{
		Switch++;
		if (Switch > cameraSwitchView.Length)
		{
			Switch = 0;
		}
	}

	public void SceneSwitch(int Number)
	{
		UnityEngine.SceneManagement.SceneManager.LoadScene(Number);
	}

	private void Start()
	{
	}

	private void Update()
	{
		if (UnityEngine.Input.GetKeyDown(KeyCode.R))
		{
			UnityEngine.SceneManagement.SceneManager.LoadScene(UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex);
		}
		BikeControl component = target.GetComponent<BikeControl>();
		GetComponent<Camera>().fieldOfView = Mathf.Clamp(component.speed / 10f + 60f, 60f, 90f);
		if (CnInputManager.GetButtonDown("changeCameraKey"))
		{
			Switch++;
			if (Switch > cameraSwitchView.Length)
			{
				Switch = 0;
			}
		}
		if (!component.crash)
		{
			if (Switch == 0)
			{
				HudFlag = false;
				Vector3 eulerAngles = base.transform.eulerAngles;
				float y = eulerAngles.y;
				Vector3 eulerAngles2 = target.eulerAngles;
				float y2 = Mathf.SmoothDampAngle(y, eulerAngles2.y, ref yVelocity, smooth);
				base.transform.eulerAngles = new Vector3(Angle, y2, 0f);
				Vector3 vector = base.transform.rotation * -Vector3.forward;
				float d = AdjustLineOfSight(target.position + new Vector3(0f, height, 0f), vector);
				base.transform.position = target.position + new Vector3(0f, height, 0f) + vector * d;
			}
			else if (Switch == 2)
			{
				HudFlag = true;
				base.transform.position = cameraSwitchView[Switch - 1].position;
				base.transform.rotation = Quaternion.Lerp(base.transform.rotation, cameraSwitchView[Switch - 1].rotation, Time.deltaTime * 5f);
			}
			else
			{
				HudFlag = false;
				base.transform.position = cameraSwitchView[Switch - 1].position;
				base.transform.rotation = Quaternion.Lerp(base.transform.rotation, cameraSwitchView[Switch - 1].rotation, Time.deltaTime * 5f);
			}
		}
		else
		{
			Vector3 forward = BikerMan.position - base.transform.position;
			base.transform.rotation = Quaternion.LookRotation(forward);
		}
	}

	private float AdjustLineOfSight(Vector3 target, Vector3 direction)
	{
		if (Physics.Raycast(target, direction, out RaycastHit hitInfo, distance, lineOfSightMask.value))
		{
			return hitInfo.distance;
		}
		return distance;
	}
}
