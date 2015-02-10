package framework.zbuffer
{
	import flash.display.*;
	import flash.geom.*;
	import framework.*;

	public class Buffer
	{
		public var 
			node         : TreeNode,
			info_list    : Vector.<RenderInfo>,
			world_rect   : Rectangle;

		private var 
			_info_size    : uint,
			_pre_render   : Boolean,
			_render_size  : uint,
			_render_list  : Vector.<RenderInfo>;
			
		public function Buffer(rect:Rectangle, node:TreeNode)
		{
			world_rect = rect;
			info_list = new Vector.<RenderInfo>(20, true);
			_render_list = new Vector.<RenderInfo>(20, true);
		}

		public function add_info(info:RenderInfo):void
		{
			if (!_pre_render) _pre_render = true;

			if (_info_size == info_list.length)
			{
				Debug.logError('add_info: out of size!');

				for (var i:uint=0; i<_info_size; ++i) info_list[i] = info_list[i+1];
				info_list[_info_size - 1] = info;

				return;
			}

			info_list[_info_size++] = info;
		}

		public function remove_info(info:RenderInfo):void
		{
			if (!_pre_render) _pre_render = true;

			var i:int = info_list.indexOf(info);

			if (i != -1)
			{
				--_info_size;
				info_list[i] = null;
				for (var b:uint=i; b<_info_size; ++b) info_list[b] = info_list[b+1];
				info_list[_info_size] = null;
			}
		}

		public function reset():void
		{
			_info_size = 0;	

			if (!_pre_render) _pre_render = true;
		}

		public function render(target:BitmapData, source:BitmapData):void
		{
			if (_pre_render)
			{
				_render_size = 0;
				//TODO new list

				_pre_render = false;
			}
		
			//TODO render
		}
	}
}
