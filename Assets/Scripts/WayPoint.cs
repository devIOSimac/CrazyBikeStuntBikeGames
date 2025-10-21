using System;
using UnityEngine;

[Serializable]
public class WayPoint : MonoBehaviour
{
	[NonSerialized]
	public static WayPoint start;

	public WayPoint next;

	public bool isStart;

	public Vector3 CalculateTargetPosition(Vector3 position)
	{
		return (Vector3.Distance(transform.position, position) >= 6f) ? transform.position : next.transform.position;
	}

	public void Awake()
	{
		if (!next)
		{
			UnityEngine.Debug.Log("This waypoint is not connected,you need to set the next waypoint!", this);
		}
		if (isStart)
		{
			start = this;
		}
	}

	public void OnDrawGizmos()
	{
		Gizmos.color = new Color(1f, 0f, 0f, 0.3f);
		Gizmos.DrawCube(transform.position, new Vector3(5f, 5f, 5f));
		if ((bool)next)
		{
			Gizmos.color = Color.green;
			Gizmos.DrawLine(transform.position, next.transform.position);
		}
	}

	public void Main()
	{
	}
}
