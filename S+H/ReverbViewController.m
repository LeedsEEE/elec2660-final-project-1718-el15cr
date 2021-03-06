//
//  ReverbViewController.m
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 21/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

// References
//
// https://developer.apple.com/documentation/uikit/uiviewcontroller/1621473-unwindforsegue

#import "ReverbViewController.h"

@interface ReverbViewController ()

@end

@implementation ReverbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Loads the values from audio engine, so when the segue is done it shows the correct value

    self.pickerReverb.delegate = self;
    self.pickerReverb.dataSource = self;
    
    self.sliderWetDryMix.value = self.audioEngine.audioUnitReverb.wetDryMix;
    self.sliderInstrument1.value = self.audioEngine.sendReverbInstrument1.volume;
    self.sliderInstrument2.value = self.audioEngine.sendReverbInstrument2.volume;
    self.sliderDrums.value = self.audioEngine.sendReverbDrums.volume;
    self.sliderMicrophone.value = self.audioEngine.sendReverbMicrophone.volume;
    
    [self.pickerReverb selectRow:self.settings.selectedReverb inComponent:0 animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) unwindForSegue:(nonnull UIStoryboardSegue *)unwindSegue towardsViewController:(nonnull UIViewController *)subsequentVC{
    
    // Goes back from segue to the original view controller
    
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    // When the picker has been moved it changes the preset in audio engine
    // this is done by sending the vaule of the picker to the settings class first
    
    self.settings.selectedReverb = [self.pickerReverb selectedRowInComponent:0];

    [self.audioEngine changeReverb:self.settings.selectedReverb];
    
    NSLog(@"Reverb selected: %@",self.settings.pickerReverbData[row]);
    
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}


-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.settings.pickerReverbData.count;
    
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    return self.settings.pickerReverbData[row];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// IBActions to send the value from the view controler to the audio engine
// allowing the user to make changes.

- (IBAction)didMoveSliderWetDryMix:(UISlider *)sender {
    
    [self.audioEngine audioUnitReverbWetDry:self.sliderWetDryMix.value];
    
}

- (IBAction)didMoveSliderInstrument1:(UISlider *)sender {
    
    [self.audioEngine sendsForReverb:self.sliderInstrument1.value :self.sliderInstrument2.value :self.sliderDrums.value :self.sliderMicrophone.value];
}

- (IBAction)didMoveSliderInstrument2:(UISlider *)sender {
    [self.audioEngine sendsForReverb:self.sliderInstrument1.value :self.sliderInstrument2.value :self.sliderDrums.value :self.sliderMicrophone.value];
}

- (IBAction)didMoveSliderDrums:(UISlider *)sender {
    [self.audioEngine sendsForReverb:self.sliderInstrument1.value :self.sliderInstrument2.value :self.sliderDrums.value :self.sliderMicrophone.value];
}

- (IBAction)didMoveSliderMicrophone:(UISlider *)sender {
    [self.audioEngine sendsForReverb:self.sliderInstrument1.value :self.sliderInstrument2.value :self.sliderDrums.value :self.sliderMicrophone.value];
}
@end
