using UnityEngine;

public class MB_ExampleMover : MonoBehaviour
{
	public int axis;

	private void Update()
	{
		Vector3 position = new Vector3(5f, 5f, 5f);
		int index;
		position[index = axis] = position[index] * Mathf.Sin(Time.time);
		base.transform.position = position;
	}
}
