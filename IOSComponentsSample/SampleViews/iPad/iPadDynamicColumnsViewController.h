//
//  iPadDynamicColumnsViewController.h
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadExampleViewControllerBase.h"

@interface iPadDynamicColumnsViewController : iPadExampleViewControllerBase
@property (strong, nonatomic) IBOutlet FLXSFlexDataGrid *flxsDataGrid;
@property (strong, nonatomic) IBOutlet UIToolbar *iPadToolBar;

- (IBAction)btnAddCol_clickHandler:(id)sender;
- (IBAction)btnRemoveCol_clickHandler:(id)sender;
@end
