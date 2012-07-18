//
//  PerlinNoiseKitTests.m
//  PerlinNoiseKitTests
//
//  Created by Weston Hanners on 7/18/12.
//  Copyright (c) 2012 Hanners Software. All rights reserved.
//

#import "PerlinNoiseKitTests.h"

@implementation PerlinNoiseKitTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)test1DPerlinNoise
{
    PerlinNoise *p = [[PerlinNoise alloc] initWithSeed:25];
    
    for (int i = 0; i < 10000; i++) {
        float n = [p perlin1DValueForPoint:i];
        if (n > 1 || n < 0) {
            STFail(@"Iteration %i was out of range in 1D function.");
        }
    }
}

- (void)test2DPerlinNoise
{
    PerlinNoise *p = [[PerlinNoise alloc] initWithSeed:25];
    for (int j = 0; j < 10000; j++) {
        for (int i = 0; i < 10000; i++) {
            float n = [p perlin2DValueForPoint:i :j];
            if (n > 1 || n < 0) {
                STFail(@"Iteration %i was out of range in 2D function.");
            }
        }
    }
}

@end
