<h1>Advanced Matrix and ColorMatrixFilter tweens</h1>
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