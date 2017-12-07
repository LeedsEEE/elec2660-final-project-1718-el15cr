//
//  audioEngine.m
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 17/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

// References
//
// https://developer.apple.com/documentation/avfoundation/avaudiosession?language=objc
// https://developer.apple.com/documentation/avfoundation/avaudioengine?language=objc
// https://developer.apple.com/documentation/avfoundation/avaudionode/1387122-installtaponbus
// https://developer.apple.com/documentation/avfoundation/avaudioplayernode?language=objc
// https://developer.apple.com/documentation/avfoundation/avaudiounitsampler?language=objc
// https://developer.apple.com/documentation/avfoundation/avaudiounit?language=objc
// https://developer.apple.com/documentation/avfoundation/avaudiomixing?language=objc
// https://developer.apple.com/documentation/avfoundation/avaudiomixernode?language=objc
// https://developer.apple.com/documentation/avfoundation/avaudiobuffer?language=objc
// https://developer.apple.com/documentation/avfoundation/avaudiofile?language=objc
// https://developer.apple.com/documentation/avfoundation/avaudioformat?language=objc
// https://developer.apple.com/documentation/avfoundation/avaudioinputnode?language=objc
// https://developer.apple.com/documentation/avfoundation/avaudiounitdelay?language=objc
// https://developer.apple.com/documentation/avfoundation/avaudiounitreverb?language=objc
// https://developer.apple.com/documentation/avfoundation/avaudiounittimepitch?language=objc
// https://developer.apple.com/documentation/avfoundation/avaudiounitdistortion?language=objc
// https://developer.apple.com/documentation/foundation/1409211-nstemporarydirectory?language=objc
// https://www.slideshare.net/bobmccune/building-modern-audio-apps-with-avaudioengine
// https://blog.metova.com/audio-manipulation-using-avaudioengine
// http://nshipster.com/nstemporarydirectory/

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

#pragma mark setup and initialise methods for init

-(void) createSession {
    
    NSError *error;
    
    // Starts audio session - app will not work without it
    
    self.audioSession = [AVAudioSession sharedInstance];
    [self.audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    
    // NSlog to show if audio session has errored
    
    if (error) {
        NSLog(@"Session failed to initialise %@",error);
    }

    // Requests the users permission to use the Microphone
    // Permission is always granted in the simulator

    [self.audioSession requestRecordPermission:^(BOOL granted){
        
        if (granted){
            
            NSLog(@"Permission granted");
            
        } else {
            
            NSLog(@"Permission declined");
            
        }
        
        
    }];
 
    
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
    self.playerMetronome = [[AVAudioPlayerNode alloc]init];
    self.mainMixer = [self.engine mainMixerNode];
    self.audioUnitTimePitch = [[AVAudioUnitTimePitch alloc]init];
    self.inputMicrophone = [self.engine inputNode];
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
    [self.engine attachNode:self.audioUnitTimePitch];
    [self.engine attachNode:self.playerMetronome];
    
    NSLog(@"Nodes attached");
    
}

- (void) createConnections {
    
    // Create the essential connections
    
    // Uses arrays to create connection points. Theses are used to send the instumnet to multiple outputs. They are being sent the the effects busses.
    
    self.connectionBusSend1 = [NSArray arrayWithObjects:[[AVAudioConnectionPoint alloc] initWithNode:self.busDelay bus:1],[[AVAudioConnectionPoint alloc] initWithNode:self.busDistortion bus:1],[[AVAudioConnectionPoint alloc] initWithNode:self.busReverb bus:1],[[AVAudioConnectionPoint alloc] initWithNode:self.busDirectOut bus:1],nil ];
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
    [self.engine connect:self.playerMicrophone to:self.audioUnitTimePitch format:self.audioFormat];
    [self.engine connect:self.audioUnitTimePitch toConnectionPoints:self.connectionBusSend4 fromBus:0 format:self.audioFormat];
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
    [self.engine connect:self.playerMetronome to:self.mainMixer format:self.audioFormat];

    
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
    
    // Loads the initialised defaults for the sampler units
    
    NSError *error;
    
    self.samplerInstrument1URL  = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Chaos Bank V1.9 (12Mb)" ofType:@"sf2"]];
    
    [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:0 bankMSB:0x79 bankLSB:0 error:&error];
    
    if (error) {
        NSLog(@"Instrument 1 failed to load samples %@",error);
    } else {
        
        NSLog(@"Instrument 1 loaded");
        
    }
    
    self.samplerInstrument2URL  = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Chaos Bank V1.9 (12Mb)" ofType:@"sf2"]];
    
    [self.samplerInstrument2 loadSoundBankInstrumentAtURL:self.samplerInstrument2URL program:33 bankMSB:0x79 bankLSB:0 error:&error];
    
    if (error) {
        NSLog(@"Instrument 2 failed to load samples %@",error);
    } else {
        
        NSLog(@"Instrument 2 loaded");
        
    }
    
    self.samplerIDrumsURL  = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Angular TR-808" ofType:@"sf2"]];
    
    [self.samplerDrums loadSoundBankInstrumentAtURL:self.samplerIDrumsURL program:0 bankMSB:0x79 bankLSB:0 error:&error];
    
    if (error) {
        
        NSLog(@"Drums failed to load samples %@",error);
        
    }  else {
                
        NSLog(@"Drums loaded");
        
    }

    
}

-(void) loadAudioUnitDefaults {
    
    // Loads the initialised defaults for the audio units
    
    [self.audioUnitReverb loadFactoryPreset:AVAudioUnitReverbPresetSmallRoom];
    [self.audioUnitDistortion loadFactoryPreset:AVAudioUnitDistortionPresetDrumsBitBrush];
    
    self.audioUnitDistortion.wetDryMix = 100;
    self.audioUnitDistortion.preGain = 0;
    
    self.audioUnitDelay.wetDryMix = 100;
    self.audioUnitDelay.delayTime = 0;
    self.audioUnitDelay.lowPassCutoff = 100;
    self.audioUnitDelay.feedback = 20;
    
    self.audioUnitReverb.wetDryMix = 100;
    
    self.sendReverbInstrument1.volume = 0;
    self.sendReverbPlayerInstrument1.volume = 0;
    self.sendReverbInstrument2.volume = 0;
    self.sendReverbPlayerInstrument2.volume = 0;
    self.sendReverbDrums.volume = 0;
    self.sendReverbPlayerDrums.volume = 0;
    self.sendReverbMicrophone.volume = 0;
    
    self.sendDelayInstrument1.volume = 0;
    self.sendDelayPlayerInstrument1.volume = 0;
    self.sendDelayInstrument2.volume = 0;
    self.sendDelayPlayerInstrument2.volume = 0;
    self.sendDelayDrums.volume = 0;
    self.sendDelayPlayerDrums.volume = 0;
    self.sendDelayMicrophone.volume = 0;
    
    self.sendDistortionInstrument1.volume = 0;
    self.sendDistortionPlayerInstrument1.volume = 0;
    self.sendDistortionInstrument2.volume = 0;
    self.sendDistortionPlayerInstrument2.volume = 0;
    self.sendDistortionDrums.volume = 0;
    self.sendDistortionPlayerDrums.volume = 0;
    self.sendDistortionMicrophone.volume = 0;
    
    self.sendDirectOutInstrument1.volume = 1;
    self.sendDirectOutPlayerInstrument1.volume = 1;
    self.sendDirectOutInstrument2.volume = 1;
    self.sendDirectOutPlayerInstrument2.volume = 1;
    self.sendDirectOutDrums.volume = 1;
    self.sendDirectOutPlayerDrums.volume = 1;
    self.sendDirectOutMicrophone.volume = 1;
    
    self.mainMixer.outputVolume = 1;
    
    self.audioUnitTimePitch.rate = 1;
    self.audioUnitTimePitch.overlap = 32;
    self.audioUnitTimePitch.pitch = 0;

    self.playerInstument1.pan = 0;
    self.playerInstument2.pan = 0;
    self.playerDrums.pan = 0;
    self.samplerInstrument1.pan = 0;
    self.samplerInstrument2.pan = 0;
    
    self.octave = 4;
    
    self.isLoopDrums = true;
    self.isLoopInstument1 = true;
    self.isLoopInstument2 = true;
    self.isLoopMicrophone = true;
    
    self.isRecordingDrums = false;
    self.isRecordingInstument1 = false;
    self.isRecordingInstument2 = false;
    self.isRecordingMicrophone = false;
    self.isRecordingMainOut = false;
    
    NSLog(@"Loaded audio unit defaults");
}


#pragma mark methods for instument playback

-(void) playInstrument1:(int)note {
    
    // Plays the note in the correct octave
    
    if (self.octave<=0){
        
        self.octave=0;
        
        [self.samplerInstrument1 startNote:(note-48) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note %i on instrument 1",note-48);
        
    } else if (self.octave==1){
        
        self.octave=1;
        
        [self.samplerInstrument1 startNote:(note-36) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note %i on instrument 1",note-36);
        
    } else if (self.octave==2){
        
        self.octave=2;
        
        [self.samplerInstrument1 startNote:(note-24) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note %i on instrument 1",note-24);
        
    } else if (self.octave==3){
        
        self.octave=3;
        
        [self.samplerInstrument1 startNote:(note-12) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note %i on instrument 1",note-12);
        
    } else if (self.octave==4){
        
        self.octave=4;
        
        [self.samplerInstrument1 startNote:(note) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note %i on instrument 1",note);
        
    } else if (self.octave==5){
        
        self.octave=5;
        
        [self.samplerInstrument1 startNote:(note+12) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note %i on instrument 1",note+12);
        
    } else if (self.octave>=6){
        
        self.octave=6;
        
        [self.samplerInstrument1 startNote:(note+24) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note %i on instrument 1",note+24);
        
    }
    
}

-(void) stopInstrument1:(int)note {
    
    // Stops the note in the right octave
    
    if (self.octave<=0){
        
        self.octave=0;
        
        [self.samplerInstrument1 stopNote:(note-48) onChannel:0];
        
        NSLog(@"Stop note %i on instrument 1",note-48);
        
    } else if (self.octave==1){
        
        self.octave=1;
        
        [self.samplerInstrument1 stopNote:(note-36) onChannel:0];
        
        NSLog(@"Stop note %i on instrument 1",note-36);
        
    } else if (self.octave==2){
        
        self.octave=2;
        
        [self.samplerInstrument1 stopNote:(note-24) onChannel:0];
        
        NSLog(@"Stop note %i on instrument 1",note-24);
        
    } else if (self.octave==3){
        
        self.octave=3;
        
        [self.samplerInstrument1 stopNote:(note-12) onChannel:0];
        
        NSLog(@"Stop note %i on instrument 1",note-12);
        
    } else if (self.octave==4){
        
        self.octave=4;
        
        [self.samplerInstrument1 stopNote:note onChannel:0];
        
        NSLog(@"Stop note %i on instrument 1",note);
        
    } else if (self.octave==5){
        
        self.octave=5;
        
        [self.samplerInstrument1 stopNote:(note+12) onChannel:0];
        
        NSLog(@"Stop note %i on instrument 1",note+12);
        
    } else if (self.octave>=6){
        
        self.octave=6;
        
        [self.samplerInstrument1 stopNote:(note+24) onChannel:0];
        
        NSLog(@"Stop note %i on instrument 1",note+24);
        
    }
    
}

-(void) playInstrument2:(int)note {
    
    // Plays the note in the correct octave
    
    if (self.octave<=0){
        
        self.octave=0;
        
        [self.samplerInstrument2 startNote:(note-48) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note %i on instrument 2",note-48);
        
    } else if (self.octave==1){
        
        self.octave=1;
        
        [self.samplerInstrument2 startNote:(note-36) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note %i on instrument 2",note-36);
        
    } else if (self.octave==2){
        
        self.octave=2;
        
        [self.samplerInstrument2 startNote:(note-24) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note %i on instrument 2",note-24);
        
    } else if (self.octave==3){
        
        self.octave=3;
        
        [self.samplerInstrument2 startNote:(note-12) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note %i on instrument 2",note-12);
        
    } else if (self.octave==4){
        
        self.octave=4;
        
        [self.samplerInstrument2 startNote:(note) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note %i on instrument 2",note);
        
    } else if (self.octave==5){
        
        self.octave=5;
        
        [self.samplerInstrument2 startNote:(note+12) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note %i on instrument 2",note+12);
        
    } else if (self.octave>=6){
        
        self.octave=6;
        
        [self.samplerInstrument2 startNote:(note+24) withVelocity:127 onChannel:0];
        
        NSLog(@"Start note %i on instrument 2",note+24);
        
    }
    
}

-(void) stopInstrument2:(int)note {
    
    // Stops the note in the right octave
    
    if (self.octave<=0){
        
        self.octave=0;
        
        [self.samplerInstrument2 stopNote:(note-48) onChannel:0];
        
        NSLog(@"Stop note %i on instrument 2",note-48);
        
    } else if (self.octave==1){
        
        self.octave=1;
        
        [self.samplerInstrument2 stopNote:(note-36) onChannel:0];
        
        NSLog(@"Stop note %i on instrument 2",note-36);
        
    } else if (self.octave==2){
        
        self.octave=2;
        
        [self.samplerInstrument2 stopNote:(note-24) onChannel:0];
        
        NSLog(@"Stop note %i on instrument 2",note-24);
        
    } else if (self.octave==3){
        
        self.octave=3;
        
        [self.samplerInstrument2 stopNote:(note-12) onChannel:0];
        
        NSLog(@"Stop note %i on instrument 2",note-12);
        
    } else if (self.octave==4){
        
        self.octave=4;
        
        [self.samplerInstrument2 stopNote:note onChannel:0];
        
        NSLog(@"Stop note %i on instrument 2",note);
        
    } else if (self.octave==5){
        
        self.octave=5;
        
        [self.samplerInstrument2 stopNote:(note+12) onChannel:0];
        
        NSLog(@"Stop note %i on instrument 2",note+12);
        
    } else if (self.octave>=6){
        
        self.octave=6;
        
        [self.samplerInstrument2 stopNote:(note+24) onChannel:0];
        
        NSLog(@"Stop note %i on instrument 2",note+24);
        
    }
    
}

-(void) playDrums:(int)note {
    
    // Starts the drums playing on correct midi note
    
    [self.samplerDrums startNote:note withVelocity:127 onChannel:0];
    
    NSLog(@"Start note %i on Drums",note);
    
}

-(void) stopDrums:(int)note {
    
    // Stops the drums playing on correct midi note

        [self.samplerDrums stopNote:note onChannel:0];
        
        NSLog(@"Stop note %i on Drums",note);
}

-(void) panInstrument1: (float) pan{
    
    // Pan for the instument and player
    
    self.samplerInstrument1.pan = pan;
    self.playerInstument1.pan = pan;
    
    NSLog(@"Instument 1 Pan: %.2f",pan);
    
}

-(void) panInstrument2: (float) pan{
    
    // Pan for the instument and player
    
    self.samplerInstrument2.pan = pan;
    self.playerInstument2.pan = pan;
    
    NSLog(@"Instument 2 Pan: %.2f",pan);
    
}

#pragma mark methods for audio units

-(void) audioUnitReverbWetDry: (float) wetDry{
    
    // Changes how wet or dry the signal of the audio unit is
    
    self.audioUnitReverb.wetDryMix = wetDry;
    
    NSLog(@"Reverb Wet/Dry: %.2f",wetDry);
}

-(void) audioUnitDelayWetDry:(float)wetDry {
    
    // Changes how wet or dry the signal of the audio unit is
    
    self.audioUnitDelay.wetDryMix = wetDry;
    
    NSLog(@"Delay Wet/Dry: %.2f",wetDry);
    
}

-(void) audioUnitDelayTime:(float)delayTime {
    
    // Changes the delay time of the audio unit
    
    self.audioUnitDelay.delayTime = delayTime;
    
    NSLog(@"Delay Time: %.2f",delayTime);
    
}

-(void) audioUnitDelayFeedback:(float)feedback {
    
    // Changes the feedback of the audio unit
    
    self.audioUnitDelay.feedback = feedback;
    
    NSLog(@"Delay Feedback: %.2f",feedback);
    
}

-(void) audioUnitDelayLowPassCutoff:(float)cutoff {
    
    // Changes the low pass cutt off of the audio unit

    self.audioUnitDelay.lowPassCutoff = cutoff;
    
    NSLog(@"Delay Low Pass Cuttoff: %.2f",cutoff);
    
}

-(void) audioUnitDistortionWetDry:(float)wetDry {
    
    // Changes how wet or dry the signal of the audio unit is
    
    self.audioUnitDistortion.wetDryMix = wetDry;
    
    NSLog(@"Distortion Wet/Dry: %.2f",wetDry);
    
}

-(void) audioUnitDistortionPreGain:(float)preGain {
    
    // Changes the pre-gain of the audio unit
    
    self.audioUnitDistortion.preGain = preGain;
    
    NSLog(@"Distortion PreGain: %.2f",preGain);
    
}

-(void) audioUnitTimePitchRate:(float)rate {
    
    // Changes the rate of the audio unit
    
    self.audioUnitTimePitch.rate = rate;
    
    NSLog(@"Time Pitch Rate: %.2f",rate);
    
}

-(void) audioUnitTimePitchOverlap:(float)overlap {
    
    // Changes the overlap of the audio unit
    
    self.audioUnitTimePitch.overlap = overlap;
    
    NSLog(@"Time Pitch Overlap: %.2f",overlap);
    
}

-(void) audioUnitTimePitch:(float)pitch {
    
    // Changes the pitch of the audio unit
    
    self.audioUnitTimePitch.pitch = pitch;
    
    NSLog(@"Time Pitch: %.2f",pitch);
    
}

#pragma mark methods for sends and volume

-(void) sendsForDirectOut:(float)directInstrument1 :(float)directInstrument2 :(float)directDrums :(float)directMicrohpone{
    
    // The amount of input volume for each bus that it is being sent to
    
    self.sendDirectOutInstrument1.volume = directInstrument1;
    self.sendDirectOutPlayerInstrument1.volume = directInstrument1;
    
    NSLog(@"Direct out Send for instument 1: %.2f",directInstrument1);
    
    self.sendDirectOutInstrument2.volume = directInstrument2;
    self.sendDirectOutPlayerInstrument2.volume = directInstrument2;
    
    NSLog(@"Direct out Send for instument 2: %.2f",directInstrument2);
    
    self.sendDirectOutDrums.volume = directDrums;
    self.sendDirectOutPlayerDrums.volume = directDrums;
    
    NSLog(@"Direct out Send for drums: %.2f",directDrums);
    
    self.sendDirectOutMicrophone.volume = directMicrohpone;
    
    NSLog(@"Direct out Send for microphone: %.2f",directDrums);
    
}

-(void) sendsForDistortion:(float)distortionInstrument1 :(float)distortionInstrument2 :(float)distortionDrums :(float)distortionMicrohpone {
    
    // The amount of input volume for each bus that it is being sent to
    
    self.sendDistortionInstrument1.volume = distortionInstrument1;
    self.sendDistortionPlayerInstrument1.volume = distortionInstrument1;
    
    NSLog(@"distortion Send for instument 1: %.2f",distortionInstrument1);
    
    self.sendDistortionInstrument2.volume = distortionInstrument2;
    self.sendDistortionPlayerInstrument2.volume = distortionInstrument2;
    
    NSLog(@"distortion Send for instument 2: %.2f",distortionInstrument2);
    
    self.sendDistortionDrums.volume = distortionDrums;
    self.sendDistortionPlayerDrums.volume = distortionDrums;
    
    NSLog(@"distortion Send for drums: %.2f",distortionDrums);
    
    self.sendDistortionMicrophone.volume = distortionMicrohpone;
    
    NSLog(@"distortion Send for microphone: %.2f",distortionMicrohpone);
    
}

-(void) sendsForDelay:(float)delayInstrument1 :(float)delayInstrument2 :(float)delayDrums :(float)delayMicrohpone {
    
    // The amount of input volume for each bus that it is being sent to
    
    self.sendDelayInstrument1.volume = delayInstrument1;
    self.sendDelayPlayerInstrument1.volume = delayInstrument1;
    
    NSLog(@"Delay Send for instument 1: %.2f",delayInstrument1);
    
    self.sendDelayInstrument2.volume = delayInstrument2;
    self.sendDelayPlayerInstrument2.volume = delayInstrument2;
    
    NSLog(@"Delay Send for instument 2: %.2f",delayInstrument2);
    
    self.sendDelayDrums.volume = delayDrums;
    self.sendDelayPlayerDrums.volume = delayDrums;
    
    NSLog(@"Delay Send for drums: %.2f",delayDrums);
    
    self.sendDelayMicrophone.volume = delayMicrohpone;
    
    NSLog(@"Delay Send for microphone: %.2f",delayMicrohpone);
    
}

-(void) sendsForReverb: (float)reverbInstrument1 : (float)reverbInstrument2 : (float)reverbDrums : (float)reverbMicrohpone  {
    
    // The amount of input volume for each bus that it is being sent to
    
    self.sendReverbInstrument1.volume = reverbInstrument1;
    self.sendReverbPlayerInstrument1.volume = reverbInstrument1;
    
    NSLog(@"Reverb Send for instument 1: %.2f",reverbInstrument1);
    
    self.sendReverbInstrument2.volume = reverbInstrument2;
    self.sendReverbPlayerInstrument2.volume = reverbInstrument2;
    
    NSLog(@"Reverb Send for instument 2: %.2f",reverbInstrument2);
    
    self.sendReverbDrums.volume = reverbDrums;
    self.sendReverbPlayerDrums.volume = reverbDrums;
    
    NSLog(@"Reverb Send for drums: %.2f",reverbDrums);
    
    self.sendReverbMicrophone.volume = reverbMicrohpone;
    
    NSLog(@"Reverb Send for microphone: %.2f",reverbMicrohpone);
    
}

-(void) volumeMainMixer: (float) volume {
    
    // Changes the volume for the main mixer (which is the mainMixer Node)
    
    self.mainMixer.outputVolume = volume;
    
    NSLog(@"Volume %.2f",volume);
    
}

#pragma mark methods for changing instument/preset

-(void) changeInstrument1:(NSInteger)selectedInstument1 {
    
    // Loads a diffrent program depending on the selected instrument
    
    NSError *error;
    
    if (selectedInstument1 == 0){
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:0 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 1 failed to load samples when selected from %li %@",(long)selectedInstument1,error);
        }
        
    } else if (selectedInstument1 == 1) {
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:4 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 1 failed to load samples when selected from %li %@",(long)selectedInstument1,error);
        }
        
    } else if (selectedInstument1 == 2) {
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:11 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 1 failed to load samples when selected from %li %@",(long)selectedInstument1,error);
        }
        
    } else if (selectedInstument1 == 3) {
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:19 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 1 failed to load samples when selected from %li %@",(long)selectedInstument1,error);
        }
        
    } else if (selectedInstument1 == 4) {
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:40 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 1 failed to load samples when selected from %li %@",(long)selectedInstument1,error);
        }
        
    } else if (selectedInstument1 == 5) {
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:41 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 1 failed to load samples when selected from %li %@",(long)selectedInstument1,error);
        }
        
    } else if (selectedInstument1 == 6) {
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:52 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 1 failed to load samples when selected from %li %@",(long)selectedInstument1,error);
        }
        
    } else if (selectedInstument1 == 7) {
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:79 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 1 failed to load samples when selected from %li %@",(long)selectedInstument1,error);
        }
        
    } else if (selectedInstument1 == 8) {
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:83 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 1 failed to load samples when selected from %li %@",(long)selectedInstument1,error);
        }
        
    } else if (selectedInstument1 == 9) {
        
        [self.samplerInstrument1 loadSoundBankInstrumentAtURL:self.samplerInstrument1URL program:86 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 1 failed to load samples when selected from %li %@",(long)selectedInstument1,error);
        }
        
    }
}


-(void) changeInstrument2:(NSInteger)selectedInstument2 {
    
    // Loads a diffrent program depending on the selected instrument
    
    NSError *error;
    
    if (selectedInstument2 == 0){
        
        [self.samplerInstrument2 loadSoundBankInstrumentAtURL:self.samplerInstrument2URL program:33 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 2 failed to load samples when selected from %li %@",(long)selectedInstument2,error);
        }
        
    } else if (selectedInstument2 == 1) {
        
        [self.samplerInstrument2 loadSoundBankInstrumentAtURL:self.samplerInstrument2URL program:34 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 2 failed to load samples when selected from %li %@",(long)selectedInstument2,error);
        }
        
    } else if (selectedInstument2 == 2) {
        
        [self.samplerInstrument2 loadSoundBankInstrumentAtURL:self.samplerInstrument2URL program:38 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 2 failed to load samples when selected from %li %@",(long)selectedInstument2,error);
        }
        
    } else if (selectedInstument2 == 3) {
        
        [self.samplerInstrument2 loadSoundBankInstrumentAtURL:self.samplerInstrument2URL program:42 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 2 failed to load samples when selected from %li %@",(long)selectedInstument2,error);
        }
        
    } else if (selectedInstument2 == 4) {
        
        [self.samplerInstrument2 loadSoundBankInstrumentAtURL:self.samplerInstrument2URL program:45 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 2 failed to load samples when selected from %li %@",(long)selectedInstument2,error);
        }
        
    } else if (selectedInstument2 == 5) {
        
        [self.samplerInstrument2 loadSoundBankInstrumentAtURL:self.samplerInstrument2URL program:54 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 2 failed to load samples when selected from %li %@",(long)selectedInstument2,error);
        }
        
    } else if (selectedInstument2 == 6) {
        
        [self.samplerInstrument2 loadSoundBankInstrumentAtURL:self.samplerInstrument2URL program:56 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 2 failed to load samples when selected from %li %@",(long)selectedInstument2,error);
        }
        
    } else if (selectedInstument2 == 7) {
        
        [self.samplerInstrument2 loadSoundBankInstrumentAtURL:self.samplerInstrument2URL program:62 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 2 failed to load samples when selected from %li %@",(long)selectedInstument2,error);
        }
        
    } else if (selectedInstument2 == 8) {
        
        [self.samplerInstrument2 loadSoundBankInstrumentAtURL:self.samplerInstrument2URL program:77 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 2 failed to load samples when selected from %li %@",(long)selectedInstument2,error);
        }
        
    } else if (selectedInstument2 == 9) {
        
        [self.samplerInstrument2 loadSoundBankInstrumentAtURL:self.samplerInstrument2URL program:87 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 2 failed to load samples when selected from %li %@",(long)selectedInstument2,error);
        }
        
    } else if (selectedInstument2 == 10) {
        
        [self.samplerInstrument2 loadSoundBankInstrumentAtURL:self.samplerInstrument2URL program:88 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Instument 2 failed to load samples when selected from %li %@",(long)selectedInstument2,error);
        }
        
    }
}

-(void) changeDrums:(NSInteger)selectedDrums {
    
    // Loads a diffrent program depending on the selected drums
    
    NSError *error;
    
    if (selectedDrums == 0){
        
        self.samplerIDrumsURL  = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Angular TR-808" ofType:@"sf2"]];
        
        [self.samplerDrums loadSoundBankInstrumentAtURL:self.samplerIDrumsURL program:0 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Drums failed to load samples when selected from %li %@",(long)selectedDrums,error);
        }
        
    } else if (selectedDrums == 1) {
        
        self.samplerIDrumsURL  = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Angular TR-909" ofType:@"sf2"]];
        
        [self.samplerDrums loadSoundBankInstrumentAtURL:self.samplerIDrumsURL program:0 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Drums failed to load samples when selected from %li %@",(long)selectedDrums,error);
        }
        
    } else if (selectedDrums == 2) {
        
        self.samplerIDrumsURL  = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Angular Rave Set" ofType:@"sf2"]];
        
        [self.samplerDrums loadSoundBankInstrumentAtURL:self.samplerIDrumsURL program:0 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Drums failed to load samples when selected from %li %@",(long)selectedDrums,error);
        }
        
    } else if (selectedDrums == 3) {
        
        self.samplerIDrumsURL  = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Angular House Set" ofType:@"sf2"]];
        
        [self.samplerDrums loadSoundBankInstrumentAtURL:self.samplerIDrumsURL program:0 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Drums failed to load samples when selected from %li %@",(long)selectedDrums,error);
        }
        
    } else if (selectedDrums == 4) {
        
        self.samplerIDrumsURL  = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Angular Techno Set" ofType:@"sf2"]];
        
        [self.samplerDrums loadSoundBankInstrumentAtURL:self.samplerIDrumsURL program:0 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Drums failed to load samples when selected from %li %@",(long)selectedDrums,error);
        }
        
    } else if (selectedDrums == 5) {
        
        self.samplerIDrumsURL  = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Angular Jazz1 Set" ofType:@"sf2"]];
        
        [self.samplerDrums loadSoundBankInstrumentAtURL:self.samplerIDrumsURL program:0 bankMSB:0x79 bankLSB:0 error:&error];
        
        if (error) {
            NSLog(@"Drums failed to load samples when selected from %li %@",(long)selectedDrums,error);
        }
        
    }
}

-(void) changeDistortion:(NSInteger)selectedDistortion {
    
    // Loads a diffrent distortion preset depending on the selected input value
    
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

-(void) changeReverb: (NSInteger) selectedReverb {
    
    // Loads a diffrent reverb preset depending on the selected input value
    
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

#pragma mark recording audio from instuments/main out

-(void) startPlayingInstument1 {
    
    NSError *error;
    
    // Checks if recording is still enabled and disables it if YES
    if (self.isRecordingInstument1 == YES){
        
        [self stopRecordingInstument1];
        
    }
    
    // Sets the location for the recoreded file. This is in NSTemporaryDirectory
    self.outputFileInstument1URL = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:@"instument1Output.caf"]];
    
    // Prepares the file to be read
    self.outputFileInstument1 = [[AVAudioFile alloc] initForReading:self.outputFileInstument1URL error:&error];
    
    if (error){
        NSLog(@"outputFileInstument1 file player error %@",error);
        
        NSLog(@"No recorded file?");
        
        return;
    }
    
    if (self.outputFileInstument1.length <= 44100){
        
        // If the file is less than or equal to 44100 samples (less than or equal to 1 second)
        // then return from the method. Error occurs with buffer on assembly code on div.
        
        return;
        
    }
    
    // Creates a buffer for playback and sets the format to the file and lenght.
    self.bufferInstument1 = [[AVAudioPCMBuffer alloc] initWithPCMFormat:self.outputFileInstument1.processingFormat frameCapacity:(AVAudioFrameCount)self.outputFileInstument1.length];
    
    // Reads data from buffer
    [self.outputFileInstument1 readIntoBuffer:self.bufferInstument1 error:&error];
    
    if (error){
        NSLog(@"outputFileInstument1 buffer player error %@",error);
    }
    
    // If loop is enabled schedule loop buffer, if not play non-loop
   if (self.isLoopInstument1 == true){
        
        [self.playerInstument1 scheduleBuffer:self.bufferInstument1 atTime:nil options:AVAudioPlayerNodeBufferLoops completionHandler:nil];
        
    } else {
        
       [self.playerInstument1 scheduleBuffer:self.bufferInstument1 completionHandler:nil];
    }
    
    
    // If the player is not playing then play. If the player is playing then stop.
    if (self.playerInstument1.isPlaying == false) {
        
        [self.playerInstument1 play];
        
        NSLog(@"Playing Instrument1 player");
        
    } else {
        
        [self.playerInstument1 stop];
        
        NSLog(@"Stopping Instrument1 player");
        
    }
}

-(void) startRecordingInstument1{
    
    NSError *error;
    
    // Checks if recording is still enabled and disables it if YES
    if (self.isRecordingInstument1 == YES){
        
        [self stopRecordingInstument1];
        
    }
    
    // Sets the location for the recoreded file. This is in NSTemporaryDirectory
    self.outputFileInstument1URL = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:@"instument1Output.caf"]];
    
    // Prepares the file to be written to and sets the format.
    self.outputFileInstument1 = [[AVAudioFile alloc] initForWriting:self.outputFileInstument1URL settings:[[self.samplerInstrument1 outputFormatForBus:0] settings] error:&error];
    
    if (error){
        NSLog(@"outputFileInstument1 file recording error %@",error);
    }
    
    // Installs a tap on the output of a bus. This allows for the output to be captured. A local buffer then writes the captured data to the file.
    [self.samplerInstrument1 installTapOnBus:0 bufferSize:4096 format:[self.samplerInstrument1 outputFormatForBus:0] block:^(AVAudioPCMBuffer *buffer, AVAudioTime *when) {
        
        NSError *error;
        
        [self.outputFileInstument1 writeFromBuffer:buffer error:&error];
        
        if (error){
            NSLog(@"outputFileInstument1 buffer recording error %@",error);
        }

        
    }];
    
    // Recording is enabled
    self.isRecordingInstument1 = YES;
    
    NSLog(@"Recording started on Instrument1");
}

-(void) stopRecordingInstument1
{
    if (self.isRecordingInstument1) {
        
        // Removes the tap and stops the recording.
        [self.samplerInstrument1 removeTapOnBus:0];
        
        // Recording is disabled
        self.isRecordingInstument1 = NO;
        
        NSLog(@"Recording stopped on Instrument1");
    }
}

-(void) startPlayingInstument2 {
    
    NSError *error;
    
    // Checks if recording is still enabled and disables it if YES
    if (self.isRecordingInstument2 == YES){
        
        [self stopRecordingInstument2];
        
    }
    
    // Sets the location for the recoreded file. This is in NSTemporaryDirectory
    self.outputFileInstument2URL = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:@"instument2Output.caf"]];
    
    // Prepares the file to be read
    self.outputFileInstument2 = [[AVAudioFile alloc] initForReading:self.outputFileInstument2URL error:&error];
    
    if (error){
        NSLog(@"outputFileInstument2 file player error %@",error);
        
        NSLog(@"No recorded file?");
        
        return;
    }
    
    if (self.outputFileInstument2.length <= 44100){
        
        // If the file is less than or equal to 44100 samples (less than or equal to 1 second)
        // then return from the method. Error occurs with buffer on assembly code on div.
        
        return;
        
    }
    
    // Creates a buffer for playback and sets the format to the file and lenght.
    self.bufferInstument2 = [[AVAudioPCMBuffer alloc] initWithPCMFormat:self.outputFileInstument2.processingFormat frameCapacity:(AVAudioFrameCount)self.outputFileInstument2.length];
    
    // Reads data from buffer
    [self.outputFileInstument2 readIntoBuffer:self.bufferInstument2 error:&error];
    
    if (error){
        NSLog(@"outputFileInstument2 buffer player error %@",error);
    }

    // If loop is enabled schedule loop buffer, if not play non-loop
    if (self.isLoopInstument2 == true){
        
        [self.playerInstument2 scheduleBuffer:self.bufferInstument2 atTime:nil options:AVAudioPlayerNodeBufferLoops completionHandler:nil];
        
    } else {
        
        [self.playerInstument2 scheduleBuffer:self.bufferInstument2 completionHandler:nil];
    }
    
    // If the player is not playing then play. If the player is playing then stop.
    if (self.playerInstument2.isPlaying == false) {
        
        [self.playerInstument2 play];
        
        NSLog(@"Playing Instrument2 player");
        
    } else {
        
        [self.playerInstument2 stop];
        
        NSLog(@"Stopping Instrument2 player");
        
    }
}


-(void) startRecordingInstument2
{
    NSError *error;
    
    // Checks if recording is still enabled and disables it if YES
    if (self.isRecordingInstument2 == YES){
        
        [self stopRecordingInstument2];
        
    }
    
    // Sets the location for the recoreded file. This is in NSTemporaryDirectory
    self.outputFileInstument2URL = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:@"instument2Output.caf"]];
    
    // Prepares the file to be written to and sets the format.
    self.outputFileInstument2 = [[AVAudioFile alloc] initForWriting:self.outputFileInstument2URL settings:[[self.samplerInstrument2 outputFormatForBus:0] settings] error:&error];
    
    if (error){
        NSLog(@"outputFileInstument2 file recording error %@",error);
    }
    
    // Installs a tap on the output of a bus. This allows for the output to be captured. A local buffer then writes the captured data to the file.
    [self.samplerInstrument2 installTapOnBus:0 bufferSize:4096 format:[self.samplerInstrument2 outputFormatForBus:0] block:^(AVAudioPCMBuffer *buffer, AVAudioTime *when) {
        
        NSError *error;
        
        [self.outputFileInstument2 writeFromBuffer:buffer error:&error];
        
        if (error){
            NSLog(@"outputFileInstument2 buffer recording error %@",error);
        }
        
        
    }];
    
    // Recording is enabled
    self.isRecordingInstument2 = YES;
    
    NSLog(@"Recording started on Instrument2");
}

-(void) stopRecordingInstument2
{
    if (self.isRecordingInstument2) {
        
        // Removes the tap and stops the recording.
        [self.samplerInstrument2 removeTapOnBus:0];
        
        // Recording is disabled
        self.isRecordingInstument2 = NO;
        
        NSLog(@"Recording stopped on Instrument2");
    }
}


-(void) startPlayingDrums {
    
    NSError *error;
    
    // Checks if recording is still enabled and disables it if YES
    if (self.isRecordingDrums == YES){
        
        [self stopRecordingDrums];
        
    }
    
    // Sets the location for the recoreded file. This is in NSTemporaryDirectory
    self.outputFileDrumsURL = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:@"drumsOutput.caf"]];
    
    // Prepares the file to be read
    self.outputFileDrums= [[AVAudioFile alloc] initForReading:self.outputFileDrumsURL error:&error];
    
    if (error){
        NSLog(@"outputFileDrums file player error %@",error);
        
        NSLog(@"No recorded file?");
        
        return;
    }
    
    if (self.outputFileDrums.length <= 44100){
        
        // If the file is less than or equal to 44100 samples (less than or equal to 1 second)
        // then return from the method. Error occurs with buffer on assembly code on div.
        
        return;
        
    }
    
    // Creates a buffer for playback and sets the format to the file and lenght.
    self.bufferDrums = [[AVAudioPCMBuffer alloc] initWithPCMFormat:self.outputFileDrums.processingFormat frameCapacity:(AVAudioFrameCount)self.outputFileDrums.length];
    
    // Reads data from buffer
    [self.outputFileDrums readIntoBuffer:self.bufferDrums error:&error];
    
    if (error){
        NSLog(@"outputFileDrums buffer player error %@",error);
    }
    
    // If loop is enabled schedule loop buffer, if not play non-loop
    if (self.isLoopDrums == true){
        
        [self.playerDrums scheduleBuffer:self.bufferDrums atTime:nil options:AVAudioPlayerNodeBufferLoops completionHandler:nil];
        
    } else {
        
        [self.playerDrums scheduleBuffer:self.bufferDrums completionHandler:nil];
    }
    
    // If the player is not playing then play. If the player is playing then stop.
    if (self.playerDrums.isPlaying == false) {
        
        [self.playerDrums play];
        
        NSLog(@"Playing Drums player");
        
    } else {
        
        [self.playerDrums stop];
        
        NSLog(@"Stopping Drums player");
        
    }
}


-(void) startRecordingDrums
{
    NSError *error;
    
    // Checks if recording is still enabled and disables it if YES
    if (self.isRecordingDrums == YES){
        
        [self stopRecordingDrums];
        
    }
    
    // Sets the location for the recoreded file. This is in NSTemporaryDirectory
    self.outputFileDrumsURL = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:@"drumsOutput.caf"]];
    
    // Prepares the file to be written to and sets the format.
    self.outputFileDrums = [[AVAudioFile alloc] initForWriting:self.outputFileDrumsURL settings:[[self.samplerDrums outputFormatForBus:0] settings] error:&error];
    
    if (error){
        NSLog(@"outputFileDrums file recording error %@",error);
    }
    
    // Installs a tap on the output of a bus. This allows for the output to be captured. A local buffer then writes the captured data to the file.
    [self.samplerDrums installTapOnBus:0 bufferSize:4096 format:[self.samplerDrums outputFormatForBus:0] block:^(AVAudioPCMBuffer *buffer, AVAudioTime *when) {
        
        NSError *error;
        
        [self.outputFileDrums writeFromBuffer:buffer error:&error];
        
        if (error){
            NSLog(@"outputFileDrums buffer recording error %@",error);
        }
        
        
    }];
    
    // Recording is enabled
    self.isRecordingDrums = YES;
    
    NSLog(@"Recording started on Drums");
}

-(void) stopRecordingDrums
{
    if (self.isRecordingDrums) {
        
        // Removes the tap and stops the recording.
        [self.samplerDrums removeTapOnBus:0];
        
        // Recording is disabled
        self.isRecordingDrums= NO;
        
        NSLog(@"Recording stopped on Drums");
    }
}

-(void) startPlayingMainOut {
    
    NSError *error;
    
    // Checks if recording is still enabled and disables it if YES
    if (self.isRecordingMainOut == YES){
        
        [self stopRecordingMainOut];
        
    }
    
    // Sets the location for the recoreded file. This is in NSTemporaryDirectory
    self.outputFileMainOutURL = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:@"mainoutOutput.caf"]];
    
    // Prepares the file to be read
    self.outputFileMainOut = [[AVAudioFile alloc] initForReading:self.outputFileMainOutURL error:&error];
    
    if (error){
        NSLog(@"outputFileMainOut file player error %@",error);
        
        NSLog(@"No recorded file?");
        
        return;
    }
    
    if (self.outputFileMainOut.length <= 44100){
        
        // If the file is less than or equal to 44100 samples (less than or equal to 1 second)
        // then return from the method. Error occurs with buffer on assembly code on div.
        
        return;
        
    }
    
    // Creates a buffer for playback and sets the format to the file and lenght
    AVAudioPCMBuffer *bufferMainOut= [[AVAudioPCMBuffer alloc] initWithPCMFormat:self.outputFileMainOut.processingFormat frameCapacity:(AVAudioFrameCount)self.outputFileMainOut.length];
    
    if (error){
        NSLog(@"outputFileMainOut buffer player error %@",error);
    }
    
    // Reads data from buffer
    [self.outputFileMainOut readIntoBuffer:bufferMainOut error:&error];

    // Schedule main out buffer
    [self.playerMainOut scheduleBuffer:bufferMainOut completionHandler:nil];
    
    // If the player is not playing then play. If the player is playing then stop.
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
    
    // Checks if recording is still enabled and disables it if YES
    if (self.isRecordingMainOut == YES){
        
        [self stopRecordingMainOut];
        
    }
    
    // Sets the location for the recoreded file. This is in NSTemporaryDirectory
    self.outputFileMainOutURL = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:@"mainoutOutput.caf"]];
    
    // Prepares the file to be written to and sets the format.
    self.outputFileMainOut = [[AVAudioFile alloc] initForWriting:self.outputFileMainOutURL settings:[[self.mainMixer outputFormatForBus:0] settings] error:&error];
    
    if (error){
        NSLog(@"outputFileMainOut file recording error %@",error);
    }
    
    // Installs a tap on the output of a bus. This allows for the output to be captured. A local buffer then writes the captured data to the file.
    [self.mainMixer installTapOnBus:0 bufferSize:4096 format:[self.mainMixer outputFormatForBus:0] block:^(AVAudioPCMBuffer *buffer, AVAudioTime *when) {
        
        NSError *error;
        
        [self.outputFileMainOut writeFromBuffer:buffer error:&error];
        
        if (error){
            NSLog(@"outputFileMainOut buffer recording error %@",error);
            [self stopRecordingMainOut];
            self.isRecordingMainOut = NO;
        }
        
    }];
    
    // Recording is enabled
    self.isRecordingMainOut = YES;
    
    NSLog(@"Recording started on main out ");
}

-(void) stopRecordingMainOut
{
    if (self.isRecordingMainOut) {
        
        // Removes the tap and stops the recording.
        [self.mainMixer removeTapOnBus:0];
        
        // Recording is disabled
        self.isRecordingMainOut = NO;
        
        NSLog(@"Recording stopped on main out");
        
    }
}

-(void) startPlayingMicrophone {
    
    NSError *error;
    
    // Checks if recording is still enabled and disables it if YES
    if (self.isRecordingMicrophone == YES){
        
        [self stopRecordingMicrophone];
        
    }
    
    // Sets the location for the recoreded file. This is in NSTemporaryDirectory
    self.outputFileMicrophoneURL = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:@"microphoneOutput.caf"]];
    
    // Prepares the file to be read
    self.outputFileMicrophone = [[AVAudioFile alloc] initForReading:self.outputFileMicrophoneURL error:&error];
    
    if (error){
        NSLog(@"outputFileMicrophone file player error %@",error);
        
        NSLog(@"No recorded file?");
        
        return;
    }
    
    if (self.outputFileMicrophone.length <= 44100){
        
        // If the file is less than or equal to 44100 samples (less than or equal to 1 second)
        // then return from the method. Error occurs with buffer on assembly code on div.
        
        return;
        
    }
    
    // Creates a buffer for playback and sets the format to the file and lenght.
    self.bufferMicrophone = [[AVAudioPCMBuffer alloc] initWithPCMFormat:self.outputFileMicrophone.processingFormat frameCapacity:(AVAudioFrameCount)self.outputFileMicrophone.length];
    
    // Reads data from buffer
    [self.outputFileMicrophone readIntoBuffer:self.bufferMicrophone error:&error];
    
    if (error){
        NSLog(@"outputFileMicrohpone buffer player error %@",error);
    }
    
    // If loop is enabled schedule loop buffer, if not play non-loop
    if (self.isLoopMicrophone == true){
        
        [self.playerMicrophone scheduleBuffer:self.bufferMicrophone atTime:nil options:AVAudioPlayerNodeBufferLoops completionHandler:nil];
        
    } else {
        
        [self.playerMicrophone scheduleBuffer:self.bufferMicrophone completionHandler:nil];
    }
    
    // If the player is not playing then play. If the player is playing then stop.
    if (self.playerMicrophone.isPlaying == false) {
        
        [self.playerMicrophone play];
        
        NSLog(@"Playing microphone player");

        
    } else if (self.playerMicrophone.isPlaying == true){
        
        [self.playerMicrophone stop];
        
        NSLog(@"Stopping microphone player");
        
    }
    
}

-(void) startRecordingMicrophone
{
    NSError *error;
    
    // Checks if recording is still enabled and disables it if YES
    if (self.isRecordingMicrophone == YES){
        
        [self stopRecordingMicrophone];
        
    }
    
    // Sets the location for the recoreded file. This is in NSTemporaryDirectory
    self.outputFileMicrophoneURL = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:@"microphoneOutput.caf"]];
    
    // Prepares the file to be written to and sets the format.
    self.outputFileMicrophone= [[AVAudioFile alloc] initForWriting:self.outputFileMicrophoneURL settings:self.audioFormat.settings error:&error];
    
    if (error){
        NSLog(@"outputFileMicrophone file recording error %@",error);
    }
    
    // Installs a tap on the output of a bus. This allows for the output to be captured. A local buffer then writes the captured data to the file.
    [self.inputMicrophone installTapOnBus:0 bufferSize:4096 format:self.audioFormat block:^(AVAudioPCMBuffer *buffer, AVAudioTime *when) {
        
        NSError *error;
        
        [self.outputFileMicrophone writeFromBuffer:buffer error:&error];
        
        if (error){
            NSLog(@"outputFileMicrohpone buffer recording error %@",error);
            [self stopRecordingMicrophone];
            self.isRecordingMicrophone = NO;
        }
        
    }];
    
    // Recording is enabled
    self.isRecordingMicrophone = YES;
    
    NSLog(@"Recording started on microphone ");
}

-(void) stopRecordingMicrophone
{
    if (self.isRecordingMicrophone) {
        
        // Removes the tap and stops the recording.
        [self.inputMicrophone removeTapOnBus:0];
        
        // Recording is disabled
        self.isRecordingMicrophone = NO;
        
        NSLog(@"Recording stopped on microphone");
        
    }
}

@end
