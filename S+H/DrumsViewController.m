//
//  DrumsViewController.m
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 21/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import "DrumsViewController.h"

@interface DrumsViewController ()

@end

@implementation DrumsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pickerDrums.delegate = self;
    self.pickerDrums.dataSource = self;
    
    self.audioEngine.octave = self.audioEngine.octave;
    
    [self.pickerDrums selectRow:self.settings.selectedDrums inComponent:0 animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.settings.selectedDrums = [self.pickerDrums selectedRowInComponent:0];
    
    [self.audioEngine changeDrums:self.settings.selectedDrums];
    
    NSLog(@"Drums selected: %@",self.settings.pickerDrumsData[row]);
    
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}


-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.settings.pickerDrumsData.count;
    
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return self.settings.pickerDrumsData[row];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapDownNote1:(UIButton *)sender {
    [self.audioEngine playDrums:71];
}
- (IBAction)didTapDownNote2:(UIButton *)sender {
    [self.audioEngine playDrums:71];
}
- (IBAction)didTapDownNote3:(UIButton *)sender {
    [self.audioEngine playDrums:71];
}
- (IBAction)didTapDownNote4:(UIButton *)sender {
    [self.audioEngine playDrums:71];
}
- (IBAction)didTapDownNote5:(UIButton *)sender {
    [self.audioEngine playDrums:71];
}
- (IBAction)didTapDownNote6:(UIButton *)sender {
    [self.audioEngine playDrums:71];
}
- (IBAction)didTapDownNote7:(UIButton *)sender {
    [self.audioEngine playDrums:71];
}
- (IBAction)didTapDownNote8:(UIButton *)sender {
    [self.audioEngine playDrums:71];
}
- (IBAction)didTapDownNote9:(UIButton *)sender {
    [self.audioEngine playDrums:71];
}
- (IBAction)didTapDownNote10:(UIButton *)sender {
    [self.audioEngine playDrums:71];
}
- (IBAction)didTapDownNote11:(UIButton *)sender {
    [self.audioEngine playDrums:71];
}
- (IBAction)didTapDownNote12:(UIButton *)sender {
    [self.audioEngine playDrums:71];
}

- (IBAction)didTapInsideNote1:(UIButton *)sender {
    [self.audioEngine stopDrums:71];
}
- (IBAction)didTapInsideNote2:(UIButton *)sender {
    [self.audioEngine stopDrums:71];
}
- (IBAction)didTapInsideNote3:(UIButton *)sender {
    [self.audioEngine stopDrums:71];
}
- (IBAction)didTapInsideNote4:(UIButton *)sender {
    [self.audioEngine stopDrums:71];
}
- (IBAction)didTapInsideNote5:(UIButton *)sender {
    [self.audioEngine stopDrums:71];
}
- (IBAction)didTapInsideNote6:(UIButton *)sender {
    [self.audioEngine stopDrums:71];
}
- (IBAction)didTapInsideNote7:(UIButton *)sender {
    [self.audioEngine stopDrums:71];
}
- (IBAction)didTapInsideNote8:(UIButton *)sender {
    [self.audioEngine stopDrums:71];
}
- (IBAction)didTapInsideNote9:(UIButton *)sender {
    [self.audioEngine stopDrums:71];
}
- (IBAction)didTapInsideNote10:(UIButton *)sender {
    [self.audioEngine stopDrums:71];
}
- (IBAction)didTapInsideNote11:(UIButton *)sender {
    [self.audioEngine stopDrums:71];
}
- (IBAction)didTapInsideNote12:(UIButton *)sender {
    [self.audioEngine stopDrums:71];
}

- (IBAction)didTapPlay:(UIButton *)sender {
    
    [self.audioEngine startPlayingDrums];
    self.audioEngine.isLoopDrums= self.switchLoop.isOn;
    
}

- (IBAction)didTapRecord:(UIButton *)sender {
    
    if (self.audioEngine.isRecordingDrums == false) {
        
        [self.audioEngine startRecordingDrums];
        
    } else {
        
        [self.audioEngine stopRecordingDrums];
        
    }
    
}

- (IBAction)didTapSwitchLoop:(UISwitch *)sender {
    
    self.audioEngine.isLoopDrums = self.switchLoop.isOn;
    
}


@end
