using System;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using System.Xml.Serialization;
using UnityEngine;
using UnityEngine.Rendering;

[ExecuteInEditMode]
[RequireComponent(typeof(TOD_Resources))]
[RequireComponent(typeof(TOD_Components))]
public class TOD_Sky : MonoBehaviour
{
	private const float pi = (float)Math.PI;

	private const float tau = (float)Math.PI * 2f;

	private static List<TOD_Sky> instances = new List<TOD_Sky>();

	private int probeRenderID = -1;

	[Tooltip("Auto: Use the player settings.\nLinear: Force linear color space.\nGamma: Force gamma color space.")]
	public TOD_ColorSpaceType ColorSpace;

	[Tooltip("Auto: Use the camera settings.\nHDR: Force high dynamic range.\nLDR: Force low dynamic range.")]
	public TOD_ColorRangeType ColorRange;

	[Tooltip("Raw: Write color without modifications.\nDithered: Add dithering to reduce banding.")]
	public TOD_ColorOutputType ColorOutput = TOD_ColorOutputType.Dithered;

	[Tooltip("Per Vertex: Calculate sky color per vertex.\nPer Pixel: Calculate sky color per pixel.")]
	public TOD_SkyQualityType SkyQuality;

	[Tooltip("Low: Only recommended for very old mobile devices.\nMedium: Simplified cloud shading.\nHigh: Physically based cloud shading.")]
	public TOD_CloudQualityType CloudQuality = TOD_CloudQualityType.High;

	[Tooltip("Low: Only recommended for very old mobile devices.\nMedium: Simplified mesh geometry.\nHigh: Detailed mesh geometry.")]
	public TOD_MeshQualityType MeshQuality = TOD_MeshQualityType.High;

	[Tooltip("Low: Recommended for most mobile devices.\nMedium: Includes most visible stars.\nHigh: Includes all visible stars.")]
	public TOD_StarQualityType StarQuality = TOD_StarQualityType.High;

	public TOD_CycleParameters Cycle;

	public TOD_WorldParameters World;

	public TOD_AtmosphereParameters Atmosphere;

	public TOD_DayParameters Day;

	public TOD_NightParameters Night;

	public TOD_SunParameters Sun;

	public TOD_MoonParameters Moon;

	public TOD_StarParameters Stars;

	public TOD_CloudParameters Clouds;

	public TOD_LightParameters Light;

	public TOD_FogParameters Fog;

	public TOD_AmbientParameters Ambient;

	public TOD_ReflectionParameters Reflection;

	private float timeSinceLightUpdate = float.MaxValue;

	private float timeSinceAmbientUpdate = float.MaxValue;

	private float timeSinceReflectionUpdate = float.MaxValue;

	private const int TOD_SAMPLES = 2;

	private Vector3 kBetaMie;

	private Vector4 kSun;

	private Vector4 k4PI;

	private Vector4 kRadius;

	private Vector4 kScale;

	public static List<TOD_Sky> Instances => instances;

	public static TOD_Sky Instance => (instances.Count != 0) ? instances[instances.Count - 1] : null;

	public bool Initialized
	{
		get;
		private set;
	}

	public bool Headless => Camera.allCamerasCount == 0;

	public TOD_Components Components
	{
		get;
		private set;
	}

	public TOD_Resources Resources
	{
		get;
		private set;
	}

	public bool IsDay
	{
		get;
		private set;
	}

	public bool IsNight
	{
		get;
		private set;
	}

	public float Radius
	{
		get
		{
			Vector3 lossyScale = Components.DomeTransform.lossyScale;
			return lossyScale.y;
		}
	}

	public float Diameter
	{
		get
		{
			Vector3 lossyScale = Components.DomeTransform.lossyScale;
			return lossyScale.y * 2f;
		}
	}

	public float LerpValue
	{
		get;
		private set;
	}

	public float SunZenith
	{
		get;
		private set;
	}

	public float SunAltitude
	{
		get;
		private set;
	}

	public float SunAzimuth
	{
		get;
		private set;
	}

	public float MoonZenith
	{
		get;
		private set;
	}

	public float MoonAltitude
	{
		get;
		private set;
	}

	public float MoonAzimuth
	{
		get;
		private set;
	}

	public float SunsetTime
	{
		get;
		private set;
	}

	public float SunriseTime
	{
		get;
		private set;
	}

	public float LocalSiderealTime
	{
		get;
		private set;
	}

	public float LightZenith => Mathf.Min(SunZenith, MoonZenith);

	public float LightIntensity => Components.LightSource.intensity;

	public float SunVisibility
	{
		get;
		private set;
	}

	public float MoonVisibility
	{
		get;
		private set;
	}

	public Vector3 SunDirection
	{
		get;
		private set;
	}

	public Vector3 MoonDirection
	{
		get;
		private set;
	}

	public Vector3 LightDirection
	{
		get;
		private set;
	}

	public Vector3 LocalSunDirection
	{
		get;
		private set;
	}

	public Vector3 LocalMoonDirection
	{
		get;
		private set;
	}

	public Vector3 LocalLightDirection
	{
		get;
		private set;
	}

	public Color SunLightColor
	{
		get;
		private set;
	}

	public Color MoonLightColor
	{
		get;
		private set;
	}

	public Color LightColor => Components.LightSource.color;

	public Color SunRayColor
	{
		get;
		private set;
	}

	public Color MoonRayColor
	{
		get;
		private set;
	}

	public Color SunSkyColor
	{
		get;
		private set;
	}

	public Color MoonSkyColor
	{
		get;
		private set;
	}

	public Color SunMeshColor
	{
		get;
		private set;
	}

	public Color MoonMeshColor
	{
		get;
		private set;
	}

	public Color SunCloudColor
	{
		get;
		private set;
	}

	public Color MoonCloudColor
	{
		get;
		private set;
	}

	public Color FogColor
	{
		get;
		private set;
	}

	public Color GroundColor
	{
		get;
		private set;
	}

	public Color AmbientColor
	{
		get;
		private set;
	}

	public Color MoonHaloColor
	{
		get;
		private set;
	}

	public ReflectionProbe Probe
	{
		get;
		private set;
	}

	private void UpdateScattering()
	{
		float num = 0f - Atmosphere.Directionality;
		float num2 = num * num;
		kBetaMie.x = 1.5f * ((1f - num2) / (2f + num2));
		kBetaMie.y = 1f + num2;
		kBetaMie.z = 2f * num;
		float num3 = 0.002f * Atmosphere.MieMultiplier;
		float num4 = 0.002f * Atmosphere.RayleighMultiplier;
		float x = num4 * 40f * 5.27016449f;
		float y = num4 * 40f * 9.473285f;
		float z = num4 * 40f * 19.6438026f;
		float w = num3 * 40f;
		kSun.x = x;
		kSun.y = y;
		kSun.z = z;
		kSun.w = w;
		float x2 = num4 * 4f * (float)Math.PI * 5.27016449f;
		float y2 = num4 * 4f * (float)Math.PI * 9.473285f;
		float z2 = num4 * 4f * (float)Math.PI * 19.6438026f;
		float w2 = num3 * 4f * (float)Math.PI;
		k4PI.x = x2;
		k4PI.y = y2;
		k4PI.z = z2;
		k4PI.w = w2;
		kRadius.x = 1f;
		kRadius.y = 1f;
		kRadius.z = 1.025f;
		kRadius.w = 1.050625f;
		kScale.x = 40.00004f;
		kScale.y = 0.25f;
		kScale.z = 160.000153f;
		kScale.w = 0.0001f;
	}

	private void UpdateCelestials()
	{
		float f = (float)Math.PI / 180f * World.Latitude;
		float num = Mathf.Sin(f);
		float num2 = Mathf.Cos(f);
		float longitude = World.Longitude;
		float num3 = (float)Math.PI / 2f;
		int year = Cycle.Year;
		int month = Cycle.Month;
		int day = Cycle.Day;
		float num4 = Cycle.Hour - World.UTC;
		float num5 = (float)(367 * year - 7 * (year + (month + 9) / 12) / 4 + 275 * month / 9 + day - 730530) + num4 / 24f;
		float num6 = (float)(367 * year - 7 * (year + (month + 9) / 12) / 4 + 275 * month / 9 + day - 730530) + 0.5f;
		float num7 = 23.4393f - 3.563E-07f * num5;
		float f2 = (float)Math.PI / 180f * num7;
		float num8 = Mathf.Sin(f2);
		float num9 = Mathf.Cos(f2);
		float num10 = 282.9404f + 4.70935E-05f * num6;
		float num11 = 0.016709f - 1.151E-09f * num6;
		float num12 = 356.047f + 0.985600233f * num6;
		float num13 = (float)Math.PI / 180f * num12;
		float num14 = Mathf.Sin(num13);
		float num15 = Mathf.Cos(num13);
		float f3 = num13 + num11 * num14 * (1f + num11 * num15);
		float num16 = Mathf.Sin(f3);
		float num17 = Mathf.Cos(f3);
		float num18 = num17 - num11;
		float num19 = Mathf.Sqrt(1f - num11 * num11) * num16;
		float num20 = 57.29578f * Mathf.Atan2(num19, num18);
		float num21 = Mathf.Sqrt(num18 * num18 + num19 * num19);
		float num22 = num20 + num10;
		float f4 = (float)Math.PI / 180f * num22;
		float num23 = Mathf.Sin(f4);
		float num24 = Mathf.Cos(f4);
		float num25 = num21 * num24;
		float num26 = num21 * num23;
		float num27 = num25;
		float num28 = num26 * num9;
		float y = num26 * num8;
		float num29 = Mathf.Atan2(num28, num27);
		float num30 = 57.29578f * num29;
		float f5 = Mathf.Atan2(y, Mathf.Sqrt(num27 * num27 + num28 * num28));
		float num31 = Mathf.Sin(f5);
		float num32 = Mathf.Cos(f5);
		float num33 = num20 + num10;
		float num34 = num33 + 180f;
		float num35 = num30 - num34 - longitude;
		float num36 = -6f;
		float f6 = (float)Math.PI / 180f * num36;
		float num37 = Mathf.Sin(f6);
		float f7 = (num37 - num * num31) / (num2 * num32);
		float num38 = Mathf.Acos(f7);
		float num39 = 57.29578f * num38;
		SunsetTime = (24f + (num35 + num39) / 15f % 24f) % 24f;
		SunriseTime = (24f + (num35 - num39) / 15f % 24f) % 24f;
		float num40 = 282.9404f + 4.70935E-05f * num5;
		float num41 = 0.016709f - 1.151E-09f * num5;
		float num42 = 356.047f + 0.985600233f * num5;
		float num43 = (float)Math.PI / 180f * num42;
		float num44 = Mathf.Sin(num43);
		float num45 = Mathf.Cos(num43);
		float f8 = num43 + num41 * num44 * (1f + num41 * num45);
		float num46 = Mathf.Sin(f8);
		float num47 = Mathf.Cos(f8);
		float num48 = num47 - num41;
		float num49 = Mathf.Sqrt(1f - num41 * num41) * num46;
		float num50 = 57.29578f * Mathf.Atan2(num49, num48);
		float num51 = Mathf.Sqrt(num48 * num48 + num49 * num49);
		float num52 = num50 + num40;
		float f9 = (float)Math.PI / 180f * num52;
		float num53 = Mathf.Sin(f9);
		float num54 = Mathf.Cos(f9);
		float num55 = num51 * num54;
		float num56 = num51 * num53;
		float num57 = num55;
		float num58 = num56 * num9;
		float y2 = num56 * num8;
		float num59 = Mathf.Atan2(num58, num57);
		float f10 = Mathf.Atan2(y2, Mathf.Sqrt(num57 * num57 + num58 * num58));
		float num60 = Mathf.Sin(f10);
		float num61 = Mathf.Cos(f10);
		float num62 = num50 + num40;
		float num63 = num62 + 180f;
		float num64 = num63 + 15f * num4;
		float num65 = (float)Math.PI / 180f * (num64 + longitude);
		LocalSiderealTime = (num64 + longitude) / 15f;
		float f11 = num65 - num59;
		float num66 = Mathf.Sin(f11);
		float num67 = Mathf.Cos(f11);
		float num68 = num67 * num61;
		float num69 = num66 * num61;
		float num70 = num60;
		float num71 = num68 * num - num70 * num2;
		float num72 = num69;
		float y3 = num68 * num2 + num70 * num;
		float num73 = Mathf.Atan2(num72, num71) + (float)Math.PI;
		float num74 = Mathf.Atan2(y3, Mathf.Sqrt(num71 * num71 + num72 * num72));
		float num75 = num3 - num74;
		float num76 = num74;
		float num77 = num73;
		SunZenith = 57.29578f * num75;
		SunAltitude = 57.29578f * num76;
		SunAzimuth = 57.29578f * num77;
		float num120;
		float num121;
		float num122;
		if (Moon.Position == TOD_MoonPositionType.Realistic)
		{
			float num78 = 125.1228f - 0.05295381f * num5;
			float num79 = 5.1454f;
			float num80 = 318.0634f + 0.164357319f * num5;
			float num81 = 60.2666f;
			float num82 = 0.0549f;
			float num83 = 115.3654f + 13.0649929f * num5;
			float f12 = (float)Math.PI / 180f * num78;
			float num84 = Mathf.Sin(f12);
			float num85 = Mathf.Cos(f12);
			float f13 = (float)Math.PI / 180f * num79;
			float num86 = Mathf.Sin(f13);
			float num87 = Mathf.Cos(f13);
			float num88 = (float)Math.PI / 180f * num83;
			float num89 = Mathf.Sin(num88);
			float num90 = Mathf.Cos(num88);
			float f14 = num88 + num82 * num89 * (1f + num82 * num90);
			float num91 = Mathf.Sin(f14);
			float num92 = Mathf.Cos(f14);
			float num93 = num81 * (num92 - num82);
			float num94 = num81 * (Mathf.Sqrt(1f - num82 * num82) * num91);
			float num95 = 57.29578f * Mathf.Atan2(num94, num93);
			float num96 = Mathf.Sqrt(num93 * num93 + num94 * num94);
			float num97 = num95 + num80;
			float f15 = (float)Math.PI / 180f * num97;
			float num98 = Mathf.Sin(f15);
			float num99 = Mathf.Cos(f15);
			float num100 = num96 * (num85 * num99 - num84 * num98 * num87);
			float num101 = num96 * (num84 * num99 + num85 * num98 * num87);
			float num102 = num96 * (num98 * num86);
			float num103 = num100;
			float num104 = num101;
			float num105 = num102;
			float num106 = num103;
			float num107 = num104 * num9 - num105 * num8;
			float y4 = num104 * num8 + num105 * num9;
			float num108 = Mathf.Atan2(num107, num106);
			float f16 = Mathf.Atan2(y4, Mathf.Sqrt(num106 * num106 + num107 * num107));
			float num109 = Mathf.Sin(f16);
			float num110 = Mathf.Cos(f16);
			float f17 = num65 - num108;
			float num111 = Mathf.Sin(f17);
			float num112 = Mathf.Cos(f17);
			float num113 = num112 * num110;
			float num114 = num111 * num110;
			float num115 = num109;
			float num116 = num113 * num - num115 * num2;
			float num117 = num114;
			float y5 = num113 * num2 + num115 * num;
			float num118 = Mathf.Atan2(num117, num116) + (float)Math.PI;
			float num119 = Mathf.Atan2(y5, Mathf.Sqrt(num116 * num116 + num117 * num117));
			num120 = num3 - num119;
			num121 = num119;
			num122 = num118;
		}
		else
		{
			num120 = num75 - (float)Math.PI;
			num121 = num76 - (float)Math.PI;
			num122 = num77;
		}
		MoonZenith = 57.29578f * num120;
		MoonAltitude = 57.29578f * num121;
		MoonAzimuth = 57.29578f * num122;
		Quaternion quaternion = Quaternion.Euler(90f - World.Latitude, 0f, 0f) * Quaternion.Euler(0f, World.Longitude, 0f) * Quaternion.Euler(0f, num65 * 57.29578f, 0f);
		if (Stars.Position == TOD_StarsPositionType.Rotating)
		{
			Components.SpaceTransform.localRotation = quaternion;
			Components.StarTransform.localRotation = quaternion;
		}
		else
		{
			Components.SpaceTransform.localRotation = Quaternion.identity;
			Components.StarTransform.localRotation = Quaternion.identity;
		}
		Vector3 localPosition = OrbitalToLocal(num75, num77);
		Components.SunTransform.localPosition = localPosition;
		Components.SunTransform.LookAt(Components.DomeTransform.position, Components.SunTransform.up);
		Vector3 localPosition2 = OrbitalToLocal(num120, num122);
		Vector3 worldUp = quaternion * -Vector3.right;
		Components.MoonTransform.localPosition = localPosition2;
		Components.MoonTransform.LookAt(Components.DomeTransform.position, worldUp);
		float num123 = 8f * Mathf.Tan((float)Math.PI / 360f * Sun.MeshSize);
		Vector3 localScale = new Vector3(num123, num123, num123);
		Components.SunTransform.localScale = localScale;
		float num124 = 4f * Mathf.Tan((float)Math.PI / 360f * Moon.MeshSize);
		Vector3 localScale2 = new Vector3(num124, num124, num124);
		Components.MoonTransform.localScale = localScale2;
		bool enabled = (1f - Atmosphere.Fogginess) * (1f - LerpValue) > 0f;
		Components.SpaceRenderer.enabled = enabled;
		Components.StarRenderer.enabled = enabled;
		Vector3 localPosition3 = Components.SunTransform.localPosition;
		bool enabled2 = localPosition3.y > 0f - num123;
		Components.SunRenderer.enabled = enabled2;
		Vector3 localPosition4 = Components.MoonTransform.localPosition;
		bool enabled3 = localPosition4.y > 0f - num124;
		Components.MoonRenderer.enabled = enabled3;
		bool enabled4 = true;
		Components.AtmosphereRenderer.enabled = enabled4;
		bool enabled5 = false;
		Components.ClearRenderer.enabled = enabled5;
		bool enabled6 = Clouds.Coverage > 0f && Clouds.Opacity > 0f;
		Components.CloudRenderer.enabled = enabled6;
		LerpValue = Mathf.InverseLerp(105f, 90f, SunZenith);
		float time = Mathf.Clamp01(SunZenith / 90f);
		float time2 = Mathf.Clamp01((SunZenith - 90f) / 90f);
		float num125 = Mathf.Clamp01((LerpValue - 0.1f) / 0.9f);
		float num126 = Mathf.Clamp01((0.1f - LerpValue) / 0.1f);
		float num127 = Mathf.Clamp01((90f - num120 * 57.29578f) / 5f);
		SunVisibility = (1f - Atmosphere.Fogginess) * num125;
		MoonVisibility = (1f - Atmosphere.Fogginess) * num126 * num127;
		SunLightColor = TOD_Util.ApplyAlpha(Day.LightColor.Evaluate(time));
		MoonLightColor = TOD_Util.ApplyAlpha(Night.LightColor.Evaluate(time2));
		SunRayColor = TOD_Util.ApplyAlpha(Day.RayColor.Evaluate(time));
		MoonRayColor = TOD_Util.ApplyAlpha(Night.RayColor.Evaluate(time2));
		SunSkyColor = TOD_Util.ApplyAlpha(Day.SkyColor.Evaluate(time));
		MoonSkyColor = TOD_Util.ApplyAlpha(Night.SkyColor.Evaluate(time2));
		SunMeshColor = TOD_Util.ApplyAlpha(Day.SunColor.Evaluate(time));
		MoonMeshColor = TOD_Util.ApplyAlpha(Night.MoonColor.Evaluate(time2));
		SunCloudColor = TOD_Util.ApplyAlpha(Day.CloudColor.Evaluate(time));
		MoonCloudColor = TOD_Util.ApplyAlpha(Night.CloudColor.Evaluate(time2));
		Color b = TOD_Util.ApplyAlpha(Day.FogColor.Evaluate(time));
		Color a = TOD_Util.ApplyAlpha(Night.FogColor.Evaluate(time2));
		FogColor = Color.Lerp(a, b, LerpValue);
		Color color = TOD_Util.ApplyAlpha(Day.AmbientColor.Evaluate(time));
		Color color2 = TOD_Util.ApplyAlpha(Night.AmbientColor.Evaluate(time2));
		AmbientColor = Color.Lerp(color2, color, LerpValue);
		Color b2 = color;
		Color a2 = color2;
		GroundColor = Color.Lerp(a2, b2, LerpValue);
		MoonHaloColor = TOD_Util.MulRGB(MoonSkyColor, Moon.HaloBrightness * num127);
		float shadowStrength;
		float intensity;
		Color color3;
		if (LerpValue > 0.1f)
		{
			IsDay = true;
			IsNight = false;
			shadowStrength = Day.ShadowStrength;
			intensity = Mathf.Lerp(0f, Day.LightIntensity, SunVisibility);
			color3 = SunLightColor;
		}
		else
		{
			IsDay = false;
			IsNight = true;
			shadowStrength = Night.ShadowStrength;
			intensity = Mathf.Lerp(0f, Night.LightIntensity, MoonVisibility);
			color3 = MoonLightColor;
		}
		Components.LightSource.color = color3;
		Components.LightSource.intensity = intensity;
		Components.LightSource.shadowStrength = shadowStrength;
		if (!Application.isPlaying || timeSinceLightUpdate >= Light.UpdateInterval)
		{
			timeSinceLightUpdate = 0f;
			Vector3 localPosition5 = (!IsNight) ? OrbitalToLocal(Mathf.Min(num75, (1f - Light.MinimumHeight) * (float)Math.PI / 2f), num77) : OrbitalToLocal(Mathf.Min(num120, (1f - Light.MinimumHeight) * (float)Math.PI / 2f), num122);
			Components.LightTransform.localPosition = localPosition5;
			Components.LightTransform.LookAt(Components.DomeTransform.position);
		}
		else
		{
			timeSinceLightUpdate += Time.deltaTime;
		}
		SunDirection = -Components.SunTransform.forward;
		LocalSunDirection = Components.DomeTransform.InverseTransformDirection(SunDirection);
		MoonDirection = -Components.MoonTransform.forward;
		LocalMoonDirection = Components.DomeTransform.InverseTransformDirection(MoonDirection);
		LightDirection = -Components.LightTransform.forward;
		LocalLightDirection = Components.DomeTransform.InverseTransformDirection(LightDirection);
	}

	public Vector3 OrbitalToUnity(float radius, float theta, float phi)
	{
		float num = Mathf.Sin(theta);
		float num2 = Mathf.Cos(theta);
		float num3 = Mathf.Sin(phi);
		float num4 = Mathf.Cos(phi);
		Vector3 result = default(Vector3);
		result.z = radius * num * num4;
		result.y = radius * num2;
		result.x = radius * num * num3;
		return result;
	}

	public Vector3 OrbitalToLocal(float theta, float phi)
	{
		float num = Mathf.Sin(theta);
		float y = Mathf.Cos(theta);
		float num2 = Mathf.Sin(phi);
		float num3 = Mathf.Cos(phi);
		Vector3 result = default(Vector3);
		result.z = num * num3;
		result.y = y;
		result.x = num * num2;
		return result;
	}

	public Color SampleAtmosphere(Vector3 direction, bool directLight = true)
	{
		Vector3 dir = Components.DomeTransform.InverseTransformDirection(direction);
		Color color = ShaderScatteringColor(dir, directLight);
		color = TOD_HDR2LDR(color);
		return TOD_LINEAR2GAMMA(color);
	}

	public SphericalHarmonicsL2 RenderToSphericalHarmonics()
	{
		float saturation = Ambient.Saturation;
		float intensity = Mathf.Lerp(Night.AmbientMultiplier, Day.AmbientMultiplier, LerpValue);
		return RenderToSphericalHarmonics(intensity, saturation);
	}

	public SphericalHarmonicsL2 RenderToSphericalHarmonics(float intensity, float saturation)
	{
		SphericalHarmonicsL2 result = default(SphericalHarmonicsL2);
		bool directLight = false;
		Color color = TOD_Util.AdjustRGB(AmbientColor.linear, intensity, saturation);
		Vector3 vector = new Vector3(0.612372458f, 0.5f, 0.612372458f);
		Vector3 up = Vector3.up;
		Color linear = SampleAtmosphere(up, directLight).linear;
		Color color2 = TOD_Util.AdjustRGB(linear, intensity, saturation);
		result.AddDirectionalLight(up, color2, 0.428571433f);
		Vector3 direction = new Vector3(0f - vector.x, vector.y, 0f - vector.z);
		Color linear2 = SampleAtmosphere(direction, directLight).linear;
		Color color3 = TOD_Util.AdjustRGB(linear2, intensity, saturation);
		result.AddDirectionalLight(direction, color3, 0.2857143f);
		Vector3 direction2 = new Vector3(vector.x, vector.y, 0f - vector.z);
		Color linear3 = SampleAtmosphere(direction2, directLight).linear;
		Color color4 = TOD_Util.AdjustRGB(linear3, intensity, saturation);
		result.AddDirectionalLight(direction2, color4, 0.2857143f);
		Vector3 direction3 = new Vector3(0f - vector.x, vector.y, vector.z);
		Color linear4 = SampleAtmosphere(direction3, directLight).linear;
		Color color5 = TOD_Util.AdjustRGB(linear4, intensity, saturation);
		result.AddDirectionalLight(direction3, color5, 0.2857143f);
		Vector3 direction4 = new Vector3(vector.x, vector.y, vector.z);
		Color linear5 = SampleAtmosphere(direction4, directLight).linear;
		Color color6 = TOD_Util.AdjustRGB(linear5, intensity, saturation);
		result.AddDirectionalLight(direction4, color6, 0.2857143f);
		Vector3 left = Vector3.left;
		Color linear6 = SampleAtmosphere(left, directLight).linear;
		Color color7 = TOD_Util.AdjustRGB(linear6, intensity, saturation);
		result.AddDirectionalLight(left, color7, 0.142857149f);
		Vector3 right = Vector3.right;
		Color linear7 = SampleAtmosphere(right, directLight).linear;
		Color color8 = TOD_Util.AdjustRGB(linear7, intensity, saturation);
		result.AddDirectionalLight(right, color8, 0.142857149f);
		Vector3 back = Vector3.back;
		Color linear8 = SampleAtmosphere(back, directLight).linear;
		Color color9 = TOD_Util.AdjustRGB(linear8, intensity, saturation);
		result.AddDirectionalLight(back, color9, 0.142857149f);
		Vector3 forward = Vector3.forward;
		Color linear9 = SampleAtmosphere(forward, directLight).linear;
		Color color10 = TOD_Util.AdjustRGB(linear9, intensity, saturation);
		result.AddDirectionalLight(forward, color10, 0.142857149f);
		Vector3 direction5 = new Vector3(0f - vector.x, 0f - vector.y, 0f - vector.z);
		result.AddDirectionalLight(direction5, color, 0.2857143f);
		Vector3 direction6 = new Vector3(vector.x, 0f - vector.y, 0f - vector.z);
		result.AddDirectionalLight(direction6, color, 0.2857143f);
		Vector3 direction7 = new Vector3(0f - vector.x, 0f - vector.y, vector.z);
		result.AddDirectionalLight(direction7, color, 0.2857143f);
		Vector3 direction8 = new Vector3(vector.x, 0f - vector.y, vector.z);
		result.AddDirectionalLight(direction8, color, 0.2857143f);
		Vector3 down = Vector3.down;
		result.AddDirectionalLight(down, color, 0.428571433f);
		return result;
	}

	public void RenderToCubemap(RenderTexture targetTexture = null)
	{
		if (!Probe)
		{
			Probe = new GameObject().AddComponent<ReflectionProbe>();
			Probe.name = base.gameObject.name + " Reflection Probe";
			Probe.mode = ReflectionProbeMode.Realtime;
		}
		if (probeRenderID < 0 || Probe.IsFinishedRendering(probeRenderID))
		{
			float num = float.MaxValue;
			Probe.transform.position = Components.DomeTransform.position;
			Probe.size = new Vector3(num, num, num);
			Probe.intensity = RenderSettings.reflectionIntensity;
			Probe.clearFlags = Reflection.ClearFlags;
			Probe.cullingMask = Reflection.CullingMask;
			Probe.refreshMode = ReflectionProbeRefreshMode.ViaScripting;
			Probe.timeSlicingMode = Reflection.TimeSlicing;
			Probe.resolution = Mathf.ClosestPowerOfTwo(Reflection.Resolution);
			if (Components.Camera != null)
			{
				Probe.backgroundColor = Components.Camera.BackgroundColor;
				Probe.nearClipPlane = Components.Camera.NearClipPlane;
				Probe.farClipPlane = Components.Camera.FarClipPlane;
			}
			probeRenderID = Probe.RenderProbe(targetTexture);
		}
	}

	public Color SampleFogColor(bool directLight = true)
	{
		Vector3 vector = Vector3.forward;
		if (Components.Camera != null)
		{
			Vector3 eulerAngles = Components.Camera.transform.rotation.eulerAngles;
			vector = Quaternion.Euler(0f, eulerAngles.y, 0f) * vector;
		}
		Color color = SampleAtmosphere(Vector3.Lerp(vector, Vector3.up, Fog.HeightBias).normalized, directLight);
		return new Color(color.r, color.g, color.b, 1f);
	}

	public Color SampleSkyColor()
	{
		Vector3 sunDirection = SunDirection;
		sunDirection.y = Mathf.Abs(sunDirection.y);
		Color color = SampleAtmosphere(sunDirection.normalized, directLight: false);
		return new Color(color.r, color.g, color.b, 1f);
	}

	public Color SampleEquatorColor()
	{
		Vector3 sunDirection = SunDirection;
		sunDirection.y = 0f;
		Color color = SampleAtmosphere(sunDirection.normalized, directLight: false);
		return new Color(color.r, color.g, color.b, 1f);
	}

	public void UpdateFog()
	{
		switch (Fog.Mode)
		{
		case TOD_FogType.None:
			break;
		case TOD_FogType.Atmosphere:
		{
			Color color4 = RenderSettings.fogColor = SampleFogColor(directLight: false);
			break;
		}
		case TOD_FogType.Directional:
		{
			Color color2 = RenderSettings.fogColor = SampleFogColor();
			break;
		}
		case TOD_FogType.Gradient:
			RenderSettings.fogColor = FogColor;
			break;
		}
	}

	public void UpdateAmbient()
	{
		float saturation = Ambient.Saturation;
		float num = Mathf.Lerp(Night.AmbientMultiplier, Day.AmbientMultiplier, LerpValue);
		switch (Ambient.Mode)
		{
		case TOD_AmbientType.Color:
		{
			Color ambientLight2 = TOD_Util.AdjustRGB(AmbientColor, num, saturation);
			RenderSettings.ambientMode = AmbientMode.Flat;
			RenderSettings.ambientLight = ambientLight2;
			RenderSettings.ambientIntensity = num;
			break;
		}
		case TOD_AmbientType.Gradient:
		{
			Color ambientGroundColor = TOD_Util.AdjustRGB(AmbientColor, num, saturation);
			Color ambientEquatorColor = TOD_Util.AdjustRGB(SampleEquatorColor(), num, saturation);
			Color ambientSkyColor = TOD_Util.AdjustRGB(SampleSkyColor(), num, saturation);
			RenderSettings.ambientMode = AmbientMode.Trilight;
			RenderSettings.ambientSkyColor = ambientSkyColor;
			RenderSettings.ambientEquatorColor = ambientEquatorColor;
			RenderSettings.ambientGroundColor = ambientGroundColor;
			RenderSettings.ambientIntensity = num;
			break;
		}
		case TOD_AmbientType.Spherical:
		{
			Color ambientLight = TOD_Util.AdjustRGB(AmbientColor, num, saturation);
			RenderSettings.ambientMode = AmbientMode.Skybox;
			RenderSettings.ambientLight = ambientLight;
			RenderSettings.ambientIntensity = num;
			RenderSettings.ambientProbe = RenderToSphericalHarmonics(num, saturation);
			break;
		}
		}
	}

	public void UpdateReflection()
	{
		TOD_ReflectionType mode = Reflection.Mode;
		if (mode == TOD_ReflectionType.Cubemap)
		{
			float reflectionIntensity = Mathf.Lerp(Night.ReflectionMultiplier, Day.ReflectionMultiplier, LerpValue);
			RenderSettings.defaultReflectionMode = DefaultReflectionMode.Skybox;
			RenderSettings.reflectionIntensity = reflectionIntensity;
			if (Application.isPlaying)
			{
				RenderToCubemap();
			}
		}
	}

	public void LoadParameters(string xml)
	{
		XmlSerializer xmlSerializer = new XmlSerializer(typeof(TOD_Parameters));
		XmlTextReader xmlReader = new XmlTextReader(new StringReader(xml));
		TOD_Parameters tOD_Parameters = xmlSerializer.Deserialize(xmlReader) as TOD_Parameters;
		tOD_Parameters.ToSky(this);
	}

	private void UpdateQualitySettings()
	{
		if (!Headless)
		{
			Mesh mesh = null;
			Mesh mesh2 = null;
			Mesh mesh3 = null;
			Mesh mesh4 = null;
			Mesh mesh5 = null;
			Mesh mesh6 = null;
			switch (MeshQuality)
			{
			case TOD_MeshQualityType.Low:
				mesh = Resources.SkyLOD2;
				mesh2 = Resources.SkyLOD2;
				mesh3 = Resources.SkyLOD2;
				mesh4 = Resources.CloudsLOD2;
				mesh5 = Resources.MoonLOD2;
				break;
			case TOD_MeshQualityType.Medium:
				mesh = Resources.SkyLOD1;
				mesh2 = Resources.SkyLOD1;
				mesh3 = Resources.SkyLOD2;
				mesh4 = Resources.CloudsLOD1;
				mesh5 = Resources.MoonLOD1;
				break;
			case TOD_MeshQualityType.High:
				mesh = Resources.SkyLOD0;
				mesh2 = Resources.SkyLOD0;
				mesh3 = Resources.SkyLOD2;
				mesh4 = Resources.CloudsLOD0;
				mesh5 = Resources.MoonLOD0;
				break;
			}
			switch (StarQuality)
			{
			case TOD_StarQualityType.Low:
				mesh6 = Resources.StarsLOD2;
				break;
			case TOD_StarQualityType.Medium:
				mesh6 = Resources.StarsLOD1;
				break;
			case TOD_StarQualityType.High:
				mesh6 = Resources.StarsLOD0;
				break;
			}
			if ((bool)Components.SpaceMeshFilter && Components.SpaceMeshFilter.sharedMesh != mesh)
			{
				Components.SpaceMeshFilter.mesh = mesh;
			}
			if ((bool)Components.MoonMeshFilter && Components.MoonMeshFilter.sharedMesh != mesh5)
			{
				Components.MoonMeshFilter.mesh = mesh5;
			}
			if ((bool)Components.AtmosphereMeshFilter && Components.AtmosphereMeshFilter.sharedMesh != mesh2)
			{
				Components.AtmosphereMeshFilter.mesh = mesh2;
			}
			if ((bool)Components.ClearMeshFilter && Components.ClearMeshFilter.sharedMesh != mesh3)
			{
				Components.ClearMeshFilter.mesh = mesh3;
			}
			if ((bool)Components.CloudMeshFilter && Components.CloudMeshFilter.sharedMesh != mesh4)
			{
				Components.CloudMeshFilter.mesh = mesh4;
			}
			if ((bool)Components.StarMeshFilter && Components.StarMeshFilter.sharedMesh != mesh6)
			{
				Components.StarMeshFilter.mesh = mesh6;
			}
		}
	}

	private void UpdateRenderSettings()
	{
		if (!Headless)
		{
			UpdateFog();
			if (!Application.isPlaying || timeSinceAmbientUpdate >= Ambient.UpdateInterval)
			{
				timeSinceAmbientUpdate = 0f;
				UpdateAmbient();
			}
			else
			{
				timeSinceAmbientUpdate += Time.deltaTime;
			}
			if (!Application.isPlaying || timeSinceReflectionUpdate >= Reflection.UpdateInterval)
			{
				timeSinceReflectionUpdate = 0f;
				UpdateReflection();
			}
			else
			{
				timeSinceReflectionUpdate += Time.deltaTime;
			}
		}
	}

	private void UpdateShaderKeywords()
	{
		if (Headless)
		{
			return;
		}
		switch (ColorSpace)
		{
		case TOD_ColorSpaceType.Auto:
			if (QualitySettings.activeColorSpace == UnityEngine.ColorSpace.Linear)
			{
				Shader.EnableKeyword("TOD_OUTPUT_LINEAR");
			}
			else
			{
				Shader.DisableKeyword("TOD_OUTPUT_LINEAR");
			}
			break;
		case TOD_ColorSpaceType.Linear:
			Shader.EnableKeyword("TOD_OUTPUT_LINEAR");
			break;
		case TOD_ColorSpaceType.Gamma:
			Shader.DisableKeyword("TOD_OUTPUT_LINEAR");
			break;
		}
		switch (ColorRange)
		{
		case TOD_ColorRangeType.Auto:
			if ((bool)Components.Camera && Components.Camera.HDR)
			{
				Shader.EnableKeyword("TOD_OUTPUT_HDR");
			}
			else
			{
				Shader.DisableKeyword("TOD_OUTPUT_HDR");
			}
			break;
		case TOD_ColorRangeType.HDR:
			Shader.EnableKeyword("TOD_OUTPUT_HDR");
			break;
		case TOD_ColorRangeType.LDR:
			Shader.DisableKeyword("TOD_OUTPUT_HDR");
			break;
		}
		switch (ColorOutput)
		{
		case TOD_ColorOutputType.Raw:
			Shader.DisableKeyword("TOD_OUTPUT_DITHERING");
			break;
		case TOD_ColorOutputType.Dithered:
			Shader.EnableKeyword("TOD_OUTPUT_DITHERING");
			break;
		}
		switch (SkyQuality)
		{
		case TOD_SkyQualityType.PerVertex:
			Shader.DisableKeyword("TOD_SCATTERING_PER_PIXEL");
			break;
		case TOD_SkyQualityType.PerPixel:
			Shader.EnableKeyword("TOD_SCATTERING_PER_PIXEL");
			break;
		}
		switch (CloudQuality)
		{
		case TOD_CloudQualityType.Low:
			Shader.DisableKeyword("TOD_CLOUDS_DENSITY");
			Shader.DisableKeyword("TOD_CLOUDS_BUMPED");
			break;
		case TOD_CloudQualityType.Medium:
			Shader.EnableKeyword("TOD_CLOUDS_DENSITY");
			Shader.DisableKeyword("TOD_CLOUDS_BUMPED");
			break;
		case TOD_CloudQualityType.High:
			Shader.EnableKeyword("TOD_CLOUDS_DENSITY");
			Shader.EnableKeyword("TOD_CLOUDS_BUMPED");
			break;
		}
	}

	private void UpdateShaderProperties()
	{
		if (!Headless)
		{
			Shader.SetGlobalColor(Resources.ID_SunLightColor, SunLightColor);
			Shader.SetGlobalColor(Resources.ID_MoonLightColor, MoonLightColor);
			Shader.SetGlobalColor(Resources.ID_SunSkyColor, SunSkyColor);
			Shader.SetGlobalColor(Resources.ID_MoonSkyColor, MoonSkyColor);
			Shader.SetGlobalColor(Resources.ID_SunMeshColor, SunMeshColor);
			Shader.SetGlobalColor(Resources.ID_MoonMeshColor, MoonMeshColor);
			Shader.SetGlobalColor(Resources.ID_SunCloudColor, SunCloudColor);
			Shader.SetGlobalColor(Resources.ID_MoonCloudColor, MoonCloudColor);
			Shader.SetGlobalColor(Resources.ID_FogColor, FogColor);
			Shader.SetGlobalColor(Resources.ID_GroundColor, GroundColor);
			Shader.SetGlobalColor(Resources.ID_AmbientColor, AmbientColor);
			Shader.SetGlobalVector(Resources.ID_SunDirection, SunDirection);
			Shader.SetGlobalVector(Resources.ID_MoonDirection, MoonDirection);
			Shader.SetGlobalVector(Resources.ID_LightDirection, LightDirection);
			Shader.SetGlobalVector(Resources.ID_LocalSunDirection, LocalSunDirection);
			Shader.SetGlobalVector(Resources.ID_LocalMoonDirection, LocalMoonDirection);
			Shader.SetGlobalVector(Resources.ID_LocalLightDirection, LocalLightDirection);
			Shader.SetGlobalFloat(Resources.ID_Contrast, Atmosphere.Contrast);
			Shader.SetGlobalFloat(Resources.ID_Brightness, Atmosphere.Brightness);
			Shader.SetGlobalFloat(Resources.ID_Fogginess, Atmosphere.Fogginess);
			Shader.SetGlobalFloat(Resources.ID_Directionality, Atmosphere.Directionality);
			Shader.SetGlobalFloat(Resources.ID_MoonHaloPower, 1f / Moon.HaloSize);
			Shader.SetGlobalColor(Resources.ID_MoonHaloColor, MoonHaloColor);
			float value = Mathf.Lerp(0.8f, 0f, Clouds.Coverage);
			float num = Mathf.Lerp(3f, 9f, Clouds.Sharpness);
			float value2 = Mathf.Lerp(0f, 1f, Clouds.Attenuation);
			float value3 = Mathf.Lerp(0f, 2f, Clouds.Saturation);
			Shader.SetGlobalFloat(Resources.ID_CloudOpacity, Clouds.Opacity);
			Shader.SetGlobalFloat(Resources.ID_CloudCoverage, value);
			Shader.SetGlobalFloat(Resources.ID_CloudSharpness, 1f / num);
			Shader.SetGlobalFloat(Resources.ID_CloudDensity, num);
			Shader.SetGlobalFloat(Resources.ID_CloudColoring, Clouds.Coloring);
			Shader.SetGlobalFloat(Resources.ID_CloudAttenuation, value2);
			Shader.SetGlobalFloat(Resources.ID_CloudSaturation, value3);
			Shader.SetGlobalFloat(Resources.ID_CloudScattering, Clouds.Scattering);
			Shader.SetGlobalFloat(Resources.ID_CloudBrightness, Clouds.Brightness);
			Shader.SetGlobalVector(Resources.ID_CloudOffset, Components.Animation.OffsetUV);
			Shader.SetGlobalVector(Resources.ID_CloudWind, Components.Animation.CloudUV);
			Shader.SetGlobalVector(Resources.ID_CloudSize, new Vector3(Clouds.Size * 4f, Clouds.Size, Clouds.Size * 4f));
			Shader.SetGlobalFloat(Resources.ID_StarSize, Stars.Size);
			Shader.SetGlobalFloat(Resources.ID_StarBrightness, Stars.Brightness);
			Shader.SetGlobalFloat(Resources.ID_StarVisibility, (1f - Atmosphere.Fogginess) * (1f - LerpValue));
			Shader.SetGlobalFloat(Resources.ID_SunMeshContrast, 1f / Mathf.Max(0.001f, Sun.MeshContrast));
			Shader.SetGlobalFloat(Resources.ID_SunMeshBrightness, Sun.MeshBrightness * (1f - Atmosphere.Fogginess));
			Shader.SetGlobalFloat(Resources.ID_MoonMeshContrast, 1f / Mathf.Max(0.001f, Moon.MeshContrast));
			Shader.SetGlobalFloat(Resources.ID_MoonMeshBrightness, Moon.MeshBrightness * (1f - Atmosphere.Fogginess));
			Shader.SetGlobalVector(Resources.ID_kBetaMie, kBetaMie);
			Shader.SetGlobalVector(Resources.ID_kSun, kSun);
			Shader.SetGlobalVector(Resources.ID_k4PI, k4PI);
			Shader.SetGlobalVector(Resources.ID_kRadius, kRadius);
			Shader.SetGlobalVector(Resources.ID_kScale, kScale);
			Shader.SetGlobalMatrix(Resources.ID_World2Sky, Components.DomeTransform.worldToLocalMatrix);
			Shader.SetGlobalMatrix(Resources.ID_Sky2World, Components.DomeTransform.localToWorldMatrix);
		}
	}

	private float ShaderScale(float inCos)
	{
		float num = 1f - inCos;
		return 0.25f * Mathf.Exp(-0.00287f + num * (0.459f + num * (3.83f + num * (-6.8f + num * 5.25f))));
	}

	private float ShaderMiePhase(float eyeCos, float eyeCos2)
	{
		return kBetaMie.x * (1f + eyeCos2) / Mathf.Pow(kBetaMie.y + kBetaMie.z * eyeCos, 1.5f);
	}

	private float ShaderRayleighPhase(float eyeCos2)
	{
		return 0.75f + 0.75f * eyeCos2;
	}

	private Color ShaderNightSkyColor(Vector3 dir)
	{
		dir.y = Mathf.Max(0f, dir.y);
		return MoonSkyColor * (1f - 0.75f * dir.y);
	}

	private Color ShaderMoonHaloColor(Vector3 dir)
	{
		return MoonHaloColor * Mathf.Pow(Mathf.Max(0f, Vector3.Dot(dir, LocalMoonDirection)), 1f / Moon.MeshSize);
	}

	private Color TOD_HDR2LDR(Color color)
	{
		return new Color(1f - Mathf.Pow(2f, (0f - Atmosphere.Brightness) * color.r), 1f - Mathf.Pow(2f, (0f - Atmosphere.Brightness) * color.g), 1f - Mathf.Pow(2f, (0f - Atmosphere.Brightness) * color.b), color.a);
	}

	private Color TOD_GAMMA2LINEAR(Color color)
	{
		return new Color(color.r * color.r, color.g * color.g, color.b * color.b, color.a);
	}

	private Color TOD_LINEAR2GAMMA(Color color)
	{
		return new Color(Mathf.Sqrt(color.r), Mathf.Sqrt(color.g), Mathf.Sqrt(color.b), color.a);
	}

	private Color ShaderScatteringColor(Vector3 dir, bool directLight = true)
	{
		dir.y = Mathf.Max(0f, dir.y);
		float x = kRadius.x;
		float y = kRadius.y;
		float w = kRadius.w;
		float x2 = kScale.x;
		float z = kScale.z;
		float w2 = kScale.w;
		float x3 = k4PI.x;
		float y2 = k4PI.y;
		float z2 = k4PI.z;
		float w3 = k4PI.w;
		float x4 = kSun.x;
		float y3 = kSun.y;
		float z3 = kSun.z;
		float w4 = kSun.w;
		Vector3 vector = new Vector3(0f, x + w2, 0f);
		float num = Mathf.Sqrt(w + y * dir.y * dir.y - y) - x * dir.y;
		float num2 = Mathf.Exp(z * (0f - w2));
		float inCos = Vector3.Dot(dir, vector) / (x + w2);
		float num3 = num2 * ShaderScale(inCos);
		float num4 = num / 2f;
		float num5 = num4 * x2;
		Vector3 vector2 = dir * num4;
		Vector3 vector3 = vector + vector2 * 0.5f;
		float num6 = 0f;
		float num7 = 0f;
		float num8 = 0f;
		for (int i = 0; i < 2; i++)
		{
			float magnitude = vector3.magnitude;
			float num9 = 1f / magnitude;
			float num10 = Mathf.Exp(z * (x - magnitude));
			float num11 = num10 * num5;
			float inCos2 = Vector3.Dot(dir, vector3) * num9;
			float inCos3 = Vector3.Dot(LocalSunDirection, vector3) * num9;
			float num12 = num3 + num10 * (ShaderScale(inCos3) - ShaderScale(inCos2));
			float num13 = Mathf.Exp((0f - num12) * (x3 + w3));
			float num14 = Mathf.Exp((0f - num12) * (y2 + w3));
			float num15 = Mathf.Exp((0f - num12) * (z2 + w3));
			num6 += num13 * num11;
			num7 += num14 * num11;
			num8 += num15 * num11;
			vector3 += vector2;
		}
		Color sunSkyColor = SunSkyColor;
		float num16 = sunSkyColor.r * num6 * x4;
		Color sunSkyColor2 = SunSkyColor;
		float num17 = sunSkyColor2.g * num7 * y3;
		Color sunSkyColor3 = SunSkyColor;
		float num18 = sunSkyColor3.b * num8 * z3;
		Color sunSkyColor4 = SunSkyColor;
		float num19 = sunSkyColor4.r * num6 * w4;
		Color sunSkyColor5 = SunSkyColor;
		float num20 = sunSkyColor5.g * num7 * w4;
		Color sunSkyColor6 = SunSkyColor;
		float num21 = sunSkyColor6.b * num8 * w4;
		float num22 = 0f;
		float num23 = 0f;
		float num24 = 0f;
		float num25 = Vector3.Dot(LocalSunDirection, dir);
		float eyeCos = num25 * num25;
		float num26 = ShaderRayleighPhase(eyeCos);
		num22 += num26 * num16;
		num23 += num26 * num17;
		num24 += num26 * num18;
		if (directLight)
		{
			float num27 = ShaderMiePhase(num25, eyeCos);
			num22 += num27 * num19;
			num23 += num27 * num20;
			num24 += num27 * num21;
		}
		Color color = ShaderNightSkyColor(dir);
		num22 += color.r;
		num23 += color.g;
		num24 += color.b;
		if (directLight)
		{
			Color color2 = ShaderMoonHaloColor(dir);
			num22 += color2.r;
			num23 += color2.g;
			num24 += color2.b;
		}
		float a = num22;
		Color fogColor = FogColor;
		num22 = Mathf.Lerp(a, fogColor.r, Atmosphere.Fogginess);
		float a2 = num23;
		Color fogColor2 = FogColor;
		num23 = Mathf.Lerp(a2, fogColor2.g, Atmosphere.Fogginess);
		float a3 = num24;
		Color fogColor3 = FogColor;
		num24 = Mathf.Lerp(a3, fogColor3.b, Atmosphere.Fogginess);
		num22 = Mathf.Pow(num22 * Atmosphere.Brightness, Atmosphere.Contrast);
		num23 = Mathf.Pow(num23 * Atmosphere.Brightness, Atmosphere.Contrast);
		num24 = Mathf.Pow(num24 * Atmosphere.Brightness, Atmosphere.Contrast);
		return new Color(num22, num23, num24, 1f);
	}

	private void Initialize()
	{
		Components = GetComponent<TOD_Components>();
		Components.Initialize();
		Resources = GetComponent<TOD_Resources>();
		Resources.Initialize();
		instances.Add(this);
		Initialized = true;
	}

	private void Cleanup()
	{
		if ((bool)Probe)
		{
			UnityEngine.Object.Destroy(Probe.gameObject);
		}
		instances.Remove(this);
		Initialized = false;
	}

	protected void OnEnable()
	{
		LateUpdate();
	}

	protected void OnDisable()
	{
		Cleanup();
	}

	protected void LateUpdate()
	{
		if (!Initialized)
		{
			Initialize();
		}
		UpdateScattering();
		UpdateCelestials();
		UpdateQualitySettings();
		UpdateRenderSettings();
		UpdateShaderKeywords();
		UpdateShaderProperties();
	}

	protected void OnValidate()
	{
		Cycle.DateTime = Cycle.DateTime;
	}
}
