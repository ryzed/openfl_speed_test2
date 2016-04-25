package proj;
import openfl.display.BitmapData;
import openfl.gl.GL;
import openfl.gl.GLTexture;
import openfl.utils.UInt8Array;

/**
 * ...
 * @author ryzed
 */
class TextureWrapper
{
	public var texture:GLTexture;
	public var width:Int;
	public var height:Int;
	
	public function new(bd:BitmapData) 
	{
		#if lime
		var pixelData = bd.image.data;
		#else
		var pixelData = new UInt8Array (bd.getPixels(bd.rect));
		#end
		
		texture = GL.createTexture ();
		GL.bindTexture (GL.TEXTURE_2D, texture);
		GL.texParameteri (GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.CLAMP_TO_EDGE);
		GL.texParameteri (GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.CLAMP_TO_EDGE);
		GL.texImage2D (GL.TEXTURE_2D, 0, GL.RGBA, bd.width, bd.height, 0, GL.RGBA, GL.UNSIGNED_BYTE, pixelData);
		GL.texParameteri (GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.LINEAR);
		GL.texParameteri (GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.LINEAR);
		GL.bindTexture (GL.TEXTURE_2D, null);
		
		width = bd.width;
		height = bd.height;
	}
	
}