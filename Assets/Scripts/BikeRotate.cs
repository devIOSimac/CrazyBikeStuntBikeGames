using System;
using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class BikeRotate : MonoBehaviour
{
	public float rotateSpeed = 10f;

	public Text BikeNameUI;

	public Transform root;

	public GameObject[] bikes;

	private int currentBike;

	private Vector3 position;

	public void Right()
	{
		currentBike--;
		if (currentBike < 0)
		{
			currentBike = bikes.Length - 1;
		}
		ActiveCurrentBike(currentBike);
	}

	public void Left()
	{
		currentBike++;
		if (currentBike > bikes.Length - 1)
		{
			currentBike = 0;
		}
		ActiveCurrentBike(currentBike);
	}

	public void ActiveCurrentBike(int current)
	{
		int num = 0;
		float num2 = 0f;
		GameObject[] array = bikes;
		foreach (GameObject gameObject in array)
		{
			if (currentBike == num)
			{
				BikeNameUI.text = "Motorbike " + (currentBike + 1).ToString();
				IEnumerator enumerator = bikes[currentBike].transform.GetEnumerator();
				try
				{
					while (enumerator.MoveNext())
					{
						Transform transform = (Transform)enumerator.Current;
						num2 += (float)transform.GetComponent<MeshFilter>().mesh.triangles.Length / 3f;
					}
				}
				finally
				{
					IDisposable disposable;
					if ((disposable = (enumerator as IDisposable)) != null)
					{
						disposable.Dispose();
					}
				}
			}
			else
			{
				bikes[num].transform.rotation = Quaternion.Euler(0f, 0f, 0f);
			}
			num++;
		}
	}

	public void Start()
	{
		position = root.position;
	}

	private void Update()
	{
		bikes[currentBike].transform.Rotate(0f, rotateSpeed * Time.deltaTime, 0f);
		Transform transform = root;
		Vector3 a = root.position;
		Vector3 a2 = position;
		Vector3 vector = bikes[currentBike].transform.position;
		float x = vector.x;
		Vector3 vector2 = bikes[currentBike].transform.position;
		transform.position = Vector3.Lerp(a, a2 + new Vector3(x, 0f, vector2.z), Time.deltaTime * 10f);
	}
}
