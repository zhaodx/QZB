package framework
{
	import flash.utils.getTimer;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;

	public class Util
	{
		static private var 
			_baseTime   : int,
			_updateTime : Number;

		static public function get millstamp():Number
		{
			return _baseTime + (getTimer() - _updateTime);
		}

		static public function get secondstamp():int
		{
			return _baseTime + (int)(getTimer() - _updateTime);
		}

		static public function set localtime(t:int):void
		{
			_updateTime = getTimer();

			if (t < _baseTime)
			{
				_updateTime -= (_baseTime - t);
			}

			_baseTime = t;
		}
		
		static public function formate(str:String, ...args):String
		{
			for (var index:int = 0; index < args.length; ++index)
			{
				str = str.replace(new RegExp('\\{' + index + '\\}', 'gm'), args[index]);
			}

			return str;
		}

		static public function getClassName(classOrInst:*):String
		{
			var 
				description : String = getQualifiedClassName(classOrInst),
				index       : int = description.lastIndexOf(":");

			if (index > -1)
			{
				return description.slice(index + 1);
			}

			return description;
		}

		static public function deepCopy(obj:Object):Object
		{
			var bytes : ByteArray = new ByteArray();

			bytes.writeObject(obj);
			bytes.position = 0;

			return bytes.readObject();
		}

		static public function objectLength(obj:Object):int
		{
			var 
				len	: int,
				key	: String;

			for (key in obj)
			{
				len++;
			}

			return len;
		}
	}
}
