package
{
	import com.jonas.net.Multipart;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.ByteArray;
	
	[SWF(width="600", height="400", frameRate="30", backgroundColor="#CCCCCC")]
	public class MultipartTest extends Sprite
	{
		[Embed(source="icon480.png")]
		public var c:Class;
		public var b:Bitmap;
		public var t:TextField;
		
		public function MultipartTest()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var s:Sprite = new Sprite();
			s.addEventListener(MouseEvent.CLICK, onClick);
			s.buttonMode = true;
			s.y = 20;
			addChild(s);
			
			b = new c() as Bitmap; 
			b.scaleX = b.scaleY = 0.5;
			s.addChild(b);
			
			t = new TextField();
			t.width = 400;
			t.multiline = t.wordWrap = true;
			t.autoSize = TextFieldAutoSize.LEFT;
			t.x = s.width+20;
			t.y = s.y;
			addChild(t);
			t.text = "Click to upload";
		}
		
		protected function onClick(event:Event):void
		{ 
			t.text = "loading...";
			
			var jpg:JPEGEncoder = new JPEGEncoder(80);
			
			var test:ByteArray = new ByteArray();
			test.writeMultiByte("Hello", "ascii");
			
			var form:Multipart = new Multipart("http://labs.positronic.fr/flash/multipart/upload.php");
			
			// add fields
			form.addField("field1", "hello");
			form.addField("field2", "world");
			
			// add files
			form.addFile("file1", test, "text/plain", "test.txt", true);
			form.addFile("file2", jpg.encode(b.bitmapData), "application/octet-stream", "test.jpg", true);
		
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onComplete);
			try {
				loader.load(form.request);
			} catch (error: Error) {
				t.text = "Unable to load requested document";
			}
		}
		
		protected function onComplete (e: Event):void {
			t.text = e.target["data"];
		}
	}
}