//
//  iPhoneThemePickerViewController.h
//  IOSComponentsSample
//
//  Created by Flexicious-111 on 8/1/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "ViewController.h"

@protocol iPhoneThemePickerDelegate

-(void)applyTheme:(int )index;

@end


@interface iPhoneThemePickerViewController : FLXSPopupUIViewControllerBase <UITableViewDataSource, UITableViewDelegate>
{
    id<iPhoneThemePickerDelegate> theDelegate;
    NSInteger   selectedIndex;
}

@property (nonatomic ,  assign)  id <iPhoneThemePickerDelegate> theDelegate;

@property (strong, nonatomic) IBOutlet UITableView *tableViewThemeValues;
@property (strong, nonatomic) NSArray        *arrayThemeValues;

@end
