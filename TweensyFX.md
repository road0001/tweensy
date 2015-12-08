<h2>TweensyFX (beta)</h2>
<p>TweensyFX provides you with a effect library to apply Bitmap effects onto DisplayObjects in an optimized manner. These effects include directional motion blur, pixelation, xray, bulge/dent displacements, reflection, emitters, rgb channel splitting and bump mapping. TweensyFX is an expansion package to Tweensy as it allows for you to use these effects with the highly optimized tweening engine. Documentation for Tweensy can be found under the folder 'documentation/fx' or <a href='http://docs.flashdynamix.com/tweensy/fx/'>online</a></p>


&lt;hr/&gt;


<h2>Creating a Render layer</h2>
<p>Effects in TweensyFX are rendered to a layer. TweensyFX offers it render layers in either vector or bitmap format.</p>
<h3>Bitmap layers</h3>
<p>These layers are resolution dependent and in most cases offer better efficiency over Flash's built-in Display List and applying effects. Bitmap layers have a render area anything outside this area will be ignored. They also have a smoothing, transparency mode and a background color to be used when transparency is off.</p>
```
var layer:BitmapLayer = new BitmapLayer(500, 450, 1, 0x00FFFFFF, true, true);```
<p>Creates a BitmapLayer of the render area of 500x450 of 100% scale supporting transparency and smoothing with a transparent background color. </p>
<h3>Vector layers</h3>
<p>These layers are resolution independent and provides a practical library of vector drawings not provided via the Flash Drawing API onto a single Graphics layer. Vector layers also have a render area any outside this area will be ignored.</p>
```
var layer:VectorLayer = new VectorLayer(500, 450, null, false);```
<p>Creates a VectorLayer of the render area of 500x450 with a transparent background and caching as Bitmap is turned off.</p>
<p>Vector layers can easily be drawn to BitmapLayers and have effects applied via the draw method.</p>
```
var bmpLayer:BitmapLayer = new BitmapLayer();
var vecLayer:VectorLayer = new VectorLayer();
bmpLayer.draw(vecLayer);```


&lt;hr/&gt;


<h3>Applying effects to a Bitmap layer</h3>
<p>Bitmap layers can have effects added and then have the effect parameters tweened for the specific effect to change the effects style during an animation.</p>
```
var bmpLayer:BitmapLayer = new BitmapLayer();
bmpLayer.add(new FilterEffect(new BlurFilter(5, 5)));
bmpLayer.add(new ColorEffect(new ColorTransform(1, 1, 1, 0.9)));
bmpLayer.draw(myInstance);```
<p>This will apply a directional motion blur effect onto the BitmapLayer.</p>


&lt;hr/&gt;


<h2>Using emitters</h2>
<p>Emitters allow for you to create simple particle effects. An emitter will constantly create a particle DisplayObject and is intended to be then rendered by a BitmapLayer. An emitter will emit particles between a defined angle to a defined minimum and maximum distance. Over the course of a particles lifespan other display properties such as ColorTransform (alpha, colour etc.) and Matrix transformations (x,y, scale etc.) can be applied to the particle to get a desired effect.</p>
```
var bmpLayer:BitmapLayer = new BitmapLayer();
bmpLayer.add(new FilterEffect(new BlurFilter(5, 5)));
bmpLayer.add(new ColorEffect(new ColorTransform(1, 1, 1, 0.9)));
var emitter:Emitter = new Emitter(Particle, {scaleX:2, scaleY:2}, 5, 0.5, "-180, 180", "50, 100");
bmpLayer.draw(emitter.holder);```
<p>This will emit the DisplayObject Particle 5 times every other frame. The particle has an angle range of -180 to 180 degrees to a distance between 50 to 100 pixels. During the lifespan of the Particle it will scale to double its initial size.</p>
<br />
<p>Another important aspect about emitters is that it's Transform is applied onto the Particles it creates. So if you were to change the x,y, blendMode or alpha of the emitter this will be applied onto the Particles also.</p>
```
emitter.blendMode = BlendMode.ADD;
emitter.alpha = 0.8;```
<p>Will apply the ADD BlendMode, alpha of 0.8 onto all Particles created by the emitter.</p>
```
function draw(event:Event):void{
emitter.x += (stage.mouseX-emitter.x)/4;
emitter.y += (stage.mouseY-emitter.y)/4;
}
stage.addEventListener(Event.ENTER_FRAME, draw);```
<p>So a mouse following emitter would be created like the above. Updating the emitters x/y will alter the position of the Particles it creates.</p>