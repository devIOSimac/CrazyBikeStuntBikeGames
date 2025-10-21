using UnityEngine;

public class CheckPointsManager : MonoBehaviour
{
	private void Start()
	{
	}

	private void Update()
	{
	}

	private void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.tag == "Player")
		{
			base.gameObject.SetActive(value: false);
		}
	}
}
