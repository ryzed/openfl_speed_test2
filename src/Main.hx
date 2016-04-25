package;

import openfl.Assets;
import openfl.display.FPS;
import openfl.display.OpenGLView;
import openfl.display.Sprite;
import openfl.geom.Rectangle;
import proj.TempDrawer;
import proj.TextureWrapper;
import ryz.math.M44;
import ryz.math.random.Rand;

/**
 * ...
 * @author ryzed
 */
class Main extends Sprite 
{
	private var view:OpenGLView;
	
	private var textureWrap:TextureWrapper;
	private var drawer:TempDrawer;

	
	private var rots:Array<Float>;
	private var drots:Array<Float>;
	private var colors:Array<Int>;
	private var scales:Array<Float>;
	
	
	
	public function new ()
	{
		
		super ();
		
		addChild(new FPS(10, 10, 0xffffff));
		
		
		if (OpenGLView.isSupported)
		{
			view = new OpenGLView();
			
			var bd = Assets.getBitmapData ("img/cloud32.png");
			textureWrap = new TextureWrapper(bd);
			
			drawer = new TempDrawer();
			drawer.setup();
			
			view.render = renderView;
			addChild (view);
		}
		
		
		rots = [];
		drots = [];
		colors = [];
		scales = [];
		for (n in 0...8192)
		{
			rots.push(Math.random());
			drots.push(Math.random() * 0.04 - 0.02);
			colors.push(Std.random(0xffffff));
			scales.push(Math.random() * 0.5 + 0.5);
		}
		
		
		
	}
	
	
	
	
	
	private function renderView(rect:Rectangle):Void
	{
		
		drawer.resizeBackbuffer(Std.int(rect.width), Std.int(rect.height));
		drawer.resetQuads();
		drawer.setTexture(textureWrap);
		
		
		
		var m = new M44();
		var npp = 0;
		
		for (dy in 0...20)
		{
			for (dx in 0...200)
			{
				var rot = rots[npp] + drots[npp];
				rots[npp] = rot;
				
				var clr = colors[npp];
				var scl = scales[npp];
				
				m.init2d(dx * 3.8 + 24, dy * 22 + 40, rot, scl, scl);
				m.multiplyFromVals2d( -16, -16, 0, 1, 1, m);
				
				var ma = m._11;
				var mb = m._12;
				var mc = m._21;
				var md = m._22;
				var mx = m._41;
				var my = m._42;
				
				
				// vecs
				var vxX = ma * 32;
				var vxY = mb * 32;
				var vyX = mc * 32;
				var vyY = md * 32;
				
				
				var v1x = vxX + mx;
				var v1y = vxY + my;
				
				var v3x = vyX + mx;
				var v3y = vyY + my;
				
				var v2x = vxX + v3x;
				var v2y = vxY + v3y;
				
				
				drawer.emitQuad(
					mx, my, 0, 0,
					v1x, v1y, 32, 0,
					v2x, v2y, 32, 32,
					v3x, v3y, 0, 32,
					fgetR(clr), fgetG(clr), fgetB(clr), 1);
				
					
				npp++;
			}
		}
		
			
		drawer.drawQuads(textureWrap);
		
	}	
	
	
	inline public static function fgetR(x:Int):Float
	{
		return ((x >> 16) & 0xff) / 255;
	}
	inline public static function fgetG(x:Int):Float
	{
		return ((x >> 8) & 0xff) / 255;
	}
	inline public static function fgetB(x:Int):Float
	{
		return ((x) & 0xff) / 255;
	}
	
	
}
