//
//  ViewController.h
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 17/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "audioEngine.h"
#import "settings.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) audioEngine *audioEngine;
@property (nonatomic, strong) settings *settings;

@end

