package  {
	import flash.display.Shape;
	import flash.text.TextField;
    import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.net.URLRequest;
			
	public class Item extends Sprite {
		
		public var video_url:String;
		
		public function Item(xml:XML)  {
			
			var monthLabels:Array = new Array("января",
                  "февраля",
                  "марта",
                  "апреля",
                  "мая",
                  "июня",
                  "июля",
                  "августа",
                  "сентября",
                  "октября",
                  "ноября",
                  "декабря");
				  
			var myDate:Date = new Date(Date.parse(xml.pubDate));
			var txt:TextField=new TextField();
			txt.text=myDate.date+" "+monthLabels[myDate.getMonth()]+" "+myDate.fullYear+"г. "+myDate.hours+":";
			if(myDate.minutes<10) txt.appendText("0"+myDate.minutes.toString()); else txt.appendText(myDate.minutes.toString());
			var format:TextFormat=new TextFormat("Pericles", 10);
			txt.setTextFormat(format);
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.x=191;
			txt.y=0;
			txt.selectable=false;
			addChild(txt);
			
			var sh1:Shape=new Shape();
			sh1.graphics.beginFill(0x99FFCC);
			sh1.graphics.lineStyle(0, 0xCCCCCC);
			sh1.graphics.drawRect(0, 17, 450, 100);		
            sh1.graphics.endFill();
			addChild(sh1);
			
			txt=new TextField();
			txt.text=xml.title;
			txt.setTextFormat(format);
			txt.x=140;
			txt.y=25;
			txt.width=307;
			txt.height=17;
			txt.multiline=true;
			txt.wordWrap=true;
			txt.selectable=false;
			addChild(txt);
			
			txt=new TextField();
			txt.text=xml.description;
			format.size=8;
			format.leading=2;
			txt.setTextFormat(format);
			txt.x=141;
			txt.y=50;
			txt.width=307;
			txt.height=63;
			txt.multiline=true;
			txt.wordWrap=true;
			txt.selectable=false;
			addChild(txt);
			
			sh1=new Shape();
			sh1.graphics.beginFill(0x999999);
			sh1.graphics.drawRect(8, 25, 112, 84);		
            sh1.graphics.endFill();
			addChild(sh1);
			
			var loader:Loader = new Loader();
			loader.mask = sh1;
			loader.x=8;
			loader.y=25;
			loader.scaleX=0.233;
			loader.scaleY=0.233;
			var ns:Namespace = xml.namespace("media");
			loader.load(new URLRequest(xml.ns::thumbnail.@url));
			addChild(loader);
			
			video_url=xml.ns::content.@url;
		}

	}
	
}
