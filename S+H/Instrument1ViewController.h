//
//  Instrument1ViewController.h
//  S+H
//
//  Created by Callum on 19/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterfaceViewController.h"

@interface Instrument1ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property audioEngine *audioEngine;
@property NSArray *pickerInstrument1Data;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerInstrument1;

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

- (IBAction)didTapOctaveUp:(UIButton *)sender;
- (IBAction)didTapOctaveDown:(UIButton *)sender;


@end
