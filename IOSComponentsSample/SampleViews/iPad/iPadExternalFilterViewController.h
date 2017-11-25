//
//  iPadExternalFilterViewController.h
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadExampleViewControllerBase.h"

@interface iPadExternalFilterViewController : iPadExampleViewControllerBase
@property (strong, nonatomic) IBOutlet UIToolbar *iPadToolBar;
@property (strong, nonatomic) IBOutlet FLXSFlexDataGrid *flxsDataGrid;
@property (strong, nonatomic) IBOutlet UISwitch *switch_timeSheet1;
@property (strong, nonatomic) IBOutlet UISwitch *switch_timeSheet2;

- (IBAction)btn_search_clickHanler:(id)sender;

@end
