#Multipart.as

A multipart form data request generator

##Demo :

http://labs.positronic.fr/flash/multipart/

The JPEGEncoder used in this demo can be found here:
http://www.bytearray.org/wp-content/projects/fastjpeg/JPEGEncoder.as

##Restrictions :

In Flash Player 10 and later, if you use a multipart Content-Type (for example "multipart/form-data") that contains an upload (indicated by a "filename" parameter in a "content-disposition" header within the POST body), the POST operation is subject to the security rules applied to uploads:

*   If the POST operation is cross-domain (the POST target is not on the same server as the SWF file that is sending the POST request), the target server must provide a URL policy file that permits cross-domain access.


Source :
http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/net/URLRequest.html


## How to use it

Create a new `Multipart` object giving it the url you're asking for. The method will be automatically set at `POST`.

Then you can use the following methods agains your object:

* `addField(string fieldName, string value)`
* `addFile(string fieldName, ByteArray file, string mimeType, string fileName)`

Then you can retrieve the request at `yourObject.request` and load it with the native urlloader of actionscript.

Extracted from the Demo, here is a basic example:

```actionscript
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
```