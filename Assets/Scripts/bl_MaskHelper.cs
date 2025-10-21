using UnityEngine;
using UnityEngine.UI;

public class bl_MaskHelper : MonoBehaviour
{
	public Texture2D MiniMapMask;

	public Texture2D WorldMapMask;

	[Space(5f)]
	public Image Background;

	public Sprite MiniMapBackGround;

	public Sprite WorldMapBackGround;

	private RawImage _image;

	private RawImage m_image
	{
		get
		{
			if (_image == null)
			{
				_image = GetComponent<RawImage>();
			}
			return _image;
		}
	}

	private void Start()
	{
		m_image.texture = MiniMapMask;
	}

	public void OnChange(bool full = false)
	{
		if (full)
		{
			m_image.texture = WorldMapMask;
			if (Background != null)
			{
				Background.sprite = WorldMapBackGround;
			}
		}
		else
		{
			m_image.texture = MiniMapMask;
			if (Background != null)
			{
				Background.sprite = MiniMapBackGround;
			}
		}
	}
}
