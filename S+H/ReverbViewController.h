//
//  ReverbViewController.h
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 21/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterfaceViewController.h"

@interface ReverbViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property audioEngine *audioEngine;
@property settings *settings; 

@property (weak, nonatomic) IBOutlet UIPickerView *pickerReverb;
@property (weak, nonatomic) IBOutlet UISlider *sliderWetDryMix;
@property (weak, nonatomic) IBOutlet UISlider *sliderInstrument1;
@property (weak, nonatomic) IBOutlet UISlider *sliderInstrument2;
@property (weak, nonatomic) IBOutlet UISlider *sliderDrums;
@property (weak, nonatomic) IBOutlet UISlider *sliderMicrophone;

- (IBAction)didMoveSliderWetDryMix:(UISlider *)sender;
- (IBAction)didMoveSliderInstrument1:(UISlider *)sender;
- (IBAction)didMoveSliderInstrument2:(UISlider *)sender;
- (IBAction)didMoveSliderDrums:(UISlider *)sender;
- (IBAction)didMoveSliderMicrophone:(UISlider *)sender;




@end
