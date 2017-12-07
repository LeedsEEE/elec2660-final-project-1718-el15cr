//
//  SettingsViewController.m
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 21/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

// References
//
// https://developer.apple.com/documentation/uikit/uiviewcontroller/1621473-unwindforsegue

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Loads the values from audio engine, so when the segue is done it shows the correct value
    
    self.pickerUserPreset.delegate = self;
    self.pickerUserPreset.dataSource = self;
    
    self.buttonLoadPreset.layer.cornerRadius = 10;
    self.buttonStorePreset.layer.cornerRadius = 10;
    
    [self.pickerUserPreset selectRow:self.settings.selectedUserPreset inComponent:0 animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) unwindForSegue:(nonnull UIStoryboardSegue *)unwindSegue towardsViewController:(nonnull UIViewController *)subsequentVC{
    
    // Goes back from segue to the original view controller
    
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    // When the picker has been moved it changes the value
    // this is done by sending the vaule of the picker to the settings class
    
    self.settings.selectedUserPreset = [self.pickerUserPreset selectedRowInComponent:0];
    
    NSLog(@"User preset selected: %@",self.settings.pickerUserPresetData[row]);
    
    
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}


-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.settings.pickerUserPresetData.count;
    
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return self.settings.pickerUserPresetData[row];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)didTapLoadPreset:(UIButton *)sender {
    
    [self.settings loadUserPreset];
    
    [self loadUserPresetData];
    
}

- (IBAction)didTapStorePreset:(UIButton *)sender {
    
    [self storeUserPresetData];
    
    [self.settings storeUserPreset];
    
}

-(void) storeUserPresetData {
    
    // Stores the current values to an array so the user can load them later
    
    if (self.settings.selectedUserPreset == 0){
    
        NSNumber *reverbSelected = [NSNumber numberWithInteger:self.settings.selectedReverb];
        [self.settings.userPresetData1 insertObject:reverbSelected atIndex:0];
    
        NSNumber *reverbWetDry = [NSNumber numberWithFloat:self.audioEngine.audioUnitReverb.wetDryMix];
        [self.settings.userPresetData1 insertObject:reverbWetDry atIndex:1];
    
        NSNumber *reverbSend1 = [NSNumber numberWithFloat:self.audioEngine.sendReverbInstrument1.volume];
        [self.settings.userPresetData1 insertObject:reverbSend1 atIndex:2];
    
        NSNumber *reverbSend2 = [NSNumber numberWithFloat:self.audioEngine.sendReverbInstrument2.volume];
        [self.settings.userPresetData1 insertObject:reverbSend2 atIndex:3];
    
        NSNumber *reverbSend3 = [NSNumber numberWithFloat:self.audioEngine.sendReverbDrums.volume];
        [self.settings.userPresetData1 insertObject:reverbSend3 atIndex:4];
    
        NSNumber *reverbSend4 = [NSNumber numberWithFloat:self.audioEngine.sendReverbMicrophone.volume];
        [self.settings.userPresetData1 insertObject:reverbSend4 atIndex:5];
    
        NSNumber *distortionSelected = [NSNumber numberWithInteger:self.settings.selectedDistortion];
        [self.settings.userPresetData1 insertObject:distortionSelected atIndex:6];
    
        NSNumber *distortionWetDry = [NSNumber numberWithFloat:self.audioEngine.audioUnitDistortion.wetDryMix];
        [self.settings.userPresetData1 insertObject:distortionWetDry atIndex:7];
    
        NSNumber *distortionPreGain = [NSNumber numberWithFloat:self.audioEngine.audioUnitDistortion.preGain];
        [self.settings.userPresetData1 insertObject:distortionPreGain atIndex:8];
    
        NSNumber *distortionSend1 = [NSNumber numberWithFloat:self.audioEngine.sendDistortionInstrument1.volume];
        [self.settings.userPresetData1 insertObject:distortionSend1 atIndex:9];
    
        NSNumber *distortionSend2 = [NSNumber numberWithFloat:self.audioEngine.sendDistortionInstrument2.volume];
        [self.settings.userPresetData1 insertObject:distortionSend2 atIndex:10];
    
        NSNumber *distortionSend3 = [NSNumber numberWithFloat:self.audioEngine.sendDistortionDrums.volume];
        [self.settings.userPresetData1 insertObject:distortionSend3 atIndex:11];
    
        NSNumber *distortionSend4 = [NSNumber numberWithFloat:self.audioEngine.sendDistortionMicrophone.volume];
        [self.settings.userPresetData1 insertObject:distortionSend4 atIndex:12];
    
        NSNumber *delayWetDry = [NSNumber numberWithFloat:self.audioEngine.audioUnitDelay.wetDryMix];
        [self.settings.userPresetData1 insertObject:delayWetDry atIndex:13];
    
        NSNumber *delayTime = [NSNumber numberWithFloat:self.audioEngine.audioUnitDelay.delayTime];
        [self.settings.userPresetData1 insertObject:delayTime atIndex:14];
    
        NSNumber *delayFeedback = [NSNumber numberWithFloat:self.audioEngine.audioUnitDelay.feedback];
        [self.settings.userPresetData1 insertObject:delayFeedback atIndex:15];
    
        NSNumber *delayLowPassCutoff = [NSNumber numberWithFloat:self.audioEngine.audioUnitDelay.lowPassCutoff];
        [self.settings.userPresetData1 insertObject:delayLowPassCutoff atIndex:16];
    
        NSNumber *delaySend1 = [NSNumber numberWithFloat:self.audioEngine.sendDelayInstrument1.volume];
        [self.settings.userPresetData1 insertObject:delaySend1 atIndex:17];
    
        NSNumber *delaySend2 = [NSNumber numberWithFloat:self.audioEngine.sendDelayInstrument2.volume];
        [self.settings.userPresetData1 insertObject:delaySend2 atIndex:18];
    
        NSNumber *delaySend3 = [NSNumber numberWithFloat:self.audioEngine.sendDelayDrums.volume];
        [self.settings.userPresetData1 insertObject:delaySend3 atIndex:19];
    
        NSNumber *delaySend4 = [NSNumber numberWithFloat:self.audioEngine.sendDelayMicrophone.volume];
        [self.settings.userPresetData1 insertObject:delaySend4 atIndex:20];
    
        NSNumber *microphoneOverlap = [NSNumber numberWithFloat:self.audioEngine.audioUnitTimePitch.overlap];
        [self.settings.userPresetData1 insertObject:microphoneOverlap atIndex:21];
    
        NSNumber *microphonePitch = [NSNumber numberWithFloat:self.audioEngine.audioUnitTimePitch.pitch];
        [self.settings.userPresetData1 insertObject:microphonePitch atIndex:22];

        NSNumber *microphoneRate = [NSNumber numberWithFloat:self.audioEngine.audioUnitTimePitch.rate];
        [self.settings.userPresetData1 insertObject:microphoneRate atIndex:23];

        NSNumber *instument1Selected = [NSNumber numberWithInteger:self.settings.selectedInstrument1];
        [self.settings.userPresetData1 insertObject:instument1Selected atIndex:24];

        NSNumber *instument1Pan = [NSNumber numberWithFloat:self.audioEngine.samplerInstrument1.pan];
        [self.settings.userPresetData1 insertObject:instument1Pan atIndex:25];
    
        NSNumber *instument2Selected = [NSNumber numberWithInteger:self.settings.selectedInstrument2];
        [self.settings.userPresetData1 insertObject:instument2Selected atIndex:26];
    
        NSNumber *instument2Pan = [NSNumber numberWithFloat:self.audioEngine.samplerInstrument2.pan];
        [self.settings.userPresetData1 insertObject:instument2Pan atIndex:27];
    
        NSNumber *drumsSelected = [NSNumber numberWithInteger:self.settings.selectedDrums];
        [self.settings.userPresetData1 insertObject:drumsSelected atIndex:28];
    
        NSNumber *mainMix1 = [NSNumber numberWithFloat:self.audioEngine.sendDirectOutInstrument1.volume];
        [self.settings.userPresetData1 insertObject:mainMix1 atIndex:29];
    
        NSNumber *mainMix2 = [NSNumber numberWithFloat:self.audioEngine.sendDirectOutInstrument2.volume];
        [self.settings.userPresetData1 insertObject:mainMix2 atIndex:30];
    
        NSNumber *mainMix3 = [NSNumber numberWithFloat:self.audioEngine.sendDirectOutDrums.volume];
        [self.settings.userPresetData1 insertObject:mainMix3 atIndex:31];
    
        NSNumber *mainMix4 = [NSNumber numberWithFloat:self.audioEngine.sendDirectOutMicrophone.volume];
        [self.settings.userPresetData1 insertObject:mainMix4 atIndex:32];
        
    } else if (self.settings.selectedUserPreset == 1) {
        
        NSNumber *reverbSelected = [NSNumber numberWithInteger:self.settings.selectedReverb];
        [self.settings.userPresetData2  insertObject:reverbSelected atIndex:0];
        
        NSNumber *reverbWetDry = [NSNumber numberWithFloat:self.audioEngine.audioUnitReverb.wetDryMix];
        [self.settings.userPresetData2  insertObject:reverbWetDry atIndex:1];
        
        NSNumber *reverbSend1 = [NSNumber numberWithFloat:self.audioEngine.sendReverbInstrument1.volume];
        [self.settings.userPresetData2  insertObject:reverbSend1 atIndex:2];
        
        NSNumber *reverbSend2 = [NSNumber numberWithFloat:self.audioEngine.sendReverbInstrument2.volume];
        [self.settings.userPresetData2  insertObject:reverbSend2 atIndex:3];
        
        NSNumber *reverbSend3 = [NSNumber numberWithFloat:self.audioEngine.sendReverbDrums.volume];
        [self.settings.userPresetData2  insertObject:reverbSend3 atIndex:4];
        
        NSNumber *reverbSend4 = [NSNumber numberWithFloat:self.audioEngine.sendReverbMicrophone.volume];
        [self.settings.userPresetData2  insertObject:reverbSend4 atIndex:5];
        
        NSNumber *distortionSelected = [NSNumber numberWithInteger:self.settings.selectedDistortion];
        [self.settings.userPresetData2  insertObject:distortionSelected atIndex:6];
        
        NSNumber *distortionWetDry = [NSNumber numberWithFloat:self.audioEngine.audioUnitDistortion.wetDryMix];
        [self.settings.userPresetData2  insertObject:distortionWetDry atIndex:7];
        
        NSNumber *distortionPreGain = [NSNumber numberWithFloat:self.audioEngine.audioUnitDistortion.preGain];
        [self.settings.userPresetData2  insertObject:distortionPreGain atIndex:8];
        
        NSNumber *distortionSend1 = [NSNumber numberWithFloat:self.audioEngine.sendDistortionInstrument1.volume];
        [self.settings.userPresetData2  insertObject:distortionSend1 atIndex:9];
        
        NSNumber *distortionSend2 = [NSNumber numberWithFloat:self.audioEngine.sendDistortionInstrument2.volume];
        [self.settings.userPresetData2  insertObject:distortionSend2 atIndex:10];
        
        NSNumber *distortionSend3 = [NSNumber numberWithFloat:self.audioEngine.sendDistortionDrums.volume];
        [self.settings.userPresetData2  insertObject:distortionSend3 atIndex:11];
        
        NSNumber *distortionSend4 = [NSNumber numberWithFloat:self.audioEngine.sendDistortionMicrophone.volume];
        [self.settings.userPresetData2  insertObject:distortionSend4 atIndex:12];
        
        NSNumber *delayWetDry = [NSNumber numberWithFloat:self.audioEngine.audioUnitDelay.wetDryMix];
        [self.settings.userPresetData2  insertObject:delayWetDry atIndex:13];
        
        NSNumber *delayTime = [NSNumber numberWithFloat:self.audioEngine.audioUnitDelay.delayTime];
        [self.settings.userPresetData2  insertObject:delayTime atIndex:14];
        
        NSNumber *delayFeedback = [NSNumber numberWithFloat:self.audioEngine.audioUnitDelay.feedback];
        [self.settings.userPresetData2  insertObject:delayFeedback atIndex:15];
        
        NSNumber *delayLowPassCutoff = [NSNumber numberWithFloat:self.audioEngine.audioUnitDelay.lowPassCutoff];
        [self.settings.userPresetData2  insertObject:delayLowPassCutoff atIndex:16];
        
        NSNumber *delaySend1 = [NSNumber numberWithFloat:self.audioEngine.sendDelayInstrument1.volume];
        [self.settings.userPresetData2  insertObject:delaySend1 atIndex:17];
        
        NSNumber *delaySend2 = [NSNumber numberWithFloat:self.audioEngine.sendDelayInstrument2.volume];
        [self.settings.userPresetData2  insertObject:delaySend2 atIndex:18];
        
        NSNumber *delaySend3 = [NSNumber numberWithFloat:self.audioEngine.sendDelayDrums.volume];
        [self.settings.userPresetData2  insertObject:delaySend3 atIndex:19];
        
        NSNumber *delaySend4 = [NSNumber numberWithFloat:self.audioEngine.sendDelayMicrophone.volume];
        [self.settings.userPresetData2  insertObject:delaySend4 atIndex:20];
        
        NSNumber *microphoneOverlap = [NSNumber numberWithFloat:self.audioEngine.audioUnitTimePitch.overlap];
        [self.settings.userPresetData2  insertObject:microphoneOverlap atIndex:21];
        
        NSNumber *microphonePitch = [NSNumber numberWithFloat:self.audioEngine.audioUnitTimePitch.pitch];
        [self.settings.userPresetData2  insertObject:microphonePitch atIndex:22];
        
        NSNumber *microphoneRate = [NSNumber numberWithFloat:self.audioEngine.audioUnitTimePitch.rate];
        [self.settings.userPresetData2  insertObject:microphoneRate atIndex:23];
        
        NSNumber *instument1Selected = [NSNumber numberWithInteger:self.settings.selectedInstrument1];
        [self.settings.userPresetData2  insertObject:instument1Selected atIndex:24];
        
        NSNumber *instument1Pan = [NSNumber numberWithFloat:self.audioEngine.samplerInstrument1.pan];
        [self.settings.userPresetData2  insertObject:instument1Pan atIndex:25];
        
        NSNumber *instument2Selected = [NSNumber numberWithInteger:self.settings.selectedInstrument2];
        [self.settings.userPresetData2  insertObject:instument2Selected atIndex:26];
        
        NSNumber *instument2Pan = [NSNumber numberWithFloat:self.audioEngine.samplerInstrument2.pan];
        [self.settings.userPresetData2  insertObject:instument2Pan atIndex:27];
        
        NSNumber *drumsSelected = [NSNumber numberWithInteger:self.settings.selectedDrums];
        [self.settings.userPresetData2  insertObject:drumsSelected atIndex:28];
        
        NSNumber *mainMix1 = [NSNumber numberWithFloat:self.audioEngine.sendDirectOutInstrument1.volume];
        [self.settings.userPresetData2  insertObject:mainMix1 atIndex:29];
        
        NSNumber *mainMix2 = [NSNumber numberWithFloat:self.audioEngine.sendDirectOutInstrument2.volume];
        [self.settings.userPresetData2  insertObject:mainMix2 atIndex:30];
        
        NSNumber *mainMix3 = [NSNumber numberWithFloat:self.audioEngine.sendDirectOutDrums.volume];
        [self.settings.userPresetData2  insertObject:mainMix3 atIndex:31];
        
        NSNumber *mainMix4 = [NSNumber numberWithFloat:self.audioEngine.sendDirectOutMicrophone.volume];
        [self.settings.userPresetData2  insertObject:mainMix4 atIndex:32];
        
    }
    
    
}

-(void) loadUserPresetData {
    
    // Loads the stored data from the array that was stored in user deafults
    // NSNumber is an object and has to be converted back into the data type that the other object needs

    if (self.settings.selectedUserPreset == 0){
        
        NSNumber *reverbSelected = [self.settings.userPresetData1 objectAtIndex:0];
        int intReverbSelected = [reverbSelected intValue];
        self.settings.selectedReverb = intReverbSelected;
    
        NSNumber *reverbWetDry = [self.settings.userPresetData1 objectAtIndex:1];
        float floatReverbWetDry = [reverbWetDry floatValue];
        self.audioEngine.audioUnitReverb.wetDryMix = floatReverbWetDry;
    
        NSNumber *reverbSend1 = [self.settings.userPresetData1 objectAtIndex:2];
        float floatReverbSend1 = [reverbSend1 floatValue];
        self.audioEngine.sendReverbInstrument1.volume = floatReverbSend1;
    
        NSNumber *reverbSend2 = [self.settings.userPresetData1 objectAtIndex:3];
        float floatReverbSend2 = [reverbSend2 floatValue];
        self.audioEngine.sendReverbInstrument2.volume = floatReverbSend2;
    
        NSNumber *reverbSend3 = [self.settings.userPresetData1 objectAtIndex:4];
        float floatReverbSend3 = [reverbSend3 floatValue];
        self.audioEngine.sendReverbDrums.volume = floatReverbSend3;
    
        NSNumber *reverbSend4 = [self.settings.userPresetData1 objectAtIndex:5];
        float floatReverbSend4 = [reverbSend4 floatValue];
        self.audioEngine.sendReverbMicrophone.volume = floatReverbSend4;
    
        NSNumber *distortionSelected = [self.settings.userPresetData1 objectAtIndex:6];
        int intDistortionSelected = [distortionSelected intValue];
        self.settings.selectedDistortion = intDistortionSelected;
    
        NSNumber *distortionWetDry = [self.settings.userPresetData1 objectAtIndex:7];
        float floatDistortionWetDry = [distortionWetDry floatValue];
        self.audioEngine.audioUnitDistortion.wetDryMix = floatDistortionWetDry;
    
        NSNumber *distortionPreGain = [self.settings.userPresetData1 objectAtIndex:8];
        float floatDistortionPreGain = [distortionPreGain floatValue];
        self.audioEngine.audioUnitDistortion.preGain = floatDistortionPreGain;
    
        NSNumber *distortionSend1 = [self.settings.userPresetData1 objectAtIndex:9];
        float floatDistritonSend1 = [distortionSend1 floatValue];
        self.audioEngine.sendDistortionInstrument1.volume = floatDistritonSend1;
    
        NSNumber *distortionSend2 = [self.settings.userPresetData1 objectAtIndex:10];
        float floatDistritonSend2 = [distortionSend2 floatValue];
        self.audioEngine.sendDistortionInstrument2.volume = floatDistritonSend2;
    
        NSNumber *distortionSend3 = [self.settings.userPresetData1 objectAtIndex:11];
        float floatDistritonSend3 = [distortionSend3 floatValue];
        self.audioEngine.sendDistortionDrums.volume = floatDistritonSend3;
    
        NSNumber *distortionSend4 = [self.settings.userPresetData1 objectAtIndex:12];
        float floatDistritonSend4 = [distortionSend4 floatValue];
        self.audioEngine.sendDistortionMicrophone.volume = floatDistritonSend4;
    
        NSNumber *delayWetDry = [self.settings.userPresetData1 objectAtIndex:13];
        float floatDelayWetDry = [delayWetDry floatValue];
        self.audioEngine.audioUnitDelay.wetDryMix = floatDelayWetDry;
    
        NSNumber *delayTime = [self.settings.userPresetData1 objectAtIndex:14];
        float floatDelayTime = [delayTime floatValue];
        self.audioEngine.audioUnitDelay.delayTime = floatDelayTime;
    
        NSNumber *delayFeedback = [self.settings.userPresetData1 objectAtIndex:15];
        float floatDelayFeedback = [delayFeedback floatValue];
        self.audioEngine.audioUnitDelay.feedback = floatDelayFeedback;
    
        NSNumber *delayLowPassCutoff = [self.settings.userPresetData1 objectAtIndex:16];
        float floatDelayLowPassCutoff = [delayLowPassCutoff floatValue];
        self.audioEngine.audioUnitDelay.lowPassCutoff = floatDelayLowPassCutoff;
    
        NSNumber *delaySend1 = [self.settings.userPresetData1 objectAtIndex:17];
        float floatDelaySend1 = [delaySend1 floatValue];
        self.audioEngine.sendDelayInstrument1.volume = floatDelaySend1;
    
        NSNumber *delaySend2 = [self.settings.userPresetData1 objectAtIndex:18];
        float floatDelaySend2 = [delaySend2 floatValue];
        self.audioEngine.sendDelayInstrument2.volume = floatDelaySend2;
    
        NSNumber *delaySend3 = [self.settings.userPresetData1 objectAtIndex:19];
        float floatDelaySend3 = [delaySend3 floatValue];
        self.audioEngine.sendDelayDrums.volume = floatDelaySend3;
    
        NSNumber *delaySend4 = [self.settings.userPresetData1 objectAtIndex:20];
        float floatDelaySend4 = [delaySend4 floatValue];
        self.audioEngine.sendDelayMicrophone.volume = floatDelaySend4;
    
        NSNumber *microphoneOverlap = [self.settings.userPresetData1 objectAtIndex:21];
        float floatMicrophoneOverlap = [microphoneOverlap floatValue];
        self.audioEngine.audioUnitTimePitch.overlap = floatMicrophoneOverlap;
    
        NSNumber *microphonePitch = [self.settings.userPresetData1 objectAtIndex:22];
        float floatMicrophonePitch = [microphonePitch floatValue];
        self.audioEngine.audioUnitTimePitch.pitch = floatMicrophonePitch;
    
        NSNumber *microphoneRate = [self.settings.userPresetData1 objectAtIndex:23];
        float floatMicrophoneRate = [microphoneRate floatValue];
        self.audioEngine.audioUnitTimePitch.rate = floatMicrophoneRate;
    
        NSNumber *instument1Selected = [self.settings.userPresetData1 objectAtIndex:24];
        int intInstument1Selected = [instument1Selected intValue];
        self.settings.selectedInstrument1 = intInstument1Selected;
    
        NSNumber *instument1Pan = [self.settings.userPresetData1 objectAtIndex:25];
        float floatInstument1Pan = [instument1Pan floatValue];
        self.audioEngine.samplerInstrument1.pan = floatInstument1Pan;
        self.audioEngine.playerInstument1.pan = floatInstument1Pan;
    
        NSNumber *instument2Selected = [self.settings.userPresetData1 objectAtIndex:26];
        int intInstument2Selected = [instument2Selected intValue];
        self.settings.selectedInstrument2 = intInstument2Selected;
    
        NSNumber *instument2Pan = [self.settings.userPresetData1 objectAtIndex:27];
        float floatInstument2Pan = [instument2Pan floatValue];
        self.audioEngine.samplerInstrument2.pan = floatInstument2Pan;
        self.audioEngine.playerInstument2.pan = floatInstument2Pan;
    
        NSNumber *drumsSelected = [self.settings.userPresetData1 objectAtIndex:28];
        int intDrumsSelected = [drumsSelected intValue];
        self.settings.selectedDrums = intDrumsSelected;
    
        NSNumber *mainMix1 = [self.settings.userPresetData1 objectAtIndex:29];
        float floatMainMix1 = [mainMix1 floatValue];
        self.audioEngine.sendDirectOutInstrument1.volume = floatMainMix1;
    
        NSNumber *mainMix2 = [self.settings.userPresetData1 objectAtIndex:30];
        float floatMainMix2 = [mainMix2 floatValue];
        self.audioEngine.sendDirectOutInstrument2.volume = floatMainMix2;
    
        NSNumber *mainMix3 = [self.settings.userPresetData1 objectAtIndex:31];
        float floatMainMix3 = [mainMix3 floatValue];
        self.audioEngine.sendDirectOutDrums.volume = floatMainMix3;
    
        NSNumber *mainMix4 = [self.settings.userPresetData1 objectAtIndex:32];
        float floatMainMix4 = [mainMix4 floatValue];
        self.audioEngine.sendDirectOutMicrophone.volume = floatMainMix4;
        
    } else if (self.settings.selectedUserPreset == 1){
        
        NSNumber *reverbSelected = [self.settings.userPresetData2  objectAtIndex:0];
        int intReverbSelected = [reverbSelected intValue];
        self.settings.selectedReverb = intReverbSelected;
        
        NSNumber *reverbWetDry = [self.settings.userPresetData2  objectAtIndex:1];
        float floatReverbWetDry = [reverbWetDry floatValue];
        self.audioEngine.audioUnitReverb.wetDryMix = floatReverbWetDry;
        
        NSNumber *reverbSend1 = [self.settings.userPresetData2  objectAtIndex:2];
        float floatReverbSend1 = [reverbSend1 floatValue];
        self.audioEngine.sendReverbInstrument1.volume = floatReverbSend1;
        
        NSNumber *reverbSend2 = [self.settings.userPresetData2  objectAtIndex:3];
        float floatReverbSend2 = [reverbSend2 floatValue];
        self.audioEngine.sendReverbInstrument2.volume = floatReverbSend2;
        
        NSNumber *reverbSend3 = [self.settings.userPresetData2  objectAtIndex:4];
        float floatReverbSend3 = [reverbSend3 floatValue];
        self.audioEngine.sendReverbDrums.volume = floatReverbSend3;
        
        NSNumber *reverbSend4 = [self.settings.userPresetData2  objectAtIndex:5];
        float floatReverbSend4 = [reverbSend4 floatValue];
        self.audioEngine.sendReverbMicrophone.volume = floatReverbSend4;
        
        NSNumber *distortionSelected = [self.settings.userPresetData2  objectAtIndex:6];
        int intDistortionSelected = [distortionSelected intValue];
        self.settings.selectedDistortion = intDistortionSelected;
        
        NSNumber *distortionWetDry = [self.settings.userPresetData2  objectAtIndex:7];
        float floatDistortionWetDry = [distortionWetDry floatValue];
        self.audioEngine.audioUnitDistortion.wetDryMix = floatDistortionWetDry;
        
        NSNumber *distortionPreGain = [self.settings.userPresetData2  objectAtIndex:8];
        float floatDistortionPreGain = [distortionPreGain floatValue];
        self.audioEngine.audioUnitDistortion.preGain = floatDistortionPreGain;
        
        NSNumber *distortionSend1 = [self.settings.userPresetData2  objectAtIndex:9];
        float floatDistritonSend1 = [distortionSend1 floatValue];
        self.audioEngine.sendDistortionInstrument1.volume = floatDistritonSend1;
        
        NSNumber *distortionSend2 = [self.settings.userPresetData2  objectAtIndex:10];
        float floatDistritonSend2 = [distortionSend2 floatValue];
        self.audioEngine.sendDistortionInstrument2.volume = floatDistritonSend2;
        
        NSNumber *distortionSend3 = [self.settings.userPresetData2  objectAtIndex:11];
        float floatDistritonSend3 = [distortionSend3 floatValue];
        self.audioEngine.sendDistortionDrums.volume = floatDistritonSend3;
        
        NSNumber *distortionSend4 = [self.settings.userPresetData2  objectAtIndex:12];
        float floatDistritonSend4 = [distortionSend4 floatValue];
        self.audioEngine.sendDistortionMicrophone.volume = floatDistritonSend4;
        
        NSNumber *delayWetDry = [self.settings.userPresetData2  objectAtIndex:13];
        float floatDelayWetDry = [delayWetDry floatValue];
        self.audioEngine.audioUnitDelay.wetDryMix = floatDelayWetDry;
        
        NSNumber *delayTime = [self.settings.userPresetData2  objectAtIndex:14];
        float floatDelayTime = [delayTime floatValue];
        self.audioEngine.audioUnitDelay.delayTime = floatDelayTime;
        
        NSNumber *delayFeedback = [self.settings.userPresetData2  objectAtIndex:15];
        float floatDelayFeedback = [delayFeedback floatValue];
        self.audioEngine.audioUnitDelay.feedback = floatDelayFeedback;
        
        NSNumber *delayLowPassCutoff = [self.settings.userPresetData2  objectAtIndex:16];
        float floatDelayLowPassCutoff = [delayLowPassCutoff floatValue];
        self.audioEngine.audioUnitDelay.lowPassCutoff = floatDelayLowPassCutoff;
        
        NSNumber *delaySend1 = [self.settings.userPresetData2  objectAtIndex:17];
        float floatDelaySend1 = [delaySend1 floatValue];
        self.audioEngine.sendDelayInstrument1.volume = floatDelaySend1;
        
        NSNumber *delaySend2 = [self.settings.userPresetData2  objectAtIndex:18];
        float floatDelaySend2 = [delaySend2 floatValue];
        self.audioEngine.sendDelayInstrument2.volume = floatDelaySend2;
        
        NSNumber *delaySend3 = [self.settings.userPresetData2  objectAtIndex:19];
        float floatDelaySend3 = [delaySend3 floatValue];
        self.audioEngine.sendDelayDrums.volume = floatDelaySend3;
        
        NSNumber *delaySend4 = [self.settings.userPresetData2  objectAtIndex:20];
        float floatDelaySend4 = [delaySend4 floatValue];
        self.audioEngine.sendDelayMicrophone.volume = floatDelaySend4;
        
        NSNumber *microphoneOverlap = [self.settings.userPresetData2  objectAtIndex:21];
        float floatMicrophoneOverlap = [microphoneOverlap floatValue];
        self.audioEngine.audioUnitTimePitch.overlap = floatMicrophoneOverlap;
        
        NSNumber *microphonePitch = [self.settings.userPresetData2  objectAtIndex:22];
        float floatMicrophonePitch = [microphonePitch floatValue];
        self.audioEngine.audioUnitTimePitch.pitch = floatMicrophonePitch;
        
        NSNumber *microphoneRate = [self.settings.userPresetData2  objectAtIndex:23];
        float floatMicrophoneRate = [microphoneRate floatValue];
        self.audioEngine.audioUnitTimePitch.rate = floatMicrophoneRate;
        
        NSNumber *instument1Selected = [self.settings.userPresetData2  objectAtIndex:24];
        int intInstument1Selected = [instument1Selected intValue];
        self.settings.selectedInstrument1 = intInstument1Selected;
        
        NSNumber *instument1Pan = [self.settings.userPresetData2  objectAtIndex:25];
        float floatInstument1Pan = [instument1Pan floatValue];
        self.audioEngine.samplerInstrument1.pan = floatInstument1Pan;
        self.audioEngine.playerInstument1.pan = floatInstument1Pan;
        
        NSNumber *instument2Selected = [self.settings.userPresetData2  objectAtIndex:26];
        int intInstument2Selected = [instument2Selected intValue];
        self.settings.selectedInstrument2 = intInstument2Selected;
        
        NSNumber *instument2Pan = [self.settings.userPresetData2  objectAtIndex:27];
        float floatInstument2Pan = [instument2Pan floatValue];
        self.audioEngine.samplerInstrument2.pan = floatInstument2Pan;
        self.audioEngine.playerInstument2.pan = floatInstument2Pan;
        
        NSNumber *drumsSelected = [self.settings.userPresetData2  objectAtIndex:28];
        int intDrumsSelected = [drumsSelected intValue];
        self.settings.selectedDrums = intDrumsSelected;
        
        NSNumber *mainMix1 = [self.settings.userPresetData2  objectAtIndex:29];
        float floatMainMix1 = [mainMix1 floatValue];
        self.audioEngine.sendDirectOutInstrument1.volume = floatMainMix1;
        
        NSNumber *mainMix2 = [self.settings.userPresetData2  objectAtIndex:30];
        float floatMainMix2 = [mainMix2 floatValue];
        self.audioEngine.sendDirectOutInstrument2.volume = floatMainMix2;
        
        NSNumber *mainMix3 = [self.settings.userPresetData2  objectAtIndex:31];
        float floatMainMix3 = [mainMix3 floatValue];
        self.audioEngine.sendDirectOutDrums.volume = floatMainMix3;
        
        NSNumber *mainMix4 = [self.settings.userPresetData2  objectAtIndex:32];
        float floatMainMix4 = [mainMix4 floatValue];
        self.audioEngine.sendDirectOutMicrophone.volume = floatMainMix4;
        
    }
}

@end
