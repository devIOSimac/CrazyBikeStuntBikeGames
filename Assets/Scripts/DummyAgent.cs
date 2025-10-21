using UnityEngine;
using UnityEngine.AI;

public class DummyAgent : MonoBehaviour
{
	public Transform target;

	private NavMeshAgent agent;

	private void Start()
	{
		agent = GetComponent<NavMeshAgent>();
	}

	private void Update()
	{
		agent.SetDestination(target.position);
	}
}
