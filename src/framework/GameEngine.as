package framework
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	import framework.event.EngineEvent;
	import framework.pool.PoolManager;

	public class GameEngine extends EventDispatcher
	{
		private var 
			_pm 	: PoolManager,
			_stg 	: Stage,
			_second : int;

		private static var _instance : GameEngine;

		public static function get inst():GameEngine
		{
			if (!_instance)
			{
				_instance = new GameEngine();
			}

			return _instance;
		}

		public function init(stg:Stage):void
		{
			if (stg)
			{
				_stg = stg;
			}else
			{
				Debug.logError('stage is null');
				return;
			}

			_pm = new PoolManager();
			_stg.addEventListener(Event.ENTER_FRAME, onUpdate, false, 0, true);
		}

		public function dispose():void
		{
			if (_pm)
			{
				_pm.dispose();
				_pm = null;
			}

			_stg = null;
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

		public function get pool():PoolManager
		{
			return _pm;
		}
	}
}
