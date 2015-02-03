package framework.quadtree
{
	import flash.geom.Rectangle;

	import framework.GameEngine;
	import framework.Debug;
	import framework.RenderObject;
	import framework.zbuffer.Buffer;

	public class TreeNode
	{
		private var 
			_root       : TreeNode,
			_rect       : Rectangle,
			_depth      : int,
			_parent     : TreeNode,
			_zbuffer    : Buffer,
			_children   : Vector.<TreeNode>;

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
			}else
			{
				_zbuffer = new Buffer(_rect);
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

		public function add_object(robj:RenderObject):void
		{
			if (_rect.intersects(robj.rect))
			{
				if (hasChildren)
				{
					for each(var node:TreeNode in _children)
					{
						node.add_object(robj);
					}
				}else
				{
					_zbuffer.add_object(robj);
				}
			}
		}

		public function render():void
		{
			if (_zbuffer)
			{
				_zbuffer.render();
			}
		}

		public function clear_buffer():void
		{
			if (_zbuffer)
			{
				_zbuffer.clear();
			}
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

		public function get pix_vector():Vector.<uint>
		{
			return _zbuffer.pix_vector;
		}
	}
}
