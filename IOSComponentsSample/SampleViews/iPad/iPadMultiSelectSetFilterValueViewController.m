//
//  iPadMultiSelectSetFilterValueViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-110 on 7/17/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadMultiSelectSetFilterValueViewController.h"
#import "FLXSFlexiciousMockGenerator.h"

@interface iPadMultiSelectSetFilterValueViewController (){
    NSArray* multiSelectSetFilterValue_arrColl;
}

@end

@implementation iPadMultiSelectSetFilterValueViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSMultiSelectSetFilterValue"];
    [self loadJsonData:self.flxsDataGrid FromJsonResource:@"FLXSMultiSelectSetFilterValueData"];
}

- (IBAction)btnSetFilterValue_clickHandler:(id)sender {
    NSArray * arr = [[NSArray alloc] initWithObjects:@"NY",@"CT",nil];
    [self.flxsDataGrid setFilterValue:@"state" value:arr triggerEvent:YES];

}


@end
