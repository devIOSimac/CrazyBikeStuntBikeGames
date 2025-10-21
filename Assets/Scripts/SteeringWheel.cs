using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class SteeringWheel : MonoBehaviour
{
	public Graphic UI_Element;

	private RectTransform rectT;

	private Vector2 centerPoint;

	public static float maximumSteeringAngle = 200f;

	public static float wheelReleasedSpeed = 200f;

	public static float wheelAngle;

	public static float wheelPrevAngle;

	private bool wheelBeingHeld;

	public static float GetClampedValue()
	{
		return wheelAngle / maximumSteeringAngle;
	}

	public float GetAngle()
	{
		return wheelAngle;
	}

	private void Start()
	{
		rectT = UI_Element.rectTransform;
		InitEventsSystem();
		UpdateRect();
	}

	private void Update()
	{
		if (!wheelBeingHeld && !Mathf.Approximately(0f, wheelAngle))
		{
			float num = wheelReleasedSpeed * Time.deltaTime;
			if (Mathf.Abs(num) > Mathf.Abs(wheelAngle))
			{
				wheelAngle = 0f;
			}
			else if (wheelAngle > 0f)
			{
				wheelAngle -= num;
			}
			else
			{
				wheelAngle += num;
			}
		}
		rectT.localEulerAngles = Vector3.back * wheelAngle;
	}

	private void InitEventsSystem()
	{
		EventTrigger eventTrigger = UI_Element.gameObject.GetComponent<EventTrigger>();
		if (eventTrigger == null)
		{
			eventTrigger = UI_Element.gameObject.AddComponent<EventTrigger>();
		}
		if (eventTrigger.triggers == null)
		{
			eventTrigger.triggers = new List<EventTrigger.Entry>();
		}
		EventTrigger.Entry entry = new EventTrigger.Entry();
		EventTrigger.TriggerEvent triggerEvent = new EventTrigger.TriggerEvent();
		UnityAction<BaseEventData> call = PressEvent;
		triggerEvent.AddListener(call);
		entry.eventID = EventTriggerType.PointerDown;
		entry.callback = triggerEvent;
		eventTrigger.triggers.Add(entry);
		entry = new EventTrigger.Entry();
		triggerEvent = new EventTrigger.TriggerEvent();
		call = DragEvent;
		triggerEvent.AddListener(call);
		entry.eventID = EventTriggerType.Drag;
		entry.callback = triggerEvent;
		eventTrigger.triggers.Add(entry);
		entry = new EventTrigger.Entry();
		triggerEvent = new EventTrigger.TriggerEvent();
		call = ReleaseEvent;
		triggerEvent.AddListener(call);
		entry.eventID = EventTriggerType.PointerUp;
		entry.callback = triggerEvent;
		eventTrigger.triggers.Add(entry);
	}

	private void UpdateRect()
	{
		Vector3[] array = new Vector3[4];
		rectT.GetWorldCorners(array);
		for (int i = 0; i < 4; i++)
		{
			array[i] = RectTransformUtility.WorldToScreenPoint(null, array[i]);
		}
		Vector3 vector = array[0];
		Vector3 vector2 = array[2];
		float width = vector2.x - vector.x;
		float height = vector2.y - vector.y;
		Rect rect = new Rect(vector.x, vector2.y, width, height);
		centerPoint = new Vector2(rect.x + rect.width * 0.5f, rect.y - rect.height * 0.5f);
	}

	public void PressEvent(BaseEventData eventData)
	{
		Vector2 position = ((PointerEventData)eventData).position;
		wheelBeingHeld = true;
		wheelPrevAngle = Vector2.Angle(Vector2.up, position - centerPoint);
	}

	public void DragEvent(BaseEventData eventData)
	{
		Vector2 position = ((PointerEventData)eventData).position;
		float num = Vector2.Angle(Vector2.up, position - centerPoint);
		if (Vector2.Distance(position, centerPoint) > 20f)
		{
			if (position.x > centerPoint.x)
			{
				wheelAngle += num - wheelPrevAngle;
			}
			else
			{
				wheelAngle -= num - wheelPrevAngle;
			}
		}
		wheelAngle = Mathf.Clamp(wheelAngle, 0f - maximumSteeringAngle, maximumSteeringAngle);
		wheelPrevAngle = num;
	}

	public void ReleaseEvent(BaseEventData eventData)
	{
		DragEvent(eventData);
		wheelBeingHeld = false;
	}
}
