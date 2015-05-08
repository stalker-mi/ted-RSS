package
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author Vovik
	 */
	public class Preloader extends MovieClip 
	{
		private var textF:TextField = new TextField();
		private var progressBar:Sprite;
		public function Preloader() 
		{
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			var myFormat:TextFormat = new TextFormat();
			myFormat.font="Neuropol";
			myFormat.color = 0x000000;
			myFormat.size = 48;
			//textF.setTextFormat(myFormat);
			textF.defaultTextFormat = myFormat;
			textF.autoSize = TextFieldAutoSize.CENTER;
			textF.text = "Загрузка 100%";

			progressBar = new Sprite();
			progressBar.graphics.beginFill(0xCCFF00);
			progressBar.graphics.drawRect(0, 70, 400, 10);
			progressBar.graphics.endFill();
			progressBar.scaleX = 0;
			trace(textF.width);
			progressBar.x = stage.stageWidth / 2-200;
			progressBar.y = stage.stageHeight / 2;
			textF.x = stage.stageWidth / 2-textF.width/2;
			textF.y = stage.stageHeight / 2;
			
			// TODO show loader
			addChild(textF);
			addChild(progressBar);
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			// TODO update loader
			var loaded:uint = e.bytesLoaded;
			var total:uint = e.bytesTotal;
			var percentLoaded:Number = Math.round((loaded/total) * 100);
			textF.text = "Загрузка " + percentLoaded + "%";
		    progressBar.scaleX = loaded/total;
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void 
		{
			removeChild(textF);
			removeChild(progressBar);
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO hide loader
			
			startup();
		}
		
		private function startup():void 
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
	}
	
}