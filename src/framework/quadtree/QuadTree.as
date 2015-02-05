package framework.quadtree
{
	import flash.display.Bitmap;

	import flash.geom.Rectangle;

	import framework.Camera;
	import framework.RenderObject;

	import framework.Debug;

	public class QuadTree
	{
		private var 
			_depth     : int,
			_root      : TreeNode,
			_node_bmp  : Bitmap;

		public function QuadTree(q_depth:int, q_rect:Rectangle):void
		{
			_depth = q_depth;
			_root = new TreeNode(0, _depth, q_rect);
		}

		public function add_object(robj:RenderObject):void
		{
			_root.add_object(robj);
		}

		public function remove_object(robj:RenderObject):void
		{
			_root.remove_object(robj);
		}

		public function update_object(robj:RenderObject):void
		{
			_root.update_object(robj);
		}

		public function render(camera:Camera):void
		{
			_root.render(camera);
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
