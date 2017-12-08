//
//  MicrophoneViewController.m
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 21/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

// References
//
// https://developer.apple.com/documentation/uikit/uiviewcontroller/1621473-unwindforsegue
// https://developer.apple.com/documentation/objectivec/nsobject/1410849-cancelpreviousperformrequestswit?language=objc

#import "MicrophoneViewController.h"

@interface MicrophoneViewController ()

@end

@implementation MicrophoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Loads the values from audio engine, so when the segue is done it shows the correct value
    
    self.sliderRate.value = self.audioEngine.audioUnitTimePitch.rate;
    self.sliderOverlap.value = self.audioEngine.audioUnitTimePitch.overlap;
    self.sliderPitch.value = self.audioEngine.audioUnitTimePitch.pitch;
    
    self.buttonRecord.layer.cornerRadius = 10;
    self.buttonPlay.layer.cornerRadius = 10;
    
    if (self.audioEngine.playerMicrophone.isPlaying == true) {
        
        [self.buttonPlay setImage:[UIImage imageNamed:@"stopButton.png"] forState:UIControlStateNormal];
        
    } else if (self.audioEngine.playerMicrophone.isPlaying == false){
        
        [self.buttonPlay setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
        
    }
    
    self.audioEngine.isLoopMicrophone = self.switchLoop.isOn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) unwindForSegue:(nonnull UIStoryboardSegue *)unwindSegue towardsViewController:(nonnull UIViewController *)subsequentVC{
    
    // Goes back from segue to the original view controller
    
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
        
        [self.buttonPlay setImage:[UIImage imageNamed:@"stopButton.png"] forState:UIControlStateNormal];
        
    } else if (self.audioEngine.playerMicrophone.isPlaying == false){
        
        [self.buttonPlay setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
        
    }
    
}
- (IBAction)didTapRecord:(UIButton *)sender {
    
    // A delay is achived by using a timer
    // this has been added to allow the user time to move their hand
    // to the right notes they want to play
    
    [self.buttonRecord setImage:[UIImage imageNamed:@"recordButton1.png"] forState:UIControlStateNormal];
    
    if (self.audioEngine.isRecordingMicrophone == false){
        
        self.audioEngine.isRecordingMicrophone = true;
        
        self.timerRecord = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(recordMicrophone:) userInfo:nil repeats:NO];
        
        [self performSelector: @selector(recordTextLabe1:) withObject:self afterDelay: 2.0];
        [self performSelector: @selector(recordTextLabe2:) withObject:self afterDelay: 1.0];
        [self performSelector: @selector(recordTextLabe3:) withObject:self afterDelay: 0.0];
        
    } else {
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(recordTextLabe1:) object:nil];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(recordTextLabe2:) object:nil];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(recordTextLabe3:) object:nil];
        
        [self.timerRecord invalidate];
        
        [self.audioEngine stopRecordingMicrophone];
        
        [self.buttonRecordText setTitle:@"" forState:UIControlStateNormal];
        
        [self.buttonRecord setImage:[UIImage imageNamed:@"recordButton1.png"] forState:UIControlStateNormal];
        
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
    
    [self.buttonRecord setImage:[UIImage imageNamed:@"recordButton2.png"] forState:UIControlStateNormal];
}

-(void) recordTextLabe2: (id) trigger {
    
    [self.buttonRecordText setTitle:@"2" forState:UIControlStateNormal];
}

-(void) recordTextLabe3: (id) trigger {
    
    [self.buttonRecordText setTitle:@"1" forState:UIControlStateNormal];
}

@end
