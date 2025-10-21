using System;
using System.Collections.Generic;
using UnityEngine;

namespace Pegasus
{
	[Serializable]
	public class PegasusPath : ScriptableObject
	{
		[Serializable]
		public class PegasusPoint
		{
			public Vector3 m_location;

			public Vector3 m_rotationEuler;

			public Vector3 m_dofDistance;

			public PegasusPoint(Vector3 location, Vector3 rotationEuler)
			{
				m_location = location;
				m_rotationEuler = rotationEuler;
			}
		}

		public float m_defaultSpeed = 8f;

		public List<PegasusPoint> m_path = new List<PegasusPoint>();

		public static PegasusPath CreatePegasusPath()
		{
			return ScriptableObject.CreateInstance<PegasusPath>();
		}

		public void AddPoint(GameObject go)
		{
			if (go == null)
			{
				return;
			}
			Vector3 position = go.transform.position;
			Vector3 eulerAngles = go.transform.eulerAngles;
			PegasusPoint pegasusPoint = null;
			if (m_path.Count > 0)
			{
				pegasusPoint = m_path[m_path.Count - 1];
				if (pegasusPoint.m_location == position && pegasusPoint.m_rotationEuler != eulerAngles)
				{
					return;
				}
			}
			m_path.Add(new PegasusPoint(position, eulerAngles));
		}

		public void ClearPath()
		{
			m_path.Clear();
		}

		public void CreatePegasusFromPath()
		{
			if (m_path.Count != 0)
			{
				GameObject gameObject = new GameObject("Pegasus Manager");
				PegasusManager pegasusManager = gameObject.AddComponent<PegasusManager>();
				pegasusManager.SetDefaults();
				pegasusManager.m_heightCheckType = PegasusConstants.HeightCheckType.None;
				pegasusManager.m_minHeightAboveTerrain = 0.1f;
				pegasusManager.m_flythroughType = PegasusConstants.FlythroughType.SingleShot;
				PegasusPoint pegasusPoint = null;
				for (int i = 0; i < m_path.Count; i++)
				{
					pegasusPoint = m_path[i];
					pegasusManager.AddPOI(pegasusPoint.m_location, pegasusPoint.m_location + Quaternion.Euler(pegasusPoint.m_rotationEuler) * (Vector3.forward * 2f));
				}
				pegasusManager.SetSpeed(m_defaultSpeed);
			}
		}
	}
}
