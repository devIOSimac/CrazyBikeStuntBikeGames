using System;
using UnityEngine;

public class ScrollingTextArea : MonoBehaviour
{
	public Vector2 scrollPosition;

	private string text = string.Empty;

	public int height;

	public int xPadding;

	public int yPadding;

	private Texture2D consoleBackgroundTexture;

	private GUIStyle consoleTextStyle;

	private GUIStyle consoleBackgroundStyle;

	private void Start()
	{
		consoleBackgroundTexture = new Texture2D(1, 1);
		for (int i = 0; i < consoleBackgroundTexture.width; i++)
		{
			for (int j = 0; j < consoleBackgroundTexture.height; j++)
			{
				consoleBackgroundTexture.SetPixel(i, j, new Color(0f, 0f, 0f, 0.7f));
			}
		}
		consoleTextStyle = new GUIStyle();
		consoleTextStyle.fontSize = 28;
		consoleTextStyle.normal.textColor = Color.white;
		consoleTextStyle.richText = true;
		consoleBackgroundStyle = new GUIStyle();
		consoleBackgroundStyle.normal.background = consoleBackgroundTexture;
	}

	private void OnGUI()
	{
		GUI.skin.verticalScrollbar.fixedWidth = (float)Screen.width * 0.05f;
		GUI.skin.verticalScrollbarThumb.fixedWidth = (float)Screen.width * 0.05f;
		GUI.skin.horizontalScrollbar.fixedHeight = (float)Screen.width * 0.035f;
		GUI.skin.horizontalScrollbarThumb.fixedHeight = (float)Screen.width * 0.035f;
		GUI.BeginGroup(new Rect(xPadding, Screen.height - height - yPadding, Screen.width - xPadding * 2, height), consoleBackgroundStyle);
		scrollPosition = GUILayout.BeginScrollView(scrollPosition, false, true, GUILayout.Width(Screen.width - xPadding * 2), GUILayout.Height(height));
		GUILayout.Label(text, consoleTextStyle);
		GUILayout.EndScrollView();
		GUI.EndGroup();
	}

	public void Append(string append, bool newline = true)
	{
		if (newline && text.Length > 0)
		{
			text += "\n";
		}
		text = text + "[" + DateTime.UtcNow.ToString("HH:mm:ss") + "] ";
		text += append;
		scrollPosition = new Vector2(0f, float.PositiveInfinity);
	}
}
