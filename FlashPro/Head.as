package  {
	import flash.display.Shape;
	import flash.text.TextField;
    import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	public class Head extends Sprite{

		public var loading_txt:TextField;
		public var logo_info:Sprite;
		public var logo_back:Sprite;

		public function Head()  {
			var sh1:Shape=new Shape();
			sh1.graphics.beginFill(0x66CCFF);
			sh1.graphics.drawRect(0, 0, 480, 100);
            sh1.graphics.endFill();
			addChild(sh1);
			
			var txt:TextField=new TextField();
			txt.text="TED RSS";
			var format:TextFormat=new TextFormat("Pericles", 50);
			txt.setTextFormat(format);
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.x=143;
			txt.y=15;
			txt.selectable=false;
			addChild(txt);
			
			var my_back:Bitmap=new Bitmap(new back());
			logo_back=new Sprite();
			logo_back.addChild(my_back);
			logo_back.x=40;
			logo_back.y=20;
			logo_back.visible=false;
			logo_back.name="logo_back";
			addChild(logo_back);
			
			var my_info:Bitmap=new Bitmap(new info());
			logo_info=new Sprite();
			logo_info.x=400;
			logo_info.y=20;
			logo_info.addChild(my_info);
			logo_info.name="logo_info";
			addChild(logo_info);
			
			txt=new TextField();
			txt.text="TEDTalks";
			format.size=25;
			txt.setTextFormat(format);
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.x=185;
			txt.y=101;
			txt.selectable=false;
			addChild(txt);
			
			txt=new TextField();
			txt.text="Loading...";
			format.size=10;
			txt.setTextFormat(format);
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.x=191;
			txt.selectable=false;
			txt.multiline = true;
			loading_txt=txt;
			
		}
		

	}
	
}
