package framework.quadtree
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	import flash.geom.Rectangle;

	import framework.Util;
	import framework.Debug;

	public class QuadTree
	{
		private var 
			_depth     : int,
			_root      : TreeNode,
			_width     : int,
			_height    : int,
			_node_arr  : Array,
			_node_bmp  : Bitmap;

		public function init(q_depth:int=7, q_width:int=4096, q_height:int=4096):void
		{
			_depth = q_depth;
			_width = q_width;
			_height = q_height;
			_node_arr = new Array(q_depth);

			for (var index:int = 0; index <= q_depth; ++index)
			{
				_node_arr[index] = new Vector.<TreeNode>();
			}

			_root = new TreeNode(0, new Rectangle(0, 0, q_width, q_height));
		}

		public function add_object():void
		{
			
		}

		public function push_node(q_depth:int, node:TreeNode):void
		{
			(_node_arr[q_depth] as Vector.<TreeNode>).push(node);
		}

		public function get_nodes(q_depth:int):Vector.<TreeNode>
		{
			return _node_arr[q_depth];
		}

		public function get depth():int
		{
			return _depth;
		}

		public function get root():TreeNode
		{
			return _root;
		}

		public function get width():int
		{
			return _width;
		}

		public function get height():int
		{
			return _height;
		}
		
		public function get node_bmp():Bitmap
		{
			if (!_node_bmp)
			{
				var 
					sp     : Sprite = new Sprite(),
					s_w    : int = _width >> _depth,
					s_h    : int = _height >> _depth,
					bmd    : BitmapData = new BitmapData(s_w, s_h, false, 0xffffff);

				sp.graphics.lineStyle(1, 0x0000ff);
				sp.graphics.beginFill(0x0000ff, .2);
				sp.graphics.drawRect(0, 0, s_w, s_h);
				sp.graphics.endFill();

				bmd.draw(sp);
				_node_bmp = new Bitmap(bmd);
			}

			return _node_bmp;
		}
	}
}
