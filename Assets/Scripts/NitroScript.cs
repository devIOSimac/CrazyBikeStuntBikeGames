using System;
using UnityEngine;

[Serializable]
public class NitroScript : MonoBehaviour
{
	public GameObject lnitro;

	public GameObject rnitro;

	private float NosPoints;

	private int MaxNosPoints;

	public float nosRefilRate;

	public float nosUseRate;

	private bool NitroBoost;

	private bool engine;

	public AudioClip NitroSound_spray;

	public AudioClip NitroSound;

	public int zoom;

	public int normal;

	public float smooth;

	public float NitroPower;

	private bool applyForce;

	public float shakey;

	public float shakex;

	public Transform Cam;

	public Vector3 CamNeutralPosition;

	public Texture2D fadeOutTexture;

	public float fadeSpeed;

	public int drawDepth;

	private float alpha;

	private int fadeDir;

	public NitroScript()
	{
		NosPoints = 100f;
		MaxNosPoints = 100;
		nosRefilRate = 0.03f;
		nosUseRate = 30f;
		zoom = 100;
		normal = 60;
		smooth = 2f;
		NitroPower = 50f;
		shakey = 0.01f;
		shakex = -0.01f;
		fadeSpeed = 0.3f;
		drawDepth = -1000;
		alpha = 1f;
		fadeDir = -1;
	}

	public void Start()
	{
		CamNeutralPosition = Cam.transform.localPosition;
		alpha = 1f;
		fadeIn();
	}

	public void Update()
	{
		if (UnityEngine.Input.GetKey(KeyCode.W))
		{
			engine = true;
		}
		else
		{
			engine = false;
		}
		if (UnityEngine.Input.GetKey(KeyCode.LeftShift) && !(NosPoints < 1f) && engine)
		{
			if (!GetComponent<AudioSource>().isPlaying)
			{
				GetComponent<AudioSource>().PlayOneShot(NitroSound);
				GetComponent<AudioSource>().Play();
			}
			NitroBoost = true;
		}
		else if (UnityEngine.Input.GetKeyUp(KeyCode.LeftShift) || NosPoints <= 1f || !engine)
		{
			NitroBoost = false;
			GetComponent<AudioSource>().Stop();
		}
		if (!NitroBoost)
		{
			lnitro.GetComponent<Renderer>().enabled = false;
			rnitro.GetComponent<Renderer>().enabled = false;
			applyForce = false;
		}
		else if (NitroBoost)
		{
			applyForce = true;
			NosPoints = Mathf.Clamp(NosPoints - nosUseRate * Time.deltaTime, 0f, 100f);
			lnitro.GetComponent<Renderer>().enabled = true;
			rnitro.GetComponent<Renderer>().enabled = true;
		}
		if (NitroBoost && Camera.main.fieldOfView != 0f)
		{
			Camera.main.fieldOfView = Mathf.Lerp(Camera.main.fieldOfView, zoom, Time.deltaTime * smooth);
			float x = UnityEngine.Random.Range(shakey, shakex);
			float y = UnityEngine.Random.Range(shakey, shakex);
			Cam.transform.position = Cam.transform.position + new Vector3(x, y);
		}
		else if (!NitroBoost && Camera.main.fieldOfView != 0f)
		{
			Cam.transform.localPosition = Vector3.Lerp(Cam.transform.localPosition, CamNeutralPosition, Time.deltaTime);
			Camera.main.fieldOfView = Mathf.Lerp(Camera.main.fieldOfView, normal, Time.deltaTime * smooth);
		}
		if (!NitroBoost && !(NosPoints > (float)MaxNosPoints))
		{
			NosPoints += nosRefilRate + 0.05f / Mathf.Clamp(1f + nosRefilRate * Time.deltaTime, 0f, 100f);
		}
	}

	public void OnGUI()
	{
		GUI.color = Color.black;
		GUI.Button(new Rect(800f, Screen.height - 385, NosPoints * 1.5f, 10f), string.Empty);
		alpha += (float)fadeDir * fadeSpeed * Time.deltaTime;
		alpha = Mathf.Clamp01(alpha);
		float a = alpha;
		Color color = GUI.color;
		color.a = a;
		Color color3 = GUI.color = color;
		GUI.depth = drawDepth;
		GUI.DrawTexture(new Rect(0f, 0f, Screen.width, Screen.height), fadeOutTexture);
		if (NitroBoost)
		{
			fadeOut();
		}
		else if (!NitroBoost)
		{
			fadeIn();
		}
	}

	public void fadeIn()
	{
		fadeDir = -1;
	}

	public void fadeOut()
	{
		fadeDir = 1;
	}

	public void FixedUpdate()
	{
		if (applyForce)
		{
			GetComponent<Rigidbody>().AddForce(Camera.main.transform.forward * NitroPower);
		}
	}

	public void Main()
	{
	}
}
