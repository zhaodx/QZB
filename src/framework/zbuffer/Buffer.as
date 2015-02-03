package framework.zbuffer
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import framework.Debug;
	import framework.RenderObject;

	public class Buffer
	{
		private var 
			_size         : int,
			_rect         : Rectangle,
			_objects      : Vector.<RenderObject>,
			_pix_vector   : Vector.<uint>,
			_render_bmd   : BitmapData,
			_render_rect  : Rectangle;

		public function Buffer(b_rect:Rectangle)
		{
			_rect = b_rect;
			_objects = new Vector.<RenderObject>(20, true);
			_render_bmd = new BitmapData(_rect.width, _rect.height, true, 0);
		}

		public function add_object(robj:RenderObject):void
		{
			if (_size > _objects.length)
			{
				Debug.logError('out of size');
				return;
			}
			
			_objects[++_size] = robj;
		}

		public function render():void
		{
			_render_bmd.lock();

			for each(var robj:RenderObject in _objects)
			{
				if (!robj)
				{
					continue;
				}

				_render_bmd.copyPixels(
						robj.bitmapData, 
						_rect.intersection(robj.rect),
						null, null, null, true);

				//if (_render_rect)
				//{
				//	_render_rect = _render_rect.union(robj.rect);	
				//}else
				//{
				//	_render_rect = robj.rect;
				//}

				//if (_render_rect.equals(_rect))
				//{
				//	return;
				//}
			}

			_render_bmd.unlock();
			_pix_vector = _render_bmd.getVector(_rect);
		}

		public function clear():void
		{
			_size = 0;
			_pix_vector = null;
			_render_rect = null;
			_objects = new Vector.<RenderObject>(20, true);
		}

		public function get pix_vector():Vector.<uint>
		{
			return _pix_vector;
		}
	}
}
