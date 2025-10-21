using UnityEngine.UI;
using UnityEngine;
using System.Collections.Generic;

namespace UnityEngine.UI.Extensions
{
	public class UIMesh : MaskableGraphic
	{
		[SerializeField]
		private Mesh m_mesh;
		[SerializeField]
		private List<Material> m_materials;
	}
}
