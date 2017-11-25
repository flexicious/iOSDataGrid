//
//  iPadRadioButtonViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-110 on 7/5/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadRadioButtonViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface iPadRadioButtonViewController (){
    UIPopoverController* masterPopOverController;
}

@end

@implementation iPadRadioButtonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];

    self.ipadRadioButtonView.layer.cornerRadius=15;
    self.ipadRadioButtonView.layer.masksToBounds=YES;
    
    self.rbnOptionOne.title = @"Option 1";
    self.rbnOptionOne.radioButtonGroupName= @"group1";
    self.rbnOptionOne.checked = YES;
    self.rbnOptionOne.radioButtonMode=YES;
    self.rbnOptionTwo.title = @"Option 2";
    self.rbnOptionTwo.radioButtonGroupName= @"group1";
    self.rbnOptionTwo.checked = NO;
    self.rbnOptionTwo.radioButtonMode=YES;
    self.rbnOptionThree.title = @"Option 3";
    self.rbnOptionThree.radioButtonGroupName= @"group1";
    self.rbnOptionThree.checked = NO;
    self.rbnOptionThree.radioButtonMode=YES;
    self.tscbOptionOne.title = @"Option 1";
    self.tscbOptionOne.radioButtonGroupName= @"group2";
    self.tscbOptionOne.checked = YES;
    self.tscbOptionOne.radioButtonMode = NO;
    self.tscbOptionOne.allowUserToSelectMiddle= YES;
    self.tscbOptionTwo.title = @"Option 2";
    self.tscbOptionTwo.radioButtonGroupName= @"group2";
    self.tscbOptionTwo.checked = NO;
    self.tscbOptionTwo.radioButtonMode = NO;
    self.tscbOptionTwo.allowUserToSelectMiddle= NO;
    
    self.tscbOptionThree.title=@"Option1";
    self.tscbOptionThree.radioButtonGroupName= @"group3";
    self.tscbOptionThree.checked = NO;
    self.tscbOptionThree.radioButtonMode = YES;
    self.tscbOptionThree.imageView.image = [UIImage imageNamed:@"FLXS_IOSBLUE_partially_selected_checkbox"];
    self.tscbOptionThree.partiallySelectedCheckBox=[UIImage imageNamed:@"FLXS_IOSBLUE_partially_selected_checkbox"];
    self.tscbOptionThree.radioButtonSelected=[UIImage imageNamed:@"FLXS_IOSBLUE_checked_checkbox"];
    self.tscbOptionThree.radioButtonUnselected=[UIImage imageNamed:@"FLXS_IOSBLUE_unchecked_checkbox"];
    
    
    self.tscbOptionFour.title=@"Option2";
    self.tscbOptionFour.radioButtonGroupName= @"group3";
    self.tscbOptionFour.checked = YES;
    self.tscbOptionFour.radioButtonMode = NO;
    self.tscbOptionFour.allowUserToSelectMiddle=YES;
    self.tscbOptionFour.imageView.image = [UIImage imageNamed:@"FLXS_IOSBLUE_partially_selected_checkbox"];
    self.tscbOptionFour.partiallySelectedCheckBox=[UIImage imageNamed:@"FLXS_IOSBLUE_partially_selected_checkbox"];
    self.tscbOptionFour.checkedCheckBox=[UIImage imageNamed:@"FLXS_IOSBLUE_checked_checkbox"];
}

- (IBAction)rbnValueChangedHandler:(id)sender {
    FLXSTriStateCheckBox* temp=(FLXSTriStateCheckBox*)sender;
    [FLXSUIUtils showToast:[@"Selected Value: " stringByAppendingString:temp.radioButtonGroupSelectedLabel] title:@"Tap"];
}


- (IBAction)rbnClickHandler:(id)sender {
   // FLXSTriStateCheckBox* temp=(FLXSTriStateCheckBox*)sender;
     [FLXSUIUtils showToast:[@"Selected Value: " stringByAppendingString:self.rbnOptionOne.radioButtonGroupSelectedLabel] title:@"Tap"];
}



- (void)viewDidUnload {
    [self setIpadRadioButtonToolBar:nil];
    [self setIpadRadioButtonView:nil];
    [self setRbnOptionOne:nil];
    [self setRbnOptionTwo:nil];
    [self setRbnOptionThree:nil];
    [self setTscbOptionOne:nil];
    [self setTscbOptionTwo:nil];
    [self setRbnOptionThree:nil];
    [self setTscbOptionOne:nil];
    [self setTscbOptionTwo:nil];
    [self setTscbOptionThree:nil];
    [self setTscbOptionFour:nil];
    [super viewDidUnload];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES; // support all types of orientation
}
@end
