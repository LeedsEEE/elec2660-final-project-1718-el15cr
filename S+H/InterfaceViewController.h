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
@property (weak, nonatomic) IBOutlet UISlider *sliderVolume;
@property (weak, nonatomic) IBOutlet UIButton *buttonSettings;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet UIView *midView2;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *bridgeView;
@property (weak, nonatomic) IBOutlet UIView *bridgeView2;


- (IBAction)didTapPlay:(UIButton *)sender;
- (IBAction)didTapRecord:(UIButton *)sender;
- (IBAction)didMoveSliderVolume:(UISlider *)sender;

@end

