using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
[AddComponentMenu("Time of Day/Camera Atmospheric Scattering")]
public class TOD_Scattering : TOD_ImageEffect
{
	public Shader ScatteringShader;

	public Shader ScreenClearShader;

	public Shader SkyMaskShader;

	public Texture2D DitheringTexture;

	[Tooltip("Whether to render atmosphere and fog in a single pass or two separate passes. Disable when using anti-aliasing in forward rendering or when your manual reflection scripts need the sky dome to be present before the image effects are rendered.")]
	public bool SinglePass = true;

	[Header("Fog")]
	[Tooltip("How quickly the fog thickens with increasing distance.")]
	[Range(0f, 1f)]
	public float GlobalDensity = 0.01f;

	[Tooltip("How quickly the fog falls off with increasing altitude.")]
	[Range(0f, 1f)]
	public float HeightFalloff = 0.01f;

	[Tooltip("The height where fog reaches its maximum density.")]
	public float ZeroLevel;

	[Header("Blur")]
	[Tooltip("The scattering resolution.")]
	public ResolutionType Resolution = ResolutionType.Normal;

	[Tooltip("The number of blur iterations to be performed.")]
	[TOD_Range(0f, 4f)]
	public int BlurIterations = 2;

	[Tooltip("The radius to blur filter applied to the directional scattering.")]
	[TOD_Min(0f)]
	public float BlurRadius = 2f;

	[Tooltip("The maximum radius of the directional scattering.")]
	[TOD_Min(0f)]
	public float MaxRadius = 1f;

	private Material scatteringMaterial;

	private Material screenClearMaterial;

	private Material skyMaskMaterial;

	protected void OnEnable()
	{
		if (!ScatteringShader)
		{
			ScatteringShader = Shader.Find("Hidden/Time of Day/Scattering");
		}
		if (!ScreenClearShader)
		{
			ScreenClearShader = Shader.Find("Hidden/Time of Day/Screen Clear");
		}
		if (!SkyMaskShader)
		{
			SkyMaskShader = Shader.Find("Hidden/Time of Day/Sky Mask");
		}
		scatteringMaterial = CreateMaterial(ScatteringShader);
		screenClearMaterial = CreateMaterial(ScreenClearShader);
		skyMaskMaterial = CreateMaterial(SkyMaskShader);
	}

	protected void OnDisable()
	{
		if ((bool)scatteringMaterial)
		{
			UnityEngine.Object.DestroyImmediate(scatteringMaterial);
		}
		if ((bool)screenClearMaterial)
		{
			UnityEngine.Object.DestroyImmediate(screenClearMaterial);
		}
		if ((bool)skyMaskMaterial)
		{
			UnityEngine.Object.DestroyImmediate(skyMaskMaterial);
		}
	}

	protected void OnPreCull()
	{
		if (SinglePass && (bool)sky && sky.Initialized)
		{
			sky.Components.AtmosphereRenderer.enabled = false;
		}
	}

	protected void OnPostRender()
	{
		if (SinglePass && (bool)sky && sky.Initialized)
		{
			sky.Components.AtmosphereRenderer.enabled = true;
		}
	}

	[ImageEffectOpaque]
	protected void OnRenderImage(RenderTexture source, RenderTexture destination)
	{
		if (!CheckSupport(needDepth: true))
		{
			Graphics.Blit(source, destination);
			return;
		}
		sky.Components.Scattering = this;
		Vector3 lightPos = cam.WorldToViewportPoint(sky.Components.SunTransform.position);
		RenderTexture skyMask = GetSkyMask(source, skyMaskMaterial, screenClearMaterial, Resolution, lightPos, BlurIterations, BlurRadius, MaxRadius);
		scatteringMaterial.SetMatrix("_FrustumCornersWS", FrustumCorners());
		scatteringMaterial.SetTexture("_SkyMask", skyMask);
		if (SinglePass)
		{
			scatteringMaterial.EnableKeyword("TOD_SCATTERING_SINGLE_PASS");
		}
		else
		{
			scatteringMaterial.DisableKeyword("TOD_SCATTERING_SINGLE_PASS");
		}
		Shader.SetGlobalTexture("TOD_BayerTexture", DitheringTexture);
		Shader.SetGlobalVector("TOD_ScatterDensity", new Vector4(HeightFalloff, ZeroLevel, GlobalDensity, 0f));
		Graphics.Blit(source, destination, scatteringMaterial);
		RenderTexture.ReleaseTemporary(skyMask);
	}
}
