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
			_node_list : Vector.<TreeNode>;

		public function init(q_depth:int, q_rect:Rectangle):void
		{
			_depth = q_depth;
			_node_list = new Vector.<TreeNode>();
			_root = new TreeNode(0, _depth, q_rect);
		}

		public function add_object(robj:RenderObject):void
		{
			_root.add_object(robj);
		}
		
		public function add_node(node:TreeNode):void
		{
			_node_list.push(node);
		}

		public function render(camera:Camera):void
		{
			camera.bitmapData.lock();

			camera.bitmapData.setVector(camera.rect, camera.defaultVector);

			for each(var node:TreeNode in _node_list)
			{
				node.render(camera);
			}

			camera.bitmapData.unlock();
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
