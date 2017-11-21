//
//  DelayViewController.h
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 21/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterfaceViewController.h"

@interface DelayViewController : UIViewController

@property audioEngine *audioEngine;
@property (weak, nonatomic) IBOutlet UISlider *sliderWetDry;
@property (weak, nonatomic) IBOutlet UISlider *sliderDelayTime;
@property (weak, nonatomic) IBOutlet UISlider *sliderFeedback;
@property (weak, nonatomic) IBOutlet UISlider *sliderLowPassCutoff;
@property (weak, nonatomic) IBOutlet UISlider *sliderInstrument1;
@property (weak, nonatomic) IBOutlet UISlider *sliderInstrument2;
@property (weak, nonatomic) IBOutlet UISlider *sliderDrums;
@property (weak, nonatomic) IBOutlet UISlider *sliderMicrophone;

- (IBAction)didMoveSliderMicrophone:(UISlider *)sender;
- (IBAction)didMoveSliderDrums:(UISlider *)sender;
- (IBAction)didMoveSliderInstrument2:(UISlider *)sender;
- (IBAction)didMoveSliderInstrument1:(UISlider *)sender;
- (IBAction)didMoveSliderLowPassCutoff:(UISlider *)sender;
- (IBAction)didMoveSliderFeedback:(UISlider *)sender;
- (IBAction)didMoveSliderDelayTime:(UISlider *)sender;
- (IBAction)didMoveSliderDryWetMix:(UISlider *)sender;


@end
