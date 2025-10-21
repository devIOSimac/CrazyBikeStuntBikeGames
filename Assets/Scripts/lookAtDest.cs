using UnityEngine;

public class lookAtDest : MonoBehaviour
{
	public Transform Target;

	public bool smooth = true;

	public float damping = 6f;

	private int counter;

	private void Start()
	{
	}

	private void LateUpdate()
	{
		if (Target != null)
		{
			if (smooth)
			{
				Vector3 forward = Target.position - base.transform.position;
				forward.y = 0f;
				Quaternion b = Quaternion.LookRotation(forward);
				base.transform.rotation = Quaternion.Slerp(base.transform.rotation, b, Time.deltaTime * damping);
			}
			else
			{
				base.transform.LookAt(Target);
			}
		}
	}
}
