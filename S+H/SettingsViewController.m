//
//  SettingsViewController.m
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 21/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
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
    
    NSNumber *reverbWetDry = [NSNumber numberWithFloat:self.audioEngine.audioUnitReverb.wetDryMix];
    [self.settings.userPresetData1 insertObject:reverbWetDry atIndex:0];
    
}

-(void) loadUserPresetData {
    
    NSNumber *reverbWetDry = [self.settings.userPresetData1 objectAtIndex:0];
    float floatReverbWetDry = [reverbWetDry floatValue];
    self.audioEngine.audioUnitReverb.wetDryMix = floatReverbWetDry;

}

@end
