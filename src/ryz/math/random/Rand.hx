package ryz.math.random;

/**
 * ...
 * @author ryzed
 */
class Rand
{
	var seed : Int;
	var seed2 : Int;

	inline public function new(seed:Int) 
	{
		init(seed);
	}
	
	public function init(seed:Int) 
	{
		this.seed = seed;
		this.seed2 = hash(seed);
		if( this.seed == 0 ) this.seed = 1;
		if( this.seed2 == 0 ) this.seed2 = 1;
	}
	
	// this is the Murmur3 hashing function which has both excellent distribution and good randomness
	public static function hash(n, seed = 5381) 
	{
		return inlineHash(n, seed);
	}
	
	public static inline function inlineHash(n, seed) 
	{
		n *= 0xcc9e2d51;
		n = (n << 15) | (n >>> 17);
		n *= 0x1b873593;
		var h = seed;
		h ^= n;
		h = (h << 13) | (h >>> 19);
		h = h*5 + 0xe6546b64;
		h ^= h >> 16;
		h *= 0x85ebca6b;
		h ^= h >> 13;
		h *= 0xc2b2ae35;
		h ^= h >> 16;
		return h;
	}

	public inline function random(n):Int
	{
		return uint() % n;
	}

	public inline function rand():Float
	{
		// we can't use a divider > 16807 or else two consecutive seeds
		// might generate a similar float
		return (uint() % 10007) / 10007.0;
	}

	public inline function srand():Float
	{
		return (int() % 10007) / 10007.0;
	}
	
	// this is two Marsaglia Multiple-with-Carry (MWC) generators combined
	inline public function int() : Int 
	{
		seed = 36969 * (seed & 0xFFFF) + (seed >> 16);
		seed2 = 18000 * (seed2 & 0xFFFF) + (seed2 >> 16);
		return (seed << 16) + seed2;
	}
	
	inline public function uint():Int
	{
		return int() & 0x3FFFFFFF;
	}
	
	
	public inline function rndElt<T>(a:Array<T>):T
	{
		return a[random(a.length)];
	}
	public inline function shuffle<T>(arr:Array<T>)
	{
		var n = arr.length;
		while (n > 1)
		{
			var k = random(n);// Std.random(n);
			n--;
			var temp = arr[n];
			arr[n] = arr[k];
			arr[k]= temp;
		}
	}
	public inline function frange(a:Float, b:Float):Float
	{
		return ((b - a) * rand() + a);
	}
	public inline function range(a:Int, b:Int):Int
	{
		return Math.round(frange(a, b));
	}
	
}