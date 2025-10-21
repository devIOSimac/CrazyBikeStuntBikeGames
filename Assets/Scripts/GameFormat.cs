////using Area730.CrossPromo;
//using UnityEngine;

//public class GameFormat : MonoBehaviour
//{
//	[Header("Beforing click on play")]
//	[Header("Enter a number for GameFormat")]
//	[Header("1 for ActionGame")]
//	[Header("2 for Simulation")]
//	[Header("3 for Racing")]
//	public int GFNum;

//	[Header("Enter the links from DropBoxs")]
//	public string action;

//	public string simulation;

//	public string racing;

//	//public CrossPromoController acesser;

//	private void Start()
//	{
//		if (GFNum == 1)
//		{
//			acesser.DescriptorUrl = action;
//			return;
//		}
//		if (GFNum == 2)
//		{
//			acesser.DescriptorUrl = simulation;
//			return;
//		}
//		if (GFNum == 3)
//		{
//			acesser.DescriptorUrl = racing;
//			return;
//		}
//		GFNum = UnityEngine.Random.Range(1, 4);
//		if (GFNum == 1)
//		{
//			acesser.DescriptorUrl = action;
//		}
//		else if (GFNum == 2)
//		{
//			acesser.DescriptorUrl = simulation;
//		}
//		else if (GFNum == 3)
//		{
//			acesser.DescriptorUrl = racing;
//		}
//		acesser.enabled = true;
//	}
//}
