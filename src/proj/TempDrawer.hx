package proj;
import openfl.utils.Float32Array;
import openfl.gl.GL;
import openfl.gl.GLBuffer;
import openfl.utils.Int16Array;

/**
 * ...
 * @author ryzed
 */
class TempDrawer
{
	inline static var PER_VTX_FLOATS = 8;
	
	var data:Float32Array;
	var dataAdr:Int;
	var quadsCnt:Int;
	
	var vertexBuffer:GLBuffer;
	var indexBuffer:GLBuffer;
	
	var simpleTexShader:ShaderWrapper;
	
	
	var texSX:Float;
	var texSY:Float;
	var scrSX:Float;
	var scrSY:Float;
	
	
	public function new() 
	{
	}
	
	
	public function setup():Void
	{
        GL.clearColor (0x1f / 255, 0x2f / 255, 0x3f / 255, 1.0);
        GL.enable(GL.BLEND);
        GL.pixelStorei(GL.UNPACK_PREMULTIPLY_ALPHA_WEBGL, 1);
		
		
		vertexBuffer = GL.createBuffer();
		GL.bindBuffer(GL.ARRAY_BUFFER, vertexBuffer);
		
		indexBuffer = GL.createBuffer();
		GL.bindBuffer(GL.ELEMENT_ARRAY_BUFFER, indexBuffer);
		
		
		simpleTexShader = new ShaderWrapper();
		resizeBufs(8192);
	}
	
	
    private function resizeBufs(maxQuads:Int):Void
    {
        // Set the new vertex buffer size
        data = new Float32Array(maxQuads * 4 * PER_VTX_FLOATS);
		
        //GL.bufferData(GL.ARRAY_BUFFER, data.length * Float32Array.BYTES_PER_ELEMENT, GL.STREAM_DRAW);
        GL.bufferData(GL.ARRAY_BUFFER, data, GL.STREAM_DRAW);

        var indices = new Int16Array(6 * maxQuads);
        for (ii in 0...maxQuads)
		{
            indices[ii * 6 + 0] = ii * 4 + 0;
            indices[ii * 6 + 1] = ii * 4 + 1;
            indices[ii * 6 + 2] = ii * 4 + 2;
            indices[ii * 6 + 3] = ii * 4 + 2;
            indices[ii * 6 + 4] = ii * 4 + 3;
            indices[ii * 6 + 5] = ii * 4 + 0;
        }
        GL.bufferData(GL.ELEMENT_ARRAY_BUFFER, indices, GL.STATIC_DRAW);
    }
	
	
	
	
	public function setTargetSize(w:Int, h:Int):Void
	{
		scrSX = 1 / (w * 0.5);
		scrSY = 1 / (h * 0.5);
	}
	inline function setTextureSize(w:Int, h:Int):Void
	{
		texSX = 1 / w;
		texSY = 1 / h;
	}
	
	
	
	
    public function resizeBackbuffer(width:Int, height:Int):Void
    {
		GL.viewport(0, 0, width, height);
		setTargetSize(width, height);
    }
	
	public function setTexture(tex:TextureWrapper):Void
	{
		setTextureSize(tex.width, tex.height);
	}
	
	
	public function resetQuads():Void
	{
		dataAdr = 0;
		quadsCnt = 0;
	}
	public function drawQuads(tex:TextureWrapper):Void
	{
		GL.clear(GL.COLOR_BUFFER_BIT);
		GL.blendFunc(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA);
		
		simpleTexShader.prepare();
		GL.bindTexture(GL.TEXTURE_2D, tex.texture);
		
        //GL.bufferData(GL.ARRAY_BUFFER, data.subarray(0, dataAdr), GL.STREAM_DRAW);
        GL.bufferData(GL.ARRAY_BUFFER, data, GL.STREAM_DRAW);
        GL.drawElements(GL.TRIANGLES, 6 * quadsCnt, GL.UNSIGNED_SHORT, 0);
	}
	
	
	
	public function emitQuad(x0:Float, y0:Float, u0:Float, v0:Float,
							 x1:Float, y1:Float, u1:Float, v1:Float,
							 x2:Float, y2:Float, u2:Float, v2:Float,
							 x3:Float, y3:Float, u3:Float, v3:Float,
							 Rm:Float, Gm:Float, Bm:Float, Am:Float):Void
	{
		var adr = dataAdr;
		
		emitVtx(adr + 0 * PER_VTX_FLOATS, x0, y0, u0, v0, Rm, Gm, Bm, Am);
		emitVtx(adr + 1 * PER_VTX_FLOATS, x1, y1, u1, v1, Rm, Gm, Bm, Am);
		emitVtx(adr + 2 * PER_VTX_FLOATS, x2, y2, u2, v2, Rm, Gm, Bm, Am);
		emitVtx(adr + 3 * PER_VTX_FLOATS, x3, y3, u3, v3, Rm, Gm, Bm, Am);
		
		dataAdr += (4 * PER_VTX_FLOATS);
		quadsCnt++;
	}
	
	function emitVtx(adr:Int, px:Float, py:Float, tx:Float, ty:Float, Rm:Float, Gm:Float, Bm:Float, Am:Float):Void
	{
		var vb = data;
		
		vb[adr + 0] = (px * scrSX) - 1;
		vb[adr + 1] = 1 - (py * scrSY);
		
		vb[adr + 2] = tx * texSX;
		vb[adr + 3] = ty * texSY;
		
		vb[adr + 4] = Rm;
		vb[adr + 5] = Gm;
		vb[adr + 6] = Bm;
		vb[adr + 7] = Am;
	}

	
}