package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	
	[Frame(factoryClass="Preloader")]
	public class main extends MovieClip {
			
			private var scene1:Sprite;
			private var scene2:Sprite;
			private var sceneInfo:Sprite;
			private var my_items:Sprite;
			private var my_video:TedVideo;
			private var my_head:Head;
			
		public function main()  {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event = null):void 
		{
			init_scene1();
			addChild(scene1);
			init_items();
			init_scene2();
			init_sceneInfo();
		}
		
		private function init_scene1():void 
		{
			scene1=new Sprite();
			scene1.name="scene1";
			my_head=new Head();
			scene1.addChild(my_head);
			my_head.logo_info.addEventListener(MouseEvent.CLICK, logo_click );
			my_items=new Sprite();
			my_items.x=18;
			my_items.y=147;
			my_items.addChild(my_head.loading_txt);
			scene1.addChild(my_items);
		}
		
		private function init_scene2():void {
			scene2=new Sprite();
			scene2.name="scene2";
			my_head=new Head();
			my_head.logo_back.visible=true;
			scene2.addChild(my_head);
			my_head.logo_info.addEventListener(MouseEvent.CLICK, logo_click );
			my_head.logo_back.addEventListener(MouseEvent.CLICK, logo_click );
			
			my_video=new TedVideo();
			scene2.addChild(my_video);
		}
			
		private function init_sceneInfo():void {
			sceneInfo=new Sprite();
			sceneInfo.name="sceneInfo";
			my_head=new Head();
			my_head.logo_back.visible=true;
			my_head.logo_info.visible=false;
			sceneInfo.addChild(my_head);
			my_head.logo_back.addEventListener(MouseEvent.CLICK, logo_click );
			my_head.loading_txt.x=191;
			my_head.loading_txt.y=147;
			my_head.loading_txt.htmlText="<a href='https://github.com/stalker-mi/'>TedRSS for TEDTalks<br>Autor: stalker-mi</a>";
			sceneInfo.addChild(my_head.loading_txt);
		}
		
		
		private function init_items():void 
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.load(new URLRequest("http://www.ted.com/talks/rss"));
			xmlLoader.addEventListener(Event.COMPLETE, onXmlLoad);
		}
		
		private function onXmlLoad(e:Event):void 
		{
			var xml:XML = new XML(e.target.data);
			my_items.removeChild(my_items.getChildAt(0));
			var max_i:int=4;
			for(var i:int=0;i<max_i;i++){
				var my_item:Item=new Item(xml.channel.item[i]);
				my_item.addEventListener(MouseEvent.CLICK, item_click);
				my_item.y=my_item.height*i+20*i;
				my_items.addChild(my_item);
			}
		}
		
		private function item_click(e:MouseEvent):void {
			removeChild(scene1);
			addChild(scene2);
			my_video.nStream.play(e.currentTarget.video_url);
			my_video.myTimer.start();
			}
			
		private function logo_click(e:MouseEvent):void {
			if(e.currentTarget.name=="logo_back"){
				if(getChildByName("sceneInfo")){
					removeChild(sceneInfo);
					addChild(scene1);
				}
				else {
					my_video.nStream.pause();
					my_video.nStream.seek(0);
					my_video.vid.clear();
					my_video.myTimer.stop();
					removeChild(scene2);
					addChild(scene1);
				}
			}
			if(e.currentTarget.name=="logo_info"){
				if(getChildByName("scene2")){
					my_video.nStream.pause();
					my_video.nStream.seek(0);
					my_video.vid.clear();
					my_video.myTimer.stop();
					removeChild(scene2);
					addChild(sceneInfo);
				}
				else {
					removeChild(scene1);
					addChild(sceneInfo);
				}
			}
			
		}

	}
	
}
