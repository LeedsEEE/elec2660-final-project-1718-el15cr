//
//  Instrument2ViewController.m
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 21/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import "Instrument2ViewController.h"

@interface Instrument2ViewController ()

@end

@implementation Instrument2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pickerInstrument2.delegate = self;
    self.pickerInstrument2.dataSource = self;
    
    self.audioEngine.octave = self.audioEngine.octave;
    
    [self.pickerInstrument2 selectRow:self.settings.selectedInstrument2 inComponent:0 animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.settings.selectedInstrument2 = [self.pickerInstrument2 selectedRowInComponent:0];
    
    [self.audioEngine changeInstrument2:self.settings.selectedInstrument2];
    
    NSLog(@"Instrument 2 selected: %@",self.settings.pickerInstrument2Data[row]);
    
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}


-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.settings.pickerInstrument2Data.count;
    
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return self.settings.pickerInstrument2Data[row];
    
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
    [self.audioEngine playInstrument2:60];
}
- (IBAction)didTapDownNote2:(UIButton *)sender {
    [self.audioEngine playInstrument2:61];
}
- (IBAction)didTapDownNote3:(UIButton *)sender {
    [self.audioEngine playInstrument2:62];
}
- (IBAction)didTapDownNote4:(UIButton *)sender {
    [self.audioEngine playInstrument2:63];
}
- (IBAction)didTapDownNote5:(UIButton *)sender {
    [self.audioEngine playInstrument2:64];
}
- (IBAction)didTapDownNote6:(UIButton *)sender {
    [self.audioEngine playInstrument2:65];
}
- (IBAction)didTapDownNote7:(UIButton *)sender {
    [self.audioEngine playInstrument2:66];
}
- (IBAction)didTapDownNote8:(UIButton *)sender {
    [self.audioEngine playInstrument2:67];
}
- (IBAction)didTapDownNote9:(UIButton *)sender {
    [self.audioEngine playInstrument2:68];
}
- (IBAction)didTapDownNote10:(UIButton *)sender {
    [self.audioEngine playInstrument2:69];
}
- (IBAction)didTapDownNote11:(UIButton *)sender {
    [self.audioEngine playInstrument2:70];
}
- (IBAction)didTapDownNote12:(UIButton *)sender {
    [self.audioEngine playInstrument2:71];
}

- (IBAction)didTapInsideNote1:(UIButton *)sender {
    [self.audioEngine stopInstrument2:60];
}
- (IBAction)didTapInsideNote2:(UIButton *)sender {
    [self.audioEngine stopInstrument2:61];
}
- (IBAction)didTapInsideNote3:(UIButton *)sender {
    [self.audioEngine stopInstrument2:62];
}
- (IBAction)didTapInsideNote4:(UIButton *)sender {
    [self.audioEngine stopInstrument2:63];
}
- (IBAction)didTapInsideNote5:(UIButton *)sender {
    [self.audioEngine stopInstrument2:64];
}
- (IBAction)didTapInsideNote6:(UIButton *)sender {
    [self.audioEngine stopInstrument2:65];
}
- (IBAction)didTapInsideNote7:(UIButton *)sender {
    [self.audioEngine stopInstrument2:66];
}
- (IBAction)didTapInsideNote8:(UIButton *)sender {
    [self.audioEngine stopInstrument2:67];
}
- (IBAction)didTapInsideNote9:(UIButton *)sender {
    [self.audioEngine stopInstrument2:68];
}
- (IBAction)didTapInsideNote10:(UIButton *)sender {
    [self.audioEngine stopInstrument2:69];
}
- (IBAction)didTapInsideNote11:(UIButton *)sender {
    [self.audioEngine stopInstrument2:70];
}
- (IBAction)didTapInsideNote12:(UIButton *)sender {
    [self.audioEngine stopInstrument2:71];
}

- (IBAction)didTapOctaveUp:(UIButton *)sender {
    self.audioEngine.octave = self.audioEngine.octave+1;
    
    NSLog(@"Octave: %li",(long)self.audioEngine.octave);
}

- (IBAction)didTapOctaveDown:(UIButton *)sender {
    self.audioEngine.octave = self.audioEngine.octave-1;
    
    NSLog(@"Octave: %li",(long)self.audioEngine.octave);
}

- (IBAction)didMoveSliderPan:(UISlider *)sender {
    
    [self.audioEngine panInstrument2:self.sliderPan.value];
    
}

- (IBAction)didTapPlay:(UIButton *)sender {
    
    [self.audioEngine startPlayingInstument2];
    self.audioEngine.isLoopInstument2 = self.switchLoop.isOn;
    
}

- (IBAction)didTapRecord:(UIButton *)sender {
    
    if (self.audioEngine.isRecordingInstument2 == false) {
        
        self.timerRecord = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(recordInstument2:) userInfo:nil repeats:NO];
        
    } else {
        
        [self.audioEngine stopRecordingInstument2];
        
    }
    
}

- (IBAction)didTapSwitchLoop:(UISwitch *)sender {
    
    self.audioEngine.isLoopInstument2 = self.switchLoop.isOn;
    
}

-(void) recordInstument2: (NSTimer*) timer {
    
    [self.audioEngine startRecordingInstument2];
    
}

@end
