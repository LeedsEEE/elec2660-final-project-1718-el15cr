//
//  Instrument1ViewController.m
//  S+H
//
//  Created by Callum on 19/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import "Instrument1ViewController.h"

@interface Instrument1ViewController ()

@end

@implementation Instrument1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.navigationItem.hidesBackButton = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction) unwindForSegue:(nonnull UIStoryboardSegue *)unwindSegue towardsViewController:(nonnull UIViewController *)subsequentVC{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
