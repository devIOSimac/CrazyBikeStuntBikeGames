using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TrafficManager : MonoBehaviour
{
	public List<TrafficPaths> _TrafficPaths;

	private void Start()
	{
		foreach (TrafficPaths trafficPath in _TrafficPaths)
		{
			StartCoroutine(GenratePaths(trafficPath));
		}
	}

	private void Update()
	{
	}

	private IEnumerator GenratePaths(TrafficPaths path)
	{
		GameObject[] trafficCars = path.TrafficCars;
		foreach (GameObject car in trafficCars)
		{
			GenerateCars(path, car);
			yield return new WaitForSeconds(path.Delay);
		}
	}

	private void GenerateCars(TrafficPaths path, GameObject car)
	{
		car.GetComponent<AICar_Script>().waypointContainer = path.TrafficPath;
		car = UnityEngine.Object.Instantiate(car, path.PathStartPos.position, path.PathStartPos.rotation);
	}
}
