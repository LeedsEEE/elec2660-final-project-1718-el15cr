//
//  DelayViewController.m
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 21/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import "DelayViewController.h"

@interface DelayViewController ()

@end

@implementation DelayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.sliderWetDry.value = self.audioEngine.audioUnitDelay.wetDryMix;
    self.sliderDelayTime.value = self.audioEngine.audioUnitDelay.delayTime;
    self.sliderFeedback.value = self.audioEngine.audioUnitDelay.feedback;
    self.sliderLowPassCutoff.value = self.audioEngine.audioUnitDelay.lowPassCutoff;
    self.sliderInstrument1.value = self.audioEngine.sendDelayInstrument1.volume;
    self.sliderInstrument2.value = self.audioEngine.sendDelayInstrument2.volume;
    self.sliderDrums.value = self.audioEngine.sendDelayDrums.volume;
    self.sliderMicrophone.value = self.audioEngine.sendDelayMicrophone.volume;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didMoveSliderMicrophone:(UISlider *)sender {
    
    [self.audioEngine sendsForDelay:self.sliderInstrument1.value :self.sliderInstrument2.value :self.sliderDrums.value :self.sliderMicrophone.value];
    
}

- (IBAction)didMoveSliderDrums:(UISlider *)sender {
    
    [self.audioEngine sendsForDelay:self.sliderInstrument1.value :self.sliderInstrument2.value :self.sliderDrums.value :self.sliderMicrophone.value];
    
}

- (IBAction)didMoveSliderInstrument2:(UISlider *)sender {
    
    [self.audioEngine sendsForDelay:self.sliderInstrument1.value :self.sliderInstrument2.value :self.sliderDrums.value :self.sliderMicrophone.value];
    
}

- (IBAction)didMoveSliderInstrument1:(UISlider *)sender {
    
    [self.audioEngine sendsForDelay:self.sliderInstrument1.value :self.sliderInstrument2.value :self.sliderDrums.value :self.sliderMicrophone.value];
    
}

- (IBAction)didMoveSliderLowPassCutoff:(UISlider *)sender {
    
    [self.audioEngine audioUnitDelayLowPassCutoff:self.sliderLowPassCutoff.value];
    
}

- (IBAction)didMoveSliderFeedback:(UISlider *)sender {
    
    [self.audioEngine audioUnitDelayFeedback:self.sliderFeedback.value];
    
}

- (IBAction)didMoveSliderDelayTime:(UISlider *)sender {
    
    [self.audioEngine audioUnitDelayTime:self.sliderDelayTime.value];
    
}

- (IBAction)didMoveSliderDryWetMix:(UISlider *)sender {
    
    [self.audioEngine audioUnitDelayWetDry:self.sliderWetDry.value];
    
}
@end
