package framework
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	import framework.quadtree.TreeNode;
	import framework.quadtree.QuadTree;

	public class Camera extends Sprite
	{
		private var 
			_depth       : int,
			_buffer      : Bitmap,
			_use_bmp     : Boolean,
			_qtree       : QuadTree,
			_render_pos  : Point,
			_render_rect : Rectangle,
			_camera_rect : Rectangle;

		public function Camera(cdepth:int, usebmp:Boolean=false)
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;

			_depth = cdepth;
			_use_bmp = usebmp;
			_qtree = GameEngine.inst.qtree;
			_camera_rect = new Rectangle(100, 50, 1200, 700);
			_render_pos = new Point(0, 0);
			_render_rect = new Rectangle(0, 0, 0, 0);

			if (_use_bmp)
			{
				_buffer = new Bitmap(new BitmapData(
						GameEngine.inst.world_width, 
						GameEngine.inst.world_height, 
						false, 
						0xffffff), 'auto', true);

				addChild(_buffer);
			}
		}

		public function render():void
		{
			for each(var node:TreeNode in _qtree.get_nodes(_qtree.depth))
			{
				if (_camera_rect.containsRect(node.rect))
				{
					_render_pos.x = node.rect.x;
					_render_pos.y = node.rect.y;

					_render_rect.width = node.rect.width;
					_render_rect.height = node.rect.height;

					_buffer.bitmapData.copyPixels(
							_qtree.node_bmp.bitmapData, 
							_render_rect,
							_render_pos);
				}
			}
		}

		public function resize(swidth:int, sheight:int):void
		{
			//_camera_rect.width = swidth;
			//_camera_rect.height = sheight;
		}

		public function move(offset_x:int, offset_y:int):void
		{
			this.x += offset_x;	
			this.y += offset_y;	

			_camera_rect.x -= offset_x;
			_camera_rect.y -= offset_y;
		}

		public function zoom_in():void
		{
			if (_depth < 100)	
			{
				_depth += 2;
			}else
			{
				_depth = 100;
			}

			this.scaleX = _depth / 100;
			this.scaleY = _depth / 100;
		}

		public function zoom_out():void
		{
			if (_depth > 50)	
			{
				_depth -= 2;
			}else
			{
				_depth = 50;
			}

			this.scaleX = _depth / 100;
			this.scaleY = _depth / 100;
		}

		public function get depth():int
		{
			return _depth;
		}

		public function get use_bmp():Boolean
		{
			return _use_bmp;
		}

		public function get rect():Rectangle
		{
			return _camera_rect;
		}
	}
}
