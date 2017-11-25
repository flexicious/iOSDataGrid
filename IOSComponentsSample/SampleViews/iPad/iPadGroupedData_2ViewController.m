
#import "iPadGroupedData_2ViewController.h"
#import "FLXSBusinessService.h"
#import "SampleUIUtils.h"
#import "FLXSCustomCsvExporter.h"
#import "FLXSUIUtils.h"

@interface iPadGroupedData_2ViewController ()

@end

@implementation iPadGroupedData_2ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.flxsDataGrid.delegate = self;
    [self initializeTitleOfToolBar:@"Grouped Data 2"];
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSGroupedData2"];
    self.flxsDataGrid.excelOptions.exportCollapsedRows=  YES;
    [self.flxsDataGrid.excelOptions.exporters addObject:[[FLXSCustomCsvExporter alloc]init]];
    [self.flxsDataGrid.columnLevel addSort:[[FLXSFilterSort alloc] initWithSortColumn:@"name" andIsAscending:YES]];
        [self.flxsDataGrid.columnLevel addSort:[[FLXSFilterSort alloc] initWithSortColumn:@"invoiceDate" andIsAscending:YES]];
        [self.flxsDataGrid.columnLevel addSort:[[FLXSFilterSort alloc] initWithSortColumn:@"invoiceStatus.name" andIsAscending:YES]];
}


FLXSExtendedFilterPageSortChangeEvent* evt1;
-(NSArray *)getInvoiceStatuses{
    return [FLXSSystemConstants invoiceStatuses];
}
-(void)groupedData2_CreationComplete:(NSNotification*)ns
{

    [[FLXSBusinessService getInstance] getFlatOrgList :@selector(getFlatOrgList_Result:) :self];

}
-(void)groupedData2_itemEditEnd:(NSNotification*)ns
{
    [self.flxsDataGrid refreshCells];
}

-(void) getFlatOrgList_Result:( NSArray*)result{
    self.flxsDataGrid.preservePager=YES;
    
    self.flxsDataGrid.dataProviderFLXS =result;
}
-(NSNumber *)groupedData2_checkCellDisabled:(UIView<FLXSIFlexDataGridCell>*)cell{
    return [NSNumber numberWithBool:!([cell.rowInfo.data isKindOfClass:[FLXSInvoice class]] )];
}
-(BOOL)groupedData2_returnFalse:(UIView<FLXSIFlexDataGridCell>*)cell :(id)data{
    return false;
}

-(NSString*)groupedData2_footerLabelFunction:(FLXSFlexDataGridColumn*)col{
    
    return [SampleUIUtils formatCurrency:[FLXSUIUtils sum:col.level.grid.dataProviderFLXS fld:@"relationshipAmount"]];
}

-(NSString*)groupedData2_getInvoiceAmount:(NSObject*)data :(FLXSFlexDataGridColumn*)col{
    float val=0;
    if([data isKindOfClass:[FLXSInvoice class]] )
        val=((FLXSInvoice*)data).invoiceAmount;
    else if([data isKindOfClass:[FLXSDeal class]])
        val=((FLXSDeal*)data).dealAmount;
    else if([data isKindOfClass:[FLXSOrganization class]] )
        val= ((FLXSOrganization*)data ).relationshipAmount==0?((FLXSOrganization*)data ).relationshipAmountSaved:((FLXSOrganization*)data ).relationshipAmount;
    return [SampleUIUtils formatCurrency:val];
}
-(NSInteger)groupedData2_amountSortCompareFunction:(NSObject*)obj1 :(NSObject*)obj2{
    if([obj1 isKindOfClass:[FLXSOrganization class]] && [obj2 isKindOfClass:[FLXSOrganization class]]){
        return ((FLXSOrganization*)obj1).relationshipAmountSaved > ((FLXSOrganization*)obj2).relationshipAmountSaved?NSOrderedDescending:NSOrderedAscending;

    }
    else if([obj1 isKindOfClass:[FLXSDeal class]] && [obj2 isKindOfClass:[FLXSDeal class]] ){
        return ((FLXSDeal*) obj1).dealAmount > ((FLXSDeal*)obj2).dealAmount?NSOrderedDescending:NSOrderedAscending;;
    }
    else if([obj1 isKindOfClass:[FLXSInvoice class] ]&& [obj2 isKindOfClass:[FLXSInvoice class]]){
        return ((FLXSInvoice*)obj1).invoiceAmount > ((FLXSInvoice*)obj2).invoiceAmount?NSOrderedDescending:NSOrderedAscending;;
    }
    return NSOrderedSame;
    
}

FLXSExtendedFilterPageSortChangeEvent* evt1;

-(void)partialLazyLoaded_flexdatagridcolumnlevel1_itemLoadHandler: (NSNotification*)ns {
    
    [self.flxsDataGrid showSpinner:self.flxsDataGrid.spinnerLabel];
    evt1 = (FLXSExtendedFilterPageSortChangeEvent*)[ ns.userInfo objectForKey:@"event"];
    //this means we were requested to load all the details for a specific organization.
    FLXSOrganization *org=(FLXSOrganization*)evt1.filter.parentObject;
    [[FLXSBusinessService getInstance] getDealsForOrganization:org.id :evt1.filter :@selector(getDealsForOrganization_result:) :self];
    
};
-(void) getDealsForOrganization_result:(FLXSPagedResult*) result{
    [self.flxsDataGrid hideSpinner];
    [self.flxsDataGrid setChildData:evt1.filter.parentObject children:result.collection level:evt1.filter.level.parentLevel totalRecords:result.totalRecords useSelectedKeyField:NO ];
    //self.flexDataGrid.setChildData(evt1.filter.parentObject,evt.result.deals,evt1.filter.level.getParentLevel());
}
-(NSNumber*)isCellEditable:(UIView<FLXSIFlexDataGridCell>*) cell{
    return [NSNumber numberWithBool:(cell.level.nestDepth==3)&&
            [cell.columnFLXS.dataFieldFLXS isEqualToString:@"invoiceAmount"]] ;
}
- (void)viewDidUnload {
    [self setIPadGroupedData2Toolbar:nil];
    [self setFlxsDataGrid:nil];
    [super viewDidUnload];
}
     
@end
