<h1>Tweensy</h1>
<p>The Tweensy class contains static methods (for coding convenience) to create and control tween animations. Below are some simple steps to help you get started with creating your first animations with Tweensy. Documentation for Tweensy can be found under the folder 'documentation/original' or <a href='http://docs.flashdynamix.com/tweensy/original/'>online</a></p>


&lt;hr/&gt;


<h3>Doing a tween</h3>
<p>Animations can be done using one of the following methods :</p>
<h3>A 'to' tween</h3>
<p>Is an animation which goes from the instances current position to the destination defined in the 'to' Object.</p>
```
import com.flashdynamix.motion.Tweensy;

Tweensy.to(myInstance, {x:500});```
<p>This will animate 'myInstance' from it's current x to the x position of 500.</p>
<h3>A 'from' tween</h3>
<p>Is essentially the opposite of a to based tween. It is an animation which goes from the destination defined in the 'from' Object to the instances current position.</p>
```
import com.flashdynamix.motion.Tweensy;

Tweensy.from(myInstance, {x:500});```
<p>This will animate 'myInstance' from the x position 500 to it's current x position.</p>
<h3>A 'fromTo' tween</h3>
<p>Is using both the features of a from and to tween. It is an animation which goes from the destination defined in the 'from' Object and to the destination defined in the 'to' Object.</p>
```
import com.flashdynamix.motion.Tweensy;

Tweensy.fromTo(myInstance, {x:0}, {x:500});```
<p>This will animate 'myInstance' from the x position of 0 to the x position of 500.</p>


&lt;hr/&gt;


<h2>Controlling tweens</h2>
<p>Tweensy provides methods which allow for the controlling of tweens whilst they are in animation.</p>
<h3>Stopping a tween</h3>
<p>Allows for stopping a tween in motion via an Object instance or property names.</p>
```
import com.flashdynamix.motion.Tweensy;
Tweensy.to(myInstance1, {x:500, y:500});
Tweensy.to(myInstance2, {x:500, y:500});

Tweensy.stop(myInstance1);```
<p>Stops all tweens for myInstance1 though tweens will continue for myInstance2.</p>
```
Tweensy.stop(myInstance1, "x");```
<p>Stops tweens for the x property for myInstance1.</p>
```
Tweensy.stop(null, "x");```
<p>Stops all tweens for the x property animating in Tweensy.</p>
```
Tweensy.stop([myInstance1, myInstance2]);```
<p>Stops all tweens for myInstance1 and myInstance2.</p>
```
Tweensy.stop([myInstance1, myInstance2], "x");```
<p>Stops tweens for the x property for myInstance1 and myInstance2.</p>
<h3>Pausing and resuming a tween</h3>
<p>Allows for pausing and resuming all tweens executed by Tweensy.</p>
```
Tweensy.pause();
Tweensy.resume();```
<h3>Time based vs Frame based</h3>
<p>By default Tweensy uses time based animations, this ensures that tweens end precisely in the time you define. Movieclip animations created in the Flash IDE are frame based and Tweensy offers an option to use this mode also. When using frame based animations you can define how many seconds per frame are applied on each ENTER_FRAME. So if you wanted to match the FLA frame rate of 30FPS the SPF would be 1/30. Or if you wanted to double the frame rate this would be (1/30) multiplied by 2.</p>
```
Tweensy.refreshType = Tweensy.FRAME;
Tweensy.secondsPerFrame = 1/30;```
<h3>Updating a tween in motion</h3>
<p>Tweens in motion can have there positions seamlessly updated within the animation time remaining.</p>
```
Tweensy.updateTo(myInstance, {x:250});```
<h3>Repeating tweens</h3>
<p>Tweens can be set to be repeating with the following types yoyo, loop and replay in either an endless or for a finite loop count.More information regarding repeating animations can be found in the documentation.</p>
```
import com.flashdynamix.motion.*;

var timeline:TweensyTimeline = Tweensy.to(myInstance, {x:500});
timeline.repeatType = TweensyTimeline.YOYO;
timeline.repeats = 3;```
<p>This will animate 'myInstance' from its current x position to an x position of 500 to and fro 3 times.</p>


&lt;hr/&gt;


<h2>Other things to know about tweens</h2>
<p>When a to, from or fromTo tween is defined it returns an instance of TweensyTimeline this contains the parameters of this tween which you may modify during the tweens animation.</p>
<h2>Using timelines</h2>
<p>When a to, from or fromTo tween is defined it will return an instance of TweensyTImeline. Using TweensyTImeline allows for defining parameters which are not in the to, from and fromTo method as well as updating properties during the tweens animation. </p>
```
import com.flashdynamix.motion.*;

var timeline:TweensyTimeline = Tweensy.to(myInstance, {x:500}, 2.0);
timeline.duration = 3.5;```
<p>This will animate 'myInstance' from it's current x to the x position of 500 in 3.5 seconds rather than the initially defined 2 seconds.</p>

<p>Timelines offer a lot more functionality which will be described in further detail below.</p>
<h3>Relative and random range positions</h3>
<p>The properties in the to and from Objects allow for you to define a relative position or random range positions.<br />
{x:"500"} will offset the x by +500.<br />
{x:"-500"} will offset the x by -500.<br />
{x:"250,500"} will offset the x by a random number between +250 and +500.</p>
<h3>Using ease equations</h3>
<p>Ease equations change the style of movement from point A to point B.<br>
Tweensy supports all the ease equations provided via Adobe in the fl.motion.easing package and these have been provided as a part of the Tweensy library. By default Tweensy will use the ease equation Quintic.easeOut if null or no parameter is provided.</p>
```
import com.flashdynamix.motion.Tweensy;
import fl.motion.easing.Sine.easeOut;

Tweensy.to(myInstance, {x:500}, 2.0, Sine.easeOut);```
<p>This will animate 'myInstance' from its current x to the x position of 500 in 2 seconds using the Sine.easeOut equation.</p>
<h3>Additional parameters for ease equations</h3>
<p>The ease equations Back and Elastic are considered special ease equations because they allow additional parameters to be defined to modify the easing equation. TweensyTimeline allows you to define parameters to control this by the classes BackEaseParams and ElasticEaseParams.</p>
```
import com.flashdynamix.motion.*;
import fl.motion.easing.Back.easeOut;
import com.flashdynamix.motion.easing.BackEaseParams;

var timeline:TweensyTimeline = Tweensy.to(myInstance, {x:500}, 2.0, Back.easeOut);
timeline.easeParams = new BackEaseParams(0.7);```
<p>This will animate 'myInstance' from it's current x to the x position of 500 in 2 seconds using the Back.easeOut equation and dampen the overshoot of the equation by a factor of 0.7.</p>
<h3>Delaying a tween</h3>
<p>All tweens can have a start and end delay by default they will do not have any.</p>
```
import com.flashdynamix.motion.*;

var timeline:TweensyTimeline = Tweensy.to(myInstance, {x:500}, 2.0, null, 1.0);
timeline.delayEnd = 1.5;```
<p>This will animate 'myInstance' to the x position of 500 after a starting delay of 1 second with another 1.5 second ending delay before the animation is considered complete.</p>


&lt;hr/&gt;


<h2>Doing an advanced tween</h2>
<p>Tweening the properties of certain Objects in Actionscript can be more complicated these Objects include BitmapFilters, ColorTransforms, Matrices and SoundTransforms to name a few. This is because tweening the property's of these Objects need to be applied onto another for them to have a visual effect. Though Tweensy can do this, it requires you to define an extra parameter to define which Object to update onto.</p>
```
Tweensy.to(new DropShadowFilter(), {blurX:10, blurY:10}, 2.0, null, 0, myInstance);```
<p>Tweens the blurX and blurY properties for the DropShadowFilter and applies the drop shadow onto myInstance.</p>
```
var mtx:Matrix = myInstance.transform.matrix;
mtx.tx = 200;
mtx.ty = 200;
Tweensy.to(myInstance.transform.matrix, mtx, 2.0, null, 0, myInstance);```
<p>Tweens the tx and ty properties for the Matrix of myInstance and applies the matrix transformation onto myInstance.</p>
```
var ct:ColorTransform = myInstance.transform.colorTransform;
ct.redOffset = 80;
Tweensy.to(myInstance.transform.colorTransform, ct, 2.0, null, 0, myInstance);```
<p>Tweens the redOffset property for the ColorTransform of myInstance and applies the color transform onto myInstance.</p>
```
var st:SoundTransform = myChannel.soundTransform;
st.volume = 0;
Tweensy.to(myChannel.soundTransform, st, 2.0, null, 0, myChannel);```
<p>Tweens the volume property for the SoundTransform of a SoundChannel and applies the sound transform onto myChannel.</p>


&lt;hr/&gt;


<h2>Adding and removing tween events</h2>
<p>Tweensy and Timelines have 2 events update and complete. Update fires every time the tween is updated and complete fires when the animation is finished. Predefined parameters may be applied to each of these functions as they are fired if none are defined, no parameters are applied.</p>
<h3>Events for Tweensy</h3>
<p>onUpdate will fire each render of an Event.ENTER_FRAME.<br />
onComplete will fire after all animations are finished.</p>
```
import com.flashdynamix.motion.*;

Tweensy.to(myInstance, {x:500}, 2.0);
Tweensy.onComplete = allAnimationsComplete;```
<h2>Events for TweensyTimeline</h2>
<p>onUpdate will fire each time the timeline animation updates.<br />
onComplete will fire when the timeline animation is finished.<br />
onRepeat will fire when the timeline animation repeats.</p>
```
import com.flashdynamix.motion.*;

var timeline:TweensyTimeline = Tweensy.to(myInstance, {x:500}, 2.0);
timeline.onComplete = animationComplete;
timeline.onCompleteParams = new Array(myInstance);```
<p>To remove a onComplete or onUpdate event simply set it back to null.</p>
```
timeline.onComplete = null;```
<p>Tweensy uses this method of applying event listeners rather than the Adobe Event Dispatcher as it allows for predefined parameters allowing for self removing tweens without all the fussiness of using the EventDispatcher first  i.e.</p>
```
import com.flashdynamix.motion.*;

var timeline:TweensyTimeline = Tweensy.to(myInstance, {x:500}, 2.0);
timeline.onComplete = myInstance.parent.removeChild;
timeline.onCompleteParams = new Array(myInstance);```


&lt;hr/&gt;


<h2>Using TweensyGroup</h2>
<p>TweensyGroup is the recommended implementation of tweening and offers all the functionality of Tweensy (and more) but doesn't provide it's functionality by static methods and properties. As the animations contained within the TweensyGroup instance are only the ones defined by this instance it provides a greater level of control over animations. This means TweensyGroup allows for stopping, pausing and setting specific refreshTypes which only effect this TweensyGroup instance.</p>
<br />
<p>It's also important to remember as TweensyGroup is weakly referenced it is important you maintain an instance and dispose it when its no longer used.</p>
```
var tween:TweensyGroup = new TweensyGroup();
tween.to(myInstance, {x:500});```
<h3>Other benefits of using TweensyGroup</h3>
<p>TweensyGroup contains a collection of functions which shortcut otherwise advanced concepts of the Tweensy engine. Some of these include : </p>
<ul>
<li>matrixTo</li>
<li>colorTransformTo</li>
<li>soundTransformTo</li>
<li>filterTo</li>
<li>functionTo</li>
<li>slideTo</li>
<li>scaleTo</li>
</ul>
<h3>Disposing TweensyGroup</h3>
<p>As the TweensyGroup class is constructed it's important that you dispose the class when you are done with it.</p>
```
import com.flashdynamix.motion.*;

var tween:TweensyGroup = new TweensyGroup();
tween.dispose();
tween = null;```
<h3>Lazy mode with TweensyGroup</h3>
<p>Tweensy by default automatically resolves tweening conflicts though this comes at a performance cost. If this feature is turned off it can improve the overall performance of Tweensy. This mode is considered lazy tween conflict resolution because when its off it's up to the developer to stop tweens for a particular instance by the stop method.</p>
```
var tween:TweensyGroup = new TweensyGroup(false);```
<p>Will disable automatic resolution of tweening conflicts.</p>
<h3>Object pooling with TweensyGroup</h3>
<p>Part of the reason why Tweensy is so memory efficient is it has the option to use Object pooling by default this option is off. This is because using Object pooling is a rather advanced feature not suited to novice developers. For more experienced developers it is recommended to use this feature. But it's important to note that TweensyGroup pools instances of TweensyTimeline and the implications this may have. If constant references are made to an instance of TweensyTimeline this could create logical problems in your code. This is because after the TweensyTImeline instance is initially used for your animation it may be used again for another.</p>
```
var tween:TweensyGroup = new TweensyGroup(false, true);```
<p>This will enable Tweensy to use Object pooling.</p>


&lt;hr/&gt;


<h2>Motion guided tweens</h2>
<p>Tweensy has a package called guides which allow for defining a direction, orbit or bezier path to be used on a motion tween.</p>
<h3>Direction guided tweens</h3>
<p>A direction guide has a direction and a distance. Tweening the position on the Direction2D class defines where on the path the item is placed initially the path  is at position 0 and ends at position 1.</p>
```
import com.flashdynamix.motion.*;
import com.flashdynamix.motion.guides.Direction2D;
var tween:TweensyGroup = new TweensyGroup();
tween.to(new Direction2D(myInstance, 45, 100), {position:1});```
<p>This will animate 'myInstance' a distance of 100 pixels at 45 degree from it's current position.</p>
<h3>Orbit guided tweens</h3>
<p>An orbit guide has a radius x, radius y, center x and a center y. Tweening the angle in degrees on the Orbit2D class defines where on the path the item is placed initially the path is at the angle 0.</p>
```
import com.flashdynamix.motion.*;
import com.flashdynamix.motion.guides.Orbit2D;

var tween:TweensyGroup = new TweensyGroup();
tween.to(new Orbit2D(myInstance, 100, 100, 250, 250), {degree:360});```
<p>This will orbit 'myInstance' 360 degrees on a x/y radius of 100 from the x/y center point of 250.</p>
<h3>Bezier guided tweens</h3>
<p>A bezier guide has a collection of points defining a bezier path. Tweening the position on the Bezier2D class defines where on the path the item is placed initially the path is at position 0 and ends at position 1.</p>
```
import com.flashdynamix.motion.*;
import com.flashdynamix.motion.guides.Bezier2D;

var tween:TweensyGroup = new TweensyGroup();
var bezier:Bezier2D = new Bezier2D(myInstance, true, false, false);
bezier.push(new Point(100, 100));
bezier.push(new Point(200, 150));
bezier.push(new Point(300, 100));
bezier.push(new Point(400, 300));
tween.to(bezier, {position:1});```
<p>This will animate 'myInstance' along the bezier path defined from it's start position.</p>


&lt;hr/&gt;


<a href='#advancedTweens'><h2>Advanced Matrix and ColorMatrixFilter tweens</h2></a>
<p>Tweensy has a package called extras which contains classes which help you to do complicated animations in a very easy manner. These tweens include Matrix transformations around a registration point. As well ColorMatrixFilter effects such as brightness, contrast, colorize and threshold.</p>
<h3>Advanced Matrix tweens</h3>
<p>An advanced Matrix tween allows for applying Matrix transformations around a defined registration point. These transformations include rotation, skewX, skewY, scaleX, scaleY, translationX and translationY.</p>
```
import com.flashdynamix.motion.*;
import com.flashdynamix.motion.extras.MatrixTransform;

var tween:TweensyGroup = new TweensyGroup();
var mtx:MatrixTransform = new MatrixTransform(myInstance);
mtx.registrationX = myInstance.x + myInstance.width/2;
mtx.registrationY = myInstance.y + myInstance.height/2;
tween.to(mtx, {degree:45});```
<p>This will tween 'myInstance' rotation to 45 degrees around the middle of 'myInstance'.</p>
<h3>ColorMatrixFilter tweens</h3>
<p>The ColorMatrixFilter allows for applying complex color alterations like brightness, contrast, saturation, colorize and threshold. The ColorMatrix class helps to create the 4x5 Array matrix to then be tweened onto a ColorMatrixFilter.</p>
```
import flash.filters.ColorMatrixFilter;
import com.flashdynamix.motion.*;
import com.flashdynamix.motion.extras.ColorMatrix;

var tween:TweensyGroup = new TweensyGroup();
tween.to(new ColorMatrixFilter(), new ColorMatrix(0, 0, 3), 2, null, 0, myInstance);```
<p>This will tween the ColorMatrixFilter from the identity matrix to the Array matrix defined by ColorMatrix and apply the ColorMatrixFilter to 'myInstance'</p>


&lt;hr/&gt;


<h2>Using TweensySequence</h2>
<p>TweensySequence allows for a chain of tweens to occur one after another. Like TweensyGroup, TweensySequence must be constructed in order to be used. Once a sequence has been created you can then start, stop, pause or resume the sequence at any time. As well repeat via the modes replay and yoyo.</p>
```
import com.flashdynamix.motion.TweensySequence;

var sequence:TweensySequence = new TweensySequence();
sequence.push(myInstance1, {x:200, y:200}, 1);
sequence.push(myInstance1, {x:500, y:250}, 1);
sequence.push(myInstance1, {x:0, y:0}, 1);
sequence.start();```
<p>Creates a tween sequence for 'myInstance' taking 1 second to move between each of the positions pushed into the sequence.</p>