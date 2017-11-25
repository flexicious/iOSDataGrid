//
//  iPadThemePickerViewController.h
//  IOSComponentsSample
//
//  Created by Flexicious-111 on 7/16/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLXSDemoVersion.h"


@protocol ipadThemePickerDelegate
-(void) didSelectIndex:(int)index;
@end


@interface iPadThemePickerViewController : UIViewController<UITableViewDataSource  , UITableViewDelegate>
{
    id<ipadThemePickerDelegate> theDelegate;
    NSIndexPath *lastIndex;
    NSInteger   selectedIndex;
}

@property (nonatomic, strong) IBOutlet  UITableView *tableView;
@property (nonatomic, strong) NSArray*arrayThemeData;
@property (nonatomic, assign) id<ipadThemePickerDelegate> theDelegate;

@end
