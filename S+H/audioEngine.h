//
//  audioEngine.h
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 17/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface audioEngine : NSObject

@property AVAudioSession *audioSession;
@property AVAudioEngine *engine;
@property AVAudioPlayerNode *player;
@property AVAudioMixerNode *mainMixer;
@property AVAudioMixerNode *busReverb;
@property AVAudioMixerNode *busDistortion;
@property AVAudioMixerNode *busDelay;
@property AVAudioMixerNode *busDirectOut;
@property AVAudioUnitDelay *audioUnitDelay;
@property AVAudioUnitReverb *audioUnitReverb;
@property AVAudioUnitDistortion *audioUnitDistortion;
@property AVAudioUnitSampler *samplerDrums;
@property AVAudioUnitSampler *samplerInstrument1;
@property AVAudioUnitSampler *samplerInstrument2;
@property AVAudioFormat *audioFormat;
@property (nonatomic, strong) NSURL *samplerInstrument1URL;
@property (nonatomic, strong) NSURL *samplerInstrument2URL;
@property (nonatomic, strong) NSURL *samplerIDrumsURL;
@property (nonatomic, strong) NSArray <AVAudioConnectionPoint *>* connectionBusSend1;
@property (nonatomic, strong) NSArray <AVAudioConnectionPoint *>* connectionBusSend2;
@property (nonatomic, strong) NSArray <AVAudioConnectionPoint *>* connectionBusSend3;
@property (nonatomic, strong) NSArray <AVAudioConnectionPoint *>* connectionBusSend4;
@property (nonatomic) NSInteger octave;

-(void) createSession;
-(void) createEngine;
-(void) attachNodes;
-(void) createConnections;
-(void) loadInstrumentDefaults;
-(void) loadAudioUnitDefaults;
-(void) perpareAndStartEngine;

-(void) playInstrument1: (int) note;
-(void) stopInstrument1: (int) note;


@end
