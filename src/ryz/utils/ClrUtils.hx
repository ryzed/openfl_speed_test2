package ryz.utils;
import ryz.math.RMath;
import ryz.math.V3;

/**
 * ...
 * @author ryz
 */

class ClrUtils 
{
	inline public static function clrMulSlow(x:Int, s:Int):Int
	{
		var r:Int = ((((x >> 16) & 0xFF) * s) >> 8); if (r > 255) { r = 255; }
		var g:Int = ((((x >> 8) & 0xFF) * s) >> 8); if (g > 255) { g = 255; }
		var b:Int = ((((x) & 0xFF) * s) >> 8); if (b > 255) { b = 255; }
		return ((r << 16) | (g << 8) | b);
	}
	
	inline public static function clrMaxSlow(c0:Int, c1:Int):Int
	{
		var r = RMath.max(getR(c0), getR(c1));
		var g = RMath.max(getG(c0), getG(c1));
		var b = RMath.max(getB(c0), getB(c1));
		
		return RGB2Int(r, g, b);
	}
	
	
	inline public static function clrMul(x:Int, s:Int):Int
	{
		// assumed s - multiplied * 256, can be negative
		// if (number < 0) number = 0;
		s &= ~s >> 31;
		
		var r:Int = 0xFF - ((((x >> 16) & 0xFF) * s) >> 8);
		r &= ~r >> 31;
		r = 0xFF - r;
		
		var g:Int = 0xFF - ((((x >> 8) & 0xFF) * s) >> 8);
		g &= ~g >> 31;
		g = 0xFF - g;
		
		var b:Int = 0xFF - ((((x) & 0xFF) * s) >> 8);
		b &= ~b >> 31;
		b = 0xFF - b;
		
		return ((r << 16) | (g << 8) | b);
	}
	
	inline public static function mad(c0:Int, c1:Int, c1s:Int):Int
	{
		// assumed s - multiplied * 256, can be negative
		// if (number < 0) number = 0;
		c1s &= ~c1s >> 31;
		
		var r = 0xFF - (((c0 >> 16) & 0xFF) + ((((c1 >> 16) & 0xFF) * c1s) >> 8));
		r &= ~r >> 31;
		r = 0xFF - r;
		
		var g = 0xFF - (((c0 >> 8) & 0xFF) + ((((c1 >> 8) & 0xFF) * c1s) >> 8));
		g &= ~g >> 31;
		g = 0xFF - g;
		
		var b = 0xFF - ((c0 & 0xFF) + (((c1 & 0xFF) * c1s) >> 8));
		b &= ~b >> 31;
		b = 0xFF - b;
		
		return ((r << 16) | (g << 8) | b);
	}

	inline public static function sumMul(c0:Int, c1:Int, s:Int):Int
	{
		// assumed s - multiplied * 256, can be negative
		// if (number < 0) number = 0;
		s &= ~s >> 31;
		
		var r = 0xFF - (((getR(c0) + getR(c1)) * s) >> 8);
		r &= ~r >> 31;
		r = 0xFF - r;
		
		var g = 0xFF - (((getG(c0) + getG(c1)) * s) >> 8);
		g &= ~g >> 31;
		g = 0xFF - g;
		
		var b = 0xFF - (((getB(c0) + getB(c1)) * s) >> 8);
		b &= ~b >> 31;
		b = 0xFF - b;
		
		return ((r << 16) | (g << 8) | b);
	}
	inline public static function sumMulGrey(c0:Int, w:Int, s:Int):Int
	{
		// assumed s - multiplied * 256, can be negative
		// if (number < 0) number = 0;
		s &= ~s >> 31;
		
		var r = 0xFF - (((getR(c0) + w) * s) >> 8);
		r &= ~r >> 31;
		r = 0xFF - r;
		
		var g = 0xFF - (((getG(c0) + w) * s) >> 8);
		g &= ~g >> 31;
		g = 0xFF - g;
		
		var b = 0xFF - (((getB(c0) + w) * s) >> 8);
		b &= ~b >> 31;
		b = 0xFF - b;
		
		return ((r << 16) | (g << 8) | b);
	}

	
	
	inline public static function clrMulRGB(r:Int, g:Int, b:Int, s:Int):Int
	{
		// assumed s - multiplied * 256, can be negative
		
		// if (number < 0) number = 0;
		s &= ~s >> 31;
		
		r = 0xFF - ((r * s) >> 8);
		r &= ~r >> 31;
		r = 0xFF - r;
		
		g = 0xFF - ((g * s) >> 8);
		g &= ~g >> 31;
		g = 0xFF - g;
		
		b = 0xFF - ((b * s) >> 8);
		b &= ~b >> 31;
		b = 0xFF - b;
		
		return ((r << 16) | (g << 8) | b);
	}

	
	inline public static function fClrMul(x:Int, v:Float):Int
	{
		var s = Std.int(v * 256);
		
		// if (number < 0) number = 0;
		s &= ~s >>31;
		
		var r:Int = ((((x >> 16) & 0xFF) * s) >> 8); 
		// if (number > 0xFF) number = 0xFF;
		r = 0xFF-r;
		r &= ~r >>31;
		r = 0xFF-r;
		
		var g:Int = ((((x >> 8) & 0xFF) * s) >> 8);
		// if (number > 0xFF) number = 0xFF;
		g = 0xFF-g;
		g &= ~g >>31;
		g = 0xFF-g;
		
		var b:Int = ((((x) & 0xFF) * s) >> 8);
		// if (number > 0xFF) number = 0xFF;
		b = 0xFF-b;
		b &= ~b >>31;
		b = 0xFF-b;
		
		return ((r << 16) | (g << 8) | b);
	}
	
	
	
	inline public static function RGB2Int(r:Int, g:Int, b:Int):Int
	{
		return ((r << 16) | (g << 8) | b);
	}
	
	
	inline public static function getR(x:Int):Int
	{
		return ((x >> 16) & 0xff);
	}
	inline public static function getG(x:Int):Int
	{
		return ((x >> 8) & 0xff);
	}
	inline public static function getB(x:Int):Int
	{
		return ((x) & 0xff);
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
	inline public static function asGrey(c:Int):Int
	{
		return ((c << 16) | (c << 8) | c);
	}
	
	inline public static function fRGB3(fr:Float, fg:Float, fb:Float):Int
	{
		var r = Std.int(fr * 255);
		r = 0xFF-r;
		r &= ~r >>31;
		r = 0xFF - r;
		
		var g = Std.int(fg * 255);
		g = 0xFF-g;
		g &= ~g >>31;
		g = 0xFF-g;
		
		var b = Std.int(fb * 255);
		b = 0xFF-b;
		b &= ~b >>31;
		b = 0xFF - b;
		
		return ((r << 16) | (g << 8) | b);
	}
	
	
	inline public static function add(c0:Int, c1:Int):Int
	{
		var r:Int = 0xFF - (((c0 >> 16) & 0xFF) + ((c1 >> 16) & 0xff));
		r &= ~r >> 31;
		r = 0xFF - r;
		
		var g:Int = 0xFF - (((c0 >> 8) & 0xFF) + ((c1 >> 8) & 0xff));
		g &= ~g >> 31;
		g = 0xFF - g;
		
		var b:Int = 0xFF - ((c0 & 0xFF) + (c1 & 0xff));
		b &= ~b >> 31;
		b = 0xFF - b;
		
		return ((r << 16) | (g << 8) | b);
	}
	inline public static function addGrey(c0:Int, grey:Int):Int
	{
		var r:Int = 0xFF - (((c0 >> 16) & 0xFF) + grey);
		r &= ~r >> 31;
		r = 0xFF - r;
		
		var g:Int = 0xFF - (((c0 >> 8) & 0xFF) + grey);
		g &= ~g >> 31;
		g = 0xFF - g;
		
		var b:Int = 0xFF - ((c0 & 0xFF) + grey);
		b &= ~b >> 31;
		b = 0xFF - b;
		
		return ((r << 16) | (g << 8) | b);
	}
	
	
	inline public static function fromV3(v:V3):Int
	{
		var r = Std.int(v.x * 255);
		r = 0xFF-r;
		r &= ~r >>31;
		r = 0xFF - r;
		
		var g = Std.int(v.y * 255);
		g = 0xFF-g;
		g &= ~g >>31;
		g = 0xFF-g;
		
		var b = Std.int(v.z * 255);
		b = 0xFF-b;
		b &= ~b >>31;
		b = 0xFF-b;
		
		return ((r << 16) | (g << 8) | b);
	}
	inline public static function toV3(clr:Int, v:V3):Void
	{
		v.x = ((clr >> 16) & 0xff) / 0xff;
		v.y = ((clr >> 8) & 0xff) / 0xff;
		v.z = ((clr) & 0xff) / 0xff;
	}
	inline public static function makeV3(clr:Int):V3
	{
		return new V3(((clr >> 16) & 0xff) / 0xff, ((clr >> 8) & 0xff) / 0xff, ((clr) & 0xff) / 0xff);
	}
	
/*
	inline public static function toV4(clr:Int, v:V4):Void
	{
		v.w = ((clr >> 24) & 0xff) / 0xff;
		v.x = ((clr >> 16) & 0xff) / 0xff;
		v.y = ((clr >> 8) & 0xff) / 0xff;
		v.z = ((clr) & 0xff) / 0xff;
	}
*/
	
	
	inline public static function lerp(c0:Int, c1:Int, t:Int):Int
	{
		var cc0 = clrMul(c0, 255 - t);
		var cc1 = clrMul(c1, t);
		
		return add(cc0, cc1);
	}
	inline public static function flerp(c0:Int, c1:Int, t:Float):Int
	{
		//var tt = RMath.clamp(Std.int(t * 255), 0, 255);
		return lerp(c0, c1, Std.int(t * 255));
		//var cc0 = clrMul(c0, 255 - tt);
		//var cc1 = clrMul(c1, tt);
		//
		//return add(cc0, cc1);
	}
	
	
	
	/**
	 * Converts an <i>rgb</i> color value to a <i>hsv</i> color value.
	 * @param hsv Stores the result. If omitted, the method creates a new HSV object.
	 * @return The <i>hsv</i> object or a new HSV object if <i>hsv</i> was not specified.
	 */
	inline public static function I24toHSV(rgb:Int, hsv:V3):Void
	{
		var r = ((rgb >> 16) & 0xff) / 255;
		var g = ((rgb >> 8) & 0xff) / 255;
		var b = (rgb & 0xff) / 255;
		
		var min = RMath.fmin(RMath.fmin(r, g), b);
		var max = RMath.fmax(RMath.fmax(r, g), b);
		
		hsv.z = max;
		
		var delta = max - min;
		
		if (max != 0)
		{
			hsv.y = delta / max;
			
			var h;
		
			if (r == max)
				h = (g - b) / delta;
			else
			if (g == max)
				h = 2 + (b - r) / delta;
			else
				h = 4 + (r - g) / delta;
			
			h *= 60;
			if (h < 0) h += 360;
			hsv.x = h;
		}
		else
		{
			hsv.y = 0;
			hsv.x = -1;
			
		}
	}

	
	
	/**
	 * Converts an <i>rgb</i> color value to a <i>hsv</i> color value.
	 * @param hsv Stores the result. If omitted, the method creates a new HSV object.
	 * @return The <i>hsv</i> object or a new HSV object if <i>hsv</i> was not specified.
	 */
	inline public static function RGBtoHSV(rgb:V3, hsv:V3):Void
	{
		var r = rgb.x;
		var g = rgb.y;
		var b = rgb.z;
		
		var min = RMath.fmin(RMath.fmin(r, g), b);
		var max = RMath.fmax(RMath.fmax(r, g), b);
		
		hsv.z = max;
		
		var delta = max - min;
		
		if (max != 0)
		{
			hsv.y = delta / max;
			
			var h;
		
			if (r == max)
				h = (g - b) / delta;
			else
			if (g == max)
				h = 2 + (b - r) / delta;
			else
				h = 4 + (r - g) / delta;
			
			h *= 60;
			if (h < 0) h += 360;
			hsv.x = h;
		}
		else
		{
			hsv.y = 0;
			hsv.x = -1;
			
		}
	}

	/**
	 * Converts a <i>hsv</i> color value to an <i>rgb</i> color value.
	 * @param rgb Stores the result. If omitted, the method creates a new RGB object.
	 * @return The <i>rgb</i> object or a new RGB object if <i>rgb</i> was not specified.
	 */
	inline public static function HSVtoRGB(hsv:V3, rgb:V3):Void
	{
		var s = hsv.y;
		var v = hsv.z;
		
		if (s == 0)
		{
			rgb.to(v, v, v);
		}
		else
		{
			var h = hsv.x;
			h /= 60;
			var i = Math.ffloor(h);
			var f = h - i;
			var p = v * (1 - s);
			var q = v * (1 - s * f);
			var t = v * (1 - s * (1 - f));
			
			switch (i)
			{
				case 0:  rgb.to(v, t, p);
				case 1:  rgb.to(q, v, p);
				case 2:  rgb.to(p, v, t);
				case 3:  rgb.to(p, q, v);
				case 4:  rgb.to(t, p, v);
				default: rgb.to(v, p, q);
			}
		}
	}

	
	public static inline function hsv(h:Float, s:Float, v:Float):Int
	{
		if (s == 0)
		{
			return fRGB3(v, v, v);
		}
		else
		{
			h %= 360;
			if (h < 0) h += 360;
			h /= 60;
			var i = Math.ffloor(h);
			var f = h - i;
			var p = v * (1 - s);
			var q = v * (1 - s * f);
			var t = v * (1 - s * (1 - f));
			
			return switch (i)
			{
				case 0:  fRGB3(v, t, p);
				case 1:  fRGB3(q, v, p);
				case 2:  fRGB3(p, v, t);
				case 3:  fRGB3(p, q, v);
				case 4:  fRGB3(t, p, v);
				default: fRGB3(v, p, q);
			}
		}
	}		

	
	
	
/**
 * Blend two color 
 *
 * blend two RGB colors using a blend factor 
 * 
 * 0 => return color 1
 * n => return color2*(n/256) + color1*(256-n)/256
 * 256 => return color 2 
 *
 * 
 * NB : should be inlined for better efficiency
 * 
 * @param color1 RGB color input 1
 * @param color2 RGB color input 2
 * @param factor blending factor between color1 & color 2, must be 0>=factor<=256
 * 
 * @return color1 blended with color2
 *
 * @see http://dzzd.net/
 * @author Bruno Augier - ( DzzD ) - 2009
 */

	inline public static function blend(c1:Int, c2:Int, factor:Int):Int
	{
		var f1 = 256 - factor;
		return ((((c1 & 0xFF00FF) * f1 + (c2 & 0xFF00FF) * factor) & 0xFF00FF00) | (((c1 & 0x00FF00) * f1 + (c2 & 0x00FF00) * factor) & 0x00FF0000)) >>> 8;
	}
	inline public static function blend2(c1:Int, c2:Int):Int
	{
		var factor = (c2 >> 24) & 0xff;
		var f1 = 256 - factor;
		return ((((c1 & 0xFF00FF) * f1 + (c2 & 0xFF00FF) * factor) & 0xFF00FF00) | (((c1 & 0x00FF00) * f1 + (c2 & 0x00FF00) * factor) & 0x00FF0000)) >>> 8;
	}


	
	
	
	
	/**
	 * Parses an individual hexadecimal string character to the equivalent decimal integer value
	 * @param	hex_char hexadecimal character (1-length string)
	 * @return  decimal value of hex_char
	 */
	
	public static inline function hexChar2dec(hex_char:String):Int 
	{
		var val:Int = -1;
		switch(hex_char) 
		{
			case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10":val = Std.parseInt(hex_char);
			case "A","a": val = 10;
			case "B", "b": val = 11; 
			case "C", "c": val = 12; 
			case "D", "d": val = 13; 
			case "E", "e": val = 14; 
			case "F", "f": val = 15; 
		}
		if (val == -1)
		{
			throw "hexChar2dec() illegal char(" + hex_char + ")";
		}
		return val;
	}
	
	/**
	 * Parses hex string to equivalent integer
	 * @param	hex_str string in format RRGGBB or AARRGGBB (no "0x")
	 * @return integer value
	 */
	
	public static inline function hex2dec(hex_str:String):Int 
	{
		var length:Int = hex_str.length;
		var place_mult:Int = 1;		
		var sum:Int = 0;
		var i:Int = length - 1; 
		while (i >= 0) 
		{
			var char_hex:String = hex_str.substr(i, 1);
			var char_int:Int = hexChar2dec(char_hex);
			sum += char_int * place_mult;
			place_mult *= 16;
			i--;
		}
		return sum;
	}

	
	
	
	
	
}