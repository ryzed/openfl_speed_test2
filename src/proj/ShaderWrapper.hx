package proj;
import openfl.gl.GL;
import openfl.gl.GLProgram;
import openfl.gl.GLUniformLocation;
import openfl.utils.Float32Array;

/**
 * ...
 * @author ryzed
 */
class ShaderWrapper
{
	var program:GLProgram;
	
	var a_pos:Int;
	var a_uv:Int;
	var a_color:Int;
	var u_texture:GLUniformLocation;
	
	
	public function new() 
	{
		var vertexShaderSource =
		"
			attribute highp vec2 a_pos;
			attribute mediump vec2 a_uv;
			attribute lowp vec4 a_color;
			
			varying mediump vec2 v_uv;
			varying lowp vec4 v_color;
			
			void main(void)
			{
				v_uv = a_uv;
				v_color = a_color;
				gl_Position = vec4(a_pos, 0, 1);
			}
		";
		
		var fragmentShaderSource =
			#if !desktop
			"precision mediump float;" +
			#end
			"varying mediump vec2 v_uv;
			varying lowp vec4 v_color;
			
			uniform lowp sampler2D u_texture;
			
			void main(void)"+
			"{"+
			#if lime_legacy
				"gl_FragColor = texture2D (u_texture, v_uv).gbar * v_color;" + 
			#else
				"gl_FragColor = texture2D (u_texture, v_uv) * v_color;" + 
			#end
			"}";
		

			
		// compile this shit
			
		var vertexShader = GL.createShader(GL.VERTEX_SHADER);
		GL.shaderSource(vertexShader, vertexShaderSource);
		GL.compileShader(vertexShader);
		
		if (GL.getShaderParameter(vertexShader, GL.COMPILE_STATUS) == 0)
		{
			throw "Error compiling vertex shader";
		}
		
		var fragmentShader = GL.createShader(GL.FRAGMENT_SHADER);
		GL.shaderSource(fragmentShader, fragmentShaderSource);
		GL.compileShader(fragmentShader);
		
		if (GL.getShaderParameter(fragmentShader, GL.COMPILE_STATUS) == 0)
		{
			throw "Error compiling fragment shader";
		}
		
		
		program = GL.createProgram();
		GL.attachShader(program, vertexShader);
		GL.attachShader(program, fragmentShader);
		GL.linkProgram(program);
		
		if (GL.getProgramParameter(program, GL.LINK_STATUS) == 0)
		{
			throw "Unable to initialize the shader program.";
		}
		
		useProgram();
		
		
        a_pos = getAttribLocation("a_pos");
        a_uv = getAttribLocation("a_uv");
        a_color = getAttribLocation("a_color");

        u_texture = getUniformLocation("u_texture");
        setTexture(0);
	}
	
	
    public function useProgram():Void
    {
        GL.useProgram(program);
    }

    private function getAttribLocation(name:String):Int
    {
        var loc = GL.getAttribLocation(program, name);
		if (loc < 0)
		{
			var s = 'Missing attribute: $name';
			trace(s);
			throw s;
		}
        return loc;
    }

    private function getUniformLocation(name:String):GLUniformLocation
    {
        var loc = GL.getUniformLocation(program, name);
		/*
		if (loc == null)
		{
			var s = 'Missing uniform: $name';
			trace(s);
			throw s;
		}
		*/
        return loc;
    }
	
	
	
    public function setTexture(unit:Int):Void
    {
        GL.uniform1i(u_texture, unit);
    }

    public function prepare ()
    {
        GL.enableVertexAttribArray(a_pos);
        GL.enableVertexAttribArray(a_uv);
        GL.enableVertexAttribArray(a_color);

		#if openfl_legacy
		var bytesPerFloat = Float32Array.SBYTES_PER_ELEMENT;
		#else
		var bytesPerFloat = Float32Array.BYTES_PER_ELEMENT;
		#end
		
		
        var stride = 8 * bytesPerFloat;
        GL.vertexAttribPointer(a_pos, 2, GL.FLOAT, false, stride, 0 * bytesPerFloat);
        GL.vertexAttribPointer(a_uv, 2, GL.FLOAT, false, stride, 2 * bytesPerFloat);
        GL.vertexAttribPointer(a_color, 4, GL.FLOAT, false, stride, 4 * bytesPerFloat);
    }
	
	
}