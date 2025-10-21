using UnityEngine;

public class waterDestroy : MonoBehaviour
{
	public GameControllerScript s;

	private void Start()
	{
	}

	private void Update()
	{
	}

	private void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.CompareTag("Player"))
		{
			s.gameOver();
		}
	}
}
