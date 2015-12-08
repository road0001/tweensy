<h1>TweensyZero</h1>
<p>Below are some simple steps to help you get started with creating your first animations with TweensyZero. TweensyZero is a light weight version of Tweensy most core features found in Tweensy are available to TweensyZero. Documentation for TweensyZero can be found under the folder 'documentation/zero' or <a href='http://docs.flashdynamix.com/tweensy/zero/'>online</a></p>


&lt;hr/&gt;


<h3>Doing a tween</h3>
<p>Animations can be done using one of the following methods :</p>
<h3>A 'to' tween</h3>
<p>Is an animation which goes from the instances current position to the destination defined in the 'to' Object.</p>
```
import com.flashdynamix.motion.TweensyZero;

TweensyZero.to(myInstance, {x:500});```
<p>This will animate 'myInstance' from it's current x to the x position of 500.</p>
<h3>A 'from' tween</h3>
<p>Is the opposite of a to based tween. It is an animation which goes from the destination defined in the 'from' Object to the instances current position.</p>
```
import com.flashdynamix.motion.TweensyZero;

TweensyZero.from(myInstance, {x:500});```
<p>This will animate 'myInstance' from the x position 500 to it's current x position.</p>
<h3>A 'fromTo' tween</h3>
<p>Is using the features of both to and from based tweens. It is an animation which goes from the destination defined in the 'from' Object and to the destination defined in the 'to' Object.</p>
```
import com.flashdynamix.motion.TweensyZero;

TweensyZero.fromTo(myInstance, {x:0}, {x:500});```
<p>This will animate 'myInstance' from the x position of 0 to the x position of 500.</p>


&lt;hr/&gt;


<h2>Controlling tweens</h2>
<p>Tweensy provides methods which allow for the controlling of tweens whilst they are in animation.</p>
<h3>Stopping a tween</h3>
<p>Allows for stopping a tween in motion via an Object instance or property names.</p>
```
import com.flashdynamix.motion.TweensyZero;
TweensyZero.to(myInstance1, {x:500, y:500});
TweensyZero.to(myInstance2, {x:500, y:500});

TweensyZero.stop(myInstance1);```
<p>Stops all tweens for myInstance1 though tweens will continue for myInstance2</p>
```
TweensyZero.stop(myInstance1, "x");```
<p>Stops tweens for the x property for myInstance1</p>
```
TweensyZero.stop(null, "x");```
<p>Stops all tweens for the x property animating in TweensyZero</p>
```
TweensyZero.stop([myInstance1, myInstance2]);```
<p>Stops all tweens for myInstance1 and myInstance2</p>
```
TweensyZero.stop([myInstance1, myInstance2], "x");```
<p>Stops tweens for the x property for myInstance1 and myInstance2</p>
<h3>Pausing and resuming a tween</h3>
<p>Allows for pausing and resuming all tweens executed by TweensyZero.</p>
```
TweensyZero.pause();
TweensyZero.resume();```
<h3>Time based vs Frame based.</h3>
<p>By default TweensyZero uses time based animations, this ensures that tweens end precisely in the time you define. Movieclip animations created in the Flash IDE are frame based and TweensyZero offers an option to use this mode also. When using frame based animations you can define how many seconds per frame are applied on each ENTER_FRAME. So if you wanted to match the FLA frame rate of 30FPS the SPF would be 1/30. Or if you wanted to double the frame rate this would be (1/30) multiplied by 2.</p>
```
TweensyZero.refreshType = TweensyZero.FRAME;
TweensyZero.secondsPerFrame = 1/30;```


&lt;hr/&gt;


<h2>Other things to know about tweens</h2>
<p>When a to, from or fromTo tween is defined it returns an instance of TweensyTimelineZero this contains the parameters of this tween which you may modify during the tweens animation for further control over the tween.</p>
<h3>Using timelines</h3>
<p>When a to, from or fromTo tween is defined it will return an instance of TweensyTImelineZero. Using TweensyTImelineZero allows for defining parameters which are not in the to, from and fromTo method as well as updating properties during the tweens animation. </p>
```
import com.flashdynamix.motion.*;

var timeline:TweensyTimelineZero = TweensyZero.to(myInstance, {x:500}, 2.0);
timeline.duration = 3.5;```
<p>This will animate 'myInstance' from it's current x to the x position of 500 in 3.5 seconds rather than the initially defined 2 seconds.</p>
<p>Timelines offer a lot more functionality which will be described in further detail below.</p>
<h3>Relative and random range positions</h3>
<p>The properties in the to and from Objects allow for you to define a relative position or random range positions.</p>
<p>{x:"500"} will offset the x by +500.<br />
{x:"-500"} will offset the x by -500.<br />
{x:"250,500"} will offset the x by a random number between +250 and +500.</p>
<h3>Using ease equations</h3>
<p>Ease equations change the style of movement from point A to point B.<br>
TweensyZero supports all the ease equations provided via Adobe in the fl.motion.easing package and these have been provided as a part of the TweensyZero library. By default TweensyZero will use the ease equation Quintic.easeOut if null or no parameter is provided.</p>
```
import com.flashdynamix.motion.TweensyZero;
import fl.motion.easing.Sine.easeOut;

TweensyZero.to(myInstance, {x:500}, 2.0, Sine.easeOut);```
<p>This will animate 'myInstance' from its current x to the x position of 500 in 2 seconds using the Sine.easeOut equation.</p>
<h3>Additional parameters for ease equations</h3>
<p>The ease equations Back and Elastic are considered special ease equations because they allow additional parameters to be defined to modify the easing equation. TweensyTimelineZero allows you to define parameters to control this.</p>
```
import com.flashdynamix.motion.*;
import fl.motion.easing.Back.easeOut;

var timeline:TweensyTimelineZero = TweensyZero.to(myInstance, {x:500}, 2.0, Back.easeOut);
timeline.easeParams = [0.7];```
<p>This will animate 'myInstance' from it's current x to the x position of 500 in 2 seconds using the Back.easeOut equation and dampen the overshoot of the equation by a factor of 0.7.</p>
<h3>Delaying a tween</h3>
<p>All tweens can have a start and end delay by default they will do not have any.</p>
```
import com.flashdynamix.motion.*;

var timeline:TweensyTimelineZero = TweensyZero.to(myInstance, {x:500}, 2.0, null, 1.0);
timeline.delayEnd = 1.5;```
<p>This will animate 'myInstance' to the x position of 500 after a starting delay of 1 second with another 1.5 second ending delay before the animation is considered complete.</p>


&lt;hr/&gt;


<h2>Adding and removing tween events</h2>
<p>TweensyZero and Timelines have 2 events update and complete. Update fires every time the tween is updated and complete fires when the animation is finished. Predefined parameters may be applied to each of these functions as they are fired if none are defined, no parameters are applied.</p>
<h3>Events for TweensyZero</h3>
<p>onUpdate will fire each render of an Event.ENTER_FRAME.<br />
onComplete will fire after all animations are finished.</p>
```
TweensyZero.to(myInstance, {x:500}, 2.0);
TweensyZero.onComplete = allAnimationsComplete;```
<h3>Events for TweensyTimelineZero</h3>
<p>onUpdate will fire each time the timeline animation updates.<br />
onComplete will fire when the timeline animation is finished.</p>
```
import com.flashdynamix.motion.*;

var timeline:TweensyTimelineZero = TweensyZero.to(myInstance, {x:500}, 2.0);
timeline.onComplete = animationComplete;
timeline.onCompleteParams = new Array(myInstance);```
<p>To remove a onComplete or onUpdate event simply set it back to null.</p>
```
timeline.onComplete = null;```
<p>Tweensy uses this method of applying event listeners rather than the Adobe Event Dispatcher this is because it allows for predefined parameters. This easily allows for self removing tweens without all the fussiness of using the EventDispatcher first  i.e.</p>
```
var timeline:TweensyTimelineZero = TweensyZero.to(myInstance, {x:500}, 2.0);
timeline.onComplete = myInstance.parent.removeChild;
timeline.onCompleteParams = [myInstance];```


&lt;hr/&gt;


<h3>Doing an advanced tween</h3>
<p>Tweening the properties of certain Objects in Actionscript can be more complicated these Objects include BitmapFilters, ColorTransforms, Matrices and SoundTransforms to name a few. This is because tweening the property's of these Objects need to be applied onto another for them to have a visual effect. Though TweensyZero can do this, it requires you to define an extra parameter to define which Object to update onto.</p>
```
TweensyZero.to(new DropShadowFilter(), {blurX:10, blurY:10}, 2.0, null, 0, myInstance);```
<p>Tweens the blurX and blurY properties for the DropShadowFilter and applies the drop shadow onto myInstance.</p>
```
TweensyZero.to(myInstance.transform.matrix, {tx:80, ty: 80}, 2.0, null, 0, myInstance);```
<p>Tweens the tx and ty properties for the Matrix of myInstance and applies the matrix transformation onto myInstance.</p>
```
TweensyZero.to(myInstance.transform.colorTransform, {redOffset:80}, 2.0, null, 0, myInstance);```
<p>Tweens the redOffset property for the ColorTransform of myInstance and applies the color transform onto myInstance.</p>
```
TweensyZero.to(myChannel.soundTransform, {volume:0}, 2.0, null, 0, myChannel);```
<p>Tweens the volume property for the SoundTransform of a SoundChannel and applies the sound transform onto myChannel.</p>