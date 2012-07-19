//
//  PerlinViewController.m
//  PerlinTest
//
//  Created by Weston Hanners on 7/16/12.
//  Copyright (c) 2012 Hanners Software. All rights reserved.
//

#import "PerlinViewController.h"
#import "PerlinView.h"

@interface PerlinViewController () {
    PerlinNoise *perlin;
}

@end

@implementation PerlinViewController
@synthesize pview;
@synthesize sliderOctaves;
@synthesize sliderFrequency;
@synthesize sliderPersistence;
@synthesize sliderResolution;
@synthesize sliderScale;
@synthesize switch2D;
@synthesize switchCosine;
@synthesize switchSmoothing;
@synthesize labelOctaves;
@synthesize labelFrequency;
@synthesize labelPersistence;
@synthesize labelResolution;
@synthesize labelScale;
@synthesize textSeed;

- (IBAction)updates:(id)sender {
    labelOctaves.text = [NSString stringWithFormat:@"%f", sliderOctaves.value];
    perlin.octaves = sliderOctaves.value;
    labelFrequency.text = [NSString stringWithFormat:@"%f", sliderFrequency.value];
    perlin.frequency = sliderFrequency.value;
    labelPersistence.text = [NSString stringWithFormat:@"%f", sliderPersistence.value];
    perlin.persistence = sliderPersistence.value;
    labelResolution.text = [NSString stringWithFormat:@"%f", sliderResolution.value];
    labelScale.text = [NSString stringWithFormat:@"%f", sliderScale.value];
}

- (IBAction)reload:(id)sender {
    // 1D or 2D?
    if (switch2D.on == YES) {
        pview.is2D = YES;
    } else {
        pview.is2D = NO;
    }
    
    
    // Interpolated or not?
    if (switchCosine.on == YES) {
        perlin.interpolationMethod = kCosineInterpolation;
    } else {
        perlin.interpolationMethod = kLinearInterpolation;
    }
    
    // Set perlin properties.
    pview.resolution = sliderResolution.value;
    perlin.persistence = sliderPersistence.value;
    perlin.frequency = sliderFrequency.value;
    perlin.scale = sliderScale.value;
    perlin.octaves = sliderOctaves.value;
    perlin.seed = [textSeed.text intValue];
    
    // Print our values to the log for debugging.
    NSLog(@"\nPersistance: %f\nFrequency: %f\nScale:%f\nOctaves %d", perlin.persistence, perlin.frequency, perlin.scale, perlin.octaves);
    
    // Redraw.
    [pview setNeedsDisplay];
    
}


//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    NSLog(@"%@", self.view);
//    perlin = [[PerlinNoise alloc] initWithSeed:25];
//    pview.perlin = perlin;
//}

- (void)viewDidUnload {
    [self setSliderOctaves:nil];
    [self setSliderFrequency:nil];
    [self setSliderResolution:nil];
    [self setSliderScale:nil];
    [self setSwitch2D:nil];
    [self setSwitchCosine:nil];
    [self setSwitchSmoothing:nil];
    [self setLabelOctaves:nil];
    [self setLabelFrequency:nil];
    [self setLabelPersistence:nil];
    [self setLabelResolution:nil];
    [self setLabelScale:nil];
    [self setTextSeed:nil];
    [self setPview:nil];
    [super viewDidUnload];
}
@end