//
//  DrumsViewController.m
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 21/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

// References
//
// https://developer.apple.com/documentation/uikit/uiviewcontroller/1621473-unwindforsegue
// https://developer.apple.com/documentation/objectivec/nsobject/1410849-cancelpreviousperformrequestswit?language=objc

#import "DrumsViewController.h"

@interface DrumsViewController ()

@end

@implementation DrumsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Loads the values from audio engine, so when the segue is done it shows the correct value
    
    self.pickerDrums.delegate = self;
    self.pickerDrums.dataSource = self;
    
    self.buttonRecord.layer.cornerRadius = 10;
    self.buttonPlay.layer.cornerRadius = 10;

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
    
    [self.audioEngine changeDrums:self.settings.selectedDrums];
    
    if (self.audioEngine.playerDrums.isPlaying == true) {
        
        [self.buttonPlay setImage:[UIImage imageNamed:@"stopButton.png"] forState:UIControlStateNormal];
        
    } else if (self.audioEngine.playerDrums.isPlaying == false){
        
        [self.buttonPlay setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
        
    }
    
    self.audioEngine.octave = self.audioEngine.octave;
    
    [self.pickerDrums selectRow:self.settings.selectedDrums inComponent:0 animated:YES];
    
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
    
    self.settings.selectedDrums = [self.pickerDrums selectedRowInComponent:0];
    
    [self.audioEngine changeDrums:self.settings.selectedDrums];
    
    NSLog(@"Drums selected: %@",self.settings.pickerDrumsData[row]);
    
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}


-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.settings.pickerDrumsData.count;
    
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return self.settings.pickerDrumsData[row];
    
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
    [self.audioEngine playDrums:36];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote2:(UIButton *)sender {
    [self.audioEngine playDrums:37];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote3:(UIButton *)sender {
    [self.audioEngine playDrums:38];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote4:(UIButton *)sender {
    [self.audioEngine playDrums:39];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote5:(UIButton *)sender {
    [self.audioEngine playDrums:40];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote6:(UIButton *)sender {
    [self.audioEngine playDrums:41];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote7:(UIButton *)sender {
    [self.audioEngine playDrums:42];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote8:(UIButton *)sender {
    [self.audioEngine playDrums:43];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote9:(UIButton *)sender {
    [self.audioEngine playDrums:44];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote10:(UIButton *)sender {
    [self.audioEngine playDrums:45];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote11:(UIButton *)sender {
    [self.audioEngine playDrums:46];
    [sender setBackgroundColor:self.settings.colourPiano2];
}
- (IBAction)didTapDownNote12:(UIButton *)sender {
    [self.audioEngine playDrums:47];
    [sender setBackgroundColor:self.settings.colourPiano2];
}

- (IBAction)didTapInsideNote1:(UIButton *)sender {
    [self.audioEngine stopDrums:36];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote2:(UIButton *)sender {
    [self.audioEngine stopDrums:37];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote3:(UIButton *)sender {
    [self.audioEngine stopDrums:38];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote4:(UIButton *)sender {
    [self.audioEngine stopDrums:39];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote5:(UIButton *)sender {
    [self.audioEngine stopDrums:40];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote6:(UIButton *)sender {
    [self.audioEngine stopDrums:41];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote7:(UIButton *)sender {
    [self.audioEngine stopDrums:42];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote8:(UIButton *)sender {
    [self.audioEngine stopDrums:43];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote9:(UIButton *)sender {
    [self.audioEngine stopDrums:44];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote10:(UIButton *)sender {
    [self.audioEngine stopDrums:45];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote11:(UIButton *)sender {
    [self.audioEngine stopDrums:46];
    [sender setBackgroundColor:[UIColor blackColor]];
}
- (IBAction)didTapInsideNote12:(UIButton *)sender {
    [self.audioEngine stopDrums:47];
    [sender setBackgroundColor:[UIColor blackColor]];
}

- (IBAction)didTapPlay:(UIButton *)sender {
    
    [self.audioEngine startPlayingDrums];
    self.audioEngine.isLoopDrums= self.switchLoop.isOn;
    
    if (self.audioEngine.playerDrums.isPlaying == true) {
        
        [self.buttonPlay setImage:[UIImage imageNamed:@"stopButton.png"] forState:UIControlStateNormal];
        
    } else if (self.audioEngine.playerDrums.isPlaying == false){
        
        [self.buttonPlay setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
        
    }
    
}

- (IBAction)didTapRecord:(UIButton *)sender {
    
    // A delay is achived by using a timer
    // this has been added to allow the user time to move their hand
    // to the right notes they want to play
    
    if (self.audioEngine.isRecordingDrums == false) {
        
        [self.buttonRecord setImage:[UIImage imageNamed:@"recordButton1.png"] forState:UIControlStateNormal];
        
        self.audioEngine.isRecordingDrums = true;
        
        self.timerRecord = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(recordDrums:) userInfo:nil repeats:NO];
        
        [self performSelector: @selector(recordTextLabe1:) withObject:self afterDelay: 2.0];
        [self performSelector: @selector(recordTextLabe2:) withObject:self afterDelay: 1.0];
        [self performSelector: @selector(recordTextLabe3:) withObject:self afterDelay: 0.0];
        
    } else {
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(recordTextLabe1:) object:nil];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(recordTextLabe2:) object:nil];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(recordTextLabe3:) object:nil];
            
        [self.timerRecord invalidate];
        
        [self.audioEngine stopRecordingDrums];
        
        [self.buttonRecordText setTitle:@"" forState:UIControlStateNormal];
        
        [self.buttonRecord setImage:[UIImage imageNamed:@"recordButton1.png"] forState:UIControlStateNormal];
        
    }
    
}

- (IBAction)didTapSwitchLoop:(UISwitch *)sender {
    
    self.audioEngine.isLoopDrums = self.switchLoop.isOn;
    
}

-(void) recordDrums: (NSTimer*) timer {
    
    [self.audioEngine startRecordingDrums];
    
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
