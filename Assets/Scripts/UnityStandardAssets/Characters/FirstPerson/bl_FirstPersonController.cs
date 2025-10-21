using UnityEngine;
using UnityStandardAssets.Utility;

namespace UnityStandardAssets.Characters.FirstPerson
{
	public class bl_FirstPersonController : MonoBehaviour
	{
		[SerializeField]
		private bool m_IsWalking;
		[SerializeField]
		private float m_WalkSpeed;
		[SerializeField]
		private float m_RunSpeed;
		[SerializeField]
		private float m_RunstepLenghten;
		[SerializeField]
		private float m_JumpSpeed;
		[SerializeField]
		private float m_StickToGroundForce;
		[SerializeField]
		private float m_GravityMultiplier;
		[SerializeField]
		private bl_MouseLook m_MouseLook;
		[SerializeField]
		private bool m_UseFovKick;
		[SerializeField]
		private bl_FOVKick m_FovKick;
		[SerializeField]
		private bool m_UseHeadBob;
		[SerializeField]
		private bl_CurveControlledBob m_HeadBob;
		[SerializeField]
		private bl_LerpControlledBob m_JumpBob;
		[SerializeField]
		private float m_StepInterval;
		[SerializeField]
		private AudioClip[] m_FootstepSounds;
		[SerializeField]
		private AudioClip m_JumpSound;
		[SerializeField]
		private AudioClip m_LandSound;
	}
}
