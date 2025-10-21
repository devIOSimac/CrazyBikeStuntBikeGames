using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
public abstract class TOD_ImageEffect : MonoBehaviour
{
	public enum ResolutionType
	{
		Low,
		Normal,
		High
	}

	public TOD_Sky sky;

	protected Camera cam;

	private static Vector3[] frustumCornersArray = new Vector3[4];

	protected Material CreateMaterial(Shader shader)
	{
		if (!shader)
		{
			UnityEngine.Debug.Log("Missing shader in " + ToString());
			base.enabled = false;
			return null;
		}
		if (!shader.isSupported)
		{
			UnityEngine.Debug.LogError("The shader " + shader.ToString() + " on effect " + ToString() + " is not supported on this platform!");
			base.enabled = false;
			return null;
		}
		Material material = new Material(shader);
		material.hideFlags = HideFlags.DontSave;
		return material;
	}

	private TOD_Sky FindSky(bool fallback = false)
	{
		if ((bool)TOD_Sky.Instance)
		{
			return TOD_Sky.Instance;
		}
		if (fallback)
		{
			return UnityEngine.Object.FindObjectOfType(typeof(TOD_Sky)) as TOD_Sky;
		}
		return null;
	}

	protected void Awake()
	{
		if (!cam)
		{
			cam = GetComponent<Camera>();
		}
		if (!sky)
		{
			sky = FindSky(fallback: true);
		}
	}

	protected bool CheckSupport(bool needDepth = false, bool needHdr = false)
	{
		if (!cam)
		{
			cam = GetComponent<Camera>();
		}
		if (!cam)
		{
			return false;
		}
		if (!sky)
		{
			sky = FindSky();
		}
		if (!sky || !sky.Initialized)
		{
			return false;
		}
		if (!SystemInfo.supportsImageEffects)
		{
			UnityEngine.Debug.LogWarning("The image effect " + ToString() + " has been disabled as it's not supported on the current platform.");
			base.enabled = false;
			return false;
		}
		if (needDepth && !SystemInfo.SupportsRenderTextureFormat(RenderTextureFormat.Depth))
		{
			UnityEngine.Debug.LogWarning("The image effect " + ToString() + " has been disabled as it requires a depth texture.");
			base.enabled = false;
			return false;
		}
		if (needHdr && !SystemInfo.SupportsRenderTextureFormat(RenderTextureFormat.ARGBHalf))
		{
			UnityEngine.Debug.LogWarning("The image effect " + ToString() + " has been disabled as it requires HDR.");
			base.enabled = false;
			return false;
		}
		if (needDepth)
		{
			cam.depthTextureMode |= DepthTextureMode.Depth;
		}
		if (needHdr)
		{
			cam.allowHDR = true;
		}
		return true;
	}

	protected void DrawBorder(RenderTexture dest, Material material)
	{
		RenderTexture.active = dest;
		bool flag = true;
		GL.PushMatrix();
		GL.LoadOrtho();
		for (int i = 0; i < material.passCount; i++)
		{
			material.SetPass(i);
			float y;
			float y2;
			if (flag)
			{
				y = 1f;
				y2 = 0f;
			}
			else
			{
				y = 0f;
				y2 = 1f;
			}
			float x = 0f;
			float x2 = 1f / ((float)dest.width * 1f);
			float y3 = 0f;
			float y4 = 1f;
			GL.Begin(7);
			GL.TexCoord2(0f, y);
			GL.Vertex3(x, y3, 0.1f);
			GL.TexCoord2(1f, y);
			GL.Vertex3(x2, y3, 0.1f);
			GL.TexCoord2(1f, y2);
			GL.Vertex3(x2, y4, 0.1f);
			GL.TexCoord2(0f, y2);
			GL.Vertex3(x, y4, 0.1f);
			x = 1f - 1f / ((float)dest.width * 1f);
			x2 = 1f;
			y3 = 0f;
			y4 = 1f;
			GL.TexCoord2(0f, y);
			GL.Vertex3(x, y3, 0.1f);
			GL.TexCoord2(1f, y);
			GL.Vertex3(x2, y3, 0.1f);
			GL.TexCoord2(1f, y2);
			GL.Vertex3(x2, y4, 0.1f);
			GL.TexCoord2(0f, y2);
			GL.Vertex3(x, y4, 0.1f);
			x = 0f;
			x2 = 1f;
			y3 = 0f;
			y4 = 1f / ((float)dest.height * 1f);
			GL.TexCoord2(0f, y);
			GL.Vertex3(x, y3, 0.1f);
			GL.TexCoord2(1f, y);
			GL.Vertex3(x2, y3, 0.1f);
			GL.TexCoord2(1f, y2);
			GL.Vertex3(x2, y4, 0.1f);
			GL.TexCoord2(0f, y2);
			GL.Vertex3(x, y4, 0.1f);
			x = 0f;
			x2 = 1f;
			y3 = 1f - 1f / ((float)dest.height * 1f);
			y4 = 1f;
			GL.TexCoord2(0f, y);
			GL.Vertex3(x, y3, 0.1f);
			GL.TexCoord2(1f, y);
			GL.Vertex3(x2, y3, 0.1f);
			GL.TexCoord2(1f, y2);
			GL.Vertex3(x2, y4, 0.1f);
			GL.TexCoord2(0f, y2);
			GL.Vertex3(x, y4, 0.1f);
			GL.End();
		}
		GL.PopMatrix();
	}

	protected Matrix4x4 FrustumCorners()
	{
		cam.CalculateFrustumCorners(new Rect(0f, 0f, 1f, 1f), cam.farClipPlane, cam.stereoActiveEye, frustumCornersArray);
		Vector3 v = cam.transform.TransformVector(frustumCornersArray[0]);
		Vector3 v2 = cam.transform.TransformVector(frustumCornersArray[1]);
		Vector3 v3 = cam.transform.TransformVector(frustumCornersArray[2]);
		Vector3 v4 = cam.transform.TransformVector(frustumCornersArray[3]);
		Matrix4x4 identity = Matrix4x4.identity;
		identity.SetRow(0, v);
		identity.SetRow(1, v4);
		identity.SetRow(2, v2);
		identity.SetRow(3, v3);
		return identity;
	}

	protected RenderTexture GetSkyMask(RenderTexture source, Material skyMaskMaterial, Material screenClearMaterial, ResolutionType resolution, Vector3 lightPos, int blurIterations, float blurRadius, float maxRadius)
	{
		int width;
		int height;
		int depthBuffer;
		switch (resolution)
		{
		case ResolutionType.High:
			width = source.width;
			height = source.height;
			depthBuffer = 0;
			break;
		case ResolutionType.Normal:
			width = source.width / 2;
			height = source.height / 2;
			depthBuffer = 0;
			break;
		default:
			width = source.width / 4;
			height = source.height / 4;
			depthBuffer = 0;
			break;
		}
		RenderTexture temporary = RenderTexture.GetTemporary(width, height, depthBuffer);
		RenderTexture renderTexture = null;
		skyMaskMaterial.SetVector("_BlurRadius4", new Vector4(1f, 1f, 0f, 0f) * blurRadius);
		skyMaskMaterial.SetVector("_LightPosition", new Vector4(lightPos.x, lightPos.y, lightPos.z, maxRadius));
		if ((cam.depthTextureMode & DepthTextureMode.Depth) != 0)
		{
			Graphics.Blit(source, temporary, skyMaskMaterial, 1);
		}
		else
		{
			Graphics.Blit(source, temporary, skyMaskMaterial, 2);
		}
		if (cam.stereoActiveEye == Camera.MonoOrStereoscopicEye.Mono)
		{
			DrawBorder(temporary, screenClearMaterial);
		}
		float num = blurRadius * 0.00130208337f;
		skyMaskMaterial.SetVector("_BlurRadius4", new Vector4(num, num, 0f, 0f));
		skyMaskMaterial.SetVector("_LightPosition", new Vector4(lightPos.x, lightPos.y, lightPos.z, maxRadius));
		for (int i = 0; i < blurIterations; i++)
		{
			renderTexture = RenderTexture.GetTemporary(width, height, depthBuffer);
			Graphics.Blit(temporary, renderTexture, skyMaskMaterial, 0);
			RenderTexture.ReleaseTemporary(temporary);
			num = blurRadius * (((float)i * 2f + 1f) * 6f) / 768f;
			skyMaskMaterial.SetVector("_BlurRadius4", new Vector4(num, num, 0f, 0f));
			temporary = RenderTexture.GetTemporary(width, height, depthBuffer);
			Graphics.Blit(renderTexture, temporary, skyMaskMaterial, 0);
			RenderTexture.ReleaseTemporary(renderTexture);
			num = blurRadius * (((float)i * 2f + 2f) * 6f) / 768f;
			skyMaskMaterial.SetVector("_BlurRadius4", new Vector4(num, num, 0f, 0f));
		}
		return temporary;
	}
}
