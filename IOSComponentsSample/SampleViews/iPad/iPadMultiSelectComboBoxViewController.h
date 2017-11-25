//
//  iPadMultiSelectComboBoxViewController.h
//  IOSComponentsSample
//
//  Created by Flexicious-110 on 7/5/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLXSDemoVersion.h"
#import "iPadExampleViewControllerBase.h"

@interface iPadMultiSelectComboBoxViewController : iPadExampleViewControllerBase{
   // FLXSMultiSelectComboBox *multiSelectComboBox;
}
@property (strong, nonatomic) IBOutlet UIView *backgroundView;

@property (strong, nonatomic) IBOutlet FLXSMultiSelectComboBox *flxsMultiSelectComboBox_simple;
@property (strong, nonatomic) IBOutlet FLXSMultiSelectComboBox *flxsMultiSelectComboBox_complex;

- (IBAction)btnShowSelectedValueClickHandler:(id)sender;
- (IBAction)btnSetSelectedValueClickHandler:(id)sender; 
- (IBAction)btnClearSelectedValueClickHandler:(id)sender; 
@end
