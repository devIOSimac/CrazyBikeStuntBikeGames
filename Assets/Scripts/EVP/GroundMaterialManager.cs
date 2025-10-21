using UnityEngine;

namespace EVP
{
	public class GroundMaterialManager : MonoBehaviour
	{
		public GroundMaterial[] groundMaterials = new GroundMaterial[0];

		public GroundMaterial GetGroundMaterial(PhysicMaterial physicMaterial)
		{
			int i = 0;
			for (int num = groundMaterials.Length; i < num; i++)
			{
				if (groundMaterials[i].physicMaterial == physicMaterial)
				{
					return groundMaterials[i];
				}
			}
			return null;
		}
	}
}
