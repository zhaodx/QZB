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
			_camera_rect = new Rectangle(0, 0, 0, 0);

			this.bitmapData = new BitmapData(
				GameEngine.inst.world_width, 
				GameEngine.inst.world_height, 
				true, 0);

			_qtree = GameEngine.inst.qtree;
		}

		public function render():void
		{
			bitmapData.lock();
			_qtree.render(this);
			bitmapData.unlock();
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
			_camera_rect.y -= offset_x;
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
	}
}
