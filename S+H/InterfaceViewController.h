//
//  ViewController.h
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 17/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "audioEngine.h"
#import "settings.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) audioEngine *audioEngine;
@property (nonatomic, strong) settings *settings;

@property (weak, nonatomic) IBOutlet UIButton *buttonPlay;
@property (weak, nonatomic) IBOutlet UIButton *buttonRecord;
@property (weak, nonatomic) IBOutlet UIButton *buttonMainMix;
@property (weak, nonatomic) IBOutlet UIButton *buttonReverb;
@property (weak, nonatomic) IBOutlet UIButton *buttonDelay;
@property (weak, nonatomic) IBOutlet UIButton *buttonDistortion;
@property (weak, nonatomic) IBOutlet UIButton *buttonDrums;
@property (weak, nonatomic) IBOutlet UIButton *buttonMicrophone;
@property (weak, nonatomic) IBOutlet UIButton *buttonInstument2;
@property (weak, nonatomic) IBOutlet UIButton *buttonInstument1;


- (IBAction)didTapPlay:(UIButton *)sender;
- (IBAction)didTapRecord:(UIButton *)sender;

@end

