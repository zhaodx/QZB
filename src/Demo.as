package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.geom.Rectangle;

	import framework.pool.*;

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

			var pm:PoolManager = new PoolManager();
			pm.init();
			var rect:Rectangle = pm.allocateRectangle();
			
		}
	}
}
