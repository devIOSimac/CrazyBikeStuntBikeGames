using UnityEngine;

public class TestScript : MonoBehaviour
{
	private void Start()
	{
		Time.timeScale = 1f;
		GetComponent<RCCCarControllerV2>().KillOrStartEngine(0);
	}

	private void Update()
	{
	}
}
