Perlin Noise for Objective-C
============================
------------------------------------------------------

This is a Perlin Noise Generator based on information from [Hugo Elias](http://freespace.virgin.net/hugo.elias/models/m_perlin.htm "Hugo Elias's Perlin Noise Page").

Usage:
------

To use: Simply add PerlinNoise.h and PerlinNoise.m to your project. 

You can initalize the class like this:

<pre><code>PerlinNoise *perlin = [[PerlinNoise alloc] initWithSeed:someint];</code></pre>

Then by calling one of the output functions you will recieve a float that is the PerlinNoise value for the input.

<pre><code>float n = [perlin perlin1DValueForPoint:x];</code></pre>

or 

<pre><code>float n = [perlin perlin2DValueForPoint:x :y];</code></pre>


You can manipulate the output using the following properties.

- .seed (this is the number used to generate the output)

- .octaves (how many iterations the function should run)

- .persistance (this changes the frequency for the subsequent octaves)

- .scale (multiply the output by this number, the default output is between 0 and 1)

- .frequency (the distance between the returned values)

- .interpolationType (this can be kLinearInterpolation or kCosineInterpolation, CosineInterpolation is slower)

---------------------------------------------------------------
Thanks to Hugo Elias for his wonderful page about perlin noise

http://freespace.virgin.net/hugo.elias/models/m_perlin.htm

Also thanks for my friend Tim Winter who always helps me find my bugs.
