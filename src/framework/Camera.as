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
			_qtree       : QuadTree,
			_buffer      : BitmapData,
			_use_bmp     : Boolean,
			_render_pos  : Point,
			_render_rect : Rectangle,
			_camera_rect : Rectangle;

		public function Camera(cdepth:int, usebmp:Boolean=false)
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;

			_depth = cdepth;
			_use_bmp = usebmp;
			_camera_rect = new Rectangle(100, 50, 1024, 512);
			_render_pos = new Point(0, 0);
			_render_rect = new Rectangle(0, 0, 0, 0);

			this.x = _camera_rect.x;
			this.y = _camera_rect.y;

			if (_use_bmp)
			{
				_buffer = new BitmapData(_camera_rect.width, _camera_rect.height, false, 0xffffff);
				addChild(new Bitmap(_buffer, 'auto', true));
			}

			_qtree = GameEngine.inst.qtree;
			_qtree.init(6, _camera_rect.width, _camera_rect.height)
		}

		public function render():void
		{
			_buffer.lock();

			for each(var node:TreeNode in _qtree.get_nodes(_qtree.depth))
			{
				_buffer.setVector(node.rect, node.pix_vector);
			}

			_buffer.unlock();
		}

		public function resize(swidth:int, sheight:int):void
		{
			_camera_rect.width = swidth;
			_camera_rect.height = sheight;
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
