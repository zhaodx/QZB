package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.geom.Rectangle;

	import framework.Util;
	import framework.Debug;
	import framework.Camera;
	import framework.GameEngine;
	import framework.RenderObject;

	[SWF(width='1440', height='900')]

	public class Demo extends Sprite
	{
		public function Demo()
		{
			if (stage)
			{
				init();
			}else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}

		private function init():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			stage.frameRate = 60;
			stage.stageFocusRect = false;
			stage.showDefaultContextMenu = false;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.LOW;

			var st:Number = Util.millstamp;
			GameEngine.inst.init(stage, 4096, 4096);
			Debug.log("Engine init time: " + (Util.millstamp - st));

			test();
		}

		private function test():void
		{
			draw_camera();

			draw_object();
		}

		private function draw_object():void
		{
			for (var i:int=0; i<2; ++i)
			{
				var robj : RenderObject = new RenderObject(GameEngine.inst.qtree.node_bmp.bitmapData);	
				
				robj.rect.x = 100 + Math.random() * 1024;
				robj.rect.y = 50 + Math.random() * 512;

				robj.rect.x = 102;
				robj.rect.y = 53;

				GameEngine.inst.camera.add_object(robj);
			}
		}

		private function draw_camera():void
		{
			var sp : Sprite = new Sprite();
			sp.graphics.lineStyle(1, 0xff0000);
			sp.graphics.drawRect(
				GameEngine.inst.camera.rect.x,
				GameEngine.inst.camera.rect.y,
				GameEngine.inst.camera.rect.width, 
				GameEngine.inst.camera.rect.height);
			stage.addChild(sp);
		}
	}
}
