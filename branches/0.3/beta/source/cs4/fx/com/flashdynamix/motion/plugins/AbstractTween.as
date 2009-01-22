package com.flashdynamix.motion.plugins {
	import com.flashdynamix.motion.TweensyTimeline;	

	/**
	 * This abstract tween class provides necessary functionality to the typed plugin
	 * tweens.
	 */
	public class AbstractTween {

		public var inited : Boolean = false;
		public var timeline : TweensyTimeline;
		/** @private */
		internal var propNames : Array = [];
		protected var _propCount : int = 0;

		public function AbstractTween() {
		}

		public function construct(currentObj : Object, updateObj : Object) : void {
			inited = false;
		}

		protected function set to(item : Object) : void {
		}

		protected function get to() : Object {
			return null;
		}

		protected function set from(item : Object) : void {
		}

		protected function get from() : Object {
			return null;
		}

		public function get current() : Object {
			return null;
		}

		public function get instance() : Object {
			return current;
		}

		protected function get properties() : Number {
			return _propCount;
		}

		public function get hasAnimations() : Boolean {
			return (_propCount > 0);
		}

		public function toTarget(toObj : Object) : void {
			for(var propName:String in toObj) {
				addTo(propName, toObj[propName]);
			}
			
			apply();
		}

		public function fromTarget(fromObj : Object) : void {
			for(var propName:String in fromObj) {
				addFrom(propName, fromObj[propName]);
			}
			
			apply();
		}

		public function fromToTarget(fromObj : Object, toObj : Object) : void {
			for(var propName:String in fromObj) {
				addFromTo(propName, fromObj[propName], toObj[propName]);
			}
			
			apply();
		}

		public function updateTo(position : Number, item : Object) : void {
			for(var propName:String in item) {
				if(has(propName)) {
					var target : Number = item[propName];
					var change : Number = (target - current[propName]) * (1 / (1 - position));
					
					from[propName] = target - change;
					to[propName] = target;
				}
			}
		}

		public function removeOverlap(item : AbstractTween) : void {
			if(match(item)) {
				
				var i : int;
				var propName : String;
				
				for(i = _propCount - 1;i >= 0; i--) {
					propName = propNames[i];
					remove(propName);
				}
			}
		}

		public function stop(...props : Array) : void {
			
			if(props.length == 0) {
				stopAll();
			} else {
				var len : int = props.length;
				var i : int;
			
				for(i = 0;i < len; i++) remove(props[i]);
			}
		}

		public function stopAll() : void {
			propNames.length = 0;
			
			_propCount = 0;
		}

		public function update(position : Number) : void {
		}

		public function swapToFrom() : void {
			var toCopy : Object = to;
			
			to = from;
			from = toCopy;
		}

		public function addTo(propName : String, target : *) : void {
			to[propName] = translate(propName, target);
			
			propNames[_propCount] = propName;
			_propCount++;
		}

		public function addFrom(propName : String, target : *) : void {
			to[propName] = current[propName];
			current[propName] = translate(propName, target);
			
			propNames[_propCount] = propName;
			_propCount++;
		}

		public function addFromTo(propName : String, fromTarget : *, toTarget : *) : void {
			to[propName] = translate(propName, toTarget);
			current[propName] = translate(propName, fromTarget);
			
			propNames[_propCount] = propName;
			_propCount++;
		}

		public function remove(propName : String) : void {
			var index : int = propNames.indexOf(propName);
			
			if(index >= 0) {
				propNames.splice(index, 1);
				_propCount--;
			}
		}

		public function clear() : void {
			stopAll();
			timeline = null;
		}

		protected function has(propName : String) : Boolean {
			return propNames.indexOf(propName) > 0;
		}

		protected function match(item : AbstractTween) : Boolean {
			return item.instance == instance;
		}

		protected function apply() : void {
		}

		protected function translate(propName : String, value : *) : Number {
			
			var current : Number = current[propName];
			var target : Number;
			
			if(value is String) {
				var values : Array = String(value).split(",");
				if(values.length == 1) {
					target = current + parseFloat(value);
				} else {
					var start : Number = parseFloat(values[0]), end : Number = parseFloat(values[1]);
					target = current + start + (Math.random() * (end - start));
				}
			} else {
				target = value;
			}
			
			return target;
		}

		protected function smartRotate(currentAngle : Number, targetAngle : Number) : Number {
			var pi : Number = 180;
			var pi2 : Number = pi * 2;
				
			currentAngle = (Math.abs(currentAngle) > pi2) ? (currentAngle < 0) ? currentAngle % pi2 + pi2 : currentAngle % pi2 : currentAngle;

			targetAngle = (Math.abs(targetAngle) > pi2) ? (targetAngle < 0) ? targetAngle % pi2 + pi2 : targetAngle % pi2 : targetAngle;
			targetAngle += (Math.abs(targetAngle - currentAngle) < pi) ? 0 : (targetAngle - currentAngle > 0) ? -pi2 : pi2;
			
			return targetAngle;
		}

		public function dispose() : void {
			propNames = null;
			timeline = null;
		}
	}
}