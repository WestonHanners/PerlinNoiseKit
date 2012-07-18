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

@synthesize perlin = _perlin, is3D = _is3D,resolution = _resolution;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        //timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(scroll:) userInfo:nil repeats:YES];
        offset = 0;
        _is3D = NO;
    }
    return self;
}

- (void)scroll:(id)sender {
    offset+=1;
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    float z = 0;

    if (_is3D == YES) {
        for (int i = 0; i <= rect.size.width; i+=_resolution) {
            for (int j = 0; j <= rect.size.height; j+=_resolution) {
                point2D px;
                px.x = i + offset;
                px.y = j + offset;
                z = [_perlin perlin2DValueForPoint:px];
                CGContextSetRGBFillColor(ctx, 0.0, 0.0, 0.0, fabsf(z));
                CGContextFillRect(ctx, CGRectMake(i, j, _resolution, _resolution));
            }
        }
    } else {
        UIBezierPath *p = [[UIBezierPath alloc] init];
        [p setLineWidth:2];
        [p moveToPoint:CGPointMake(0, ((rect.size.height) / 2))];
        for (int i = 0; i <= rect.size.width; i+=_resolution) {
            point1D px;
            px.x = i + offset;
            z = [_perlin perlin1DValueForPoint:px] + ((rect.size.height) / 2);
            [p addLineToPoint:CGPointMake(i, z)];
        }
        [p stroke];
            
    }
}

@end
