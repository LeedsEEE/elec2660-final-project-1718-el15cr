//
//  audioEngine.m
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 17/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import "audioEngine.h"

@implementation audioEngine

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // Calls the function createSession to create the session
        
        [self createSession];
      
        // Calls the function createEngine to create the audio engine
        
        [self createEngine];
        
        // Calls the function attachNodes and attaches the nodes to the engine
        
        [self attachNodes];
        
        // Calls the function createConnections and creates the connections using the nodes
        
        [self createConnections];
        
        // Calls the function mixingDestination and creates the mix desternation objects
        
        [self mixingDestination];
        
        // Calls the function perpareAndStartEngine and prepares the engine then starts it
        
        [self perpareAndStartEngine];
        
        // Calls the function loadInstrumentDefaults and loads defaults for Instruments
        
        [self loadInstrumentDefaults];
        
        // Calls the function loadAudioUnitDefaults and loads defaults for audio units
        
        [self loadAudioUnitDefaults];
        
        NSLog(@"init Complete");
        
    }
    return self;
}

#pragma setup and initialise methods for init

-(void) createSession {
    
    NSError *error;
    
    // Starts audio session - app will not work without it
    
    self.audioSession = [AVAudioSession sharedInstance];
    [self.audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    
    // NSlog to show if audio session has errored
    
    if (error) {
        NSLog(@"Session failed to initialise %@",error);
    }
    
    NSLog(@"Session created");
    
}

-(void) createEngine {
    
    // Starts engine and creates all other objects that are required
    
    self.engine = [[AVAudioEngine alloc]init];
    
    self.audioUnitDelay = [[AVAudioUnitDelay alloc]init];
    self.audioUnitReverb = [[AVAudioUnitReverb alloc]init];
    self.audioUnitDistortion = [[AVAudioUnitDistortion alloc]init];
    self.busDelay = [[AVAudioMixerNode alloc]init];
    self.busReverb = [[AVAudioMixerNode alloc] init];
    self.busDistortion = [[AVAudioMixerNode alloc]init];
    self.busDirectOut = [[AVAudioMixerNode alloc]init];
    self.samplerDrums = [[AVAudioUnitSampler alloc]init];
    self.samplerInstrument1 = [[AVAudioUnitSampler alloc]init];
    self.samplerInstrument2 = [[AVAudioUnitSampler alloc]init];
    self.playerMicrophone = [[AVAudioPlayerNode alloc]init];
    self.playerMainOut = [[AVAudioPlayerNode alloc]init];
    self.playerInstument1 = [[AVAudioPlayerNode alloc]init];
    self.playerInstument2 = [[AVAudioPlayerNode alloc]init];
    self.playerDrums = [[AVAudioPlayerNode alloc]init];
    self.mainMixer = [self.engine mainMixerNode] ;
    self.audioFormat = [[AVAudioFormat alloc] initStandardFormatWithSampleRate:44100 channels:2];

    NSLog(@"Engine created");
    
}

-(void) attachNodes {
    
    //Attaches the nodes to the audio engine
    
    [self.engine attachNode:self.audioUnitDelay];
    [self.engine attachNode:self.audioUnitDistortion];
    [self.engine attachNode:self.audioUnitReverb];
    [self.engine attachNode:self.busDirectOut];
    [self.engine attachNode:self.busDistortion];
    [self.engine attachNode:self.busReverb];
    [self.engine attachNode:self.busDelay];
    [self.engine attachNode:self.samplerInstrument1];
    [self.engine attachNode:self.samplerInstrument2];
    [self.engine attachNode:self.samplerDrums];
    [self.engine attachNode:self.playerMicrophone];
    [self.engine attachNode:self.playerMainOut];
    [self.engine attachNode:self.playerInstument1];
    [self.engine attachNode:self.playerInstument2];
    [self.engine attachNode:self.playerDrums];
    
    NSLog(@"Nodes attached");
    
}

- (void) createConnections {
    
    // Create the essential connections
    
    // Uses arrays to create connection points. Theses are used to send the instumnet to multiple outputs. They are being sent the the effects busses.
    
    self.connectionBusSend1 = [NSArray arrayWithObjects:[[AVAudioConnectionPoint alloc] initWithNode:self.busDelay bus:1],[[AVAudioConnectionPoint alloc] initWithNode:self.busDistortion bus:1],[[AVAudioConnectionPoint alloc] initWithNode:self.busReverb bus:1],[[AVAudioConnectionPoint alloc] initWithNode:self.busDirectOut bus:1],nil ];
    
   //self.connectionBusSend1 = [NSArray arrayWithObjects:[[AVAudioConnectionPoint alloc] initWithNode:self.busReverb bus:1], nil ];
    self.connectionBusSend2 = [NSArray arrayWithObjects:[[AVAudioConnectionPoint alloc] initWithNode:self.busDelay bus:2],[[AVAudioConnectionPoint alloc] initWithNode:self.busDistortion bus:2],[[AVAudioConnectionPoint alloc] initWithNode:self.busReverb bus:2],[[AVAudioConnectionPoint alloc] initWithNode:self.busDirectOut bus:2],nil ];
    self.connectionBusSend3 = [NSArray arrayWithObjects:[[AVAudioConnectionPoint alloc] initWithNode:self.busDelay bus:3],[[AVAudioConnectionPoint alloc] initWithNode:self.busDistortion bus:3],[[AVAudioConnectionPoint alloc] initWithNode:self.busReverb bus:3],[[AVAudioConnectionPoint alloc] initWithNode:self.busDirectOut bus:3],nil ];
    self.connectionBusSend4 = [NSArray arrayWithObjects:[[AVAudioConnectionPoint alloc] initWithNode:self.busDelay bus:4],[[AVAudioConnectionPoint alloc] initWithNode:self.busDistortion bus:4],[[AVAudioConnectionPoint alloc] initWithNode:self.busReverb bus:4],[[AVAudioConnectionPoint alloc] initWithNode:self.busDirectOut bus:4],nil ];
    self.connectionBusSend5 = [NSArray arrayWithObjects:[[AVAudioConnectionPoint alloc] initWithNode:self.busDelay bus:5],[[AVAudioConnectionPoint alloc] initWithNode:self.busDistortion bus:5],[[AVAudioConnectionPoint alloc] initWithNode:self.busReverb bus:5],[[AVAudioConnectionPoint alloc] initWithNode:self.busDirectOut bus:5],nil ];
    self.connectionBusSend6 = [NSArray arrayWithObjects:[[AVAudioConnectionPoint alloc] initWithNode:self.busDelay bus:6],[[AVAudioConnectionPoint alloc] initWithNode:self.busDistortion bus:6],[[AVAudioConnectionPoint alloc] initWithNode:self.busReverb bus:6],[[AVAudioConnectionPoint alloc] initWithNode:self.busDirectOut bus:6],nil ];
    self.connectionBusSend7 = [NSArray arrayWithObjects:[[AVAudioConnectionPoint alloc] initWithNode:self.busDelay bus:7],[[AVAudioConnectionPoint alloc] initWithNode:self.busDistortion bus:7],[[AVAudioConnectionPoint alloc] initWithNode:self.busReverb bus:7],[[AVAudioConnectionPoint alloc] initWithNode:self.busDirectOut bus:7],nil ];

    // Connect the instumnets to the connecton points that have been created in the array
    
    [self.engine connect:self.samplerInstrument1 toConnectionPoints:self.connectionBusSend1 fromBus:0 format:self.audioFormat];
    [self.engine connect:self.samplerInstrument2 toConnectionPoints:self.connectionBusSend2 fromBus:0 format:self.audioFormat];
    [self.engine connect:self.samplerDrums toConnectionPoints:self.connectionBusSend3 fromBus:0 format:self.audioFormat];
    [self.engine connect:self.playerMicrophone toConnectionPoints:self.connectionBusSend4 fromBus:0 format:self.audioFormat];
    [self.engine connect:self.playerInstument1 toConnectionPoints:self.connectionBusSend5 fromBus:0 format:self.audioFormat];
    [self.engine connect:self.playerInstument2 toConnectionPoints:self.connectionBusSend6 fromBus:0 format:self.audioFormat];
    [self.engine connect:self.playerDrums toConnectionPoints:self.connectionBusSend7 fromBus:0 format:self.audioFormat];
    
    // Connect busses to audio units
    
    [self.engine connect:self.busReverb to:self.audioUnitReverb format:self.audioFormat];
    [self.engine connect:self.busDistortion to:self.audioUnitDistortion format:self.audioFormat];
    [self.engine connect:self.busDelay to:self.audioUnitDelay format:self.audioFormat];
    
    // Connect audio units to main out
    
    [self.engine connect:self.audioUnitReverb to:self.mainMixer format:self.audioFormat];
    [self.engine connect:self.audioUnitDistortion to:self.mainMixer format:self.audioFormat];
    [self.engine connect:self.audioUnitDelay to:self.mainMixer format:self.audioFormat];
    [self.engine connect:self.busDirectOut to:self.mainMixer format:self.audioFormat];
    [self.engine connect:self.playerMainOut to:self.mainMixer format:self.audioFormat];

    
    NSLog(@"Connections created");
    
}

-(void) perpareAndStartEngine {
    
    // Starts and prepares the audio engine for playback
    
    NSError *error;
    
    [self.engine prepare];
    [self.engine startAndReturnError:&error];
    
    if (error) {
        NSLog(@"Engine failed to start %@",error);
    }
    
    NSLog(@"Engine started");
}

-(void) mixingDestination {
    
    // Allows control of the how much is sent to a bus from the input
    
    self.sendReverbInstrument1 = [self.samplerInstrument1 destinationForMixer:self.busReverb bus:1];
    self.sendDelayInstrument1 = [self.samplerInstrument1 destinationForMixer:self.busDelay bus:1];
    self.sendDistortionInstrument1 = [self.samplerInstrument1 destinationForMixer:self.busDistortion bus:1];
    self.sendDirectOutInstrument1 = [self.samplerInstrument1 destinationForMixer:self.busDirectOut bus:1];
    
    self.sendReverbPlayerInstrument1 = [self.playerInstument1 destinationForMixer:self.busReverb bus:5];
    self.sendDelayPlayerInstrument1 = [self.playerInstument1 destinationForMixer:self.busDelay bus:5];
    self.sendDistortionPlayerInstrument1 = [self.playerInstument1 destinationForMixer:self.busDistortion bus:5];
    self.sendDirectOutPlayerInstrument1 = [self.playerInstument1 destinationForMixer:self.busDirectOut bus:5];
    
    self.sendReverbInstrument2 = [self.samplerInstrument2 destinationForMixer:self.busReverb bus:2];
    self.sendDelayInstrument2 = [self.samplerInstrument2 destinationForMixer:self.busDelay bus:2];
    self.sendDistortionInstrument2 = [self.samplerInstrument2 destinationForMixer:self.busDistortion bus:2];
    self.sendDirectOutInstrument2 = [self.samplerInstrument2 destinationForMixer:self.busDirectOut bus:2];
    
    self.sendReverbPlayerInstrument2 = [self.playerInstument2 destinationForMixer:self.busReverb bus:6];
    self.sendDelayPlayerInstrument2 = [self.playerInstument2 destinationForMixer:self.busDelay bus:6];
    self.sendDistortionPlayerInstrument2 = [self.playerInstument2 destinationForMixer:self.busDistortion bus:6];
    self.sendDirectOutPlayerInstrument2 = [self.playerInstument2 destinationForMixer:self.busDirectOut bus:6];
    
    self.sendReverbDrums = [self.samplerDrums destinationForMixer:self.busReverb bus:3];
    self.sendDelayDrums = [self.samplerDrums destinationForMixer:self.busDelay bus:3];
    self.sendDistortionDrums = [self.samplerDrums destinationForMixer:self.busDistortion bus:3];
    self.sendDirectOutDrums = [self.samplerDrums destinationForMixer:self.busDirectOut bus:3];
    
    self.sendReverbPlayerDrums = [self.playerDrums destinationForMixer:self.busReverb bus:7];
    self.sendDelayPlayerDrums = [self.playerDrums destinationForMixer:self.busDelay bus:7];
    self.sendDistortionPlayerDrums = [self.playerDrums destinationForMixer:self.busDistortion bus:7];
    self.sendDirectOutPlayerDrums = [self.playerDrums destinationForMixer:self.busDirectOut bus:7];
    
    self.sendReverbMicrophone = [self.playerMicrophone destinationForMixer:self.busReverb bus:4];
    self.sendDelayMicrophone = [self.playerMicrophone destinationForMixer:self.busDelay bus:4];
    self.sendDistortionMicrophone = [self.playerMicrophone destinationForMixer:self.busDistortion bus:4];
    self.sendDirectOutMicrophone = [self.playerMicrophone destinationForMixer:self.busDirectOut bus:4];
    
}

-(void) loadInstrumentDefaults {
    
    NSError *error;
    
    self.samplerInstrument1URL  = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Chaos Bank V1.9 (12Mb)" ofType:@"sf2"]];
    
    [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:83 bankMSB:0x79 bankLSB:0 error:&error];
    
    if (error) {
        NSLog(@"Instrument 1 failed to load samples %@",error);
    }
    
    //self.samplerInstrument2URL  = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"" ofType:@""]];
    
    [self.samplerInstrument2 loadInstrumentAtURL:self.samplerInstrument2URL error:&error];
    
    if (error) {
        NSLog(@"Instrument 2 failed to load samples %@",error);
    }
    
    //self.samplerIDrumsURL  = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"" ofType:@""]];
    
    [self.samplerDrums loadInstrumentAtURL:self.samplerIDrumsURL error:&error];
    
    if (error) {
        NSLog(@"Drums failed to load samples %@",error);
    }
    
}

-(void) loadAudioUnitDefaults {
    
    [self.audioUnitReverb loadFactoryPreset:AVAudioUnitReverbPresetLargeHall2];
    [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetSpeechAlienChatter];
    self.audioUnitDistortion.wetDryMix = 0;
    self.audioUnitDelay.delayTime = 0;
    self.audioUnitDelay.wetDryMix = 0;
    self.audioUnitReverb.wetDryMix =0;
    
}


#pragma methods for instument playback

-(void) playInstrument1:(int)note {
    
    // Plays the note in the correct octave
    
    if (self.octave<=0){
        
        self.octave=0;
        
        [self.samplerInstrument1 startNote:(note-48) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note = %i",note-48);
        
    } else if (self.octave==1){
        
         self.octave=1;
        
        [self.samplerInstrument1 startNote:(note-36) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note = %i",note-36);
        
    } else if (self.octave==2){
        
         self.octave=2;
        
        [self.samplerInstrument1 startNote:(note-24) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note = %i",note-24);
        
    } else if (self.octave==3){
        
        self.octave=3;
        
        [self.samplerInstrument1 startNote:(note-12) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note = %i",note-12);
        
    } else if (self.octave==4){
        
        self.octave=4;
        
        [self.samplerInstrument1 startNote:(note) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note = %i",note);
        
    } else if (self.octave==5){
        
        self.octave=5;
        
        [self.samplerInstrument1 startNote:(note+12) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note = %i",note+12);
        
    } else if (self.octave>=6){
        
        self.octave=6;
        
        [self.samplerInstrument1 startNote:(note+24) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note = %i",note+24);
        
    }
    
}

-(void) stopInstrument1:(int)note {
    
    // Stops the note in the right octave
    
    if (self.octave<=0){
        
        self.octave=0;
        
        [self.samplerInstrument1 stopNote:(note-48) onChannel:0];
        
        NSLog(@"Stop note = %i",note-48);
        
    } else if (self.octave==1){
        
        self.octave=1;
        
        [self.samplerInstrument1 stopNote:(note-36) onChannel:0];
        
        NSLog(@"Stop note = %i",note-36);
        
    } else if (self.octave==2){
        
        self.octave=2;
        
        [self.samplerInstrument1 stopNote:(note-24) onChannel:0];
        
        NSLog(@"Stop note = %i",note-24);
        
    } else if (self.octave==3){
        
        self.octave=3;
        
        [self.samplerInstrument1 stopNote:(note-12) onChannel:0];
        
        NSLog(@"Stop note = %i",note-12);
        
    } else if (self.octave==4){
        
        self.octave=4;
        
        [self.samplerInstrument1 stopNote:note onChannel:0];
        
        NSLog(@"Stop note = %i",note);
        
    } else if (self.octave==5){
        
        self.octave=5;
        
        [self.samplerInstrument1 stopNote:(note+12) onChannel:0];
        
        NSLog(@"Stop note = %i",note+12);
        
    } else if (self.octave>=6){
        
        self.octave=6;
        
        [self.samplerInstrument1 stopNote:(note+24) onChannel:0];
        
        NSLog(@"Stop note = %i",note+24);
        
    }

}

-(void) panInstrument1: (float) pan{
    
    self.samplerInstrument1.pan = pan;
    
}

#pragma methods for audio units

-(void) sendsForReverb: (float)reverbInstrument1 : (float)reverbInstrument2 : (float)reverbDrums : (float)reverbMicrohpone  {
    
    self.sendReverbInstrument1.volume = reverbInstrument1;
    self.sendReverbPlayerInstrument1.volume = reverbInstrument1;
    self.sendReverbInstrument2.volume = reverbInstrument2;
    self.sendReverbDrums.volume = reverbDrums;
    self.sendReverbMicrophone.volume = reverbMicrohpone;
    
}

-(void) audioUnitReverbWetDry: (float) wetDry{
    
    self.audioUnitReverb.wetDryMix = wetDry;
}

-(void) changeReverb: (NSInteger) selectedReverb {
    
    if (selectedReverb == 0){
        
        [self.audioUnitReverb loadFactoryPreset:AVAudioUnitReverbPresetSmallRoom];
        
    } else if (selectedReverb == 1) {
        
        [self.audioUnitReverb loadFactoryPreset:AVAudioUnitReverbPresetMediumRoom];
        
    } else if (selectedReverb == 2) {
        
        [self.audioUnitReverb loadFactoryPreset:AVAudioUnitReverbPresetLargeRoom];
        
    }  else if (selectedReverb == 3) {
        
        [self.audioUnitReverb loadFactoryPreset:AVAudioUnitReverbPresetLargeRoom2];
        
    } else if (selectedReverb == 4) {
        
        [self.audioUnitReverb loadFactoryPreset:AVAudioUnitReverbPresetMediumHall];
        
    } else if (selectedReverb == 5) {
        
        [self.audioUnitReverb loadFactoryPreset:AVAudioUnitReverbPresetMediumHall2];
        
    } else if (selectedReverb == 6) {
        
        [self.audioUnitReverb loadFactoryPreset:AVAudioUnitReverbPresetMediumHall3];
        
    } else if (selectedReverb == 7) {
        
        [self.audioUnitReverb loadFactoryPreset:AVAudioUnitReverbPresetLargeHall];
        
    } else if (selectedReverb == 8) {
        
        [self.audioUnitReverb loadFactoryPreset:AVAudioUnitReverbPresetLargeHall2];
        
    } else if (selectedReverb == 9) {
        
        [self.audioUnitReverb loadFactoryPreset:AVAudioUnitReverbPresetMediumChamber];
        
    } else if (selectedReverb == 10) {
        
        [self.audioUnitReverb loadFactoryPreset:AVAudioUnitReverbPresetLargeChamber];
        
    } else if (selectedReverb == 11) {
        
        [self.audioUnitReverb loadFactoryPreset:AVAudioUnitReverbPresetPlate];
        
    } else if (selectedReverb == 12) {
        
        [self.audioUnitReverb loadFactoryPreset:AVAudioUnitReverbPresetCathedral];
    }
    
}

-(void) sendsForDelay:(float)delayInstrument1 :(float)delayInstrument2 :(float)delayDrums :(float)delayMicrohpone {
    
    self.sendDelayInstrument1.volume = delayInstrument1;
    self.sendDelayPlayerInstrument1.volume = delayInstrument1;
    self.sendDelayInstrument2.volume = delayInstrument2;
    self.sendDelayDrums.volume = delayDrums;
    self.sendDelayMicrophone.volume = delayMicrohpone;
    
}

-(void) audioUnitDelayWetDry:(float)wetDry {
    
    self.audioUnitDelay.wetDryMix = wetDry;
    
}

-(void) audioUnitDelayTime:(float)delayTime {
    
    self.audioUnitDelay.delayTime = delayTime;
    
}

-(void) audioUnitDelayFeedback:(float)feedback {
    
    self.audioUnitDelay.feedback = feedback;
    
}

-(void) audioUnitDelayLowPassCutoff:(float)cutoff {

    self.audioUnitDelay.lowPassCutoff = cutoff;
    
}

-(void) sendsForDistortion:(float)distortionInstrument1 :(float)distortionInstrument2 :(float)distortionDrums :(float)distortionMicrohpone {
    
    self.sendDistortionInstrument1.volume = distortionInstrument1;
    self.sendDistortionPlayerInstrument1.volume = distortionInstrument1;
    self.sendDistortionInstrument2.volume = distortionInstrument2;
    self.sendDistortionDrums.volume = distortionDrums;
    self.sendDistortionMicrophone.volume = distortionMicrohpone;
    
}

-(void) audioUnitDistortionWetDry:(float)wetDry {
    
    self.audioUnitDistortion.wetDryMix = wetDry;
    
}

-(void) audioUnitDistortionPreGain:(float)preGain {
    
    self.audioUnitDistortion.preGain = preGain;
    
}

-(void) changeDistortion:(NSInteger)selectedDistortion {
    
    if (selectedDistortion == 0){
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetDrumsBitBrush];
        
    } else if (selectedDistortion == 1) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetDrumsBufferBeats];
        
    } else if (selectedDistortion == 2) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetDrumsLoFi];
        
    } else if (selectedDistortion == 3) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetMultiBrokenSpeaker];
        
    } else if (selectedDistortion == 4) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetMultiCellphoneConcert];
        
    } else if (selectedDistortion == 5) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetMultiDecimated1];
        
    } else if (selectedDistortion == 6) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetMultiDecimated2];
        
    } else if (selectedDistortion == 7) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetMultiDecimated3];
        
    } else if (selectedDistortion == 8) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetMultiDecimated4];
        
    } else if (selectedDistortion == 9) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetMultiDistortedFunk];
        
    } else if (selectedDistortion == 10) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetMultiDistortedCubed];
        
    } else if (selectedDistortion == 11) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetMultiDistortedSquared];
        
    } else if (selectedDistortion == 12) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetMultiEcho1];
        
    } else if (selectedDistortion == 13) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetMultiEcho2];
        
    } else if (selectedDistortion == 14) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetMultiEchoTight1];
        
    } else if (selectedDistortion == 15) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetMultiEchoTight2];
        
    } else if (selectedDistortion == 16) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetMultiEverythingIsBroken];
        
    } else if (selectedDistortion == 17) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetSpeechAlienChatter];
        
    } else if (selectedDistortion == 18) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetSpeechCosmicInterference];
        
    } else if (selectedDistortion == 19) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetSpeechGoldenPi];
        
    } else if (selectedDistortion == 20) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetSpeechRadioTower];
        
    } else if (selectedDistortion == 21) {
        
        [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetSpeechWaves];
        
    }
    
}

-(void) sendsForDirectOut:(float)directInstrument1 :(float)directInstrument2 :(float)directDrums :(float)directMicrohpone{
    
    self.sendDirectOutInstrument1.volume = directInstrument1;
    self.sendDirectOutPlayerInstrument1.volume = directInstrument1;
    self.sendDirectOutInstrument2.volume = directInstrument2;
    self.sendDirectOutDrums.volume = directDrums;
    self.sendDirectOutMicrophone.volume = directMicrohpone;
    
}


-(void) changeInstrument1:(NSInteger)selectedInstument1 {
    
    NSError *error;
    
    if (selectedInstument1 == 0){
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:0 bankMSB:0x79 bankLSB:0 error:&error];
        
    } else if (selectedInstument1 == 1) {
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:1 bankMSB:0x79 bankLSB:0 error:&error];
        
    } else if (selectedInstument1 == 2) {
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:11 bankMSB:0x79 bankLSB:0 error:&error];
        
    } else if (selectedInstument1 == 3) {
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:19 bankMSB:0x79 bankLSB:0 error:&error];
        
    } else if (selectedInstument1 == 4) {
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:40 bankMSB:0x79 bankLSB:0 error:&error];
        
    } else if (selectedInstument1 == 5) {
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:41 bankMSB:0x79 bankLSB:0 error:&error];
        
    } else if (selectedInstument1 == 6) {
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:52 bankMSB:0x79 bankLSB:0 error:&error];
        
    } else if (selectedInstument1 == 7) {
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:79 bankMSB:0x79 bankLSB:0 error:&error];
        
    } else if (selectedInstument1 == 8) {
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:83 bankMSB:0x79 bankLSB:0 error:&error];
        
    } else if (selectedInstument1 == 9) {
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:86 bankMSB:0x79 bankLSB:0 error:&error];
        
    }
    
    
}


-(void) startPlayingInstument1 {
    
    NSError *error;
    
    if (self.isRecordingInstument1 == YES){
        
        [self stopRecordingInstument1];
        
    }
    
    self.outputFileInstument1URL = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:@"instument1Output.caf"]];
    
    self.outputFileInstument1 = [[AVAudioFile alloc] initForReading:self.outputFileInstument1URL error:&error];
    
    if (error){
        NSLog(@"outputFileInstument1 file player error %@",error);
    }
    
    AVAudioPCMBuffer *bufferInstument1 = [[AVAudioPCMBuffer alloc] initWithPCMFormat:self.outputFileInstument1.processingFormat frameCapacity:(AVAudioFrameCount)self.outputFileInstument1.length];
    
    if (error){
        NSLog(@"outputFileInstument1 buffer player error %@",error);
    }
    
    if (self.isLoop == true){
        
        [self.playerInstument1 scheduleBuffer:bufferInstument1 atTime:nil options:AVAudioPlayerNodeBufferLoops completionHandler:nil];
        
    } else {
        
        [self.playerInstument1 scheduleBuffer:bufferInstument1 completionHandler:nil];
    }
    
    [self.outputFileInstument1 readIntoBuffer:bufferInstument1 error:&error];
    
    if (self.playerInstument1.isPlaying == false) {
        
        [self.playerInstument1 play];
        
        NSLog(@"Playing Instrument1 player");
        
    } else {
        
        [self.playerInstument1 stop];
        
        NSLog(@"Stopping Instrument1 player");
        
    }
}


-(void) startRecordingInstument1
{
    NSError *error;
    self.outputFileInstument1URL = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:@"instument1Output.caf"]];
    
    self.outputFileInstument1 = [[AVAudioFile alloc] initForWriting:self.outputFileInstument1URL settings:[[self.samplerInstrument1 outputFormatForBus:0] settings] error:&error];
    
    if (error){
        NSLog(@"outputFileInstument1 file recording error %@",error);
    }
    
    [self.samplerInstrument1 installTapOnBus:0 bufferSize:4096 format:[self.samplerInstrument1 outputFormatForBus:0] block:^(AVAudioPCMBuffer *buffer, AVAudioTime *when) {
        
        NSError *error;
        
        [self.outputFileInstument1 writeFromBuffer:buffer error:&error];
        
        if (error){
            NSLog(@"outputFileInstument1 buffer recording error %@",error);
        }

        
    }];
    self.isRecordingInstument1 = YES;
    
    NSLog(@"Recording started on Instrument1");
}

-(void) stopRecordingInstument1
{
    if (self.isRecordingInstument1) {
        [self.samplerInstrument1 removeTapOnBus:0];
        self.isRecordingInstument1 = NO;
        
        NSLog(@"Recording stopped on Instrument1");
    }
}

-(void) startPlayingMainOut {
    
    NSError *error;
    
    if (self.isRecordingMainOut == YES){
        
        [self stopRecordingMainOut];
        
    }
    
    self.outputFileMainOutURL = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:@"mainoutOutput.caf"]];
    
    self.outputFileMainOut = [[AVAudioFile alloc] initForReading:self.outputFileMainOutURL error:&error];
    
    if (error){
        NSLog(@"outputFileMainOut file player error %@",error);
    }
    
    AVAudioPCMBuffer *bufferMainOut= [[AVAudioPCMBuffer alloc] initWithPCMFormat:self.outputFileMainOut.processingFormat frameCapacity:(AVAudioFrameCount)self.outputFileMainOut.length];
    
    if (error){
        NSLog(@"outputFileMainOut buffer player error %@",error);
    }
    
    [self.outputFileMainOut readIntoBuffer:bufferMainOut error:&error];
    
    [self.playerMainOut scheduleBuffer:bufferMainOut completionHandler:nil];
    
    if (self.playerMainOut.isPlaying == false) {
        
        [self.playerMainOut play];
        
        NSLog(@"Playing main out player");
        
    } else {
        
        [self.playerMainOut stop];
        
        NSLog(@"Stopping main out player");
        
    }
    
    
    
}


-(void) startRecordingMainOut
{
    NSError *error;
    self.outputFileMainOutURL = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:@"mainoutOutput.caf"]];
    
    self.outputFileMainOut = [[AVAudioFile alloc] initForWriting:self.outputFileMainOutURL settings:[[self.mainMixer outputFormatForBus:0] settings] error:&error];
    
    if (error){
        NSLog(@"outputFileMainOut file recording error %@",error);
    }
    
    [self.mainMixer installTapOnBus:0 bufferSize:4096 format:[self.mainMixer outputFormatForBus:0] block:^(AVAudioPCMBuffer *buffer, AVAudioTime *when) {
        
        NSError *error;
        
        [self.outputFileMainOut writeFromBuffer:buffer error:&error];
        
        if (error){
            NSLog(@"outputFileMainOut buffer recording error %@",error);
            [self stopRecordingMainOut];
            self.isRecordingMainOut = NO;
        }
        
    }];
    
    self.isRecordingMainOut = YES;
    
    NSLog(@"Recording started on main out ");
}

-(void) stopRecordingMainOut
{
    if (self.isRecordingMainOut) {
        [self.mainMixer removeTapOnBus:0];
        self.isRecordingMainOut = NO;
        
        NSLog(@"Recording stopped on main out");
        
    }
}


@end
