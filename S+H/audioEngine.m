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
    self.samplerInstument1 = [[AVAudioUnitSampler alloc]init];
    self.samplerInstument2 = [[AVAudioUnitSampler alloc]init];
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
    [self.engine attachNode:self.samplerInstument2];
    [self.engine attachNode:self.samplerInstument1];
    [self.engine attachNode:self.samplerDrums];
    [self.engine attachNode:self.player];
    
    NSLog(@"Nodes attached");
    
}

- (void) createConnections {
    
    // Create the essential connections
    
    // Uses arrays to create connection points. Theses are used to send the instumnet to multiple outputs. They are being sent the the effects busses.
    
    self.connectionBusSend1 = [NSArray arrayWithObjects:[[AVAudioConnectionPoint alloc] initWithNode:self.busDelay bus:0],[[AVAudioConnectionPoint alloc] initWithNode:self.busDistortion bus:0],[[AVAudioConnectionPoint alloc] initWithNode:self.busReverb bus:0],[[AVAudioConnectionPoint alloc] initWithNode:self.busDirectOut bus:0],nil ];
    
    self.connectionBusSend2 = [NSArray arrayWithObjects:[[AVAudioConnectionPoint alloc] initWithNode:self.busDelay bus:1],[[AVAudioConnectionPoint alloc] initWithNode:self.busDistortion bus:1],[[AVAudioConnectionPoint alloc] initWithNode:self.busReverb bus:1],[[AVAudioConnectionPoint alloc] initWithNode:self.busDirectOut bus:1],nil ];
    [self.engine connect: self.player toConnectionPoints:self.connectionBusSend1 fromBus:0 format:self.audioFormat];
    
    self.connectionBusSend3 = [NSArray arrayWithObjects:[[AVAudioConnectionPoint alloc] initWithNode:self.busDelay bus:2],[[AVAudioConnectionPoint alloc] initWithNode:self.busDistortion bus:2],[[AVAudioConnectionPoint alloc] initWithNode:self.busReverb bus:2],[[AVAudioConnectionPoint alloc] initWithNode:self.busDirectOut bus:2],nil ];
    [self.engine connect: self.player toConnectionPoints:self.connectionBusSend1 fromBus:0 format:self.audioFormat];
    
    self.connectionBusSend4 = [NSArray arrayWithObjects:[[AVAudioConnectionPoint alloc] initWithNode:self.busDelay bus:3],[[AVAudioConnectionPoint alloc] initWithNode:self.busDistortion bus:3],[[AVAudioConnectionPoint alloc] initWithNode:self.busReverb bus:3],[[AVAudioConnectionPoint alloc] initWithNode:self.busDirectOut bus:3],nil ];
    [self.engine connect: self.player toConnectionPoints:self.connectionBusSend1 fromBus:0 format:self.audioFormat];
    
    // Connect the instumnets to the connecton points that have been created in the array
    
    [self.engine connect:self.samplerInstument1 toConnectionPoints:self.connectionBusSend1 fromBus:0 format:self.audioFormat];
    [self.engine connect:self.samplerInstument2 toConnectionPoints:self.connectionBusSend2 fromBus:0 format:self.audioFormat];
    [self.engine connect:self.samplerDrums toConnectionPoints:self.connectionBusSend2 fromBus:0 format:self.audioFormat];
    [self.engine connect:self.player toConnectionPoints:self.connectionBusSend2 fromBus:0 format:self.audioFormat];
    
    // Need to sort out audio format
    
    [self.engine connect:self.audioUnitDelay to:self.mainMixer format:self.audioFormat];
    [self.engine connect:self.audioUnitDistortion to:self.mainMixer format:self.audioFormat];
    [self.engine connect:self.audioUnitDelay to:self.mainMixer format:self.audioFormat];
    
    NSLog(@"Connections created");
    
}

#pragma setup instuments

#pragma methods for playback

#pragma audio units 



@end
