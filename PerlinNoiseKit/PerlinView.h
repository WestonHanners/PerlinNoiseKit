//
//  PerlinView.h
//  PerlinTest
//
//  Created by Weston Hanners on 7/16/12.
//  Copyright (c) 2012 Hanners Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PerlinNoise.h"

@interface PerlinView : UIView

@property (strong, nonatomic) PerlinNoise *perlin;

@property BOOL is3D;
@property int resolution;
- (void)scroll:(id)sender;
@end
