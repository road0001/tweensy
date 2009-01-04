package com.flashdynamix.utils {

	public class ObjectPool {

		public var minSize : int;
		public var size : int = 0;
		public var Create : Class;
		public var length : int = 0;

		private var list : Array = [];
		private var disposed : Boolean = false;

		public function ObjectPool(Create : Class, minSize : int = 50) {
			this.Create = Create;
			this.minSize = minSize;
			
			for(var i : int = 0;i < minSize; i++) add();
		}

		public function add() : void {
			list[length++] = new Create();
			size++;
		}

		public function checkOut() : * {
			if(length == 0) {
				size++;
				return new Create();
			}
			
			return list[--length];
		}

		public function checkIn(item : *) : void {
			list[length++] = item;
		}

		public function dispose() : void {
			if(disposed) return;
			
			disposed = true;
			
			Create = null;
			list = null;
		}
	}
}