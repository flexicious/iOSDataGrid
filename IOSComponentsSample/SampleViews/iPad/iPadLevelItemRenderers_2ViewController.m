//
//  iPadLevelItemRenderers-2ViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-110 on 7/8/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadLevelItemRenderers_2ViewController.h"
#import "FLXSBusinessService.h"
#import "SampleLevelRenderer2ViewController.h"

@interface iPadLevelItemRenderers_2ViewController (){
    FLXSExtendedFilterPageSortChangeEvent* evt1;

}

@end

@implementation iPadLevelItemRenderers_2ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.flxsDataGrid.delegate = self;
    
    
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSLevelRenderers2"];
    [self initializeTitleOfToolBar:@"Level Renderers 2"];
}

-(void)levelRenderers2_creationCompleteHandler:(NSNotification*)ns
{
    evt1 = (FLXSExtendedFilterPageSortChangeEvent*)[ ns.userInfo objectForKey:@"event"];

    [[FLXSBusinessService getInstance] getDeepOrgList:@selector(getDeepOrgList_result:) :self];
}

-(FLXSClassFactory *)levelRenderers_getNextLevelRenderer
{
    return [[FLXSClassFactory alloc] initWithNibName:@"SampleLevelRenderer2ViewController"
                                  andControllerClass:[SampleLevelRenderer2ViewController class]
                                      withProperties:nil];

}

-(void)getDeepOrgList_result:(NSArray*)result
{
    [self.flxsDataGrid setDataProviderFLXS:result];
}
- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
