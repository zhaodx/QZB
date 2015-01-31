package framework
{
	public class Debug
	{
		static public function log(str:String):void
		{
			trace(Util.formate('[ QZB_LOG ] {0}.', str));
		}

		static public function logError(str:String):void
		{
			trace(Util.formate('[ QZB_ERROR ] {0}.', str));
		}
	}
}
