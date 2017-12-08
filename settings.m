 //
//  settings.m
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 22/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

// References
//
// https://stackoverflow.com/questions/19634426/how-to-save-nsmutablearray-in-nsuserdefaults

#import "settings.h"

@implementation settings

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.userDefaults = [NSUserDefaults standardUserDefaults];
        
        self.userPresetData1 = [NSMutableArray array];
        self.userPresetData2 = [NSMutableArray array];
        
        self.selectedReverb = 0;
        self.selectedDistortion =0;
        self.selectedInstrument1 =0;
        self.selectedInstrument2 =0;
        self.selectedDrums =0;
        self.selectedUserPreset =0;
        
        self.pickerReverbData = @[@"Small Room", @"Medium Room",@"Large Room",@"Large Room 2",@"Meduim Hall",@"Medium Hall 2",@"Meduim Hall 3",@"Large Hall",@"Large Hall 2",@"Medium Chamber",@"Large Chamber",@"Plate",@"Cathedral"];
        
        self.pickerDistortionData = @[@"Drums Bit Brush", @"Drums Buffer Beats",@"Drums Lo-Fi",@"Multi Broken Speaker", @"Multi Cellphone Concert",@"Multi Decimated 1", @"Multi Decimated 2",@"Multi Decimated 3",@"Multi Decimated 4", @"Multi Distorted Funk",@"Multi Distorted Cubed",@"Multi Distorted Squared", @"Multi Echo 1",@"Multi Echo 2",@"Multi Echo Tight 1", @"Multi Echo Tight 2",@"Multi Everything Is Broken",@"Speech Alien Chatter",@"Speech Cosmic Interference",@"Speech Golden Pi",@"Speech Radio Tower",@"Speech Waves"];
        
        self.pickerInstrument1Data = @[@"Piano 1", @"Piano 2",@"Xylophone",@"Church Organ",@"Violin",@"Viola",@"Choir Aahs",@"Ocarina",@"Chiffer Lead",@"5th Saw Wave"];
        
        self.pickerInstrument2Data = @[@"Fingered Bass", @"Picked Bass",@"Synth Bass",@"Cello",@"Pizzicato",@"Synth Vox",@"Trumpet",@"Synth Brass",@"Shakuhachi",@"Bass and Lead",@"Fantasia"];
        
        self.pickerDrumsData = @[@"TR-808", @"TR-909", @"Rave", @"House", @"Techno", @"Jazz"];
        
        self.pickerUserPresetData = @[@"User Preset 1", @"User Preset 2"];
        
        self.colourPiano = [[UIColor alloc] initWithDisplayP3Red:0.79 green:0.79 blue:0.79 alpha:1];
        self.colourPiano2 = [[UIColor alloc] initWithDisplayP3Red:0.257 green:0.257 blue:0.257 alpha:1];
        
        self.colourOctave = [[UIColor alloc] initWithDisplayP3Red:0.13 green:0.13 blue:0.13 alpha:1];
        
        
    }
    return self;
}

-(void) loadUserPreset {
    
    // Loads the array that was stored in user deafaults using the key.
    
    if (self.selectedUserPreset == 0) {
        
        self.userPresetData1 = [[self.userDefaults arrayForKey:@"userPreset1"] mutableCopy];
        
        NSLog(@"User Preset 1 loaded");
        
    } else if (self.selectedUserPreset == 1){
        
        self.userPresetData2 = [[self.userDefaults arrayForKey:@"userPreset2"] mutableCopy];
        
        NSLog(@"User Preset 2 loaded");
    }
    

}

-(void) storeUserPreset {
    
    // Stores the array in user deafaults using the key to easliy find the array again
    
    if (self.selectedUserPreset == 0) {
        
        [self.userDefaults setObject:self.userPresetData1 forKey:@"userPreset1"];
        
        [self.userDefaults synchronize];
        
        NSLog(@"User Preset 1 stored");
        
    } else if (self.selectedUserPreset == 1){
        
        [self.userDefaults setObject:self.userPresetData2 forKey:@"userPreset2"];
        
        [self.userDefaults synchronize];
        
        NSLog(@"User Preset 2 stored");
    }
    
}

@end
