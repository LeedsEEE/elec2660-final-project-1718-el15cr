//
//  MicrophoneViewController.m
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 21/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import "MicrophoneViewController.h"

@interface MicrophoneViewController ()

@end

@implementation MicrophoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.sliderRate.value = self.audioEngine.audioUnitTimePitch.rate;
    self.sliderOverlap.value = self.audioEngine.audioUnitTimePitch.overlap;
    self.sliderPitch.value = self.audioEngine.audioUnitTimePitch.pitch;
    
    self.audioEngine.isLoopMicrophone = self.switchLoop.isOn;
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

- (IBAction)didTapPlay:(UIButton *)sender {
    
    [self.audioEngine startPlayingMicrophone]; 
    
}
- (IBAction)didTapRecord:(UIButton *)sender {
    
    if (self.audioEngine.isRecordingMicrophone == false){
        
        [self.audioEngine startRecordingMicrophone];
        
    } else {
        
        [self.audioEngine stopRecordingMicrophone];
        
    }
}

- (IBAction)didSlideLoop:(UISwitch *)sender {
    
    self.audioEngine.isLoopMicrophone = self.switchLoop.isOn;
    
}

- (IBAction)didMoveSliderOverlap:(UISlider *)sender {
    
    [self.audioEngine audioUnitTimePitchOverlap:self.sliderOverlap.value];
    
}
- (IBAction)didMoveSliderPitch:(UISlider *)sender {
    
    [self.audioEngine audioUnitTimePitch:self.sliderPitch.value];
    
}

- (IBAction)didMoveSliderRate:(UISlider *)sender {
    
    [self.audioEngine audioUnitTimePitchRate:self.sliderRate.value];
    
}

- (IBAction)didMoveSliderPan:(UISlider *)sender {
}
@end
