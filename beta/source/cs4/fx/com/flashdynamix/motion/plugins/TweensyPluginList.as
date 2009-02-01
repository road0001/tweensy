/**.______                                                              __          ___     /\__  _\                                                           /'__`\      /'___`\   \/_/\ \/  __  __  __     __      __     ___      ____   __  __    /\ \/\ \    /\_\ /\ \  ...\ \ \ /\ \/\ \/\ \  /'__`\  /'__`\ /' _ `\   /',__\ /\ \/\ \   \ \ \ \ \   \/_/// /__ ....\ \ \\ \ \_/ \_/ \/\  __/ /\  __/ /\ \/\ \ /\__, `\\ \ \_\ \   \ \ \_\ \ __  // /_\ \.....\ \_\\ \___x___/'\ \____\\ \____\\ \_\ \_\\/\____/ \/`____ \   \ \____//\_\/\______/......\/_/ \/__//__/   \/____/ \/____/ \/_/\/_/ \/___/   `/___/> \   \/___/ \/_/\/_____/ ............................................................/\___/                       ............................................................\/__/................. Tweening since 1998 .................................................................................. */package com.flashdynamix.motion.plugins {	import flash.display.DisplayObject;	import flash.utils.Dictionary;
	import com.flashdynamix.motion.TweensyGroup;	import com.flashdynamix.utils.MultiTypeObjectPool;	

	/**	 * @author FlashDynamix	 */	public class TweensyPluginList {		
		private static var pool : MultiTypeObjectPool;		private static var list : Vector.<Class>;		private static var map : Dictionary;		private static var listLength : int = 0;		
		protected static var inited : Boolean = init();

		private static function init() : Boolean {			if(inited) return true;						list = new Vector.<Class>();			map = new Dictionary(true);			pool = new MultiTypeObjectPool();						add(FilterTween.key, FilterTween);			add(MatrixTween.key, MatrixTween);			add(ColorTween.key, ColorTween);			add(SoundTween.key, SoundTween);			add(RectangleTween.key, RectangleTween);			add(PointTween.key, PointTween);						FilterTween.filters = TweensyGroup.filters;						pool.add(DisplayTween);			pool.add(SimpleDisplayTween);			pool.add(ObjectTween);						return true;		}

		public static function add(Type : Class, Tween : Class) : void {			list[listLength++] = Type;			map[Type] = Tween;			pool.add(Tween);		}

		public static function checkOut(item : Object) : AbstractTween {			//if(item is DisplayObject) return pool.checkOut(SimpleDisplayTween);			if(item is DisplayObject) return pool.checkOut(DisplayTween);						var i : int = 0;			var len : int = listLength;			var Type : Class;						for (i = 0;i < len; i++) {				Type = list[i];				if(item is Type) return pool.checkOut(map[Type]);			}						return pool.checkOut(ObjectTween);		}

		public static function checkIn(item : Object ) : void {			pool.checkIn(item);		}

		public static function empty() : void {			pool.empty();		}	}}