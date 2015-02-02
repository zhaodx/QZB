package framework
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	public class Camera extends Sprite
	{
		private var 
			_depth   : int,
			_buffer  : Bitmap,
			_use_bmp : Boolean;

		public function Camera(cdepth:int, usebmp:Boolean=false)
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;

			_depth = cdepth;
			_use_bmp = usebmp;

			if (_use_bmp)
			{
				_buffer = new Bitmap(new BitmapData(
						GameEngine.inst.world_width, 
						GameEngine.inst.world_height, 
						false, 
						0xffffff), 'auto', true);

				addChild(_buffer);

				draw_qtree();
			}
		}

		private function draw_qtree():void
		{
			foreach(var node:TreeNode in _qtree.get_nodes(_qtree.depth))
			{
				_buffer.bitmapData.copyPixels(_qtree.node_bmp.bitmapData, 
					new Rectangle(0, 0, node.rect.width, node.rect.height), 
					new Point(node.rect.x, node.rect.y));		
			}
		}

		public function resize(swidth:int, sheight:int):void
		{
			//addChild(GameEngine.inst.qtree.node_bmp);
		}

		public function move(offset_x:int, offset_y:int):void
		{
			this.x += offset_x;	
			this.y += offset_y;	
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
			if (_use_bmp)
			{
				return _buffer.bitmapData.rect;
			}

			return new Rectangle(this.x, this.y, this.width, this.height);
		}
	}
}
