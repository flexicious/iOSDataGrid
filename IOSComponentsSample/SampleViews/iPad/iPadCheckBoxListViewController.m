//
//  iPadCheckBoxListViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-110 on 7/5/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadCheckBoxListViewController.h"
#import "FLXSEmployee.h"

@interface iPadCheckBoxListViewController ()

@end

@implementation iPadCheckBoxListViewController

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
    self.backgroundView.layer.cornerRadius=15;
    self.backgroundView.layer.masksToBounds=YES;
    self.flxsCheckBoxList_simple.layer.borderColor=([[UIColor darkGrayColor] CGColor]);
    self.flxsCheckBoxList_simple.layer.cornerRadius=10;
    self.flxsCheckBoxList_simple.layer.masksToBounds=YES;
    self.flxsCheckBoxList_simple.layer.borderWidth=2;
    
    self.flxsCheckBoxList_complex.layer.borderColor=([[UIColor darkGrayColor] CGColor]);
    self.flxsCheckBoxList_complex.layer.cornerRadius=10;
    self.flxsCheckBoxList_complex.layer.borderWidth=2;
    self.flxsCheckBoxList_complex.layer.masksToBounds=YES;
    [self showCheckBoxList];
    
}
- (IBAction)btnSetSelectedValuesHandler:(id)sender {
 
    self.flxsCheckBoxList_simple.selectedValues=[[NSMutableArray alloc]initWithObjects:[self.flxsCheckBoxList_simple.dataProviderFLXS objectAtIndex:2],[self.flxsCheckBoxList_simple.dataProviderFLXS objectAtIndex:3], nil];
}

- (IBAction)btnShowSelectedValuesHandler:(id)sender {
    [FLXSUIUtils showToast:[self.flxsCheckBoxList_simple.selectedValues description] title:@"SelectedValues"];
}
- (IBAction)btnClearSelectedValuesHandler:(id)sender {
    [self.flxsCheckBoxList_simple clear];
}


-(void)showCheckBoxList{
    
    
    NSMutableArray* myDataSource = [[NSMutableArray alloc] init];
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
    
    
    self.flxsCheckBoxList_simple.addAllItem = YES;
    //  [checkBoxList.layer setBorderWidth:2.0];
    //[checkBoxList.layer setBorderColor:[UIColor blueColor].CGColor];
    [self.flxsCheckBoxList_simple addEventListenerOfType:[FLXSDateComboBox EVENT_CHANGE] usingTarget:self withHandler:@selector(onCheckBoxListChange:
    )];
    self.flxsCheckBoxList_simple.dataProviderFLXS = myDataSource;
    self.flxsCheckBoxList_complex.addAllItem=YES;
    self.flxsCheckBoxList_complex.dataProviderFLXS =[FLXSEmployee employees];
    self.flxsCheckBoxList_complex.labelField=@"displayName";
    self.flxsCheckBoxList_complex.dataFieldFLXS =@"employeeId";
    [self.flxsCheckBoxList_complex addEventListenerOfType:[FLXSDateComboBox EVENT_CHANGE] usingTarget:self withHandler:@selector(onCheckBoxListChange:)];
   
}
- (void)onCheckBoxListChange:(NSNotification*)notification {
    //FLXSEvent *evt = [notification.userInfo valueForKey:@"event"];
    //FLXSCheckBoxList *checkBoxList = (FLXSCheckBoxList *)evt.target;
}

- (void)viewDidUnload {
    [self setBackgroundView:nil];
    [self setFlxsCheckBoxList_simple:nil];
    [self setFlxsCheckBoxList_complex:nil];
    [super viewDidUnload];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES; // support all types of orientation
}
@end
