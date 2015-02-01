package framework.quadtree
{
	import flash.geom.Rectangle;

	import framework.Util;
	import framework.Debug;
	import framework.GameEngine;
	import framework.event.EngineEvent;

	public class QuadTree
	{
		private var 
			_depth     : int,
			_root      : TreeNode;

		public function init(q_depth:int=5, q_width:int=4096, q_height:int=4096):void
		{
			_depth = q_depth;
			_root = new TreeNode(0, new Rectangle(0, 0, q_width, q_height));
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
