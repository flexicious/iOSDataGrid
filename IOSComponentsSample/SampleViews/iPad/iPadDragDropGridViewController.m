//
//  iPadDragDropGridViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadDragDropGridViewController.h"
#import "FLXSBusinessService.h"

@interface iPadDragDropGridViewController ()

@end

@implementation iPadDragDropGridViewController



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
    self.flxsDataGrid.dataProviderFLXS =result;
}



//can we start dragging this cell?
-(BOOL)isDraggable:(UIView<FLXSIFlexDataGridDataCell>*)cell{
    return true;
}
//can we drop on this cell?
-(BOOL)isDroppable:(UIView<FLXSIFlexDataGridDataCell>*)target{
    //in here we only allow the cells to drop on the same level they belong to
    //so for example, you can reparent a deal from an org, but you cannot
    //drop a deal below an Invoice, because the hierarchy is
    //Org=>Deal=>Invoice
    return target&&self.flxsDataGrid.dragColumn&&(self.flxsDataGrid.dragColumn.level==target.level);
}
//perform our action as a result of  drag drop.
-(void) onDragComplete:(UIView<FLXSIFlexDataGridDataCell>*)target{
}
- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
