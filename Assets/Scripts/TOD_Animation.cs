using System;
using UnityEngine;

public class TOD_Animation : MonoBehaviour
{
	[Tooltip("How much to move the clouds when the camera moves.")]
	[TOD_Min(0f)]
	public float CameraMovement = 1f;

	[Tooltip("Wind direction in degrees.")]
	[TOD_Range(0f, 360f)]
	public float WindDegrees;

	[Tooltip("Speed of the wind that is acting on the clouds.")]
	[TOD_Min(0f)]
	public float WindSpeed = 1f;

	private TOD_Sky sky;

	public Vector3 CloudUV
	{
		get;
		set;
	}

	public Vector3 OffsetUV
	{
		get
		{
			Vector3 point = base.transform.position * (CameraMovement * 0.0001f);
			Vector3 eulerAngles = base.transform.rotation.eulerAngles;
			Quaternion rotation = Quaternion.Euler(0f, 0f - eulerAngles.y, 0f);
			return rotation * point;
		}
	}

	protected void Start()
	{
		sky = GetComponent<TOD_Sky>();
		CloudUV = new Vector3(UnityEngine.Random.value, UnityEngine.Random.value, UnityEngine.Random.value);
	}

	protected void Update()
	{
		float num = Mathf.Sin((float)Math.PI / 180f * WindDegrees);
		float num2 = Mathf.Cos((float)Math.PI / 180f * WindDegrees);
		float num3 = 0.001f * Time.deltaTime;
		float num4 = WindSpeed * num3;
		Vector3 cloudUV = CloudUV;
		float x = cloudUV.x;
		Vector3 cloudUV2 = CloudUV;
		float y = cloudUV2.y;
		Vector3 cloudUV3 = CloudUV;
		float z = cloudUV3.z;
		y += num3 * 0.1f;
		x -= num4 * num;
		z -= num4 * num2;
		x -= Mathf.Floor(x);
		y -= Mathf.Floor(y);
		z -= Mathf.Floor(z);
		CloudUV = new Vector3(x, y, z);
		sky.Components.BillboardTransform.localRotation = Quaternion.Euler(0f, y * 360f, 0f);
	}
}
