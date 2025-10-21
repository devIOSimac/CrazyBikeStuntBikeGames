using UnityEngine;

public class Skidmarks : MonoBehaviour
{
	private class markSection
	{
		public Vector3 pos = Vector3.zero;

		public Vector3 normal = Vector3.zero;

		public Vector4 tangent = Vector4.zero;

		public Vector3 posl = Vector3.zero;

		public Vector3 posr = Vector3.zero;

		public float intensity;

		public int lastIndex;
	}

	public int maxMarks = 1024;

	public float markWidth = 0.275f;

	public float groundOffset = 0.02f;

	public float minDistance = 0.1f;

	private int indexShift;

	private int numMarks;

	private markSection[] skidmarks;

	private bool updated;

	public bool skidmake;

	private void Start()
	{
		if (base.transform.position != new Vector3(0f, 0f, 0f))
		{
			base.transform.position = new Vector3(0f, 0f, 0f);
		}
	}

	private void Awake()
	{
		skidmarks = new markSection[maxMarks];
		for (int i = 0; i < maxMarks; i++)
		{
			skidmarks[i] = new markSection();
		}
		if (GetComponent<MeshFilter>().mesh == null)
		{
			GetComponent<MeshFilter>().mesh = new Mesh();
		}
	}

	public int AddSkidMark(Vector3 pos, Vector3 normal, float intensity, int lastIndex)
	{
		if (intensity > 1f)
		{
			intensity = 1f;
		}
		if (intensity < 0f)
		{
			return -1;
		}
		markSection markSection = skidmarks[numMarks % maxMarks];
		markSection.pos = pos + normal * groundOffset;
		markSection.normal = normal;
		markSection.intensity = intensity;
		markSection.lastIndex = lastIndex;
		if (lastIndex != -1)
		{
			markSection markSection2 = skidmarks[lastIndex % maxMarks];
			Vector3 lhs = markSection.pos - markSection2.pos;
			Vector3 normalized = Vector3.Cross(lhs, normal).normalized;
			markSection.posl = markSection.pos + normalized * markWidth * 0.5f;
			markSection.posr = markSection.pos - normalized * markWidth * 0.5f;
			markSection.tangent = new Vector4(normalized.x, normalized.y, normalized.z, 1f);
			if (markSection2.lastIndex == -1)
			{
				markSection2.tangent = markSection.tangent;
				markSection2.posl = markSection.pos + normalized * markWidth * 0.5f;
				markSection2.posr = markSection.pos - normalized * markWidth * 0.5f;
			}
		}
		numMarks++;
		updated = true;
		return numMarks - 1;
	}

	private void LateUpdate()
	{
		WheelCollider[] array = UnityEngine.Object.FindObjectsOfType(typeof(WheelCollider)) as WheelCollider[];
		WheelCollider[] array2 = array;
		foreach (WheelCollider wheelCollider in array2)
		{
			if (!skidmake)
			{
				wheelCollider.gameObject.AddComponent<WheelSkidmarks>();
			}
		}
		skidmake = true;
		if (!updated)
		{
			return;
		}
		updated = false;
		Mesh mesh = GetComponent<MeshFilter>().mesh;
		mesh.Clear();
		int num = 0;
		for (int j = 0; j < numMarks && j < maxMarks; j++)
		{
			if (skidmarks[j].lastIndex != -1 && skidmarks[j].lastIndex > numMarks - maxMarks)
			{
				num++;
			}
		}
		Vector3[] array3 = new Vector3[num * 4];
		Vector3[] array4 = new Vector3[num * 4];
		Vector4[] array5 = new Vector4[num * 4];
		Color[] array6 = new Color[num * 4];
		Vector2[] array7 = new Vector2[num * 4];
		int[] array8 = new int[num * 6];
		num = 0;
		for (int k = 0; k < numMarks && k < maxMarks; k++)
		{
			if (skidmarks[k].lastIndex != -1 && skidmarks[k].lastIndex > numMarks - maxMarks)
			{
				markSection markSection = skidmarks[k];
				markSection markSection2 = skidmarks[markSection.lastIndex % maxMarks];
				array3[num * 4] = markSection2.posl;
				array3[num * 4 + 1] = markSection2.posr;
				array3[num * 4 + 2] = markSection.posl;
				array3[num * 4 + 3] = markSection.posr;
				array4[num * 4] = markSection2.normal;
				array4[num * 4 + 1] = markSection2.normal;
				array4[num * 4 + 2] = markSection.normal;
				array4[num * 4 + 3] = markSection.normal;
				array5[num * 4] = markSection2.tangent;
				array5[num * 4 + 1] = markSection2.tangent;
				array5[num * 4 + 2] = markSection.tangent;
				array5[num * 4 + 3] = markSection.tangent;
				array6[num * 4] = new Color(0f, 0f, 0f, markSection2.intensity);
				array6[num * 4 + 1] = new Color(0f, 0f, 0f, markSection2.intensity);
				array6[num * 4 + 2] = new Color(0f, 0f, 0f, markSection.intensity);
				array6[num * 4 + 3] = new Color(0f, 0f, 0f, markSection.intensity);
				array7[num * 4] = new Vector2(0f, 0f);
				array7[num * 4 + 1] = new Vector2(1f, 0f);
				array7[num * 4 + 2] = new Vector2(0f, 1f);
				array7[num * 4 + 3] = new Vector2(1f, 1f);
				array8[num * 6] = num * 4;
				array8[num * 6 + 2] = num * 4 + 1;
				array8[num * 6 + 1] = num * 4 + 2;
				array8[num * 6 + 3] = num * 4 + 2;
				array8[num * 6 + 5] = num * 4 + 1;
				array8[num * 6 + 4] = num * 4 + 3;
				num++;
			}
		}
		mesh.vertices = array3;
		mesh.normals = array4;
		mesh.tangents = array5;
		mesh.triangles = array8;
		mesh.colors = array6;
		mesh.uv = array7;
	}
}
