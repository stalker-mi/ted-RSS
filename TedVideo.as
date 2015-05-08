package  {
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.events.AsyncErrorEvent;
	import flash.media.Video;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import fl.events.SliderEvent;
	import fl.controls.ProgressBar;
	import fl.controls.ProgressBarMode;
	import flash.media.SoundTransform;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.FullScreenEvent; 
    import flash.geom.Rectangle; 
	import flash.display.StageDisplayState; 
	
	public class TedVideo extends Sprite {
		public var nStream:NetStream;
		public var myTimer:Timer;
		public var vid:Video;
		private var positionBar:MyProgress;
		private var positionLabel:TextField;
		private var totalLabel:TextField;
		private var meta:Object;
		
		public function TedVideo() {
			var nc:NetConnection = new NetConnection(); 
			nc.connect(null);
			meta = new Object();
			var customClient:Object = new Object();
			nStream = new NetStream(nc);
			nStream.client = customClient; 
			customClient.onMetaData = metadataHandler;
			nStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler); 
			function asyncErrorHandler(event:AsyncErrorEvent):void 
			{ 
				trace("error");
			}
			
			vid = new Video(); 
			vid.attachNetStream(nStream); 
			vid.x=100;
			vid.y=147;
			addChild(vid);
			
			init_buttons();
		}
		
		private function init_buttons():void{
			var my_pause:Bitmap=new Bitmap(new BPause());
			var my_play:Bitmap=new Bitmap(new BPlay());
			var logo_pause:Sprite=new Sprite();
			logo_pause.x=100;
			logo_pause.y=400;
			logo_pause.addChild(my_pause);
			addChild(logo_pause);
			var flag_play:Boolean=true;
			logo_pause.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{
										nStream.togglePause();
										if(flag_play){
											logo_pause.removeChild(my_pause);
											logo_pause.addChild(my_play);
											flag_play=false;
										}
										else {
											logo_pause.removeChild(my_play);
											logo_pause.addChild(my_pause);
											flag_play=true;
										}
										});
			var volumeSlider:MySlider=new MySlider();
			volumeSlider.value = nStream.soundTransform.volume; 
			volumeSlider.minimum = 0; 
			volumeSlider.maximum = 1; 
			volumeSlider.snapInterval = 0.05; 
			volumeSlider.tickInterval = volumeSlider.snapInterval; 
			volumeSlider.liveDragging = true; 
			volumeSlider.addEventListener(SliderEvent.CHANGE, function(event:SliderEvent):void {
										  var volumeTransform:SoundTransform=new SoundTransform();
										  volumeTransform.volume = event.value; 
										  nStream.soundTransform=volumeTransform; 
										  });
			volumeSlider.x=160;
			volumeSlider.y=425;
			volumeSlider.width=50;
			addChild(volumeSlider);
			
			positionBar=new MyProgress();
			positionBar.mode = ProgressBarMode.MANUAL;
			positionBar.source=nStream;
			positionBar.x=220;
			positionBar.y=415;
			positionBar.width=200;
			positionBar.height=20;
			addChild(positionBar);
			
			positionLabel=new TextField();
			positionLabel.x=220;
			positionLabel.y=430;
			positionLabel.selectable=false;
			addChild(positionLabel);
			
			totalLabel=new TextField();
			totalLabel.x=395;
			totalLabel.y=430;
			positionLabel.selectable=false;
			addChild(totalLabel);
			
			var my_full:Bitmap=new Bitmap(new fullScreen());
			var logo_full:Sprite=new Sprite();
			logo_full.x=150;
			logo_full.y=450;
			logo_full.addChild(my_full);
			addChild(logo_full);
			logo_full.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{
									    var screenRectangle:Rectangle = new Rectangle(vid.x, vid.y, vid.width, vid.height); 
          							    stage.fullScreenSourceRect = screenRectangle; 
            							stage.displayState = StageDisplayState.FULL_SCREEN;  
									   });
			
			myTimer = new Timer(1000);
            myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
			
		}
		
		private function metadataHandler(metadataObj:Object):void 
		{ 
			meta = metadataObj;
			var seconds=int(meta.duration % 60);
			if(seconds<10) seconds="0"+int(meta.duration % 60);
			totalLabel.text = int(meta.duration/ 60) + ":" + seconds; 
		}
		private function timerHandler(event:TimerEvent):void 
		{ 
			positionBar.setProgress(nStream.time, meta.duration);
			var seconds=int(nStream.time % 60);
			if(seconds<10) seconds="0"+int(nStream.time % 60);
       		positionLabel.text = int(nStream.time / 60) + ":" + seconds;
		}

	}
	
}
