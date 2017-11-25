//
//  iPadNestedUIViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadNestedUIViewController.h"
#import "FLXSBusinessService.h"
#import "FLXSDemoVersion.h"
@interface iPadNestedUIViewController ()

@end

@implementation iPadNestedUIViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}


-(void)vbox1_creationCompleteHandler:(NSNotification*)ns
{
    [[FLXSBusinessService getInstance] getDeepOrgList:@selector(getDeepOrgList_result:) :self];
}
-(void)getDeepOrgList_result:(NSArray*)result
{
    self.flxsdataGrid.dataProviderFLXS =result;
}
-(void)grid_itemDoubleClickHandler:(NSNotification*)ns
{
    //Alert.show(event.cell.rowInfo.data.legalName);
    
    
    
    for(FLXSRowInfo* row in self.flxsdataGrid.bodyContainer.rows)
    {
        for (FLXSComponentInfo* cell in row.cells)
        {
            FLXSFlexDataGridCell * tdgc = [cell.component conformsToProtocol:@protocol(FLXSIFlexDataGridCell)]?(FLXSFlexDataGridCell*)cell.component:nil;
            if(tdgc)
                tdgc.colIcon.hidden=YES;
        }
    }
    
}
//https://bugs.adobe.com/jira/browse/SDK-31155 (right click issue)

-(void)grid_cellRenderedHandler:(NSNotification*)ns
{
    FLXSFlexDataGridEvent* event = (FLXSFlexDataGridEvent*)[ns.userInfo objectForKey:@"event"];
    if(event.cellFLXS.columnFLXS && event.cellFLXS.columnFLXS.enableExpandCollapseIcon){
        //we want to position this seperately.
        FLXSFlexDataGridCell *fdg=(FLXSFlexDataGridCell*)event.cellFLXS;
        if(fdg.expandCollapseIcon)
            fdg.expandCollapseIcon.x = ((event.cellFLXS.level.nestDepth-1) * 15)+5;
            if(fdg.colIcon)
                fdg.colIcon.x = ((event.cellFLXS.level.nestDepth-1) * 15)+25;
                
                }
    
}
- (void)viewDidUnload {
    [self setFlxsdataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
