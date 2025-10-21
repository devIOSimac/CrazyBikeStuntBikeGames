using CnControls;
using UnityEngine;
using UnityEngine.Serialization;

namespace EVP
{
	public class VehicleCameraController : MonoBehaviour
	{
		public enum Mode
		{
			AttachTo,
			SmoothFollow,
			MouseOrbit,
			LookAt
		}

		public Mode mode = Mode.SmoothFollow;

		public Transform target;

		public bool followCenterOfMass = true;

		public KeyCode changeCameraKey = KeyCode.C;

		public CameraAttachTo attachTo = new CameraAttachTo();

		[FormerlySerializedAs("smoothFollowSettings")]
		public CameraSmoothFollow smoothFollow = new CameraSmoothFollow();

		[FormerlySerializedAs("orbitSettings")]
		public CameraMouseOrbit mouseOrbit = new CameraMouseOrbit();

		public CameraLookAt lookAt = new CameraLookAt();

		private Transform m_transform;

		private Mode m_prevMode;

		private CameraMode[] m_cameraModes = new CameraMode[0];

		private Transform m_prevTarget;

		private Rigidbody m_targetRigidbody;

		private Vector3 m_localTargetOffset;

		private Vector3 m_targetOffset;

		private void OnEnable()
		{
			m_transform = GetComponent<Transform>();
			m_cameraModes = new CameraMode[4]
			{
				attachTo,
				smoothFollow,
				mouseOrbit,
				lookAt
			};
			CameraMode[] cameraModes = m_cameraModes;
			foreach (CameraMode cameraMode in cameraModes)
			{
				cameraMode.Initialize(m_transform);
			}
			AdquireTarget();
			ComputeTargetOffset();
			m_prevTarget = target;
			m_cameraModes[(int)mode].OnEnable(m_transform, target, m_targetOffset);
			m_cameraModes[(int)mode].Reset(m_transform, target, m_targetOffset);
			m_prevMode = mode;
		}

		private void OnDisable()
		{
			m_cameraModes[(int)mode].OnDisable(m_transform, target, m_targetOffset);
		}

		private void LateUpdate()
		{
			if (target != m_prevTarget)
			{
				AdquireTarget();
				m_prevTarget = target;
			}
			ComputeTargetOffset();
			if (CnInputManager.GetButtonDown("changeCameraKey"))
			{
				NextCameraMode();
			}
			if (mode != m_prevMode)
			{
				m_cameraModes[(int)m_prevMode].OnDisable(m_transform, target, m_targetOffset);
				m_cameraModes[(int)mode].OnEnable(m_transform, target, m_targetOffset);
				m_cameraModes[(int)mode].Reset(m_transform, target, m_targetOffset);
				m_prevMode = mode;
			}
			m_cameraModes[(int)mode].Update(m_transform, target, m_targetOffset);
		}

		public void NextCameraMode()
		{
			if (base.enabled)
			{
				mode++;
				if ((int)mode >= m_cameraModes.Length)
				{
					mode = Mode.AttachTo;
				}
			}
		}

		public void ResetCamera()
		{
			if (base.enabled)
			{
				m_cameraModes[(int)mode].Reset(m_transform, target, m_targetOffset);
			}
		}

		public void SetViewConfig(VehicleViewConfig viewConfig)
		{
			CameraMode[] cameraModes = m_cameraModes;
			foreach (CameraMode cameraMode in cameraModes)
			{
				cameraMode.SetViewConfig(viewConfig);
			}
		}

		private void AdquireTarget()
		{
			if (target != null)
			{
				VehicleViewConfig component = target.GetComponent<VehicleViewConfig>();
				if (component != null)
				{
					if (component.lookAtPoint != null)
					{
						target = component.lookAtPoint;
					}
					SetViewConfig(component);
				}
			}
			if (followCenterOfMass && target != null)
			{
				m_targetRigidbody = target.GetComponent<Rigidbody>();
				m_localTargetOffset = m_targetRigidbody.centerOfMass;
			}
			else
			{
				m_targetRigidbody = null;
			}
			ResetCamera();
		}

		private void ComputeTargetOffset()
		{
			if (followCenterOfMass && m_targetRigidbody != null)
			{
				m_targetOffset = target.TransformDirection(m_localTargetOffset);
			}
			else
			{
				m_targetOffset = Vector3.zero;
			}
		}
	}
}
