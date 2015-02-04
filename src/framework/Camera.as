package framework
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	import framework.quadtree.TreeNode;
	import framework.quadtree.QuadTree;

	public class Camera extends Bitmap 
	{
		private var 
			_depth       : int,
			_qtree       : QuadTree,
			_camera_rect : Rectangle;

		public function Camera(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=true)
		{
			_camera_rect = new Rectangle(100, 50, 1024, 512);

			this.x = _camera_rect.x;
			this.y = _camera_rect.y;

			this.bitmapData = new BitmapData(_camera_rect.width, _camera_rect.height, true, 0);

			_qtree = new QuadTree(6, _camera_rect);
		}

		public function render():void
		{
			_qtree.render(this);
		}

		public function resize(swidth:int, sheight:int):void
		{
			//_camera_rect.width = swidth;
			//_camera_rect.height = sheight;
		}

		public function move(offset_x:int, offset_y:int):void
		{
			//this.x += offset_x;	
			//this.y += offset_y;	

			//_camera_rect.x -= offset_x;
			//_camera_rect.y -= offset_y;
		}

		public function zoom_in():void
		{
			//if (_depth < 100)	
			//{
			//	_depth += 2;
			//}else
			//{
			//	_depth = 100;
			//}

			//this.scaleX = _depth / 100;
			//this.scaleY = _depth / 100;
		}

		public function zoom_out():void
		{
			//if (_depth > 50)	
			//{
			//	_depth -= 2;
			//}else
			//{
			//	_depth = 50;
			//}

			//this.scaleX = _depth / 100;
			//this.scaleY = _depth / 100;
		}

		public function get depth():int
		{
			return _depth;
		}

		public function set depth(value:int):void
		{
			_depth = value;
		}

		public function get rect():Rectangle
		{
			return _camera_rect;
		}

		public function get qtree():QuadTree
		{
			return _qtree;
		}
	}
}
