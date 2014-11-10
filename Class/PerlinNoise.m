//
//  PerlinNoise.m
//  PerlinTest
//
//  Created by Weston Hanners on 7/16/12.
//  Copyright (c) 2012 Hanners Software. All rights reserved.
//

#import "PerlinNoise.h"

@interface PerlinNoise () {
    int _functionSelector;
}

@end

@implementation PerlinNoise

- (id)initWithSeed:(int)seed {
    if ((self = [super init])) {
        self.seed = seed;
        self.smoothing = NO;
        self.interpolationMethod = kLinearInterpolation;
        self.octaves = 1;
        self.scale = 1;
        self.frequency = 0.5;
        self.persistence = sqrt(self.amplitude);
    }
    return self;
}

- (float)linearInterpolationBetweenValueA:(float)a valueB:(float)b valueX:(float)x {
    return a * (1 - x) + b * x ;
}

- (float)cosineInterpolationBetweenValueA:(float)a valueB:(float)b valueX:(float)x {
    float ft = x * 3.1415927f;
    float f = (1 - (float)cos(ft)) * 0.5f;
    return a * (1 - f) + b * f;
}

#pragma mark - 1D Perlin Functions

- (float)makeNoise1D:(int)x {
    x = (x >> 13) ^ x;
    x = (x * (x * x * (int)_seed + 19990303) + 1376312589) & RAND_MAX;
    return ( 1.0 - ( (x * (x * x * 15731 + 789221) + 1376312589) & RAND_MAX) / 1073741824.0);
}

- (float)smoothedNoise1D:(float)x {
    return [self makeNoise1D:x] / 2 + [self makeNoise1D:(x - 1)] / 4 + [self makeNoise1D:(x + 1)] / 4;;
}

- (float)interpolatedNoise1D:(float)x {
    int integer_x = (int)x;
    float fractional_x = x-integer_x;
    
    float v1 = [self smoothedNoise1D:integer_x];
    float v2 = [self smoothedNoise1D:integer_x + 1];
    
    
    if (_interpolationMethod == kCosineInterpolation) {
        return [self cosineInterpolationBetweenValueA:v1 valueB:v2 valueX:fractional_x];
    } else {
        return [self linearInterpolationBetweenValueA:v1 valueB:v2 valueX:fractional_x];
    }
}

- (float)perlin1DValueForPoint:(float)x {
    float value = 0;
    float persistence = _persistence;
    float frequency = _frequency;
    float amplitude;
    for (int i = 0;i < _octaves;i++) {
        
        frequency = powf(frequency, i);
        amplitude = powf(persistence, i);
        
        if (_smoothing) {
            value = value + [self interpolatedNoise1D:(x * frequency) * frequency] * amplitude;
        } else {
            value = value + [self makeNoise1D:(x * frequency) * frequency] * amplitude;
        }
        
    }
    
    return value / _octaves * _scale;;
}

#pragma mark - 2D Perlin Functions

- (float)makeNoise2D:(int)x :(int)y {
    int n = x + y * 57;
    n = (n >> 13) ^  (n * _functionSelector);
    n = (n * (n * n * (int)_seed + 19990303) + 1376312589) & RAND_MAX;
    return ( 1.0 - ( (n * (n * n * 15731 + 789221) + 1376312589) & RAND_MAX) / 1073741824.0);
}

- (float)smoothedNoise2D:(float)x :(float)y {
    float corners = ([self makeNoise2D:x-1 :y-1] + [self makeNoise2D:x+1 :y-1] +
                     [self makeNoise2D:x-1 :y+1] + [self makeNoise2D:x+1 :y+1]) / 16;
    float sides = ([self makeNoise2D:x-1 :y] + [self makeNoise2D:x+1 :y] +
                   [self makeNoise2D:x :y+1] + [self makeNoise2D:x :y+1]) / 8;
    float center = [self makeNoise2D:x :y] / 4;
    
    return corners + sides + center;
}

- (float)interpolatedNoise2D:(float)x :(float)y {
    int integer_x = (int)x;
    float fractional_x = x-integer_x;
    
    int integer_y = (int)y;
    float fractional_y = y-integer_y;
    
    float v1 = [self smoothedNoise2D:integer_x :integer_y];
    float v2 = [self smoothedNoise2D:integer_x + 1 :integer_y];
    float v3 = [self smoothedNoise2D:integer_x :integer_y + 1];
    float v4 = [self smoothedNoise2D:integer_x + 1 :integer_y + 1];

    
    if (_interpolationMethod == kCosineInterpolation) {
        float i1 = [self cosineInterpolationBetweenValueA:v1 valueB:v2 valueX:fractional_x];
        float i2 = [self cosineInterpolationBetweenValueA:v3 valueB:v4 valueX:fractional_x];
        return [self cosineInterpolationBetweenValueA:i1 valueB:i2 valueX:fractional_y];
    } else {
        float i1 = [self linearInterpolationBetweenValueA:v1 valueB:v2 valueX:fractional_x];
        float i2 = [self linearInterpolationBetweenValueA:v3 valueB:v4 valueX:fractional_x];
        return [self linearInterpolationBetweenValueA:i1 valueB:i2 valueX:fractional_y];
    }
}

- (float)perlin2DValueForPoint:(float)x :(float)y{
    _functionSelector = 1;
    float value = 0;
    float persistence = _persistence;
    float frequency = _frequency;
    float amplitude;
    for (int i = 0;i < _octaves;i++) {
        
        frequency = powf(frequency, i);
        amplitude = powf(persistence, i);
        
        if (_smoothing) {
            value = value + [self interpolatedNoise2D:(x * _frequency) * frequency :(y * _frequency) * frequency] * amplitude;
        } else {
            value = value + [self makeNoise2D:(x * _frequency) * frequency :(y * _frequency) * frequency] * amplitude;

        }

        _functionSelector++;
    }
    return value / _octaves * _scale;
}

@end
