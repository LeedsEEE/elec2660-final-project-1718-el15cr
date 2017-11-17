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
    
    self.connectionBusDelay = [NSArray arrayWithObjects:[[AVAudioConnectionPoint alloc] initWithNode:self.busDelay bus:1],[[AVAudioConnectionPoint alloc] initWithNode:self.busDelay bus:1], nil ];
    
    [self.engine connect: self.player toConnectionPoints:self.connectionBusDelay fromBus:0 format:nil];
    
        // Need to sort out audio format
    
    [self.engine connect:self.audioUnitDelay to:self.mainMixer format:nil];
    [self.engine connect:self.audioUnitDistortion to:self.mainMixer format:nil];
    [self.engine connect:self.audioUnitDelay to:self.mainMixer format:nil];
    
    
}

@end
