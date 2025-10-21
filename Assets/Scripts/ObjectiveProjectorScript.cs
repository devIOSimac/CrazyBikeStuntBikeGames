using UnityEngine;

public class ObjectiveProjectorScript : MonoBehaviour
{
	public Transform objectiveTransform;

	private bool up = true;

	private float counter = 150f;

	private void changeSize()
	{
		up = !up;
	}

	private void Start()
	{
		Transform transform = base.transform;
		Vector3 position = objectiveTransform.position;
		float x = position.x;
		Vector3 position2 = base.transform.position;
		float y = position2.y;
		Vector3 position3 = objectiveTransform.position;
		transform.position = new Vector3(x, y, position3.z);
		InvokeRepeating("changeSize", 1f, 1f);
	}

	private void FixedUpdate()
	{
		if (up)
		{
			counter += 2f;
		}
		else
		{
			counter -= 2f;
		}
		base.transform.localScale = new Vector3(counter, 0.01f, counter);
	}
}
