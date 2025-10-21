using System;
using UnityEngine;

public abstract class Singleton<T> : MonoBehaviour where T : MonoBehaviour
{
	private static T _instance;

	public bool Persistent;

	public static T Instance
	{
		get
		{
			if (!Instantiated)
			{
				CreateInstance();
			}
			return _instance;
		}
	}

	public static bool Instantiated
	{
		get;
		private set;
	}

	public static bool Destroyed
	{
		get;
		private set;
	}

	private static void CreateInstance()
	{
		if (Destroyed)
		{
			return;
		}
		Type typeFromHandle = typeof(T);
		T[] array = UnityEngine.Object.FindObjectsOfType<T>();
		if (array.Length > 0)
		{
			if (array.Length > 1)
			{
				UnityEngine.Debug.LogWarning("There is more than one instance of Singleton of type \"" + typeFromHandle + "\". Keeping the first one. Destroying the others.");
				for (int i = 1; i < array.Length; i++)
				{
					UnityEngine.Object.Destroy(array[i].gameObject);
				}
			}
			_instance = array[0];
			_instance.gameObject.SetActive(value: true);
			Instantiated = true;
			Destroyed = false;
			return;
		}
		PrefabAttribute prefabAttribute = Attribute.GetCustomAttribute(typeFromHandle, typeof(PrefabAttribute)) as PrefabAttribute;
		string text;
		GameObject gameObject;
		if (prefabAttribute == null || string.IsNullOrEmpty(prefabAttribute.Name))
		{
			text = typeFromHandle.ToString();
			gameObject = new GameObject();
		}
		else
		{
			text = prefabAttribute.Name;
			gameObject = UnityEngine.Object.Instantiate(Resources.Load<GameObject>(text));
			if (gameObject == null)
			{
				throw new Exception("Could not find Prefab \"" + text + "\" on Resources for Singleton of type \"" + typeFromHandle + "\".");
			}
		}
		gameObject.name = text;
		if ((UnityEngine.Object)_instance == (UnityEngine.Object)null)
		{
			_instance = (gameObject.GetComponent<T>() ?? gameObject.AddComponent<T>());
		}
		Instantiated = true;
		Destroyed = false;
	}

	protected virtual void Awake()
	{
		if ((UnityEngine.Object)_instance == (UnityEngine.Object)null)
		{
			if (Persistent)
			{
				CreateInstance();
				UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
			}
			return;
		}
		if (Persistent)
		{
			UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
		}
		if (GetInstanceID() != _instance.GetInstanceID())
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}
	}

	private void OnDestroy()
	{
		Destroyed = true;
		Instantiated = false;
	}

	public void Touch()
	{
	}
}
