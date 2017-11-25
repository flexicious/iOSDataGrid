//
//  iPadTextInputViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-110 on 7/4/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadTextInputViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation iPadTextInputViewController


-(void)viewDidLoad{
    [super viewDidLoad];

    [self initializeTitleOfToolBar:@"Auto complete text input"];

    [self showTextInput];
    
}


-(void)showTextInput{
   
    
    NSMutableArray *myDataSource = [[NSMutableArray alloc] init];
   self.flxsTextInput.autoCompleteDropDownBorderWidth = 1.0;
    self.flxsTextInput.autoCompleteDropDownBorderColor = [UIColor blueColor].CGColor;
    //customTextInput.watermarkString = @"search";
    self.flxsTextInput.placeholder = @"test";
    self.flxsTextInput.autoCompleteMatchType = [FLXSTextInput AUTO_COMPLETE_MATCH_TYPE_BEGINS_WITH];
    //[customTextInput setInitialText:@"search"];
    [myDataSource addObject:@"one"];
    [myDataSource addObject:@"two"];
    [myDataSource addObject:@"three"];
    [myDataSource addObject:@"four"];
    [myDataSource addObject:@"five"];
    [myDataSource addObject:@"six"];
    [myDataSource addObject:@"seven"];
    [myDataSource addObject:@"eight"];
    [myDataSource addObject:@"nine"];
    [myDataSource addObject:@"ten"];
    [myDataSource addObject:@"eleven"];
    [myDataSource addObject:@"twelve"];
    [myDataSource addObject:@"thirteen"];
    self.flxsTextInput.autoCompleteSource = myDataSource;
    [self becomeFirstResponder];
    
}
- (void)viewDidUnload {

    [self setFlxsTextInput:nil];
    [super viewDidUnload];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES; // support all types of orientation
}
@end
