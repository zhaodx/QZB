package framework.zbuffer
{
	import flash.geom.Rectangle;
	
	import framework.RenderObject;

	public class Buffer
	{
		_rect       : Rectangle;
		_objects    : Vector.<RenderObject>;
		_obj_size   : int;
		_pix_vector : Vector.<uint>;

		public function Buffer(b_rect:Rectangle)
		{
			_rect = b_rect;
		}

		
	}
}
