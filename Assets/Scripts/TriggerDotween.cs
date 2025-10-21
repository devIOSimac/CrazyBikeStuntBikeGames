using DG.Tweening;
using UnityEngine;

public class TriggerDotween : MonoBehaviour
{
	public enum TypeOfTween
	{
		DotweenAnim,
		DotweenPath
	}

	public TypeOfTween _thisType;

	public DOTweenAnimation _animation;

	public DOTweenPath _path;

	private void OnTriggerEnter(Collider other)
	{
		if (other.CompareTag("Player"))
		{
			switch (_thisType)
			{
			case TypeOfTween.DotweenAnim:
				_animation.DOPlayForward();
				break;
			case TypeOfTween.DotweenPath:
				_path.DOPlayForward();
				break;
			}
		}
	}
}
