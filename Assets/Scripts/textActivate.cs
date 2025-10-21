using UnityEngine;

public class textActivate : MonoBehaviour
{
	public GameObject text;

	private bool activate;

	private void Start()
	{
		activate = true;
	}

	private void Update()
	{
	}

	private void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.CompareTag("Player"))
		{
			if (activate)
			{
				text.SetActive(value: true);
				activate = !activate;
			}
			else if (!activate)
			{
				text.SetActive(value: false);
				activate = !activate;
			}
		}
	}
}
