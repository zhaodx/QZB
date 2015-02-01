package framework.quadtree
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import framework.GameEngine;
	import framework.Debug;

	public class TreeNode
	{
		private var _depth    : int,
					_root     : TreeNode,
					_parent   : TreeNode,
					_rect     : Rectangle,
					_pixels   : Vector.<Point>,
					_children : Vector.<TreeNode>;

		public function TreeNode(depth:int, rect:Rectangle, root:TreeNode=null, parent:TreeNode=null)
		{
			_depth = depth;
			_rect = rect;
			
			if (!root)
			{
				_root = this;
			}else
			{
				_root = root;
			}

			if (!parent)
			{
				_parent = this;
			}else
			{
				_parent = parent;
			}
			
			if (_depth < GameEngine.inst.qtree.depth)
			{
				initChildren();
			}else
			{
				initPixels();	
			}
		}

		private function initChildren():void
		{
			_children = new Vector.<TreeNode>(4, true);
			
			var rect_nw : Rectangle = GameEngine.inst.pool.pop_rect,
				rect_ne : Rectangle = GameEngine.inst.pool.pop_rect,
				rect_sw : Rectangle = GameEngine.inst.pool.pop_rect,
				rect_se : Rectangle = GameEngine.inst.pool.pop_rect;
			
			rect_nw.x = _rect.x;
			rect_nw.y = _rect.y;
			rect_nw.width = _rect.width * 0.5;
			rect_nw.height = _rect.height * 0.5;
			_children[0] = new TreeNode(_depth + 1, rect_nw, _root, this);

			rect_ne.x = _rect.x + _rect.width * 0.5;
			rect_ne.y = _rect.y;
			rect_ne.width = _rect.width * 0.5;
			rect_ne.height = _rect.height * 0.5;
			_children[1] = new TreeNode(_depth + 1, rect_ne, _root, this);

			rect_sw.x = _rect.x;
			rect_sw.y = _rect.y + _rect.height * 0.5;
			rect_sw.width = _rect.width * 0.5;
			rect_sw.height = _rect.height * 0.5;
			_children[2] = new TreeNode(_depth + 1, rect_sw, _root, this);

			rect_se.x = _rect.x + _rect.width * 0.5;
			rect_se.y = _rect.y + _rect.height * 0.5;
			rect_se.width = _rect.width * 0.5;
			rect_se.height = _rect.height * 0.5;
			_children[3] = new TreeNode(_depth + 1, rect_se, _root, this);

			Debug.log("_children: " + _depth + "    " + rect_se);
		}

		private function initPixels():void
		{
			var index  : int,
				width  : int = _root.rect.width >> GameEngine.inst.qtree.depth,
				height : int = _root.rect.height >> GameEngine.inst.qtree.depth;

			_pixels = new Vector.<Point>(width * height, true);

			for (var w:int = 0; w < width; ++w)
			{
				for (var h:int = 0; h < height; ++h)
				{
					_pixels[index] = new Point(_rect.x + w, _rect.y + h);
				}
			}

			Debug.log("_pixels: " + _pixels.length);
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
	}
}
