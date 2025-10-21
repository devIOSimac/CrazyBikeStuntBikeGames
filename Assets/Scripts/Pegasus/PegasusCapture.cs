using UnityEngine;
using UnityEngine.UI;

namespace Pegasus
{
	public class PegasusCapture : MonoBehaviour
	{
		public KeyCode m_keyCodeCapture = KeyCode.P;

		public Camera m_mainCamera;

		public PegasusPath m_path;

		public bool m_enableOnStart = true;

		public bool m_clearOnStart = true;

		public bool m_showReticule = true;

		public GameObject m_reticuleGO;

		private void Start()
		{
			if (m_mainCamera == null)
			{
				m_mainCamera = Camera.main;
			}
			if (m_path == null)
			{
				m_path = PegasusPath.CreatePegasusPath();
			}
			if (m_reticuleGO == null)
			{
				m_reticuleGO = GameObject.Find("Pegasus Capture Reticule");
			}
			if (m_reticuleGO != null)
			{
				m_reticuleGO.SetActive(m_showReticule && m_enableOnStart);
				UpdateReticuleText();
			}
			if (m_enableOnStart)
			{
				if (m_clearOnStart)
				{
					m_path.ClearPath();
				}
				foreach (PegasusPath.PegasusPoint item in m_path.m_path)
				{
					GameObject gameObject = GameObject.CreatePrimitive(PrimitiveType.Sphere);
					gameObject.transform.position = item.m_location;
					gameObject.transform.localScale = Vector3.one * 0.25f;
				}
			}
		}

		private void Update()
		{
			if (Application.isPlaying && m_enableOnStart && !(m_path == null) && !(m_mainCamera == null) && UnityEngine.Input.GetKeyDown(m_keyCodeCapture))
			{
				UnityEngine.Debug.Log("Pegasus POI Location Captured!");
				ProcessCaptureEvent();
			}
		}

		private void ProcessCaptureEvent()
		{
			m_path.AddPoint(m_mainCamera.gameObject);
			GameObject gameObject = GameObject.CreatePrimitive(PrimitiveType.Sphere);
			gameObject.transform.position = m_mainCamera.gameObject.transform.position;
			gameObject.transform.localScale = Vector3.one;
		}

		public void UpdateReticuleVisibility()
		{
			if (m_reticuleGO == null)
			{
				m_reticuleGO = GameObject.Find("Pegasus Capture Reticule");
			}
			if (m_reticuleGO != null)
			{
				m_reticuleGO.SetActive(m_showReticule && m_enableOnStart);
			}
		}

		public void UpdateReticuleText()
		{
			if (m_reticuleGO == null)
			{
				m_reticuleGO = GameObject.Find("Pegasus Capture Reticule");
			}
			if (m_reticuleGO != null)
			{
				Text[] componentsInChildren = m_reticuleGO.GetComponentsInChildren<Text>();
				Text[] array = componentsInChildren;
				foreach (Text text in array)
				{
					text.text = $"Play your game and then press {m_keyCodeCapture.ToString()} to create a POI at the current location.";
				}
				m_reticuleGO.SetActive(m_showReticule && m_enableOnStart);
			}
		}
	}
}
