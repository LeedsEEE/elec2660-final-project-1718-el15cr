//
//  DistortionViewController.h
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 21/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterfaceViewController.h"

@interface DistortionViewController : UIViewController

@property audioEngine *audioEngine;

@property (weak, nonatomic) IBOutlet UISlider *sliderDryWetMix;
@property (weak, nonatomic) IBOutlet UISlider *sliderPreGain;
@property (weak, nonatomic) IBOutlet UISlider *sliderInstrument1;
@property (weak, nonatomic) IBOutlet UISlider *sliderInstrument2;
@property (weak, nonatomic) IBOutlet UISlider *sliderDrums;
@property (weak, nonatomic) IBOutlet UISlider *sliderMicrophone;

- (IBAction)didMoveSliderDryWetMix:(UISlider *)sender;
- (IBAction)didMoveSliderPreGain:(UISlider *)sender;
- (IBAction)didMoveSliderInstrument1:(UISlider *)sender;
- (IBAction)didMoveSliderInstrument2:(UISlider *)sender;
- (IBAction)didMoveSliderDrums:(UISlider *)sender;
- (IBAction)didMoveSliderMicrophone:(UISlider *)sender;


@end
