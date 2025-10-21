using UnityEngine;

public class RCCEnterExitCamera : MonoBehaviour
{
	public float maxRayDistance = 2f;

	private bool showGui;

	private void Update()
	{
		Vector3 direction = base.gameObject.transform.TransformDirection(Vector3.forward);
		if (Physics.Raycast(base.transform.position, direction, out RaycastHit hitInfo, maxRayDistance))
		{
			showGui = true;
			if (UnityEngine.Input.GetKeyDown(KeyCode.E))
			{
				hitInfo.collider.gameObject.SendMessage("Action", SendMessageOptions.DontRequireReceiver);
			}
		}
		else
		{
			showGui = false;
		}
	}

	private void OnGUI()
	{
		if (showGui)
		{
			GUI.Label(new Rect((float)Screen.width - (float)Screen.width / 1.7f, (float)Screen.height - (float)Screen.height / 1.4f, 800f, 100f), "Press ''E'' key to Use");
		}
	}
}
