using UnityEngine;
using UnityEngine.UI;

public class bl_MiniMapItem : MonoBehaviour
{
	private bool changecolor;

	[Header("Target")]
	public GameObject GraphicPrefab;

	public Transform Target;

	public Vector3 OffSet = Vector3.zero;

	[Space(5f)]
	[Header("Icon")]
	public Sprite Icon;

	public Sprite DeathIcon;

	public Color IconColor = new Color(1f, 1f, 1f, 0.9f);

	public Color color1 = new Color(255f, 0f, 0f, 255f);

	public Color color2 = new Color(0f, 255f, 0f, 255f);

	public float Size = 20f;

	[Header("Icon Button")]
	public string InfoItem = "Info Icon here";

	[Space(5f)]
	[Header("Settings")]
	public bool OffScreen = true;

	public float BorderOffScreen = 0.01f;

	public float OffScreenSize = 10f;

	public ItemEffect m_Effect = ItemEffect.None;

	private Image Graphic;

	private RectTransform RectRoot;

	private GameObject cacheItem;

	public bool captured;

	private bl_MiniMap _minimap;

	public Vector3 TargetPosition
	{
		get
		{
			if (Target == null)
			{
				return Vector3.zero;
			}
			Vector3 position = Target.position;
			float x = position.x;
			Vector3 position2 = Target.position;
			return new Vector3(x, 0f, position2.z);
		}
	}

	private bl_MiniMap m_miniMap
	{
		get
		{
			if (_minimap == null)
			{
				_minimap = cacheItem.transform.root.GetComponentInChildren<bl_MiniMap>();
			}
			return _minimap;
		}
	}

	private void Start()
	{
		InvokeRepeating("Toggle", 0f, 0.2f);
		captured = false;
		if (bl_MiniMap.MapUIRoot != null)
		{
			CreateIcon();
		}
		else
		{
			UnityEngine.Debug.Log("You need a MiniMap in scene for use MiniMap Items.");
		}
	}

	private void CreateIcon()
	{
		cacheItem = UnityEngine.Object.Instantiate(GraphicPrefab);
		RectRoot = bl_MiniMap.MapUIRoot;
		Graphic = cacheItem.GetComponent<Image>();
		if (Icon != null)
		{
			Graphic.sprite = Icon;
			Graphic.color = IconColor;
		}
		cacheItem.transform.SetParent(RectRoot.transform, worldPositionStays: false);
		Graphic.GetComponent<RectTransform>().anchoredPosition = Vector2.zero;
		if (Target == null)
		{
			Target = GetComponent<Transform>();
		}
		StartEffect();
		bl_IconItem component = cacheItem.GetComponent<bl_IconItem>();
		component.GetInfoItem(InfoItem);
	}

	private void FixedUpdate()
	{
		if (changecolor)
		{
			Graphic.color = color1;
		}
		else if (!changecolor)
		{
			Graphic.color = color2;
		}
		if (Target == null || Graphic == null || captured)
		{
			return;
		}
		RectTransform component = Graphic.GetComponent<RectTransform>();
		Vector3 position = TargetPosition + OffSet;
		Vector2 vector = bl_MiniMap.MiniMapCamera.WorldToViewportPoint(position);
		float x = vector.x;
		Vector2 sizeDelta = RectRoot.sizeDelta;
		float num = x * sizeDelta.x;
		Vector2 sizeDelta2 = RectRoot.sizeDelta;
		float x2 = num - sizeDelta2.x * 0.5f;
		float y = vector.y;
		Vector2 sizeDelta3 = RectRoot.sizeDelta;
		float num2 = y * sizeDelta3.y;
		Vector2 sizeDelta4 = RectRoot.sizeDelta;
		Vector2 anchoredPosition = new Vector2(x2, num2 - sizeDelta4.y * 0.5f);
		if (OffScreen)
		{
			float x3 = anchoredPosition.x;
			Vector2 sizeDelta5 = RectRoot.sizeDelta;
			float min = 0f - (sizeDelta5.x * 0.5f - BorderOffScreen);
			Vector2 sizeDelta6 = RectRoot.sizeDelta;
			anchoredPosition.x = Mathf.Clamp(x3, min, sizeDelta6.x * 0.5f - BorderOffScreen);
			float y2 = anchoredPosition.y;
			Vector2 sizeDelta7 = RectRoot.sizeDelta;
			float min2 = 0f - (sizeDelta7.y * 0.5f - BorderOffScreen);
			Vector2 sizeDelta8 = RectRoot.sizeDelta;
			anchoredPosition.y = Mathf.Clamp(y2, min2, sizeDelta8.y * 0.5f - BorderOffScreen);
		}
		float size = Size;
		if (m_miniMap.useCompassRotation)
		{
			Vector3 zero = Vector3.zero;
			Vector3 direction = Target.position - m_miniMap.TargetPosition;
			Vector3 vector2 = bl_MiniMap.MiniMapCamera.transform.InverseTransformDirection(direction);
			vector2.z = 0f;
			vector2 = vector2.normalized / 2f;
			float num3 = Mathf.Abs(anchoredPosition.x);
			float num4 = Mathf.Abs(0.5f + vector2.x * m_miniMap.CompassSize);
			if (num3 >= num4)
			{
				zero.x = 0.5f + vector2.x * m_miniMap.CompassSize;
				zero.y = 0.5f + vector2.y * m_miniMap.CompassSize;
				anchoredPosition = zero;
				size = OffScreenSize;
			}
			else
			{
				size = Size;
			}
		}
		else
		{
			float x4 = anchoredPosition.x;
			Vector2 sizeDelta9 = RectRoot.sizeDelta;
			if (x4 != sizeDelta9.x * 0.5f - BorderOffScreen)
			{
				float y3 = anchoredPosition.y;
				Vector2 sizeDelta10 = RectRoot.sizeDelta;
				if (y3 != sizeDelta10.y * 0.5f - BorderOffScreen)
				{
					float x5 = anchoredPosition.x;
					Vector2 sizeDelta11 = RectRoot.sizeDelta;
					if (x5 != 0f - sizeDelta11.x * 0.5f - BorderOffScreen)
					{
						float num5 = 0f - anchoredPosition.y;
						Vector2 sizeDelta12 = RectRoot.sizeDelta;
						if (num5 != sizeDelta12.y * 0.5f - BorderOffScreen)
						{
							size = Size;
							goto IL_039a;
						}
					}
				}
			}
			size = OffScreenSize;
		}
		goto IL_039a;
		IL_039a:
		component.anchoredPosition = anchoredPosition;
		component.sizeDelta = Vector2.Lerp(component.sizeDelta, new Vector2(size, size), Time.deltaTime * 8f);
		Quaternion identity = Quaternion.identity;
		Quaternion rotation = Target.rotation;
		identity.x = rotation.x;
		component.localRotation = identity;
	}

	private void Toggle()
	{
		changecolor = !changecolor;
	}

	private void StartEffect()
	{
		Animation component = Graphic.GetComponent<Animation>();
		if (m_Effect == ItemEffect.Pulsing)
		{
			component.Play("Pulsing");
		}
		else if (m_Effect == ItemEffect.Fade)
		{
			component.Play("Fade");
		}
	}

	public void DestroyItem(bool inmediate)
	{
		if (Graphic == null)
		{
			UnityEngine.Debug.Log("Graphic Item of " + base.name + " not exist in scene");
		}
		else if (DeathIcon == null || inmediate)
		{
			Graphic.GetComponent<bl_IconItem>().DestroyIcon(inmediate);
		}
		else
		{
			Graphic.GetComponent<bl_IconItem>().DestroyIcon(inmediate, DeathIcon);
		}
	}

	public void HideItem()
	{
		if (cacheItem != null)
		{
			cacheItem.SetActive(value: false);
		}
	}

	public void ShowItem()
	{
		if (cacheItem != null)
		{
			cacheItem.SetActive(value: true);
		}
		else
		{
			UnityEngine.Debug.Log("There is no item to active.");
		}
	}
}
