using UnityEngine;

public class VehicleNitro : MonoBehaviour
{
	public enum Mode
	{
		Acceleration,
		Impulse
	}

	public Mode mode;

	public float value = 10f;

	public float maxVelocity = 50f;

	public KeyCode key = KeyCode.N;

	private Rigidbody m_rigidbody;

	private void OnEnable()
	{
		m_rigidbody = GetComponent<Rigidbody>();
	}

	private void Update()
	{
		if (mode == Mode.Impulse && UnityEngine.Input.GetKeyDown(key) && m_rigidbody.velocity.magnitude < maxVelocity)
		{
			m_rigidbody.AddRelativeForce(Vector3.forward * value, ForceMode.VelocityChange);
		}
	}

	private void FixedUpdate()
	{
		if (mode == Mode.Acceleration && UnityEngine.Input.GetKey(key) && m_rigidbody.velocity.magnitude < maxVelocity)
		{
			m_rigidbody.AddRelativeForce(Vector3.forward * value, ForceMode.Acceleration);
		}
	}
}
