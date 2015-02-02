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
	import framework.pool.PoolManager;

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

			stage.frameRate = 30;
			stage.stageFocusRect = false;
			stage.showDefaultContextMenu = false;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.LOW;

			GameEngine.inst.init(stage, 4096, 4096);

			var st:Number = Util.millstamp;
			test();
			Debug.log("test time: " + (Util.millstamp - st));
		}

		private function test():void
		{
			draw_camera();
		}

		private function draw_camera():void
		{
			var sp : Sprite = new Sprite();

			sp.graphics.lineStyle(4, 0xff0000);
			sp.graphics.drawRect(
				0, 
				0, 
				GameEngine.inst.camera.rect.width - 8, 
				GameEngine.inst.camera.rect.height - 8);

			stage.addChild(sp);

			sp.x = 100;
			sp.y = 50;
		}
	}
}
