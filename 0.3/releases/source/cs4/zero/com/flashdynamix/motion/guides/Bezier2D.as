package com.flashdynamix.motion.guides {
	import flash.geom.Point;	

	/**
	 * Allows for Objects to follow a 2D bezier path. This path is made from a list of
	 * points these points are either control points or through points for the bezier.
	 */
	public class Bezier2D {

		/**
		 * The Object you wish to be updated with x,y and rotation values.
		 */
		public var item : Object;
		/**
		 * A list of Points defining nodes of the bezier path.
		 */
		public var pts : Array;
		/**
		 * Whether the Object will directionally rotate.
		 */
		public var autoRotate : Boolean;
		/**
		 * Whether the pts in the bezier path will be used as control points or through points.
		 */
		public var through : Boolean;
		/**
		 * Whether the pts in the BezierPath can be repositioned.
		 */
		public var movingPts : Boolean;

		private var curve : Array;
		private var _position : Number = 0;
		private var radsDegree : Number = 180 / Math.PI;

		/**
		 * @param item The Object you wish to be updated with x,y and rotation values.
		 * @param through Whether the pts in the bezier path will be used as control points or through points.
		 * @param autoRotate Whether the Object will directionally rotate.
		 * @param movingPts Whether the pts in the BezierPath can be repositioned.
		 */
		public function Bezier2D(item : Object, through : Boolean = false, autoRotate : Boolean = false, movingPts : Boolean = false, ...pts : Array) {
			this.item = item;
			this.through = through;
			this.autoRotate = autoRotate;
			this.movingPts = movingPts;
			this.pts = pts;
		}

		/**
		 * @param index The position to return a Point from.
		 * @return Returns a Point at the specified index.
		 */
		public function index(index : int) : Point {
			return pts[index];
		}

		/**
		 * Pushes a Point into the Bezier path.
		 * @param pt The Point which will be added to the end of the bezier path.
		 */
		public function push(pt : Point) : void {
			pts.push(pt);
			update();
		}

		/**
		 * Adds a Point into the Bezier path at the specified index.
		 * @param index The index for which to insert the Point.
		 * @param pt The Point to insert at the index.
		 */
		public function addAt(index : int, pt : Point) : void {
			pts.splice(index, 0, pt);
			update();
		}

		/**
		 * Removes a Point from the Bezier path.
		 * @param pt The Point you would like to remove from the bezier path.
		 */
		public function remove(pt : Point) : void {
			var index : int = pts.indexOf(pt);
			if(index != -1) removeAt(index, 1);
		}

		/**
		 * Removes one or more Point(s) at the specified index and count from the Bezier path. 
		 * @param index The index to start removing nodes from the Bezier path.
		 * @param count the Number of nodes to remove from the Bezier path. If this is 0 no nodes are removed.
		 * 
		 */
		public function removeAt(index : int, count : int = 1) : void {
			pts.splice(index, count);
			update();
		}

		/**
		 * @return The number of nodes in the Bezier path.
		 */
		public function get length() : int {
			return pts.length;
		}

		/**
		 * Sets the position on the Object along the bezier path from 0-1.
		 * @param num The position from 0-1.
		 */
		public function set position(num : Number) : void {
			_position = num;
			
			if(movingPts) update();
			
			var max : int = curve.length - 3;
			var steps : int = (curve.length - 1) / 2;
			var idx : Number = num * steps;
			var inc : Number = idx - int(idx);
			var start : int = int(idx) * 2;
			if(start > max) {
				inc = 1;
				start = max;
			}
			
			var sPt : Point = curve[start];
			var cPt : Point = curve[start + 1];
			var ePt : Point = curve[start + 2];
		
			var pt : Point = new Point(quadratic(inc, sPt.x, cPt.x, ePt.x), quadratic(inc, sPt.y, cPt.y, ePt.y));
			item.x = pt.x;
			item.y = pt.y;
		
			if(autoRotate) item.rotation = angle(inc, sPt, cPt, ePt) * radsDegree;
		}

		/**
		 * @return The current position of the Object along the Bezier path from 0-1.
		 */
		public function get position() : Number {
			return _position;
		}

		private function update() : void {
			if(pts.length <= 2) return;
			
			if(through) {
				var pt : Point = pts[int(0)];
				var cPt : Point;
			
				curve = [];
				curve.push(pt);
				
				cPt = index(2).subtract(pt);
				cPt.x /= 4;
				cPt.y /= 4;
				cPt = index(1).subtract(cPt);
				
				pt = index(1);
				
				curve.push(cPt);
				curve.push(pt);
				
				var len : int = pts.length - 1;
				for(var i : int = 1;i < len; i++) {
					cPt = index(i).add(index(i).subtract(cPt));
					pt = index(i + 1);
					
					curve.push(cPt);
					curve.push(pt);
				}
			} else {
				curve = pts;
			}
		}

		private function angle(t : Number, pt1 : Point, pt2 : Point, pt3 : Point) : Number {
			return (Math.atan2(derivative(t, pt1.y, pt2.y, pt3.y), derivative(t, pt1.x, pt2.x, pt3.x)));
		}

		private function quadratic(t : Number,a : Number,b : Number,c : Number) : Number {
			return a + t * (2 * (1 - t) * (b - a) + t * (c - a));
		}

		private function derivative(t : Number, a : Number, b : Number, c : Number) : Number {
			return 2 * a * (t - 1) + 2 * b * (1 - 2 * t) + 2 * c * t;
		}
	}
}
