<h1>Motion guided tweens</h1>
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