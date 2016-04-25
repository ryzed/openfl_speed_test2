package ryz.math;

class M44 
{
	//private static inline var EPSILON = 1e-10;
	
	public var _11 : Float;
	public var _12 : Float;
	public var _13 : Float;
	public var _14 : Float;
	public var _21 : Float;
	public var _22 : Float;
	public var _23 : Float;
	public var _24 : Float;
	public var _31 : Float;
	public var _32 : Float;
	public var _33 : Float;
	public var _34 : Float;
	public var _41 : Float;
	public var _42 : Float;
	public var _43 : Float;
	public var _44 : Float;

	inline public function new() {	}

	inline public function zero():Void
	{
		_11 = 0.0; _12 = 0.0; _13 = 0.0; _14 = 0.0;
		_21 = 0.0; _22 = 0.0; _23 = 0.0; _24 = 0.0;
		_31 = 0.0; _32 = 0.0; _33 = 0.0; _34 = 0.0;
		_41 = 0.0; _42 = 0.0; _43 = 0.0; _44 = 0.0;
	}

	public inline function identity():Void
	{
		_11 = 1.0; _12 = 0.0; _13 = 0.0; _14 = 0.0;
		_21 = 0.0; _22 = 1.0; _23 = 0.0; _24 = 0.0;
		_31 = 0.0; _32 = 0.0; _33 = 1.0; _34 = 0.0;
		_41 = 0.0; _42 = 0.0; _43 = 0.0; _44 = 1.0;
	}

	
	inline public function initEuler( x : Float, y : Float, z : Float )
	{
		#if flash
		var Math = Math;
		#end
		var cx = Math.cos(x);
		var sx = Math.sin(x);
		var cy = Math.cos(y);
		var sy = Math.sin(y);
		var cz = Math.cos(z);
		var sz = Math.sin(z);
		var cxsy = cx * sy;
		var sxsy = sx * sy;
		_11 = cy * cz;
		_12 = cy * sz;
		_13 = -sy;
		_14 = 0;
		_21 = sxsy * cz - cx * sz;
		_22 = sxsy * sz + cx * cz;
		_23 = sx * cy;
		_24 = 0;
		_31 = cxsy * cz + sx * sz;
		_32 = cxsy * sz - sx * cz;
		_33 = cx * cy;
		_34 = 0;
		_41 = 0;
		_42 = 0;
		_43 = 0;
		_44 = 1;
	}
	
	inline public function initAngleAxis( ax:Float, ay:Float, az:Float, angle : Float )
	{
		var cos = Math.cos(angle), sin = Math.sin(angle);
		var cos1 = 1 - cos;
		var x = -ax, y = -ay, z = -az;
		var xx = x * x, yy = y * y, zz = z * z;
		var len = (1 / Math.sqrt(xx + yy + zz));
		x *= len;
		y *= len;
		z *= len;
		var xcos1 = x * cos1, zcos1 = z * cos1;
		_11 = cos + x * xcos1;
		_12 = y * xcos1 - z * sin;
		_13 = x * zcos1 + y * sin;
		_14 = 0.;
		_21 = y * xcos1 + z * sin;
		_22 = cos + y * y * cos1;
		_23 = y * zcos1 - x * sin;
		_24 = 0.;
		_31 = x * zcos1 - y * sin;
		_32 = y * zcos1 + x * sin;
		_33 = cos + z * zcos1;
		_34 = 0.;
		_41 = 0.; _42 = 0.; _43 = 0.; _44 = 1.;
	}

	
	inline public function initTR(px:Float, py:Float, pz:Float, rx:Float, ry:Float, rz:Float):Void
	{
		#if flash
		var Math = Math;
		#end
		var cx = Math.cos(rx);
		var sx = Math.sin(rx);
		var cy = Math.cos(ry);
		var sy = Math.sin(ry);
		var cz = Math.cos(rz);
		var sz = Math.sin(rz);
		var cxsy = cx * sy;
		var sxsy = sx * sy;
		_11 = cy * cz;
		_12 = cy * sz;
		_13 = -sy;
		_14 = 0;
		_21 = sxsy * cz - cx * sz;
		_22 = sxsy * sz + cx * cz;
		_23 = sx * cy;
		_24 = 0;
		_31 = cxsy * cz + sx * sz;
		_32 = cxsy * sz - sx * cz;
		_33 = cx * cy;
		_34 = 0;
		_41 = px;
		_42 = py;
		_43 = pz;
		_44 = 1;
	}
	inline public function initRotationalMatrix(m:M44):Void
	{
		_11 = m._11; _12 = m._12; _13 = m._13; _14 = 0;
		_21 = m._21; _22 = m._22; _23 = m._23; _24 = 0;
		_31 = m._31; _32 = m._32; _33 = m._33; _34 = 0;
		_41 =     0; _42 =     0; _43 =     0; _44 = 1;
	}

	
	
	
	inline public function initTranslate( x : Float, y : Float, z : Float ):Void
	{
		_11 = 1.0; _12 = 0.0; _13 = 0.0; _14 = 0.0;
		_21 = 0.0; _22 = 1.0; _23 = 0.0; _24 = 0.0;
		_31 = 0.0; _32 = 0.0; _33 = 1.0; _34 = 0.0;
		_41 = x; _42 = y; _43 = z; _44 = 1.0;
	}
	inline public function zeroTranslate():Void
	{
		_41 = 0; _42 = 0; _43 = 0;
	}

	inline public function translate(x:Float, y:Float, z:Float = 0.):Void
	{
		_11 += x * _14;
		_12 += y * _14;
		_13 += z * _14;
		_21 += x * _24;
		_22 += y * _24;
		_23 += z * _24;
		_31 += x * _34;
		_32 += y * _34;
		_33 += z * _34;
		_41 += x * _44;
		_42 += y * _44;
		_43 += z * _44;
	}
	
	inline public function scale(x:Float, y:Float, z:Float = 1):Void
	{
		// dont scale position
		_11 *= x;
		_21 *= x;
		_31 *= x;
		//_41 *= x;
		_12 *= y;
		_22 *= y;
		_32 *= y;
		//_42 *= y;
		_13 *= z;
		_23 *= z;
		_33 *= z;
		//_43 *= z;
	}

	inline public function initScale( x : Float, y : Float, z : Float ):Void
	{
		_11 =   x; _12 = 0.0; _13 = 0.0; _14 = 0.0;
		_21 = 0.0; _22 =   y; _23 = 0.0; _24 = 0.0;
		_31 = 0.0; _32 = 0.0; _33 =   z; _34 = 0.0;
		_41 = 0.0; _42 = 0.0; _43 = 0.0; _44 = 1.0;
	}

	inline public function multiply( a : M44, b : M44 ):Void
	{
		var a11 = a._11; var a12 = a._12; var a13 = a._13; var a14 = a._14;
		var a21 = a._21; var a22 = a._22; var a23 = a._23; var a24 = a._24;
		var a31 = a._31; var a32 = a._32; var a33 = a._33; var a34 = a._34;
		var a41 = a._41; var a42 = a._42; var a43 = a._43; var a44 = a._44;
		
		var b11 = b._11; var b12 = b._12; var b13 = b._13; var b14 = b._14;
		var b21 = b._21; var b22 = b._22; var b23 = b._23; var b24 = b._24;
		var b31 = b._31; var b32 = b._32; var b33 = b._33; var b34 = b._34;
		var b41 = b._41; var b42 = b._42; var b43 = b._43; var b44 = b._44;

		_11 = a11 * b11 + a12 * b21 + a13 * b31 + a14 * b41;
		_12 = a11 * b12 + a12 * b22 + a13 * b32 + a14 * b42;
		_13 = a11 * b13 + a12 * b23 + a13 * b33 + a14 * b43;
		_14 = a11 * b14 + a12 * b24 + a13 * b34 + a14 * b44;

		_21 = a21 * b11 + a22 * b21 + a23 * b31 + a24 * b41;
		_22 = a21 * b12 + a22 * b22 + a23 * b32 + a24 * b42;
		_23 = a21 * b13 + a22 * b23 + a23 * b33 + a24 * b43;
		_24 = a21 * b14 + a22 * b24 + a23 * b34 + a24 * b44;

		_31 = a31 * b11 + a32 * b21 + a33 * b31 + a34 * b41;
		_32 = a31 * b12 + a32 * b22 + a33 * b32 + a34 * b42;
		_33 = a31 * b13 + a32 * b23 + a33 * b33 + a34 * b43;
		_34 = a31 * b14 + a32 * b24 + a33 * b34 + a34 * b44;

		_41 = a41 * b11 + a42 * b21 + a43 * b31 + a44 * b41;
		_42 = a41 * b12 + a42 * b22 + a43 * b32 + a44 * b42;
		_43 = a41 * b13 + a42 * b23 + a43 * b33 + a44 * b43;
		_44 = a41 * b14 + a42 * b24 + a43 * b34 + a44 * b44;
	}
	
	
	inline public function inverse( m:M44 ):Void
	{
		var m11 = m._11; var m12 = m._12; var m13 = m._13; var m14 = m._14;
		var m21 = m._21; var m22 = m._22; var m23 = m._23; var m24 = m._24;
		var m31 = m._31; var m32 = m._32; var m33 = m._33; var m34 = m._34;
		var m41 = m._41; var m42 = m._42; var m43 = m._43; var m44 = m._44;

		_11 = m22 * m33 * m44 - m22 * m34 * m43 - m32 * m23 * m44 + m32 * m24 * m43 + m42 * m23 * m34 - m42 * m24 * m33;
		_21 = -m21 * m33 * m44 + m21 * m34 * m43 + m31 * m23 * m44 - m31 * m24 * m43 - m41 * m23 * m34 + m41 * m24 * m33;
		_31 = m21 * m32 * m44 - m21 * m34 * m42 - m31 * m22 * m44 + m31 * m24 * m42 + m41 * m22 * m34 - m41 * m24 * m32;
		_41 = -m21 * m32 * m43 + m21 * m33 * m42 + m31 * m22 * m43 - m31 * m23 * m42 - m41 * m22 * m33 + m41 * m23 * m32;
		_12 = -m12 * m33 * m44 + m12 * m34 * m43 + m32 * m13 * m44 - m32 * m14 * m43 - m42 * m13 * m34 + m42 * m14 * m33;
		_22 = m11 * m33 * m44 - m11 * m34 * m43 - m31 * m13 * m44 + m31 * m14 * m43 + m41 * m13 * m34 - m41 * m14 * m33;
		_32 = -m11 * m32 * m44 + m11 * m34 * m42 + m31 * m12 * m44 - m31 * m14 * m42 - m41 * m12 * m34 + m41 * m14 * m32;
		_42 = m11 * m32 * m43 - m11 * m33 * m42 - m31 * m12 * m43 + m31 * m13 * m42 + m41 * m12 * m33 - m41 * m13 * m32;
		_13 = m12 * m23 * m44 - m12 * m24 * m43 - m22 * m13 * m44 + m22 * m14 * m43 + m42 * m13 * m24 - m42 * m14 * m23;
		_23 = -m11 * m23 * m44 + m11 * m24 * m43 + m21 * m13 * m44 - m21 * m14 * m43 - m41 * m13 * m24 + m41 * m14 * m23;
		_33 = m11 * m22 * m44 - m11 * m24 * m42 - m21 * m12 * m44 + m21 * m14 * m42 + m41 * m12 * m24 - m41 * m14 * m22;
		_43 = -m11 * m22 * m43 + m11 * m23 * m42 + m21 * m12 * m43 - m21 * m13 * m42 - m41 * m12 * m23 + m41 * m13 * m22;
		_14 = -m12 * m23 * m34 + m12 * m24 * m33 + m22 * m13 * m34 - m22 * m14 * m33 - m32 * m13 * m24 + m32 * m14 * m23;
		_24 =  m11 * m23 * m34 - m11 * m24 * m33 - m21 * m13 * m34 + m21 * m14 * m33 + m31 * m13 * m24 - m31 * m14 * m23;
		_34 =  -m11 * m22 * m34 + m11 * m24 * m32 + m21 * m12 * m34 - m21 * m14 * m32 - m31 * m12 * m24 + m31 * m14 * m22;
		_44 = m11 * m22 * m33 - m11 * m23 * m32 - m21 * m12 * m33 + m21 * m13 * m32 + m31 * m12 * m23 - m31 * m13 * m22;

		var det = m11 * _11 + m12 * _21 + m13 * _31 + m14 * _41;
		if (Math.abs(det) < 1e-10 /* EPSILON */)
		{
			zero();
		}
		else
		{
			det = 1.0 / det;
			_11 *= det;
			_12 *= det;
			_13 *= det;
			_14 *= det;
			_21 *= det;
			_22 *= det;
			_23 *= det;
			_24 *= det;
			_31 *= det;
			_32 *= det;
			_33 *= det;
			_34 *= det;
			_41 *= det;
			_42 *= det;
			_43 *= det;
			_44 *= det;
		}
	}

	/*
	public inline function project(v:V3, out:V3):Void
	{
		var w = 1.0 / (_14 * v.x + _24 * v.y + _34 * v.z + _44);
		var x = (_11 * v.x + _21 * v.y + _31 * v.z + _41) * w;
		var y = (_12 * v.x + _22 * v.y + _32 * v.z + _42) * w;
		out.x = x;
		out.y = y;
		out.z = w;
	}
	public inline function project3(vx:Float, vy:Float, vz:Float, out:V3):Void
	{
		var w = 1.0 / (_14 * vx + _24 * vy + _34 * vz + _44);
		var x = (_11 * vx + _21 * vy + _31 * vz + _41) * w;
		var y = (_12 * vx + _22 * vy + _32 * vz + _42) * w;
		out.x = x;
		out.y = y;
		out.z = w;
	}
	

	public inline function projectMV( v : HMeshV3):Void
	{
		var w = 1.0 / (_14 * v.x + _24 * v.y + _34 * v.z + _44);
		v.w = w;
		v.sx = (_11 * v.x + _21 * v.y + _31 * v.z + _41) * w;
		v.sy = (_12 * v.x + _22 * v.y + _32 * v.z + _42) * w;
	}


	public inline function transform( v:V3, out : V3 ):Void
	{
		var px = _11 * v.x + _21 * v.y + _31 * v.z + _41;
		var py = _12 * v.x + _22 * v.y + _32 * v.z + _42;
		var pz = _13 * v.x + _23 * v.y + _33 * v.z + _43;
		out.x = px;
		out.y = py;
		out.z = pz;
	}
	public inline function transform3( vx:Float, vy:Float, vz:Float, out : V3 ):Void
	{
		out.x = _11 * vx + _21 * vy + _31 * vz + _41;
		out.y = _12 * vx + _22 * vy + _32 * vz + _42;
		out.z = _13 * vx + _23 * vy + _33 * vz + _43;
	}
	public inline function rotate(v:V3, out:V3):Void
	{
		var px = _11 * v.x + _21 * v.y + _31 * v.z;
		var py = _12 * v.x + _22 * v.y + _32 * v.z;
		var pz = _13 * v.x + _23 * v.y + _33 * v.z;
		out.x = px;
		out.y = py;
		out.z = pz;
	}
	public inline function rotate3(vx:Float, vy:Float, vz:Float, out:V3):Void
	{
		var px = _11 * vx + _21 * vy + _31 * vz;
		var py = _12 * vx + _22 * vy + _32 * vz;
		var pz = _13 * vx + _23 * vy + _33 * vz;
		out.x = px;
		out.y = py;
		out.z = pz;
	}

	public inline function transformMV(v:HMeshV3, out:HMeshV3):Void
	{
		var px = _11 * v.x + _21 * v.y + _31 * v.z + _41;
		var py = _12 * v.x + _22 * v.y + _32 * v.z + _42;
		var pz = _13 * v.x + _23 * v.y + _33 * v.z + _43;
		out.x = px;
		out.y = py;
		out.z = pz;
	}

*/

	inline public function transpose():Void
	{
		var tmp;
		tmp = _12; _12 = _21; _21 = tmp;
		tmp = _13; _13 = _31; _31 = tmp;
		tmp = _14; _14 = _41; _41 = tmp;
		tmp = _23; _23 = _32; _32 = tmp;
		tmp = _24; _24 = _42; _42 = tmp;
		tmp = _34; _34 = _43; _43 = tmp;
	}

/*
	public function toString() {
		return "MAT=[\n" +
			"  [ " + Math.fmt(_11) + ", " + Math.fmt(_12) + ", " + Math.fmt(_13) + ", " + Math.fmt(_14) + " ]\n" +
			"  [ " + Math.fmt(_21) + ", " + Math.fmt(_22) + ", " + Math.fmt(_23) + ", " + Math.fmt(_24) + " ]\n" +
			"  [ " + Math.fmt(_31) + ", " + Math.fmt(_32) + ", " + Math.fmt(_33) + ", " + Math.fmt(_34) + " ]\n" +
			"  [ " + Math.fmt(_41) + ", " + Math.fmt(_42) + ", " + Math.fmt(_43) + ", " + Math.fmt(_44) + " ]\n" +
		"]";
	}
*/
/*
	public function toMatrix():Matrix3D
	{
		return new flash.geom.Matrix3D(flash.Vector.ofArray([
			_11, _12, _13, _14,
			_21, _22, _23, _24,
			_31, _32, _33, _34,
			_41, _42, _43, _44,
		]));
	}
*/
	inline public function fromArray(a:Array<Float>):Void
	{
		_11 = a[0]; _12 = a[1]; _13 = a[2]; _14 = a[3];
		_21 = a[4]; _22 = a[5]; _23 = a[6]; _24 = a[7];
		_31 = a[8]; _32 = a[9]; _33 = a[10]; _34 = a[11];
		_41 = a[12]; _42 = a[13]; _43 = a[14]; _44 = a[15];
	}
	inline public function getFloats()
	{
		return [_11, _12, _13, _14, _21, _22, _23, _24, _31, _32, _33, _34, _41, _42, _43, _44];
	}

	inline public function from(m:M44):Void
	{
		_11 = m._11; _12 = m._12; _13 = m._13; _14 = m._14;
		_21 = m._21; _22 = m._22; _23 = m._23; _24 = m._24;
		_31 = m._31; _32 = m._32; _33 = m._33; _34 = m._34;
		_41 = m._41; _42 = m._42; _43 = m._43; _44 = m._44;
	}
	
	
	inline public function clone():M44
	{
		var m = new M44();
		m.from(this);
		return m;
	}

	
	
	inline public static function I():M44
	{
		var m = new M44();
		m.identity();
		return m;
	}

	inline public static function T(x:Float = 0, y:Float = 0, z:Float = 0):M44
	{
		var m = new M44();
		m.initTranslate(x, y, z);
		return m;
	}

	inline public static function R(x:Float, y:Float, z:Float):M44
	{
		var m = new M44();
		m.initEuler(x,y,z);
		return m;
	}

	inline public static function S(x:Float = 1, y:Float = 1, z:Float = 1):M44
	{
		var m = new M44();
		m.initScale(x, y, z);
		return m;
	}

	
	
	
	
	
/*
	public function decompose(t:V3, r:Quat, s:V3):Void
	{
		pos3(t);
		getScale(s);
		Quat.fromM44(this, s, r);
	}
	
	private static var tmp = new M44();
	public function compose(t:V3, r:Quat, s:V3):Void
	{
		//r.toM44(this);
		//scale(s.x, s.y, s.z);
		//translate(t.x, t.y, t.z);
		
		initScale(s.x, s.y, s.z);
		r.toM44(tmp);
		multiply(this, tmp);
		translate(t.x, t.y, t.z);
	}
	
	inline public function composeNoS(t:V3, r:Quat):Void
	{
		//r.toM44(this);
		//scale(s.x, s.y, s.z);
		//translate(t.x, t.y, t.z);
		
		identity();
		r.toM44(tmp);
		multiply(this, tmp);
		translate(t.x, t.y, t.z);
	}
*/
	
	/*
	macro public inline function transform(m:ExprOf<M44>, inp:Expr, out:Expr):Expr
	{
		var inType = Context.typeof(inp);
		Context.un
		trace(inType);
		
		var outType = Context.typeof(out);
		trace(outType);
		
		// usage m.transform([x, y, z] => [x, y, z]);
		//var fdec = MacroUtils.arrowDecompose(names);
		//var lNames = MacroUtils.unpackArrayOfIDsExpr(fdec.L);
		//var rNames = MacroUtils.unpackArrayOfIDsExpr(fdec.R);
		
		//trace(lNames);
		//trace(rNames);
		
		return macro 0;
	}
	*/
	
	
	
	public static function Frustum(l:Float, r:Float, b:Float, t:Float, n:Float, f:Float):M44
	{
		var m = new M44();
		m.zero();
		m._11 = (2 * n) / (r - l);
		m._22 = (2 * n) / (t - b);
		m._33 = (f + n) / (f - n);
		m._34 = 1;
		m._43 = -(2 * f * n) / (f - n);
		
		return m;
	}

	
	public static function Perspective(fov:Float, aspect:Float, zNear:Float, zFar:Float):M44
	{
		return null;
	}
	
	/*
	 * 
	 * From unity
	 * 
	 * 
    static Matrix4x4 PerspectiveOffCenter(float left, float right, float bottom, float top, float near, float far) {
        float x = 2.0F * near / (right - left);
        float y = 2.0F * near / (top - bottom);
        float a = (right + left) / (right - left);
        float b = (top + bottom) / (top - bottom);
        float c = -(far + near) / (far - near);
        float d = -(2.0F * far * near) / (far - near);
        float e = -1.0F;
        Matrix4x4 m = new Matrix4x4();
        m[0, 0] = x;
        m[0, 1] = 0;
        m[0, 2] = a;
        m[0, 3] = 0;
        m[1, 0] = 0;
        m[1, 1] = y;
        m[1, 2] = b;
        m[1, 3] = 0;
        m[2, 0] = 0;
        m[2, 1] = 0;
        m[2, 2] = c;
        m[2, 3] = d;
        m[3, 0] = 0;
        m[3, 1] = 0;
        m[3, 2] = e;
        m[3, 3] = 0;
        return m;
    }
	*/
	
	public static function Ortho(l:Float, r:Float, b:Float, t:Float, n:Float, f:Float):M44
	{
		var m = new M44();
		m.zero();
		m._11 = 2 / (r - l);
		m._22 = 2 / (t - b);
		m._33 = 1 / (f - n);
		m._44 = 1;
		
		m._41 = (l + r) / (l - r);
		m._42 = (t + b) / (b - t);
		m._43 = -n / (n - f);
		
		return m;
	}
	
	
	
	
	
	
	inline public function init2d(x:Float, y:Float, rotation:Float, scaleX:Float, scaleY:Float):Void
	{
		#if flash
		var Math = Math;
		#end
		
		var sin = Math.sin(rotation);
		var cos = Math.cos(rotation);
		
		_11 = cos * scaleX;
		_12 = sin * scaleX;
		_13 = 0;
		_14 = 0;
		_21 = -sin * scaleY;
		_22 = cos * scaleY;
		_23 = 0;
		_24 = 0;
		_31 = 0;
		_32 = 0;
		_33 = 1;
		_34 = 0;
		_41 = x;
		_42 = y;
		_43 = 0;
		_44 = 1;
	}
	inline public function set2d(a:Float, b:Float, c:Float, d:Float, x:Float, y:Float):Void
	{
		_11 = a; _12 = b; _13 = 0; _14 = 0;
		_21 = c; _22 = d; _23 = 0; _24 = 0;
		_31 = 0; _32 = 0; _33 = 1; _34 = 0;
		_41 = x; _42 = y; _43 = 0; _44 = 1;
	}

	
	inline public function multiplyFromMtx2d(ma:Float, mb:Float, mc:Float, md:Float, mx:Float, my:Float, bm:M44):Void
	{
		var b11 = bm._11; var b12 = bm._12;
		var b21 = bm._21; var b22 = bm._22;
		var b41 = bm._41; var b42 = bm._42;

		
		_11 = ma * b11 + mb * b21;
		_12 = ma * b12 + mb * b22;

		_21 = mc * b11 + md * b21;
		_22 = mc * b12 + md * b22;

		_31 = 0;
		_32 = 0;
		//_34 = 0;

		_41 = mx * b11 + my * b21 + b41;
		_42 = mx * b12 + my * b22 + b42;
	}
	
	
	
	inline public function multiplyFromVals2d(x:Float, y:Float, rotation:Float, scaleX:Float, scaleY:Float, bm:M44):Void
	{
		#if flash
		var Math = Math;
		#end
		
		var sin = Math.sin(rotation);
		var cos = Math.cos(rotation);
		
		var a11 = cos * scaleX; var a12 = sin * scaleX;
		var a21 = -sin * scaleY; var a22 = cos * scaleY;
		
		var b11 = bm._11; var b12 = bm._12;
		var b21 = bm._21; var b22 = bm._22;
		var b41 = bm._41; var b42 = bm._42;

		
		_11 = a11 * b11 + a12 * b21;
		_12 = a11 * b12 + a12 * b22;

		_21 = a21 * b11 + a22 * b21;
		_22 = a21 * b12 + a22 * b22;

		_31 = 0;
		_32 = 0;
		//_34 = 0;

		_41 = x * b11 + y * b21 + b41;
		_42 = x * b12 + y * b22 + b42;
	}
	
	
}