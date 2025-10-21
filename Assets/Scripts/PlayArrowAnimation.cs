using UnityEngine;

public class PlayArrowAnimation : MonoBehaviour
{
	public AnimationState playAnim;

	private void Start()
	{
		GetComponent<Animation>().Play("UpDownAnim");
		GetComponent<Animation>()["UpDownAnim"].speed = 0.25f;
	}

	private void Update()
	{
	}
}
