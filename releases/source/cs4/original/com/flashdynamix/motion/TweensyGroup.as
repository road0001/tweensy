﻿
/**.______                                                         __        __     /\__  _\                                                      /'__`\    /'__`\   \/_/\ \/ __  __  __     __     __    ___     ____  __  __    /\ \/\ \  /\_\L\ \  ...\ \ \/\ \/\ \/\ \  /'__`\ /'__`\/' _ `\  /',__\/\ \/\ \   \ \ \ \ \ \/_/_\_<_ ....\ \ \ \ \_/ \_/ \/\  __//\  __//\ \/\ \/\__, `\ \ \_\ \   \ \ \_\ \__/\ \L\ \.....\ \_\ \___x___/'\ \____\ \____\ \_\ \_\/\____/\/`____ \   \ \____/\_\ \____/......\/_/\/__//__/   \/____/\/____/\/_/\/_/\/___/  `/___/> \   \/___/\/_/\/___/ ......................................................./\___/                    .......................................................\/__/ ................. Tweening since 1998 .................................................................................. */package com.flashdynamix.motion {	import flash.display.*;
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.*;
	
	import com.flashdynamix.motion.TweensyTimeline;
	import com.flashdynamix.motion.easing.TweenTarget;
	import com.flashdynamix.utils.ObjectPool;	

	/**	 * The TweensyGroup Class contains a collection of tweens specified by property tweens for an Object instance.	 * Using the TweensyGroup Class to manage tweens is the recommended implementation of Tweensy.	 * <BR><BR>	 * A tween can be executed in one of the following manners :	 * <ul>	 * <li>to - allows for defining where the animation is going 'to' from its current position<BR>	 * e.g. <code>tween.to(item, {x:50, y:100});</code>	 * </li>	 * <li>from - allows for defining where the animation is coming 'from' and will be going to its current position<BR>	 * e.g. <code>tween.from(item, {x:200, y:150});</code>	 * </li>	 * <li>fromTo - allows for defining where the animation is coming 'from' and going 'to'<BR>	 * e.g. <code>tween.fromTo(item, {x:200, y:150}, {x:50, y:100});</code>	 * </li>	 * </ul>	 * The TweensyGroup Class has events for:	 * <ul>	 * <li>onComplete - When all tweens in the TweensyGroup Class are done</li>	 * <li>onUpdate - When all animations in the TweensyGroup Class have been updated.</li>	 * </ul>	 * These events allow for predefined params to be applied when they are executed.	 * Tweensy favours this method as it allows for predefining the event and the params it requires	 * without all the fussiness of Event listeners.	 * 	 * @see com.flashdynamix.motion.TweensyTimeline	 */	public class TweensyGroup {
		protected static var inited : Boolean = init();		protected static var pool : ObjectPool;
		protected static var frame : Sprite;
		protected static var map : Dictionary;		protected static var keyframes : Dictionary;		public static var filters : Dictionary;		protected static const radsDegree : Number = 180 / Math.PI;		/**		 * Defines whether the TweensyGroup Class will automatically resolve property tween conflicts.<BR>		 * Property tween conflicts occur when one property tweens time overlaps another.		 */		public var lazyMode : Boolean = true;		/**		 * Defines whether the TweensyGroup Class will use object pooling for instances of TweensyTimeline.<BR>		 * Object Pooling can result in significant performance increase as it descreases the expenses of constructing		 * TweensyTimeline instances but requires the developer to be careful when creating references to pooled instances.<BR>		 * This is because pooled TweensyTimeline instances may be being reused.		 */		public var useObjectPooling : Boolean = false;		/**		 * Whether the timelines contained within the TweensyGroup class will use smart rotation or not.<BR>		 * Using smart rotation will ensure that when tweening the 'rotation' property it will turn in the shortest rotation direction.<BR>		 * This fixes what may otherwise appear as a visual glitch even though mathimatically it is correct.		 */		public var smartRotate : Boolean = true;		/**		 * Whether the timelines contained within the TweensyGroup class will snap tweened properties to the closest whole number.		 */		public var snapToClosest : Boolean = false;
		public var autoHide : Boolean = false;
		/**		 * Defines how many seconds per frame are added to to each on an ENTER_FRAME when TweensyGroup Class's refreshType is of the Tweensy.FRAME mode.<BR>		 * This property and feature is intended as an alternative to the Tweensy.TIME (time based animation) mode which can result in jumpy effects.		 * This is because by using Tweensy.Time rfreshType it ensures that your animation will accurately finish in the time you specify.		 * Instead Tweensy.FRAME ensures that every frame is rendered for the duration of your animation.		 * e.g. If your FLA frame rate is 30 frames per second then set secondsPerFrame to 1 second for every 30 frames (1/30).		 * 		 * @see com.flashdynamix.motion.TweensyGroup#refreshType		 * @see com.flashdynamix.motion.Tweensy#FRAME		 */		public var secondsPerFrame : Number = 1 / 30;		/**		 * The timing system currently in use.<BR>		 * This can be either :		 * <ul>		 * <li>Tweensy.TIME</li>		 * <li>Tweensy.FRAME</li>		 * </ul>		 * 		 * @see com.flashdynamix.motion.Tweensy#FRAME		 * @see com.flashdynamix.motion.Tweensy#TIME		 * @see com.flashdynamix.motion.TweensyGroup#secondsPerFrame		 */		public var refreshType : String = "time";		/**		 * Executed on each frame update.		 * 		 * @see com.flashdynamix.motion.TweensyGroup#onUpdateParams		 */		public var onUpdate : Function;		/**		 * Parameters applied to the onUpdate Function.		 * 		 * @see com.flashdynamix.motion.TweensyGroup#onUpdate		 */		public var onUpdateParams : Array;		/**		 * Executed when all tweens are complete.		 * 		 * @see com.flashdynamix.motion.TweensyGroup#onComplete		 */		public var onComplete : Function;		/**		 * Parameters applied to the onComplete Function.		 * 		 * @see com.flashdynamix.motion.TweensyGroup#onCompleteParams		 */		public var onCompleteParams : Array;
		private var first : TweensyTimeline;		private var last : TweensyTimeline;
		private var time : Number;		private var _timelines : int = 0;		private var _paused : Boolean;		private var disposed : Boolean = false;

		/**		 * @param lazyMode Whether the tween manager will automatically remove confilcting tweens. This is not the most efficient method		 * for using Tweensy. If lazy mode is turned off (false) then it's the responsibility of the developer to ensure that conflicting tweens don't 		 * occur by using the stop method on the instance.		 * @param useObjectPooling Defines whether the TweensyGroup Class will use object pooling for instances of TweensyTimeline.		 * @param refreshType Can be either "time" or "frame" by default it's <code>Tweensy.TIME</code>. <code>Tweensy.TIME</code> will ensure that your animations finish in		 * the time you specify. <code>Tweensy.FRAME</code> allows you to set the seconds to update per frame by default it's set to 30 FPS which equals		 * in SPF = 0.033333333 or 1/30.		 * 		 * @see com.flashdynamix.motion.TweensyGroup#refreshType		 * @see com.flashdynamix.motion.TweensyGroup#useObjectPooling		 */		public function TweensyGroup(lazyMode : Boolean = true, useObjectPooling : Boolean = false, refreshType : String = "time") {			this.lazyMode = lazyMode;			this.useObjectPooling = useObjectPooling;			this.refreshType = refreshType;			time = getTimer();		}

		private static function init() : Boolean {
			
			pool = new ObjectPool(TweensyTimeline);
			frame = new Sprite();
			map = new Dictionary(true);
			keyframes = new Dictionary(true);
			filters = new Dictionary(true);
			
			return true;
		}

		/**		 * Adds a to based tween using the properties defined in the target Object.		 * 		 * @param instance The instance Object to be tweened or multiple instances if using the type Array e.g. <code>[item1, item2]</code>		 * @param to An Object containing the properties you would like to tween to e.g. <code>{x:50, y:25}</code>		 * or this can be relative e.g. <code>{x:'50', y:'-25'}</code> or can be a random position e.g. <code>{x:'-50, 50', y:'-25, 25'}</code>		 * @param duration The time in secs you would like the tween to run.		 * @param ease The ease equation you would like to use, by default this is Quintic.easeOut or the ease equation defined in TweensyTimeline.defaultTween.		 * @param delayStart The delay you would like to use at the beginning of the tween and every subsequent REPLAY of a tween.		 * @param update This param is used when tweening a property in a Object which needs to be applied onto another Object each time		 * the tween occurs. This occurs with tweening ColorTransforms, Matrices, SoundTransforms, BitmapFilters.<BR>		 * For example <code>tween.to(new DropShadowFilter(), {alpha:0}, 0.5, null, 0, myDisplayItem);</code><BR>		 * Will apply the tweening DropShadowFilter onto the DisplayObject <code>'myDisplayItem'</code>.		 * @param onComplete The onComplete event handler you would like to fire once the tween is complete.		 * @param onCompleteParams The params applied to the onComplete handler.		 * 		 * @return An instance to the TweensyTimeline which can used to manage this tween.		 * 		 * @see com.flashdynamix.motion.TweensyTimeline		 */		public function to(instance : Object, toObj : Object, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0, updateObj : Object = null, onComplete : Function = null, onCompleteParams : Array = null) : TweensyTimeline {			var timeline : TweensyTimeline = setup(duration, ease, delayStart, onComplete, onCompleteParams);			timeline.to(instance, toObj, updateObj);						return add(timeline);		}

		/**		 * Adds a from based tween using the properties defined in the from Object.		 * 		 * @param instance The instance Object to be tweened or multiple instances if using the type Array e.g. <code>[item1, item2]</code>		 * @param from An Object containing the properties you would like to tween from e.g. <code>{x:50, y:25}</code>		 * or this can be relative e.g. <code>{x:'50', y:'-25'}</code> or can be a random position e.g. <code>{x:'-50, 50', y:'-25, 25'}</code>		 * @param duration The time in secs you would like the tween to run.		 * @param ease The ease equation you would like to use, by default this is Quintic.easeOut or the ease equation defined in TweensyTimeline.defaultTween.		 * @param delayStart The delay you would like to use at the beginning of the tween and every subsequent REPLAY of a tween.		 * @param update This param is used when tweening a property in a Object which needs to be applied onto another Object each time		 * the tween occurs.This occurs with tweening ColorTransforms, Matrices, SoundTransforms, BitmapFilters.<BR>		 * For example <code>tween.from(new DropShadowFilter(), {alpha:0}, 0.5, null, 0, myDisplayItem);</code><BR>		 * Will apply the tweening DropShadowFilter onto the DisplayObject <code>'myDisplayItem'</code>.		 * @param onComplete The onComplete event handler you would like to fire once the tween is complete.		 * @param onCompleteParams The params applied to the onComplete handler.		 *		 * @return An instance of the TweensyTimeline which can used to manage this tween.		 * 		 * @see com.flashdynamix.motion.TweensyTimeline		 */		public function from(instance : Object, fromObj : Object, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0, updateObj : Object = null, onComplete : Function = null, onCompleteParams : Array = null) : TweensyTimeline {			var timeline : TweensyTimeline = setup(duration, ease, delayStart, onComplete, onCompleteParams);			timeline.from(instance, fromObj, updateObj);						return add(timeline);		}

		/**		 * Adds a from to based tween using the properties defined in the from and to Objects.		 * 		 * @param instance The instance Object to be tweened or multiple instances if using the type Array e.g. <code>[item1, item2]</code>		 * @param from An Object containing the properties you would like to tween from e.g. <code>{x:50, y:25}</code>		 * or this can be relative e.g. <code>{x:'50', y:'-25'}</code> or can be a random position e.g. <code>{x:'-50, 50', y:'-25, 25'}</code>		 * @param to An Object containing the properties you would like to tween to e.g. <code>{x:50, y:25}</code>		 * or this can be relative e.g. <code>{x:'50', y:'-25'}</code> or can be a random position e.g. <code>{x:'-50, 50', y:'-25, 25'}</code>		 * @param duration The time in secs you would like the tween to run.		 * @param ease The ease equation you would like to use, by default this is Quintic.easeOut or the ease equation defined in TweensyTimeline.defaultTween.		 * @param delayStart The delay you would like to use at the beginning of the tween and every subsequent REPLAY of a tween.		 * @param update This param is used when tweening a property in a Object which needs to be applied onto another Object each time		 * the tween occurs.This occurs with tweening ColorTransforms, Matrices, SoundTransforms, BitmapFilters.<BR>		 * For example <code>tween.fromTo(new DropShadowFilter(), {alpha:1}, {alpha:0}, 0.5, null, 0, myDisplayItem);</code><BR>		 * Will apply the tweening DropShadowFilter onto the DisplayObject <code>'myDisplayItem'</code>.		 * @param onComplete The onComplete event handler you would like to fire once the tween is complete.		 * @param onCompleteParams The params applied to the onComplete handler.		 *		 * @return An instance of the TweensyTimeline which can used to manage this tween.		 * 		 * @see com.flashdynamix.motion.TweensyTimeline		 */		public function fromTo(instance : Object, fromObj : Object, toObj : Object, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0, updateObj : Object = null, onComplete : Function = null, onCompleteParams : Array = null) : TweensyTimeline {			var timeline : TweensyTimeline = setup(duration, ease, delayStart, onComplete, onCompleteParams);			timeline.fromTo(instance, fromObj, toObj, updateObj);						return add(timeline);		}

		public function animate(instance : Object, target : TweenTarget, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0, updateObj : Object = null, onComplete : Function = null, onCompleteParams : Array = null) : TweensyTimeline {			var timeline : TweensyTimeline = setup(duration, ease, delayStart, onComplete, onCompleteParams);						switch(target.type) {				case TweenTarget.FROM :					timeline.to(instance, target.from, updateObj);					break;				case TweenTarget.TO :					timeline.to(instance, target.to, updateObj);					break;				case TweenTarget.FROM_TO :					timeline.fromTo(instance, target.from, target.to, updateObj);					break;			}						return add(timeline);		}

		/**		 * Updates a tween for the instance Object to the new target positions defined in the to Object.		 */		public function updateTo(instance : Object, toObj : Object) : void {			var timeline : TweensyTimeline = first;			var timelinesList : Array = map[instance];						for each(timeline in timelinesList) timeline.updateTo(instance, toObj);		}

		/**		 * This method provides a handy method to do the common task of tweening an Object instance and then needing to apply this to an update Function call.<BR>		 * This is equivalent to : <code>var timeline:TweensyTimeline = tween.to(point, {x:50, y:50});<BR>		 * timeline.onUpdate = item.setPoint;<BR>		 * timeline.onUpdateParams = [point];</code>		 * <BR><BR>		 * If requiring not to just set the instance to the Function but rather properties within the instance which are tweening this can be 		 * done via the following code example :<BR>		 * <code>var onUpdate:Function = function(current:Object):void{<BR>		 * 		pane.setSize(current.width, current.height);<BR>		 * }<BR>		 * tween.functionTo({width:pane.width, height:pane.height}, {width:200, height:200}, onUpdate);</code>		 * 		 * @return An instance to the TweensyTimeline.		 */		public function functionTo(instance : Object, toObj : Object, onUpdate : Function, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0) : TweensyTimeline {			var timeline : TweensyTimeline = setup(duration, ease, delayStart);			timeline.to(instance, toObj);						timeline.onUpdate = onUpdate;						add(timeline);						return timeline;		}

		/**		 * This method provides a handy method to do the common task of an alpha tween for an Object instance.<BR>		 * This is equivalent to : <code>tween.to(instance, {alpha:'value'});</code>		 * 		 * @return An instance to the TweensyTimeline.		 */		public function alphaTo(instance : DisplayObject, alpha : Number, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0) : TweensyTimeline {			var timeline : TweensyTimeline = setup(duration, ease, delayStart);			timeline.to(instance, {alpha:alpha});			add(timeline);						return timeline;		}

		/**		 * This method provides a handy method to do the common task of an scaling by x and y for an Object instance.<BR>		 * This is equivalent to <code>tween.to(instance, {scaleX:'value', scaleY:'value'});</code>		 * 		 * @return An instance to the TweensyTimeline.		 */		public function scaleTo(instance : DisplayObject, scale : Number, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0) : TweensyTimeline {			var timeline : TweensyTimeline = setup(duration, ease, delayStart);			timeline.to(instance, {scale:scale});			add(timeline);						return timeline;		}

		/**		 * This method provides a handy method to do the common task of an moving by x and y for an Object instance.<BR>		 * This is equivalent to : <code>tween.to(instance, {x:'value', y:'value'});</code>		 * 		 * @return An instance to the TweensyTimeline.		 */		public function slideTo(instance : DisplayObject, x : Number, y : Number, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0) : TweensyTimeline {			var timeline : TweensyTimeline = setup(duration, ease, delayStart);			timeline.to(instance, {x:x, y:y});			add(timeline);						return timeline;		}

		public function skewXYTo(instance : DisplayObject, xDegree : Number, yDegree : Number, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0) : TweensyTimeline {			var mtx : Matrix = instance.transform.matrix;						var scaleX : Number = Math.sqrt(mtx.a * mtx.a + mtx.b * mtx.b);			var scaleY : Number = Math.sqrt(mtx.c * mtx.c + mtx.d * mtx.d);						var skewY : Number = yDegree * radsDegree;			var skewX : Number = xDegree * radsDegree;						mtx.a = scaleX * Math.cos(skewY);			mtx.b = scaleX * Math.sin(skewY);			mtx.c = -scaleY * Math.sin(skewX);			mtx.d = scaleY * Math.cos(skewX);						return matrixTo(instance, mtx, duration, ease, delayStart);		}

		/**		 * This method provides a handy method to do the common task of rotation for an Object instance.<BR>		 * This is equivalent to : <code>tween.to(instance, {rotation:'value'});</code>		 * 		 * @return An instance to the TweensyTimeline.		 * 		 * @see com.flashdynamix.motion.TweensyGroup#useSmartRotate		 */		public function rotateTo(instance : DisplayObject, rotation : Number, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0) : TweensyTimeline {			var timeline : TweensyTimeline = setup(duration, ease, delayStart);			timeline.to(instance, {rotation:rotation});			add(timeline);						return timeline;		}

		/**		 * This method provides a handy method to do the common task of a matrix transform for a DisplayObject instance.<BR>		 * This is equivalent to :		 * <code>tween.to(instance.transform.matrix, new Matrix(), 0.5, null, 0, instance);</code>		 * 		 * @return An instance to the TweensyTimeline.		 */		public function matrixTo(instance : DisplayObject, mtx : Matrix, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0) : TweensyTimeline {			var timeline : TweensyTimeline = setup(duration, ease, delayStart);			timeline.to(instance.transform.matrix, mtx, instance);			add(timeline);						return timeline;		}

		/**		 * This method provides a handy method to do the common task of a sound transforms for a Sprite or SoundChannel instance.<BR>		 * This is equivalent to :		 * <code>tween.to(instance.soundTransform, new SoundTransform(), 0.5, null, 0, instance);</code>		 * 		 * @return An instance to the TweensyTimeline.		 */		public function soundTransformTo(instance : Object, trans : SoundTransform, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0) : TweensyTimeline {			var timeline : TweensyTimeline = setup(duration, ease, delayStart);						if(instance is SoundChannel) {				timeline.to((instance as SoundChannel).soundTransform, trans, instance);			} else {				timeline.to((instance as Sprite).soundTransform, trans, instance);			}						add(timeline);						return timeline;		}

		public function childrenOf(container : DisplayObjectContainer, target : TweenTarget, stagger : Number = 0.1, duration : Number = 0.5, ease : Function = null, updateObj : Object = null) : Array {			var instance : DisplayObject;			var i : int;			var len : int = container.numChildren;			var timelineList : Array = [];						for (i = 0;i < len; i++) {				instance = container.getChildAt(i);				timelineList.push(animate(instance, target, duration, ease, i * stagger, updateObj));			}						return timelineList;		}

		public function stagger(items : Array, target : TweenTarget, stagger : Number = 0.1, duration : Number = 0.5, ease : Function = null, updateObj : Object = null) : Array {			var instance : Object;			var i : int;			var len : int = items.length;			var timelineList : Array = [];						for (i = 0;i < len; i++) {				instance = items[i];				timelineList.push(animate(instance, target, duration, ease, i * stagger, updateObj));			}						return timelineList;		}

		/**		 * This method provides a handy method to do the common task of a tweening BitmapFilter properties and applying them to a DisplayObject instance.<BR>		 * This is equivalent to :		 * <code>tween.to(new DropShadowFilter(), {alpha:1}, 0.5, null, 0, instance);</code>		 * 		 * @return An instance to the TweensyTimeline.		 */		public function filter(instance : DisplayObject, filter : BitmapFilter, target : TweenTarget, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0, uniqueFilters : Boolean = true, autoRemove : Boolean = false) : TweensyTimeline {			if(uniqueFilters) {								if(filters[instance] == null) filters[instance] = instance.filters;								var filterMatch : BitmapFilter;				var instanceFilters : Array = filters[instance];								for each(var filterItem : BitmapFilter in instanceFilters) {					if(getQualifiedClassName(filter) == getQualifiedClassName(filterItem)) {						filterMatch = filterItem;					}				}								filter = (filterMatch) ? filterMatch : filter;			}						var timeline : TweensyTimeline = animate(filter, target, duration, ease, delayStart, instance);						if(autoRemove) timeline.onComplete = function():void {				var list : Array = filters[instance];				list.splice(list.indexOf(filter), 1);								instance.filters = list;			};						return timeline;		}

		public function getFilters(instance : DisplayObject) : Array {			if(!(instance in filters)) filters[instance] = [];						return filters[instance];		}

		/**		 * This method provides a handy method to do the common task of color transitions for a DisplayObject instance.<BR>		 * This is equivalent to :		 * <code>var ct : ColorTransform = new ColorTransform();<BR>		 * ct.color = 'value';<BR>		 * tween.to(instance.transform.colorTransform, ct, 0.5, null, 0, instance);</code>		 * 		 * @param color The hexadecimal color you would like to be tweened to for the instance.		 * 		 * @return An instance to the TweensyTimeline.		 */		public function colorTo(instance : DisplayObject, color : uint, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0) : TweensyTimeline {			var timeline : TweensyTimeline = setup(duration, ease, delayStart);						var ct : ColorTransform = new ColorTransform();			ct.color = color;						timeline.to(instance.transform.colorTransform, ct, instance);			add(timeline);						return timeline;		}

		/**		 * This method provides a handy method to do the common task of color transform for a DisplayObject instance.<BR>		 * This is equivalent to :		 * <code>tween.to(instance.transform.colorTransform, new ColorTransform(), 0.5, null, 0, instance);</code>		 * 		 * @return An instance to the TweensyTimeline.		 */		public function colorTransformTo(instance : DisplayObject, color : ColorTransform, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0) : TweensyTimeline {			var timeline : TweensyTimeline = setup(duration, ease, delayStart);			timeline.to(instance.transform.colorTransform, color, instance);			add(timeline);						return timeline;		}

		/**		 * This method provides a handy method to do the common task of applying contrast to a DisplayObject instance via a ColorTransform.<BR>		 * This is equivalent to :		 * <code>var ct : ColorTransform = new ColorTransform(1, 1, 1, 1, 'value' * 255, 'value' * 255, 'value' * 255);<BR>		 * tween.to(instance.transform.colorTransform, ct, 0.5, null, 0, instance);</code><BR><BR>		 * Contrast can also be applied by using a ColorMarixFilter.		 * 		 * @param amount Defines the amount of contrast to apply. The amount can be a value from -1 to 1. An amount of 1 is full bright contrast, -1 is full dark contrast and 0 is normal contrast.		 * 		 * @return An instance to the TweensyTimeline.		 * 		 * @see com.flashdynamix.motion.extras.ColorMatrixFilter		 */		public function contrastTo(instance : DisplayObject, amount : Number, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0) : TweensyTimeline {			var timeline : TweensyTimeline = setup(duration, ease, delayStart);						var ct : ColorTransform = new ColorTransform(1, 1, 1, 1, amount * 255, amount * 255, amount * 255);						timeline.to(instance.transform.colorTransform, ct, instance);			add(timeline);						return timeline;		}

		/**		 * This method provides a handy method to do the common task of applying brightness to a DisplayObject instance via a ColorTransform.<BR>		 * This is equivalent to :		 * <code>var ct : ColorTransform = new ColorTransform('value', 'value', 'value', 1, 'value' * 255, 'value' * 255, 'value' * 255);<BR>		 * tween.to(instance.transform.colorTransform, ct, 0.5, null, 0, instance);</code><BR><BR>		 * Brightness can also be applied by using a ColorMarixFilter.		 * 		 * @param amount Defines the amount of brightness to apply. The amount can be a value from -1 to 1. An amount of 1 is white, -1 is black and 0 is normal brightness.		 * 		 * @return An instance to the TweensyTimeline.		 * 		 * @see com.flashdynamix.motion.extras.ColorMatrixFilter		 */		public function brightnessTo(instance : DisplayObject, amount : Number, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0) : TweensyTimeline {			var timeline : TweensyTimeline = setup(duration, ease, delayStart);						var ct : ColorTransform;			if(amount > 0) {				ct = new ColorTransform(amount, amount, amount, 1, amount * 255, amount * 255, amount * 255);			} else {				ct = new ColorTransform(1 + amount, 1 + amount, 1 + amount);			}						timeline.to(instance.transform.colorTransform, ct, instance);			add(timeline);						return timeline;		}

		public function keyframeTo(instance : Object, index : int, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0) : TweensyTimeline {			var to : Object = getKeyframe(instance, index);						if(to == null) return null;						var timeline : TweensyTimeline = setup(duration, ease, delayStart);						timeline.to(instance, to);			add(timeline);						return timeline;		}

		public function addKeyframe(instance : Object, ...props : Array) : void {			var to : Object = {};
			
			if(!(instance in keyframes)) keyframes[instance] = [];			keyframes[instance].push(to);						for each(var propName:String in props) to[propName] = instance[propName];		}

		public function removeKeyframe(instance : Object, index : int) : int {			if(instance in keyframes) {				var frames : Array = keyframes[instance];				frames.splice(index, 1);								return frames.length;			}						return -1;		}

		public function getKeyframe(instance : Object, index : int) : Object {			if(instance in keyframes) return keyframes[index];						return null;		}

		/**		 * Adds a TweensyTimeline to the TweensyGroup class.		 * This can be useful if you want to prepare an animation and the tweens contained within it but not necessarily		 * have it to Tweening straight away.		 * 		 * @return An instance to the TweensyTimeline.		 */		public function add(item : TweensyTimeline) : TweensyTimeline {						if(lazyMode) {				var instance : Object;				for each(instance in item.instances) addInstance(instance, item);			}						if(!hasTimelines) startUpdate();						item.manager = this;			item.smartRotate = smartRotate;			item.snapToClosest = snapToClosest;			item.autoHide = autoHide;						if(first) {				first.previous = item;			} else {				last = item;			}						item.next = first;			first = item;						_timelines++;						return item;		}

		/**		 * Removes a TweensyTimeline from the TweensyGroup class.		 * This will stop this timeline from being updated but can be re-added to the TweensyGroup class resuming that animation.		 * 		 * @return An instance to the TweensyTimeline.		 */		public function remove(item : TweensyTimeline) : void {			if(item.manager != this) return;						if(item.previous) item.previous.next = item.next;			if(item.next) item.next.previous = item.previous;						if(item == first) {				first = first.next;				if(first) first.previous = null;			}						if(item == last) {				last = item.previous;				if(last) last.next = null;			}						var instance : Object;			for each(instance in item.instances) removeInstance(instance, item);						if(useObjectPooling) {
				pool.checkIn(item);
				item.clear();
			}						_timelines--;						if(!hasTimelines) stopUpdate();		}

		internal function addInstance(instance : Object, item : TweensyTimeline) : void {			if(lazyMode) {								var timelineList : Array = map[instance];				var timeline : TweensyTimeline;							if(timelineList) {					for each(timeline in timelineList) timeline.removeOverlap(item);				}				if(!(instance in map)) timelineList = map[instance] = [];									timelineList.push(item);			}		}

		internal function removeInstance(instance : Object, item : TweensyTimeline) : void {			if(lazyMode) {								var timelinesList : Array = map[instance];								if(timelinesList) {					var index : int = timelinesList.indexOf(item);					if(index != -1) {						if(timelinesList.length <= 1) {							map[instance].length = 0;						} else {							timelinesList.splice(index, 1);						}					}				}			}		}

		/**		 * Allows for removing tweens via an instance or tween props by the following methods :		 * <ul>		 * <li><code>tween.stop(instance);</code> - stops all property tweens for this instance.</li>		 * <li><code>tween.stop(instance, "x", "y");</code> - stops all x,y property tweens for this instance.</li>		 * <li><code>tween.stop([instance1, instance2]);</code> - stops all property tweens for these instances.</li>		 * <li><code>tween.stop([instance1, instance2], "x", "y");</code> - stops all x,y property tweens for these instances.</li>		 * <li><code>tween.stop(null, "x", "y");</code> - stops all x,y property tweens.</li>		 * <li><code>tween.stop();</code> - stops all tweens though it is recommended to use the stopAll method as this is more efficient.</li>		 * </ul>		 * 		 */		public function stop(instance : * = null, ...props : Array) : void {			var timeline : TweensyTimeline;			var timelinesList : Array = map[instance];			var args : Array = [instance].concat(props);						for each(timeline in timelinesList) timeline.stop.apply(null, args);		}

		/**		 * Removes all tweens from the TweensyGroup Class.		 */		public function stopAll() : void {			if(_timelines > 0)						var timeline : TweensyTimeline = first;						while(timeline) {				timeline.stopAll();				timeline = timeline.next;			}		}

		/**		 * Pauses all tweens in the TweensyGroup Class.		 */		public function pause() : void {			_paused = true;		}

		/**		 * Resumes all paused tweens in the TweensyGroup Class.		 */		public function resume() : void {			_paused = false;
			
			time = getTimer();		}

		/**		 * Whether the TweensyGroup Class is timeline paused.		 */		public function get paused() : Boolean {			return _paused;		}

		/**		 * Whether the TweensyGroup Class has any TweensyTimeline animations.		 */		public function get hasTimelines() : Boolean {			return (_timelines > 0);		}

		/**		 * Total number of animations in progress for the TweensyGroup class.		 */		public function get timelines() : int {			return _timelines;		}

		private function setup(duration : Number, ease : Function, delayStart : Number, onComplete : Function = null, onCompleteParams : Array = null) : TweensyTimeline {			var timeline : TweensyTimeline;						if(useObjectPooling) {				timeline = pool.checkOut();			} else {				timeline = new TweensyTimeline();			}						timeline.duration = duration;			if(ease != null) timeline.ease = ease;			timeline.delayStart = delayStart;			timeline.onComplete = onComplete;			timeline.onCompleteParams = onCompleteParams;						return timeline;		}

		private function startUpdate() : void {			time = getTimer();			
			frame.addEventListener(Event.ENTER_FRAME, update, false, 0, true);		}

		private function stopUpdate() : void {
			frame.removeEventListener(Event.ENTER_FRAME, update);		}

		private function update(e : Event) : void {
			if(_paused) return;
						var timeline : TweensyTimeline = first;			var next : TweensyTimeline;			var dif : Number = secondsPerFrame;						if(refreshType == Tweensy.TIME) {				dif = getTimer() - time;				time += dif;				dif *= 0.001;			}						while(timeline) {				next = timeline.next;				timeline.update(dif);				timeline = next;			}						if(onUpdate != null) onUpdate.apply(this, onUpdateParams);			if(!hasTimelines && onComplete != null) onComplete.apply(this, onCompleteParams);		}

		/**		 * Prepares the TweensyGroup class for garbage collection by disposing its Object Pools and making it 		 * no longer usable in the Flash application.		 */		public static function empty() : void {			pool.empty();			map = new Dictionary(true);			keyframes = new Dictionary(true);			filters = new Dictionary(true);		}

		/**		 * Disposes the TweensyGroup Class instance ready for garbage collection		 */		public function dispose() : void {			if(disposed) return;						disposed = true;						stopAll();			first = null;			last = null;			onComplete = null;			onCompleteParams = null;			onUpdate = null;			onUpdateParams = null;			_timelines = 0;		}

		public function toString() : String {			return "TweensyGroup " + Tweensy.version + " {timelines:" + _timelines + "}";		}	}}