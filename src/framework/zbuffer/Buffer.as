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
			_rect        : Rectangle,
			_objects     : Vector.<RenderObject>,
			_render_pos  : Point,
			_render_obj  : RenderObject,
			_render_bmd  : BitmapData,
			_default_bmd : BitmapData,
			_render_rect : Rectangle,
			_render_list : Vector.<uint>;

		public function Buffer(b_rect:Rectangle)
		{
			_rect = b_rect;
			_render_pos = new Point(0, 0);
			_objects = new Vector.<RenderObject>();
			_default_bmd = new BitmapData(_rect.width, _rect.height, true, 0);
			_render_bmd = new BitmapData(_rect.width, _rect.height, true, 0);
		}

		public function add_object(robj:RenderObject):void
		{
			_objects.push(robj);	
		}

		public function remove_object(robj:RenderObject):void
		{
			var index : int = _objects.indexOf(robj);

			if (index != -1)
			{
				_objects.splice(index, 1);
			}
		}

		private function get render_list():Vector.<uint>
		{
			var 
				tmp_rect     : Rectangle,
				rect_area    : int,
				inster_area  : int,
				render_area  : int,
				render_rect  : Rectangle,
				inster_rect  : Rectangle,
				render_index : Vector.<uint>;

			render_index = new Vector.<uint>();

			for (var index:int = _objects.length; index > 0 ; --index)
			{
				_render_obj = _objects[index - 1];
				inster_rect = _rect.intersection(_render_obj.rect);
				inster_area = inster_rect.width * inster_rect.height;

				if (!render_rect)
				{
					render_rect = inster_rect;
					render_area = inster_area;
					render_index.push(index - 1);

					continue;
				}

				rect_area = render_rect.width * render_rect.height;

				if (render_rect.containsRect(inster_rect) 
						&& render_area == rect_area)
				{
					continue;
				}

				if (render_rect.equals(inster_rect) 
						&& render_area == rect_area)
				{
					continue;
				}

				render_rect = render_rect.union(inster_rect);
				render_area += inster_area;
				render_index.push(index - 1);				

				if (render_rect.intersects(inster_rect))
				{
					tmp_rect = render_rect.intersection(inster_rect);
					render_area -= tmp_rect.width * tmp_rect.height;
				}

				if (render_rect.equals(_rect) 
						&& render_area == _rect.width * _rect.height)
				{
					return render_index.reverse();
				}
			}

			return render_index.reverse();
		}

		public function render(camera:Camera):void
		{
			_render_list = render_list;

			_render_bmd.lock();
			_render_bmd.setVector(_render_bmd.rect, _default_bmd.getVector(_default_bmd.rect));
			for each(var index:uint in _render_list)
			{
				_render_obj = _objects[index];
				_render_rect = _rect.intersection(_render_obj.rect);
				_render_pos.x = _render_rect.x - _rect.x;
				_render_pos.y = _render_rect.y - _rect.y;

				_render_rect.x = _render_rect.x - _render_obj.rect.x;
				_render_rect.y = _render_rect.y - _render_obj.rect.y;

				_render_bmd.copyPixels(
						_render_obj.bitmapData, 
						_render_rect,
						_render_pos, 
						null, null, true);
			}

			_render_bmd.unlock();

			camera.bitmapData.setVector(
					_rect,
					_render_bmd.getVector(new Rectangle(0, 0, _rect.width, _rect.height)));
		}
	}
}
