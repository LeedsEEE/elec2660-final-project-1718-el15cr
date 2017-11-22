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
        

        
        
    }
    return self;
}


-(void) changeReverb {
    
    if (self.selectedReverb == 0){
        
        [self.audioEngine.audioUnitReverb loadFactoryPreset:AVAudioUnitReverbPresetPlate];
        
    } else if (self.selectedReverb == 1) {
        
        [self.audioEngine.audioUnitReverb loadFactoryPreset:AVAudioUnitReverbPresetLargeChamber];
        
    } else if (self.selectedReverb == 2) {
        
        [self.audioEngine.audioUnitReverb loadFactoryPreset:AVAudioUnitReverbPresetSmallRoom];
        
    }
    
}

@end
