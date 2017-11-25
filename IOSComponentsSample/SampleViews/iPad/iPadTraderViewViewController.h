//
//  iPadTraderViewViewController.h
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadExampleViewControllerBase.h"

@interface iPadTraderViewViewController : iPadExampleViewControllerBase
@property (strong, nonatomic) IBOutlet FLXSFlexDataGrid *flxsDataGrid;
@property (strong, nonatomic) IBOutlet UIToolbar *iPadToolBar;
@property (strong, nonatomic) IBOutlet UISwitch *switch_start;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIStepper *stepper;

@end
