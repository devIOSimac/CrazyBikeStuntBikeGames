using System;
using UnityEngine;

namespace EVP
{
	[RequireComponent(typeof(VehicleController))]
	public class VehicleDamage : MonoBehaviour
	{
		public MeshFilter[] meshes;

		public MeshCollider[] colliders;

		public Transform[] nodes;

		[Space(5f)]
		public float minVelocity = 1f;

		public float multiplier = 1f;

		[Space(5f)]
		public float damageRadius = 1f;

		public float maxDisplacement = 0.5f;

		public float maxVertexFracture = 0.1f;

		[Space(5f)]
		public float nodeDamageRadius = 0.5f;

		public float maxNodeRotation = 14f;

		public float nodeRotationRate = 10f;

		[Space(5f)]
		public float vertexRepairRate = 0.1f;

		public bool enableRepairKey = true;

		public KeyCode repairKey = KeyCode.R;

		private VehicleController m_vehicle;

		private Vector3[][] m_originalMeshes;

		private Vector3[][] m_originalColliders;

		private Vector3[] m_originalNodePositions;

		private Quaternion[] m_originalNodeRotations;

		private bool m_repairing;

		private float m_meshDamage;

		private float m_colliderDamage;

		private float m_nodeDamage;

		public bool isRepairing => m_repairing;

		public float meshDamage => m_meshDamage;

		public float colliderDamage => m_colliderDamage;

		public float nodeDamage => m_nodeDamage;

		private void OnEnable()
		{
			m_vehicle = GetComponent<VehicleController>();
			m_vehicle.processContacts = true;
			VehicleController vehicle = m_vehicle;
			vehicle.onImpact = (VehicleController.OnImpact)Delegate.Combine(vehicle.onImpact, new VehicleController.OnImpact(ProcessImpact));
			m_originalMeshes = new Vector3[meshes.Length][];
			for (int i = 0; i < meshes.Length; i++)
			{
				Mesh mesh = meshes[i].mesh;
				m_originalMeshes[i] = mesh.vertices;
				mesh.MarkDynamic();
			}
			m_originalColliders = new Vector3[colliders.Length][];
			for (int j = 0; j < colliders.Length; j++)
			{
				Mesh sharedMesh = colliders[j].sharedMesh;
				m_originalColliders[j] = sharedMesh.vertices;
				sharedMesh.MarkDynamic();
			}
			m_originalNodePositions = new Vector3[nodes.Length];
			m_originalNodeRotations = new Quaternion[nodes.Length];
			for (int k = 0; k < nodes.Length; k++)
			{
				m_originalNodePositions[k] = nodes[k].transform.localPosition;
				m_originalNodeRotations[k] = nodes[k].transform.localRotation;
			}
			m_repairing = false;
			m_meshDamage = 0f;
			m_colliderDamage = 0f;
			m_nodeDamage = 0f;
		}

		private void OnDisable()
		{
			RestoreMeshes();
			RestoreNodes();
			RestoreColliders();
			m_repairing = false;
			m_meshDamage = 0f;
			m_colliderDamage = 0f;
			m_nodeDamage = 0f;
		}

		private void Update()
		{
			if (enableRepairKey && UnityEngine.Input.GetKeyDown(repairKey))
			{
				m_repairing = true;
			}
			ProcessRepair();
		}

		public void Repair()
		{
			m_repairing = true;
		}

		private void ProcessImpact()
		{
			Vector3 vector = Vector3.zero;
			if (m_vehicle.localImpactVelocity.sqrMagnitude > minVelocity * minVelocity)
			{
				vector = m_vehicle.cachedTransform.TransformDirection(m_vehicle.localImpactVelocity) * multiplier * 0.02f;
			}
			if (vector.sqrMagnitude > 0f)
			{
				Vector3 contactPoint = base.transform.TransformPoint(m_vehicle.localImpactPosition);
				int i = 0;
				for (int num = meshes.Length; i < num; i++)
				{
					m_meshDamage += DeformMesh(meshes[i].mesh, m_originalMeshes[i], meshes[i].transform, contactPoint, vector);
				}
				m_colliderDamage = DeformColliders(contactPoint, vector);
				int j = 0;
				for (int num2 = nodes.Length; j < num2; j++)
				{
					m_nodeDamage += DeformNode(nodes[j], m_originalNodePositions[j], m_originalNodeRotations[j], contactPoint, vector * 0.5f);
				}
			}
		}

		private float DeformMesh(Mesh mesh, Vector3[] originalMesh, Transform localTransform, Vector3 contactPoint, Vector3 contactVelocity)
		{
			Vector3[] vertices = mesh.vertices;
			float num = damageRadius * damageRadius;
			float num2 = maxDisplacement * maxDisplacement;
			Vector3 a = localTransform.InverseTransformPoint(contactPoint);
			Vector3 a2 = localTransform.InverseTransformDirection(contactVelocity);
			float num3 = 0f;
			int num4 = 0;
			for (int i = 0; i < vertices.Length; i++)
			{
				float sqrMagnitude = (a - vertices[i]).sqrMagnitude;
				if (sqrMagnitude < num)
				{
					Vector3 vector = a2 * (damageRadius - Mathf.Sqrt(sqrMagnitude)) / damageRadius + UnityEngine.Random.onUnitSphere * maxVertexFracture;
					vertices[i] += vector;
					Vector3 vector2 = vertices[i] - originalMesh[i];
					if (vector2.sqrMagnitude > num2)
					{
						vertices[i] = originalMesh[i] + vector2.normalized * maxDisplacement;
					}
					num3 += vector.magnitude;
					num4++;
				}
			}
			mesh.vertices = vertices;
			mesh.RecalculateNormals();
			mesh.RecalculateBounds();
			return (num4 <= 0) ? 0f : (num3 / (float)num4);
		}

		private float DeformNode(Transform T, Vector3 originalLocalPos, Quaternion originalLocalRot, Vector3 contactPoint, Vector3 contactVelocity)
		{
			float sqrMagnitude = (contactPoint - T.position).sqrMagnitude;
			float num = (damageRadius - Mathf.Sqrt(sqrMagnitude)) / damageRadius;
			float num2 = 0f;
			if (sqrMagnitude < damageRadius * damageRadius)
			{
				Vector3 vector = contactVelocity * num + UnityEngine.Random.onUnitSphere * maxVertexFracture;
				T.position += vector;
				Vector3 vector2 = T.localPosition - originalLocalPos;
				if (vector2.sqrMagnitude > maxDisplacement * maxDisplacement)
				{
					T.localPosition = originalLocalPos + vector2.normalized * maxDisplacement;
				}
				num2 += vector.magnitude;
			}
			if (sqrMagnitude < nodeDamageRadius * nodeDamageRadius)
			{
				Vector3 a = AnglesToVector(T.localEulerAngles);
				Vector3 b = new Vector3(maxNodeRotation, maxNodeRotation, maxNodeRotation);
				Vector3 vector3 = a + b;
				Vector3 vector4 = a - b;
				Vector3 b2 = num * nodeRotationRate * UnityEngine.Random.onUnitSphere;
				a += b2;
				T.localEulerAngles = new Vector3(Mathf.Clamp(a.x, vector4.x, vector3.x), Mathf.Clamp(a.y, vector4.y, vector3.y), Mathf.Clamp(a.z, vector4.z, vector3.z));
				num2 += b2.magnitude / 45f;
			}
			return num2;
		}

		private Vector3 AnglesToVector(Vector3 Angles)
		{
			if (Angles.x > 180f)
			{
				Angles.x = -360f + Angles.x;
			}
			if (Angles.y > 180f)
			{
				Angles.y = -360f + Angles.y;
			}
			if (Angles.z > 180f)
			{
				Angles.z = -360f + Angles.z;
			}
			return Angles;
		}

		private float DeformColliders(Vector3 contactPoint, Vector3 impactVelocity)
		{
			if (colliders.Length > 0)
			{
				Vector3 centerOfMass = m_vehicle.cachedRigidbody.centerOfMass;
				float num = 0f;
				int i = 0;
				for (int num2 = colliders.Length; i < num2; i++)
				{
					Mesh mesh = new Mesh();
					mesh.vertices = colliders[i].sharedMesh.vertices;
					mesh.triangles = colliders[i].sharedMesh.triangles;
					num += DeformMesh(mesh, m_originalColliders[i], colliders[i].transform, contactPoint, impactVelocity);
					colliders[i].sharedMesh = mesh;
				}
				m_vehicle.cachedRigidbody.centerOfMass = centerOfMass;
				return num;
			}
			return 0f;
		}

		private void ProcessRepair()
		{
			if (m_repairing)
			{
				float repairedThreshold = 0.002f;
				bool flag = true;
				int i = 0;
				for (int num = meshes.Length; i < num; i++)
				{
					flag = (RepairMesh(meshes[i].mesh, m_originalMeshes[i], vertexRepairRate, repairedThreshold) && flag);
				}
				int j = 0;
				for (int num2 = nodes.Length; j < num2; j++)
				{
					flag = (RepairNode(nodes[j], m_originalNodePositions[j], m_originalNodeRotations[j], vertexRepairRate, repairedThreshold) && flag);
				}
				if (flag)
				{
					m_repairing = false;
					m_meshDamage = 0f;
					m_colliderDamage = 0f;
					m_nodeDamage = 0f;
					RestoreNodes();
					RestoreColliders();
				}
			}
		}

		private bool RepairMesh(Mesh mesh, Vector3[] originalMesh, float repairRate, float repairedThreshold)
		{
			bool result = true;
			Vector3[] vertices = mesh.vertices;
			repairRate *= Time.deltaTime;
			repairedThreshold *= repairedThreshold;
			int i = 0;
			for (int num = vertices.Length; i < num; i++)
			{
				vertices[i] = Vector3.MoveTowards(vertices[i], originalMesh[i], repairRate);
				if ((originalMesh[i] - vertices[i]).sqrMagnitude >= repairedThreshold)
				{
					result = false;
				}
			}
			mesh.vertices = vertices;
			mesh.RecalculateNormals();
			mesh.RecalculateBounds();
			return result;
		}

		private bool RepairNode(Transform T, Vector3 originalLocalPosition, Quaternion originalLocalRotation, float repairRate, float repairedThreshold)
		{
			repairRate *= Time.deltaTime;
			T.localPosition = Vector3.MoveTowards(T.localPosition, originalLocalPosition, repairRate);
			T.localRotation = Quaternion.RotateTowards(T.localRotation, originalLocalRotation, repairRate * 50f);
			return (originalLocalPosition - T.localPosition).sqrMagnitude < repairedThreshold * repairedThreshold && Quaternion.Angle(originalLocalRotation, T.localRotation) < repairedThreshold;
		}

		private void RestoreMeshes()
		{
			int i = 0;
			for (int num = meshes.Length; i < num; i++)
			{
				Mesh mesh = meshes[i].mesh;
				mesh.vertices = m_originalMeshes[i];
				mesh.RecalculateNormals();
				mesh.RecalculateBounds();
			}
		}

		private void RestoreNodes()
		{
			int i = 0;
			for (int num = nodes.Length; i < num; i++)
			{
				nodes[i].localPosition = m_originalNodePositions[i];
				nodes[i].localRotation = m_originalNodeRotations[i];
			}
		}

		private void RestoreColliders()
		{
			if (colliders.Length > 0)
			{
				Vector3 centerOfMass = m_vehicle.cachedRigidbody.centerOfMass;
				int i = 0;
				for (int num = colliders.Length; i < num; i++)
				{
					Mesh mesh = new Mesh();
					mesh.vertices = m_originalColliders[i];
					mesh.triangles = colliders[i].sharedMesh.triangles;
					mesh.RecalculateNormals();
					mesh.RecalculateBounds();
					colliders[i].sharedMesh = mesh;
				}
				m_vehicle.cachedRigidbody.centerOfMass = centerOfMass;
			}
		}
	}
}
