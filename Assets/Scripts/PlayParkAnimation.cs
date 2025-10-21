using UnityEngine;

public class PlayParkAnimation : MonoBehaviour
{
	private void Start()
	{
		GetComponent<Animation>().Play("UpDownAnim");
		GetComponent<Animation>()["UpDownAnim"].speed = 0.25f;
	}

	private void Update()
	{
	}
}
