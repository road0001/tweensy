package com.flashdynamix.motion.data {

	/**	 * @author FlashDynamix	 */	public class TweenTarget {

		public static const TO : int = 0;		public static const FROM : int = 1;		public static const FROM_TO : int = 2;

		public var from : Object;		public var to : Object;

		public function TweenTarget(toObj : Object = null, fromObj : Object = null) : void {			this.to = toObj;			this.from = fromObj;		}

		public function get type() : int {			var _id : int;						if(to && !from) {				_id = TO;			} else if(!to && from) {				_id = FROM;			} else {				_id = FROM_TO;			}						return _id;		}	}}