package framework
{
	import flash.geom.Rectangle;
	import flash.display.BitmapData;

	import framework.event.EngineEvent;

	public class RenderObject
	{
		private var 
			_tick        : uint,
			_atlas       : BitmapData,
			_world_rect  : Rectangle,
			_atlas_rect  : Rectangle,
			_frames_rect : Vector.<Rectangle>;

		public function RenderObject(r_atlas:BitmapData, fs_rect:Vector.<Rectangle>, w_rect:Rectangle)
		{
			_atlas = r_atlas;
			_world_rect = w_rect;
			_frames_rect = fs_rect;
			_atlas_rect = _frames_rect[0];
		}

		public function play():void
		{
			if (_frames_rect.length > 1)
			{
				GameEngine.inst.addEventListener(EngineEvent.UPDATE_EVENT, update);	
			}
		}

		public function stop():void
		{
			GameEngine.inst.removeEventListener(EngineEvent.UPDATE_EVENT, update);	
		}

		private function update(event:EngineEvent):void
		{
			_atlas_rect = _frames_rect[_tick++ % _frames_rect.length];

			GameEngine.inst.qtree.update_object(this);
		}

		public function get atlas():BitmapData
		{
			return _atlas;
		}

		public function get atlas_rect():Rectangle
		{
			return _atlas_rect;
		}

		public function get world_rect():Rectangle
		{
			return _world_rect;
		}
	}
}
