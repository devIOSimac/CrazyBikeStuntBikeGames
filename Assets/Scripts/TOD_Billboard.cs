using UnityEngine;

public class TOD_Billboard : MonoBehaviour
{
	public float Altitude;

	public float Azimuth;

	public float Distance = 1f;

	public float Size = 1f;

	private T GetComponentInParents<T>() where T : Component
	{
		Transform transform = base.transform;
		T component = transform.GetComponent<T>();
		while ((Object)component == (Object)null && transform.parent != null)
		{
			transform = transform.parent;
			component = transform.GetComponent<T>();
		}
		return component;
	}
}
