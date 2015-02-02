package framework
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;

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
		}

		public function resize(swidth:int, sheight:int):void
		{
			if (_buffer)
			{
				removeChild(_buffer);

				_buffer.bitmapData.dispose();
				_buffer.bitmapData = null;
				_buffer = null;
			}

			if (_use_bmp)
			{
				_buffer = new Bitmap(
					new BitmapData(swidth, sheight, false, 0x000000), 
					'auto', 
					true);

				addChild(_buffer);
			}
		}

		public function move(offset_x:int, offset_y:int):void
		{
			this.x += offset_x;	
			this.y += offset_y;	
		}

		public function zoom_in():void
		{
			
		}

		public function zoom_out():void
		{
			
		}

		public function get depth():int
		{
			return _depth;
		}

		public function get use_bmp():Boolean
		{
			return _use_bmp;
		}
	}
}
