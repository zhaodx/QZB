package framework
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class Camera extends Sprite
	{
		private var 
			_depth  : int,
			_buffer : Bitmap;

		public function Camera(c_d:int, c_w:int=0, c_h:int=0, use_bmp:Boolean=false)
		{
			_depth = c_d;

			if (use_bmp)
			{
				init_buffer(c_w, c_h);
			}
		}

		private function init_buffer(c_w:int, c_h:int):void
		{
			if (!_buffer)
			{
				_buffer = new Bitmap(
					new BitmapData(c_w, c_h, false, 0x000000), 
					'auto', 
					true);

				addChild(_buffer);
			}
		}

		public function get depth():int
		{
			return _depth;
		}
	}
}
