package com.flashdynamix.motion.plugins {
	import flash.display.DisplayObject;
	import flash.geom.Matrix;

	import com.flashdynamix.motion.plugins.AbstractTween;	

	/**
	 * This plugin will be used when tweening Matrices.
	 */
	public class MatrixTween extends AbstractTween {

		private var _current : Matrix;
		protected var _to : Matrix;
		protected var _from : Matrix;
		protected var _update : DisplayObject;

		public function MatrixTween() {
			_to = new Matrix();
			_from = new Matrix();
		}

		override public function construct(...params : Array) : void {
			super.construct();
			
			_current = params[0];
			_update = params[1];
			
			apply();
		}

		override protected function set to(item : Object) : void {
			_to = item as Matrix;
		}

		override protected function get to() : Object {
			return _to;
		}

		override protected function set from(item : Object) : void {
			_from = item as Matrix;
		}

		override protected function get from() : Object {
			return _from;
		}
		
		override public function get key() : Object {
			if(_update != null) return _update;
			
			return _current;
		}

		override protected function get current() : Object {
			return _current;
		}

		override public function toTarget(to : Object) : void {
			if(to is Matrix) {
				var mtx : Matrix = to as Matrix;
			
				add("tx", mtx.tx, false);
				add("ty", mtx.ty, false);
				add("a", mtx.a, false);
				add("b", mtx.b, false);
				add("c", mtx.c, false);
				add("d", mtx.d, false);
			} else {
				super.toTarget(to);
			}
		}

		override public function fromTarget(from : Object) : void {
			if(from is Matrix) {
				var mtx : Matrix = from as Matrix;
			
				add("tx", mtx.tx, true);
				add("ty", mtx.ty, true);
				add("a", mtx.a, true);
				add("b", mtx.b, true);
				add("c", mtx.c, true);
				add("d", mtx.d, true);
			} else {
				super.fromTarget(from);
			}
		}

		override public function update(position : Number) : void {
			var q : Number = 1 - position;
			
			if(!inited && _propCount > 0) {
				for(propName in propNames) _from[propName] = _current[propName];
				inited = true;
			}
			
			for(var propName:String in propNames) {
				
				if(propName == "tx") {
					_current.tx = _from.tx * q + _to.tx * position;
				} else if(propName == "ty") {
					_current.ty = _from.ty * q + _to.ty * position;
				} else if(propName == "a") {
					_current.a = _from.a * q + _to.a * position;
				} else if(propName == "b") {
					_current.b = _from.b * q + _to.b * position;
				} else if(propName == "c") {
					_current.c = _from.c * q + _to.c * position;
				} else if(propName == "d") {
					_current.d = _from.d * q + _to.d * position;
				} else {
					_current[propName] = _from[propName] * q + _to[propName] * position;
				}
				
				if(timeline.snapToClosest) _current[propName] = Math.round(_current[propName]);
			}
			
			apply();
		}

		override public function apply() : void {
			if(_update == null) return;
			
			_update.transform.matrix = _current;
		}
		
		override public function dispose() : void {
			_to = null;
			_from = null;
			_current = null;
			_update = null;
			
			super.dispose();
		}
	}
}