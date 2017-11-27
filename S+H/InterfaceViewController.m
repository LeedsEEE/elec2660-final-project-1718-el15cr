//
//  ViewController.m
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 17/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import "InterfaceViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.audioEngine = [[audioEngine alloc]init];
    self.settings = [[settings alloc]init];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    ViewController *controller = [segue destinationViewController];
    
    // Sends audioEngine object via segue to other view controller
    
    if ([[segue identifier] isEqualToString:@"AudioEngineAndSettings"]){
        
        controller.settings = self.settings;
        controller.audioEngine = self.audioEngine;
        
    }

}


- (IBAction)didTapPlay:(UIButton *)sender {
    
    [self.audioEngine startPlayingMainOut];
    
    if (self.audioEngine.playerMainOut.isPlaying == true) {
        
        [self.buttonPlay setTitle:@"Stop" forState:UIControlStateNormal];
        
    } else if (self.audioEngine.playerMainOut.isPlaying == false){
        
        [self.buttonPlay setTitle:@"Play" forState:UIControlStateNormal];
        
    }
    
}

- (IBAction)didTapRecord:(UIButton *)sender {
    
    if (self.audioEngine.isRecordingMainOut == false){
        
        [self.audioEngine startRecordingMainOut];
        
    } else {
        
        [self.audioEngine stopRecordingMainOut];
        
    }
    
}
@end
