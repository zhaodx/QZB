package framework.event
{
	import flash.events.Event;

	public class EngineEvent extends Event
	{
		static public const 
			SECOND_EVENT : String = "second_event",
			UPDATE_EVENT : String = "update_event";

		protected var 
			_data : Object;

		public function EngineEvent(type:String, data:Object, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			super(type, bubbles, cancelable);
			_data = data;
		}

		public function get eventData():Object
		{
			return _data;
		}

		public function set eventData(data:Object):void
		{
			_data = data;
		}
	}
}
