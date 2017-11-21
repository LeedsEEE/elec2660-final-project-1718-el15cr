//
//  ReverbViewController.h
//  S+H
//
//  Created by Callum Rosedale [el15cr] on 21/11/2017.
//  Copyright © 2017 Callum Rosedale [el15cr]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterfaceViewController.h"

@interface ReverbViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property audioEngine *audioEngine;
@property NSArray *pickerReverbData;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerReverb;



@end
