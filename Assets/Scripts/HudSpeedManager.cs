using UnityEngine;

public class HudSpeedManager : MonoBehaviour
{
	private void Start()
	{
	}

	private void Update()
	{
		GetComponent<TextMesh>().text = ((int)BikeControl.tempSPEED).ToString();
	}
}
