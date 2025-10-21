using UnityEngine;

public class RCCNGUIController : MonoBehaviour
{
	public float input;

	public float sensitivity = 3f;

	private bool pressing;

	private void Start()
	{
	}

	private void OnPress(bool isPressed)
	{
		if (isPressed)
		{
			pressing = true;
		}
		else
		{
			pressing = false;
		}
	}

	private void Update()
	{
		if (pressing)
		{
			input += Time.deltaTime * sensitivity;
		}
		else
		{
			input -= Time.deltaTime * sensitivity;
		}
		if (input < 0f)
		{
			input = 0f;
		}
		if (input > 1f)
		{
			input = 1f;
		}
	}
}
