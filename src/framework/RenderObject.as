package framework
{
	import flash.geom.Rectangle;
	import flash.display.BitmapData;

	import framework.quadtree.TreeNode;

	public class RenderObject
	{
		private var 
			_bmd   : BitmapData,
			_rect  : Rectangle,
			_alpha : Number;
			_nodes : Vector.<TreeNode>;

		public function RenderObject(bmd:BitmapData, alp:Number=1)
		{
			_bmd = bmd;
			_alpha = alp;
			_rect = new Rectangle(0, 0, _bmd.width, _bmd.height);
			_nodes = new Vector.<TreeNode>(100, true);
		}

		public function add_node(node:TreeNode):void
		{
			_nodes.push(node);
		}

		public function clear_node():void
		{
			var index : int = 0;
			for each(var node:TreeNode in _nodes)
			{
				node.remove_object(this);

				_nodes[index] = null;
				index++;
			}
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
