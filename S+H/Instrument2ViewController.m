//
//  Instrument2ViewController.m
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 21/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

// References
//
// https://developer.apple.com/documentation/uikit/uiviewcontroller/1621473-unwindforsegue
// https://developer.apple.com/documentation/objectivec/nsobject/1410849-cancelpreviousperformrequestswit?language=objc

#import "Instrument2ViewController.h"

@interface Instrument2ViewController ()

@end

@implementation Instrument2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Loads the values from audio engine, so when the segue is done it shows the correct value
    
    self.pickerInstrument2.delegate = self;
    self.pickerInstrument2.dataSource = self;
    
    self.buttonRecord.layer.cornerRadius = 10;
    self.buttonPlay.layer.cornerRadius = 10;
    
    self.buttonOctaveUp.layer.cornerRadius = 10;
    self.buttonOctaveUp.layer.borderColor = self.settings.colourOctave.CGColor;
    self.buttonOctaveUp.layer.borderWidth = 2.0;
    self.buttonOctaveDown.layer.cornerRadius = 10;
    self.buttonOctaveDown.layer.borderColor = self.settings.colourOctave.CGColor;
    self.buttonOctaveDown.layer.borderWidth = 2.0;
    
    self.buttonNote1.layer.cornerRadius = 5;
    self.buttonNote2.layer.cornerRadius = 5;
    self.buttonNote3.layer.cornerRadius = 5;
    self.buttonNote4.layer.cornerRadius = 5;
    self.buttonNote5.layer.cornerRadius = 5;
    self.buttonNote6.layer.cornerRadius = 5;
    self.buttonNote7.layer.cornerRadius = 5;
    self.buttonNote8.layer.cornerRadius = 5;
    self.buttonNote9.layer.cornerRadius = 5;
    self.buttonNote10.layer.cornerRadius = 5;
    self.buttonNote11.layer.cornerRadius = 5;
    self.buttonNote12.layer.cornerRadius = 5;
    
    [self.audioEngine changeInstrument2:self.settings.selectedInstrument2];
    
    if (self.audioEngine.playerInstument2.isPlaying == true) {
        
        [self.buttonPlay setImage:[UIImage imageNamed:@"stopButton.png"] forState:UIControlStateNormal];
        
    } else if (self.audioEngine.playerInstument2.isPlaying == false){
        
        [self.buttonPlay setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
        
    }
    
    self.audioEngine.octave = self.audioEngine.octave;
    self.sliderPan.value = self.audioEngine.samplerInstrument2.pan; 
    
    [self.pickerInstrument2 selectRow:self.settings.selectedInstrument2 inComponent:0 animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) unwindForSegue:(nonnull UIStoryboardSegue *)unwindSegue towardsViewController:(nonnull UIViewController *)subsequentVC{
    
    // Goes back from segue to the original view controller
    
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    // When the picker has been moved it changes the preset in audio engine
    // this is done by sending the vaule of the picker to the settings class first
    
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
    [sender setBackgroundColor:self.settings.colourPiano];
}
- (IBAction)didTapDownNote2:(UIButton *)sender {
    [self.audioEngine playInstrument2:61];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote3:(UIButton *)sender {
    [self.audioEngine playInstrument2:62];
    [sender setBackgroundColor:self.settings.colourPiano];
}
- (IBAction)didTapDownNote4:(UIButton *)sender {
    [self.audioEngine playInstrument2:63];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote5:(UIButton *)sender {
    [self.audioEngine playInstrument2:64];
    [sender setBackgroundColor:self.settings.colourPiano];
}
- (IBAction)didTapDownNote6:(UIButton *)sender {
    [self.audioEngine playInstrument2:65];
    [sender setBackgroundColor:self.settings.colourPiano];
}
- (IBAction)didTapDownNote7:(UIButton *)sender {
    [self.audioEngine playInstrument2:66];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote8:(UIButton *)sender {
    [self.audioEngine playInstrument2:67];
    [sender setBackgroundColor:self.settings.colourPiano];
}
- (IBAction)didTapDownNote9:(UIButton *)sender {
    [self.audioEngine playInstrument2:68];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote10:(UIButton *)sender {
    [self.audioEngine playInstrument2:69];
    [sender setBackgroundColor:self.settings.colourPiano];
}
- (IBAction)didTapDownNote11:(UIButton *)sender {
    [self.audioEngine playInstrument2:70];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote12:(UIButton *)sender {
    [self.audioEngine playInstrument2:71];
    [sender setBackgroundColor:self.settings.colourPiano];
}

- (IBAction)didTapInsideNote1:(UIButton *)sender {
    [self.audioEngine stopInstrument2:60];
    [sender setBackgroundColor:[UIColor whiteColor]];
}
- (IBAction)didTapInsideNote2:(UIButton *)sender {
    [self.audioEngine stopInstrument2:61];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote3:(UIButton *)sender {
    [self.audioEngine stopInstrument2:62];
    [sender setBackgroundColor:[UIColor whiteColor]];
}
- (IBAction)didTapInsideNote4:(UIButton *)sender {
    [self.audioEngine stopInstrument2:63];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote5:(UIButton *)sender {
    [self.audioEngine stopInstrument2:64];
    [sender setBackgroundColor:[UIColor whiteColor]];
}
- (IBAction)didTapInsideNote6:(UIButton *)sender {
    [self.audioEngine stopInstrument2:65];
    [sender setBackgroundColor:[UIColor whiteColor]];
}
- (IBAction)didTapInsideNote7:(UIButton *)sender {
    [self.audioEngine stopInstrument2:66];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote8:(UIButton *)sender {
    [self.audioEngine stopInstrument2:67];
    [sender setBackgroundColor:[UIColor whiteColor]];
}
- (IBAction)didTapInsideNote9:(UIButton *)sender {
    [self.audioEngine stopInstrument2:68];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote10:(UIButton *)sender {
    [self.audioEngine stopInstrument2:69];
    [sender setBackgroundColor:[UIColor whiteColor]];
}
- (IBAction)didTapInsideNote11:(UIButton *)sender {
    [self.audioEngine stopInstrument2:70];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote12:(UIButton *)sender {
    [self.audioEngine stopInstrument2:71];
    [sender setBackgroundColor:[UIColor whiteColor]];
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

    
    self.audioEngine.isLoopInstument2 = self.switchLoop.isOn;
    
    [self.audioEngine startPlayingInstument2];
    
    if (self.audioEngine.playerInstument2.isPlaying == true) {
        
        [self.buttonPlay setImage:[UIImage imageNamed:@"stopButton.png"] forState:UIControlStateNormal];
        
    } else if (self.audioEngine.playerInstument2.isPlaying == false){
        
        [self.buttonPlay setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
        
    }
    
}

- (IBAction)didTapRecord:(UIButton *)sender {
    
    // A delay is achived by using a timer
    // this has been added to allow the user time to move their hand
    // to the right notes they want to play
    
    if (self.audioEngine.isRecordingInstument2 == false) {
        
        [self.buttonRecord setImage:[UIImage imageNamed:@"recordButton1.png"] forState:UIControlStateNormal];
        
        self.audioEngine.isRecordingInstument2 = true;
        
        self.timerRecord = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(recordInstument2:) userInfo:nil repeats:NO];
        
        [self performSelector: @selector(recordTextLabe1:) withObject:self afterDelay: 2.0];
        [self performSelector: @selector(recordTextLabe2:) withObject:self afterDelay: 1.0];
        [self performSelector: @selector(recordTextLabe3:) withObject:self afterDelay: 0.0];
        
    } else {
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(recordTextLabe1:) object:nil];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(recordTextLabe2:) object:nil];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(recordTextLabe3:) object:nil];
        
        [self.timerRecord invalidate];
        
        [self.audioEngine stopRecordingInstument2];
        
        [self.buttonRecordText setTitle:@"" forState:UIControlStateNormal];
        
        [self.buttonRecord setImage:[UIImage imageNamed:@"recordButton1.png"] forState:UIControlStateNormal];
        
    }
    
}

- (IBAction)didTapSwitchLoop:(UISwitch *)sender {
    
    self.audioEngine.isLoopInstument2 = self.switchLoop.isOn;
    
}

-(void) recordInstument2: (NSTimer*) timer {
    
    [self.audioEngine startRecordingInstument2];
    
}

-(void) recordTextLabe1: (id) trigger {
    
    [self.buttonRecord setImage:[UIImage imageNamed:@"recordButton2.png"] forState:UIControlStateNormal];
}

-(void) recordTextLabe2: (id) trigger {
    
    [self.buttonRecordText setTitle:@"2" forState:UIControlStateNormal];
}

-(void) recordTextLabe3: (id) trigger {
    
    [self.buttonRecordText setTitle:@"1" forState:UIControlStateNormal];
}


@end
