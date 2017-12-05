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
    
    self.buttonRecord.layer.cornerRadius = 10;
    self.buttonPlay.layer.cornerRadius = 10;
    
    if (self.audioEngine.playerMicrophone.isPlaying == true) {
        
        [self.buttonPlay setTitle:@"Stop" forState:UIControlStateNormal];
        
    } else if (self.audioEngine.playerMicrophone.isPlaying == false){
        
        [self.buttonPlay setTitle:@"Play" forState:UIControlStateNormal];
        
    }
    
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
    
    if (self.audioEngine.playerMicrophone.isPlaying == true) {
        
        [self.buttonPlay setTitle:@"Stop" forState:UIControlStateNormal];
        
    } else if (self.audioEngine.playerMicrophone.isPlaying == false){
        
        [self.buttonPlay setTitle:@"Play" forState:UIControlStateNormal];
        
    }
    
}
- (IBAction)didTapRecord:(UIButton *)sender {
    
    if (self.audioEngine.isRecordingMicrophone == false){
        
        self.audioEngine.isRecordingMicrophone = true;
        
        self.timerRecord = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(recordMicrophone:) userInfo:nil repeats:NO];
        
        [self performSelector: @selector(recordTextLabe1:) withObject:self afterDelay: 2.0];
        [self performSelector: @selector(recordTextLabe2:) withObject:self afterDelay: 1.0];
        [self performSelector: @selector(recordTextLabe3:) withObject:self afterDelay: 0.0];
        
    } else {
        
        [self.buttonRecord setTitle:@"Record" forState:UIControlStateNormal];
        
        [self.timerRecord invalidate];
        
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

-(void) recordMicrophone: (NSTimer*) timer {
    
    [self.audioEngine startRecordingMicrophone];
    
}

-(void) recordTextLabe1: (id) trigger {
    
    [self.buttonRecord setTitle:@"Recording" forState:UIControlStateNormal];
}

-(void) recordTextLabe2: (id) trigger {
    
    [self.buttonRecord setTitle:@"2" forState:UIControlStateNormal];
}

-(void) recordTextLabe3: (id) trigger {
    
    [self.buttonRecord setTitle:@"1" forState:UIControlStateNormal];
}

@end
