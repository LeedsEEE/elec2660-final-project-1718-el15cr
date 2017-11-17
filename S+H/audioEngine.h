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
@property AVAudioUnitSampler *samplerInstument1;
@property AVAudioUnitSampler *samplerInstument2;
@property AVAudioFormat *audioFormat;
@property NSArray <AVAudioConnectionPoint *>* connectionBusSend1;
@property NSArray <AVAudioConnectionPoint *>* connectionBusSend2;
@property NSArray <AVAudioConnectionPoint *>* connectionBusSend3;
@property NSArray <AVAudioConnectionPoint *>* connectionBusSend4;

-(void) createSession;
-(void) createEngine;
-(void) attachNodes;
-(void) createConnections;


@end
