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
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.ByteArray;
	
	[SWF(width="600", height="400", frameRate="30", backgroundColor="#CCCCCC")]
	public class Demo extends Sprite
	{
		[Embed(source="../assets/icon480.png")]
		public var iconClass:Class;
		public var iconBitmap:Bitmap;
		
		public var textField:TextField;
		
		private var url:String = "http://labs.positronic.fr/flash/multipart/upload.php";
		
		public function Demo()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var container:Sprite = new Sprite();
			container.addEventListener(MouseEvent.CLICK, onClick);
			container.buttonMode = true;
			container.y = 20;
			addChild(container);
			
			iconBitmap = new iconClass() as Bitmap; 
			iconBitmap.scaleX = iconBitmap.scaleY = 0.5;
			container.addChild(iconBitmap);
			
			textField = new TextField();
			textField.width = 400;
			textField.multiline = textField.wordWrap = true;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.x = container.width+20;
			textField.y = container.y;
			addChild(textField);
			textField.text = "Click to upload";
			
			if(loaderInfo.parameters["url"] != null){
				url = loaderInfo.parameters["url"];
			}
		}

		
		protected function onClick(event:Event):void
		{ 
			textField.text = "loading...";
			
			// Create an image ByteArray with Thibault Imbert's JPEGEncoder
			// http://www.bytearray.org/wp-content/projects/fastjpeg/JPEGEncoder.as
			var jpg:JPEGEncoder = new JPEGEncoder(80);
			var image:ByteArray = jpg.encode(iconBitmap.bitmapData);
			
			// Create an ascii text ByteArray
			var text:ByteArray = new ByteArray();
			text.writeMultiByte("Hello", "ascii");
			
			// Instanciate Multipart with url
			var form:Multipart = new Multipart(url);
			
			// Add fields
			form.addField("field1", "hello");
			form.addField("field2", "world");
			
			// Add files
			form.addFile("file1", text, "text/plain", "test.txt");
			form.addFile("file2", image, "image/jpeg", "test.jpg");
		
			// Load request
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onComplete);
			try {
				loader.load(form.request);
			} catch (error: Error) {
				textField.text = "Unable to load request : "+error.message;
			}
		}
		
		protected function onComplete(event:Event):void 
		{
			textField.text = event.target["data"];
		}
	}
}