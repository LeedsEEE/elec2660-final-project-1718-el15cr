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
    [self.audioEngine playDrums:36];
}
- (IBAction)didTapDownNote2:(UIButton *)sender {
    [self.audioEngine playDrums:37];
}
- (IBAction)didTapDownNote3:(UIButton *)sender {
    [self.audioEngine playDrums:38];
}
- (IBAction)didTapDownNote4:(UIButton *)sender {
    [self.audioEngine playDrums:39];
}
- (IBAction)didTapDownNote5:(UIButton *)sender {
    [self.audioEngine playDrums:40];
}
- (IBAction)didTapDownNote6:(UIButton *)sender {
    [self.audioEngine playDrums:41];
}
- (IBAction)didTapDownNote7:(UIButton *)sender {
    [self.audioEngine playDrums:42];
}
- (IBAction)didTapDownNote8:(UIButton *)sender {
    [self.audioEngine playDrums:43];
}
- (IBAction)didTapDownNote9:(UIButton *)sender {
    [self.audioEngine playDrums:44];
}
- (IBAction)didTapDownNote10:(UIButton *)sender {
    [self.audioEngine playDrums:45];
}
- (IBAction)didTapDownNote11:(UIButton *)sender {
    [self.audioEngine playDrums:46];
}
- (IBAction)didTapDownNote12:(UIButton *)sender {
    [self.audioEngine playDrums:47];
}

- (IBAction)didTapInsideNote1:(UIButton *)sender {
    [self.audioEngine stopDrums:36];
}
- (IBAction)didTapInsideNote2:(UIButton *)sender {
    [self.audioEngine stopDrums:37];
}
- (IBAction)didTapInsideNote3:(UIButton *)sender {
    [self.audioEngine stopDrums:38];
}
- (IBAction)didTapInsideNote4:(UIButton *)sender {
    [self.audioEngine stopDrums:39];
}
- (IBAction)didTapInsideNote5:(UIButton *)sender {
    [self.audioEngine stopDrums:40];
}
- (IBAction)didTapInsideNote6:(UIButton *)sender {
    [self.audioEngine stopDrums:41];
}
- (IBAction)didTapInsideNote7:(UIButton *)sender {
    [self.audioEngine stopDrums:42];
}
- (IBAction)didTapInsideNote8:(UIButton *)sender {
    [self.audioEngine stopDrums:43];
}
- (IBAction)didTapInsideNote9:(UIButton *)sender {
    [self.audioEngine stopDrums:44];
}
- (IBAction)didTapInsideNote10:(UIButton *)sender {
    [self.audioEngine stopDrums:45];
}
- (IBAction)didTapInsideNote11:(UIButton *)sender {
    [self.audioEngine stopDrums:46];
}
- (IBAction)didTapInsideNote12:(UIButton *)sender {
    [self.audioEngine stopDrums:47];
}

- (IBAction)didTapPlay:(UIButton *)sender {
    
    [self.audioEngine startPlayingDrums];
    self.audioEngine.isLoopDrums= self.switchLoop.isOn;
    
}

- (IBAction)didTapRecord:(UIButton *)sender {
    
    if (self.audioEngine.isRecordingDrums == false) {
        
        self.timerRecord = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(recordDrums:) userInfo:nil repeats:NO];
        
    } else {
        
        [self.audioEngine stopRecordingDrums];
        
    }
    
}

- (IBAction)didTapSwitchLoop:(UISwitch *)sender {
    
    self.audioEngine.isLoopDrums = self.switchLoop.isOn;
    
}

-(void) recordDrums: (NSTimer*) timer {
    
    [self.audioEngine startRecordingDrums];
    
}
@end
