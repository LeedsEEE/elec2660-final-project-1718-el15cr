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

@property (nonatomic, strong) AVAudioSession *audioSession;
@property (nonatomic, strong) AVAudioEngine *engine;
@property (nonatomic, strong) AVAudioPlayerNode *playerInstument1;
@property (nonatomic, strong) AVAudioPlayerNode *playerInstument2;
@property (nonatomic, strong) AVAudioPlayerNode *playerDrums;
@property (nonatomic, strong) AVAudioPlayerNode *playerMicrophone;
@property (nonatomic, strong) AVAudioPlayerNode *playerMainOut;
@property (nonatomic, strong) AVAudioFile *outputFileInstument1;
@property (nonatomic, strong) AVAudioFile *outputFileInstument2;
@property (nonatomic, strong) AVAudioFile *outputFileDrums;
@property (nonatomic, strong) AVAudioFile *outputFileMicrophone;
@property (nonatomic, strong) AVAudioFile *outputFileMainOut;
@property (nonatomic, strong) AVAudioMixerNode *mainMixer;
@property (nonatomic, strong) AVAudioInputNode *inputMicrophone;
@property (nonatomic, strong) AVAudioMixerNode *busReverb;
@property (nonatomic, strong) AVAudioMixerNode *busDistortion;
@property (nonatomic, strong) AVAudioMixerNode *busDelay;
@property (nonatomic, strong) AVAudioMixerNode *busDirectOut;
@property (nonatomic, strong) AVAudioUnitDelay *audioUnitDelay;
@property (nonatomic, strong) AVAudioUnitReverb *audioUnitReverb;
@property (nonatomic, strong) AVAudioUnitDistortion *audioUnitDistortion;
@property (nonatomic, strong) AVAudioUnitTimePitch *audioUnitTimePitch;
@property (nonatomic, strong) AVAudioUnitSampler *samplerDrums;
@property (nonatomic, strong) AVAudioUnitSampler *samplerInstrument1;
@property (nonatomic, strong) AVAudioUnitSampler *samplerInstrument2;
@property (nonatomic, strong) AVAudioFormat *audioFormat;
@property (nonatomic, strong) AVAudioPCMBuffer *bufferInstument1;
@property (nonatomic, strong) AVAudioPCMBuffer *bufferInstument2;
@property (nonatomic, strong) AVAudioPCMBuffer *bufferDrums;
@property (nonatomic, strong) AVAudioPCMBuffer *bufferMicrophone;
@property (nonatomic, strong) AVAudioMixingDestination *sendReverbInstrument1;
@property (nonatomic, strong) AVAudioMixingDestination *sendReverbInstrument2;
@property (nonatomic, strong) AVAudioMixingDestination *sendReverbDrums;
@property (nonatomic, strong) AVAudioMixingDestination *sendReverbMicrophone;
@property (nonatomic, strong) AVAudioMixingDestination *sendDelayInstrument1;
@property (nonatomic, strong) AVAudioMixingDestination *sendDelayInstrument2;
@property (nonatomic, strong) AVAudioMixingDestination *sendDelayDrums;
@property (nonatomic, strong) AVAudioMixingDestination *sendDelayMicrophone;
@property (nonatomic, strong) AVAudioMixingDestination *sendDistortionInstrument1;
@property (nonatomic, strong) AVAudioMixingDestination *sendDistortionInstrument2;
@property (nonatomic, strong) AVAudioMixingDestination *sendDistortionDrums;
@property (nonatomic, strong) AVAudioMixingDestination *sendDistortionMicrophone;
@property (nonatomic, strong) AVAudioMixingDestination *sendDirectOutInstrument1;
@property (nonatomic, strong) AVAudioMixingDestination *sendDirectOutInstrument2;
@property (nonatomic, strong) AVAudioMixingDestination *sendDirectOutDrums;
@property (nonatomic, strong) AVAudioMixingDestination *sendDirectOutMicrophone;
@property (nonatomic, strong) AVAudioMixingDestination *sendReverbPlayerInstrument1;
@property (nonatomic, strong) AVAudioMixingDestination *sendDelayPlayerInstrument1;
@property (nonatomic, strong) AVAudioMixingDestination *sendDistortionPlayerInstrument1;
@property (nonatomic, strong) AVAudioMixingDestination *sendDirectOutPlayerInstrument1;
@property (nonatomic, strong) AVAudioMixingDestination *sendReverbPlayerInstrument2;
@property (nonatomic, strong) AVAudioMixingDestination *sendDelayPlayerInstrument2;
@property (nonatomic, strong) AVAudioMixingDestination *sendDistortionPlayerInstrument2;
@property (nonatomic, strong) AVAudioMixingDestination *sendDirectOutPlayerInstrument2;
@property (nonatomic, strong) AVAudioMixingDestination *sendReverbPlayerDrums;
@property (nonatomic, strong) AVAudioMixingDestination *sendDelayPlayerDrums;
@property (nonatomic, strong) AVAudioMixingDestination *sendDistortionPlayerDrums;
@property (nonatomic, strong) AVAudioMixingDestination *sendDirectOutPlayerDrums;
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
@property NSInteger octave;
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

-(void) playInstrument2: (int) note;
-(void) stopInstrument2: (int) note;
-(void) panInstrument2: (float) pan;

-(void) playDrums: (int) note;
-(void) stopDrums: (int) note;

-(void) sendsForReverb: (float)reverbInstrument1 : (float)reverbInstrument2 : (float)reverbDrums : (float)reverbMicrohpone;
-(void) sendsForDirectOut: (float)directInstrument1 : (float)directInstrument2 : (float)directDrums : (float)directMicrohpone;
-(void) sendsForDelay: (float)delayInstrument1 : (float)delayInstrument2 : (float)delayDrums : (float)delayMicrohpone;
-(void) sendsForDistortion: (float)distortionInstrument1 : (float)distortionInstrument2 : (float)distortionDrums : (float)distortionMicrohpone;

-(void) volumeMainMixer: (float) volume;

-(void) audioUnitReverbWetDry: (float) wetDry;

-(void) audioUnitDelayTime: (float) delayTime;
-(void) audioUnitDelayFeedback: (float) feedback;
-(void) audioUnitDelayWetDry: (float) wetDry;
-(void) audioUnitDelayLowPassCutoff: (float) cutoff;

-(void) audioUnitDistortionPreGain: (float) preGain;
-(void) audioUnitDistortionWetDry: (float) wetDry;

-(void) audioUnitTimePitchRate: (float) rate;
-(void) audioUnitTimePitchOverlap: (float) overlap;
-(void) audioUnitTimePitch: (float) pitch;

-(void) changeReverb: (NSInteger) selectedReverb;
-(void) changeDistortion: (NSInteger) selectedDistortion;
-(void) changeInstrument1: (NSInteger) selectedInstument1;
-(void) changeInstrument2: (NSInteger) selectedInstument2;
-(void) changeDrums: (NSInteger) selectedDrums;

-(void) startRecordingInstument1;
-(void) stopRecordingInstument1;
-(void) startPlayingInstument1;

-(void) startRecordingInstument2;
-(void) stopRecordingInstument2;
-(void) startPlayingInstument2;

-(void) startRecordingDrums;
-(void) stopRecordingDrums;
-(void) startPlayingDrums;

-(void) startRecordingMainOut;
-(void) stopRecordingMainOut;
-(void) startPlayingMainOut;

-(void) startRecordingMicrophone;
-(void) stopRecordingMicrophone;
-(void) startPlayingMicrophone;


@end
