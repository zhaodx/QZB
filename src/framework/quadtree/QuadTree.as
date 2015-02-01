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
			_root      : TreeNode,
			_pix_pess  : int,
			_pix_size  : int, 
			_pix_nodes : Vector.<TreeNode>;

		public function init(q_depth:int=5, q_width:int=4096, q_height:int=4096):void
		{
			_depth = q_depth;

			_pix_nodes = new Vector.<TreeNode>(Math.pow(4, q_depth), true);
			_root = new TreeNode(0, new Rectangle(0, 0, q_width, q_height));

			GameEngine.inst.addEventListener(EngineEvent.UPDATE_EVENT, onUpdate);
		}

		private function onUpdate(event:EngineEvent):void
		{
			if (_pix_pess >= _pix_size)
			{
				GameEngine.inst.removeEventListener(EngineEvent.UPDATE_EVENT, onUpdate);

				return;
			}

			for (var index:int = _pix_pess; index < _pix_pess + 512; ++index)
			{
				_pix_nodes[index].initPixels();
			}

			_pix_pess += 512;
		}

		public function addPixNode(node:TreeNode):void
		{
			if (_pix_size < _pix_nodes.length)
			{
				_pix_nodes[_pix_size++] = node;
			}else
			{
				Debug.logError('_pix_size out of length');
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

		public function get pix_nodes():Vector.<TreeNode>
		{
			return _pix_nodes;
		}
	}
}
