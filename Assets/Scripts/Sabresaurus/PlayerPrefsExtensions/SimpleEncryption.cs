using System;
using System.Security.Cryptography;
using System.Text;

namespace Sabresaurus.PlayerPrefsExtensions
{
	public static class SimpleEncryption
	{
		private static string key = ":{j%6j?E:t#}G10mM%9hp5S=%}2,Y26C";

		private static RijndaelManaged provider;

		private static void SetupProvider()
		{
			provider = new RijndaelManaged();
			provider.Key = Encoding.ASCII.GetBytes(key);
			provider.Mode = CipherMode.ECB;
		}

		public static string EncryptString(string sourceString)
		{
			if (provider == null)
			{
				SetupProvider();
			}
			ICryptoTransform cryptoTransform = provider.CreateEncryptor();
			byte[] bytes = Encoding.UTF8.GetBytes(sourceString);
			byte[] inArray = cryptoTransform.TransformFinalBlock(bytes, 0, bytes.Length);
			return Convert.ToBase64String(inArray);
		}

		public static string DecryptString(string sourceString)
		{
			if (provider == null)
			{
				SetupProvider();
			}
			ICryptoTransform cryptoTransform = provider.CreateDecryptor();
			byte[] array = Convert.FromBase64String(sourceString);
			byte[] bytes = cryptoTransform.TransformFinalBlock(array, 0, array.Length);
			return Encoding.UTF8.GetString(bytes);
		}

		public static string EncryptFloat(float value)
		{
			byte[] bytes = BitConverter.GetBytes(value);
			string sourceString = Convert.ToBase64String(bytes);
			return EncryptString(sourceString);
		}

		public static string EncryptInt(int value)
		{
			byte[] bytes = BitConverter.GetBytes(value);
			string sourceString = Convert.ToBase64String(bytes);
			return EncryptString(sourceString);
		}

		public static float DecryptFloat(string sourceString)
		{
			string s = DecryptString(sourceString);
			byte[] value = Convert.FromBase64String(s);
			return BitConverter.ToSingle(value, 0);
		}

		public static int DecryptInt(string sourceString)
		{
			string s = DecryptString(sourceString);
			byte[] value = Convert.FromBase64String(s);
			return BitConverter.ToInt32(value, 0);
		}
	}
}
