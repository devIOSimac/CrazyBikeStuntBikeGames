using UnityEngine;

public class OpponentAnimationTrigger : MonoBehaviour
{
	public GameObject[] brakeLight;

	private void Start()
	{
	}

	private void OnTriggerEnter(Collider col)
	{
		if (col.tag == "Opponent")
		{
			for (int i = 0; i <= brakeLight.Length - 1; i++)
			{
				brakeLight[i].SetActive(value: true);
				MonoBehaviour.print("On break light of opponent");
				Invoke("OffLight", 1f);
			}
		}
	}

	private void OffLight()
	{
		for (int i = 0; i <= brakeLight.Length - 1; i++)
		{
			brakeLight[i].SetActive(value: false);
		}
	}
}
