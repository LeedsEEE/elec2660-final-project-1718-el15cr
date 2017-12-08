//
//  MicrophoneViewController.h
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 21/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterfaceViewController.h"

@interface MicrophoneViewController : UIViewController

@property (nonatomic, strong) audioEngine *audioEngine;
@property (nonatomic, strong) settings *settings;
@property (nonatomic, strong) NSTimer *timerRecord;

@property (weak, nonatomic) IBOutlet UISlider *sliderOverlap;
@property (weak, nonatomic) IBOutlet UISlider *sliderPitch;
@property (weak, nonatomic) IBOutlet UISlider *sliderRate;
@property (weak, nonatomic) IBOutlet UISwitch *switchLoop;
@property (weak, nonatomic) IBOutlet UIButton *buttonPlay;
@property (weak, nonatomic) IBOutlet UIButton *buttonRecord;
@property (weak, nonatomic) IBOutlet UIButton *buttonRecordText;


- (IBAction)didTapPlay:(UIButton *)sender;
- (IBAction)didTapRecord:(UIButton *)sender;
- (IBAction)didSlideLoop:(UISwitch *)sender;
- (IBAction)didMoveSliderOverlap:(UISlider *)sender;
- (IBAction)didMoveSliderPitch:(UISlider *)sender;
- (IBAction)didMoveSliderRate:(UISlider *)sender;



@end
