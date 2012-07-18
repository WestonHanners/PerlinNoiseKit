//
//  PerlinNoise.h
//  PerlinTest
//
//  Created by Weston Hanners on 7/16/12.
//  Copyright (c) 2012 Hanners Software. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    float x;
} point1D;

typedef struct {
    float x;
    float y;
} point2D;

typedef struct {
    float x;
    float y;
    float z;
} point3D;

typedef enum {
    kLinearInterpolation = 0,
    kCosineInterpolation = 1
} interpolationType;

@interface PerlinNoise : NSObject

- (id)initWithSeed:(int)seed;
- (float)perlin1DValueForPoint:(point1D)point;
- (float)perlin2DValueForPoint:(point2D)point;
- (float)perlin2DValueForPoint:(point2D)point;

@property int seed;
@property int octaves;
@property float persistence;
@property float scale;
@property float frequency;
@property interpolationType interpolationMethod;

@end
