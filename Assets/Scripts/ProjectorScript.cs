using UnityEngine;

public class ProjectorScript : MonoBehaviour
{
	private Transform targetTransform;

	public void followPlayer(Transform playerTransform)
	{
		targetTransform = playerTransform;
		Transform transform = base.transform;
		Vector3 position = playerTransform.position;
		float x = position.x;
		Vector3 position2 = playerTransform.position;
		float y = position2.y + 250f;
		Vector3 position3 = playerTransform.position;
		transform.position = new Vector3(x, y, position3.z);
		Transform transform2 = base.transform;
		Vector3 eulerAngles = playerTransform.eulerAngles;
		float x2 = eulerAngles.x;
		Vector3 eulerAngles2 = playerTransform.eulerAngles;
		float y2 = eulerAngles2.y;
		Vector3 eulerAngles3 = playerTransform.eulerAngles;
		transform2.eulerAngles = new Vector3(x2, y2, eulerAngles3.z);
		InvokeRepeating("followPlayer", 0f, 0.2f);
	}

	private void followPlayer()
	{
		Transform transform = base.transform;
		Vector3 position = targetTransform.position;
		float x = position.x;
		Vector3 position2 = base.transform.position;
		float y = position2.y;
		Vector3 position3 = targetTransform.position;
		transform.position = new Vector3(x, y, position3.z);
		Transform transform2 = base.transform;
		Vector3 eulerAngles = targetTransform.eulerAngles;
		float x2 = eulerAngles.x + 180f;
		Vector3 eulerAngles2 = targetTransform.eulerAngles;
		float y2 = eulerAngles2.y;
		Vector3 eulerAngles3 = targetTransform.eulerAngles;
		transform2.eulerAngles = new Vector3(x2, y2, eulerAngles3.z);
	}

	private void Start()
	{
	}

	private void Update()
	{
	}
}
