using UnityEngine;

public class RCCWheelSkidmarks : MonoBehaviour
{
	public RCCCarControllerV2 vehicle;

	private Rigidbody vehicleRigid;

	private float startSlipValue = 0.25f;

	private RCCSkidmarks skidmarks;

	private int lastSkidmark = -1;

	private WheelCollider wheel_col;

	private float wheelSlipAmountSideways;

	private float wheelSlipAmountForward;

	private void Start()
	{
		wheel_col = GetComponent<WheelCollider>();
		vehicleRigid = vehicle.GetComponent<Rigidbody>();
		if ((bool)UnityEngine.Object.FindObjectOfType(typeof(RCCSkidmarks)))
		{
			skidmarks = (UnityEngine.Object.FindObjectOfType(typeof(RCCSkidmarks)) as RCCSkidmarks);
		}
		else
		{
			UnityEngine.Debug.Log("No skidmarks object found. Skidmarks will not be drawn. Drag ''SkidmarksManager'' from Prefabs folder, and drop on to your existing scene...");
		}
	}

	private void FixedUpdate()
	{
		if (!skidmarks)
		{
			return;
		}
		wheel_col.GetGroundHit(out WheelHit hit);
		wheelSlipAmountSideways = Mathf.Abs(hit.sidewaysSlip);
		wheelSlipAmountForward = Mathf.Abs(hit.forwardSlip);
		if (wheelSlipAmountSideways > startSlipValue || wheelSlipAmountForward > 0.5f)
		{
			Vector3 pos = hit.point + 2f * vehicleRigid.velocity * Time.deltaTime;
			if (vehicleRigid.velocity.magnitude > 1f)
			{
				lastSkidmark = skidmarks.AddSkidMark(pos, hit.normal, wheelSlipAmountSideways / 2f + wheelSlipAmountForward / 2.5f, lastSkidmark);
			}
			else
			{
				lastSkidmark = -1;
			}
		}
		else
		{
			lastSkidmark = -1;
		}
	}
}
