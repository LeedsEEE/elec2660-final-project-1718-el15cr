//
//  SettingsViewController.h
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 21/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterfaceViewController.h"

@interface SettingsViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property settings *settings;
@property audioEngine *audioEngine; 

@property (weak, nonatomic) IBOutlet UIPickerView *pickerUserPreset;
@property (weak, nonatomic) IBOutlet UISwitch *switchMetronome;
@property (weak, nonatomic) IBOutlet UISlider *sliderMetronome;


- (IBAction)didTapStorePreset:(UIButton *)sender;
- (IBAction)didTapLoadPreset:(UIButton *)sender;
- (IBAction)didMoveSliderMetronome:(UISlider *)sender;
- (IBAction)didMoveSwitchMetronome:(UISwitch *)sender;


@end
