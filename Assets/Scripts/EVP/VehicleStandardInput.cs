using CnControls;
using UnityEngine;

namespace EVP
{
	public class VehicleStandardInput : MonoBehaviour
	{
		public enum ThrottleAndBrakeInput
		{
			SingleAxis,
			SeparateAxes
		}

		public VehicleController target;

		public bool continuousForwardAndReverse = true;

		public int controlType;

		public ThrottleAndBrakeInput throttleAndBrakeInput;

		public string steerAxis = "Horizontal";

		public string throttleAndBrakeAxis = "Vertical";

		public string throttleAxis = "Fire2";

		public string brakeAxis = "Fire3";

		public string handbrakeAxis = "Jump";

		public KeyCode resetVehicleKey = KeyCode.Return;

		public float steerInput;

		private bool m_doReset;

		private void OnEnable()
		{
			if (target == null)
			{
				target = GetComponent<VehicleController>();
			}
		}

		private void Update()
		{
			if (!(target == null) && CnInputManager.GetButtonDown("resetVehicleKey"))
			{
				m_doReset = true;
			}
		}

		private void FixedUpdate()
		{
			if (target == null)
			{
				return;
			}
			if (controlType == 0)
			{
				steerInput = Mathf.Clamp(CnInputManager.GetAxis(steerAxis), -1f, 1f);
			}
			else if (controlType == 1)
			{
				steerInput = SteeringWheel.GetClampedValue();
			}
			else if (controlType == 2)
			{
				Vector3 acceleration = Input.acceleration;
				steerInput = Mathf.Clamp(acceleration.x, -1f, 1f);
			}
			float handbrakeInput = Mathf.Clamp01(CnInputManager.GetAxis(handbrakeAxis));
			float num = 0f;
			float num2 = 0f;
			if (throttleAndBrakeInput == ThrottleAndBrakeInput.SeparateAxes)
			{
				num = Mathf.Clamp01(CnInputManager.GetAxis(throttleAxis));
				num2 = Mathf.Clamp01(CnInputManager.GetAxis(brakeAxis));
			}
			else
			{
				num = Mathf.Clamp01(CnInputManager.GetAxis(throttleAndBrakeAxis));
				num2 = Mathf.Clamp01(0f - CnInputManager.GetAxis(throttleAndBrakeAxis));
			}
			float throttleInput = 0f;
			float brakeInput = 0f;
			if (continuousForwardAndReverse)
			{
				float num3 = 0.1f;
				float num4 = 0.1f;
				if (target.speed > num3)
				{
					throttleInput = num;
					brakeInput = num2;
				}
				else if (num2 > num4)
				{
					throttleInput = 0f - num2;
					brakeInput = 0f;
				}
				else if (num > num4)
				{
					if (target.speed < 0f - num3)
					{
						throttleInput = 0f;
						brakeInput = num;
					}
					else
					{
						throttleInput = num;
						brakeInput = 0f;
					}
				}
			}
			else if (!CnInputManager.GetButton("Ctrl"))
			{
				throttleInput = num;
				brakeInput = num2;
			}
			else
			{
				throttleInput = 0f - num2;
				brakeInput = 0f;
			}
			target.steerInput = steerInput;
			target.throttleInput = throttleInput;
			target.brakeInput = brakeInput;
			target.handbrakeInput = handbrakeInput;
			if (m_doReset)
			{
				target.ResetVehicle();
				m_doReset = false;
			}
		}
	}
}
