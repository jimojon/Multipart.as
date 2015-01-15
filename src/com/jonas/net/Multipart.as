package com.jonas.net 
{
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLRequestHeader;
	import flash.utils.ByteArray;

	/**
	 *
	 * Based on RFC 1867 + real case observation
	 *
	 * RFC 1867
	 * https://tools.ietf.org/html/rfc1867
	 *
	 */
	public class Multipart
	{
		private var _url:String;
		private var _fields:Array = [];
		private var _files:Array = [];
		private var _data:ByteArray = new ByteArray();

		public function Multipart(url:String = null)
		{
			_url = url;
		}
		
		public function addFields(fields:Object):void
		{
			for (var s:String in fields) {
				addField(s, fields[s]);
			}
		}

		public function addField(name:String, value:String):void
		{
			_fields.push({name:name, value:value});
		}

		public function addFile(name:String, byteArray:ByteArray, mimeType:String, fileName:String):void {
			_files.push({name:name, byteArray:byteArray, mimeType:mimeType, fileName:fileName});
		}

		public function clear():void
		{
			_data = new ByteArray();
			_fields = [];
			_files = [];
		}

		public function get request():URLRequest
		{
			var boundary: String = (Math.round(Math.random()*100000000)).toString();

			var n:uint;
			var i:uint;

			// Add fields
			n = _fields.length;
			for(i=0; i<n; i++){
				_writeString('--' + boundary + '\r\n'
					+'Content-Disposition: form-data; name="'+_fields[i].name+'"\r\n\r\n'
					+_fields[i].value+'\r\n');
			}

			// Add files
			n = _files.length;
			for(i=0; i<n; i++){
				_writeString('--'+boundary + '\r\n'
					+'Content-Disposition: form-data; name="'+_files[i].name+'"; filename="'+_files[i].fileName+'"\r\n'
					+'Content-Type: '+_files[i].mimeType+'\r\n\r\n');

				_writeBytes(_files[i].byteArray);
				_writeString('\r\n');
			}

			// Close
			_writeString('--' + boundary + '--\r\n');

			var r: URLRequest = new URLRequest(_url);
			r.data = _data;
			r.method = URLRequestMethod.POST;
			r.requestHeaders.push( new URLRequestHeader('Content-type', 'multipart/form-data; boundary=' + boundary) );

			return r;

		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function set url(value:String):void
		{
			_url = value;
		}

		private function _writeString(value:String):void
		{
			var b:ByteArray = new ByteArray();
			b.writeMultiByte(value, "ascii");
			_data.writeBytes(b, 0, b.length);
		}

		private function _writeBytes(value:ByteArray):void
		{
			value.position = 0;
			_data.writeBytes(value, 0, value.length);
		}
	}
}
