using System;
using UnityEngine;

[RequireComponent(typeof(Animator))]
public class BikeAnimation1 : MonoBehaviour
{
	[Serializable]
	public class IKPointsClass
	{
		public Transform rightHand;

		public Transform leftHand;

		public Transform rightFoot;

		public Transform leftFoot;
	}

	protected Animator animator;

	public bool GameoverAd;

	public bool ikActive;

	public float RestTime = 5f;

	public IKPointsClass IKPoints;

	public Transform myBike;

	public Transform player;

	public Transform eventPoint;

	public static int crashesCount;

	public GameControllerScript gameController;

	public AudioSource crashSound;

	public carReset resetScript;

	private Rigidbody bikeRigidbody;

	private BikeControl BikeScript;

	private Vector3 myPosition;

	private Quaternion myRotation;

	private float timer;

	private float steer;

	private float speed;

	private float groundedTime;

	private bool grounded = true;

	public float CrashSpeed = 50f;

	private void Awake()
	{
		if (resetScript == null)
		{
			resetScript = UnityEngine.Object.FindObjectOfType<carReset>();
		}
		if (gameController == null)
		{
			gameController = UnityEngine.Object.FindObjectOfType<GameControllerScript>();
		}
		crashesCount = 0;
		BikeScript = myBike.GetComponent<BikeControl>();
		animator = player.GetComponent<Animator>();
		myPosition = player.localPosition;
		myRotation = player.localRotation;
		DisableRagdoll(active: true);
		bikeRigidbody = myBike.GetComponent<Rigidbody>();
	}

	private void Update()
	{
		if (timer != 0f)
		{
			timer = Mathf.MoveTowards(timer, 0f, Time.deltaTime);
		}
		Vector3 vector = (!BikeScript.grounded) ? eventPoint.TransformDirection(0f, -0.25f, 1f) : eventPoint.TransformDirection(Vector3.forward);
		UnityEngine.Debug.DrawRay(eventPoint.position, vector, Color.red);
		if (Physics.Raycast(eventPoint.position, vector, out RaycastHit _, 1f) && BikeScript.speed > CrashSpeed)
		{
			if (player.parent != null)
			{
				crashSound.GetComponent<AudioSource>().Play();
				player.parent = null;
			}
			DisableRagdoll(active: true);
			player.GetComponent<Animator>().enabled = false;
			BikeScript.crash = true;
			timer = RestTime;
		}
		if (timer == 0f)
		{
			player.GetComponent<Animator>().enabled = true;
			DisableRagdoll(active: false);
			player.parent = BikeScript.bikeSetting.MainBody.transform;
			player.localPosition = myPosition;
			player.localRotation = myRotation;
			if (BikeScript.crash)
			{
				if (crashesCount >= gameController.crashesThreshold)
				{
					gameController.currentState = GameControllerScript.GameState.isPause;
				}
				else
				{
					MonoBehaviour.print(" ------------------------ Reset ------------------ ");
					resetScript.ResetCar();
					BikeScript.crash = false;
					crashesCount++;
				}
			}
		}
		if (!player.GetComponent<Animator>().enabled)
		{
			return;
		}
		if (BikeScript.speed > 50f && grounded)
		{
			steer = BikeScript.steer;
		}
		else
		{
			steer = Mathf.MoveTowards(steer, 0f, Time.deltaTime * 10f);
		}
		if (BikeScript.grounded)
		{
			grounded = true;
			groundedTime = 2f;
		}
		else
		{
			groundedTime = Mathf.MoveTowards(groundedTime, 0f, Time.deltaTime * 10f);
			if (groundedTime == 0f)
			{
				grounded = false;
			}
		}
		if (BikeScript.currentGear > 0)
		{
			speed = BikeScript.speed;
		}
		else
		{
			speed = 0f - BikeScript.speed;
		}
		animator.SetFloat("speed", speed);
		animator.SetFloat("right", steer);
		animator.SetBool("grounded", grounded);
	}

	private void DisableRagdoll(bool active)
	{
		Component[] componentsInChildren = player.GetComponentsInChildren(typeof(Rigidbody));
		Component[] array = componentsInChildren;
		for (int i = 0; i < array.Length; i++)
		{
			Rigidbody rigidbody = (Rigidbody)array[i];
			rigidbody.isKinematic = !active;
		}
		Component[] componentsInChildren2 = player.GetComponentsInChildren(typeof(Collider));
		Component[] array2 = componentsInChildren2;
		for (int j = 0; j < array2.Length; j++)
		{
			Collider collider = (Collider)array2[j];
			collider.enabled = active;
		}
	}

	private void OnAnimatorIK()
	{
		if (!player.GetComponent<Animator>().enabled || !animator)
		{
			return;
		}
		if (ikActive)
		{
			animator.SetIKPositionWeight(AvatarIKGoal.RightHand, 1f);
			animator.SetIKRotationWeight(AvatarIKGoal.RightHand, 1f);
			animator.SetIKPositionWeight(AvatarIKGoal.LeftHand, 1f);
			animator.SetIKRotationWeight(AvatarIKGoal.LeftHand, 1f);
			animator.SetIKPositionWeight(AvatarIKGoal.RightFoot, 1f);
			animator.SetIKRotationWeight(AvatarIKGoal.RightFoot, 1f);
			animator.SetIKPositionWeight(AvatarIKGoal.LeftFoot, 1f);
			animator.SetIKRotationWeight(AvatarIKGoal.LeftFoot, 1f);
			if (IKPoints.leftHand != null)
			{
				animator.SetIKPosition(AvatarIKGoal.LeftHand, IKPoints.leftHand.position);
				animator.SetIKRotation(AvatarIKGoal.LeftHand, IKPoints.leftHand.rotation);
			}
			if (speed > -1f)
			{
				if (IKPoints.rightHand != null)
				{
					animator.SetIKPosition(AvatarIKGoal.RightHand, IKPoints.rightHand.position);
					animator.SetIKRotation(AvatarIKGoal.RightHand, IKPoints.rightHand.rotation);
				}
				if (IKPoints.rightFoot != null)
				{
					animator.SetIKPosition(AvatarIKGoal.RightFoot, IKPoints.rightFoot.position);
					animator.SetIKRotation(AvatarIKGoal.RightFoot, IKPoints.rightFoot.rotation);
				}
				if (IKPoints.leftFoot != null && BikeScript.speed > 30f)
				{
					animator.SetIKPosition(AvatarIKGoal.LeftFoot, IKPoints.leftFoot.position);
					animator.SetIKRotation(AvatarIKGoal.LeftFoot, IKPoints.leftFoot.rotation);
				}
			}
		}
		else
		{
			animator.SetIKPositionWeight(AvatarIKGoal.RightHand, 0f);
			animator.SetIKRotationWeight(AvatarIKGoal.RightHand, 0f);
		}
	}
}
