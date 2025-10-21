using System;
using System.Collections.Generic;
using UnityEngine;

namespace DigitalOpus.MB.Core
{
	[Serializable]
	public class MB3_MeshBakerGrouperPie : MB3_MeshBakerGrouperCore
	{
		public MB3_MeshBakerGrouperPie(GrouperData data)
		{
			d = data;
		}

		public override Dictionary<string, List<Renderer>> FilterIntoGroups(List<GameObject> selection)
		{
			Dictionary<string, List<Renderer>> dictionary = new Dictionary<string, List<Renderer>>();
			if (d.pieNumSegments == 0)
			{
				UnityEngine.Debug.LogError("pieNumSegments must be greater than zero.");
				return dictionary;
			}
			if (d.pieAxis.magnitude <= 1E-06f)
			{
				UnityEngine.Debug.LogError("Pie axis must have length greater than zero.");
				return dictionary;
			}
			d.pieAxis.Normalize();
			Quaternion rotation = Quaternion.FromToRotation(d.pieAxis, Vector3.up);
			UnityEngine.Debug.Log("Collecting renderers in each cell");
			foreach (GameObject item in selection)
			{
				if (!(item == null))
				{
					GameObject gameObject = item;
					Renderer component = gameObject.GetComponent<Renderer>();
					if (component is MeshRenderer || component is SkinnedMeshRenderer)
					{
						Vector3 point = component.bounds.center - d.origin;
						point.Normalize();
						point = rotation * point;
						float num = 0f;
						if (Mathf.Abs(point.x) < 0.0001f && Mathf.Abs(point.z) < 0.0001f)
						{
							num = 0f;
						}
						else
						{
							num = Mathf.Atan2(point.x, point.z) * 57.29578f;
							if (num < 0f)
							{
								num = 360f + num;
							}
						}
						int num2 = Mathf.FloorToInt(num / 360f * (float)d.pieNumSegments);
						List<Renderer> list = null;
						string key = "seg_" + num2;
						if (dictionary.ContainsKey(key))
						{
							list = dictionary[key];
						}
						else
						{
							list = new List<Renderer>();
							dictionary.Add(key, list);
						}
						if (!list.Contains(component))
						{
							list.Add(component);
						}
					}
				}
			}
			return dictionary;
		}

		public override void DrawGizmos(Bounds sourceObjectBounds)
		{
			if (!(d.pieAxis.magnitude < 0.1f) && d.pieNumSegments >= 1)
			{
				float magnitude = sourceObjectBounds.extents.magnitude;
				DrawCircle(d.pieAxis, d.origin, magnitude, 24);
				Quaternion rotation = Quaternion.FromToRotation(Vector3.up, d.pieAxis);
				Quaternion rotation2 = Quaternion.AngleAxis(180f / (float)d.pieNumSegments, Vector3.up);
				Vector3 point = Vector3.forward;
				for (int i = 0; i < d.pieNumSegments; i++)
				{
					Vector3 a = rotation * point;
					Gizmos.DrawLine(d.origin, d.origin + a * magnitude);
					point = rotation2 * point;
					point = rotation2 * point;
				}
			}
		}

		public static void DrawCircle(Vector3 axis, Vector3 center, float radius, int subdiv)
		{
			Quaternion rotation = Quaternion.AngleAxis(360 / subdiv, axis);
			Vector3 a = new Vector3(axis.y, 0f - axis.x, axis.z);
			a.Normalize();
			a *= radius;
			for (int i = 0; i < subdiv + 1; i++)
			{
				Vector3 vector = rotation * a;
				Gizmos.DrawLine(center + a, center + vector);
				a = vector;
			}
		}
	}
}
