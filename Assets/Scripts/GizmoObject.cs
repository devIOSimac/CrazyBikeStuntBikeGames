using UnityEngine;

public class GizmoObject : MonoBehaviour
{
	public Color GColor = Color.white;

	public float GSize = 1f;

	private void OnDrawGizmos()
	{
		Matrix4x4 matrix4x2 = Gizmos.matrix = Matrix4x4.TRS(base.transform.position, base.transform.rotation, Vector3.one * GSize);
		Gizmos.color = GColor;
		Gizmos.DrawCube(Vector3.zero, Vector3.one * GSize);
	}
}
