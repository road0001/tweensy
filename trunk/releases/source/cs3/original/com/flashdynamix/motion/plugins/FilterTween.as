package com.flashdynamix.motion.plugins {
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.utils.Dictionary;	

	/**
	 * This plugin will be used when tweening BitmapFilters.
	 */
	public class FilterTween extends ObjectTween {

		private static var filterDictionary : Dictionary = new Dictionary(true);
		
		private var _current : Object;
		protected var _filter : BitmapFilter;
		protected var _update : DisplayObject;
		protected var filterList : Array;

		public function FilterTween() {
		}

		override public function construct(...params : Array) : void {
			super.construct();
			
			_filter = params[0];
			_update = params[1];
			
			if(_filter is ColorMatrixFilter) {
				_current = ColorMatrixFilter(_filter).matrix;
			} else {
				_current = _filter;
			}
			
			filterList = filterDictionary[_update];
			
			if(filterList == null || filterList.length != _update.filters.length) {
				filterList = filterDictionary[_update] = _update.filters;
			}
			
			if(filterList.indexOf(_filter) == -1) filterList.push(_filter);
			
			apply();
		}

		override public function get key() : Object {
			if(_update != null) return _update;
			
			return _filter;
		}

		override protected function get current() : Object {
			return _current;
		}

		override public function update(position : Number) : void {
			var q : Number = 1 - position;
			
			if(!inited && _propCount > 0) {
				for(propName in propNames) _from[propName] = _current[propName];
				inited = true;
			}
			
			for(var propName:String in propNames) {
				_current[propName] = _from[propName] * q + _to[propName] * position;
				
				if(timeline.snapToClosest) _current[propName] = Math.round(_current[propName]);
			}
			
			apply();
		}

		override public function apply() : void {
			if(_update == null) return;
			
			if(_filter is ColorMatrixFilter) ColorMatrixFilter(_filter).matrix = _current as Array;
			
			_update.filters = filterList;
		}

		override public function dispose() : void {
			_filter = null;
			_current = null;
			_update = null;
			filterList = null;
			
			super.dispose();
		}
	}
}