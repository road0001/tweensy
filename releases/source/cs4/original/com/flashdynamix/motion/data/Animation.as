package com.flashdynamix.motion.data {

	/**	 * @author FlashDynamix	 */	public class Animation {

		public var instance : Object;		public var applyInstance : Object;		public var style : TweenStyle;		public var target : TweenTarget;		public var onComplete : Function;		public var onCompleteParams : Array;		public var onUpdate : Function;		public var onUpdateParams : Array;		public var onRepeat : Function;		public var onRepeatParams : Array;

		public function Animation(instance : Object, target : TweenTarget, style : TweenStyle = null, applyInstance : Object = null, onComplete : Function = null, onCompleteParams : Array = null) {			this.instance = instance;			this.target = target;			this.style = style;			this.applyInstance = applyInstance;						this.onComplete = onComplete;			this.onCompleteParams = onCompleteParams;		}	}}