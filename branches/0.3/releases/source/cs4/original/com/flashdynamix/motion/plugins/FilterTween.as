﻿package com.flashdynamix.motion.plugins {	import flash.display.DisplayObject;	import flash.filters.BitmapFilter;	import flash.filters.ColorMatrixFilter;	import flash.utils.Dictionary;		/**	 * This plugin will be used when tweening BitmapFilters.	 */	public class FilterTween extends ObjectTween {		public static var filterDictionary : Dictionary = new Dictionary(true);		private var _current : Object;		protected var _filter : BitmapFilter;		/** @private */		internal var displayObject : DisplayObject;		protected var filterList : Array;		public function FilterTween() {		}		override public function construct(...params : Array) : void {			super.construct();						_filter = params[0];			displayObject = params[1];						if(_filter is ColorMatrixFilter) {				_current = ColorMatrixFilter(_filter).matrix;			} else {				_current = _filter;			}						filterList = filterDictionary[displayObject];						if(filterList == null || filterList.length != displayObject.filters.length) {				filterList = filterDictionary[displayObject] = displayObject.filters;			}						if(filterList.indexOf(_filter) == -1) filterList.push(_filter);						apply();		}		override public function removeOverlap(item : AbstractTween) : void {			if(item is FilterTween && (current == item.current || (FilterTween(item).displayObject != null && displayObject == FilterTween(item).displayObject)) ) {				for(var propName:String in item.propNames) remove(propName);			}		}		override public function get current() : Object {			return _current;		}				override public function get instance() : Object {			return (displayObject) ? displayObject : current;		}		override public function update(position : Number) : void {			var q : Number = 1 - position;			var propName:String;						if(!inited && _propCount > 0) {				for(propName in propNames) _from[propName] = _current[propName];				inited = true;			}						for(propName in propNames) {				_current[propName] = _from[propName] * q + _to[propName] * position;								if(timeline.snapToClosest) _current[propName] = Math.round(_current[propName]);			}						apply();		}		override public function apply() : void {			if(displayObject == null) return;						if(_filter is ColorMatrixFilter) ColorMatrixFilter(_filter).matrix = _current as Array;						displayObject.filters = filterList;		}		override public function dispose() : void {			_filter = null;			_current = null;			displayObject = null;			filterList = null;						super.dispose();		}	}}