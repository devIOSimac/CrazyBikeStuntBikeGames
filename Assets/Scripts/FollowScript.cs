using UnityEngine;

public class FollowScript : MonoBehaviour
{
	public Transform followTransform;

	private void Start()
	{
	}

	private void Update()
	{
		if (followTransform != null)
		{
			base.transform.position = followTransform.position;
			Transform transform = base.transform;
			Vector3 eulerAngles = followTransform.eulerAngles;
			transform.eulerAngles = new Vector3(0f, eulerAngles.y + 90f, 0f);
		}
	}

	public void followObject(Transform toFollow, bool isTrailer)
	{
		followTransform = toFollow;
		if (!isTrailer)
		{
			switch (PlayerPrefs.GetInt("SelectedVehicle"))
			{
			case 0:
				base.transform.localScale = new Vector3(10f, 1E-06f, 4.4f);
				break;
			case 1:
				base.transform.localScale = new Vector3(7f, 1E-06f, 4f);
				break;
			case 2:
				base.transform.localScale = new Vector3(15f, 1E-07f, 5.5f);
				break;
			case 3:
				base.transform.localScale = new Vector3(8.5f, 1E-06f, 3.5f);
				break;
			case 4:
				base.transform.localScale = new Vector3(11.5f, 1E-06f, 5.5f);
				break;
			case 5:
				base.transform.localScale = new Vector3(10f, 1E-07f, 5f);
				break;
			case 6:
				base.transform.localScale = new Vector3(9f, 1E-06f, 4f);
				break;
			case 7:
				base.transform.localScale = new Vector3(9f, 1E-06f, 4f);
				break;
			default:
				UnityEngine.Debug.Log("Error");
				break;
			}
		}
		else
		{
			switch (PlayerPrefs.GetInt("SelectedVehicle"))
			{
			case 0:
				base.transform.localScale = new Vector3(10f, 1E-06f, 4.4f);
				break;
			case 1:
				base.transform.localScale = new Vector3(15f, 1E-06f, 4f);
				break;
			case 2:
				base.transform.localScale = new Vector3(10f, 1E-07f, 4f);
				break;
			case 3:
				base.transform.localScale = new Vector3(8.5f, 1E-06f, 3.5f);
				break;
			case 4:
				base.transform.localScale = new Vector3(11.5f, 1E-06f, 5.5f);
				break;
			case 5:
				base.transform.localScale = new Vector3(10f, 1E-07f, 5f);
				break;
			case 6:
				base.transform.localScale = new Vector3(9f, 1E-06f, 4f);
				break;
			case 7:
				base.transform.localScale = new Vector3(9f, 1E-06f, 4f);
				break;
			default:
				UnityEngine.Debug.Log("Error");
				break;
			}
		}
	}
}
