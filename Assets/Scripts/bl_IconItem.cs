using UnityEngine;
using UnityEngine.UI;

public class bl_IconItem : MonoBehaviour
{
	public Image TargetGrapihc;

	public Sprite DeathIcon;

	public Text InfoText;

	public float DestroyIn = 5f;

	private bool open;

	public void DestroyIcon(bool inmediate)
	{
		if (inmediate)
		{
			UnityEngine.Object.Destroy(base.gameObject);
			return;
		}
		TargetGrapihc.sprite = DeathIcon;
		UnityEngine.Object.Destroy(base.gameObject, DestroyIn);
	}

	public void DestroyIcon(bool inmediate, Sprite death)
	{
		if (inmediate)
		{
			UnityEngine.Object.Destroy(base.gameObject);
			return;
		}
		TargetGrapihc.sprite = death;
		UnityEngine.Object.Destroy(base.gameObject, DestroyIn);
	}

	public void GetInfoItem(string info)
	{
		if (!(InfoText == null))
		{
			InfoText.text = info;
		}
	}

	public void InfoItem()
	{
		open = !open;
		Animation component = GetComponent<Animation>();
		if (open)
		{
			component["OpenInfo"].time = 0f;
			component["OpenInfo"].speed = 1f;
			component.CrossFade("OpenInfo", 0.2f);
		}
		else
		{
			component["OpenInfo"].time = component["OpenInfo"].length;
			component["OpenInfo"].speed = -1f;
			component.CrossFade("OpenInfo", 0.2f);
		}
	}
}
