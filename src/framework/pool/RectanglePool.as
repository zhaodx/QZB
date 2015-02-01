package framework.pool
{
	import flash.geom.Rectangle;

	public class RectanglePool
	{
		private var 
			_size   : int,
			_buffer : Vector.<Rectangle>;
		
		public function push(rect:Rectangle):void
		{
			if (!_buffer || _size == _buffer.length)
			{
				allocate();
			}

			_buffer[_size++] = rect;
		}

		public function pop():Rectangle
		{
			if (_buffer && _size != 0)
			{
				var rect : Rectangle = _buffer[--_size];
				_buffer[_size] = null;

				return rect;
			}

			return null;
		}

		private function allocate():void
		{
			var tmpbf : Vector.<Rectangle>;
			
			tmpbf = (_buffer) ? 
				new Vector.<Rectangle>(Math.max(_buffer.length << 1, 32), true) : 
				new Vector.<Rectangle>(32, true);

			if (_buffer && _size > 0) 
			{
				tmpbf = tmpbf.concat(_buffer);
			}

			_buffer = tmpbf;
		}

		public function get size():int
		{
			return _size;
		}
	}
}
