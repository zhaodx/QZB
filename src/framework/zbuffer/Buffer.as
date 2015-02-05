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
			_render_bmd   : BitmapData;

		public function Buffer(b_rect:Rectangle)
		{
			_rect = b_rect;
			_objects = new Vector.<RenderObject>(500, true);
			_render_bmd = new BitmapData(_rect.width, _rect.height, true, 0);
		}

		public function add_object(robj:RenderObject):void
		{
			if (_size == _objects.length)
			{
				Debug.logError('out of buffer');
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

		private function get render_list():Vector.<uint>
		{
			var 
				robj         : RenderObject,
				tmp_rect     : Rectangle,
				old_rect     : Rectangle,
				rect_area    : int,
				inster_area  : int,
				render_area  : int,
				render_rect  : Rectangle,
				inster_rect  : Rectangle,
				render_index : Vector.<uint>;

			rect_area = _rect.width * _rect.height;
			render_index = new Vector.<uint>();

			for (var index:int = _size; index > 0 ; --index)
			{
				robj = _objects[index - 1];
				inster_rect = _rect.intersection(robj.rect);
				inster_area = inster_rect.width * inster_rect.height;

				if (!render_rect)
				{
					render_rect = inster_rect;
					render_area = inster_area;
					render_index.push(index - 1);

					continue;
				}

				//if (render_rect.containsRect(inster_rect) && render_area == render_rect.width * render_rect.height)
				//{
				//	continue;
				//}

				//if (render_rect.equals(inster_rect) && render_area == render_rect.width * render_rect.height)
				//{
				//	continue;
				//}

				//render_rect = render_rect.union(inster_rect);
				//render_area += inster_area;
				render_index.push(index - 1);				

				//if (render_rect.intersects(inster_rect))
				//{
				//	tmp_rect = render_rect.intersection(inster_rect);
				//	render_area -= tmp_rect.width * tmp_rect.height;
				//}

				//render_rect = render_rect.union(inster_rect);
				//render_area += inster_area;
				//render_index.push(index - 1);				

				//if (render_rect.equals(_rect) && render_area == rect_area)
				//{
				//	return render_index.reverse();
				//}
			}

			return render_index.reverse();
		}

		public function render(camera:Camera):void
		{
			var 
				robj         : RenderObject,
				render_pos   : Point,
				render_rect  : Rectangle;

			depth_sort();

			_render_bmd.lock();

			//for each(var index:uint in render_list)
			for (var index:int = 0; index < _size; ++index)
			{
				robj = _objects[index];
				render_rect = _rect.intersection(robj.rect);
				render_pos = new Point(render_rect.x - _rect.x, render_rect.y - _rect.y);

				render_rect.x = render_rect.x - robj.rect.x;
				render_rect.y = render_rect.y - robj.rect.y;

				//trace(render_rect, render_pos);

				_render_bmd.copyPixels(
						robj.bitmapData, 
						render_rect,
						render_pos, 
						null, null, true);
			}

			_render_bmd.unlock();

			camera.bitmapData.setVector(
					new Rectangle(_rect.x - camera.rect.x, _rect.y - camera.rect.y, _rect.width, _rect.height), 
					_render_bmd.getVector(new Rectangle(0, 0, _rect.width, _rect.height)));
		}
	}
}
