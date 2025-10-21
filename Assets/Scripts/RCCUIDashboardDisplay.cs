using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(RCCDashboardInputs))]
public class RCCUIDashboardDisplay : MonoBehaviour
{
	private RCCDashboardInputs inputs;

	public Text RPMLabel;

	public Text KMHLabel;

	public Text GearLabel;

	private void Start()
	{
		inputs = GetComponent<RCCDashboardInputs>();
	}

	private void Update()
	{
	}
}
