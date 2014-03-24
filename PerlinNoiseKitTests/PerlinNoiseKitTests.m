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

- (void)test1DPerlinNoise {
    
    PerlinNoise *p = [[PerlinNoise alloc] initWithSeed:25];
    
    for (int i = 0; i < 10000; i++) {
        float n = [p perlin1DValueForPoint:i];
        if (n > 1 || n < -1) {
            XCTFail(@"Iteration was out of range in 1D function. Value: %f", n);
        }
    }
}

- (void)test1DPerlinNoisePersistance {
    
    float noiseStore[100];
    
    for (int value = 0; value < 100; value++) {
        
        PerlinNoise *p = [[PerlinNoise alloc] initWithSeed:25];
                // Init store
            noiseStore[value] = [p perlin1DValueForPoint:value];
    }
    
    for (int iteration = 0; iteration < 100; iteration++) {
        
        PerlinNoise *p = [[PerlinNoise alloc] initWithSeed:25];
        
        for (int value = 0; value < 100; value++) {
            float pv = [p perlin1DValueForPoint:value];
            float sv = noiseStore[value];
            
            if (pv != sv) {
                XCTFail(@"Iteration was incosistent pv: %f sv: %f", pv, sv);
            }
        }
    }
}

- (void)testPerlinVariety {
    
    float noise = 0;
    
    int failCount = 0;
    
    PerlinNoise *p = [[PerlinNoise alloc] initWithSeed:25];
    
    for (int count = 0; count < 100; count++) {
        
        float curNoise = [p perlin1DValueForPoint:count];
        if (curNoise == noise) {
            failCount++;
        }
        noise = curNoise;
    }
    
    if (failCount > 10) {
        XCTFail(@"Noise Fail Count was too high %d", failCount);
    }
    
}

- (void)test2DPerlinNoise {
    
    PerlinNoise *p = [[PerlinNoise alloc] initWithSeed:25];
    
    for (int j = 0; j < 100; j++) {
        for (int i = 0; i < 100; i++) {
            float n = [p perlin2DValueForPoint:i :j];
            if (n > 1 || n < -1) {
                XCTFail(@"Iteration was out of range in 2D function.");
            }
        }
    }
}

@end
