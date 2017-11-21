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
    self.player = [[AVAudioPlayerNode alloc]init];
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
    [self.engine attachNode:self.player];
    
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

    // Connect the instumnets to the connecton points that have been created in the array
    
    [self.engine connect:self.samplerInstrument1 toConnectionPoints:self.connectionBusSend1 fromBus:0 format:self.audioFormat];
    [self.engine connect:self.samplerInstrument2 toConnectionPoints:self.connectionBusSend2 fromBus:0 format:self.audioFormat];
    [self.engine connect:self.samplerDrums toConnectionPoints:self.connectionBusSend3 fromBus:0 format:self.audioFormat];
    [self.engine connect:self.player toConnectionPoints:self.connectionBusSend4 fromBus:0 format:self.audioFormat];
    
    // Connect busses to audio units
    
    [self.engine connect:self.busReverb to:self.audioUnitReverb format:self.audioFormat];
    [self.engine connect:self.busDistortion to:self.audioUnitDistortion format:self.audioFormat];
    [self.engine connect:self.busDelay to:self.audioUnitDelay format:self.audioFormat];
    
    // Connect audio units to main out
    
    [self.engine connect:self.audioUnitReverb to:self.mainMixer format:self.audioFormat];
    [self.engine connect:self.audioUnitDistortion to:self.mainMixer format:self.audioFormat];
    [self.engine connect:self.audioUnitDelay to:self.mainMixer format:self.audioFormat];
    [self.engine connect:self.busDirectOut to:self.mainMixer format:self.audioFormat];

    
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
    
    self.sendReverbInstrument2 = [self.samplerInstrument2 destinationForMixer:self.busReverb bus:2];
    self.sendDelayInstrument2 = [self.samplerInstrument2 destinationForMixer:self.busDelay bus:2];
    self.sendDistortionInstrument2 = [self.samplerInstrument2 destinationForMixer:self.busDistortion bus:2];
    self.sendDirectOutInstrument2 = [self.samplerInstrument2 destinationForMixer:self.busDirectOut bus:2];
    
    self.sendReverbDrums = [self.samplerDrums destinationForMixer:self.busReverb bus:3];
    self.sendDelayDrums = [self.samplerDrums destinationForMixer:self.busDelay bus:3];
    self.sendDistortionDrums = [self.samplerDrums destinationForMixer:self.busDistortion bus:3];
    self.sendDirectOutDrums = [self.samplerDrums destinationForMixer:self.busDirectOut bus:3];
    
    self.sendReverbMicrophone = [self.player destinationForMixer:self.busReverb bus:4];
    self.sendDelayMicrophone = [self.player destinationForMixer:self.busDelay bus:4];
    self.sendDistortionMicrophone = [self.player destinationForMixer:self.busDistortion bus:4];
    self.sendDirectOutMicrophone = [self.player destinationForMixer:self.busDirectOut bus:4];
    
}

-(void) loadInstrumentDefaults {
    
    NSError *error;
    
    self.samplerInstrument1URL  = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Nice-Keys-Ultimate-V2.3" ofType:@"sf2"]];
    
    [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:1 bankMSB:0x79 bankLSB:0 error:&error];
    
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
        
    } else if (self.octave==1){
        
         self.octave=1;
        
        [self.samplerInstrument1 startNote:(note-36) withVelocity:127 onChannel:0];
        
    } else if (self.octave==2){
        
         self.octave=2;
        
        [self.samplerInstrument1 startNote:(note-24) withVelocity:127 onChannel:0];
        
    } else if (self.octave==3){
        
        self.octave=3;
        
        [self.samplerInstrument1 startNote:(note-12) withVelocity:127 onChannel:0];
        
    } else if (self.octave==4){
        
        self.octave=4;
        
        [self.samplerInstrument1 startNote:(note) withVelocity:127 onChannel:0];
        
    } else if (self.octave==5){
        
        self.octave=5;
        
        [self.samplerInstrument1 startNote:(note+12) withVelocity:127 onChannel:0];
        
    } else if (self.octave==6){
        
        self.octave=6;
        
        [self.samplerInstrument1 startNote:(note+24) withVelocity:127 onChannel:0];
        
    } else if (self.octave>=7){
        
        self.octave=7;
        
        [self.samplerInstrument1 startNote:(note+36) withVelocity:127 onChannel:0];
        
    }
    
}

-(void) stopInstrument1:(int)note {
    
    // Stops the note in the right octave
    
    if (self.octave<=0){
        
        self.octave=0;
        
        [self.samplerInstrument1 stopNote:(note-48) onChannel:0];
        
        NSLog(@"Note = %i",note);
        
    } else if (self.octave==1){
        
        self.octave=1;
        
        [self.samplerInstrument1 stopNote:(note-36) onChannel:0];
        
        NSLog(@"Note = %i",note);
        
    } else if (self.octave==2){
        
        self.octave=2;
        
        [self.samplerInstrument1 stopNote:(note-24) onChannel:0];
        
        NSLog(@"Note = %i",note);
        
    } else if (self.octave==3){
        
        self.octave=3;
        
        [self.samplerInstrument1 stopNote:(note-12) onChannel:0];
        
        NSLog(@"Note = %i",note);
        
    } else if (self.octave==4){
        
        self.octave=4;
        
        [self.samplerInstrument1 stopNote:note onChannel:0];
        
        NSLog(@"Note = %i",note);
        
    } else if (self.octave==5){
        
        self.octave=5;
        
        [self.samplerInstrument1 stopNote:(note+12) onChannel:0];
        
        NSLog(@"Note = %i",note);
        
    } else if (self.octave==6){
        
        self.octave=6;
        
        [self.samplerInstrument1 stopNote:(note+24) onChannel:0];
        
        NSLog(@"Note = %i",note);
        
    } else if (self.octave>=7){
        
        self.octave=7;
        
        [self.samplerInstrument1 stopNote:(note+36) onChannel:0];
        
        NSLog(@"Note = %i",note);
        
    }
    
    

}

#pragma methods for audio units

-(void) sendsForReverb: (float)reverbInstrument1 : (float)reverbInstrument2 : (float)reverbDrums : (float)reverbMicrohpone  {
    
    self.sendReverbInstrument1.volume = reverbInstrument1;
    self.sendReverbInstrument2.volume = reverbInstrument2;
    self.sendReverbDrums.volume = reverbDrums;
    self.sendReverbMicrophone.volume = reverbMicrohpone;
    
}

-(void) audioUnitReverbWetDry: (float) wetDry{
    
    self.audioUnitReverb.wetDryMix = wetDry;
}


-(void) sendsForDelay:(float)delayInstrument1 :(float)delayInstrument2 :(float)delayDrums :(float)delayMicrohpone {
    
    self.sendDelayInstrument1.volume = delayInstrument1;
    self.sendDelayInstrument2.volume = delayInstrument2;
    self.sendDelayDrums.volume = delayDrums;
    self.sendDelayMicrophone.volume = delayMicrohpone;
    
}

-(void) sendsForDistortion:(float)distortionInstrument1 :(float)distortionInstrument2 :(float)distortionDrums :(float)distortionMicrohpone {
    
    self.sendDistortionInstrument1.volume = distortionInstrument1;
    self.sendDistortionInstrument2.volume = distortionInstrument2;
    self.sendDistortionDrums.volume = distortionDrums;
    self.sendDistortionMicrophone.volume = distortionMicrohpone;
    
}

-(void) sendsForDirectOut:(float)directInstrument1 :(float)directInstrument2 :(float)directDrums :(float)directMicrohpone{
    
    self.sendDirectOutInstrument1.volume = directInstrument1;
    self.sendDirectOutInstrument2.volume = directInstrument2;
    self.sendDirectOutDrums.volume = directDrums;
    self.sendDirectOutMicrophone.volume = directMicrohpone;
    
}




@end
