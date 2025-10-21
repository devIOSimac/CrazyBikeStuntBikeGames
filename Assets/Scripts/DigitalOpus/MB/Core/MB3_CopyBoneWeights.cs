using System.Collections.Generic;
using UnityEngine;

namespace DigitalOpus.MB.Core
{
	public class MB3_CopyBoneWeights
	{
		public static void CopyBoneWeightsFromSeamMeshToOtherMeshes(float radius, Mesh seamMesh, Mesh[] targetMeshes)
		{
			List<int> list = new List<int>();
			if (seamMesh == null)
			{
				UnityEngine.Debug.LogError($"The SeamMesh cannot be null");
				return;
			}
			if (seamMesh.vertexCount == 0)
			{
				UnityEngine.Debug.LogError("The seam mesh has no vertices. Check that the Asset Importer for the seam mesh does not have 'Optimize Mesh' checked.");
				return;
			}
			Vector3[] vertices = seamMesh.vertices;
			BoneWeight[] boneWeights = seamMesh.boneWeights;
			Vector3[] normals = seamMesh.normals;
			Vector4[] tangents = seamMesh.tangents;
			Vector2[] uv = seamMesh.uv;
			if (uv.Length != vertices.Length)
			{
				UnityEngine.Debug.LogError("The seam mesh needs uvs to identify which vertices are part of the seam. Vertices with UV > .5 are part of the seam. Vertices with UV < .5 are not part of the seam.");
				return;
			}
			for (int i = 0; i < uv.Length; i++)
			{
				if (uv[i].x > 0.5f && uv[i].y > 0.5f)
				{
					list.Add(i);
				}
			}
			UnityEngine.Debug.Log($"The seam mesh has {seamMesh.vertices.Length} vertices of which {list.Count} are seam vertices.");
			if (list.Count == 0)
			{
				UnityEngine.Debug.LogError("None of the vertices in the Seam Mesh were marked as seam vertices. To mark a vertex as a seam vertex the UV must be greater than (.5,.5). Vertices with UV less than (.5,.5) are excluded.");
				return;
			}
			bool flag = false;
			for (int j = 0; j < targetMeshes.Length; j++)
			{
				if (targetMeshes[j] == null)
				{
					UnityEngine.Debug.LogError($"Mesh {j} was null");
					flag = true;
				}
				if (radius < 0f)
				{
					UnityEngine.Debug.LogError("radius must be zero or positive.");
				}
			}
			if (flag)
			{
				return;
			}
			for (int k = 0; k < targetMeshes.Length; k++)
			{
				Mesh mesh = targetMeshes[k];
				Vector3[] vertices2 = mesh.vertices;
				BoneWeight[] boneWeights2 = mesh.boneWeights;
				Vector3[] normals2 = mesh.normals;
				Vector4[] tangents2 = mesh.tangents;
				int num = 0;
				for (int l = 0; l < vertices2.Length; l++)
				{
					for (int m = 0; m < list.Count; m++)
					{
						int num2 = list[m];
						if (Vector3.Distance(vertices2[l], vertices[num2]) <= radius)
						{
							num++;
							boneWeights2[l] = boneWeights[num2];
							vertices2[l] = vertices[num2];
							if (normals2.Length == vertices2.Length && normals.Length == normals.Length)
							{
								normals2[l] = normals[num2];
							}
							if (tangents2.Length == vertices2.Length && tangents.Length == vertices.Length)
							{
								tangents2[l] = tangents[num2];
							}
						}
					}
				}
				if (num > 0)
				{
					targetMeshes[k].vertices = vertices2;
					targetMeshes[k].boneWeights = boneWeights2;
					targetMeshes[k].normals = normals2;
					targetMeshes[k].tangents = tangents2;
				}
				UnityEngine.Debug.Log(string.Format("Copied boneweights for {1} vertices in mesh {0} that matched positions in the seam mesh.", targetMeshes[k].name, num));
			}
		}
	}
}
