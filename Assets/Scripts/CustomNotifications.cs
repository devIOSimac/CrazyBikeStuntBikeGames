using UnityEngine;

public class CustomNotifications : MonoBehaviour
{
	private float sleepUntil;

	public int delay;

	public int timeOut;

	public string title;

	public string longMessage;

	private void Start()
	{
		LocalNotification.SendRepeatingNotification(1, delay, timeOut, title, longMessage, new Color32(byte.MaxValue, 68, 68, byte.MaxValue));
		sleepUntil = Time.time + 99999f;
	}

	private void Update()
	{
	}
}
