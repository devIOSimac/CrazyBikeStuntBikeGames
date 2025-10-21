using UnityEngine;
using UnityEngine.UI;

public class BikeGUI : MonoBehaviour
{
	public Image tachometerNeedle;

	public Image barShiftGUI;

	public Text speedText;

	public Text GearText;

	private GameObject gear;

	private GameObject speed;

	private GameObject needle;

	private GameObject shift;

	private int gearst;

	private float thisAngle = -150f;

	public BikeControl bikeScript;

	private void Start()
	{
		if (bikeScript == null)
		{
			bikeScript = UnityEngine.Object.FindObjectOfType<BikeControl>();
		}
		if (tachometerNeedle == null)
		{
			needle = GameObject.FindGameObjectWithTag("Needle");
			tachometerNeedle = needle.GetComponent<Image>();
			UnityEngine.Debug.Log("Sucess");
		}
		if (barShiftGUI == null)
		{
			barShiftGUI = GameObject.FindGameObjectWithTag("Bar").GetComponent<Image>();
		}
		if (speedText == null)
		{
			speedText = GameObject.FindGameObjectWithTag("SpeedText").GetComponent<Text>();
		}
		if (GearText == null)
		{
			GearText = GameObject.FindGameObjectWithTag("GearText").GetComponent<Text>();
		}
	}

	private void Update()
	{
		BikeControl component = base.transform.GetComponent<BikeControl>();
		gearst = component.currentGear;
		speedText.text = ((int)component.speed).ToString();
		if (gearst > 0 && component.speed > 1f)
		{
			GearText.color = Color.green;
			GearText.text = gearst.ToString();
		}
		else if (component.speed > 1f)
		{
			GearText.color = Color.red;
			GearText.text = "R";
		}
		else
		{
			GearText.color = Color.white;
			GearText.text = "N";
		}
		thisAngle = component.motorRPM / 20f - 175f;
		thisAngle = Mathf.Clamp(thisAngle, -180f, 90f);
		tachometerNeedle.rectTransform.rotation = Quaternion.Euler(0f, 0f, 0f - thisAngle);
		barShiftGUI.rectTransform.localScale = new Vector3(component.powerShift / 100f, 1f, 1f);
	}
}
