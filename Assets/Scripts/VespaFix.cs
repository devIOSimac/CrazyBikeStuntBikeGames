using UnityEngine;

public class VespaFix : MonoBehaviour
{
	public GameObject a;

	public GameObject b;

	private void Start()
	{
		a = GameObject.Find("Wheel_FWheelCollider");
		a.GetComponent<WheelCollider>().center = new Vector3(0f, 0.1f, 0f);
		b = GameObject.Find("Wheel_BWheelCollider");
		b.GetComponent<WheelCollider>().center = new Vector3(0f, 0.1f, 0f);
	}

	private void Update()
	{
	}
}
