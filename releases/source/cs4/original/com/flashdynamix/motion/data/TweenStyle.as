package com.flashdynamix.motion.data {



		public static const REPLAY : int = 1;
		public static const LOOP : int = 2;
		
		



		public var repeats : int = -1;
		public var repeatEase : Array;


			this.conflictResolve = conflictResolve;







		 * The total duration of the TweenStyle animation in seconds.<BR>
		 * This is the sum of delayStart, duration and delayEnd.
		 */
		public function get totalDuration() : Number {
			return (delayStart + duration + delayEnd);
		}

