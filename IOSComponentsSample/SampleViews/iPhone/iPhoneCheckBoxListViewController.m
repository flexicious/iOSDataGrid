//
//  iPhoneCheckBoxListViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-111 on 6/26/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPhoneCheckBoxListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FLXSEmployee.h"


@implementation iPhoneCheckBoxListViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.flxsCheckBoxScrollView setContentSize:CGSizeMake(self.flxsCheckBoxListView.frame.size.width, self.flxsCheckBoxListView.frame.size.height+100)];
    
    self.flxsCheckBoxListView.layer.cornerRadius=10;
    self.flxsCheckBoxListView.layer.masksToBounds=YES;
    self.flxsCheckBoxList_simple.layer.borderColor=([[UIColor darkGrayColor] CGColor]);
    self.flxsCheckBoxList_simple.layer.cornerRadius=5;
    self.flxsCheckBoxList_simple.layer.masksToBounds=YES;
    self.flxsCheckBoxList_simple.layer.borderWidth=1;
    
    self.flxsCheckBoxList_complex.layer.borderColor=([[UIColor darkGrayColor] CGColor]);
    self.flxsCheckBoxList_complex.layer.cornerRadius=5;
    self.flxsCheckBoxList_complex.layer.borderWidth=1;
    self.flxsCheckBoxList_complex.layer.masksToBounds=YES;
    [self   initializeTitleOfToolBar:@"CheckBox List"];

}

- (void)viewDidUnload {
    
    [self setFlxsCheckBoxListView:nil];
    [self setFlxsCheckBoxScrollView:nil];
    [super viewDidUnload];
}
@end
