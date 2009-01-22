﻿package com.flashdynamix.motion.plugins {	import flash.display.DisplayObject;	import flash.geom.Matrix;	import com.flashdynamix.motion.plugins.AbstractTween;		/**	 * This plugin will be used when tweening Matrices.	 */	public class MatrixTween extends AbstractTween {				public static var key : Class = Matrix;				private var _current : Matrix;		protected var _to : Matrix;		protected var _from : Matrix;		/** @private */		internal var displayObject : DisplayObject;		public function MatrixTween() {			_to = new Matrix();			_from = new Matrix();		}		override public function construct(currentObj : Object, updateObj : Object) : void {			inited = false;						_current = currentObj as Matrix;			displayObject = updateObj as DisplayObject;		}		override protected function set to(item : Object) : void {			_to = item as Matrix;		}		override protected function get to() : Object {			return _to;		}		override protected function set from(item : Object) : void {			_from = item as Matrix;		}		override protected function get from() : Object {			return _from;		}		override public function get current() : Object {			return _current;		}		override public function get instance() : Object {			return (displayObject) ? displayObject : current;		}		override protected function match(item : AbstractTween) : Boolean {			return (item is MatrixTween && (current == item.current || ((item as MatrixTween).displayObject == null || (item as MatrixTween).displayObject == displayObject)));		}		override public function toTarget(toObj : Object) : void {			if(to is Matrix) {				var mtx : Matrix = toObj as Matrix;							addTo("tx", mtx.tx);				addTo("ty", mtx.ty);				addTo("a", mtx.a);				addTo("b", mtx.b);				addTo("c", mtx.c);				addTo("d", mtx.d);			} else {				super.toTarget(toObj);			}		}		override public function fromTarget(fromObj : Object) : void {			if(from is Matrix) {				var mtx : Matrix = fromObj as Matrix;							addFrom("tx", mtx.tx);				addFrom("ty", mtx.ty);				addFrom("a", mtx.a);				addFrom("b", mtx.b);				addFrom("c", mtx.c);				addFrom("d", mtx.d);			} else {				super.fromTarget(fromObj);			}		}		override public function update(position : Number) : void {			var q : Number = 1 - position, propName : String, i : int = 0;						if(!inited && _propCount > 0) {				if(displayObject) {					_current = displayObject.transform.matrix;					_from = displayObject.transform.matrix;				} else {					for(i = 0;i < _propCount; i++) {						propName = propNames[i];						_from[propName] = _current[propName];					}				}				inited = true;			}						for(i = 0;i < _propCount; i++) {				propName = propNames[i];								if(propName == "tx") {					_current.tx = _from.tx * q + _to.tx * position;				} else if(propName == "ty") {					_current.ty = _from.ty * q + _to.ty * position;				} else if(propName == "a") {					_current.a = _from.a * q + _to.a * position;				} else if(propName == "b") {					_current.b = _from.b * q + _to.b * position;				} else if(propName == "c") {					_current.c = _from.c * q + _to.c * position;				} else if(propName == "d") {					_current.d = _from.d * q + _to.d * position;				} else {					_current[propName] = _from[propName] * q + _to[propName] * position;				}								if(timeline.snapToClosest) _current[propName] = Math.round(_current[propName]);			}						apply();		}		override protected function apply() : void {			if(displayObject == null) return;						displayObject.transform.matrix = _current;		}		override public function dispose() : void {			_to = null;			_from = null;			_current = null;			displayObject = null;						super.dispose();		}	}}