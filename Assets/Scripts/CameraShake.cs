using UnityEngine;

public class CameraShake : MonoBehaviour
{
	public bool Shaking;

	private float ShakeDecay;

	private float ShakeIntensity;

	private Vector3 OriginalPos;

	private Quaternion OriginalRot;

	public GameObject scoreDeduction;

	private bool checking;

	private void Start()
	{
		checking = false;
		Shaking = false;
	}

	private void Update()
	{
		if (checking)
		{
			scoreDeduction.transform.Translate(Vector3.up * 30f * Time.deltaTime);
		}
		if (ShakeIntensity > 0f)
		{
			base.transform.position = OriginalPos + UnityEngine.Random.insideUnitSphere * ShakeIntensity;
			base.transform.rotation = new Quaternion(OriginalRot.x + UnityEngine.Random.Range(0f - ShakeIntensity, ShakeIntensity) * 0.2f, OriginalRot.y + UnityEngine.Random.Range(0f - ShakeIntensity, ShakeIntensity) * 0.2f, OriginalRot.z + UnityEngine.Random.Range(0f - ShakeIntensity, ShakeIntensity) * 0.2f, OriginalRot.w + UnityEngine.Random.Range(0f - ShakeIntensity, ShakeIntensity) * 0.2f);
			ShakeIntensity -= ShakeDecay;
		}
		else if (Shaking)
		{
			Invoke("scoreDeductionoff", 1f);
			Shaking = false;
		}
	}

	private void OnGUI()
	{
	}

	private void scoreDeductionoff()
	{
		scoreDeduction.transform.Translate(Vector3.down * 30f);
		scoreDeduction.SetActive(value: false);
		checking = false;
	}

	public void DoShake()
	{
		if (PlayerPrefs.GetInt("mode") == 0)
		{
			scoreDeduction.SetActive(value: true);
			checking = true;
		}
		if (PlayerPrefs.GetInt("Score") >= 250)
		{
			PlayerPrefs.SetInt("Score", PlayerPrefs.GetInt("Score") - 250);
		}
		OriginalPos = base.transform.position;
		OriginalRot = base.transform.rotation;
		ShakeIntensity = 0.3f;
		ShakeDecay = 0.02f;
		Shaking = true;
	}
}
