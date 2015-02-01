package framework
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	import framework.event.EngineEvent;
	import framework.pool.PoolManager;
	import framework.quadtree.QuadTree;

	public class GameEngine extends EventDispatcher
	{
		private var 
			_pm         : PoolManager,
			_stg        : Stage,
			_qtree      : QuadTree,
			_second     : int,
			_camera     : Camera,
			_mouse_pos  : Point;

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
			_qtree = new QuadTree();

			add_event();
			add_camera();
		}

		private function add_camera():void
		{
			_camera = new Camera(100, 800, 600, true);
			_stg.addChild(_camera);
		}

		private function add_event():void
		{
			_stg.addEventListener(Event.RESIZE, onResize, false, 0, true);
			_stg.addEventListener(Event.ENTER_FRAME, onUpdate, false, 0, true);
			_stg.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
			_stg.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
			_stg.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true);
			_stg.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel, false, 0, true);
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

		private function onResize(event:Event):void
		{
			Debug.log('onResize: ' + stage_width + ',  ' + stage_height);
		}
		
		private function onMouseDown(event:MouseEvent):void
		{
			_mouse_pos = new Point(event.stageX, event.stageY);

			//Debug.log('onMouseDown: ' + event.stageX + ',  ' + event.stageY);
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			_mouse_pos = null;

			//Debug.log('onMouseUp: ' + event.stageX + ',  ' + event.stageY);
		}

		private function onMouseMove(event:MouseEvent):void
		{
			if (_mouse_pos)
			{
				_camera.move(event.stageX - _mouse_pos.x, event.stageY - _mouse_pos.y);

				_mouse_pos.x = event.stageX;
				_mouse_pos.y = event.stageY;

				//Debug.log('onMouseMove: ' + event.stageX + ',  ' + event.stageY);
			}
		}

		private function onMouseWheel(event:MouseEvent):void
		{
			(event.delta < 0) ? _camera.zoom_in() : _camera.zoom_out();
		}

		public function get stage():Stage
		{
			return _stg;
		}

		public function get stage_width():int
		{
			return _stg.stageWidth;
		}

		public function get stage_height():int
		{
			return _stg.stageHeight;
		}

		public function get pool():PoolManager
		{
			return _pm;
		}

		public function get qtree():QuadTree
		{
			return _qtree;
		}

		public function get camera():Camera
		{
			return _camera;
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
	}
}
