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
    
    // Sends audioEngine object via segue to other view controller
    
    ViewController *controller = [segue destinationViewController];
    controller.audioEngine = self.audioEngine;
    
     if ([[segue identifier] isEqualToString:@"settings"]){
         
         controller.settings = self.settings; 
         
     }
    
}


@end
