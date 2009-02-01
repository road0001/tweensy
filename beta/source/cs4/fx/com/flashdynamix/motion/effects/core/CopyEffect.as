package com.flashdynamix.motion.effects.core {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.geom.*;
	import com.flashdynamix.motion.effects.IEffect;	
	/**
	 * Copys a BitmapData onto another BitmapData, this method for drawing is an extremely efficient way of updating the 
	 * display in Flash, although CopyEffect has limitations, which is part of the reason why it's so much faster. 
	 * CopyEffect can only use a x,y position transform unlike the DrawEffect which can accept a matrix and color transformations. 
	 * This means that scale, rotation, skew, alpha and color transformations can not be done with a CopyEffect.
	 */
	public class CopyEffect implements IEffect {
		/**
		 * The source BitmapData to copy onto the destination BitmapData.
		 */
		public var sourceBmd : BitmapData;
		public var source : IBitmapDrawable;
		public var animating : Boolean = false;
		public var mtx : Matrix;
		/**
		 * The clipping rectangle to use when drawing the source BitmapData onto the destination BitmapData.
		 */
		public var sourceRect : Rectangle;
		/**
		 * The destination point to draw the sourceRect from.
		 */
		public var transPt : Point;
		/**
		 * The alphaBmd ALPHA channel to use when copying the BitmapData, if one is desired other than the ALPHA.
		 * channel in the sourceBmd 
		 */
		public var alphaBmd : BitmapData;
		/**
		 * The point to draw the ALPHA channel from using the alphaBmd.
		 */
		public var alphaPt : Point;
		/**
		 * Whether both ALPHA channels are merged between the sourceBmd and the alphaBmd.
		 */
		public var mergeAlpha : Boolean;
		private var _alpha : Number = 1;
		/**
		 * @param sourceBmd The source BitmapData to copy onto the destination BitmapData.
		 * @param sourceRect The clipping rectangle to use when drawing the source BitmapData onto the destination BitmapData.
		 * @param point The destination point to draw the sourceRect from.
		 * @param alphaBmd The alphaBmd ALPHA channel to use when copying the BitmapData if another is desired other than the ALPHA
		 * channel in the sourceBmd.
		 * @param alphaPt The point to draw the ALPHA channel from using the alphaBmd.
		 * @param mergeAlpha Whether both ALPHA channels are merged between the sourceBmd and the alphaBmd.
		 */
		public function CopyEffect(source : IBitmapDrawable, x : Number = 0, y : Number = 0, alpha : Number = 1, mergeAlpha : Boolean = false, rect : Rectangle = null) {
			this.source = source;
			
			if(source is BitmapData) {
				sourceBmd = source as BitmapData;
				sourceRect = sourceBmd.rect;
			} else {
				var sourceDisplay : DisplayObject = source as DisplayObject;
				
				sourceRect = (rect == null) ? new Rectangle(0, 0, sourceDisplay.width, sourceDisplay.height) : rect;
				sourceBmd = new BitmapData(sourceRect.width, sourceRect.height, true, 0x00FFFFFF);
				sourceBmd.draw(source);
			}
			
			alphaBmd = new BitmapData(sourceBmd.width, sourceBmd.height, true, 0xFFFFFFFF);
			
			this.transPt = new Point(x, y);
			this.mergeAlpha = mergeAlpha;
			this.alpha = alpha;
		}
		public function set x(pixels : Number) : void {
			transPt.x = pixels;
		}
		public function get x() : Number {
			return transPt.x;
		}
		public function set y(pixels : Number) : void {
			transPt.y = pixels;
		}
		public function get y() : Number {
			return transPt.y;
		}
		public function set alpha(amount : Number) : void {
			_alpha = amount;
			
			var A : uint = amount * 0xFF;
			var R : uint = 0xFF;
			var G : uint = 0xFF;
			var B : uint = 0xFF;
			
			var color : uint = A << 24 | R << 16 | G << 8 | B;
			
			alphaBmd.fillRect(alphaBmd.rect, color);
		}
		public function get alpha() : Number {
			return _alpha;
		}
		/**
		 * Renders the CopyEffect to the specified BitmapData.
		 */
		public function render(bmd : BitmapData) : void {
			if(animating) {
				sourceBmd.fillRect(sourceRect, 0x00FFFFFF);
				sourceBmd.draw(source, mtx);
			}
			
			bmd.copyPixels(sourceBmd, sourceRect, transPt, alphaBmd, alphaPt, mergeAlpha);
		}
	}
}
