Multipart.as
============

A multipart form data request generator

Demo :
http://labs.positronic.fr/flash/multipart/

Use :
var form:Multipart = new Multipart("http://labs.positronic.fr/flash/multipart/upload.php");
			
// add fields
form.addField("field1", "hello");
form.addField("field2", "world");
			
// add files
form.addFile("file1", test, "text/plain", "test.txt", true);
form.addFile("file2", jpg.encode(b.bitmapData), "application/octet-stream", "test.jpg", true);

// load request
var loader:URLLoader = new URLLoader();
loader.addEventListener(Event.COMPLETE, onComplete);
loader.load(form.request);