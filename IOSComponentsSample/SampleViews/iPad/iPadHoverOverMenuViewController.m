//
//  iPadHoverOverMenuViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadHoverOverMenuViewController.h"
#import "FLXSBusinessService.h"

@interface iPadHoverOverMenuViewController ()

@end

@implementation iPadHoverOverMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

-(void)grid_itemRollOverHandler:(NSNotification*)ns
{
    
}


-(void)grid_itemRollOutHandler:(NSNotification*)ns
{
    [self.flxsDataGrid hideTooltip];
}

-(void)vbox1_creationCompleteHandler:(NSNotification*)ns
{
    [[FLXSBusinessService getInstance] getDeepOrgList:@selector(getDeepOrgList_result:) :self];
}
-(void)getDeepOrgList_result:(NSArray*)result
{
    self.flxsDataGrid.dataProviderFLXS = result;
}
- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
