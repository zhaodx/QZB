package framework.quadtree
{
	import flash.geom.Point;
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
			_pixels   : Vector.<Point>,
			_children : Vector.<TreeNode>;

		public function TreeNode(nd_depth:int, nd_rect:Rectangle, nd_root:TreeNode=null, nd_parent:TreeNode=null)
		{
			_rect = nd_rect;
			_depth = nd_depth;
			_root = (nd_root) ? nd_root : this;
			_parent = (nd_parent) ? nd_parent : this;
			
			//Debug.log("TreeNode: " + _depth + "    " + _rect);

			(isPixNode) ? GameEngine.inst.qtree.addPixNode(this) : initChildren();
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

		public function initPixels():void
		{
			var 
				index  : int,
				p_w    : int = _root.rect.width >> GameEngine.inst.qtree.depth,
				p_h    : int = _root.rect.height >> GameEngine.inst.qtree.depth;

			_pixels = new Vector.<Point>(p_w * p_h, true);

			for (var w:int = 0; w < p_w; ++w)
			{
				for (var h:int = 0; h < p_h; ++h)
				{
					_pixels[index] = new Point(_rect.x + w, _rect.y + h);
				}
			}

			//Debug.log("_pixels: " + _pixels.length);
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

		public function get pixels():Vector.<Point>
		{
			return _pixels;
		}

		public function get isPixNode():Boolean
		{
			return _depth == GameEngine.inst.qtree.depth;
		}
	}
}
