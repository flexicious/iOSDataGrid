
#import "iPadChangeTrackingAPIViewController.h"
#import "FLXSFlexiciousMockGenerator.h"


@interface iPadChangeTrackingAPIViewController (){
 }

@end

@implementation iPadChangeTrackingAPIViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.flxsDataGrid.delegate=self;
    
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSChangeTrackingAPI"];
    [self initializeTitleOfToolBar:@"Change Tracking API"];
    
    self.flxsDataGrid.dataProviderFLXS = [FLXSFlexiciousMockGenerator mockNestedData];
    [self.flxsDataGrid validateNow];
    [self.flxsDataGrid expandAll];

}

- (IBAction)btnGetChanges_clickHandler:(id)sender {
    self.textView.text = [self.flxsDataGrid.changes componentsJoinedByString:@"\n"];
}


-(UIColor*)changeTrackingAPI_getCellBackgroundColor:(UIView<FLXSIFlexDataGridCell>*)cell{
    
    if(!cell.rowInfo.isDataRow || [cell.level.grid conformsToProtocol:@protocol(FLXSIPrintDatagrid)]){
        return nil;
    }
    
    for(int i=0;i<[self.flxsDataGrid.changes count];i++){
       FLXSChangeInfo* changeInfo= [self.flxsDataGrid.changes objectAtIndex:(NSUInteger) i];
        if(changeInfo.changedItem == cell.rowInfo.data
           && changeInfo.changedProperty == cell.columnFLXS.dataFieldFLXS
           && changeInfo.previousValue!=changeInfo.changedValue){
            return  [[FLXSStyleManager instance] getUIColorObjectFromHexString:0x119933];
        }
    }
    return nil;
}

- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [self setTextView:nil];
    [super viewDidUnload];
}
@end
