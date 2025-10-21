using UnityEngine;

public class RoadArrowMove : MonoBehaviour
{
	public float scrollspeed = 0.5f;

	public Renderer rend;

	private void Start()
	{
		rend = GetComponent<Renderer>();
	}

	private void Update()
	{
		float num = Time.time * scrollspeed;
		rend.material.mainTextureOffset = new Vector2(0f - num, 0f);
	}
}
