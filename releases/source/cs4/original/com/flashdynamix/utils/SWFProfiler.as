package com.flashdynamix.utils {
	import flash.display.*;
	import flash.events.*;
	import flash.net.LocalConnection;
	import flash.system.System;
	import flash.ui.*;
	import flash.utils.getTimer;	

	/**
	 * The SWFProfiler is a degugging tool which allows for monitoring the amount of memory and the frame rate of a SWF.
	 */
	public class SWFProfiler {

		private static var itvTime : int;
		private static var initTime : int;
		private static var currentTime : int;
		private static var frameCount : int;
		private static var totalCount : int;

		public static var minFps : Number;
		public static var maxFps : Number;
		public static var minMem : Number;
		public static var maxMem : Number;
		public static var history : int = 60;
		public static var refreshRate : Number = 1;
		public static var fpsList : Array = [];
		public static var memList : Array = [];

		private static var displayed : Boolean = false;
		private static var started : Boolean = false;
		private static var inited : Boolean = false;
		private static var frame : Sprite;
		private static var stage : Stage;
		private static var content : ProfilerContent;
		private static var ci : ContextMenuItem;

		
		/**
		 * Iniates the SWFProfiler to the ContextMenu of the reference passed.
		 */
		public static function init(context : InteractiveObject) : void {
			if(inited) return;
			
			inited = true;
			stage = context.stage;
			
			content = new ProfilerContent();
			frame = new Sprite();
			
			minFps = Number.MAX_VALUE;
			maxFps = Number.MIN_VALUE;
			minMem = Number.MAX_VALUE;
			maxMem = Number.MIN_VALUE;
			
			var cm : ContextMenu = new ContextMenu();
			cm.hideBuiltInItems();
			ci = new ContextMenuItem("Show Profiler", true);
			cm.customItems = [ci];
			context.contextMenu = cm;
			addEvent(ci, ContextMenuEvent.MENU_ITEM_SELECT, onSelect);
			
			start();
		}

		/**
		 * Starts updating the Profiler.
		 */
		public static function start() : void {
			if(started) return;
			started = true;
			initTime = itvTime = getTimer();
			totalCount = frameCount = 0;
			addEvent(frame, Event.ENTER_FRAME, draw);
		}

		/**
		 * Stops updating the Profiler.
		 */
		public static function stop() : void {
			if(!started) return;
			started = false;
			removeEvent(frame, Event.ENTER_FRAME, draw);
		}

		/**
		 * Garbage collect the SWF.
		 */
		public static function gc() : void {
			try {
				System.gc();
				new LocalConnection().connect('foo');
				new LocalConnection().connect('foo');
			} catch (e : Error) {
			}
		}

		/**
		 * @return The current frames per second.
		 */
		public static function get currentFps() : Number {
			return frameCount / intervalTime;
		}

		/**
		 * @return The current amount of memory used by the SWF in MB.
		 */
		public static function get currentMem() : Number {
			return System.totalMemory / 1024 / 1024;
		}

		/**
		 * @return The average frames per second.
		 */
		public static function get averageFps() : Number {
			return totalCount / runningTime;
		}

		public static function show() : void {
			ci.caption = "Hide Profiler";
			displayed = true;
			stage.addChild(content);
			updateDisplay();
		}

		public static function hide() : void {
			ci.caption = "Show Profiler";
			displayed = false;
			stage.removeChild(content);
		}

		private static function get runningTime() : Number {
			return (currentTime - initTime) / 1000;
		}

		private static function get intervalTime() : Number {
			return (currentTime - itvTime) / 1000;
		}

		private static function onSelect(e : ContextMenuEvent) : void {
			if(!displayed) {
				show();
			} else {
				hide();
			}
		}

		private static function draw(e : Event = null) : void {
			currentTime = getTimer();
			
			frameCount++;
			totalCount++;
			
			if(intervalTime >= refreshRate) {
				if(displayed) {
					updateDisplay();
				} else {
					updateMinMax();
				}
				
				fpsList.unshift(currentFps);
				memList.unshift(currentMem);
				
				if(fpsList.length > history) fpsList.pop();
				if(memList.length > history) memList.pop();
				
				itvTime = currentTime;
				frameCount = 0;
			}
		}

		private static function updateDisplay() : void {
			updateMinMax();
			content.update(runningTime, stage.frameRate, minFps, maxFps, minMem, maxMem, currentFps, currentMem, averageFps, fpsList, memList, history);
		}

		private static function updateMinMax() : void {
			if(!(currentFps > 0)) return;
			
			minFps = Math.min(currentFps, minFps);
			maxFps = Math.max(currentFps, maxFps);
				
			minMem = Math.min(currentMem, minMem);
			maxMem = Math.max(currentMem, maxMem);
		}

		private static function addEvent(item : EventDispatcher, type : String, listener : Function) : void {
			item.addEventListener(type, listener, false, 0, true);
		}

		private static function removeEvent(item : EventDispatcher, type : String, listener : Function) : void {
			item.removeEventListener(type, listener);
		}
	}
}

import flash.display.*;
import flash.events.Event;
import flash.text.*;

internal class ProfilerContent extends Sprite {

	private var minFpsTxtBx : TextField;
	private var maxFpsTxtBx : TextField;
	private var minMemTxtBx : TextField;
	private var maxMemTxtBx : TextField;
	private var infoTxtBx : TextField;
	private var box : Shape;
	private var fps : Shape;
	private var mb : Shape;

	
	public function ProfilerContent() : void {
		fps = new Shape();
		mb = new Shape();
		box = new Shape();
			
		this.mouseChildren = false;
		this.mouseEnabled = false;
			
		fps.x = 65;
		fps.y = 45;	
		mb.x = 65;
		mb.y = 90;
			
		var tf : TextFormat = new TextFormat("_sans", 9, 0xAAAAAA);
			
		infoTxtBx = new TextField();
		infoTxtBx.autoSize = TextFieldAutoSize.LEFT;
		infoTxtBx.defaultTextFormat = new TextFormat("_sans", 11, 0xCCCCCC);
		infoTxtBx.y = 98;
			
		minFpsTxtBx = new TextField();
		minFpsTxtBx.autoSize = TextFieldAutoSize.LEFT;
		minFpsTxtBx.defaultTextFormat = tf;
		minFpsTxtBx.x = 7;
		minFpsTxtBx.y = 37;
			
		maxFpsTxtBx = new TextField();
		maxFpsTxtBx.autoSize = TextFieldAutoSize.LEFT;
		maxFpsTxtBx.defaultTextFormat = tf;
		maxFpsTxtBx.x = 7;
		maxFpsTxtBx.y = 5;
			
		minMemTxtBx = new TextField();
		minMemTxtBx.autoSize = TextFieldAutoSize.LEFT;
		minMemTxtBx.defaultTextFormat = tf;
		minMemTxtBx.x = 7;
		minMemTxtBx.y = 83;
			
		maxMemTxtBx = new TextField();
		maxMemTxtBx.autoSize = TextFieldAutoSize.LEFT;
		maxMemTxtBx.defaultTextFormat = tf;
		maxMemTxtBx.x = 7;
		maxMemTxtBx.y = 50;
			
		addChild(box);
		addChild(infoTxtBx);
		addChild(minFpsTxtBx);
		addChild(maxFpsTxtBx);
		addChild(minMemTxtBx);
		addChild(maxMemTxtBx);
		addChild(fps);
		addChild(mb);
		
		this.addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true);
		this.addEventListener(Event.REMOVED_FROM_STAGE, removed, false, 0, true);
	}

	public function update(runningTime : Number, actualFps : Number, minFps : Number, maxFps : Number, minMem : Number, maxMem : Number, currentFps : Number, currentMem : Number, averageFps : Number, fpsList : Array, memList : Array, history : int) : void {
		if(runningTime >= 1) {
			minFpsTxtBx.text = minFps.toFixed(3) + " Fps";
			maxFpsTxtBx.text = maxFps.toFixed(3) + " Fps";
			minMemTxtBx.text = minMem.toFixed(3) + " Mb";
			maxMemTxtBx.text = maxMem.toFixed(3) + " Mb";
		}
			
		infoTxtBx.text = "Current " + currentFps.toFixed(3) + "   Average " + averageFps.toFixed(3) + "   Actual " + actualFps.toString() + " Fps   |   Memory Used " + currentMem.toFixed(3) + " Mb";
		infoTxtBx.x = stage.stageWidth - infoTxtBx.width - 20;
		
		var vec : Graphics = fps.graphics;
		vec.clear();
		vec.lineStyle(1, 0x33FF00, 0.7);
			
		var i : int = 0;
		var len : int = fpsList.length;
		var height : int = 35;
		var width : int = stage.stageWidth - 80;
		var inc : Number = width / (history - 1);
		var rateRange : Number = maxFps - minFps;
		var value : Number;
			
		for(i = 0;i < len; i++) {
			value = (fpsList[i] - minFps) / rateRange;
			if(i == 0) {
				vec.moveTo(0, -value * height);
			} else {
				vec.lineTo(i * inc, -value * height);
			}
		}
			
		vec = mb.graphics;
		vec.clear();
		vec.lineStyle(1, 0x0066FF, 0.7);
			
		i = 0;
		len = memList.length;
		rateRange = maxMem - minMem;
		for(i = 0;i < len; i++) {
			value = (memList[i] - minMem) / rateRange;
			if(i == 0) {
				vec.moveTo(0, -value * height);
			} else {
				vec.lineTo(i * inc, -value * height);
			}
		}
	}

	private function added(e : Event) : void {
		resize();
		stage.addEventListener(Event.RESIZE, resize, false, 0, true);
	}

	private function removed(e : Event) : void {
		stage.removeEventListener(Event.RESIZE, resize);
	}

	private function resize(e : Event = null) : void {
		var vec : Graphics = box.graphics;
		vec.clear();
		
		vec.beginFill(0x000000, 0.5);
		vec.drawRect(0, 0, stage.stageWidth, 120);
		vec.lineStyle(1, 0xFFFFFF, 0.2);
			
		vec.moveTo(65, 45);
		vec.lineTo(65, 10);
		vec.moveTo(65, 45);
		vec.lineTo(stage.stageWidth - 15, 45);
			
		vec.moveTo(65, 90);
		vec.lineTo(65, 55);
		vec.moveTo(65, 90);
		vec.lineTo(stage.stageWidth - 15, 90);
			
		vec.endFill();
		
		infoTxtBx.x = stage.stageWidth - infoTxtBx.width - 20;
	}
}