using UnityEngine;

public class RCCCarCameraConfig : MonoBehaviour
{
	public float distance = 10f;

	public float height = 5f;

	public float heightOffset = 4f;

	private void Start()
	{
	}

	private void OnEnable()
	{
		Camera main = Camera.main;
		if ((bool)main && (bool)main.GetComponent<RCCCarCamera>())
		{
			main.GetComponent<RCCCarCamera>().distance = distance;
			main.GetComponent<RCCCarCamera>().height = height;
			main.GetComponent<RCCCarCamera>().heightOffset = heightOffset;
		}
	}
}
