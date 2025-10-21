using UnityEngine;

namespace EVP
{
	public class VehicleTelemetry : MonoBehaviour
	{
		public enum DataMode
		{
			TireSlipAndForce,
			GroundMaterial
		}

		public VehicleController target;

		public DataMode dataMode;

		public Font font;

		public KeyCode toggleKey = KeyCode.Y;

		public bool show = true;

		public bool gizmos;

		public bool gizmosAtPhysicsPos;

		private string m_telemetryText = string.Empty;

		private GUIStyle m_style = new GUIStyle();

		private void OnEnable()
		{
			m_style.font = font;
			m_style.fontSize = 10;
			m_style.normal.textColor = Color.white;
			if (target == null)
			{
				target = GetComponent<VehicleController>();
			}
		}

		private void Update()
		{
			if (target != null && show)
			{
				m_telemetryText = DoTelemetry();
			}
			if (target != null && gizmos)
			{
				DrawGizmos();
			}
			if (!Input.GetKeyDown(toggleKey))
			{
				return;
			}
			if (UnityEngine.Input.GetKey(KeyCode.LeftShift) || UnityEngine.Input.GetKey(KeyCode.RightShift))
			{
				dataMode++;
				if (dataMode > DataMode.GroundMaterial)
				{
					dataMode = DataMode.TireSlipAndForce;
				}
			}
			else
			{
				show = !show;
			}
		}

		private void OnGUI()
		{
			if (target != null && show)
			{
				GUI.Box(new Rect(8f, 8f, 545f, 180f), "Telemetry");
				GUI.Label(new Rect(16f, 28f, 400f, 270f), m_telemetryText, m_style);
			}
		}

		private string DoTelemetry()
		{
			string text = string.Format("V: {0,5:0.0} m/s  {1,5:0.0} km/h {2,5:0.0} mph  {3,5:0.0}º\n\n", target.speed, target.speed * 3.6f, target.speed * 2.237f, target.speedAngle);
			float suspensionForce = 0f;
			WheelData[] wheelData = target.wheelData;
			foreach (WheelData wd in wheelData)
			{
				text += GetWheelTelemetry(wd, ref suspensionForce);
			}
			string str = text;
			object arg = suspensionForce;
			float num = 0f - suspensionForce;
			Vector3 gravity = Physics.gravity;
			text = str + string.Format("\n     ΣF:{0,6:0.}  Perceived mass:{1,7:0.0}\n                Rigidbody mass:{2,7:0.0}\n", arg, num / gravity.y, target.cachedRigidbody.mass);
			VehicleAudio component = target.GetComponent<VehicleAudio>();
			if (component != null)
			{
				text += string.Format("\nAudio gear/rpm:{0,2:0.} {1,5:0.}", component.simulatedGear, component.simulatedEngineRpm);
			}
			VehicleDamage component2 = target.GetComponent<VehicleDamage>();
			if (component2 != null)
			{
				text += string.Format("\nDamage mesh/collider/node:{0,5:0.00} {1,4:0.00} {2,4:0.00}  {3}", component2.meshDamage, component2.colliderDamage, component2.nodeDamage, (!component2.isRepairing) ? string.Empty : "REPAIRING");
			}
			if (target.debugText != string.Empty)
			{
				text = text + "\n\n" + target.debugText;
			}
			return text;
		}

		private string GetWheelTelemetry(WheelData wd, ref float suspensionForce)
		{
			bool flag = !(wd.collider.motorTorque > 0f);
			string str = string.Format("{0,-10}{1}{2,5:0.} rpm  ", wd.collider.gameObject.name, (!flag) ? ":" : "×", wd.angularVelocity * VehicleController.WToRpm);
			if (wd.grounded)
			{
				str += string.Format("C:{0,5:0.00}  ", wd.suspensionCompression);
				switch (dataMode)
				{
				case DataMode.TireSlipAndForce:
					str += string.Format("F:{0,5:0.}  ", wd.downforce);
					str += string.Format("Sx:{0,6:0.00} Sy:{1,6:0.00} ", wd.tireSlip.x, wd.tireSlip.y);
					str += string.Format("Fx:{0,5:0.} Fy:{1,5:0.}  ", wd.tireForce.x, wd.tireForce.y);
					break;
				case DataMode.GroundMaterial:
					str += string.Format("F:{0,4:0.0} %  ", wd.downforceRatio);
					str += string.Format("Slip:{0,4:0.0}  ", wd.combinedTireSlip);
					if (wd.groundMaterial != null)
					{
						str += string.Format("Grip:{0,4:0.0} Drag:{1,4:0.0}  [{2}]", wd.groundMaterial.grip, wd.groundMaterial.drag, (!(wd.groundMaterial.physicMaterial != null)) ? "no mat" : wd.groundMaterial.physicMaterial.name);
					}
					break;
				}
				suspensionForce += wd.hit.force;
			}
			else
			{
				str += $"C: 0.--  ";
			}
			return str + "\n";
		}

		private void DrawGizmos()
		{
			CommonTools.DrawCrossMark(target.cachedTransform.TransformPoint(target.cachedRigidbody.centerOfMass), target.cachedTransform, Color.white);
			WheelData[] wheelData = target.wheelData;
			foreach (WheelData wd in wheelData)
			{
				DrawWheelGizmos(wd);
			}
		}

		private void DrawWheelGizmos(WheelData wd)
		{
			RaycastHit hitInfo = default(RaycastHit);
			bool flag;
			if (gizmosAtPhysicsPos)
			{
				flag = wd.grounded;
				hitInfo.point = wd.hit.point;
				hitInfo.normal = wd.hit.normal;
			}
			else
			{
				bool flag2 = Physics.Raycast(wd.transform.TransformPoint(wd.collider.center), -wd.transform.up, out hitInfo, wd.collider.suspensionDistance + wd.collider.radius, -5);
				flag = (wd.grounded && flag2);
			}
			if (flag)
			{
				UnityEngine.Debug.DrawLine(hitInfo.point, hitInfo.point + wd.transform.up * (wd.downforce / 10000f), (!(wd.suspensionCompression > 0.99f)) ? Color.white : Color.magenta);
				CommonTools.DrawCrossMark(wd.transform.position, wd.transform, Color.Lerp(Color.green, Color.gray, 0.5f));
				Vector3 sidewaysForceAppPoint = target.GetSidewaysForceAppPoint(wd, hitInfo.point);
				CommonTools.DrawCrossMark(sidewaysForceAppPoint, wd.transform, Color.Lerp(Color.yellow, Color.gray, 0.5f));
				Vector3 val = wd.hit.forwardDir * wd.tireForce.y + wd.hit.sidewaysDir * wd.tireForce.x;
				UnityEngine.Debug.DrawLine(sidewaysForceAppPoint, sidewaysForceAppPoint + CommonTools.Lin2Log(val) * 0.1f, Color.green);
				Vector3 val2 = wd.hit.forwardDir * wd.tireSlip.y + wd.hit.sidewaysDir * wd.tireSlip.x;
				UnityEngine.Debug.DrawLine(hitInfo.point, hitInfo.point + CommonTools.Lin2Log(val2) * 0.5f, Color.cyan);
			}
		}
	}
}
