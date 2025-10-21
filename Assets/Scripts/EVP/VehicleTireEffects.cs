using UnityEngine;

namespace EVP
{
	[RequireComponent(typeof(VehicleController))]
	public class VehicleTireEffects : MonoBehaviour
	{
		public float tireWidth = 0.2f;

		public float minSlip = 1f;

		public float maxSlip = 5f;

		[Header("Tire marks")]
		[Range(0f, 2f)]
		public float intensity = 1f;

		public float updateInterval = 0.02f;

		[Header("Smoke")]
		public float minIntensityTime = 0.5f;

		public float maxIntensityTime = 6f;

		public float limitIntensityTime = 10f;

		private VehicleController m_vehicle;

		private TireFxData[] m_fxData = new TireFxData[0];

		private void OnEnable()
		{
			m_vehicle = GetComponent<VehicleController>();
			m_vehicle.computeExtendedTireData = true;
		}

		private void Update()
		{
			if (m_vehicle.wheelData.Length != m_fxData.Length)
			{
				InitializeTireFxData();
			}
			int i = 0;
			for (int num = m_fxData.Length; i < num; i++)
			{
				WheelData wheelData = m_vehicle.wheelData[i];
				TireFxData fxData = m_fxData[i];
				UpdateTireMarks(wheelData, fxData);
				UpdateTireParticles(wheelData, fxData);
			}
		}

		private void InitializeTireFxData()
		{
			m_fxData = new TireFxData[m_vehicle.wheelData.Length];
			for (int i = 0; i < m_fxData.Length; i++)
			{
				m_fxData[i] = new TireFxData();
			}
		}

		private void UpdateTireMarks(WheelData wheelData, TireFxData fxData)
		{
			if (fxData.lastMarksIndex != -1 && wheelData.grounded && fxData.marksDelta < updateInterval)
			{
				fxData.marksDelta += Time.deltaTime;
				return;
			}
			float num = fxData.marksDelta;
			if (num == 0f)
			{
				num = Time.deltaTime;
			}
			fxData.marksDelta = 0f;
			if (!wheelData.grounded || wheelData.hit.collider.attachedRigidbody != null)
			{
				fxData.lastMarksIndex = -1;
				return;
			}
			TireMarksRenderer tireMarksRenderer = (wheelData.groundMaterial == null) ? null : wheelData.groundMaterial.marksRenderer;
			if (tireMarksRenderer != fxData.lastRenderer)
			{
				fxData.lastRenderer = tireMarksRenderer;
				fxData.lastMarksIndex = -1;
			}
			if (tireMarksRenderer != null)
			{
				float pressureRatio = Mathf.Clamp01(intensity * wheelData.downforceRatio * 0.5f);
				float skidRatio = Mathf.InverseLerp(minSlip, maxSlip, wheelData.combinedTireSlip);
				TireMarksRenderer tireMarksRenderer2 = tireMarksRenderer;
				Vector3 point = wheelData.rayHit.point;
				Vector3 right = wheelData.transform.right;
				Vector3 center = wheelData.collider.center;
				fxData.lastMarksIndex = tireMarksRenderer2.AddMark(point - right * center.x + wheelData.velocity * num, wheelData.rayHit.normal, pressureRatio, skidRatio, tireWidth, fxData.lastMarksIndex);
			}
		}

		private void UpdateTireParticles(WheelData wheelData, TireFxData fxData)
		{
			if (!wheelData.grounded)
			{
				fxData.lastParticleTime = -1f;
				fxData.slipTime -= Time.deltaTime;
				if (fxData.slipTime < 0f)
				{
					fxData.slipTime = 0f;
				}
				return;
			}
			TireParticleEmitter tireParticleEmitter = (wheelData.groundMaterial == null) ? null : wheelData.groundMaterial.particleEmitter;
			if (tireParticleEmitter != fxData.lastEmitter)
			{
				fxData.lastEmitter = tireParticleEmitter;
				fxData.lastParticleTime = -1f;
			}
			if (tireParticleEmitter != null)
			{
				Vector3 a = wheelData.rayHit.point + wheelData.transform.up * tireWidth * 0.5f;
				Vector3 b = UnityEngine.Random.insideUnitSphere * tireWidth;
				float num = Mathf.Clamp01(wheelData.downforceRatio);
				float num2 = Mathf.InverseLerp(minSlip, maxSlip, wheelData.combinedTireSlip);
				if (num2 > 0f && tireParticleEmitter.mode == TireParticleEmitter.Mode.PressureAndSkid)
				{
					fxData.slipTime += Time.deltaTime * num2 * num;
				}
				else
				{
					fxData.slipTime -= Time.deltaTime;
				}
				fxData.slipTime = Mathf.Clamp(fxData.slipTime, 0f, limitIntensityTime);
				float num3 = Mathf.InverseLerp(minIntensityTime, maxIntensityTime, fxData.slipTime);
				fxData.lastParticleTime = tireParticleEmitter.EmitParticle(a + b, wheelData.velocity, wheelData.tireSlip.y * wheelData.transform.forward, num, num2 * num3, fxData.lastParticleTime);
			}
			else
			{
				fxData.slipTime -= Time.deltaTime;
				if (fxData.slipTime < 0f)
				{
					fxData.slipTime = 0f;
				}
			}
		}
	}
}
