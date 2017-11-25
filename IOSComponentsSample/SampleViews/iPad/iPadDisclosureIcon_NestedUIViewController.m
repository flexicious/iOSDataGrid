//
//  iPadDisclosureIcon-NestedUIViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadDisclosureIcon_NestedUIViewController.h"
#import "FLXSFlexiciousMockGenerator.h"

@interface iPadDisclosureIcon_NestedUIViewController ()

@end
 @implementation iPadDisclosureIcon_NestedUIViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
     self.flxsDataGrid.delegate=self;
   
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSSelectionUI1"];
    [self initializeTitleOfToolBar:@"SelectionUI1"];
    self.flxsDataGrid.dataProviderFLXS = [FLXSFlexiciousMockGenerator mockNestedData];


}

-(void)selectedUI2_CreationComplete:(NSNotification*)ns
{

}
- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
