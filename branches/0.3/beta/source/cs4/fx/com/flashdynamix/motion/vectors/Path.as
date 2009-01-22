package com.flashdynamix.motion.vectors {
	import flash.display.Graphics;
	import flash.display.GraphicsPath;
	import flash.geom.Rectangle;	

	public class Path extends GraphicsPath implements IVector {

		public function Path() {
		}

		public function draw(vector : Graphics, rect : Rectangle) : void {
			vector.drawPath(commands, data, winding);
		}
	}
}
