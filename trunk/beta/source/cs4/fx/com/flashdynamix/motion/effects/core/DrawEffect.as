package com.flashdynamix.motion.effects.core {
	import flash.display.*;
	import flash.geom.*;
	
	import com.flashdynamix.motion.effects.IEffect;	

	/**
	 * Draws an IBitmapDrawable onto a BitmapData with options to apply a Matrix transformation, 
	 * ColorTransform, BlendMode or clipping Rectangle onto the drawn BitmapData.
	 */
	public class DrawEffect implements IEffect {

		/**
		 * The source IBitmapDrawable to be drawn onto the BitmapData on render.
		 */
		/**
		 * The Matrix transformation to be used on render of the IBitmapDrawable to the BitmapData.
		 */
		/**
		 * The ColorTransform to be used on render of the IBitmapDrawable to the BitmapData.
		 */
		/**
		 * The BlendMode to be used on render of the IBitmapDrawable to the BitmapData.
		 */
		/**
		 * The clipping Rectangle to be used on render of the IBitmapDrawable to the BitmapData.
		 */
		/**
		 * Whether the BitmapData will be drawn with pixel smoothing.
		 */

		/**
		 * @param source The source IBitmapDrawable to be drawn onto the BitmapData on render.
		 * @param matrix The Matrix transformation to be used on render of the IBitmapDrawable to the BitmapData.
		 * @param clipRect The clipping Rectangle to be used on render of the IBitmapDrawable to the BitmapData.
		 * @param colorTransform The ColorTransform to be used on render of the IBitmapDrawable to the BitmapData.
		 * @param blendMode The BlendMode to be used on render of the IBitmapDrawable to the BitmapData.
		 * @param smoothing Whether the BitmapData will be drawn with pixel smoothing.
		 */
			this.source = source;
			this.matrix = (matrix == null) ? new Matrix() : matrix;
			this.colorTransform = (colorTransform == null) ? new ColorTransform() : colorTransform;
			this.blendMode = blendMode;
			this.rect = rect;
			this.smoothing = smoothing;
		}

		/**
		 * Renders the DrawEffect on to the specified BitmapData.
		 */
			bmd.draw(source, matrix, colorTransform, blendMode, rect, smoothing);
		}
	}
}