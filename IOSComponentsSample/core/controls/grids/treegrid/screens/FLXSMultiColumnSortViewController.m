//
//  FLXSMultiColumnSortViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-111 on 7/2/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "FLXSMultiColumnSortViewController.h"
#import "FLXSCloseEvent.h"
#import "UIViewController+UIViewControllerAdditions.h"

@interface FLXSMultiColumnSortViewController ()

@end

@implementation FLXSMultiColumnSortViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self       initView];
}

#pragma mark - Private methods...

-(void) initView{

    // Do any additional setup after loading the view from its nib.
    NSMutableArray* myDataSource = [[NSMutableArray alloc] init];
    [myDataSource addObject:@"ID"];
    [myDataSource addObject:@"LegalName of the FLXSOrganization"];
    [myDataSource addObject:@"Line 1"];
    [myDataSource addObject:@"Line 2"];
    [myDataSource addObject:@"City"];
    [myDataSource addObject:@"State"];
    [myDataSource addObject:@"Country"];
    [myDataSource addObject:@"Annual Revenue"];
    [myDataSource addObject:@"Num Employees"];
    [myDataSource addObject:@"EPS"];
    [myDataSource addObject:@"Stock Price"];
    
    // Sort 1...
    self.cbx1.dataProvider = myDataSource;
    self.cbx1.addAllItem = NO;

    // Sort 2/...
    self.cbx2.dataProvider = myDataSource;
    self.cbx2.addAllItem = NO;

    // Sort 3..
    self.cbx3.dataProvider = myDataSource;
    self.cbx3.addAllItem = NO;
    

    // Sort 4..
    self.cbx4.dataProvider = myDataSource;
    self.cbx4.addAllItem = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setM_ButtonClearAll:nil];
    [self setM_ButtonApply:nil];
    [self setM_ButtonCancel:nil];
    [self setM_ButtonCross:nil];
    [self setCbx1:nil];
    [self setCbx2:nil];
    [self setCbx3:nil];
    [self setCbx4:nil];
    [super viewDidUnload];
}

#pragma mark - Actions...

- (IBAction)buttonPressClearAll:(id)sender {

}

- (IBAction)buttonPressCancel:(id)sender {

    FLXSCloseEvent* evt = [[FLXSCloseEvent alloc] initWithType:[FLXSCloseEvent CLOSE]
                                                 andCancelable:NO
                                                    andBubbles:NO];
    evt.detail = [FLXSCloseEvent CANCEL] ;
    [self dispatchEvent:evt];
    if([FLXSUIUtils isIPad])
        [self.parentViewController dismissModalViewControllerAnimated:YES];
    else
        [self.parentViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)buttonPressCross:(id)sender {
    NSLog(@"Cross");
}

- (IBAction)segmentSort1:(id)sender {
    NSLog(@"Sort1");
}

- (IBAction)segmentSort2:(id)sender {
    NSLog(@"Sort2");
}

- (IBAction)segmentSort3:(id)sender {
    NSLog(@"Sort3");
}

- (IBAction)segmentSort4:(id)sender {
    NSLog(@"Sort4");
}

- (IBAction)buttonPressApply:(id)sender {
    NSLog(@"Apply");
    FLXSCloseEvent* evt = [[FLXSCloseEvent alloc] initWithType:[FLXSCloseEvent CLOSE]
                                                 andCancelable:NO
                                                    andBubbles:NO];
    evt.detail = [FLXSCloseEvent CANCEL] ;
    [self dispatchEvent:evt];
    if([FLXSUIUtils isIPad])
        [self.parentViewController dismissModalViewControllerAnimated:YES];
    else
        [self.parentViewController dismissViewControllerAnimated:YES completion:NULL];
}


@end
