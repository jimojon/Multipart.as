#Multipart.as

A multipart form data request generator

##Demo :

http://labs.positronic.fr/flash/multipart/

The JPEGEncoder used in this demo can be found here:

http://www.bytearray.org/wp-content/projects/fastjpeg/JPEGEncoder.as

##Restrictions :

In Flash Player 10 and later, if you use a multipart Content-Type (for example "multipart/form-data") that contains an upload (indicated by a "filename" parameter in a "content-disposition" header within the POST body), the POST operation is subject to the security rules applied to uploads:

*   The POST operation must be performed in response to a user-initiated action, such as a mouse click or key press.  
*   If the POST operation is cross-domain (the POST target is not on the same server as the SWF file that is sending the POST request), the target server must provide a URL policy file that permits cross-domain access.


Source :

http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/net/URLRequest.html
