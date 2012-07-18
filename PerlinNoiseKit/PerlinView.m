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
        [self setBackgroundColor:[UIColor whiteColor]];
        //timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(scroll:) userInfo:nil repeats:YES];
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


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    float z = 0;

    if (_is2D == YES) {
        for (int i = 0; i <= rect.size.width; i+=_resolution) {
            for (int j = 0; j <= rect.size.height; j+=_resolution) {
                z = [_perlin perlin2DValueForPoint:(i + offset) :(j + offset)];
                [[UIColor colorWithWhite:fabsf(z * 3) alpha:1] setFill];
                UIRectFill(CGRectMake(i, j, _resolution, _resolution));
                [self debug:z];
            }
        }
    } else {
        UIBezierPath *p = [[UIBezierPath alloc] init];
        [p setLineWidth:2];
        [p moveToPoint:CGPointMake(0, [_perlin perlin1DValueForPoint:0])];
        for (int i = 0; i <= rect.size.width; i+=_resolution) {
            z = [_perlin perlin1DValueForPoint:(i + offset)];
            [p addLineToPoint:CGPointMake(i, ((z * 5) + (rect.size.height) / 2))];
            [self debug:(z / _perlin.scale)];
        }
        [p stroke];
            
    }
}

@end
