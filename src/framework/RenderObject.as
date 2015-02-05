package framework
{
	import flash.geom.Rectangle;
	import flash.display.BitmapData;

	import framework.event.EngineEvent;

	public class RenderObject
	{
		private var 
			_fps       : int,
			_w_x       : int,
			_w_y       : int,
			_bmd       : BitmapData,
			_tick      : int,
			_bmds      : Vector.<BitmapData>,
			_rect      : Rectangle;

		public function RenderObject(bmd:BitmapData, r_fps:int=20)
		{
			_fps = r_fps;
			_bmd = bmd;
			_rect = new Rectangle(_w_x, _w_y, _bmd.width, _bmd.height);
		}

		public function play():void
		{
			GameEngine.inst.addEventListener(EngineEvent.UPDATE_EVENT, update);	
		}

		public function stop():void
		{
			GameEngine.inst.removeEventListener(EngineEvent.UPDATE_EVENT, update);	
		}

		private function update(event:EngineEvent):void
		{
			if (++_tick % 2 == 0)
			{
				GameEngine.inst.qtree.remove_object(this);
				_bmd = _bmds[_tick % 8];
				GameEngine.inst.qtree.add_object(this);
			}
		}

		public function get bitmapData():BitmapData
		{
			return _bmd;
		}

		public function get rect():Rectangle
		{
			return _rect;
		}

		public function get fps():int
		{
			return _fps;
		}

		public function set world_x(value:int):void
		{
			_w_x = value;
			_rect.x = value;
		}

		public function set world_y(value:int):void
		{
			_w_y = value;
			_rect.y = value;
		}

		public function set bmds(value:Vector.<BitmapData>):void
		{
			_bmds = value;
		}
	}
}
