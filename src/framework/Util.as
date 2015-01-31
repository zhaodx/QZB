package framework
{
	import flash.text.TextField;

	public class Util
	{
		static public function formate(str:String, ...args):String
		{
			for (var index:int = 0; index < args.length; ++index)
			{
				str = str.replace(new RegExp('\\{' + index + '\\}', 'gm'), args[index]);
			}

			return str;
		}
	}
}
