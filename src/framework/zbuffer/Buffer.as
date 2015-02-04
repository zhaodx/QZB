package framework.zbuffer
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import framework.Camera;
	import framework.RenderObject;

	import framework.Debug;

	public class Buffer
	{
		private var 
			_size         : int,
			_rect         : Rectangle,
			_objects      : Vector.<RenderObject>,
			_render_bmd   : BitmapData,
			_render_pos   : Point,
			_render_robj  : RenderObject,
			_render_rect  : Rectangle;

		public function Buffer(b_rect:Rectangle)
		{
			_rect = b_rect;
			_objects = new Vector.<RenderObject>(10, true);
			_render_bmd = new BitmapData(_rect.width, _rect.height, true, 0);
		}

		public function add_object(robj:RenderObject):void
		{
			if (_size == _objects.length)
			{
				_size = 0;
			}
			
			_objects[_size++] = robj;
		}

		public function remove_object(robj:RenderObject):void
		{
			var index : int = _objects.indexOf(robj);

			if (index != -1 && index < _size)
			{
				--_size;
				_objects[index] = null;

				for (var i:int = index; i < _size; ++i)
				{
					_objects[i] = _objects[i + 1];
				}

				_objects[_size] = null;
			}
		}

		private function depth_sort():void
		{

		}

		private function get z_index():int
		{
			for (var index:int = _size; index > 0 ; --index)
			{
				_render_robj = _objects[index - 1];

				if (_render_rect)
				{
					_render_rect = _render_rect.union(_render_robj.rect);	
				}else
				{
					_render_rect = _render_robj.rect;
				}

				if (_render_rect.containsRect(_rect) || _render_rect.equals(_rect))
				{
					_render_rect = null;
					return index - 1;
				}
			}

			_render_rect = null;
			return _size - 1;
		}

		public function render(camera:Camera):void
		{
			depth_sort();

			_render_bmd.lock();

			for (var index:int = z_index; index < _size ; ++index)
			{
				//trace(index, _size);

				_render_robj = _objects[index];
				_render_rect = _rect.intersection(_render_robj.rect);
				_render_pos = new Point(_render_rect.x - _rect.x, _render_rect.y - _rect.y);

				_render_rect.x = _render_rect.x - _render_robj.rect.x;
				_render_rect.y = _render_rect.y - _render_robj.rect.y;

				//trace(_render_rect, _render_pos);

				_render_bmd.copyPixels(
						_render_robj.bitmapData, 
						_render_rect,
						_render_pos, 
						null, null, true);
			}

			_render_bmd.unlock();

			camera.bitmapData.setVector(
					new Rectangle(_rect.x - camera.rect.x, _rect.y - camera.rect.y, _rect.width, _rect.height), 
					_render_bmd.getVector(new Rectangle(0, 0, _rect.width, _rect.height)));
		}
	}
}
