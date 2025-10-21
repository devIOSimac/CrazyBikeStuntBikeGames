using UnityEngine;
using UnityEngine.AI;

public class SampleNavigation : MonoBehaviour
{
	public int startingPoint;

	public Transform pointsParent;

	public Transform raycastPoint;

	private Transform[] pointsArray;

	private NavMeshAgent currentAgent;

	private int currentPoint;

	private float speed;

	private GameObject playerInst;

	private void Awake()
	{
		currentAgent = base.gameObject.GetComponent<NavMeshAgent>();
		pointsArray = new Transform[pointsParent.childCount];
		for (int i = 0; i < pointsParent.childCount; i++)
		{
			pointsArray[i] = pointsParent.GetChild(i);
		}
	}

	private void Start()
	{
		if (startingPoint >= 1)
		{
			currentPoint = startingPoint - 1;
		}
		else
		{
			UnityEngine.Debug.LogError("Dont use Zero for Starting Point");
		}
		playerInst = GameObject.FindGameObjectWithTag("Player");
		currentAgent.SetDestination(pointsArray[currentPoint].position);
		speed = currentAgent.speed;
		InvokeRepeating("changePoint", 2f, 1f);
	}

	private void changePoint()
	{
		if (currentAgent.remainingDistance < 10f)
		{
			if (currentPoint >= pointsArray.Length - 1)
			{
				currentPoint = 0;
			}
			else
			{
				currentPoint++;
			}
			currentAgent.SetDestination(pointsArray[currentPoint].transform.position);
		}
	}

	private void lookForObstacles()
	{
		if (Physics.Raycast(raycastPoint.transform.position, -1f * raycastPoint.transform.right, out RaycastHit hitInfo, 25f))
		{
			if (hitInfo.collider.gameObject.tag == "Player")
			{
				currentAgent.speed = 0f;
			}
			else
			{
				currentAgent.speed = speed;
			}
		}
		else
		{
			currentAgent.speed = speed;
		}
		UnityEngine.Debug.DrawRay(raycastPoint.transform.position, -1f * raycastPoint.transform.right * 25f);
	}

	private void Update()
	{
	}
}
