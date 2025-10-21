using UnityEngine;

public class VinDiesel : MonoBehaviour
{
	public GameObject Car;

	public int speed;

	public static bool kicharChecking;

	private float timer = 2.5f;

	private GameObject rccCamera;

	public int changeCameraTime;

	private void Start()
	{
		Invoke("Findcar", 1f);
		rccCamera = GameObject.FindGameObjectWithTag("RCCCamera");
	}

	private void Update()
	{
		if (!kicharChecking)
		{
		}
	}

	private void OnTriggerExit(Collider other)
	{
		if (other.gameObject.tag == "Player")
		{
			timer = 2.5f;
			Invoke("changeCameraBack", changeCameraTime);
		}
	}

	private void changeCameraBack()
	{
	}

	private void OnTriggerStay(Collider other)
	{
		if (other.gameObject.tag == "Player")
		{
			timer -= Time.deltaTime;
			if (!(timer <= 0f))
			{
				Car.gameObject.GetComponent<Rigidbody>().AddForce(Car.transform.forward * speed);
			}
		}
	}

	private void Findcar()
	{
		Car = GameObject.FindGameObjectWithTag("Player");
	}
}
