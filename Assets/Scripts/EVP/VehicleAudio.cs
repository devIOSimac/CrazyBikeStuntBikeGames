using System;
using UnityEngine;

namespace EVP
{
	[RequireComponent(typeof(VehicleController))]
	public class VehicleAudio : MonoBehaviour
	{
		[Serializable]
		public class Engine
		{
			public AudioSource audioSource;

			[Space(5f)]
			public float idleRpm = 600f;

			public float idlePitch = 0.25f;

			public float idleVolume = 0.4f;

			[Space(5f)]
			public float maxRpm = 6000f;

			public float maxPitch = 1.5f;

			public float maxVolume = 0.6f;

			[Space(5f)]
			public float throttleRpmBoost = 500f;

			public float throttleVolumeBoost = 0.4f;

			[Space(5f)]
			public float wheelsToEngineRatio = 16f;

			public int gears = 5;

			public float gearDownRpm = 2500f;

			public float gearUpRpm = 5000f;

			[Space(5f)]
			public float gearUpRpmRate = 5f;

			public float gearDownRpmRate = 6f;

			public float volumeChangeRateUp = 48f;

			public float volumeChangeRateDown = 16f;
		}

		[Serializable]
		public class EngineExtras
		{
			public AudioSource turboAudioSource;

			public float turboMinRpm = 3500f;

			public float turboMaxRpm = 5500f;

			[Range(0f, 3f)]
			public float turboMinPitch = 0.8f;

			[Range(0f, 3f)]
			public float turboMaxPitch = 1.5f;

			[Range(0f, 1f)]
			public float turboMaxVolume = 1f;

			public bool turboRequiresThrottle = true;

			[Space(5f)]
			public AudioClip turboDumpClip;

			public float turboDumpMinRpm = 5000f;

			public float turboDumpMinInterval = 2f;

			public float turboDumpMinThrottleTime = 0.3f;

			public float turboDumpVolume = 0.5f;

			[Space(5f)]
			public AudioSource transmissionAudioSource;

			[Range(0.1f, 1f)]
			public float transmissionMaxRatio = 0.9f;

			[Range(0f, 3f)]
			public float transmissionMinPitch = 0.2f;

			[Range(0f, 3f)]
			public float transmissionMaxPitch = 1.1f;

			[Range(0f, 1f)]
			public float transmissionMinVolume = 0.1f;

			[Range(0f, 1f)]
			public float transmissionMaxVolume = 0.2f;
		}

		[Serializable]
		public class Wheels
		{
			public AudioSource skidAudioSource;

			public float skidMinSlip = 2f;

			public float skidMaxSlip = 7f;

			[Range(0f, 3f)]
			public float skidMinPitch = 0.9f;

			[Range(0f, 3f)]
			public float skidMaxPitch = 0.8f;

			[Range(0f, 1f)]
			public float skidMaxVolume = 0.75f;

			[Space(5f)]
			public AudioSource offroadAudioSource;

			public float offroadMinSpeed = 1f;

			public float offroadMaxSpeed = 20f;

			[Range(0f, 3f)]
			public float offroadMinPitch = 0.3f;

			[Range(0f, 3f)]
			public float offroadMaxPitch = 2.5f;

			[Range(0f, 1f)]
			public float offroadMinVolume = 0.3f;

			[Range(0f, 1f)]
			public float offroadMaxVolume = 0.6f;

			[Space(5f)]
			public AudioClip bumpAudioClip;

			public float bumpMinForceDelta = 2000f;

			public float bumpMaxForceDelta = 18000f;

			[Range(0f, 1f)]
			public float bumpMinVolume = 0.2f;

			[Range(0f, 1f)]
			public float bumpMaxVolume = 0.6f;
		}

		[Serializable]
		public class Impacts
		{
			[Space(5f)]
			public AudioClip hardImpactAudioClip;

			public AudioClip softImpactAudioClip;

			public float minSpeed = 0.1f;

			public float maxSpeed = 10f;

			[Range(0f, 3f)]
			public float minPitch = 0.3f;

			[Range(0f, 3f)]
			public float maxPitch = 0.6f;

			[Range(0f, 3f)]
			public float randomPitch = 0.2f;

			[Range(0f, 1f)]
			public float minVolume = 0.7f;

			[Range(0f, 1f)]
			public float maxVolume = 1f;

			[Range(0f, 1f)]
			public float randomVolume = 0.2f;
		}

		[Serializable]
		public class Drags
		{
			public AudioSource hardDragAudioSource;

			public AudioSource softDragAudioSource;

			public float minSpeed = 2f;

			public float maxSpeed = 20f;

			[Range(0f, 3f)]
			public float minPitch = 0.6f;

			[Range(0f, 3f)]
			public float maxPitch = 0.8f;

			[Range(0f, 1f)]
			public float minVolume = 0.8f;

			[Range(0f, 1f)]
			public float maxVolume = 1f;

			[Space(5f)]
			public AudioClip scratchAudioClip;

			public float scratchRandomThreshold = 0.02f;

			public float scratchMinSpeed = 2f;

			public float scratchMinInterval = 0.2f;

			[Range(0f, 3f)]
			public float scratchMinPitch = 0.7f;

			[Range(0f, 3f)]
			public float scratchMaxPitch = 1.1f;

			[Range(0f, 1f)]
			public float scratchMinVolume = 0.9f;

			[Range(0f, 1f)]
			public float scratchMaxVolume = 1f;
		}

		[Serializable]
		public class Wind
		{
			public AudioSource windAudioSource;

			public float minSpeed = 3f;

			public float maxSpeed = 30f;

			[Range(0f, 3f)]
			public float minPitch = 0.5f;

			[Range(0f, 3f)]
			public float maxPitch = 1f;

			[Range(0f, 1f)]
			public float maxVolume = 0.5f;
		}

		[Tooltip("AudioSource to be used with the one-time audio effects (impacts, etc)")]
		public AudioSource audioClipTemplate;

		[Space(2f)]
		public Engine engine = new Engine();

		[Space(2f)]
		public EngineExtras engineExtras = new EngineExtras();

		[Space(2f)]
		public Wheels wheels = new Wheels();

		[Space(2f)]
		public Impacts impacts = new Impacts();

		[Space(2f)]
		public Drags drags = new Drags();

		[Space(2f)]
		public Wind wind = new Wind();

		[NonSerialized]
		public float skidRatioChangeRate = 40f;

		[NonSerialized]
		public float offroadSpeedChangeRate = 20f;

		[NonSerialized]
		public float offroadCutoutSpeed = 0.02f;

		[NonSerialized]
		public float dragCutoutSpeed = 0.01f;

		[NonSerialized]
		public float turboRatioChangeRate = 8f;

		[NonSerialized]
		public float wheelsRpmChangeRateLimit = 400f;

		private VehicleController m_vehicle;

		private float m_engineRpm;

		private float m_engineThrottleRpm;

		private float m_engineRpmDamp;

		private float m_wheelsRpm;

		private int m_gear;

		private int m_lastGear;

		private float m_skidRatio;

		private float m_offroadSpeed;

		private float m_lastScratchTime;

		private float m_turboRatio;

		private float m_lastTurboDumpTime;

		private float m_lastThrottleInput;

		private float m_lastThrottlePressedTime;

		private WheelAudioData[] m_audioData = new WheelAudioData[0];

		public int simulatedGear => m_gear;

		public float simulatedEngineRpm => m_engineRpm;

		private void OnEnable()
		{
			m_vehicle = GetComponent<VehicleController>();
			m_vehicle.processContacts = true;
			VehicleController vehicle = m_vehicle;
			vehicle.onImpact = (VehicleController.OnImpact)Delegate.Combine(vehicle.onImpact, new VehicleController.OnImpact(DoImpactAudio));
			m_vehicle.computeExtendedTireData = true;
			if (engine.gears < 2)
			{
				engine.gears = 2;
			}
			m_engineRpmDamp = engine.gearUpRpmRate;
			m_wheelsRpm = 0f;
			VerifyAudioSources();
		}

		private void OnDisable()
		{
			StopAudio(engine.audioSource);
		}

		private void Update()
		{
			DoEngineAudio();
			DoEngineExtraAudio();
			DoBodyDragAudio();
			DoWindAudio();
			DoTireAudio();
			m_lastGear = m_gear;
			m_lastThrottleInput = m_vehicle.throttleInput;
		}

		private void FixedUpdate()
		{
			if (m_vehicle.wheelData.Length != m_audioData.Length)
			{
				InitializeAudioData();
			}
			DoWheelBumpAudio();
		}

		private void InitializeAudioData()
		{
			m_audioData = new WheelAudioData[m_vehicle.wheelData.Length];
			for (int i = 0; i < m_audioData.Length; i++)
			{
				m_audioData[i] = new WheelAudioData();
			}
		}

		private void DoEngineAudio()
		{
			float num = 0f;
			int num2 = 0;
			WheelData[] wheelData = m_vehicle.wheelData;
			foreach (WheelData wheelData2 in wheelData)
			{
				if (wheelData2.wheel.drive)
				{
					num2++;
					num += wheelData2.angularVelocity;
				}
			}
			if (num2 == 0)
			{
				if (engine.audioSource != null)
				{
					engine.audioSource.Stop();
				}
				return;
			}
			num /= (float)num2;
			m_wheelsRpm = Mathf.MoveTowards(m_wheelsRpm, num * 57.29578f / 6f, wheelsRpmChangeRateLimit * Time.deltaTime);
			float num3 = m_wheelsRpm * engine.wheelsToEngineRatio;
			float value;
			if (Mathf.Abs(m_wheelsRpm) < 1f)
			{
				m_gear = 0;
				value = engine.idleRpm + Mathf.Abs(num3);
			}
			else if (num3 >= 0f)
			{
				float num4 = engine.gearUpRpm - engine.idleRpm;
				if (num3 < num4)
				{
					m_gear = 1;
					value = num3 + engine.idleRpm;
				}
				else
				{
					float num5 = engine.gearUpRpm - engine.gearDownRpm;
					m_gear = 2 + (int)((num3 - num4) / num5);
					if (m_gear > engine.gears)
					{
						m_gear = engine.gears;
						value = num3 - num4 - (float)(engine.gears - 2) * num5 + engine.gearDownRpm;
					}
					else
					{
						value = Mathf.Repeat(num3 - num4, num5) + engine.gearDownRpm;
					}
				}
			}
			else
			{
				m_gear = -1;
				value = Mathf.Abs(num3) + engine.idleRpm;
			}
			value = Mathf.Clamp(value, 10f, engine.maxRpm);
			if (m_gear != m_lastGear)
			{
				m_engineRpmDamp = ((m_gear <= m_lastGear) ? engine.gearDownRpmRate : engine.gearUpRpmRate);
			}
			m_engineRpm = Mathf.Lerp(m_engineRpm, value, m_engineRpmDamp * Time.deltaTime);
			m_engineThrottleRpm = Mathf.Lerp(m_engineThrottleRpm, m_vehicle.throttleInput * engine.throttleRpmBoost, m_engineRpmDamp * Time.deltaTime);
			if (engine.audioSource != null)
			{
				float num6 = Mathf.InverseLerp(engine.idleRpm, engine.maxRpm, m_engineRpm + m_engineThrottleRpm);
				ProcessContinuousAudioPitch(engine.audioSource, num6, engine.idlePitch, engine.maxPitch);
				float volume = Mathf.Lerp(engine.idleVolume, engine.maxVolume, num6) + Mathf.Abs(m_vehicle.throttleInput) * engine.throttleVolumeBoost;
				ProcessVolume(engine.audioSource, volume, engine.volumeChangeRateUp, engine.volumeChangeRateDown);
			}
		}

		private void DoEngineExtraAudio()
		{
			float num = Mathf.InverseLerp(engineExtras.turboMinRpm, engineExtras.turboMaxRpm, m_engineRpm);
			if (engineExtras.turboRequiresThrottle)
			{
				num *= Mathf.Clamp01(m_vehicle.throttleInput);
			}
			m_turboRatio = Mathf.Lerp(m_turboRatio, num, turboRatioChangeRate * Time.deltaTime);
			ProcessContinuousAudio(engineExtras.turboAudioSource, m_turboRatio, engineExtras.turboMinPitch, engineExtras.turboMaxPitch, 0f, engineExtras.turboMaxVolume);
			if (engineExtras.turboDumpClip != null && Time.time - m_lastTurboDumpTime > engineExtras.turboDumpMinInterval && m_engineRpm > engineExtras.turboDumpMinRpm)
			{
				bool flag = m_gear != m_lastGear && m_lastGear > 0 && m_gear > 0 && m_gear > m_lastGear;
				bool flag2 = m_vehicle.throttleInput < 0.5f && (m_vehicle.throttleInput - m_lastThrottleInput) / Time.deltaTime < -20f;
				float num2 = Time.time - m_lastThrottlePressedTime;
				if (m_vehicle.throttleInput < 0.2f)
				{
					m_lastThrottlePressedTime = Time.time;
				}
				if ((flag || flag2) && num2 > engineExtras.turboDumpMinThrottleTime)
				{
					Vector3 position = (!(engineExtras.turboAudioSource != null)) ? m_vehicle.cachedTransform.position : engineExtras.turboAudioSource.transform.position;
					PlayOneTime(engineExtras.turboDumpClip, position, engineExtras.turboDumpVolume);
					m_lastTurboDumpTime = Time.time;
				}
			}
			float ratio = Mathf.Abs(m_wheelsRpm * engine.wheelsToEngineRatio) / (engine.maxRpm * (float)engine.gears * engineExtras.transmissionMaxRatio);
			ProcessContinuousAudio(engineExtras.transmissionAudioSource, ratio, engineExtras.transmissionMinPitch, engineExtras.transmissionMaxPitch, engineExtras.transmissionMinVolume, engineExtras.transmissionMaxVolume);
		}

		private void DoTireAudio()
		{
			float num = 0f;
			float num2 = 0f;
			int num3 = 0;
			WheelData[] wheelData = m_vehicle.wheelData;
			foreach (WheelData wheelData2 in wheelData)
			{
				if (wheelData2.groundMaterial == null || wheelData2.groundMaterial.surfaceType == GroundMaterial.SurfaceType.Hard)
				{
					num += Mathf.InverseLerp(wheels.skidMinSlip, wheels.skidMaxSlip, wheelData2.combinedTireSlip);
				}
				else if (wheelData2.grounded)
				{
					num2 += wheelData2.velocity.magnitude + Mathf.Abs(wheelData2.tireSlip.y);
					num3++;
				}
			}
			m_skidRatio = Mathf.Lerp(m_skidRatio, num, skidRatioChangeRate * Time.deltaTime);
			ProcessContinuousAudio(wheels.skidAudioSource, m_skidRatio, wheels.skidMinPitch, wheels.skidMaxPitch, 0f, wheels.skidMaxVolume);
			if (num3 > 1)
			{
				num2 /= (float)num3;
			}
			m_offroadSpeed = Mathf.Lerp(m_offroadSpeed, num2, offroadSpeedChangeRate * Time.deltaTime);
			ProcessSpeedBasedAudio(wheels.offroadAudioSource, m_offroadSpeed, offroadCutoutSpeed, wheels.offroadMinSpeed, wheels.offroadMaxSpeed, 0f, wheels.offroadMinPitch, wheels.offroadMaxPitch, wheels.offroadMinVolume, wheels.offroadMaxVolume);
		}

		private void DoImpactAudio()
		{
			if (!(impacts.hardImpactAudioClip != null) && !(impacts.softImpactAudioClip != null))
			{
				return;
			}
			float magnitude = m_vehicle.localImpactVelocity.magnitude;
			if (magnitude > impacts.minSpeed)
			{
				float t = Mathf.InverseLerp(impacts.minSpeed, impacts.maxSpeed, magnitude);
				AudioClip audioClip = null;
				audioClip = (impacts.softImpactAudioClip ? ((!m_vehicle.isHardImpact) ? impacts.softImpactAudioClip : impacts.hardImpactAudioClip) : impacts.hardImpactAudioClip);
				if ((bool)audioClip)
				{
					PlayOneTime(audioClip, m_vehicle.cachedTransform.TransformPoint(m_vehicle.localImpactPosition), Mathf.Lerp(impacts.minVolume, impacts.maxVolume, t) + UnityEngine.Random.Range(0f - impacts.randomVolume, impacts.randomVolume), Mathf.Lerp(impacts.minPitch, impacts.maxPitch, t) + UnityEngine.Random.Range(0f - impacts.randomPitch, impacts.randomPitch));
				}
			}
		}

		private void DoBodyDragAudio()
		{
			float magnitude = m_vehicle.localDragVelocity.magnitude;
			float speed = (!m_vehicle.isHardDrag) ? 0f : magnitude;
			float speed2 = (!m_vehicle.isHardDrag) ? magnitude : 0f;
			ProcessSpeedBasedAudio(drags.hardDragAudioSource, speed, dragCutoutSpeed, drags.minSpeed, drags.maxSpeed, 0f, drags.minPitch, drags.maxPitch, drags.minVolume, drags.maxVolume);
			ProcessSpeedBasedAudio(drags.softDragAudioSource, speed2, dragCutoutSpeed, drags.minSpeed, drags.maxSpeed, 0f, drags.minPitch, drags.maxPitch, drags.minVolume, drags.maxVolume);
			if (drags.scratchAudioClip != null && magnitude > drags.scratchMinSpeed && m_vehicle.isHardDrag && UnityEngine.Random.value < drags.scratchRandomThreshold && Time.time - m_lastScratchTime > drags.scratchMinInterval)
			{
				PlayOneTime(drags.scratchAudioClip, m_vehicle.cachedTransform.TransformPoint(m_vehicle.localDragPosition), UnityEngine.Random.Range(drags.scratchMinVolume, drags.scratchMaxVolume), UnityEngine.Random.Range(drags.scratchMinPitch, drags.scratchMaxPitch));
				m_lastScratchTime = Time.time;
			}
		}

		private void DoWheelBumpAudio()
		{
			if (wheels.bumpAudioClip == null)
			{
				return;
			}
			int i = 0;
			for (int num = m_vehicle.wheelData.Length; i < num; i++)
			{
				WheelData wheelData = m_vehicle.wheelData[i];
				WheelAudioData wheelAudioData = m_audioData[i];
				float num2 = wheelData.downforce - wheelAudioData.lastDownforce;
				wheelAudioData.lastDownforce = wheelData.downforce;
				if (num2 > wheels.bumpMinForceDelta && Time.fixedTime - wheelAudioData.lastWheelBumpTime > 0.03f)
				{
					ProcessWheelBumpAudio(num2, wheelData.transform.position);
					wheelAudioData.lastWheelBumpTime = Time.fixedTime;
				}
			}
		}

		private void DoWindAudio()
		{
			float ratio = Mathf.InverseLerp(wind.minSpeed, wind.maxSpeed, m_vehicle.cachedRigidbody.velocity.magnitude);
			ProcessContinuousAudio(wind.windAudioSource, ratio, wind.minPitch, wind.maxPitch, 0f, wind.maxVolume);
		}

		private void StopAudio(AudioSource audio)
		{
			if (audio != null)
			{
				audio.Stop();
			}
		}

		private void ProcessContinuousAudio(AudioSource audio, float ratio, float minPitch, float maxPitch, float minVolume, float maxVolume)
		{
			if (!(audio == null))
			{
				audio.pitch = Mathf.Lerp(minPitch, maxPitch, ratio);
				audio.volume = Mathf.Lerp(minVolume, maxVolume, ratio);
				if (!audio.isPlaying)
				{
					audio.Play();
				}
				audio.loop = true;
			}
		}

		private void ProcessContinuousAudioPitch(AudioSource audio, float ratio, float minPitch, float maxPitch)
		{
			if (!(audio == null))
			{
				audio.pitch = Mathf.Lerp(minPitch, maxPitch, ratio);
				if (!audio.isPlaying)
				{
					audio.Play();
				}
				audio.loop = true;
			}
		}

		private void ProcessVolume(AudioSource audio, float volume, float changeRateUp, float changeRateDown)
		{
			float num = (!(volume > audio.volume)) ? changeRateDown : changeRateUp;
			audio.volume = Mathf.Lerp(audio.volume, volume, Time.deltaTime * num);
		}

		private void ProcessSpeedBasedAudio(AudioSource audio, float speed, float cutoutSpeed, float minSpeed, float maxSpeed, float cutoutPitch, float minPitch, float maxPitch, float minVolume, float maxVolume)
		{
			if (audio == null)
			{
				return;
			}
			if (speed < cutoutSpeed)
			{
				if (audio.isPlaying)
				{
					audio.Stop();
				}
				return;
			}
			if (speed < minSpeed)
			{
				float t = Mathf.InverseLerp(cutoutSpeed, minSpeed, speed);
				audio.pitch = Mathf.Lerp(cutoutPitch, minPitch, t);
				audio.volume = Mathf.Lerp(0f, minVolume, t);
			}
			else
			{
				float t2 = Mathf.InverseLerp(minSpeed, maxSpeed, speed);
				audio.pitch = Mathf.Lerp(minPitch, maxPitch, t2);
				audio.volume = Mathf.Lerp(minVolume, maxVolume, t2);
			}
			if (!audio.isPlaying)
			{
				audio.Play();
			}
			audio.loop = true;
		}

		private void ProcessWheelBumpAudio(float suspensionForceDelta, Vector3 position)
		{
			float t = Mathf.InverseLerp(wheels.bumpMinForceDelta, wheels.bumpMaxForceDelta, suspensionForceDelta);
			PlayOneTime(wheels.bumpAudioClip, position, Mathf.Lerp(wheels.bumpMinVolume, wheels.bumpMaxVolume, t));
		}

		private void PlayOneTime(AudioClip clip, Vector3 position, float volume)
		{
			PlayOneTime(clip, position, volume, 1f);
		}

		private void PlayOneTime(AudioClip clip, Vector3 position, float volume, float pitch)
		{
			if (!(clip == null) && !(pitch < 0.01f) && !(volume < 0.01f))
			{
				GameObject gameObject;
				AudioSource audioSource;
				if (audioClipTemplate != null)
				{
					gameObject = UnityEngine.Object.Instantiate(audioClipTemplate.gameObject, position, Quaternion.identity);
					audioSource = gameObject.GetComponent<AudioSource>();
					gameObject.transform.parent = audioClipTemplate.transform.parent;
				}
				else
				{
					gameObject = new GameObject("One shot audio");
					gameObject.transform.parent = m_vehicle.cachedTransform;
					gameObject.transform.position = position;
					audioSource = null;
				}
				if (audioSource == null)
				{
					audioSource = gameObject.AddComponent<AudioSource>();
					audioSource.spatialBlend = 1f;
				}
				audioSource.clip = clip;
				audioSource.volume = volume;
				audioSource.pitch = pitch;
				audioSource.dopplerLevel = 0f;
				audioSource.Play();
				UnityEngine.Object.Destroy(gameObject, clip.length / pitch);
			}
		}

		private void VerifyAudioSources()
		{
		}

		private void VerifyAudioSource(ref AudioSource audioSource)
		{
			if (audioSource != null && !audioSource.transform.IsChildOf(m_vehicle.transform))
			{
				UnityEngine.Debug.LogWarning(m_vehicle.name + ": VehicleAudio: The audio source [" + audioSource.name + "] is not child of this vehicle. Disabled.", m_vehicle);
				audioSource = null;
			}
		}
	}
}
