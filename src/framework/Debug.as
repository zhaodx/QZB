package framework
{
	public class Debug
	{
		public static function log(...args):void
		{
			var str:String = '[ QZB_LOG ] ';

			trace(str.concat(args));
		}

		public static function logError(...args):void
		{
			var str:String = '[ QZB_ERROR ] ';

			trace(str.concat(args));
		}
	}
}
