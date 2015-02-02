package framework.quadtree
{
	import flash.geom.Rectangle;

	import framework.GameEngine;
	import framework.Debug;

	public class TreeNode
	{
		private var 
			_depth    : int,
			_root     : TreeNode,
			_parent   : TreeNode,
			_rect     : Rectangle,
			_children : Vector.<TreeNode>;

		public function TreeNode(nd_depth:int, nd_rect:Rectangle, nd_root:TreeNode=null, nd_parent:TreeNode=null)
		{
			_rect = nd_rect;
			_depth = nd_depth;
			_root = (nd_root) ? nd_root : this;
			_parent = (nd_parent) ? nd_parent : this;

			GameEngine.inst.qtree.push_node(nd_depth, this);

			if (hasChildren) 
			{
				initChildren();
			}
		}

		private function initChildren():void
		{
			var 
				ch_d    : int = _depth + 1,
				ch_w    : int = _rect.width * 0.5,
				ch_h    : int = rect.height * 0.5,

				rect_nw : Rectangle = new Rectangle(_rect.x, _rect.y, ch_w, ch_h),
				rect_ne : Rectangle = new Rectangle(_rect.x + ch_w, _rect.y, ch_w, ch_h),
				rect_sw : Rectangle = new Rectangle(_rect.x, _rect.y + ch_h, ch_w, ch_h),
				rect_se : Rectangle = new Rectangle(_rect.x + ch_w, _rect.y + ch_h, ch_w, ch_h);

			_children = new Vector.<TreeNode>(4, true);
			_children[0] = new TreeNode(ch_d, rect_nw, _root, this);
			_children[1] = new TreeNode(ch_d, rect_ne, _root, this);
			_children[2] = new TreeNode(ch_d, rect_sw, _root, this);
			_children[3] = new TreeNode(ch_d, rect_se, _root, this);
		}

		public function get depth():int
		{
			return _depth;
		}

		public function get root():TreeNode
		{
			return _root;
		}

		public function get parent():TreeNode
		{
			return _parent;
		}

		public function get rect():Rectangle
		{
			return _rect;
		}

		public function get children():Vector.<TreeNode>
		{
			return _children;
		}

		public function get hasChildren():Boolean
		{
			return _depth < GameEngine.inst.qtree.depth;
		}
	}
}
