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
			_objects     : Vector.<RenderObject>,
			_default     : Vector.<uint>,
			_world_rect  : Rectangle,
			_render_pos  : Point,
			_render_obj  : RenderObject,
			_render_rect : Rectangle,
			_render_list : Vector.<uint>;

		public function Buffer(w_rect:Rectangle)
		{
			_world_rect = w_rect;
			_render_pos = new Point(0, 0);
			_objects = new Vector.<RenderObject>();

			var bmd:BitmapData = new BitmapData(_world_rect.width, _world_rect.height, true, 0);
			_default = bmd.getVector(bmd.rect);
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
				inster_rect = _world_rect.intersection(_render_obj.world_rect);
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

				if (render_rect.equals(_world_rect) 
						&& render_area == _world_rect.width * _world_rect.height)
				{
					return render_index.reverse();
				}
			}

			return render_index.reverse();
		}

		public function render(camera:Camera):void
		{
			_render_list = render_list;

			camera.bitmapData.setVector(_world_rect, _default);

			for each(var index:uint in _render_list)
			{
				_render_obj = _objects[index];
				_render_rect = _world_rect.intersection(_render_obj.world_rect);
				_render_pos.x = _render_rect.x - _world_rect.x;
				_render_pos.y = _render_rect.y - _world_rect.y;

				_render_rect.x = _render_rect.x - _render_obj.world_rect.x;
				_render_rect.y = _render_rect.y - _render_obj.world_rect.y;

				_render_rect.x = _render_rect.x - _render_obj.atlas_rect.x;
				_render_rect.y = _render_rect.y - _render_obj.atlas_rect.y;

				camera.bitmapData.copyPixels(
						_render_obj.atlas, 
						_render_rect,
						_render_pos, 
						null, null, true);

			}
		}
	}
}
