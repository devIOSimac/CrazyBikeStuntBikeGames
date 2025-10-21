using UnityEngine;

namespace DigitalOpus.MB.Core
{
	public class MB2_Log
	{
		public static void Log(MB2_LogLevel l, string msg, MB2_LogLevel currentThreshold)
		{
			if (l <= currentThreshold)
			{
				if (l == MB2_LogLevel.error)
				{
					UnityEngine.Debug.LogError(msg);
				}
				if (l == MB2_LogLevel.warn)
				{
					UnityEngine.Debug.LogWarning($"frm={Time.frameCount} WARN {msg}");
				}
				if (l == MB2_LogLevel.info)
				{
					UnityEngine.Debug.Log($"frm={Time.frameCount} INFO {msg}");
				}
				if (l == MB2_LogLevel.debug)
				{
					UnityEngine.Debug.Log($"frm={Time.frameCount} DEBUG {msg}");
				}
				if (l == MB2_LogLevel.trace)
				{
					UnityEngine.Debug.Log($"frm={Time.frameCount} TRACE {msg}");
				}
			}
		}

		public static string Error(string msg, params object[] args)
		{
			string arg = string.Format(msg, args);
			string text = $"f={Time.frameCount} ERROR {arg}";
			UnityEngine.Debug.LogError(text);
			return text;
		}

		public static string Warn(string msg, params object[] args)
		{
			string arg = string.Format(msg, args);
			string text = $"f={Time.frameCount} WARN {arg}";
			UnityEngine.Debug.LogWarning(text);
			return text;
		}

		public static string Info(string msg, params object[] args)
		{
			string arg = string.Format(msg, args);
			string text = $"f={Time.frameCount} INFO {arg}";
			UnityEngine.Debug.Log(text);
			return text;
		}

		public static string LogDebug(string msg, params object[] args)
		{
			string arg = string.Format(msg, args);
			string text = $"f={Time.frameCount} DEBUG {arg}";
			UnityEngine.Debug.Log(text);
			return text;
		}

		public static string Trace(string msg, params object[] args)
		{
			string arg = string.Format(msg, args);
			string text = $"f={Time.frameCount} TRACE {arg}";
			UnityEngine.Debug.Log(text);
			return text;
		}
	}
}
