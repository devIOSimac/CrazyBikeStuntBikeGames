using System;
using UnityEngine;
using UnityScript.Lang;

[Serializable]
public class PlayerCar : MonoBehaviour
{
	public WheelCollider FrontLeftWheel;

	public WheelCollider FrontRightWheel;

	public float[] GearRatio;

	public int CurrentGear;

	public float EngineTorque;

	public float MaxEngineRPM;

	public float MinEngineRPM;

	private float EngineRPM;

	public PlayerCar()
	{
		EngineTorque = 230f;
		MaxEngineRPM = 3000f;
		MinEngineRPM = 1000f;
	}

	public void Start()
	{
		GetComponent<Rigidbody>().centerOfMass = GetComponent<Rigidbody>().centerOfMass + new Vector3(0f, -1f, 0.25f);
	}

	public void Update()
	{
		EngineRPM = (FrontLeftWheel.rpm + FrontRightWheel.rpm) / 2f * GearRatio[CurrentGear];
		ShiftGears();
		GetComponent<AudioSource>().pitch = Mathf.Abs(EngineRPM / MaxEngineRPM) + 1f;
		if (!(GetComponent<AudioSource>().pitch <= 2f))
		{
			GetComponent<AudioSource>().pitch = 2f;
		}
		FrontLeftWheel.motorTorque = EngineTorque / GearRatio[CurrentGear] * UnityEngine.Input.GetAxis("Vertical");
		FrontRightWheel.motorTorque = EngineTorque / GearRatio[CurrentGear] * UnityEngine.Input.GetAxis("Vertical");
		FrontLeftWheel.steerAngle = 10f * UnityEngine.Input.GetAxis("Horizontal");
		FrontRightWheel.steerAngle = 10f * UnityEngine.Input.GetAxis("Horizontal");
	}

	public void ShiftGears()
	{
		int currentGear;
		if (!(EngineRPM < MaxEngineRPM))
		{
			currentGear = CurrentGear;
			for (int i = 0; i < Extensions.get_length((System.Array)GearRatio); i++)
			{
				if (!(FrontLeftWheel.rpm * GearRatio[i] >= MaxEngineRPM))
				{
					currentGear = i;
					break;
				}
			}
			CurrentGear = currentGear;
		}
		if (EngineRPM > MinEngineRPM)
		{
			return;
		}
		currentGear = CurrentGear;
		for (int num = Extensions.get_length((System.Array)GearRatio) - 1; num >= 0; num--)
		{
			if (!(FrontLeftWheel.rpm * GearRatio[num] <= MinEngineRPM))
			{
				currentGear = num;
				break;
			}
		}
		CurrentGear = currentGear;
	}

	public void Main()
	{
	}
}
