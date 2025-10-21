using UnityEngine;

namespace Pegasus
{
	public class PegasusHide : MonoBehaviour
	{
		public bool m_hideAtRuntime = true;

		private void Start()
		{
			if (m_hideAtRuntime)
			{
				Collider[] componentsInChildren = GetComponentsInChildren<Collider>();
				Collider[] array = componentsInChildren;
				foreach (Collider collider in array)
				{
					collider.enabled = false;
				}
				MeshRenderer[] componentsInChildren2 = GetComponentsInChildren<MeshRenderer>();
				MeshRenderer[] array2 = componentsInChildren2;
				foreach (MeshRenderer meshRenderer in array2)
				{
					meshRenderer.enabled = false;
				}
			}
		}
	}
}
