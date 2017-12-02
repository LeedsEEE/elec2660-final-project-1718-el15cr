//
//  settings.h
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 22/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface settings : NSObject

@property (nonatomic, strong) NSUserDefaults *userDefaults; 

@property NSInteger selectedReverb;
@property NSInteger selectedDistortion;
@property NSInteger selectedInstrument1;
@property NSInteger selectedInstrument2;
@property NSInteger selectedDrums;
@property NSInteger selectedUserPreset;

@property UIColor *colourPiano;
@property UIColor *colourPiano2;

@property (nonatomic, strong) NSArray *pickerReverbData;
@property (nonatomic, strong) NSArray *pickerDistortionData;
@property (nonatomic, strong) NSArray *pickerInstrument1Data;
@property (nonatomic, strong) NSArray *pickerInstrument2Data;
@property (nonatomic, strong) NSArray *pickerDrumsData;
@property (nonatomic, strong) NSArray *pickerUserPresetData;
@property (nonatomic, strong) NSMutableArray *userPresetData1;
@property (nonatomic, strong) NSMutableArray *userPresetData2;

-(void) storeUserPreset;
-(void) loadUserPreset;

@end
