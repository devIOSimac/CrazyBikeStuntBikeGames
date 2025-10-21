using System;
using UnityEngine;

internal class LocalNotification
{
	public enum NotificationExecuteMode
	{
		Inexact,
		Exact,
		ExactAndAllowWhileIdle
	}

	private static string fullClassName = "net.agasper.unitynotification.UnityNotificationManager";

	private static string mainActivityClassName = "com.unity3d.player.UnityPlayerNativeActivity";

	public static void SendNotification(int id, TimeSpan delay, string title, string message)
	{
		SendNotification(id, (int)delay.TotalSeconds, title, message, Color.white);
	}

	public static void SendNotification(int id, long delay, string title, string message, Color32 bgColor, bool sound = true, bool vibrate = true, bool lights = true, string bigIcon = "notify_icon_big", NotificationExecuteMode executeMode = NotificationExecuteMode.Inexact)
	{
		new AndroidJavaClass(fullClassName)?.CallStatic("SetNotification", id, delay * 1000, title, message, message, sound ? 1 : 0, vibrate ? 1 : 0, lights ? 1 : 0, bigIcon, "notify_icon_big", bgColor.r * 65536 + bgColor.g * 256 + bgColor.b, (int)executeMode, mainActivityClassName);
	}

	public static void SendRepeatingNotification(int id, long delay, long timeout, string title, string message, Color32 bgColor, bool sound = true, bool vibrate = false, bool lights = true, string bigIcon = "notify_icon_big")
	{
		new AndroidJavaClass(fullClassName)?.CallStatic("SetRepeatingNotification", id, delay * 1000, title, message, message, timeout * 1000, sound ? 1 : 0, vibrate ? 1 : 0, lights ? 1 : 0, bigIcon, "notify_icon_big", bgColor.r * 65536 + bgColor.g * 256 + bgColor.b, mainActivityClassName);
	}

	public static void CancelNotification(int id)
	{
		new AndroidJavaClass(fullClassName)?.CallStatic("CancelNotification", id);
	}
}
