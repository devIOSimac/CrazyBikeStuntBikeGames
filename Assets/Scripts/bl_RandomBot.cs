using UnityEngine;
using UnityEngine.AI;

public class bl_RandomBot : MonoBehaviour
{
	private NavMeshAgent m_Agent;

	private NavMeshAgent Agent
	{
		get
		{
			if (m_Agent == null)
			{
				m_Agent = GetComponent<NavMeshAgent>();
			}
			return m_Agent;
		}
	}

	private void FixedUpdate()
	{
		if (!Agent.hasPath)
		{
			RandomBot();
		}
	}

	private void RandomBot()
	{
		Vector3 a = UnityEngine.Random.insideUnitSphere * 50f;
		a += base.transform.position;
		NavMesh.SamplePosition(a, out NavMeshHit hit, 50f, 1);
		Vector3 position = hit.position;
		Agent.SetDestination(position);
	}
}
