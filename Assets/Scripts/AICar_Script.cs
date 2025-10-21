using System;
using UnityEngine;
using UnityScript.Lang;

[Serializable]
public class AICar_Script : MonoBehaviour
{
	public WheelCollider FrontLeftWheel;

	public WheelCollider FrontRightWheel;

	public WheelCollider RearLeftWheel;

	public WheelCollider RearRightWheel;

	public float vehicleCenterOfMass;

	public float steeringSharpness;

	public float[] GearRatio;

	public int CurrentGear;

	public float EngineTorque;

	public float BrakePower;

	public float MaxEngineRPM;

	public float MinEngineRPM;

	private float EngineRPM;

	public GameObject waypointContainer;

	public Transform[] waypoints;

	public int currentWaypoint;

	private int currentIndex;

	private float inputSteer;

	private float inputTorque;

	public bool loop;

	public AICar_Script()
	{
		steeringSharpness = 12f;
		EngineTorque = 600f;
		MaxEngineRPM = 3000f;
		MinEngineRPM = 1000f;
	}

	public void Awake()
	{
		GetWaypoints();
	}

	public void Start()
	{
		float y = vehicleCenterOfMass;
		Vector3 centerOfMass = GetComponent<Rigidbody>().centerOfMass;
		centerOfMass.y = y;
		Vector3 vector2 = GetComponent<Rigidbody>().centerOfMass = centerOfMass;
	}

	public void FixedUpdate()
	{
		GetComponent<Rigidbody>().drag = GetComponent<Rigidbody>().velocity.magnitude / 250f;
		NavigateTowardsWaypoint();
		EngineRPM = (FrontLeftWheel.rpm + FrontRightWheel.rpm) / 2f * GearRatio[CurrentGear];
		ShiftGears();
		GetComponent<AudioSource>().pitch = Mathf.Abs(EngineRPM / MaxEngineRPM) + 1f;
		if (!(GetComponent<AudioSource>().pitch <= 2f))
		{
			GetComponent<AudioSource>().pitch = 2f;
		}
		FrontLeftWheel.motorTorque = EngineTorque / GearRatio[CurrentGear] * inputTorque;
		FrontRightWheel.motorTorque = EngineTorque / GearRatio[CurrentGear] * inputTorque;
		RearLeftWheel.brakeTorque = BrakePower;
		RearRightWheel.brakeTorque = BrakePower;
		FrontLeftWheel.steerAngle = steeringSharpness * inputSteer;
		FrontRightWheel.steerAngle = steeringSharpness * inputSteer;
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

	public void GetWaypoints()
	{
		Transform[] componentsInChildren = waypointContainer.GetComponentsInChildren<Transform>();
		waypoints = new Transform[Extensions.get_length((System.Array)componentsInChildren) - 1];
		for (int i = 0; i < Extensions.get_length((System.Array)componentsInChildren); i++)
		{
			Transform transform = componentsInChildren[i];
			if (transform != waypointContainer.transform)
			{
				waypoints[i - 1] = transform;
			}
		}
	}

	public void NavigateTowardsWaypoint()
	{
		Transform transform = this.transform;
		Vector3 position = waypoints[currentWaypoint].position;
		float x = position.x;
		Vector3 position2 = this.transform.position;
		float y = position2.y;
		Vector3 position3 = waypoints[currentWaypoint].position;
		Vector3 vector = transform.InverseTransformPoint(new Vector3(x, y, position3.z));
		inputSteer = vector.x / vector.magnitude;
		if (!(Mathf.Abs(inputSteer) >= 0.5f))
		{
			inputTorque = vector.z / vector.magnitude - Mathf.Abs(inputSteer);
		}
		else
		{
			inputTorque = 0f;
		}
		if (vector.magnitude >= 20f)
		{
			return;
		}
		currentWaypoint++;
		if (currentWaypoint >= Extensions.get_length((System.Array)waypoints))
		{
			if (loop)
			{
				currentWaypoint = 0;
			}
			else
			{
				UnityEngine.Object.Destroy(gameObject);
			}
		}
	}

	public void Main()
	{
	}
}
