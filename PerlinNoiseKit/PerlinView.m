//
//  PerlinView.m
//  PerlinTest
//
//  Created by Weston Hanners on 7/16/12.
//  Copyright (c) 2012 Hanners Software. All rights reserved.
//

#import "PerlinView.h"
#import "PerlinNoise.h"

@implementation PerlinView {
    int offset;
    NSTimer *timer;
}

@synthesize perlin = _perlin, is2D = _is2D,resolution = _resolution;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //[self setBackgroundColor:[UIColor whiteColor]];
        //timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(scroll:) userInfo:nil repeats:YES];
        _perlin = [[PerlinNoise alloc] initWithSeed:25];
        offset = 0;
        _is2D = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        offset = 0;
        _is2D = NO;
    }
    return self;
}

- (void)scroll:(id)sender {
    offset+=1;
    [self setNeedsDisplay];
}

- (void)debug:(float)z {
    if (z == 0) {
        NSLog(@"0");
    }
    
    if (z > 1 || z < -1) {
        NSLog(@"z:%f is out of range.", z);
    }
}

- (void)drawRect:(CGRect)rect {
    
    int step = _resolution;
    
    if (!_resolution) {
        step = 10;
    }
    
    if (!self.is2D) {

        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        [[UIColor greenColor] setStroke];
        
        [path moveToPoint:CGPointMake(0, CGRectGetMidY(rect))];
        
        for (int x = 0; x <= CGRectGetMaxX(rect); x+=step) {
            float y = [self.perlin perlin1DValueForPoint:x];
            [path addLineToPoint:CGPointMake(x, y * 100 + CGRectGetMidY(rect))];
            
        }
        
        [path stroke];
    } else {
    
        
        for (int x = 0; x <= CGRectGetMaxX(rect); x+=step) {
            for (int y = 0; y <= CGRectGetMaxY(rect); y+=step) {
                
                float z = [self.perlin perlin2DValueForPoint:x :y];
                
                float value = (z + 1) * 0.5;
                
                UIColor *color = [UIColor colorWithWhite:value alpha:1];
                [color setFill];
                UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, step, step)];

                [path fill];
                
            }
        }
    }
}


@end
