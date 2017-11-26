//
//  settings.h
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 22/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "audioEngine.h"

@interface settings : NSObject

@property audioEngine *audioEngine;

@property (nonatomic) NSInteger selectedReverb;
@property (nonatomic) NSInteger selectedDistortion;
@property (nonatomic) NSInteger selectedInstrument1;
@property (nonatomic) NSInteger selectedInstrument2;
@property (nonatomic) NSInteger selectedDrums;

@property NSArray *pickerReverbData;
@property NSArray *pickerDistortionData;
@property NSArray *pickerInstrument1Data;
@property NSArray *pickerInstrument2Data;
@property NSArray *pickerDrumsData;



@end
