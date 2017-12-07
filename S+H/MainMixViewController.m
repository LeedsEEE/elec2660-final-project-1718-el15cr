//
//  MainMixViewController.m
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 21/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

// References
//
// https://developer.apple.com/documentation/uikit/uiviewcontroller/1621473-unwindforsegue

#import "MainMixViewController.h"

@interface MainMixViewController ()

@end

@implementation MainMixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Loads the values from audio engine, so when the segue is done it shows the correct value
    
    self.sliderInstrument1.value = self.audioEngine.sendDirectOutInstrument1.volume;
    self.sliderInstrument2.value = self.audioEngine.sendDirectOutInstrument2.volume;
    self.sliderDrums.value = self.audioEngine.sendDirectOutDrums.volume;
    self.sliderMicrophone.value = self.audioEngine.sendDirectOutMicrophone.volume;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) unwindForSegue:(nonnull UIStoryboardSegue *)unwindSegue towardsViewController:(nonnull UIViewController *)subsequentVC{
    
    // Goes back from segue to the original view controller
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// IBActions to send the value from the view controler to the audio engine
// allowing the user to make changes.

- (IBAction)didMoveSliderInstrument1:(UISlider *)sender {
    
    [self.audioEngine sendsForDirectOut:self.sliderInstrument1.value :self.sliderInstrument2.value :self.sliderDrums.value :self.sliderMicrophone.value];
    
}

- (IBAction)didMoveSliderInstrument2:(UISlider *)sender {
    
    [self.audioEngine sendsForDirectOut:self.sliderInstrument1.value :self.sliderInstrument2.value :self.sliderDrums.value :self.sliderMicrophone.value];
    
}

- (IBAction)didMoveSliderDrums:(UISlider *)sender {
    
    [self.audioEngine sendsForDirectOut:self.sliderInstrument1.value :self.sliderInstrument2.value :self.sliderDrums.value :self.sliderMicrophone.value];
    
}

- (IBAction)didMoveSliderMircophone:(UISlider *)sender {
    
    [self.audioEngine sendsForDirectOut:self.sliderInstrument1.value :self.sliderInstrument2.value :self.sliderDrums.value :self.sliderMicrophone.value];
    
}
@end
