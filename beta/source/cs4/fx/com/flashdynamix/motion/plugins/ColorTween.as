﻿package com.flashdynamix.motion.plugins {	import flash.display.DisplayObject;	import flash.geom.ColorTransform;		/**	 * This plugin will be used when tweening ColorTransforms.	 */	public class ColorTween extends AbstractTween {		private var _current : ColorTransform;		protected var _to : ColorTransform;		protected var _from : ColorTransform;		/** @private */		internal var displayObject : DisplayObject;		public function ColorTween() {			_to = new ColorTransform();			_from = new ColorTransform();		}		override public function construct(...params : Array) : void {			super.construct();						_current = params[0];			displayObject = params[1];						apply();		}		override protected function set to(item : Object) : void {			_to = item as ColorTransform;		}		override protected function get to() : Object {			return _to;		}		override protected function set from(item : Object) : void {			_from = item as ColorTransform;		}		override protected function get from() : Object {			return _from;		}		override public function get current() : Object {			return _current;		}		override public function get instance() : Object {			return (displayObject) ? displayObject : current;		}		override public function removeOverlap(item : AbstractTween) : void {			if(item is ColorTween && (current == item.current || (ColorTween(item).displayObject != null && displayObject == ColorTween(item).displayObject)) ) {				for(var propName:String in item.propNames) remove(propName);			}		}		override public function toTarget(to : Object) : void {			if(to is ColorTransform) {				var ct : ColorTransform = to as ColorTransform;							add("redOffset", ct.redOffset, false);				add("blueOffset", ct.blueOffset, false);				add("greenOffset", ct.greenOffset, false);				add("alphaOffset", ct.alphaOffset, false);							add("redMultiplier", ct.redMultiplier, false);				add("blueMultiplier", ct.blueMultiplier, false);				add("greenMultiplier", ct.greenMultiplier, false);				add("alphaMultiplier", ct.alphaMultiplier, false);			} else {				super.toTarget(to);			}		}		override public function fromTarget(from : Object) : void {			if(from is ColorTransform) {				var ct : ColorTransform = from as ColorTransform;							add("redOffset", ct.redOffset, true);				add("blueOffset", ct.blueOffset, true);				add("greenOffset", ct.greenOffset, true);				add("alphaOffset", ct.alphaOffset, true);							add("redMultiplier", ct.redMultiplier, true);				add("blueMultiplier", ct.blueMultiplier, true);				add("greenMultiplier", ct.greenMultiplier, true);				add("alphaMultiplier", ct.alphaMultiplier, true);			} else {				super.toTarget(from);			}		}		override public function update(position : Number) : void {			var q : Number = 1 - position;			var propName : String;						if(!inited && _propCount > 0) {				if(displayObject) {					_current = displayObject.transform.colorTransform;					_from = displayObject.transform.colorTransform;				} else {					for(propName in propNames) {						_from[propName] = _current[propName];					}				}				inited = true;			}						for(propName in propNames) {								if(propName == "redOffset") {					_current.redOffset = _from.redOffset * q + _to.redOffset * position;				} else if(propName == "redMultiplier") {					_current.redMultiplier = _from.redMultiplier * q + _to.redMultiplier * position;				} else if(propName == "greenOffset") {					_current.greenOffset = _from.greenOffset * q + _to.greenOffset * position;				} else if(propName == "greenMultiplier") {					_current.greenMultiplier = _from.greenMultiplier * q + _to.greenMultiplier * position;				} else if(propName == "blueOffset") {					_current.blueOffset = _from.blueOffset * q + _to.blueOffset * position;				} else if(propName == "blueMultiplier") {					_current.blueMultiplier = _from.blueMultiplier * q + _to.blueMultiplier * position;				} else if(propName == "alphaOffset") {					_current.alphaOffset = _from.alphaOffset * q + _to.alphaOffset * position;				} else if(propName == "alphaMultiplier") {					_current.alphaMultiplier = _from.alphaMultiplier * q + _to.alphaMultiplier * position;				} else {					_current[propName] = _from[propName] * q + _to[propName] * position;				}								if(timeline.snapToClosest) _current[propName] = Math.round(_current[propName]);			}						apply();		}		override public function apply() : void {			if(displayObject == null) return;						displayObject.transform.colorTransform = _current;		}		override public function dispose() : void {			_to = null;			_from = null;			displayObject = null;			_current = null;						super.dispose();		}	}}