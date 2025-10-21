using System;
using System.Collections.Generic;
using UnityEngine;

namespace Pegasus
{
	public class PegasusManager : MonoBehaviour
	{
		public GameObject m_target;

		public PegasusConstants.FlythroughType m_flythroughType = PegasusConstants.FlythroughType.Looped;

		public PegasusConstants.FlythroughEndAction m_flythroughEndAction;

		public PegasusConstants.TargetFrameRate m_targetFramerateType = PegasusConstants.TargetFrameRate.LeaveAlone;

		public PegasusConstants.HeightCheckType m_heightCheckType = PegasusConstants.HeightCheckType.Terrain;

		public bool m_autoStartAtRuntime = true;

		public List<PegasusPoi> m_poiList = new List<PegasusPoi>();

		public float m_minHeightAboveTerrain = 1.8f;

		public bool m_displayDebug;

		public bool m_alwaysShowGizmos = true;

		public PegasusConstants.FlythroughState m_currentState;

		public int m_currentSegmentIdx;

		public PegasusPoi m_currentSegment;

		public float m_currentSegmentDistanceTravelled;

		public float m_totalDistanceTravelled;

		public float m_totalDistanceTravelledPct;

		public float m_totalDistance;

		public TimeSpan m_totalDuration = TimeSpan.Zero;

		public float m_currentVelocity;

		public Vector3 m_currentPosition = Vector3.zero;

		public Quaternion m_currentRotation = Quaternion.identity;

		public bool m_canUpdateNow;

		public DateTime m_lastUpdateTime = DateTime.MinValue;

		public float m_frameUpdateTime = 0.0166666675f;

		public float m_frameUpdateDistance;

		public float m_rotationDamping = 0.75f;

		public float m_positionDamping = 0.3f;

		public PegasusManager m_nextPegasus;

		public bool m_alwaysShowPath;

		public bool m_showScrubber;

		public bool m_showPOIHelpers;

		public float m_poiGizmoSize = 0.75f;

		public bool m_showAdvanced;

		public float m_collisionHeightOffset = 1000f;

		public float m_managerSpeed = 8f;

		public PegasusDefaults m_defaults;

		public float m_autoRollMaxSpeed = 25f;

		public float m_autoRollMaxAngle = 15f;

		private void Start()
		{
			m_currentState = PegasusConstants.FlythroughState.Stopped;
			if (m_target == null)
			{
				if (Camera.main == null)
				{
					UnityEngine.Debug.LogWarning("Can not start Pegasus - no target has been assigned.");
					return;
				}
				if (m_displayDebug)
				{
					UnityEngine.Debug.Log("Assigning main camera to target : " + Camera.main.name);
				}
				m_target = Camera.main.gameObject;
			}
			if (m_defaults == null)
			{
				SetDefaults();
			}
			ChangeFramerate(m_targetFramerateType);
			InitialiseFlythrough();
			if (m_autoStartAtRuntime)
			{
				StartFlythrough();
			}
		}

		public void SetDefaults()
		{
			m_defaults = null;
			m_defaults = ScriptableObject.CreateInstance<PegasusDefaults>();
		}

		public void InitialiseFlythrough()
		{
			if (m_displayDebug)
			{
				UnityEngine.Debug.Log("Initialising flythrough...");
			}
			m_currentState = PegasusConstants.FlythroughState.Initialising;
			m_poiList.Clear();
			for (int i = 0; i < base.transform.childCount; i++)
			{
				m_poiList.Add(base.transform.GetChild(i).GetComponent<PegasusPoi>());
			}
			PegasusPoi pegasusPoi = null;
			for (int i = 0; i < m_poiList.Count; i++)
			{
				pegasusPoi = m_poiList[i];
				pegasusPoi.m_segmentIndex = i;
				if (i == 0)
				{
					pegasusPoi.m_isFirstPOI = true;
				}
				else
				{
					pegasusPoi.m_isFirstPOI = false;
				}
				if (i == m_poiList.Count - 1)
				{
					pegasusPoi.m_isLastPOI = true;
				}
				else
				{
					pegasusPoi.m_isLastPOI = false;
				}
				if (m_flythroughType == PegasusConstants.FlythroughType.SingleShot)
				{
					if (pegasusPoi.m_isFirstPOI)
					{
						if (m_poiList.Count > 1)
						{
							pegasusPoi.m_prevPoi = m_poiList[1];
						}
						else
						{
							pegasusPoi.m_prevPoi = pegasusPoi;
						}
					}
					else
					{
						pegasusPoi.m_prevPoi = m_poiList[i - 1];
					}
					if (pegasusPoi.m_isLastPOI)
					{
						if (m_poiList.Count > 1)
						{
							pegasusPoi.m_nextPoi = m_poiList[i - 1];
						}
						else
						{
							pegasusPoi.m_nextPoi = pegasusPoi;
						}
					}
					else
					{
						pegasusPoi.m_nextPoi = m_poiList[i + 1];
					}
				}
				else
				{
					if (i == 0)
					{
						pegasusPoi.m_prevPoi = m_poiList[m_poiList.Count - 1];
					}
					else
					{
						pegasusPoi.m_prevPoi = m_poiList[i - 1];
					}
					if (i == m_poiList.Count - 1)
					{
						pegasusPoi.m_nextPoi = m_poiList[0];
					}
					else
					{
						pegasusPoi.m_nextPoi = m_poiList[i + 1];
					}
				}
				pegasusPoi.m_alwaysShowGizmos = m_alwaysShowGizmos;
			}
			for (int i = 0; i < m_poiList.Count; i++)
			{
				m_poiList[i].Initialise(updateSegments: false);
			}
			m_totalDuration = TimeSpan.Zero;
			m_totalDistanceTravelledPct = 0f;
			m_totalDistanceTravelled = 0f;
			m_totalDistance = 0f;
			for (int i = 0; i < m_poiList.Count; i++)
			{
				m_poiList[i].Initialise(updateSegments: true);
				m_poiList[i].m_segmentStartTime = new TimeSpan(m_totalDuration.Ticks);
				m_totalDistance += m_poiList[i].m_segmentDistance;
				m_totalDuration += m_poiList[i].m_segmentDuration;
			}
			m_currentSegmentIdx = 0;
			if (m_poiList.Count > 0)
			{
				m_currentSegment = m_poiList[m_currentSegmentIdx];
			}
			else
			{
				m_currentSegment = null;
			}
			m_currentSegmentDistanceTravelled = 0f;
			m_lastUpdateTime = DateTime.Now;
			m_canUpdateNow = true;
		}

		private void RestartFlythrough()
		{
			if (m_displayDebug)
			{
				UnityEngine.Debug.Log("Restarting flythrough...");
			}
			m_currentState = PegasusConstants.FlythroughState.Initialising;
			m_totalDistanceTravelledPct = 0f;
			m_totalDistanceTravelled = 0f;
			m_currentSegmentIdx = 0;
			if (m_poiList.Count > 0)
			{
				m_currentSegment = m_poiList[m_currentSegmentIdx];
			}
			else
			{
				m_currentSegment = null;
			}
			m_currentSegmentDistanceTravelled = 0f;
			m_lastUpdateTime = DateTime.Now;
			m_canUpdateNow = true;
		}

		public void UpdateFlythroughMetaData()
		{
			m_totalDuration = TimeSpan.Zero;
			m_totalDistance = 0f;
			for (int i = 0; i < m_poiList.Count; i++)
			{
				m_poiList[i].m_segmentStartTime = new TimeSpan(m_totalDuration.Ticks);
				m_totalDuration += m_poiList[i].m_segmentDuration;
				m_totalDistance += m_poiList[i].m_segmentDistance;
			}
		}

		public void UpdateSegmentWithDependencies(PegasusPoi segment)
		{
			if (segment == null)
			{
				UnityEngine.Debug.LogError("Attempting to update null segment!");
				return;
			}
			if (m_flythroughType == PegasusConstants.FlythroughType.SingleShot)
			{
				int segmentIndex = segment.m_segmentIndex;
				SafeInitialise(segmentIndex - 2, wrap: false, updateSegments: true);
				SafeInitialise(segmentIndex - 1, wrap: false, updateSegments: true);
				SafeInitialise(segmentIndex, wrap: false, updateSegments: true);
				SafeInitialise(segmentIndex + 1, wrap: false, updateSegments: true);
			}
			else
			{
				int segmentIndex2 = segment.m_segmentIndex;
				SafeInitialise(segmentIndex2 - 2, wrap: true, updateSegments: true);
				SafeInitialise(segmentIndex2 - 1, wrap: true, updateSegments: true);
				SafeInitialise(segmentIndex2, wrap: true, updateSegments: true);
				SafeInitialise(segmentIndex2 + 1, wrap: true, updateSegments: true);
			}
			UpdateFlythroughMetaData();
		}

		private void SafeInitialise(int idx, bool wrap, bool updateSegments)
		{
			if (!wrap)
			{
				if (idx >= 0 && idx < m_poiList.Count)
				{
					m_poiList[idx].Initialise(updateSegments);
				}
				return;
			}
			idx %= m_poiList.Count;
			if (idx < 0)
			{
				idx += m_poiList.Count;
			}
			m_poiList[idx].Initialise(updateSegments);
		}

		public void StartFlythrough(bool fullInitialise = false)
		{
			Application.runInBackground = true;
			if (fullInitialise)
			{
				InitialiseFlythrough();
			}
			else
			{
				RestartFlythrough();
			}
			if (m_displayDebug)
			{
				UnityEngine.Debug.Log("Starting flythrough..");
			}
			if (m_target != null)
			{
				m_currentSegment.CalculateProgress(0f, out m_currentVelocity, out m_currentPosition, out m_currentRotation);
				m_target.transform.rotation = m_currentRotation;
				m_target.transform.position = m_currentPosition;
				m_currentSegment.OnStartTriggers();
				m_currentState = PegasusConstants.FlythroughState.Started;
			}
			else
			{
				UnityEngine.Debug.LogWarning("Cannot start Pegasus - no target has been assigned!");
				m_currentState = PegasusConstants.FlythroughState.Stopped;
			}
		}

		public void ResumeFlythrough()
		{
			if (m_displayDebug)
			{
				UnityEngine.Debug.Log("Resuming flythrough");
			}
			if (m_currentState != PegasusConstants.FlythroughState.Paused)
			{
				UnityEngine.Debug.LogWarning("Can not resume flythrough - it was not paused.");
			}
			else
			{
				m_currentState = PegasusConstants.FlythroughState.Started;
			}
		}

		public void PauseFlythrough()
		{
			if (m_displayDebug)
			{
				UnityEngine.Debug.Log("Pausing flythrough");
			}
			m_currentState = PegasusConstants.FlythroughState.Paused;
		}

		public void StopFlythrough()
		{
			if (m_displayDebug)
			{
				UnityEngine.Debug.Log("Stopping flythrough");
			}
			m_currentState = PegasusConstants.FlythroughState.Stopped;
			m_canUpdateNow = false;
		}

		public void ChangeFramerate(PegasusConstants.TargetFrameRate newRate)
		{
			m_targetFramerateType = newRate;
			if (m_targetFramerateType != PegasusConstants.TargetFrameRate.LeaveAlone && Application.isPlaying)
			{
				switch (m_targetFramerateType)
				{
				case PegasusConstants.TargetFrameRate.NineFps:
					Application.targetFrameRate = 9;
					m_frameUpdateTime = 0.111111112f;
					break;
				case PegasusConstants.TargetFrameRate.FifteenFps:
					Application.targetFrameRate = 15;
					m_frameUpdateTime = 71f / (339f * (float)Math.PI);
					break;
				case PegasusConstants.TargetFrameRate.TwentyFourFps:
					Application.targetFrameRate = 24;
					m_frameUpdateTime = 0.0416666679f;
					break;
				case PegasusConstants.TargetFrameRate.TwentyFiveFps:
					Application.targetFrameRate = 25;
					m_frameUpdateTime = 0.04f;
					break;
				case PegasusConstants.TargetFrameRate.ThirtyFps:
					Application.targetFrameRate = 30;
					m_frameUpdateTime = 71f / (678f * (float)Math.PI);
					break;
				case PegasusConstants.TargetFrameRate.SixtyFps:
					Application.targetFrameRate = 60;
					m_frameUpdateTime = 0.0166666675f;
					break;
				case PegasusConstants.TargetFrameRate.NinetyFps:
					Application.targetFrameRate = 90;
					m_frameUpdateTime = 0.0111111114f;
					break;
				case PegasusConstants.TargetFrameRate.MaxFps:
					Application.targetFrameRate = -1;
					m_frameUpdateTime = 0f;
					break;
				}
			}
		}

		public void SetSpeed(float speed)
		{
			for (int i = 0; i < m_poiList.Count; i++)
			{
				m_poiList[i].m_startSpeed = speed;
				m_poiList[i].m_startSpeedType = PegasusConstants.SpeedType.Custom;
			}
			InitialiseFlythrough();
		}

		public void SetAutoRoll(bool autoRoll)
		{
			for (int i = 0; i < m_poiList.Count; i++)
			{
				m_poiList[i].m_autoRollOn = autoRoll;
				if (!autoRoll)
				{
					m_poiList[i].transform.localEulerAngles = Vector3.zero;
				}
			}
			InitialiseFlythrough();
		}

		public void SelectPoi(PegasusPoi poi)
		{
			for (int i = 0; i < m_poiList.Count; i++)
			{
				m_poiList[i].m_isSelected = false;
			}
			if (poi != null)
			{
				poi.m_isSelected = true;
			}
		}

		public void MovePoi(PegasusPoi poi, Vector3 movement)
		{
			poi.transform.position = GetValidatedPoiPosition(poi.transform.position + movement, poi.m_heightCheckType);
			poi.GetRelativeOffsets(poi.transform.position, poi.m_lookatLocation, out poi.m_lookAtDistance, out poi.m_lookAtHeight, out poi.m_lookAtAngle);
			UpdateSegmentWithDependencies(poi);
		}

		public void MovePoiLookat(PegasusPoi poi, Vector3 movement)
		{
			poi.m_lookatType = PegasusConstants.LookatType.Target;
			Vector3 validatedLookatPosition = GetValidatedLookatPosition(poi.m_lookatLocation + movement, poi.m_heightCheckType);
			if (validatedLookatPosition != poi.m_lookatLocation)
			{
				poi.m_lookatLocation = validatedLookatPosition;
				poi.m_lookatType = PegasusConstants.LookatType.Target;
				poi.GetRelativeOffsets(poi.transform.position, poi.m_lookatLocation, out poi.m_lookAtDistance, out poi.m_lookAtHeight, out poi.m_lookAtAngle);
				UpdateSegmentWithDependencies(poi);
			}
		}

		public void MoveTargetNow()
		{
			MoveTargetTo(m_totalDistanceTravelled / m_totalDistance);
		}

		public void MoveTargetTo(float percent)
		{
			if (m_target == null)
			{
				UnityEngine.Debug.LogWarning("Can not move target as none has been set");
				return;
			}
			float num = percent * m_totalDistance;
			float num2 = 0f;
			float num3 = 0f;
			int num4 = 0;
			PegasusPoi pegasusPoi;
			while (true)
			{
				if (num4 < m_poiList.Count)
				{
					pegasusPoi = m_poiList[num4];
					num3 = num2 + pegasusPoi.m_segmentDistance;
					if (num >= num2 && num <= num3)
					{
						break;
					}
					num2 += pegasusPoi.m_segmentDistance;
					num4++;
					continue;
				}
				return;
			}
			m_totalDistanceTravelled = num;
			m_totalDistanceTravelledPct = m_totalDistanceTravelled / m_totalDistance;
			m_currentPosition = pegasusPoi.CalculatePositionLinear((num - num2) / pegasusPoi.m_segmentDistance);
			m_currentRotation = pegasusPoi.CalculateRotation((num - num2) / pegasusPoi.m_segmentDistance);
			m_currentVelocity = pegasusPoi.CalculateVelocity((num - num2) / pegasusPoi.m_segmentDistance);
			m_target.transform.position = m_currentPosition;
			m_target.transform.rotation = m_currentRotation;
		}

		public void CalculateTargetAtDistance(float distance, out Vector3 position, out Quaternion rotation, out float velocity)
		{
			if (m_target == null || m_poiList.Count == 0)
			{
				position = Vector3.zero;
				rotation = Quaternion.identity;
				velocity = 0f;
				return;
			}
			float num;
			if (m_flythroughType == PegasusConstants.FlythroughType.SingleShot)
			{
				num = Mathf.Clamp(distance, 0f, m_totalDistance);
			}
			else
			{
				num = distance % m_totalDistance;
				if (num < 0f)
				{
					num += m_totalDistance;
				}
			}
			float num2 = 0f;
			float num3 = 0f;
			for (int i = 0; i < m_poiList.Count; i++)
			{
				PegasusPoi pegasusPoi = m_poiList[i];
				num3 = num2 + pegasusPoi.m_segmentDistance;
				if (num >= num2 && num <= num3)
				{
					position = pegasusPoi.CalculatePositionLinear((num - num2) / pegasusPoi.m_segmentDistance);
					rotation = pegasusPoi.CalculateRotation((num - num2) / pegasusPoi.m_segmentDistance);
					velocity = pegasusPoi.CalculateVelocity((num - num2) / pegasusPoi.m_segmentDistance);
					return;
				}
				num2 += pegasusPoi.m_segmentDistance;
			}
			position = m_poiList[m_poiList.Count - 1].transform.position;
			rotation = m_poiList[m_poiList.Count - 1].transform.localRotation;
			velocity = m_poiList[m_poiList.Count - 1].m_startSpeed;
		}

		public void CalculateTargetAtPercent(float percent, out Vector3 position, out Quaternion rotation, out float velocity)
		{
			float distance = Mathf.Clamp(percent, 0f, 100f) * m_totalDistance;
			CalculateTargetAtDistance(distance, out position, out rotation, out velocity);
		}

		public void MoveTargetToPoi(PegasusPoi targetPoi)
		{
			if (m_target == null)
			{
				UnityEngine.Debug.LogWarning("Can not move target as none has been set");
				return;
			}
			m_totalDistanceTravelled = 0f;
			for (int i = 0; i < m_poiList.Count; i++)
			{
				if (m_poiList[i].GetInstanceID() == targetPoi.GetInstanceID())
				{
					m_totalDistanceTravelledPct = m_totalDistanceTravelled / m_totalDistance;
					m_currentPosition = targetPoi.CalculatePositionLinear(0f);
					m_currentRotation = targetPoi.CalculateRotation(0f);
					m_currentVelocity = targetPoi.CalculateVelocity(0f);
					m_target.transform.position = m_currentPosition;
					m_target.transform.rotation = m_currentRotation;
				}
				else
				{
					m_totalDistanceTravelled += m_poiList[i].m_segmentDistance;
				}
			}
		}

		public void StepTargetBackward(float distMeters)
		{
			m_totalDistanceTravelled -= distMeters;
			if (m_totalDistanceTravelled < 0f)
			{
				m_totalDistanceTravelled = 0f;
			}
			MoveTargetTo(m_totalDistanceTravelled / m_totalDistance);
		}

		public void StepTargetForward(float distMeters)
		{
			m_totalDistanceTravelled += distMeters;
			if (m_totalDistanceTravelled > m_totalDistance)
			{
				m_totalDistanceTravelled = m_totalDistance;
			}
			MoveTargetTo(m_totalDistanceTravelled / m_totalDistance);
		}

		public void CreateDebugObjects()
		{
			for (int i = 0; i < m_poiList.Count; i++)
			{
				PegasusPoi pegasusPoi = m_poiList[i];
				if (pegasusPoi.transform.childCount == 0)
				{
					GameObject gameObject = GameObject.CreatePrimitive(PrimitiveType.Cube);
					UnityEngine.Object.DestroyImmediate(gameObject.GetComponent<BoxCollider>());
					gameObject.transform.position = pegasusPoi.transform.position;
					gameObject.transform.localScale = new Vector3(0.05f, 10f, 0.05f);
					gameObject.transform.parent = pegasusPoi.transform;
					gameObject = GameObject.CreatePrimitive(PrimitiveType.Cube);
					UnityEngine.Object.DestroyImmediate(gameObject.GetComponent<BoxCollider>());
					gameObject.transform.position = pegasusPoi.transform.position;
					gameObject.transform.localScale = new Vector3(0.05f, 0.05f, 5f);
					gameObject.transform.parent = pegasusPoi.transform;
					gameObject = GameObject.CreatePrimitive(PrimitiveType.Cube);
					UnityEngine.Object.DestroyImmediate(gameObject.GetComponent<BoxCollider>());
					gameObject.transform.position = pegasusPoi.transform.position;
					gameObject.transform.localScale = new Vector3(5f, 0.05f, 0.05f);
					gameObject.transform.parent = pegasusPoi.transform;
				}
			}
		}

		public void DeleteDebugObjects()
		{
			for (int i = 0; i < m_poiList.Count; i++)
			{
				PegasusPoi pegasusPoi = m_poiList[i];
				while (pegasusPoi.transform.childCount > 0)
				{
					UnityEngine.Object.DestroyImmediate(pegasusPoi.transform.GetChild(0).gameObject);
				}
			}
		}

		public Vector3 GetValidatedPoiPosition(Vector3 source, PegasusConstants.PoiHeightCheckType heightCheckOverride = PegasusConstants.PoiHeightCheckType.ManagerSettings)
		{
			PegasusConstants.HeightCheckType heightCheckType = m_heightCheckType;
			switch (heightCheckOverride)
			{
			case PegasusConstants.PoiHeightCheckType.Collision:
				heightCheckType = PegasusConstants.HeightCheckType.Collision;
				break;
			case PegasusConstants.PoiHeightCheckType.Terrain:
				heightCheckType = PegasusConstants.HeightCheckType.Terrain;
				break;
			default:
				heightCheckType = PegasusConstants.HeightCheckType.None;
				break;
			case PegasusConstants.PoiHeightCheckType.ManagerSettings:
				break;
			}
			switch (heightCheckType)
			{
			case PegasusConstants.HeightCheckType.None:
				return source;
			case PegasusConstants.HeightCheckType.Collision:
				if (Physics.Raycast(new Vector3(source.x, source.y + m_collisionHeightOffset, source.z), Vector3.down, out RaycastHit hitInfo, 10000f))
				{
					Vector3 point = hitInfo.point;
					if (point.y + m_minHeightAboveTerrain > source.y)
					{
						Vector3 point2 = hitInfo.point;
						source.y = point2.y + m_minHeightAboveTerrain;
					}
				}
				return source;
			default:
			{
				Terrain terrain = GetTerrain(source);
				if (terrain != null)
				{
					float num = terrain.SampleHeight(source);
					if (num + m_minHeightAboveTerrain > source.y)
					{
						source.y = num + m_minHeightAboveTerrain;
					}
				}
				return source;
			}
			}
		}

		public Vector3 GetLowestPoiPosition(Vector3 source, PegasusConstants.PoiHeightCheckType heightCheckOverride = PegasusConstants.PoiHeightCheckType.ManagerSettings)
		{
			PegasusConstants.HeightCheckType heightCheckType = m_heightCheckType;
			switch (heightCheckOverride)
			{
			case PegasusConstants.PoiHeightCheckType.Collision:
				heightCheckType = PegasusConstants.HeightCheckType.Collision;
				break;
			case PegasusConstants.PoiHeightCheckType.Terrain:
				heightCheckType = PegasusConstants.HeightCheckType.Terrain;
				break;
			default:
				heightCheckType = PegasusConstants.HeightCheckType.None;
				break;
			case PegasusConstants.PoiHeightCheckType.ManagerSettings:
				break;
			}
			switch (heightCheckType)
			{
			case PegasusConstants.HeightCheckType.None:
				return source;
			case PegasusConstants.HeightCheckType.Collision:
				if (Physics.Raycast(new Vector3(source.x, source.y + m_collisionHeightOffset, source.z), Vector3.down, out RaycastHit hitInfo, 10000f))
				{
					Vector3 point = hitInfo.point;
					source.y = point.y + m_minHeightAboveTerrain;
				}
				return source;
			default:
			{
				Terrain terrain = GetTerrain(source);
				if (terrain != null)
				{
					source.y = terrain.SampleHeight(source) + m_minHeightAboveTerrain;
				}
				return source;
			}
			}
		}

		public Vector3 GetValidatedLookatPosition(Vector3 source, PegasusConstants.PoiHeightCheckType heightCheckOverride = PegasusConstants.PoiHeightCheckType.ManagerSettings)
		{
			PegasusConstants.HeightCheckType heightCheckType = m_heightCheckType;
			switch (heightCheckOverride)
			{
			case PegasusConstants.PoiHeightCheckType.Collision:
				heightCheckType = PegasusConstants.HeightCheckType.Collision;
				break;
			case PegasusConstants.PoiHeightCheckType.Terrain:
				heightCheckType = PegasusConstants.HeightCheckType.Terrain;
				break;
			default:
				heightCheckType = PegasusConstants.HeightCheckType.None;
				break;
			case PegasusConstants.PoiHeightCheckType.ManagerSettings:
				break;
			}
			switch (heightCheckType)
			{
			case PegasusConstants.HeightCheckType.None:
				return source;
			case PegasusConstants.HeightCheckType.Collision:
				if (Physics.Raycast(new Vector3(source.x, source.y + m_collisionHeightOffset, source.z), Vector3.down, out RaycastHit hitInfo, 2000f))
				{
					Vector3 point = hitInfo.point;
					if (point.y > source.y)
					{
						Vector3 point2 = hitInfo.point;
						source.y = point2.y;
					}
				}
				return source;
			default:
			{
				Terrain terrain = GetTerrain(source);
				if (terrain != null)
				{
					float num = terrain.SampleHeight(source);
					if (num > source.y)
					{
						source.y = num;
					}
				}
				return source;
			}
			}
		}

		public Vector3 GetLowestLookatPosition(Vector3 source, PegasusConstants.PoiHeightCheckType heightCheckOverride = PegasusConstants.PoiHeightCheckType.ManagerSettings)
		{
			PegasusConstants.HeightCheckType heightCheckType = m_heightCheckType;
			switch (heightCheckOverride)
			{
			case PegasusConstants.PoiHeightCheckType.Collision:
				heightCheckType = PegasusConstants.HeightCheckType.Collision;
				break;
			case PegasusConstants.PoiHeightCheckType.Terrain:
				heightCheckType = PegasusConstants.HeightCheckType.Terrain;
				break;
			default:
				heightCheckType = PegasusConstants.HeightCheckType.None;
				break;
			case PegasusConstants.PoiHeightCheckType.ManagerSettings:
				break;
			}
			switch (heightCheckType)
			{
			case PegasusConstants.HeightCheckType.None:
				return source;
			case PegasusConstants.HeightCheckType.Collision:
				if (Physics.Raycast(new Vector3(source.x, source.y + m_collisionHeightOffset, source.z), Vector3.down, out RaycastHit hitInfo, 2000f))
				{
					Vector3 point = hitInfo.point;
					source.y = point.y;
				}
				return source;
			default:
			{
				Terrain terrain = GetTerrain(source);
				if (terrain != null)
				{
					source.y = terrain.SampleHeight(source);
				}
				return source;
			}
			}
		}

		public float GetValidatedLookatHeightRelativeToMinimum(Vector3 source, PegasusConstants.PoiHeightCheckType heightCheckOverride = PegasusConstants.PoiHeightCheckType.ManagerSettings)
		{
			Vector3 lowestLookatPosition = GetLowestLookatPosition(source, heightCheckOverride);
			return source.y - lowestLookatPosition.y;
		}

		public Terrain GetTerrain(Vector3 location)
		{
			Vector3 vector = default(Vector3);
			Vector3 vector2 = default(Vector3);
			Terrain activeTerrain = Terrain.activeTerrain;
			if (activeTerrain != null)
			{
				vector = activeTerrain.GetPosition();
				vector2 = vector + activeTerrain.terrainData.size;
				if (location.x >= vector.x && location.x <= vector2.x && location.z >= vector.z && location.z <= vector2.z)
				{
					return activeTerrain;
				}
			}
			for (int i = 0; i < Terrain.activeTerrains.Length; i++)
			{
				activeTerrain = Terrain.activeTerrains[i];
				vector = activeTerrain.GetPosition();
				vector2 = vector + activeTerrain.terrainData.size;
				if (location.x >= vector.x && location.x <= vector2.x && location.z >= vector.z && location.z <= vector2.z)
				{
					return activeTerrain;
				}
			}
			return null;
		}

		private void LateUpdate()
		{
			if (m_currentState == PegasusConstants.FlythroughState.Paused)
			{
				m_lastUpdateTime = DateTime.Now;
			}
			if (m_currentState != PegasusConstants.FlythroughState.Started)
			{
				return;
			}
			CalculateFlythroughUpdates();
			if (m_canUpdateNow && m_target != null)
			{
				if (m_rotationDamping > 0f)
				{
					m_target.transform.rotation = Quaternion.Slerp(m_target.transform.rotation, m_currentRotation, Time.deltaTime * (1f / m_rotationDamping));
				}
				else
				{
					m_target.transform.rotation = m_currentRotation;
				}
				if (m_positionDamping > 0f)
				{
					m_target.transform.position = Vector3.Slerp(m_target.transform.position, m_currentPosition, Time.deltaTime * (1f / m_positionDamping));
				}
				else
				{
					m_target.transform.position = m_currentPosition;
				}
				m_canUpdateNow = false;
			}
		}

		private void CalculateFlythroughUpdates()
		{
			if (!(m_currentSegment != null))
			{
				return;
			}
			m_currentSegment.CalculateProgress(m_currentSegmentDistanceTravelled / m_currentSegment.m_segmentDistance, out m_currentVelocity, out m_currentPosition, out m_currentRotation);
			if (m_targetFramerateType == PegasusConstants.TargetFrameRate.MaxFps || m_targetFramerateType == PegasusConstants.TargetFrameRate.LeaveAlone)
			{
				m_frameUpdateTime = (float)(DateTime.Now - m_lastUpdateTime).Milliseconds / 1000f;
				m_lastUpdateTime = DateTime.Now;
			}
			m_frameUpdateDistance = m_frameUpdateTime * m_currentVelocity;
			m_currentSegmentDistanceTravelled += m_frameUpdateDistance;
			m_totalDistanceTravelled += m_frameUpdateDistance;
			m_totalDistanceTravelledPct = m_totalDistanceTravelled / m_totalDistance;
			if (m_currentSegmentDistanceTravelled >= m_currentSegment.m_segmentDistance)
			{
				m_currentSegment.OnEndTriggers();
				m_currentSegmentIdx++;
				if (m_currentSegmentIdx >= m_poiList.Count)
				{
					if (m_flythroughType != PegasusConstants.FlythroughType.Looped)
					{
						m_currentSegmentIdx--;
						m_currentSegmentDistanceTravelled = m_currentSegment.m_segmentDistance;
						m_totalDistanceTravelled = m_totalDistance;
						m_totalDistanceTravelledPct = 1f;
						if (m_flythroughEndAction == PegasusConstants.FlythroughEndAction.StopFlythrough)
						{
							StopFlythrough();
							return;
						}
						if (m_flythroughEndAction == PegasusConstants.FlythroughEndAction.QuitApplication)
						{
							StopFlythrough();
							Application.Quit();
							return;
						}
						StopFlythrough();
						if (m_nextPegasus != null)
						{
							m_nextPegasus.StartFlythrough();
						}
						else
						{
							UnityEngine.Debug.Log("Next Pegasus has not been configured. Can not start.");
						}
						return;
					}
					m_currentSegmentIdx = 0;
					m_currentSegmentDistanceTravelled -= m_currentSegment.m_segmentDistance;
					m_totalDistanceTravelled = m_currentSegmentDistanceTravelled;
				}
				else
				{
					m_currentSegmentDistanceTravelled -= m_currentSegment.m_segmentDistance;
				}
				m_totalDistanceTravelledPct = m_totalDistanceTravelled / m_totalDistance;
				m_currentSegment = m_poiList[m_currentSegmentIdx];
				m_currentSegment.OnStartTriggers();
				if (m_currentState != PegasusConstants.FlythroughState.Started)
				{
					m_canUpdateNow = false;
					return;
				}
			}
			m_currentSegment.OnUpdateTriggers(m_currentSegmentDistanceTravelled / m_currentSegment.m_segmentDistance);
			m_canUpdateNow = true;
		}

		public void AddPOI(Vector3 targetLocation, Vector3 lookatLocation)
		{
			GameObject gameObject = new GameObject("POI " + m_poiList.Count);
			gameObject.transform.parent = base.transform;
			gameObject.transform.position = targetLocation;
			PegasusPoi pegasusPoi = gameObject.AddComponent<PegasusPoi>();
			pegasusPoi.m_manager = this;
			pegasusPoi.m_lookatLocation = lookatLocation;
			if (targetLocation != lookatLocation)
			{
				pegasusPoi.m_lookatType = PegasusConstants.LookatType.Target;
			}
			pegasusPoi.m_startSpeedType = m_defaults.m_flyThroughSpeed;
			m_poiList.Add(pegasusPoi);
			InitialiseFlythrough();
		}

		public PegasusPoi AddPoiAfter(PegasusPoi currentPoi)
		{
			GameObject gameObject = new GameObject("POI " + m_poiList.Count);
			PegasusPoi pegasusPoi = gameObject.AddComponent<PegasusPoi>();
			pegasusPoi.m_manager = this;
			pegasusPoi.m_startSpeedType = m_defaults.m_flyThroughSpeed;
			m_poiList.Insert(m_poiList.IndexOf(currentPoi) + 1, pegasusPoi);
			Vector3 validatedPoiPosition = GetValidatedPoiPosition(currentPoi.CalculatePositionLinear(0.5f), pegasusPoi.m_heightCheckType);
			gameObject.transform.position = validatedPoiPosition;
			gameObject.transform.parent = base.transform;
			gameObject.transform.SetSiblingIndex(currentPoi.m_segmentIndex + 1);
			InitialiseFlythrough();
			return pegasusPoi;
		}

		public PegasusPoi AddPoiBefore(PegasusPoi currentPoi)
		{
			return AddPoiAfter(GetPrevPOI(currentPoi));
		}

		public PegasusPoi GetFirstPOI()
		{
			if (m_poiList.Count < 1)
			{
				return null;
			}
			return m_poiList[0];
		}

		public PegasusPoi GetPOI(int poiIndex)
		{
			if (m_poiList.Count == 0 || poiIndex < 0 || poiIndex >= m_poiList.Count)
			{
				return null;
			}
			return m_poiList[poiIndex];
		}

		public PegasusPoi GetPrevPOI(PegasusPoi currentPoi, bool wrap = true)
		{
			if (currentPoi != null)
			{
				if (currentPoi.m_segmentIndex > 0)
				{
					return m_poiList[currentPoi.m_segmentIndex - 1];
				}
				if (wrap)
				{
					return m_poiList[m_poiList.Count - 1];
				}
				return null;
			}
			return null;
		}

		public PegasusPoi GetNextPOI(PegasusPoi currentPoi, bool wrap = true)
		{
			if (currentPoi != null)
			{
				if (currentPoi.m_segmentIndex < m_poiList.Count - 1)
				{
					return m_poiList[currentPoi.m_segmentIndex + 1];
				}
				if (wrap)
				{
					return m_poiList[0];
				}
				return null;
			}
			return null;
		}

		public void SetPoiToMinHeight()
		{
			for (int i = 0; i < m_poiList.Count; i++)
			{
				PegasusPoi pegasusPoi = m_poiList[i];
				pegasusPoi.transform.position = pegasusPoi.m_manager.GetLowestPoiPosition(pegasusPoi.transform.position, pegasusPoi.m_heightCheckType);
			}
			InitialiseFlythrough();
		}
	}
}
