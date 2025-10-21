using System.Collections.Generic;
using UnityEngine;

namespace Pegasus
{
	public class PegasusFollow : MonoBehaviour
	{
		public Transform m_target;

		[Header("Local Overrides")]
		[Tooltip("Always show gizmo's, even when not selected")]
		public bool m_alwaysShowGizmos;

		[Tooltip("Ground character to terrain")]
		public bool m_groundToTerrain = true;

		[Tooltip("Rotate character to terrain. Best for quadrapeds.")]
		public bool m_rotateToTerrain;

		[Tooltip("Avoid collisions with terrain trees.")]
		public bool m_avoidTreeCollisions;

		[Tooltip("Avoid collisions with objects on the object collision layer.")]
		public bool m_avoidObjectCollisions;

		[Tooltip("Distance to check for collisions. Bigger values will slow your system down.")]
		[Range(1f, 10f)]
		public float m_collisionRange = 2f;

		[Tooltip("Layers to check for collisions on. Ensure that your terrain is NOT included in these layers.")]
		public LayerMask m_objectCollisionLayer;

		private int m_currentCollisionCount;

		private RaycastHit[] m_currentCollisionHitArray;

		private int m_currentTreeCollisionCount;

		private List<TreeManager.TreeStruct> m_currentTreeCollisionHitArray = new List<TreeManager.TreeStruct>();

		private TreeManager m_terrainTreeManager;

		private Dictionary<int, Collider> m_myColliders = new Dictionary<int, Collider>();

		[Header("Character Speeds")]
		[Tooltip("Walk speed")]
		public float m_walkSpeed = 2f;

		[Tooltip("Run speed")]
		public float m_runSpeed = 7f;

		[Header("Distance Thresholds")]
		[Tooltip("Minimum distance from target that character can stop.")]
		public float m_stopDistanceMin = 0.05f;

		[Tooltip("Maximum distance from target that character can stop.")]
		public float m_stopDistanceMax = 0.05f;

		private float m_currentStopDistance = 0.05f;

		private bool m_updateStopDistance;

		[Tooltip("Character will run if further away from target than this distance, otherwise will walk or is stopped.")]
		public float m_runIfFurtherThan = 15f;

		[Header("Change Rates")]
		[Range(0.001f, 3f)]
		[Tooltip("Turn rate. Lower values produce smoother turns, larger values produce more accurate turns.")]
		public float m_turnChange = 1.5f;

		[Range(0.001f, 3f)]
		[Tooltip("Movement rate. Lower values produce smoother movement, larger values produce more accurate movement.")]
		public float m_movementChange = 1.5f;

		[Header("Path Randomisation")]
		[Range(0f, 2f)]
		[Tooltip("Deviation rate. Smaller values produce slower more subtle deviations, larger values produce more obvious and rapid deviations.")]
		public float m_deviationRate;

		[Tooltip("Deviation range in X plane")]
		public float m_maxDeviationX;

		[Tooltip("Deviation range in Y plane")]
		public float m_maxDeviationY;

		[Tooltip("Deviation range in Z plane")]
		public float m_maxDeviationZ;

		private Vector3 m_targetPosition = Vector3.zero;

		private float m_distanceToTarget;

		private float m_currentMovementDistance;

		private Vector3 m_currentVelocity = Vector3.zero;

		private void Start()
		{
			if (!(m_target == null))
			{
				m_updateStopDistance = false;
				m_targetPosition = m_target.position;
				m_distanceToTarget = (m_targetPosition - base.transform.position).magnitude;
				m_currentStopDistance = UnityEngine.Random.Range(m_stopDistanceMin, m_stopDistanceMax);
				m_currentCollisionCount = 0;
				m_currentCollisionHitArray = new RaycastHit[20];
				if (m_avoidTreeCollisions)
				{
					m_terrainTreeManager = new TreeManager();
					m_terrainTreeManager.LoadTreesFromTerrain();
				}
				Collider[] componentsInChildren = GetComponentsInChildren<Collider>();
				Collider[] array = componentsInChildren;
				foreach (Collider collider in array)
				{
					m_myColliders.Add(collider.GetInstanceID(), collider);
				}
			}
		}

		private void Update()
		{
			if (m_target == null)
			{
				return;
			}
			Vector3 targetPositionWithNoise = GetTargetPositionWithNoise(m_target.position);
			targetPositionWithNoise = GetTargetPositionWithCollisions(targetPositionWithNoise);
			if (m_target.position == m_targetPosition && m_distanceToTarget <= m_currentStopDistance)
			{
				return;
			}
			m_targetPosition = targetPositionWithNoise;
			Vector3 vector = m_targetPosition - base.transform.position;
			m_distanceToTarget = vector.magnitude;
			if (m_distanceToTarget > m_currentStopDistance)
			{
				m_updateStopDistance = true;
				Vector3 vector2 = new Vector3(vector.x, 0f, vector.z);
				if (m_deviationRate > 0f && m_maxDeviationY > 0f)
				{
					vector2 = new Vector3(vector.x, vector.y, vector.z);
				}
				if (vector2 == Vector3.zero)
				{
					base.transform.rotation = Quaternion.Slerp(base.transform.rotation, Quaternion.identity, m_turnChange * Time.deltaTime);
				}
				else
				{
					base.transform.rotation = Quaternion.Slerp(base.transform.rotation, Quaternion.LookRotation(vector2), m_turnChange * Time.deltaTime);
				}
				float b = Time.deltaTime * m_walkSpeed;
				if (m_distanceToTarget > m_runIfFurtherThan)
				{
					b = Time.deltaTime * m_runSpeed;
				}
				m_currentMovementDistance = Mathf.Lerp(m_currentMovementDistance, b, m_movementChange * Time.deltaTime);
				m_currentVelocity = base.transform.forward * m_currentMovementDistance;
				base.transform.position += m_currentVelocity;
				m_currentVelocity *= 1f / Time.deltaTime;
			}
			else
			{
				m_currentMovementDistance = 0f;
				m_currentVelocity = Vector3.zero;
				if (m_updateStopDistance)
				{
					m_updateStopDistance = false;
					m_currentStopDistance = UnityEngine.Random.Range(m_stopDistanceMin, m_stopDistanceMax);
				}
			}
		}

		private void LateUpdate()
		{
			if (m_target == null)
			{
				return;
			}
			if (m_groundToTerrain || m_rotateToTerrain)
			{
				Vector3 position = base.transform.position;
				Terrain terrain = GetTerrain(position);
				if (terrain == null)
				{
					return;
				}
				position.y = terrain.SampleHeight(position);
				if (m_groundToTerrain)
				{
					base.transform.position = position;
				}
				if (m_rotateToTerrain)
				{
					Vector3 vector = terrain.transform.InverseTransformPoint(position);
					Vector3 size = terrain.terrainData.size;
					float x = Mathf.InverseLerp(0f, size.x, vector.x);
					Vector3 size2 = terrain.terrainData.size;
					float y = Mathf.InverseLerp(0f, size2.y, vector.y);
					Vector3 size3 = terrain.terrainData.size;
					Vector3 vector2 = new Vector3(x, y, Mathf.InverseLerp(0f, size3.z, vector.z));
					Vector3 interpolatedNormal = terrain.terrainData.GetInterpolatedNormal(vector2.x, vector2.z);
					base.transform.rotation = Quaternion.FromToRotation(base.transform.up, interpolatedNormal) * base.transform.rotation;
				}
			}
			if (m_avoidObjectCollisions)
			{
				m_currentCollisionCount = Physics.SphereCastNonAlloc(base.transform.position, m_collisionRange, base.transform.forward, m_currentCollisionHitArray, 0f, m_objectCollisionLayer, QueryTriggerInteraction.UseGlobal);
			}
			if (m_avoidTreeCollisions)
			{
				if (m_terrainTreeManager == null)
				{
					m_terrainTreeManager = new TreeManager();
					m_terrainTreeManager.LoadTreesFromTerrain();
				}
				m_currentTreeCollisionCount = m_terrainTreeManager.GetTrees(base.transform.position, m_collisionRange + m_collisionRange / 2f, ref m_currentTreeCollisionHitArray);
			}
		}

		private Vector3 GetTargetPositionWithNoise(Vector3 targetPosition)
		{
			if (m_deviationRate > 0f)
			{
				float num = (-0.5f + Mathf.PerlinNoise(targetPosition.x * m_deviationRate, targetPosition.z * m_deviationRate)) * 2f;
				Vector3 b = new Vector3(num * m_maxDeviationX, num * m_maxDeviationY, num * m_maxDeviationZ);
				targetPosition += b;
			}
			return targetPosition;
		}

		private Vector3 GetTargetPositionWithCollisions(Vector3 targetPosition)
		{
			if (m_currentCollisionCount == 0 && m_currentTreeCollisionCount == 0)
			{
				return targetPosition;
			}
			float num = 0f;
			float num2 = 0f;
			float num3 = 0f;
			float num4 = m_collisionRange * m_collisionRange;
			Vector3 vector = Vector3.zero;
			Vector3 position = base.transform.position;
			position += m_currentVelocity * 0.5f;
			for (int i = 0; i < m_currentCollisionCount; i++)
			{
				if (m_myColliders.ContainsKey(m_currentCollisionHitArray[i].collider.GetInstanceID()))
				{
					continue;
				}
				Vector3 direction = m_currentCollisionHitArray[i].transform.position - position;
				if (Physics.Raycast(position, direction, out RaycastHit hitInfo, m_collisionRange, m_objectCollisionLayer))
				{
					Vector3 a = position - hitInfo.point;
					num2 = a.sqrMagnitude;
					num = Mathf.Abs(1f - num2 / num4);
					if (num > 0f)
					{
						num3 = num * (num4 / num2);
						a *= num3;
						vector += a;
					}
				}
			}
			for (int j = 0; j < m_currentTreeCollisionCount; j++)
			{
				Vector3 a2 = position;
				TreeManager.TreeStruct treeStruct = m_currentTreeCollisionHitArray[j];
				Vector3 a = a2 - treeStruct.position;
				num2 = a.sqrMagnitude - 0.0625f;
				num = Mathf.Abs(1f - num2 / num4);
				if (num > 0f)
				{
					num3 = num * (num4 / num2);
					a *= num3;
					vector += a;
				}
			}
			return targetPosition + vector;
		}

		private Terrain GetTerrain(Vector3 locationWU)
		{
			Vector3 vector = default(Vector3);
			Vector3 vector2 = default(Vector3);
			Terrain activeTerrain = Terrain.activeTerrain;
			if (activeTerrain != null)
			{
				vector = activeTerrain.GetPosition();
				vector2 = vector + activeTerrain.terrainData.size;
				if (locationWU.x >= vector.x && locationWU.x <= vector2.x && locationWU.z >= vector.z && locationWU.z <= vector2.z)
				{
					return activeTerrain;
				}
			}
			for (int i = 0; i < Terrain.activeTerrains.Length; i++)
			{
				activeTerrain = Terrain.activeTerrains[i];
				vector = activeTerrain.GetPosition();
				vector2 = vector + activeTerrain.terrainData.size;
				if (locationWU.x >= vector.x && locationWU.x <= vector2.x && locationWU.z >= vector.z && locationWU.z <= vector2.z)
				{
					return activeTerrain;
				}
			}
			return null;
		}

		private void OnDrawGizmos()
		{
			DrawGizmos(isSelected: false);
		}

		private void OnDrawGizmosSelected()
		{
			DrawGizmos(isSelected: true);
		}

		private void DrawGizmos(bool isSelected)
		{
			if (!isSelected && !m_alwaysShowGizmos)
			{
				return;
			}
			Color color = Gizmos.color;
			Gizmos.color = Color.yellow;
			Gizmos.DrawLine(base.transform.position, m_targetPosition);
			if (m_avoidObjectCollisions || m_avoidTreeCollisions)
			{
				Gizmos.color = Color.cyan;
				Gizmos.DrawWireSphere(base.transform.position, m_collisionRange);
				Gizmos.color = Color.red;
				for (int i = 0; i < m_currentCollisionCount; i++)
				{
					Gizmos.DrawLine(base.transform.position, m_currentCollisionHitArray[i].transform.position);
				}
				for (int j = 0; j < m_currentTreeCollisionCount; j++)
				{
					Vector3 position = base.transform.position;
					TreeManager.TreeStruct treeStruct = m_currentTreeCollisionHitArray[j];
					Gizmos.DrawLine(position, treeStruct.position);
				}
			}
			Gizmos.color = color;
		}
	}
}
