package framework
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	import framework.event.EngineEvent;
	import framework.pool.PoolManager;
	import framework.quadtree.QuadTree;

	public class GameEngine extends EventDispatcher
	{
		private var 
			_pm        : PoolManager,
			_stg       : Stage,
			_qtree     : QuadTree,
			_second    : int,
			_ui_camera : Camera,
			_wd_camera : Camera,
			_bg_camera : Camera;

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

			_stg.addEventListener(Event.ENTER_FRAME, onUpdate, false, 0, true);

			_pm = new PoolManager();
			_qtree = new QuadTree();

			init_camera();
		}

		private function init_camera():void
		{
			_bg_camera = new Camera(1);
			stage.addChild(_bg_camera);

			_wd_camera = new Camera(1, 600, 400, true);
			stage.addChild(_wd_camera);

			_ui_camera = new Camera(1);
			stage.addChild(_ui_camera);
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

				dispatchEvent(new EngineEvent(EngineEvent.SECOND_EVENT, Util.secondstamp));
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

		public function get qtree():QuadTree
		{
			return _qtree;
		}
	}
}
