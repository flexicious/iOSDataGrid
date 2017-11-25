//
//  iPhoneRadioButtonViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-111 on 6/26/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPhoneRadioButtonViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation iPhoneRadioButtonViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self   initializeTitleOfToolBar:@"Radio Button"];

    [self.flxsRadioButtonScrollView setContentSize:CGSizeMake(self.flxsRadioButtonView.frame.size.width, self.flxsRadioButtonView.frame.size.height+100)];
    self.flxsRadioButtonView.layer.cornerRadius=10;
    self.flxsRadioButtonView.layer.masksToBounds=YES;
    
}



- (void)viewDidUnload {
    [self setFlxsRadioButtonView:nil];
    [self setFlxsRadioButtonScrollView:nil];
    [super viewDidUnload];
}
@end
