package com.flashdynamix.motion.data {

	/**
		public static const SMART_ROTATE : int = 1 << 0;

		/**
		 * @see com.flashdynamix.motion.TweenStyle#repeatType
		 */
		public static const YOYO : int = 0;
		/**
		 * @see com.flashdynamix.motion.TweenStyle#repeatType
		 */
		public static const REPLAY : int = 1;
		/**
		 * @see com.flashdynamix.motion.TweenStyle#repeatType
		 */
		public static const LOOP : int = 2;
		/**
		 * @see com.flashdynamix.motion.TweenStyle#repeatType
		 */
		public static const NONE : int = -1;

		public static var defaultTween : Function = easeOut;

		public var duration : Number = 0.5;
		public var repeats : int = -1;
		public var repeatEase : Array;

		private var _options : int = 1;

		public function TweenStyle(duration : Number = 0.5, ease : Function = null, delayStart : Number = 0, options : int = 1) : void {

		public function set options(values : int) : void {

		public function get options() : int {

		public function get smartRotate() : Boolean {

		public function get snapClosest() : Boolean {

		public function get autoHide() : Boolean {

		public function get uniqueFilters() : Boolean {

		public function get autoRemove() : Boolean {
		/**
		 * The total duration of the TweenStyle animation in seconds.<BR>
		 * This is the sum of delayStart, duration and delayEnd.
		 */
		public function get totalDuration() : Number {
			return (delayStart + duration + delayEnd);
		}

		public function clone() : TweenStyle {

		private static function easeOut(t : Number, b : Number, c : Number, d : Number) : Number {