using UnityEngine;

public class RotateVehicle : MonoBehaviour
{
	private void Start()
	{
	}

	private void Update()
	{
		base.transform.Rotate(Vector3.up * Time.fixedDeltaTime * 20f);
	}
}
