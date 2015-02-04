package
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.StageQuality;

	import flash.events.Event;
	
	import flash.geom.Rectangle;

	import framework.Util;
	import framework.Camera;
	import framework.GameEngine;
	import framework.RenderObject;

	import framework.Debug;

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
			//GameEngine.inst.camera.bitmapData.draw(new Bitmap(tesdbmd(16, 8)));

			//for (var i:int=0; i<2; ++i)
			//{
				var robj : RenderObject = new RenderObject(tesdbmd(100, 50, 0x0000ff));	
				
				//robj.rect.x = 100 + (int)(Math.random() * 1000);
				//robj.rect.y = 50 + (int)(Math.random() * 500);
				robj.rect.x = 110;
				robj.rect.y = 60;

				GameEngine.inst.qtree.add_object(robj);	

				var robj1 : RenderObject = new RenderObject(tesdbmd(100, 50, 0xff0000));	
				
				robj1.rect.x = 120;
				robj1.rect.y = 80;

				GameEngine.inst.qtree.add_object(robj1);	
			//}
		}

		private function tesdbmd(w:int, h:int, color:uint):BitmapData
		{
			var 
				sp     : Sprite = new Sprite(),
				bmd    : BitmapData = new BitmapData(w, h, false, 0);

			//sp.graphics.lineStyle(1, 0x0000ff);
			sp.graphics.beginFill(color, 1);
			sp.graphics.drawRect(0, 0, w, h);
			sp.graphics.endFill();

			bmd.draw(sp);
			return bmd;
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
