//
//  iPadToolbarActionsViewController.h
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadExampleViewControllerBase.h"

@interface iPadToolbarActionsViewController : iPadExampleViewControllerBase<UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet FLXSFlexDataGrid *flxsDataGrid;
@property (strong, nonatomic) IBOutlet UIToolbar *iPadToolBar;

@end
