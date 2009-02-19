package com.flashdynamix.motion.vectors {
	import flash.display.Graphics;
	import flash.display.GraphicsPath;
	import flash.geom.Rectangle;	

	public class Path implements IVector {
		public var info : GraphicsPath;
		public function Path() {
			info = new GraphicsPath();
		}
		public function draw(vector : Graphics, rect : Rectangle) : void {
			vector.drawPath(info.commands, info.data, info.winding);
		}
	}
}
