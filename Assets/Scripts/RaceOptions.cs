using UnityEngine;

public class RaceOptions : MonoBehaviour
{
	public GameControllerScript _controller;

	public float ChangedCrashSpeed;

	private void Start()
	{
		Invoke("FixBike", 3f);
	}

	private void FixBike()
	{
		_controller.playerRef.GetComponentInChildren<BikeAnimation>().CrashSpeed = ChangedCrashSpeed;
	}
}
