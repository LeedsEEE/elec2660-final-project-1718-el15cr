//
//  Instrument1ViewController.h
//  S+H
//
//  Created by Callum on 19/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterfaceViewController.h"
#import "settings.h"

@interface Instrument1ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) audioEngine *audioEngine;
@property (nonatomic, strong) settings *settings;
@property (nonatomic, strong) NSTimer *timerRecord; 

@property (weak, nonatomic) IBOutlet UIPickerView *pickerInstrument1;
@property (weak, nonatomic) IBOutlet UISlider *sliderPan;
@property (weak, nonatomic) IBOutlet UISwitch *switchLoop;
@property (weak, nonatomic) IBOutlet UIButton *buttonNote1;
@property (weak, nonatomic) IBOutlet UIButton *buttonNote2;
@property (weak, nonatomic) IBOutlet UIButton *buttonNote3;
@property (weak, nonatomic) IBOutlet UIButton *buttonNote4;
@property (weak, nonatomic) IBOutlet UIButton *buttonNote5;
@property (weak, nonatomic) IBOutlet UIButton *buttonNote6;
@property (weak, nonatomic) IBOutlet UIButton *buttonNote7;
@property (weak, nonatomic) IBOutlet UIButton *buttonNote8;
@property (weak, nonatomic) IBOutlet UIButton *buttonNote9;
@property (weak, nonatomic) IBOutlet UIButton *buttonNote10;
@property (weak, nonatomic) IBOutlet UIButton *buttonNote11;
@property (weak, nonatomic) IBOutlet UIButton *buttonNote12;
@property (weak, nonatomic) IBOutlet UIButton *buttonOctaveDown;
@property (weak, nonatomic) IBOutlet UIButton *buttonOctaveUp;
@property (weak, nonatomic) IBOutlet UIButton *buttonPlay;
@property (weak, nonatomic) IBOutlet UIButton *buttonRecord;
@property (weak, nonatomic) IBOutlet UILabel *labelPan;
@property (weak, nonatomic) IBOutlet UIButton *buttonRecordText;



// If the button is taped down then play the note

- (IBAction)didTapDownNote1:(UIButton *)sender;
- (IBAction)didTapDownNote2:(UIButton *)sender;
- (IBAction)didTapDownNote3:(UIButton *)sender;
- (IBAction)didTapDownNote4:(UIButton *)sender;
- (IBAction)didTapDownNote5:(UIButton *)sender;
- (IBAction)didTapDownNote6:(UIButton *)sender;
- (IBAction)didTapDownNote7:(UIButton *)sender;
- (IBAction)didTapDownNote8:(UIButton *)sender;
- (IBAction)didTapDownNote9:(UIButton *)sender;
- (IBAction)didTapDownNote10:(UIButton *)sender;
- (IBAction)didTapDownNote11:(UIButton *)sender;
- (IBAction)didTapDownNote12:(UIButton *)sender;

// If the button is touched on the inside stop the note

- (IBAction)didTapInsideNote1:(UIButton *)sender;
- (IBAction)didTapInsideNote2:(UIButton *)sender;
- (IBAction)didTapInsideNote3:(UIButton *)sender;
- (IBAction)didTapInsideNote4:(UIButton *)sender;
- (IBAction)didTapInsideNote5:(UIButton *)sender;
- (IBAction)didTapInsideNote6:(UIButton *)sender;
- (IBAction)didTapInsideNote7:(UIButton *)sender;
- (IBAction)didTapInsideNote8:(UIButton *)sender;
- (IBAction)didTapInsideNote9:(UIButton *)sender;
- (IBAction)didTapInsideNote10:(UIButton *)sender;
- (IBAction)didTapInsideNote11:(UIButton *)sender;
- (IBAction)didTapInsideNote12:(UIButton *)sender;

// If tapped octave goes up or down

- (IBAction)didTapOctaveUp:(UIButton *)sender;
- (IBAction)didTapOctaveDown:(UIButton *)sender;

- (IBAction)didMoveSliderPan:(UISlider *)sender;
- (IBAction)didTapPlay:(UIButton *)sender;
- (IBAction)didTapRecord:(UIButton *)sender;

- (IBAction)didTapSwitchLoop:(UISwitch *)sender;



@end
