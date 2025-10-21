using UnityEngine;
using UnityEngine.AI;

public class NavigationScript : MonoBehaviour
{
	public Transform points;

	public Transform[] pointsArray;

	public int startingPoint;

	public bool Ascending;

	public int cpCounter;

	private NavMeshAgent agent;

	public Transform raycastPoint;

	public int speed;

	private void Start()
	{
		speed = 10;
		pointsArray = new Transform[points.childCount];
		for (int i = 0; i < points.childCount; i++)
		{
			pointsArray[i] = points.GetChild(i);
		}
		agent = GetComponent<NavMeshAgent>();
		cpCounter = startingPoint;
		if (Ascending)
		{
			agent.SetDestination(pointsArray[cpCounter].position);
			return;
		}
		cpCounter--;
		if (cpCounter < 0)
		{
			cpCounter = pointsArray.Length - 1;
			agent.SetDestination(pointsArray[cpCounter].position);
		}
		else
		{
			agent.SetDestination(pointsArray[cpCounter--].position);
		}
	}

	private void lookForObstacles()
	{
		if (Physics.Raycast(raycastPoint.transform.position, -1f * raycastPoint.transform.right, out RaycastHit hitInfo, 25f))
		{
			if (hitInfo.collider.gameObject.tag == "Player")
			{
				agent.speed = 0f;
			}
			else
			{
				agent.speed = speed;
			}
		}
		else
		{
			agent.speed = speed;
		}
		UnityEngine.Debug.DrawRay(raycastPoint.transform.position, -1f * raycastPoint.transform.right * 25f);
	}

	private void Update()
	{
		checkNextPoint();
		lookForObstacles();
	}

	private void checkNextPoint()
	{
		if (!(agent.remainingDistance < 10f))
		{
			return;
		}
		if (Ascending)
		{
			if (cpCounter == pointsArray.Length)
			{
				cpCounter = 1;
			}
			agent.SetDestination(pointsArray[cpCounter].position);
			return;
		}
		cpCounter--;
		if (cpCounter < 0)
		{
			cpCounter = pointsArray.Length - 1;
			agent.SetDestination(pointsArray[cpCounter].position);
		}
		else
		{
			agent.SetDestination(pointsArray[cpCounter--].position);
		}
	}
}
