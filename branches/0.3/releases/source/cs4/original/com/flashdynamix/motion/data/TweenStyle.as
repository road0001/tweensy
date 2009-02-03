package com.flashdynamix.motion.data {
	/**	 * @author FlashDynamix	 */	public class TweenStyle {
		public static const SMART_ROTATE : int = 1 << 0;		public static const SNAP_CLOSEST : int = 1 << 1;		public static const AUTO_HIDE : int = 1 << 2;		public static const UNIQUE_FILTERS : int = 1 << 3;		public static const AUTO_REMOVE : int = 1 << 4;
		public static const YOYO : int = 0;
		public static const REPLAY : int = 1;
		public static const LOOP : int = 2;
				public static const STOP_CONCURRENT : int = 0;		public static const STOP_ANY : int = 1;
		public static const UPDATE_CURRENT : int = 2;
				public static const NONE : int = -1;
		public static var defaultTween : Function = easeOut;
		public var conflictResolve : int = 0;
		public var duration : Number = 0.5;		/**		 * Defines the ease equation you would like to use. By default this is Quintic.easeOut or the defaultTween.		 * 		 * @see com.flashdynamix.motion.TweenStyle#defaultTween		 */		public var ease : Function;		public var easeParams : Array = [];		/**		 * Defines the delay in seconds at the start of the animation.<BR>		 * By default this value is 0 seconds.		 */		public var delayStart : Number = 0;		/**		 * Defines the delay in seconds at the end of the animation.<BR>		 * By default this value is 0 seconds.		 */		public var delayEnd : Number = 0;		/**		 * The number of repeats to use. If -1 is used then the animation will repeat indefinitely.		 * 		 * @see com.flashdynamix.motion.TweenStyle#repeats		 * @see com.flashdynamix.motion.TweenStyle#repeatType		 */
		public var repeats : int = -1;		/**		 * Defines the repeat type for the animation. By default this is TweenStyle.NONE<BR><BR>		 * Options include :		 * <ul>		 * <li>TweenStyle.NONE</li>		 * <li>TweenStyle.YOYO</li>		 * <li>TweenStyle.REPLAY</li>		 * <li>TweenStyle.LOOP</li>		 * </ul>		 * 		 * @see com.flashdynamix.motion.TweenStyle#repeats		 * @see com.flashdynamix.motion.TweenStyle#repeatCount		 * @see com.flashdynamix.motion.TweenStyle#NONE		 * @see com.flashdynamix.motion.TweenStyle#YOYO		 * @see com.flashdynamix.motion.TweenStyle#REPLAY		 * @see com.flashdynamix.motion.TweenStyle#LOOP		 */		public var repeatType : int = -1;		/**		 * This contains a list of ease Functions to use on each repeat for the tween animation.<BR>		 * i.e. [Quintic.easeIn, Quintic.easeOut]<BR>		 * This will then use each of these ease Functions on each repeat.<BR>		 * By default this is null when this property is null this functionality is ignored.		 * 		 * @see com.flashdynamix.motion.TweenStyle#repeats		 * @see com.flashdynamix.motion.TweenStyle#repeatType		 */
		public var repeatEase : Array;
		private var _options : int = 1;		private var _smartRotate : Boolean = false;		private var _snapClosest : Boolean = false;		private var _autoHide : Boolean = false;		private var _uniqueFilters : Boolean = false;		private var _autoRemove : Boolean = false;
		public function TweenStyle(duration : Number = 0.5, ease : Function = null, delayStart : Number = 0, options : int = 9, conflictResolve:int = 0) : void {			this.duration = duration;			this.ease = (ease == null) ? defaultTween : ease;			this.delayStart = delayStart;			this.delayEnd = delayEnd;			this.options = options;
			this.conflictResolve = conflictResolve;		}
		public function set options(values : int) : void {			_options = values;						_smartRotate = Boolean(_options & SMART_ROTATE);			_snapClosest = Boolean(_options & SNAP_CLOSEST);			_autoHide = Boolean(_options & AUTO_HIDE);			_uniqueFilters = Boolean(_options & UNIQUE_FILTERS);			_autoRemove = Boolean(_options & AUTO_REMOVE);		}
		public function get options() : int {			return _options;		}
		public function get smartRotate() : Boolean {			return _smartRotate;		}
		public function get snapClosest() : Boolean {			return _snapClosest;		}
		public function get autoHide() : Boolean {			return _autoHide;		}
		public function get uniqueFilters() : Boolean {			return _uniqueFilters;		}
		public function get autoRemove() : Boolean {			return _autoRemove;		}		/**
		 * The total duration of the TweenStyle animation in seconds.<BR>
		 * This is the sum of delayStart, duration and delayEnd.
		 */
		public function get totalDuration() : Number {
			return (delayStart + duration + delayEnd);
		}
		public function clone() : TweenStyle {			return new TweenStyle(duration, ease, delayStart, _options);		}
		private static function easeOut(t : Number, b : Number, c : Number, d : Number) : Number {			return -c * (t /= d) * (t - 2) + b;		}	}}