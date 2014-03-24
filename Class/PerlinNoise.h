//
//  PerlinNoise.h
//  PerlinTest
//
//  Created by Weston Hanners on 7/16/12.
//  Copyright (c) 2012 Hanners Software. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kLinearInterpolation = 0,
    kCosineInterpolation = 1
} interpolationType;

@interface PerlinNoise : NSObject

- (id)initWithSeed:(int)seed;
- (float)perlin1DValueForPoint:(float)x;
- (float)perlin2DValueForPoint:(float)x :(float)y;

@property int seed;
@property int octaves;
@property float persistence;
@property float scale;
@property float frequency;
@property float amplitude;
@property interpolationType interpolationMethod;
@property BOOL smoothing;

@end
