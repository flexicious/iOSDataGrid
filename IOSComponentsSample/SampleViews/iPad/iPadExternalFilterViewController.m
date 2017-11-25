//
//  iPadExternalFilterViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadExternalFilterViewController.h"
#import "FLXSFlexiciousMockGenerator.h"

@interface iPadExternalFilterViewController (){
    NSString* xml;
}

@end

@implementation iPadExternalFilterViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeTitleOfToolBar:@"External Filters"];
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSExternalFilter"];
    self.flxsDataGrid.dataProviderFLXS = FLXSFlexiciousMockGenerator.mockNestedData;
    self.flxsDataGrid.columnLevel.nextLevel.nextLevel.filterFunction = @"filterDeviceTypes";
    [self.flxsDataGrid validateNow];
    [self.flxsDataGrid expandAll];
}


- (IBAction)btn_search_clickHanler:(id)sender {
    [self.flxsDataGrid reloadData];
}

-(NSNumber *)filterDeviceTypes:(NSMutableDictionary*)item{

    if(!self.switch_timeSheet1.on && [[item objectForKey:@"timeSheetTitle"] isEqual:@"Time Sheet-1"])
        return [NSNumber numberWithBool:NO];
    if(!self.switch_timeSheet2.on && [[item objectForKey:@"timeSheetTitle"] isEqual:@"Time Sheet-2"])
        return [NSNumber numberWithBool:NO];
    return [NSNumber numberWithBool:YES];
}

- (void)viewDidUnload {
    [self setIPadToolBar:nil];
    [self setFlxsDataGrid:nil];
    [self setSwitch_timeSheet1:nil];
    [self setSwitch_timeSheet2:nil];
    [super viewDidUnload];
}
@end
