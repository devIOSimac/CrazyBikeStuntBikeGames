using UnityEngine;

public class carReset : MonoBehaviour
{
	private Transform closestTransform;

	private Transform car;

	private float y;

	private Rigidbody rcc;

	public Transform resetParent;

	private Transform[] resetArray;

	public GameObject ResetRewardCanvas;

	private void Start()
	{
		resetArray = new Transform[resetParent.childCount];
		for (int i = 0; i < resetParent.childCount; i++)
		{
			resetArray[i] = resetParent.GetChild(i);
		}
		Invoke("playerInitiation", 5f);
	}

	private void playerInitiation()
	{
		car = GameObject.FindGameObjectWithTag("Player").transform;
		rcc = car.GetComponent<Rigidbody>();
	}

	private void Update()
	{
		if (UnityEngine.Input.GetKeyDown(KeyCode.F))
		{
			ResetCar();
		}
	}

	public void ResetCar()
	{
		if (PlayerPrefs.GetInt("BikeRest") > 0)
		{
			PlayerPrefs.SetInt("BikeRest", PlayerPrefs.GetInt("BikeRest") - 1);
			rcc.velocity = new Vector3(0f, 0f, 0f);
			float num = 1E+10f;
			Vector3 position = car.position;
			Transform[] array = resetArray;
			foreach (Transform transform in array)
			{
				float num2 = Vector3.Distance(position, transform.position);
				if (num2 < num)
				{
					num = num2;
					closestTransform = transform;
				}
			}
			Vector3 eulerAngles = car.eulerAngles;
			if (eulerAngles.y >= 0f)
			{
				Vector3 eulerAngles2 = car.eulerAngles;
				if (eulerAngles2.y <= 45f)
				{
					y = 22f;
					goto IL_02f6;
				}
			}
			Vector3 eulerAngles3 = car.eulerAngles;
			if (eulerAngles3.y > 45f)
			{
				Vector3 eulerAngles4 = car.eulerAngles;
				if (eulerAngles4.y <= 90f)
				{
					y = 60f;
					goto IL_02f6;
				}
			}
			Vector3 eulerAngles5 = car.eulerAngles;
			if (eulerAngles5.y > 90f)
			{
				Vector3 eulerAngles6 = car.eulerAngles;
				if (eulerAngles6.y <= 135f)
				{
					y = 110f;
					goto IL_02f6;
				}
			}
			Vector3 eulerAngles7 = car.eulerAngles;
			if (eulerAngles7.y > 135f)
			{
				Vector3 eulerAngles8 = car.eulerAngles;
				if (eulerAngles8.y <= 180f)
				{
					y = 165f;
					goto IL_02f6;
				}
			}
			Vector3 eulerAngles9 = car.eulerAngles;
			if (eulerAngles9.y > 180f)
			{
				Vector3 eulerAngles10 = car.eulerAngles;
				if (eulerAngles10.y <= 225f)
				{
					y = 200f;
					goto IL_02f6;
				}
			}
			Vector3 eulerAngles11 = car.eulerAngles;
			if (eulerAngles11.y > 225f)
			{
				Vector3 eulerAngles12 = car.eulerAngles;
				if (eulerAngles12.y <= 270f)
				{
					y = 250f;
					goto IL_02f6;
				}
			}
			Vector3 eulerAngles13 = car.eulerAngles;
			if (eulerAngles13.y > 270f)
			{
				Vector3 eulerAngles14 = car.eulerAngles;
				if (eulerAngles14.y <= 315f)
				{
					y = 290f;
					goto IL_02f6;
				}
			}
			Vector3 eulerAngles15 = car.eulerAngles;
			if (eulerAngles15.y > 270f)
			{
				Vector3 eulerAngles16 = car.eulerAngles;
				if (eulerAngles16.y <= 360f)
				{
					y = 330f;
				}
			}
			goto IL_02f6;
		}
		ResetRewardCanvas.SetActive(value: true);
		Time.timeScale = 0f;
		return;
		IL_02f6:
		car.position = closestTransform.position;
		car.transform.eulerAngles = new Vector3(0f, y, 0f);
	}
}
