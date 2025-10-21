using UnityEngine;
using UnityEngine.AI;

public class WheelRotation : MonoBehaviour
{
	private float speed;

	private void UpdateSpeed()
	{
		speed = base.transform.GetComponentInParent<NavMeshAgent>().speed;
	}

	private void Start()
	{
		InvokeRepeating("UpdateSpeed", 2f, 2f);
	}

	private void Update()
	{
		for (int i = 0; i < base.transform.childCount; i++)
		{
			base.transform.GetChild(i).transform.Rotate(Vector3.right * speed);
		}
	}
}
