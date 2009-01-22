package com.flashdynamix.motion.layers {	import flash.display.BitmapData;	
	/**	 * @author FlashDynamix	 */	public class SuperBitmapData extends BitmapData {
		public var sourceBitmapData : BitmapData;
		public function SuperBitmapData(source : BitmapData) {						sourceBitmapData = source.clone();		}	}}