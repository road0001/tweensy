package com.flashdynamix.utils {
	import flash.utils.Dictionary;		

	public class MultiTypeObjectPool {

		public var pools : Dictionary;
		private var disposed : Boolean = false;

		public function MultiTypeObjectPool(...types : Array) {
			pools = new Dictionary(true);
		}

		public function add(Type : Class) : void {
			pools[Type] = new ObjectPool(Type);
		}

		public function checkOut(Type : Class) : * {
			return (pools[Type] as ObjectPool).checkOut();
		}

		public function checkIn(item : Object) : void {
			(pools[item.constructor] as ObjectPool).checkIn(item);
		}

		public function empty() : void {
			var pool : ObjectPool;
			
			for each(pool in pools) pool.empty();
		}

		public function dispose() : void {
			if(disposed) return;
			
			disposed = true;
			
			var pool : ObjectPool;
			
			for each(pool in pools) {
				pool.dispose();
				delete pools[pool];
			}
			
			pools = null;
		}
	}
}
