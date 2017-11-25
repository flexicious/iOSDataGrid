//
//  iPadJsonDataViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-110 on 7/30/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadJsonDataViewController.h"

@interface iPadJsonDataViewController ()

@end

@implementation iPadJsonDataViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSMultiSelectSetFilterValue"];
    [self loadJsonData:self.flxsDataGrid FromJsonResource:@"FLXSMultiSelectSetFilterValueData"];
    [self initializeTitleOfToolBar : @"Json Data"];

}



- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [super viewDidUnload];
}
@end
