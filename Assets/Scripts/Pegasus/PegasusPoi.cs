using System;
using System.Collections.Generic;
using UnityEngine;

namespace Pegasus
{
	public class PegasusPoi : MonoBehaviour
	{
		private delegate float Easing(float time, float duration = 1f);

		[Tooltip("The type of POI. Auto generated POI's are subject to automatic deletion. Manual POI's will always be kept.")]
		public PegasusConstants.PoiType m_poiType;

		[Tooltip("The mechanism used to check height for the POI.")]
		public PegasusConstants.PoiHeightCheckType m_heightCheckType;

		[Tooltip("The lookat type for this POI segement. Changing this will re-generate the lookat location.")]
		public PegasusConstants.LookatType m_lookatType;

		[Tooltip("The lookat angle from the POI.")]
		public float m_lookAtAngle;

		[Tooltip("The lookat distance from the POI.")]
		public float m_lookAtDistance;

		[Tooltip("The lookat height above the ground from the POI.")]
		public float m_lookAtHeight;

		[Tooltip("The actual lookat location for the POI segment.")]
		public Vector3 m_lookatLocation = Vector3.zero;

		[Tooltip("The start speed type for this segment. The segement will always start at this speed and ease to the next segments start speed.")]
		public PegasusConstants.SpeedType m_startSpeedType = PegasusConstants.SpeedType.Medium;

		[Tooltip("The actual start speed for this segment. Speed varies between stat speed for this segment and start speed for next segment.")]
		public float m_startSpeed = 1f;

		[HideInInspector]
		public PegasusConstants.EasingType m_rotationEasingType;

		[HideInInspector]
		public PegasusConstants.EasingType m_velocityEasingType = PegasusConstants.EasingType.EaseInOut;

		[HideInInspector]
		public PegasusConstants.EasingType m_positionEasingType;

		[HideInInspector]
		public PegasusManager m_manager;

		[HideInInspector]
		public bool m_alwaysShowGizmos = true;

		[HideInInspector]
		public float m_segmentDistance;

		[HideInInspector]
		public TimeSpan m_segmentStartTime = TimeSpan.Zero;

		[HideInInspector]
		public TimeSpan m_segmentDuration = TimeSpan.Zero;

		[HideInInspector]
		public int m_segmentIndex;

		[HideInInspector]
		public bool m_isFirstPOI = true;

		[HideInInspector]
		public bool m_isLastPOI = true;

		[HideInInspector]
		public PegasusPoi m_prevPoi;

		[HideInInspector]
		public PegasusPoi m_nextPoi;

		[HideInInspector]
		public List<Vector3> m_poiSteps = new List<Vector3>();

		[HideInInspector]
		public bool m_isSelected;

		[HideInInspector]
		public List<TriggerBase> m_poiTriggers = new List<TriggerBase>();

		[HideInInspector]
		public bool m_autoRollOn;

		[HideInInspector]
		public Vector3 m_lastRotation = Vector3.zero;

		private Easing m_velocityEasingCalculator = EaseLinear;

		private Easing m_positionEasingCalculator = EaseLinear;

		private Easing m_rotationEasingCalculator = EaseLinear;

		public Quaternion m_rotationStart = Quaternion.identity;

		public Quaternion m_rotationEnd = Quaternion.identity;

		private void OnDrawGizmosSelected()
		{
			DrawGizmos(isSelected: true);
		}

		private void OnDrawGizmos()
		{
			DrawGizmos(isSelected: false);
		}

		private void DrawGizmos(bool isSelected)
		{
			if (!isSelected && !m_alwaysShowGizmos)
			{
				return;
			}
			if (base.transform.parent.childCount != m_manager.m_poiList.Count)
			{
				m_manager.InitialiseFlythrough();
			}
			float num = 249.99f;
			if (m_nextPoi != null)
			{
				bool flag = true;
				if (m_isLastPOI && m_manager.m_flythroughType == PegasusConstants.FlythroughType.SingleShot)
				{
					flag = false;
				}
				if (flag)
				{
					float num2 = 0.05f;
					Vector3 from = CalculatePositionSpline(0f);
					float num3 = CalculateVelocity(0f);
					for (float num4 = num2; num4 <= 1.02f; num4 += num2)
					{
						Vector3 vector = CalculatePositionLinear(num4);
						float num5 = CalculateVelocity(num4);
						if (m_isSelected)
						{
							Gizmos.color = Color.magenta * Color.Lerp(Color.cyan, Color.red, (num3 + num5 / 2f - 0.01f) / num);
						}
						else
						{
							Gizmos.color = Color.Lerp(Color.cyan, Color.red, (num3 + num5 / 2f - 0.01f) / num);
						}
						Gizmos.DrawLine(from, vector);
						num3 = num5;
						from = vector;
					}
				}
			}
			if (m_lookatType == PegasusConstants.LookatType.Target)
			{
				Gizmos.color = Color.Lerp(Color.cyan, Color.red, (m_startSpeed - 0.01f) / num);
				Gizmos.DrawLine(base.transform.position, m_lookatLocation);
				Gizmos.color = Color.cyan;
				Gizmos.DrawSphere(m_lookatLocation, 0.25f);
			}
			Gizmos.color = Color.yellow;
			if (m_isLastPOI && m_manager.m_flythroughType == PegasusConstants.FlythroughType.SingleShot && m_manager.m_flythroughEndAction == PegasusConstants.FlythroughEndAction.PlayNextPegasus && m_manager.m_nextPegasus != null)
			{
				PegasusPoi firstPOI = m_manager.m_nextPegasus.GetFirstPOI();
				if (firstPOI != null)
				{
					Gizmos.DrawLine(base.transform.position, firstPOI.transform.position);
				}
			}
			Gizmos.DrawSphere(base.transform.position, m_manager.m_poiGizmoSize);
		}

		public bool IsSameObject(PegasusPoi poi)
		{
			if (poi == null)
			{
				return false;
			}
			if (GetInstanceID() == poi.GetInstanceID())
			{
				return true;
			}
			return false;
		}

		public void Initialise(bool updateSegments)
		{
			if (m_prevPoi == null || m_nextPoi == null)
			{
				return;
			}
			base.transform.position = m_manager.GetValidatedPoiPosition(base.transform.position, m_heightCheckType);
			m_lastRotation = base.transform.rotation.eulerAngles;
			switch (m_velocityEasingType)
			{
			case PegasusConstants.EasingType.Linear:
				m_velocityEasingCalculator = EaseLinear;
				break;
			case PegasusConstants.EasingType.EaseIn:
				m_velocityEasingCalculator = EaseIn;
				break;
			case PegasusConstants.EasingType.EaseOut:
				m_velocityEasingCalculator = EaseOut;
				break;
			case PegasusConstants.EasingType.EaseInOut:
				m_velocityEasingCalculator = EaseInOut;
				break;
			}
			switch (m_rotationEasingType)
			{
			case PegasusConstants.EasingType.Linear:
				m_rotationEasingCalculator = EaseLinear;
				break;
			case PegasusConstants.EasingType.EaseIn:
				m_rotationEasingCalculator = EaseIn;
				break;
			case PegasusConstants.EasingType.EaseOut:
				m_rotationEasingCalculator = EaseOut;
				break;
			case PegasusConstants.EasingType.EaseInOut:
				m_rotationEasingCalculator = EaseInOut;
				break;
			}
			switch (m_positionEasingType)
			{
			case PegasusConstants.EasingType.Linear:
				m_positionEasingCalculator = EaseLinear;
				break;
			case PegasusConstants.EasingType.EaseIn:
				m_positionEasingCalculator = EaseIn;
				break;
			case PegasusConstants.EasingType.EaseOut:
				m_positionEasingCalculator = EaseOut;
				break;
			case PegasusConstants.EasingType.EaseInOut:
				m_positionEasingCalculator = EaseInOut;
				break;
			}
			switch (m_lookatType)
			{
			case PegasusConstants.LookatType.Path:
				m_lookatLocation = CalculatePositionSpline(0.005f);
				GetRelativeOffsets(base.transform.position, m_lookatLocation, out m_lookAtDistance, out m_lookAtHeight, out m_lookAtAngle);
				break;
			case PegasusConstants.LookatType.Target:
				GetRelativeOffsets(base.transform.position, m_lookatLocation, out m_lookAtDistance, out m_lookAtHeight, out m_lookAtAngle);
				break;
			}
			if (m_autoRollOn && (m_manager.m_flythroughType == PegasusConstants.FlythroughType.Looped || (!m_isFirstPOI && !m_isLastPOI)))
			{
				Vector3 position = m_prevPoi.transform.position;
				Vector3 position2 = base.transform.position;
				Vector3 position3 = m_nextPoi.transform.position;
				Vector3 vector = position2 - position;
				Quaternion quaternion = Quaternion.identity;
				if (vector != Vector3.zero)
				{
					quaternion = Quaternion.LookRotation(vector);
				}
				Vector3 vector2 = position3 - position2;
				Quaternion quaternion2 = Quaternion.identity;
				if (vector2 != Vector3.zero)
				{
					quaternion2 = Quaternion.LookRotation(vector2);
				}
				Vector3 eulerAngles = quaternion2.eulerAngles;
				float y = eulerAngles.y;
				Vector3 eulerAngles2 = quaternion.eulerAngles;
				float num = y - eulerAngles2.y;
				float num2 = Mathf.Clamp(m_startSpeed, 0.01f, m_manager.m_autoRollMaxSpeed) / m_manager.m_autoRollMaxSpeed;
				float num3 = num;
				num3 = ((!(num < 0f)) ? (Mathf.Clamp(num, 0f, 90f) / 90f) : (Mathf.Clamp(num, -90f, 0f) / 90f));
				float z = num3 * num2 * m_manager.m_autoRollMaxAngle * -1f;
				base.transform.localRotation = Quaternion.Euler(0f, 0f, z);
				m_lastRotation = base.transform.localEulerAngles;
			}
			Vector3 lhs = m_lookatLocation - base.transform.position;
			if (lhs != Vector3.zero)
			{
				m_rotationStart = Quaternion.LookRotation(m_lookatLocation - base.transform.position) * base.transform.localRotation;
			}
			else
			{
				m_rotationStart = base.transform.localRotation;
			}
			lhs = m_nextPoi.m_lookatLocation - m_nextPoi.transform.position;
			if (lhs != Vector3.zero)
			{
				m_rotationEnd = Quaternion.LookRotation(lhs) * m_nextPoi.transform.localRotation;
			}
			else
			{
				m_rotationEnd = m_nextPoi.transform.localRotation;
			}
			switch (m_startSpeedType)
			{
			case PegasusConstants.SpeedType.ReallySlow:
				m_startSpeed = 0.01f;
				break;
			case PegasusConstants.SpeedType.Slow:
				m_startSpeed = 1.4f;
				break;
			case PegasusConstants.SpeedType.Medium:
				m_startSpeed = 8f;
				break;
			case PegasusConstants.SpeedType.Fast:
				m_startSpeed = 25f;
				break;
			case PegasusConstants.SpeedType.ReallyFast:
				m_startSpeed = 70f;
				break;
			case PegasusConstants.SpeedType.Stratospheric:
				m_startSpeed = 250f;
				break;
			}
			if (updateSegments)
			{
				UpdateSegment();
			}
			m_poiTriggers.Clear();
			m_poiTriggers.AddRange(base.gameObject.GetComponentsInChildren<TriggerBase>());
		}

		public void OnStartTriggers()
		{
			for (int i = 0; i < m_poiTriggers.Count; i++)
			{
				m_poiTriggers[i].OnStart(this);
			}
		}

		public void OnUpdateTriggers(float progress)
		{
			for (int i = 0; i < m_poiTriggers.Count; i++)
			{
				m_poiTriggers[i].OnUpdate(this, progress);
			}
		}

		public void OnEndTriggers()
		{
			for (int i = 0; i < m_poiTriggers.Count; i++)
			{
				m_poiTriggers[i].OnEnd(this);
			}
		}

		public float GetStartSpeed(PegasusConstants.SpeedType speedType)
		{
			switch (speedType)
			{
			case PegasusConstants.SpeedType.ReallySlow:
				return 0.01f;
			case PegasusConstants.SpeedType.Slow:
				return 1.4f;
			case PegasusConstants.SpeedType.Medium:
				return 8f;
			case PegasusConstants.SpeedType.Fast:
				return 25f;
			case PegasusConstants.SpeedType.ReallyFast:
				return 70f;
			case PegasusConstants.SpeedType.Stratospheric:
				return 250f;
			default:
				return m_startSpeed;
			}
		}

		public void UpdateSegment()
		{
			m_segmentDistance = 0f;
			m_segmentDuration = TimeSpan.Zero;
			m_segmentStartTime = TimeSpan.Zero;
			if (!m_isFirstPOI)
			{
				m_segmentStartTime = m_prevPoi.m_segmentStartTime + m_prevPoi.m_segmentDuration;
			}
			m_poiSteps.Clear();
			if (m_manager.m_flythroughType == PegasusConstants.FlythroughType.SingleShot && m_manager.GetNextPOI(this, wrap: false) == null)
			{
				return;
			}
			float num = 0f;
			Vector3 zero = Vector3.zero;
			Vector3 zero2 = Vector3.zero;
			if (m_nextPoi != null)
			{
				int num2 = 3;
				int num3 = num2 * 20;
				float num4 = Vector3.Distance(base.transform.position, m_nextPoi.transform.position);
				int num5 = (int)Mathf.Ceil((float)num3 * num4);
				float num6 = 1f / (float)num5;
				float num7 = 0f;
				float num8 = 0f;
				float num9 = 0f;
				float num10 = 0f;
				float num11 = 0f;
				float num12 = 0f;
				float num13 = 0f;
				zero = base.transform.position;
				int i = 1;
				num = 0f;
				num9 = 0f;
				num10 = 0f;
				for (; i <= num5; i++)
				{
					num += num6;
					zero2 = CalculatePositionSpline(num);
					zero2 = m_manager.GetValidatedPoiPosition(zero2, m_heightCheckType);
					num7 = Vector3.Distance(zero, zero2);
					m_segmentDistance += num7;
					zero = zero2;
					if (ApproximatelyEqual(num9, 0f) || num7 < num9)
					{
						num9 = num7;
					}
					if (ApproximatelyEqual(num10, 0f) || num7 > num10)
					{
						num10 = num7;
					}
				}
				if (m_segmentDistance < 2f)
				{
					num2 *= 3;
				}
				float num14 = 1f / (float)num2;
				num14 = m_segmentDistance / Mathf.Floor(m_segmentDistance / num14);
				zero = base.transform.position;
				m_poiSteps.Add(zero);
				i = 1;
				num = 0f;
				num12 = 0f;
				num13 = 0f;
				for (; i <= num5; i++)
				{
					num += num6;
					zero2 = CalculatePositionSpline(num);
					zero2 = m_manager.GetValidatedPoiPosition(zero2, m_heightCheckType);
					num7 = Vector3.Distance(zero, zero2);
					num8 += num7;
					if (num8 >= num14)
					{
						if (ApproximatelyEqual(num12, 0f) || num8 < num12)
						{
							num12 = num8;
						}
						if (ApproximatelyEqual(num13, 0f) || num8 > num13)
						{
							num13 = num8;
						}
						while (num8 >= num14)
						{
							m_poiSteps.Add(Vector3.Lerp(m_poiSteps[m_poiSteps.Count - 1], zero2, num14 / num8));
							num8 -= num14;
							num11 += num14;
						}
					}
					zero = zero2;
				}
				if ((num11 - m_segmentDistance) / num14 < -0.5f)
				{
					m_poiSteps.Add(m_nextPoi.transform.position);
				}
				else
				{
					m_poiSteps[m_poiSteps.Count - 1] = m_nextPoi.transform.position;
				}
			}
			UpdateSegmentDuration();
		}

		public void UpdateSegmentDuration()
		{
			m_segmentDuration = TimeSpan.Zero;
			float num = 0f;
			Vector3 a = CalculatePositionLinear(0f);
			Vector3 zero = Vector3.zero;
			float num2 = 0f;
			for (num = 0f; num < 1f; num += 0.05f)
			{
				zero = CalculatePositionLinear(num);
				num2 += Vector3.Distance(a, zero) / CalculateVelocity(num);
				a = zero;
			}
			m_segmentDuration = TimeSpan.FromSeconds(num2);
		}

		public void CalculateProgress(float percent, out float velocity, out Vector3 position, out Quaternion rotation)
		{
			velocity = CalculateVelocity(percent);
			rotation = CalculateRotation(percent);
			position = CalculatePositionLinear(percent);
		}

		public Vector3 CalculatePositionSpline(float percent)
		{
			return CatmullRom(m_prevPoi.transform.position, base.transform.position, m_nextPoi.transform.position, m_nextPoi.m_nextPoi.transform.position, percent);
		}

		public Vector3 CalculatePositionLinear(float percent)
		{
			percent = m_positionEasingCalculator(percent);
			if (m_poiSteps.Count == 0)
			{
				return Vector3.zero;
			}
			if (m_poiSteps.Count == 1)
			{
				return m_poiSteps[0];
			}
			int num = m_poiSteps.Count - 1;
			int num2 = (int)(percent * (float)num);
			if (num2 == num)
			{
				return m_poiSteps[num2];
			}
			float t = percent * (float)num - (float)num2;
			return Vector3.Lerp(m_poiSteps[num2], m_poiSteps[num2 + 1], t);
		}

		public float CalculateVelocity(float percent)
		{
			return Mathf.Lerp(m_startSpeed, m_nextPoi.m_startSpeed, m_velocityEasingCalculator(percent));
		}

		public Quaternion CalculateRotation(float percent)
		{
			return Quaternion.Lerp(m_rotationStart, m_rotationEnd, m_rotationEasingCalculator(percent));
		}

		public void GetRelativeOffsets(Vector3 source, Vector3 target, out float targetDistance, out float targetHeight, out float targetAngle)
		{
			targetHeight = m_manager.GetValidatedLookatHeightRelativeToMinimum(target, m_heightCheckType);
			targetDistance = Vector3.Distance(b: new Vector3(target.x, source.y, target.z), a: source);
			Vector3 vector = source - target;
			if (vector != Vector3.zero)
			{
				Vector3 eulerAngles = Quaternion.LookRotation(vector, Vector3.up).eulerAngles;
				targetAngle = eulerAngles.y;
			}
			else
			{
				targetAngle = 0f;
			}
		}

		public static bool ApproximatelyEqual(float a, float b)
		{
			if (a == b || Mathf.Abs(a - b) < float.Epsilon)
			{
				return true;
			}
			return false;
		}

		public static Vector3 RotatePointAroundPivot(Vector3 point, Vector3 pivot, Vector3 angle)
		{
			Vector3 point2 = point - pivot;
			point2 = Quaternion.Euler(angle) * point2;
			point = point2 + pivot;
			return point;
		}

		private static float EaseLinear(float time, float duration = 1f)
		{
			return time / duration;
		}

		private static float EaseIn(float time, float duration = 1f)
		{
			return (time /= duration) * time;
		}

		private static float EaseOut(float time, float duration = 1f)
		{
			return -1f * (time /= duration) * (time - 2f);
		}

		private static float EaseInOut(float time, float duration = 1f)
		{
			if ((time /= duration / 2f) < 1f)
			{
				return 0.5f * time * time;
			}
			return -0.5f * ((time -= 1f) * (time - 2f) - 1f);
		}

		public static Vector3 CatmullRom(Vector3 value1, Vector3 value2, Vector3 value3, Vector3 value4, float amount)
		{
			return new Vector3(CalcCatmullRom(value1.x, value2.x, value3.x, value4.x, amount), CalcCatmullRom(value1.y, value2.y, value3.y, value4.y, amount), CalcCatmullRom(value1.z, value2.z, value3.z, value4.z, amount));
		}

		public static void CatmullRom(ref Vector3 value1, ref Vector3 value2, ref Vector3 value3, ref Vector3 value4, float amount, out Vector3 result)
		{
			result.x = CalcCatmullRom(value1.x, value2.x, value3.x, value4.x, amount);
			result.y = CalcCatmullRom(value1.y, value2.y, value3.y, value4.y, amount);
			result.z = CalcCatmullRom(value1.z, value2.z, value3.z, value4.z, amount);
		}

		public static float CalcCatmullRom(float value1, float value2, float value3, float value4, float amount)
		{
			double num = amount * amount;
			double num2 = num * (double)amount;
			return (float)(0.5 * (2.0 * (double)value2 + (double)((value3 - value1) * amount) + (2.0 * (double)value1 - 5.0 * (double)value2 + 4.0 * (double)value3 - (double)value4) * num + (3.0 * (double)value2 - (double)value1 - 3.0 * (double)value3 + (double)value4) * num2));
		}

		public static Vector3 Hermite(Vector3 value1, Vector3 tangent1, Vector3 value2, Vector3 tangent2, float amount)
		{
			return new Vector3(CalcHermite(value1.x, tangent1.x, value2.x, tangent2.x, amount), CalcHermite(value1.y, tangent1.y, value2.y, tangent2.y, amount), CalcHermite(value1.z, tangent1.z, value2.z, tangent2.z, amount));
		}

		public static void Hermite(ref Vector3 value1, ref Vector3 tangent1, ref Vector3 value2, ref Vector3 tangent2, float amount, out Vector3 result)
		{
			result.x = CalcHermite(value1.x, tangent1.x, value2.x, tangent2.x, amount);
			result.y = CalcHermite(value1.y, tangent1.y, value2.y, tangent2.y, amount);
			result.z = CalcHermite(value1.z, tangent1.z, value2.z, tangent2.z, amount);
		}

		public static float CalcHermite(float value1, float tangent1, float value2, float tangent2, float amount)
		{
			double num = value1;
			double num2 = value2;
			double num3 = tangent1;
			double num4 = tangent2;
			double num5 = amount;
			double num6 = num5 * num5 * num5;
			double num7 = num5 * num5;
			double num8 = (amount == 0f) ? ((double)value1) : ((amount != 1f) ? ((2.0 * num - 2.0 * num2 + num4 + num3) * num6 + (3.0 * num2 - 3.0 * num - 2.0 * num3 - num4) * num7 + num3 * num5 + num) : ((double)value2));
			return (float)num8;
		}
	}
}
