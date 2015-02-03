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
			_pm           : PoolManager,
			_stg          : Stage,
			_qtree        : QuadTree,
			_second       : int,
			_camera       : Camera,
			_mouse_pos    : Point,
			_world_width  : int,
			_world_height : int;

		private static var _instance : GameEngine;

		public static function get inst():GameEngine
		{
			if (!_instance)
			{
				_instance = new GameEngine();
			}

			return _instance;
		}

		public function init(stg:Stage, width:int, height:int):void
		{
			if (stg)
			{
				_stg = stg;

				Debug.log('OK, FUNPLUS');
			}else
			{
				Debug.logError('stage is null');
				return;
			}

			_world_width = width;
			_world_height = height;

			_pm = new PoolManager();

			add_quadtree();
			add_camera();
			add_event();
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

		private function add_quadtree():void
		{
			_qtree = new QuadTree();
		}

		private function add_camera():void
		{
			_camera = new Camera(100, true);
			_stg.addChild(_camera);
		}

		private function onUpdate(event:Event):void
		{
			dispatchEvent(new EngineEvent(EngineEvent.UPDATE_EVENT, Util.millstamp));

			if (Util.secondstamp > _second)
			{
				_second = Util.secondstamp;	

				dispatchEvent(new EngineEvent(EngineEvent.SECOND_EVENT, Util.secondstamp));
			}

			_camera.render();
		}

		private function onResize(event:Event):void
		{
			//Debug.log('onResize: ' + stage_width + ',  ' + stage_height);
			//_camera.resize(stage_width, stage_height);
		}
		
		private function onMouseDown(event:MouseEvent):void
		{
			//Debug.log('onMouseDown: ' + event.stageX + ',  ' + event.stageY);
			_mouse_pos = new Point(event.stageX, event.stageY);
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			//Debug.log('onMouseUp: ' + event.stageX + ',  ' + event.stageY);
			_mouse_pos = null;
		}

		private function onMouseMove(event:MouseEvent):void
		{
			//Debug.log('onMouseMove: ' + event.stageX + ',  ' + event.stageY);
			if (_mouse_pos)
			{
				//_camera.move(event.stageX - _mouse_pos.x, event.stageY - _mouse_pos.y);

				_mouse_pos.x = event.stageX;
				_mouse_pos.y = event.stageY;
			}
		}

		private function onMouseWheel(event:MouseEvent):void
		{
			//Debug.log('onMouseWheel: ' + event.delta);
			//(event.delta < 0) ? _camera.zoom_in() : _camera.zoom_out();
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

		public function get world_width():int
		{
			return _world_width;
		}

		public function get world_height():int
		{
			return _world_height;
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
