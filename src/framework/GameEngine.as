package framework
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	import framework.event.*;

	public class GameEngine extends EventDispatcher
	{
		private var _stg:Stage;
		private var _second:int;

		public function init(stg:Stage):void
		{
			if (stg)
			{
				_stg = stg;

				_stg.addEventListener(Event.ENTER_FRAME, onUpdate, false, 0, true);
			}else
			{
				Debug.logError('stage is null');
			}
		}

		private function onUpdate(event:Event):void
		{
			dispatchEvent(new EngineEvent(EngineEvent.UPDATE_EVENT, Util.millstamp));

			if (Util.secondstamp > _second)
			{
				_second = Util.secondstamp;	

				dispatchEvent(new EngineEvent(EngineEvent.SECOND_EVENT, _second));
			}
		}
		
		public function get stage():Stage
		{
			return _stg;
		}
	}
}
