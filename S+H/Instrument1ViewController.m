//
//  Instrument1ViewController.m
//  S+H
//
//  Created by Callum on 19/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import "Instrument1ViewController.h"

@interface Instrument1ViewController ()

@end

@implementation Instrument1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.pickerInstrument1.delegate = self;
    self.pickerInstrument1.dataSource = self;
    
    self.audioEngine.octave = self.audioEngine.octave;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction) unwindForSegue:(nonnull UIStoryboardSegue *)unwindSegue towardsViewController:(nonnull UIViewController *)subsequentVC{
    
    // Goes back from segue to the original view controller
    
}


-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}


-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.settings.pickerInstrument1Data.count;
    
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return self.settings.pickerInstrument1Data[row];
    
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
    [self.audioEngine playInstrument1:60];
}
- (IBAction)didTapDownNote2:(UIButton *)sender {
    [self.audioEngine playInstrument1:61];
}
- (IBAction)didTapDownNote3:(UIButton *)sender {
    [self.audioEngine playInstrument1:62];
}
- (IBAction)didTapDownNote4:(UIButton *)sender {
    [self.audioEngine playInstrument1:63];
}
- (IBAction)didTapDownNote5:(UIButton *)sender {
    [self.audioEngine playInstrument1:64];
}
- (IBAction)didTapDownNote6:(UIButton *)sender {
    [self.audioEngine playInstrument1:65];
}
- (IBAction)didTapDownNote7:(UIButton *)sender {
    [self.audioEngine playInstrument1:66];
}
- (IBAction)didTapDownNote8:(UIButton *)sender {
    [self.audioEngine playInstrument1:67];
}
- (IBAction)didTapDownNote9:(UIButton *)sender {
    [self.audioEngine playInstrument1:68];
}
- (IBAction)didTapDownNote10:(UIButton *)sender {
    [self.audioEngine playInstrument1:69];
}
- (IBAction)didTapDownNote11:(UIButton *)sender {
    [self.audioEngine playInstrument1:70];
}
- (IBAction)didTapDownNote12:(UIButton *)sender {
    [self.audioEngine playInstrument1:71];
}

- (IBAction)didTapInsideNote1:(UIButton *)sender {
    [self.audioEngine stopInstrument1:60];
}
- (IBAction)didTapInsideNote2:(UIButton *)sender {
    [self.audioEngine stopInstrument1:61];
}
- (IBAction)didTapInsideNote3:(UIButton *)sender {
    [self.audioEngine stopInstrument1:62];
}
- (IBAction)didTapInsideNote4:(UIButton *)sender {
    [self.audioEngine stopInstrument1:63];
}
- (IBAction)didTapInsideNote5:(UIButton *)sender {
    [self.audioEngine stopInstrument1:64];
}
- (IBAction)didTapInsideNote6:(UIButton *)sender {
    [self.audioEngine stopInstrument1:65];
}
- (IBAction)didTapInsideNote7:(UIButton *)sender {
    [self.audioEngine stopInstrument1:66];
}
- (IBAction)didTapInsideNote8:(UIButton *)sender {
    [self.audioEngine stopInstrument1:67];
}
- (IBAction)didTapInsideNote9:(UIButton *)sender {
    [self.audioEngine stopInstrument1:68];
}
- (IBAction)didTapInsideNote10:(UIButton *)sender {
    [self.audioEngine stopInstrument1:69];
}
- (IBAction)didTapInsideNote11:(UIButton *)sender {
    [self.audioEngine stopInstrument1:70];
}
- (IBAction)didTapInsideNote12:(UIButton *)sender {
    [self.audioEngine stopInstrument1:71];
}

- (IBAction)didTapOctaveUp:(UIButton *)sender {
    self.audioEngine.octave = self.audioEngine.octave+1;
}

- (IBAction)didTapOctaveDown:(UIButton *)sender {
    self.audioEngine.octave = self.audioEngine.octave-1;
}

- (IBAction)didMoveSliderPan:(UISlider *)sender {
    
    [self.audioEngine panInstrument1:self.sliderPan.value];
    
}


@end
