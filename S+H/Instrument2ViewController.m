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
    
    NSLog(@"Octave: %li",(long)self.audioEngine.octave);
}

- (IBAction)didTapOctaveDown:(UIButton *)sender {
    self.audioEngine.octave = self.audioEngine.octave-1;
    
    NSLog(@"Octave: %li",(long)self.audioEngine.octave);
}

- (IBAction)didMoveSliderPan:(UISlider *)sender {
    
    [self.audioEngine panInstrument1:self.sliderPan.value];
    
}

- (IBAction)didTapPlay:(UIButton *)sender {
    
    [self.audioEngine startPlayingInstument1];
    self.audioEngine.isLoopInstument1 = self.switchLoop.isOn;
    
}

- (IBAction)didTapRecord:(UIButton *)sender {
    
    if (self.audioEngine.isRecordingInstument1 == false) {
        
        [self.audioEngine startRecordingInstument1];
        
    } else {
        
        [self.audioEngine stopRecordingInstument1];
        
    }
    
}

- (IBAction)didTapSwitchLoop:(UISwitch *)sender {
    
    self.audioEngine.isLoopInstument1 = self.switchLoop.isOn;
    
}

@end
