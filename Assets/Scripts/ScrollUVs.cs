using UnityEngine;

public class ScrollUVs : MonoBehaviour
{
	private Renderer toScroll;

	public float ScrX;

	public float ScrY;

	private void Start()
	{
		toScroll = GetComponent<Renderer>();
	}

	private void Update()
	{
		Material material = toScroll.material;
		Vector2 mainTextureOffset = toScroll.material.mainTextureOffset;
		float x = mainTextureOffset.x + ScrX;
		Vector2 mainTextureOffset2 = toScroll.material.mainTextureOffset;
		material.mainTextureOffset = new Vector2(x, mainTextureOffset2.y + ScrY);
	}
}
