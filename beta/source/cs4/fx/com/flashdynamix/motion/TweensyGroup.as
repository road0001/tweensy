﻿
/**
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.*;
	
	import com.flashdynamix.motion.TweensyTimeline;
	import com.flashdynamix.motion.easing.EaseTarget;
	import com.flashdynamix.utils.ObjectPool;	

	/**
		protected static var inited : Boolean = init();
		protected static var frame : Sprite;
		protected static var checkInTimer : Timer;
		public var autoHide : Boolean = false;
		/**
		private var first : TweensyTimeline;
		private var time : Number;

		/**

		private static function init() : Boolean {
			
			pool = new ObjectPool(TweensyTimeline);
			frame = new Sprite();
			checkInTimer = new Timer(2000);
			map = new Dictionary(true);
			keyframes = new Dictionary(true);
			filters = new Dictionary(true);
			
			return true;
		}

		/**

		/**

		/**

		public function animate(instance : Object, target : EaseTarget, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0, updateObj : Object = null, onComplete : Function = null, onCompleteParams : Array = null) : TweensyTimeline {

		/**

		/**

		/**

		/**

		/**

		public function skewXYTo(instance : DisplayObject, xDegree : Number, yDegree : Number, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0) : TweensyTimeline {

		/**

		/**

		/**

		public function childrenOf(container : DisplayObjectContainer, target : EaseTarget, stagger : Number = 0.1, duration : Number = 0.5, ease : Function = null, updateObj : Object = null) : Array {

		public function stagger(items : Array, target : EaseTarget, stagger : Number = 0.1, duration : Number = 0.5, ease : Function = null, updateObj : Object = null) : Array {

		/**

		public function getFilters(instance : DisplayObject) : Array {

		/**

		/**

		/**

		/**

		public function keyframeTo(instance : Object, index : int, duration : Number = 0.5, ease : Function = null, delayStart : Number = 0) : TweensyTimeline {

		public function addKeyframe(instance : Object, ...props : Array) : void {
			
			if(!(instance in keyframes)) keyframes[instance] = [];

		public function removeKeyframe(instance : Object, index : int) : int {

		public function getKeyframe(instance : Object, index : int) : Object {

		/**

		/**
				pool.checkIn(item);
				item.clear();
			}

		internal function addInstance(instance : Object, item : TweensyTimeline) : void {

		internal function removeInstance(instance : Object, item : TweensyTimeline) : void {

		/**

		/**

		/**

		/**

		/**

		/**

		/**

		private function setup(duration : Number, ease : Function, delayStart : Number, onComplete : Function = null, onCompleteParams : Array = null) : TweensyTimeline {

		private function startUpdate() : void {
			checkInTimer.start();

		private function stopUpdate() : void {
			
			checkInTimer.stop();

		private function update(e : Event) : void {

		/**

		/**

		public function toString() : String {