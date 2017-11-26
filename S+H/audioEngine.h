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
@property AVAudioPlayerNode *playerInstument1;
@property AVAudioPlayerNode *playerInstument2;
@property AVAudioPlayerNode *playerDrums;
@property AVAudioPlayerNode *playerMicrophone;
@property AVAudioPlayerNode *playerMainOut;
@property AVAudioFile *outputFileInstument1;
@property AVAudioFile *outputFileInstument2;
@property AVAudioFile *outputFileDrums;
@property AVAudioFile *outputFileMicrophone;
@property AVAudioFile *outputFileMainOut;
@property AVAudioMixerNode *mainMixer;
@property AVAudioInputNode *inputMicrophone;
@property AVAudioMixerNode *busReverb;
@property AVAudioMixerNode *busDistortion;
@property AVAudioMixerNode *busDelay;
@property AVAudioMixerNode *busDirectOut;
@property AVAudioUnitDelay *audioUnitDelay;
@property AVAudioUnitReverb *audioUnitReverb;
@property AVAudioUnitDistortion *audioUnitDistortion;
@property AVAudioUnitTimePitch *audioUnitTimePitch;
@property AVAudioUnitSampler *samplerDrums;
@property AVAudioUnitSampler *samplerInstrument1;
@property AVAudioUnitSampler *samplerInstrument2;
@property AVAudioFormat *audioFormat;
@property AVAudioPCMBuffer *bufferInstument1;
@property AVAudioPCMBuffer *bufferInstument2;
@property AVAudioPCMBuffer *bufferDrums;
@property AVAudioPCMBuffer *bufferMicrophone;
@property AVAudioMixingDestination *sendReverbInstrument1;
@property AVAudioMixingDestination *sendReverbInstrument2;
@property AVAudioMixingDestination *sendReverbDrums;
@property AVAudioMixingDestination *sendReverbMicrophone;
@property AVAudioMixingDestination *sendDelayInstrument1;
@property AVAudioMixingDestination *sendDelayInstrument2;
@property AVAudioMixingDestination *sendDelayDrums;
@property AVAudioMixingDestination *sendDelayMicrophone;
@property AVAudioMixingDestination *sendDistortionInstrument1;
@property AVAudioMixingDestination *sendDistortionInstrument2;
@property AVAudioMixingDestination *sendDistortionDrums;
@property AVAudioMixingDestination *sendDistortionMicrophone;
@property AVAudioMixingDestination *sendDirectOutInstrument1;
@property AVAudioMixingDestination *sendDirectOutInstrument2;
@property AVAudioMixingDestination *sendDirectOutDrums;
@property AVAudioMixingDestination *sendDirectOutMicrophone;
@property AVAudioMixingDestination *sendReverbPlayerInstrument1;
@property AVAudioMixingDestination *sendDelayPlayerInstrument1;
@property AVAudioMixingDestination *sendDistortionPlayerInstrument1;
@property AVAudioMixingDestination *sendDirectOutPlayerInstrument1;
@property AVAudioMixingDestination *sendReverbPlayerInstrument2;
@property AVAudioMixingDestination *sendDelayPlayerInstrument2;
@property AVAudioMixingDestination *sendDistortionPlayerInstrument2;
@property AVAudioMixingDestination *sendDirectOutPlayerInstrument2;
@property AVAudioMixingDestination *sendReverbPlayerDrums;
@property AVAudioMixingDestination *sendDelayPlayerDrums;
@property AVAudioMixingDestination *sendDistortionPlayerDrums;
@property AVAudioMixingDestination *sendDirectOutPlayerDrums;
@property (nonatomic, strong) NSURL *samplerInstrument1URL;
@property (nonatomic, strong) NSURL *samplerInstrument2URL;
@property (nonatomic, strong) NSURL *samplerIDrumsURL;
@property (nonatomic, strong) NSURL *outputFileInstument1URL;
@property (nonatomic, strong) NSURL *outputFileInstument2URL;
@property (nonatomic, strong) NSURL *outputFileDrumsURL;
@property (nonatomic, strong) NSURL *outputFileMicrophoneURL;
@property (nonatomic, strong) NSURL *outputFileMainOutURL;
@property (nonatomic, strong) NSArray <AVAudioConnectionPoint *>* connectionBusSend1;
@property (nonatomic, strong) NSArray <AVAudioConnectionPoint *>* connectionBusSend2;
@property (nonatomic, strong) NSArray <AVAudioConnectionPoint *>* connectionBusSend3;
@property (nonatomic, strong) NSArray <AVAudioConnectionPoint *>* connectionBusSend4;
@property (nonatomic, strong) NSArray <AVAudioConnectionPoint *>* connectionBusSend5;
@property (nonatomic, strong) NSArray <AVAudioConnectionPoint *>* connectionBusSend6;
@property (nonatomic, strong) NSArray <AVAudioConnectionPoint *>* connectionBusSend7;
@property (nonatomic) NSInteger octave;
@property bool isRecordingInstument1;
@property bool isRecordingInstument2;
@property bool isRecordingDrums;
@property bool isRecordingMicrophone;
@property bool isRecordingMainOut;
@property BOOL isLoopInstument1;
@property BOOL isLoopInstument2;
@property BOOL isLoopDrums;
@property BOOL isLoopMicrophone;


-(void) createSession;
-(void) createEngine;
-(void) attachNodes;
-(void) createConnections;
-(void) mixingDestination;
-(void) loadInstrumentDefaults;
-(void) loadAudioUnitDefaults;
-(void) perpareAndStartEngine;

-(void) playInstrument1: (int) note;
-(void) stopInstrument1: (int) note;
-(void) panInstrument1: (float) pan; 

-(void) sendsForReverb: (float)reverbInstrument1 : (float)reverbInstrument2 : (float)reverbDrums : (float)reverbMicrohpone;
-(void) audioUnitReverbWetDry: (float) wetDry;

-(void) sendsForDelay: (float)delayInstrument1 : (float)delayInstrument2 : (float)delayDrums : (float)delayMicrohpone;
-(void) audioUnitDelayTime: (float) delayTime;
-(void) audioUnitDelayFeedback: (float) feedback;
-(void) audioUnitDelayWetDry: (float) wetDry;
-(void) audioUnitDelayLowPassCutoff: (float) cutoff;

-(void) sendsForDistortion: (float)distortionInstrument1 : (float)distortionInstrument2 : (float)distortionDrums : (float)distortionMicrohpone;
-(void) audioUnitDistortionPreGain: (float) preGain;
-(void) audioUnitDistortionWetDry: (float) wetDry;

-(void) audioUnitTimePitchRate: (float) rate;
-(void) audioUnitTimePitchOverlap: (float) overlap;
-(void) audioUnitTimePitch: (float) pitch;

-(void) sendsForDirectOut: (float)directInstrument1 : (float)directInstrument2 : (float)directDrums : (float)directMicrohpone;

-(void) changeReverb: (NSInteger) selectedReverb;
-(void) changeDistortion: (NSInteger) selectedDistortion;
-(void) changeInstrument1: (NSInteger) selectedInstument1;
-(void) changeInstrument2: (NSInteger) selectedInstument2;
-(void) changeDrums: (NSInteger) selectedDrums;

-(void) startRecordingInstument1;
-(void) stopRecordingInstument1;
-(void) startPlayingInstument1;
-(void) loopInstrument1: (BOOL) isLoop;
-(void) startRecordingMainOut;
-(void) stopRecordingMainOut;
-(void) startPlayingMainOut;

-(void) startRecordingMicrophone;
-(void) stopRecordingMicrophone;
-(void) startPlayingMicrophone;

@end
