package framework.pool
{
	public class BetterList
	{
		private var _buffer:Vector.<Object>;
		private var _size:int;
			
		public function Add(object:Object):void
		{
			if (!_buffer || _size == _buffer.length)
			{
				AllocateMore();
			}

			_buffer[_size++] = object;
		}

		public function Insert(index:int, object:Object):void
		{
			if (!_buffer || _size == _buffer.length)
			{
				AllocateMore();
			}

			if (index > -1 && index < _size)
			{
				for(i:int = _size; i > index; --i)
				{
					_buffer[i] = _buffer[i - 1];
				}

				_buffer[index] = object;
				++_size;
			}else
			{
				Add(object);
			}
		}

		public function Clear():void
		{
			_size = 0;
		}

		public function Release():void
		{
			_size = 0;
			_buffer = null;
		}

		public function Contains(object:Object):Boolean
		{
			return IndexOf(object) > -1;
		}

		public function IndexOf(object:Object):int
		{
			if (!_buffer)
			{
				return -1;
			}

			return _buffer.indexOf(object);
		}

		public function Remove(object:Object):Boolean
		{
			if (_buffer)
			{
				var index:int = IndexOf(object);

				if (index > -1)
				{
					--_size;

					for(i:int = index; i < _size; ++i)
					{
						_buffer[i] = _buffer[i + 1];
					}

					_buffer[_size] = new Object();

					return true;
				}

				return false;
			}

			return false;
		}

		public function RemoveAt(index:int):void
		{
			if (_buffer && index > -1 && index < _size)
			{
				--_size;
				_buffer[index] = new Object();
			}
		}

		private function AllocateMore():void
		{
			var buffer:Vector.<Object>;

			buffer = (_buffer) ? new Vector.<Object>(
				Math.max(_buffer.length << 1, 32), true) : new Vector.<Object>(32, true);

			if (_buffer && _size > 0) 
			{
				buffer = buffer .concat(_buffer);
			}

			_buffer = buffer;
		}

		private function Trim():void
		{
			if (_size > 0)
			{
				if (_size > _buffer.length)
				{
					var buffer:Vector.<Object> = new Vector.<Object>(_size);

					for(index:int = 0; index < _size; ++index)
					{
						buffer[index] = _buffer[index];
					}

					_buffer = buffer;
				}
			}else
			{
				_buffer = null;
			}
		}
	}
}
