package com.flashdynamix.motion.plugins {
	import flash.display.DisplayObject;		

	 * This plugin will be used when tweening DisplayObjects.
	 */
	public class DisplayTween extends AbstractTween {

		protected var _to : DisplayTweenObject;
		protected var _from : DisplayTweenObject;

			_to = new DisplayTweenObject();
			_from = new DisplayTweenObject();
		}

			super.construct();
			
			_current = params[0];
		}

			_to = item as DisplayTweenObject;
		}

			return _to;
		}

			_from = item as DisplayTweenObject;
		}

			return _from;
		}

			return _current;
		}

			return _current;
		}

			var q : Number = 1 - position;
			var propName : String;
			
			if(!inited && _propCount > 0) {
				for(propName in propNames) _from[propName] = _current[propName];
				inited = true;
			}
			
			for(propName in propNames) {

				if(propName == "x") {
					_current.x = _from.x * q + _to.x * position;
				} else if(propName == "y") {
					_current.y = _from.y * q + _to.y * position;
				} else if(propName == "z") {
					_current.z = _from.z * q + _to.z * position;
				}else if(propName == "width") {
					_current.width = _from.width * q + _to.width * position;
				} else if(propName == "height") {
					_current.height = _from.height * q + _to.height * position;
				} else if(propName == "scaleX") {
					_current.scaleX = _from.scaleX * q + _to.scaleX * position;
				} else if(propName == "scaleY") {
					_current.scaleY = _from.scaleY * q + _to.scaleY * position;
				} else if(propName == "scaleZ") {
					_current.scaleZ = _from.scaleZ * q + _to.scaleZ * position;
				} else if(propName == "alpha") {
					_current.alpha = _from.alpha * q + _to.alpha * position;
				} else if(propName == "rotation" ) {
					_current.rotation = _from.rotation * q + _to.rotation * position;
				} else if(propName == "rotationX" ) {
					_current.rotationX = _from.rotationX * q + _to.rotationX * position;
				} else if(propName == "rotationY" ) {
					_current.rotationY = _from.rotationY * q + _to.rotationY * position;
				} else if(propName == "rotationZ" ) {
					_current.rotationZ = _from.rotationZ * q + _to.rotationZ * position;
				} else {
					_current[propName] = _from[propName] * q + _to[propName] * position;
				}
				
				if(timeline.snapToClosest) _current[propName] = Math.round(_current[propName]);
			} 
		}

			var current : Number = _current[propName];
			var target : Number = super.translate(propName, value);
			
			if(propName == "rotation" && timeline.useSmartRotate) {
				target = smartRotate(current, target);
			}
			
			return target;
		}

			_to = null;
			_from = null;
			_current = null;
			
			super.dispose();
		}
	}
}

	public var x : Number;
	public var y : Number;
	public var z : Number;
	public var alpha : Number;
	public var width : Number;
	public var height : Number;
	public var scaleX : Number;
	public var scaleY : Number;
	public var scaleZ : Number;
	public var rotation : Number;
	public var rotationX : Number;
	public var rotationY : Number;
	public var rotationZ : Number;
}