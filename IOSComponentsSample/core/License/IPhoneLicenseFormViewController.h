//
//  IPhoneLicenseFormViewController.h
//  IOSComponentsSample
//
//  Created by Harigharan on 12/08/14.
//  Copyright (c) 2014 ___IOSComponents___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLXSPopupUIViewControllerBase.h"

@interface IPhoneLicenseFormViewController : FLXSPopupUIViewControllerBase

@property (strong, nonatomic) IBOutlet UITextField *companyNameTF;
@property (strong, nonatomic) IBOutlet UITextField *developerNameTF;
@property (strong, nonatomic) IBOutlet UITextField *developerEmailTF;
@property (strong, nonatomic) IBOutlet UITextField *flexVersionTF;
@property (strong, nonatomic) IBOutlet UITextField *purchaseReferenceTF;

@end
