using UnityEngine;
using UnityEngine.UI;

public class nossystem : MonoBehaviour
{
	public float nospoints = 100f;

	public float maxnospoints = 100f;

	public float nosfillrate = 0.03f;

	public float nosuserate = 30f;

	private bool nitroboost;

	[SerializeField]
	private bool engine;

	public float nitropower = 50f;

	public bool applyforce;

	public Rigidbody car;

	public int zoom = 100;

	public int normal = 60;

	public float smooth = 2f;

	public float NosRegenarationRate;

	public Image nosUI;

	public GameObject Lnitro;

	public AudioSource aud;

	private void Start()
	{
		car = GetComponent<Rigidbody>();
	}

	private void Update()
	{
		if (UnityEngine.Input.GetKey(KeyCode.LeftShift) && nospoints >= 1f && engine)
		{
			nitroboost = true;
		}
		else if (UnityEngine.Input.GetKeyUp(KeyCode.LeftShift) || nospoints <= 1f || !engine)
		{
			nitroboost = false;
		}
		if (!nitroboost)
		{
			Lnitro.SetActive(value: false);
			applyforce = false;
		}
		else if (nitroboost)
		{
			applyforce = true;
			nospoints = Mathf.Clamp(nospoints - nosuserate * Time.deltaTime, 0f, 100f);
			Lnitro.SetActive(value: true);
			nosUI.fillAmount = nospoints / 10f;
		}
		if (!nitroboost && nospoints <= maxnospoints)
		{
			nospoints += nosfillrate + 0.05f / Mathf.Clamp(NosRegenarationRate + nosfillrate * Time.deltaTime, 0f, 100f);
			nosUI.fillAmount = nospoints / 10f;
		}
	}

	private void FixedUpdate()
	{
		if (applyforce)
		{
			car.AddForce(base.transform.forward * nitropower);
		}
	}

	public void nosOn()
	{
		nitroboost = true;
		engine = true;
		aud.Play();
	}

	public void nosOff()
	{
		nitroboost = false;
		engine = false;
		aud.Stop();
	}
}
