package
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.Loader;
	import flash.display.LoaderInfo;

	import flash.net.URLRequest;

	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;

	import flash.events.Event;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import framework.Util;
	import framework.Camera;
	import framework.GameEngine;
	import framework.RenderObject;
	import framework.event.EngineEvent;

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

			stage.frameRate = 30;
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
			//draw_camera();
			
			var loader:Loader = new Loader();
			var loaderContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			loader.load(new URLRequest('aida.png'), loaderContext);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (event:Event):void
			{
				var loadInfo:LoaderInfo = event.currentTarget as LoaderInfo;
				var resBmd:BitmapData = (loadInfo.content as Bitmap).bitmapData;
				var rects:Vector.<Rectangle> = new Vector.<Rectangle>();

				for (var i:int = 0; i < 8; i = i + 1)
				{
					var bound:Rectangle = new Rectangle(0, 0, resBmd.width >> 2, resBmd.height >> 2);

					if (i < 4)
					{
						bound.x = bound.width * i;
						bound.y = 0;
					}else
					{
						bound.x = bound.width * (i - 4);
						bound.y = bound.height;
					}

					rects.push(bound);
				}

				draw_object(resBmd, rects);
			});
		}

		private function draw_object(atlas:BitmapData, rects:Vector.<Rectangle>):void
		{
			for (var i:int=0; i<1; ++i)
			{
				var x:int = 100;//Math.random() * 1200;
				var y:int = 100;//Math.random() * 800;
				var w_rect : Rectangle = new Rectangle(x, y, rects[0].width, rects[0].height);
			  	var robj : RenderObject = new RenderObject(atlas, rects, w_rect);	

				GameEngine.inst.qtree.add_object(robj);

			  	robj.play();
			}
		}

		private function tesdbmd(w:int, h:int, color:uint):BitmapData
		{
			var 
				sp     : Sprite = new Sprite(),
				bmd    : BitmapData = new BitmapData(w, h, false, 0xffffff);

			sp.graphics.lineStyle(1, color);
			sp.graphics.beginFill(color, .2);
			sp.graphics.drawRect(0, 0, w - 1, h - 1);
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
