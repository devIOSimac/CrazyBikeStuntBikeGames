using UnityEngine;

public class collisionScript : MonoBehaviour
{
	private void Start()
	{
	}

	private void Update()
	{
	}

	private void OnCollisionEnter(Collision abc)
	{
		UnityEngine.Debug.Log(abc.collider.gameObject.name);
	}
}
