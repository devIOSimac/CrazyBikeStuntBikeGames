using System;
using System.Collections.Generic;
using UnityEngine;

namespace DigitalOpus.MB.Core
{
	[Serializable]
	public class MB3_MeshBakerGrouperGrid : MB3_MeshBakerGrouperCore
	{
		public MB3_MeshBakerGrouperGrid(GrouperData d)
		{
			base.d = d;
		}

		public override Dictionary<string, List<Renderer>> FilterIntoGroups(List<GameObject> selection)
		{
			Dictionary<string, List<Renderer>> dictionary = new Dictionary<string, List<Renderer>>();
			if (d.cellSize.x <= 0f || d.cellSize.y <= 0f || d.cellSize.z <= 0f)
			{
				UnityEngine.Debug.LogError("cellSize x,y,z must all be greater than zero.");
				return dictionary;
			}
			UnityEngine.Debug.Log("Collecting renderers in each cell");
			foreach (GameObject item in selection)
			{
				if (!(item == null))
				{
					GameObject gameObject = item;
					Renderer component = gameObject.GetComponent<Renderer>();
					if (component is MeshRenderer || component is SkinnedMeshRenderer)
					{
						Vector3 center = component.bounds.center;
						center.x = Mathf.Floor((center.x - d.origin.x) / d.cellSize.x) * d.cellSize.x;
						center.y = Mathf.Floor((center.y - d.origin.y) / d.cellSize.y) * d.cellSize.y;
						center.z = Mathf.Floor((center.z - d.origin.z) / d.cellSize.z) * d.cellSize.z;
						List<Renderer> list = null;
						string key = center.ToString();
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
			Vector3 cellSize = d.cellSize;
			if (cellSize.x <= 1E-05f || cellSize.y <= 1E-05f || cellSize.z <= 1E-05f)
			{
				return;
			}
			Vector3 vector = sourceObjectBounds.center - sourceObjectBounds.extents;
			Vector3 origin = d.origin;
			origin.x %= cellSize.x;
			origin.y %= cellSize.y;
			origin.z %= cellSize.z;
			vector.x = Mathf.Round(vector.x / cellSize.x) * cellSize.x + origin.x;
			vector.y = Mathf.Round(vector.y / cellSize.y) * cellSize.y + origin.y;
			vector.z = Mathf.Round(vector.z / cellSize.z) * cellSize.z + origin.z;
			float x = vector.x;
			Vector3 center = sourceObjectBounds.center;
			float x2 = center.x;
			Vector3 extents = sourceObjectBounds.extents;
			if (x > x2 - extents.x)
			{
				vector.x -= cellSize.x;
			}
			float y = vector.y;
			Vector3 center2 = sourceObjectBounds.center;
			float y2 = center2.y;
			Vector3 extents2 = sourceObjectBounds.extents;
			if (y > y2 - extents2.y)
			{
				vector.y -= cellSize.y;
			}
			float z = vector.z;
			Vector3 center3 = sourceObjectBounds.center;
			float z2 = center3.z;
			Vector3 extents3 = sourceObjectBounds.extents;
			if (z > z2 - extents3.z)
			{
				vector.z -= cellSize.z;
			}
			Vector3 vector2 = vector;
			Vector3 size = sourceObjectBounds.size;
			float num = size.x / cellSize.x;
			Vector3 size2 = sourceObjectBounds.size;
			float num2 = num + size2.y / cellSize.y;
			Vector3 size3 = sourceObjectBounds.size;
			int num3 = Mathf.CeilToInt(num2 + size3.z / cellSize.z);
			if (num3 > 200)
			{
				Gizmos.DrawWireCube(d.origin + cellSize / 2f, cellSize);
				return;
			}
			while (true)
			{
				float x3 = vector.x;
				Vector3 center4 = sourceObjectBounds.center;
				float x4 = center4.x;
				Vector3 extents4 = sourceObjectBounds.extents;
				if (!(x3 < x4 + extents4.x))
				{
					break;
				}
				vector.y = vector2.y;
				while (true)
				{
					float y3 = vector.y;
					Vector3 center5 = sourceObjectBounds.center;
					float y4 = center5.y;
					Vector3 extents5 = sourceObjectBounds.extents;
					if (!(y3 < y4 + extents5.y))
					{
						break;
					}
					vector.z = vector2.z;
					while (true)
					{
						float z3 = vector.z;
						Vector3 center6 = sourceObjectBounds.center;
						float z4 = center6.z;
						Vector3 extents6 = sourceObjectBounds.extents;
						if (!(z3 < z4 + extents6.z))
						{
							break;
						}
						Gizmos.DrawWireCube(vector + cellSize / 2f, cellSize);
						vector.z += cellSize.z;
					}
					vector.y += cellSize.y;
				}
				vector.x += cellSize.x;
			}
		}
	}
}
