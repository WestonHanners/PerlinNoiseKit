//
//  PerlinViewController.h
//  PerlinTest
//
//  Created by Weston Hanners on 7/16/12.
//  Copyright (c) 2012 Hanners Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PerlinView.h"

@interface PerlinViewController : UIViewController

- (IBAction)updates:(id)sender;
- (IBAction)reload:(id)sender;

@property (weak, nonatomic) IBOutlet PerlinView *pview;
@property (weak, nonatomic) IBOutlet UISlider *sliderOctaves;
@property (weak, nonatomic) IBOutlet UISlider *sliderFrequency;
@property (weak, nonatomic) IBOutlet UISlider *sliderPersistence;
@property (weak, nonatomic) IBOutlet UISlider *sliderResolution;
@property (weak, nonatomic) IBOutlet UISlider *sliderScale;
@property (weak, nonatomic) IBOutlet UISwitch *switch2D;
@property (weak, nonatomic) IBOutlet UISwitch *switchCosine;
@property (weak, nonatomic) IBOutlet UISwitch *switchSmoothing;
@property (weak, nonatomic) IBOutlet UILabel *labelOctaves;
@property (weak, nonatomic) IBOutlet UILabel *labelFrequency;
@property (weak, nonatomic) IBOutlet UILabel *labelPersistence;
@property (weak, nonatomic) IBOutlet UILabel *labelResolution;
@property (weak, nonatomic) IBOutlet UILabel *labelScale;
@property (weak, nonatomic) IBOutlet UITextField *textSeed;

@end
