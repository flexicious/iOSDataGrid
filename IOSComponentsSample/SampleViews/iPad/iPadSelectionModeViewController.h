//
//  iPadSelectionModeViewController.h
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadExampleViewControllerBase.h"

@interface iPadSelectionModeViewController : iPadExampleViewControllerBase
@property (strong, nonatomic) IBOutlet UIToolbar *iPadToolBar;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (strong, nonatomic) IBOutlet FLXSFlexDataGrid *flxsDataGrid;

- (IBAction)radioClick:(id)sender;
- (IBAction)btn_showSelected_clickHanlder:(id)sender;
- (IBAction)bt_clear_clickHanler:(id)sender;
@end
