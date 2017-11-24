//
//  DistortionViewController.m
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 21/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import "DistortionViewController.h"

@interface DistortionViewController ()

@end

@implementation DistortionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pickerDistortion.delegate = self;
    self.pickerDistortion.dataSource = self;
    
    self.sliderDryWetMix.value = self.audioEngine.audioUnitDistortion.wetDryMix;
    self.sliderPreGain.value = self.audioEngine.audioUnitDistortion.preGain;
    self.sliderInstrument1.value = self.audioEngine.sendDistortionInstrument1.volume;
    self.sliderInstrument2.value = self.audioEngine.sendDistortionInstrument2.volume;
    self.sliderDrums.value = self.audioEngine.sendDistortionDrums.volume;
    self.sliderMicrophone.value = self.audioEngine.sendDistortionMicrophone.volume;
    
    [self.pickerDistortion selectRow:self.settings.selectedDistortion inComponent:0 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.settings.selectedDistortion = [self.pickerDistortion selectedRowInComponent:0];
    
    [self.audioEngine changeDistortion:self.settings.selectedDistortion];
    
    NSLog(@"Distortion selected: %@",self.settings.pickerDistortionData[row]);
    
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}


-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.settings.pickerDistortionData.count;
    
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return self.settings.pickerDistortionData[row];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didMoveSliderDryWetMix:(UISlider *)sender {
    
    [self.audioEngine audioUnitDistortionWetDry:self.sliderDryWetMix.value];
    
}
- (IBAction)didMoveSliderPreGain:(UISlider *)sender {
    
    [self.audioEngine audioUnitDistortionPreGain:self.sliderPreGain.value];
    
}

- (IBAction)didMoveSliderInstrument1:(UISlider *)sender {
    
    [self.audioEngine sendsForDistortion:self.sliderInstrument1.value :self.sliderInstrument2.value :self.sliderDrums.value :self.sliderMicrophone.value];
    
}

- (IBAction)didMoveSliderInstrument2:(UISlider *)sender {
    
    [self.audioEngine sendsForDistortion:self.sliderInstrument1.value :self.sliderInstrument2.value :self.sliderDrums.value :self.sliderMicrophone.value];
    
}

- (IBAction)didMoveSliderDrums:(UISlider *)sender {
    
    [self.audioEngine sendsForDistortion:self.sliderInstrument1.value :self.sliderInstrument2.value :self.sliderDrums.value :self.sliderMicrophone.value];
    
}

- (IBAction)didMoveSliderMicrophone:(UISlider *)sender {
    
    [self.audioEngine sendsForDistortion:self.sliderInstrument1.value :self.sliderInstrument2.value :self.sliderDrums.value :self.sliderMicrophone.value];
    
}
@end
