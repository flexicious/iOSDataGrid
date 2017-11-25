//
//  iPadDisclosureIcon-GroupedUIViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadDisclosureIcon_GroupedUIViewController.h"
#import "FLXSFlexiciousMockGenerator.h"

@interface iPadDisclosureIcon_GroupedUIViewController (){
    NSString* xml;
    NSObject* data;
}

@end

@implementation iPadDisclosureIcon_GroupedUIViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.flxsDataGrid.delegate=self;

    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSSelectionUI2"];
    [self initializeTitleOfToolBar : @"Custom Disclosure Icon - Grouped Data"];
    [self loadJsonData:self.flxsDataGrid FromJsonResource:@"FLXSSelectionUI1Data"];

}


- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
