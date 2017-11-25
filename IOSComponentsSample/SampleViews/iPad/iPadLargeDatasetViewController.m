//
//  iPadLargeDatasetViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadLargeDatasetViewController.h"
#import "FLXSBusinessService.h"

@interface iPadLargeDatasetViewController (){
    FLXSEvent* evt;
}

@end

@implementation iPadLargeDatasetViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.flxsDataGrid.delegate=self;
   
    
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSLargeDataset"];
    [self initializeTitleOfToolBar:@"Large DataSet"];
     // Do any additional setup after loading the view from its nib.
}

-(void)largeDataset_CreationComplete:(NSNotification*)ns
{
    evt = (FLXSEvent*)[ ns.userInfo objectForKey:@"event"];
    [[FLXSBusinessService getInstance] getAllLineItems:@selector(getAllLineItems:) :self];
}
-(void)getAllLineItems:(NSArray*)result
{
   self.flxsDataGrid.dataProviderFLXS =result;
}
- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
