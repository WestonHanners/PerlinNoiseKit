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
    PerlinView *pview;
    PerlinNoise * perlin;
    UISlider *persistance;
    UISlider *octaves;
    UISlider *frequency;
    UISlider *scale;
    UISwitch *interpolation;
    UISwitch *is3DSwitch;
    UISlider *resolution;

}

@end

@implementation PerlinViewController


- (void)updates:(id)sender {
    if (is3DSwitch.on == YES) {
        pview.is3D = YES;
    } else {
        pview.is3D = NO;
    }
    if (interpolation.on == YES) {
        perlin.interpolationMethod = kCosineInterpolation;
    } else {
        perlin.interpolationMethod = kLinearInterpolation;
    }
    pview.resolution = resolution.value;
    perlin.persistence = persistance.value;
    perlin.frequency = frequency.value;
    perlin.scale = scale.value;
    perlin.octaves = octaves.value;
    
    // Print our values to the log for debugging
    NSLog(@"\nPersistance: %f\nFrequency: %f\nScale:%f\n Octaves %d", perlin.persistence, perlin.frequency, perlin.scale, perlin.octaves);
    [pview setNeedsDisplay];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    perlin = [[PerlinNoise alloc] initWithSeed:25];
    
    persistance = [[UISlider alloc] initWithFrame:CGRectMake(0, 250, 320, 30)];
    octaves = [[UISlider alloc] initWithFrame:CGRectMake(0, 280, 320, 30)];
    frequency = [[UISlider alloc] initWithFrame:CGRectMake(0, 310, 320, 30)];
    scale = [[UISlider alloc] initWithFrame:CGRectMake(0, 340, 320, 30)];
    resolution = [[UISlider alloc] initWithFrame:CGRectMake(0, 370, 320, 30)];
    interpolation = [[UISwitch alloc] initWithFrame:CGRectMake(180, 420, 100, 100)];
    is3DSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(70, 420, 100, 100)];


    persistance.maximumValue = 1.00f;
    persistance.minimumValue = 0.00f;
    persistance.value = 0.0f;
    persistance.continuous = YES;
    
    octaves.maximumValue = 5;
    octaves.minimumValue = 1;
    octaves.value = 1;
    octaves.continuous = YES;
    
    frequency.maximumValue = 1.00f;
    frequency.minimumValue = 0.00f;
    frequency.value = 0.0f;
    frequency.continuous = YES;
    
    scale.maximumValue = 100;
    scale.minimumValue = 1;
    scale.value = 1;
    scale.continuous = YES;
    
    resolution.maximumValue = 50;
    resolution.minimumValue = 1;
    resolution.value = 1;
    resolution.continuous = YES;

    [self.view addSubview:persistance];
    [self.view addSubview:octaves];
    [self.view addSubview:frequency];
    [self.view addSubview:scale];
    [self.view addSubview:interpolation];
    [self.view addSubview:resolution];
    [self.view addSubview:is3DSwitch];
    
    [persistance addTarget:self action:@selector(updates:) forControlEvents:UIControlEventValueChanged];
    [octaves addTarget:self action:@selector(updates:) forControlEvents:UIControlEventValueChanged];
    [frequency addTarget:self action:@selector(updates:) forControlEvents:UIControlEventValueChanged];
    [scale addTarget:self action:@selector(updates:) forControlEvents:UIControlEventValueChanged];
    [resolution addTarget:self action:@selector(updates:) forControlEvents:UIControlEventValueChanged];
    [interpolation addTarget:self action:@selector(updates:) forControlEvents:UIControlEventValueChanged];
    [is3DSwitch addTarget:self action:@selector(updates:) forControlEvents:UIControlEventValueChanged];

    pview = [[PerlinView alloc] initWithFrame:CGRectMake(0, 0, 320, 250)];
    pview.perlin = perlin;
    [self updates:nil];
    [self.view addSubview:pview];
    
}


@end
