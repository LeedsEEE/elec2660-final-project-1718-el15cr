//
//  Instrument1ViewController.m
//  S+H
//
//  Created by Callum on 19/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

// References
//
// https://developer.apple.com/documentation/uikit/uiviewcontroller/1621473-unwindforsegue
// https://developer.apple.com/documentation/objectivec/nsobject/1410849-cancelpreviousperformrequestswit?language=objc

#import "Instrument1ViewController.h"

@interface Instrument1ViewController ()

@end

@implementation Instrument1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Loads the values from audio engine, so when the segue is done it shows the correct value

    self.pickerInstrument1.delegate = self;
    self.pickerInstrument1.dataSource = self;
    
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
    
    [self.audioEngine changeInstrument1:self.settings.selectedInstrument1];
    
    if (self.audioEngine.playerInstument1.isPlaying == true) {
        
        [self.buttonPlay setImage:[UIImage imageNamed:@"stopButton.png"] forState:UIControlStateNormal];
        
    } else if (self.audioEngine.playerInstument1.isPlaying == false){
        
        [self.buttonPlay setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
        
    }
    
    self.audioEngine.octave = self.audioEngine.octave;
    self.sliderPan.value = self.audioEngine.samplerInstrument1.pan;
    
    [self.pickerInstrument1 selectRow:self.settings.selectedInstrument1 inComponent:0 animated:YES];
    
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
    
    self.settings.selectedInstrument1 = [self.pickerInstrument1 selectedRowInComponent:0];
    
    [self.audioEngine changeInstrument1:self.settings.selectedInstrument1];
    
    NSLog(@"Instrument 1 selected: %@",self.settings.pickerInstrument1Data[row]);
    
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
    [sender setBackgroundColor:self.settings.colourPiano];
}
- (IBAction)didTapDownNote2:(UIButton *)sender {
    [self.audioEngine playInstrument1:61];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote3:(UIButton *)sender {
    [self.audioEngine playInstrument1:62];
    [sender setBackgroundColor:self.settings.colourPiano];
}
- (IBAction)didTapDownNote4:(UIButton *)sender {
    [self.audioEngine playInstrument1:63];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote5:(UIButton *)sender {
    [self.audioEngine playInstrument1:64];
    [sender setBackgroundColor:self.settings.colourPiano];
}
- (IBAction)didTapDownNote6:(UIButton *)sender {
    [self.audioEngine playInstrument1:65];
    [sender setBackgroundColor:self.settings.colourPiano];
}
- (IBAction)didTapDownNote7:(UIButton *)sender {
    [self.audioEngine playInstrument1:66];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote8:(UIButton *)sender {
    [self.audioEngine playInstrument1:67];
    [sender setBackgroundColor:self.settings.colourPiano];
}
- (IBAction)didTapDownNote9:(UIButton *)sender {
    [self.audioEngine playInstrument1:68];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote10:(UIButton *)sender {
    [self.audioEngine playInstrument1:69];
    [sender setBackgroundColor:self.settings.colourPiano];
}
- (IBAction)didTapDownNote11:(UIButton *)sender {
    [self.audioEngine playInstrument1:70];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote12:(UIButton *)sender {
    [self.audioEngine playInstrument1:71];
    [sender setBackgroundColor:self.settings.colourPiano];
}

- (IBAction)didTapInsideNote1:(UIButton *)sender {
    [self.audioEngine stopInstrument1:60];
    [sender setBackgroundColor:[UIColor whiteColor]];
}
- (IBAction)didTapInsideNote2:(UIButton *)sender {
    [self.audioEngine stopInstrument1:61];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote3:(UIButton *)sender {
    [self.audioEngine stopInstrument1:62];
    [sender setBackgroundColor:[UIColor whiteColor]];
}
- (IBAction)didTapInsideNote4:(UIButton *)sender {
    [self.audioEngine stopInstrument1:63];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote5:(UIButton *)sender {
    [self.audioEngine stopInstrument1:64];
    [sender setBackgroundColor:[UIColor whiteColor]];
}
- (IBAction)didTapInsideNote6:(UIButton *)sender {
    [self.audioEngine stopInstrument1:65];
    [sender setBackgroundColor:[UIColor whiteColor]];
}
- (IBAction)didTapInsideNote7:(UIButton *)sender {
    [self.audioEngine stopInstrument1:66];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote8:(UIButton *)sender {
    [self.audioEngine stopInstrument1:67];
    [sender setBackgroundColor:[UIColor whiteColor]];
}
- (IBAction)didTapInsideNote9:(UIButton *)sender {
    [self.audioEngine stopInstrument1:68];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote10:(UIButton *)sender {
    [self.audioEngine stopInstrument1:69];
    [sender setBackgroundColor:[UIColor whiteColor]];
}
- (IBAction)didTapInsideNote11:(UIButton *)sender {
    [self.audioEngine stopInstrument1:70];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote12:(UIButton *)sender {
    [self.audioEngine stopInstrument1:71];
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
    
    [self.audioEngine panInstrument1:self.sliderPan.value];
    
}

- (IBAction)didTapPlay:(UIButton *)sender {
    
    self.audioEngine.isLoopInstument1 = self.switchLoop.isOn;
    
    [self.audioEngine startPlayingInstument1];
    
    if (self.audioEngine.playerInstument1.isPlaying == true) {
        
        [self.buttonPlay setImage:[UIImage imageNamed:@"stopButton.png"] forState:UIControlStateNormal];
        
    } else if (self.audioEngine.playerInstument1.isPlaying == false){
        
        [self.buttonPlay setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
        
        
    }
    
}

- (IBAction)didTapRecord:(UIButton *)sender {
    
    // A delay is achived by using a timer
    // this has been added to allow the user time to move their hand
    // to the right notes they want to play
    
    if (self.audioEngine.isRecordingInstument1 == false) {
        
        [self.buttonRecord setImage:[UIImage imageNamed:@"recordButton1.png"] forState:UIControlStateNormal];
        
        self.audioEngine.isRecordingInstument1 = true;
        
        self.timerRecord = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(recordInstument1:) userInfo:nil repeats:NO];
        
        [self performSelector: @selector(recordTextLabe1:) withObject:self afterDelay: 2.0];
        [self performSelector: @selector(recordTextLabe2:) withObject:self afterDelay: 1.0];
        [self performSelector: @selector(recordTextLabe3:) withObject:self afterDelay: 0.0];

        self.buttonRecord.enabled = true;

        
    } else {
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(recordTextLabe1:) object:nil];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(recordTextLabe2:) object:nil];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(recordTextLabe3:) object:nil];
        
        [self.timerRecord invalidate];
        
        [self.audioEngine stopRecordingInstument1];
        
        [self.buttonRecordText setTitle:@"" forState:UIControlStateNormal];
        
        [self.buttonRecord setImage:[UIImage imageNamed:@"recordButton1.png"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)didTapSwitchLoop:(UISwitch *)sender {
    
    self.audioEngine.isLoopInstument1 = self.switchLoop.isOn;
    
}

-(void) recordInstument1: (NSTimer*) timer {
    
    [self.audioEngine startRecordingInstument1];
    
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
