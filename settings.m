 //
//  settings.m
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 22/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import "settings.h"


@implementation settings

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.selectedReverb = 0;
        self.selectedDistortion =0;
        self.selectedInstrument1 =0;
        self.selectedInstrument2 =0;
        self.selectedDrums =0;
        
        self.pickerReverbData = @[@"Small Room", @"Medium Room",@"Large Room",@"Large Room 2",@"Meduim Hall",@"Medium Hall 2",@"Meduim Hall 3",@"Large Hall",@"Large Hall 2",@"Medium Chamber",@"Large Chamber",@"Plate",@"Cathedral"];
        
        self.pickerDistortionData = @[@"Drums Bit Brush", @"Drums Buffer Beats",@"Drums Lo-Fi",@"Multi Broken Speaker", @"Multi Cellphone Concert",@"Multi Decimated 1", @"Multi Decimated 2",@"Multi Decimated 3",@"Multi Decimated 4", @"Multi Distorted Funk",@"Multi Distorted Cubed",@"Multi Distorted Squared", @"Multi Echo 1",@"Multi Echo 2",@"Multi Echo Tight 1", @"Multi Echo Tight 2",@"Multi Everything Is Broken",@"Speech Alien Chatter",@"Speech Cosmic Interference",@"Speech Golden Pi",@"Speech Radio Tower",@"Speech Waves"];
        
        self.pickerInstrument1Data = @[@"Piano 1", @"Piano 2",@"Xylophone",@"Church Organ",@"Violin",@"Viola",@"Choir Aahs",@"Ocarina",@"Chiffer Lead",@"5th Saw Wave"];
        
        self.pickerInstrument2Data = @[@"Piano 1", @"Piano 2",@"Xylophone",@"Church Organ",@"Violin",@"Viola",@"Choir Aahs",@"Ocarina",@"Chiffer Lead",@"5th Saw Wave"];
        
        self.pickerDrumsData = @[@"Drums 1", @"Drums 2"];
        
    }
    return self;
}


@end
