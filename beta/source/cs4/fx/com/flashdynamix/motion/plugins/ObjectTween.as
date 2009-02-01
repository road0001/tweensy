package com.flashdynamix.motion.plugins {
	import com.flashdynamix.motion.TweensyTimeline;	

	/**
	 * This plugin is the default plugin and will be used when tweening Objects which don't have a custom plugin.
	 */
	public class ObjectTween extends AbstractTween {

		public static var key : Class = Object;

		private var _current : Object;
		protected var _to : Object;
		protected var _from : Object;
		internal var updateObject : Object;

		public function ObjectTween() {
			_to = {};
			_from = {};
		}

		override public function construct(instance : Object, applyToInstance : Object) : void {
			inited = false;
			_current = instance;
			updateObject = applyToInstance;
		}

		override protected function set to(item : Object) : void {
			_to = item;
		}

		override protected function get to() : Object {
			return _to;
		}

		override protected function set from(item : Object) : void {
			_from = item;
		}

		override protected function get from() : Object {
			return _from;
		}

		override public function get current() : Object {
			return _current;
		}

		override public function get instance() : Object {
			return _current;
		}

		override public function toTarget(toObj : Object) : void {
			if(_current.hasOwnProperty("length")) {
				
				var item : Object;
				for(var i:String in current) {
					item = current[i];
					
					if(item is Number || item is String) {
						addTo(i, toObj[i]);
					} else {
						timeline.to(current[i], toObj, updateObject);
					}
				}
			} else {
				super.toTarget(toObj);
			}
		}

		override public function fromTarget(fromObj : Object) : void {
			if(_current.hasOwnProperty("length")) {
				
				var item : Object;
				for(var i:String in current) {
					
					item = current[i];
					
					if(item is Number || item is String) {
						addFrom(i, fromObj[i]);
					} else {
						timeline.from(current[i], fromObj, updateObject);
					}
				}
			
				apply();
			} else {
				super.fromTarget(fromObj);
			}
		}

		override public function fromToTarget(fromObj : Object, toObj : Object) : void {
			if(_current.hasOwnProperty("length")) {
				
				var item : Object;
				for(var i:String in current) {
					
					item = current[i];
					
					if(item is Number || item is String) {
						addFromTo(i, fromObj[i], toObj[i]);
					} else {
						timeline.fromTo(current[i], fromObj, toObj, updateObject);
					}
				}
			
				apply();
			} else {
				super.fromToTarget(fromObj, toObj);
			}
		}

		override public function update(position : Number) : void {
			var q : Number = 1 - position, propName : String, i : int = 0;
			
			if(!inited && _propCount > 0) {
				for(i = 0;i < _propCount; i++) {
					propName = propNames[i];
					_from[propName] = _current[propName];
				}
				inited = true;
			}
			
			for(i = 0;i < _propCount; i++) {
				propName = propNames[i];
				
				_current[propName] = from[propName] * q + to[propName] * position;
				
				if(timeline.snapClosest) _current[propName] = Math.round(_current[propName]);
			}
		}

		override public function dispose() : void {
			_to = null;
			_from = null;
			_current = null;
			
			super.dispose();
		}
	}
}
