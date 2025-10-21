using System;
using UnityEngine;

namespace Pegasus
{
	public class PegasusAnimator : MonoBehaviour
	{
		[Header("Character And Animator")]
		[Tooltip("Drop your character here. By default it will select the character this script is attached to.")]
		public Transform m_character;

		[Tooltip("Drop your animator here. By default it will select the animator on the character this script is attached to.")]
		public Animator m_animator;

		[Tooltip("Select your initial animation state. This will be played immediately on start at runtime.")]
		public PegasusConstants.PegasusAnimationState m_animationState;

		private PegasusConstants.PegasusAnimationState m_lastAnimationState;

		[Header("Optional Animation Overrides")]
		[Tooltip("Add your idle animation override here. This is optional, and the default animation will be used instead if not supplied.")]
		public AnimationClip m_idleAnimation;

		[Tooltip("Add your walk animation override here. This is optional, and the default animation will be used instead if not supplied.")]
		public AnimationClip m_walkAnimation;

		[Tooltip("Add your run animation override here. This is optional, and the default animation will be used instead if not supplied.")]
		public AnimationClip m_runAnimation;

		[Header("Walk & Run Speeds (m/sec)")]
		[Tooltip("Walk animations will play when the character movement is greater than the idle speed and less than this speed.")]
		public float m_walkSpeed = 2f;

		[Tooltip("Walk animations will play when the character movement is greater than the idle speed and less than this speed.")]
		public float m_maxWalkSpeed = 3.5f;

		[Tooltip("Run animations will play when the character movement is greater than the walk speed.")]
		public float m_runSpeed = 7f;

		private float m_speedDamping = 0.7f;

		private float m_speed;

		private float m_lastSpeed = float.MinValue;

		private Vector3 m_lastPosition = Vector3.zero;

		private float m_animationMultiplier = 1f;

		private int m_animationStateHash = Animator.StringToHash("AnimationState");

		private int m_animationMultiplierHash = Animator.StringToHash("AnimationMultiplier");

		private void Start()
		{
			if (m_character == null)
			{
				m_character = base.gameObject.transform;
			}
			if (m_animator == null)
			{
				m_animator = GetComponent<Animator>();
			}
			if (m_animator != null)
			{
				m_lastPosition = base.transform.position;
				if (m_idleAnimation != null)
				{
					ReplaceClip(m_animator, "HumanoidIdle", m_idleAnimation);
				}
				if (m_walkAnimation != null)
				{
					ReplaceClip(m_animator, "HumanoidWalk", m_walkAnimation);
				}
				if (m_runAnimation != null)
				{
					ReplaceClip(m_animator, "HumanoidRun", m_runAnimation);
				}
				PlayState(m_animationState, forceStateNow: true);
			}
		}

		private void Update()
		{
			if (m_animator == null)
			{
				return;
			}
			float num = Vector3.Distance(base.transform.position, m_lastPosition);
			m_lastPosition = base.transform.position;
			if (Time.deltaTime > 0f)
			{
				m_speed = Mathf.Lerp(m_speed, num / Time.deltaTime, Time.deltaTime * (1f / m_speedDamping));
				if (m_speed > m_maxWalkSpeed)
				{
					m_animationState = PegasusConstants.PegasusAnimationState.Running;
					m_animationMultiplier = m_speed / m_runSpeed;
				}
				else if (m_speed > 0f)
				{
					m_animationState = PegasusConstants.PegasusAnimationState.Walking;
					m_animationMultiplier = m_speed / m_walkSpeed;
				}
				else
				{
					m_animationState = PegasusConstants.PegasusAnimationState.Idle;
					m_animationMultiplier = 1f;
				}
			}
			else
			{
				m_speed = 0f;
				m_animationState = PegasusConstants.PegasusAnimationState.Idle;
				m_animationMultiplier = 1f;
			}
			if (m_animator != null && m_speed != m_lastSpeed)
			{
				m_lastSpeed = m_speed;
				m_animator.SetInteger(m_animationStateHash, (int)m_animationState);
				m_animator.SetFloat(m_animationMultiplierHash, m_animationMultiplier);
			}
		}

		private void PlayState(PegasusConstants.PegasusAnimationState newState, bool forceStateNow)
		{
			if (forceStateNow)
			{
				m_animationState = newState;
				m_animator.SetInteger(m_animationStateHash, (int)m_animationState);
				switch (m_animationState)
				{
				case PegasusConstants.PegasusAnimationState.Idle:
					m_animator.Play("Base Layer.Idle");
					break;
				case PegasusConstants.PegasusAnimationState.Walking:
					m_animator.Play("Base Layer.Walk");
					break;
				case PegasusConstants.PegasusAnimationState.Running:
					m_animator.Play("Base Layer.Run");
					break;
				default:
					throw new ArgumentOutOfRangeException();
				}
			}
			else if (m_animationState != newState)
			{
				m_animationState = newState;
				m_animator.SetInteger(m_animationStateHash, (int)m_animationState);
			}
			m_animator.SetFloat(m_animationMultiplierHash, m_animationMultiplier);
		}

		private void ReplaceClip(Animator animator, string clipName, AnimationClip overrideClip)
		{
			AnimatorOverrideController animatorOverrideController = animator.runtimeAnimatorController as AnimatorOverrideController;
			if (animatorOverrideController == null)
			{
				animatorOverrideController = new AnimatorOverrideController();
				animatorOverrideController.name = "PegasusRuntimeController";
				animatorOverrideController.runtimeAnimatorController = animator.runtimeAnimatorController;
			}
			animatorOverrideController[clipName] = overrideClip;
			if (!object.ReferenceEquals(animator.runtimeAnimatorController, animatorOverrideController))
			{
				animator.runtimeAnimatorController = animatorOverrideController;
			}
		}
	}
}
