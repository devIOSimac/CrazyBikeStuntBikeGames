using UnityEngine;

public class RotateGlow : MonoBehaviour
{
	private Material mat;

	private Vector2 rate;

	private Vector2 val;

	private void Start()
	{
		mat = GetComponent<Renderer>().material;
		rate = new Vector2(1f, 1f);
		val = Vector2.zero;
	}

	private void Update()
	{
		val += rate * Time.deltaTime * 0.1f;
		mat.SetTextureOffset("_MainTex", val);
	}
}
