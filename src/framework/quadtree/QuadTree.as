package framework.quadtree
{
	import flash.geom.Rectangle;

	public class QuadTree
	{
		private var _depth : int,
					_root  : TreeNode;

		public function init(depth:int=4, width:int=1000, height:int=1000):void
		{
			_depth = depth;
			
			_root = new TreeNode(0, new Rectangle(0, 0, width, height));
		}

		public function get depth():int
		{
			return _depth;
		}

		public function get root():TreeNode
		{
			return _root;
		}
	}
}
