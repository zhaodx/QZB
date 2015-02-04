package framework
{
	import flash.geom.Rectangle;
	import flash.display.BitmapData;

	import framework.quadtree.TreeNode;

	public class RenderObject
	{
		private var 
			_bmd       : BitmapData,
			_rect      : Rectangle,
			_alpha     : Number;

		public function RenderObject(bmd:BitmapData, alp:Number=1)
		{
			_bmd = bmd;
			_alpha = alp;
			_rect = new Rectangle(0, 0, _bmd.width, _bmd.height);
		}

		public function get bitmapData():BitmapData
		{
			return _bmd;
		}

		public function get alpha():Number
		{
			return _alpha;
		}

		public function get rect():Rectangle
		{
			return _rect;
		}
	}
}
