using UnityEngine;

namespace EVP
{
	[RequireComponent(typeof(ParticleSystem))]
	public class TireParticleEmitter : MonoBehaviour
	{
		public enum Mode
		{
			PressureAndSkid,
			PressureAndVelocity
		}

		public Mode mode;

		public float emissionRate = 10f;

		[Range(0f, 1f)]
		public float emissionShuffle;

		public float maxLifetime = 7f;

		public float minVelocity = 1f;

		public float maxVelocity = 15f;

		[Range(0f, 1f)]
		public float tireVelocityRatio = 0.5f;

		public Color Color1 = Color.white;

		public Color Color2 = Color.gray;

		public bool randomColor;

		private ParticleSystem m_particles;

		private ParticleSystem.EmitParams m_emitParams;

		private void OnEnable()
		{
			m_particles = GetComponent<ParticleSystem>();
			m_particles.Stop();
		}

		public float EmitParticle(Vector3 position, Vector3 wheelVelocity, Vector3 tireVelocity, float pressureRatio, float intensityRatio, float lastParticleTime)
		{
			if (!base.isActiveAndEnabled)
			{
				return -1f;
			}
			if (lastParticleTime < 0f)
			{
				lastParticleTime = Time.time - 1f / emissionRate;
			}
			int num = (int)((Time.time - lastParticleTime) * emissionRate);
			if (num <= 0)
			{
				return lastParticleTime;
			}
			float num2 = 0f;
			switch (mode)
			{
			case Mode.PressureAndSkid:
				num2 = pressureRatio * intensityRatio * maxLifetime;
				break;
			case Mode.PressureAndVelocity:
			{
				float value = tireVelocity.magnitude + wheelVelocity.magnitude;
				num2 = pressureRatio * maxLifetime * Mathf.InverseLerp(minVelocity, maxVelocity, value);
				break;
			}
			}
			if (num2 <= 0f)
			{
				return -1f;
			}
			for (int i = 0; i < num; i++)
			{
				Vector3 velocity = wheelVelocity * 0.9f + tireVelocity * tireVelocityRatio;
				float num3 = num2 * UnityEngine.Random.Range(0.6f, 1.4f);
				float startSize = num3 / maxLifetime * UnityEngine.Random.Range(0.8f, 1.4f);
				float rotation = UnityEngine.Random.Range(0f, 360f);
				Color c = (!randomColor) ? Color1 : Color.Lerp(Color1, Color2, UnityEngine.Random.value);
				uint randomSeed = (uint)UnityEngine.Random.Range(0, 20000);
				m_emitParams.position = position;
				m_emitParams.rotation = rotation;
				m_emitParams.velocity = velocity;
				m_emitParams.angularVelocity = 0f;
				m_emitParams.startLifetime = num3;
				m_emitParams.startSize = startSize;
				m_emitParams.startColor = c;
				m_emitParams.randomSeed = randomSeed;
				m_particles.Emit(m_emitParams, 1);
			}
			return Time.time + UnityEngine.Random.Range(0f - emissionShuffle, emissionShuffle) / emissionRate;
		}
	}
}
