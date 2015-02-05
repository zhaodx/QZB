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
		private var 
			_test_bmds : Vector.<BitmapData>;

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
			//draw_object();
			_test_bmds = new Vector.<BitmapData>();
			
			var loader:Loader = new Loader();
			var loaderContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			loader.load(new URLRequest('aida.png'), loaderContext);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (event:Event):void
			{
				var loadInfo:LoaderInfo = event.currentTarget as LoaderInfo;
				var resBmd:BitmapData = (loadInfo.content as Bitmap).bitmapData;
				var bound:Rectangle = new Rectangle(0, 0, resBmd.width >> 2, resBmd.height >> 2);
				var tmpWidth:Number = bound.width;
				var tmpHeight:Number = bound.height;

				for (var i:int = 0; i < 8; i = i + 1)
				{
					if (i < 4)
					{
						bound.x = tmpWidth * i;
						bound.y = 0;
					}else
					{
						bound.x = tmpWidth * (i - 4);
						bound.y = tmpHeight;
					}

					var bmd:BitmapData = new BitmapData(bound.width, bound.height, true, 0); 
					bmd.copyPixels(resBmd, bound, new Point(), null, null, false);
					_test_bmds.push(bmd);
				}

				loader.unload();
				loader = null;

				draw_object()
			});
		}

		private function draw_object():void
		{
			for (var i:int=0; i<200; ++i)
			{
			  	var robj : RenderObject = new RenderObject(_test_bmds[0]);	

			  	robj.bmds = _test_bmds;
			  	robj.rect.x = (int)(Math.random() * 1200);
			  	robj.rect.y = (int)(Math.random() * 800);

				//GameEngine.inst.qtree.add_object(robj);
			  	robj.play();
			}

			//var robj : RenderObject = new RenderObject(tesdbmd(64, 64, 0x0000ff));	
			//
			//robj.rect.x = (int)(Math.random() * 1400);
			//robj.rect.y = (int)(Math.random() * 900);

			//GameEngine.inst.qtree.add_object(robj);	

			//var robj1 : RenderObject = new RenderObject(tesdbmd(128, 128, 0xff0000));	
			//
			//robj1.rect.x = 0;
			//robj1.rect.y = 0;

			//GameEngine.inst.qtree.add_object(robj1);	
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
