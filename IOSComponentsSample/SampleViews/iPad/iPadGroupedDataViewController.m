#import "iPadGroupedDataViewController.h"
#import "FLXSBusinessService.h"
#import "FLXSDemoVersion.h"
#import "SampleUIUtils.h"

@interface iPadGroupedDataViewController ()

@end

@implementation iPadGroupedDataViewController

-(NSArray *)getInvoiceStatuses{
    return [FLXSSystemConstants invoiceStatuses];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    [self initializeTitleOfToolBar:@"Grouped Data"];
    self.flxsDataGrid.delegate = self;
  
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSGroupedData"];

}
FLXSExtendedFilterPageSortChangeEvent* evt1 ;
-(void)vbox1_creationCompleteHandler:(NSNotification*)ns
{

    [[FLXSBusinessService getInstance] getDeepOrgList:@selector(getDeepOrgList_result:) :self ];
                                                 
}
-(void)getDeepOrgList_result:(NSArray*)result
{
    [self.flxsDataGrid setDataProviderFLXS:result];
    //set default sort:
    NSMutableArray* sorts = [[NSMutableArray alloc] init];
    [sorts addObject:[[FLXSFilterSort alloc] initWithSortColumn:@"legalName" andIsAscending:YES ]];
    [sorts addObject:[[FLXSFilterSort alloc] initWithSortColumn:@"dealDescription" andIsAscending:YES ]];
    [sorts addObject:[[FLXSFilterSort alloc] initWithSortColumn:@"invoiceNumber" andIsAscending:YES ]];
    [self.flxsDataGrid processSort:sorts];
    
}
-(BOOL)checkCellDisabled:(UIView<FLXSIFlexDataGridCell>*)cell
{
    return !([cell.rowInfo.data isKindOfClass: [FLXSInvoice class]]);
}
-(BOOL)returnFalse:(UIView<FLXSIFlexDataGridCell>*)cell{
    return false;
}
-(NSString*)groupedData_getInvoiceAmount:(NSObject*)data :(FLXSFlexDataGridColumn*)col{
    float val=0;
    if([data isKindOfClass:[FLXSInvoice class]])
        val=((FLXSInvoice*)data).invoiceAmount;
    else if([data isKindOfClass: [FLXSDeal class]])
        val=((FLXSDeal*)data).dealAmount;
    else if([data isKindOfClass:[FLXSOrganization class]])
        val= ((FLXSOrganization*)data ).relationshipAmount;
    return [SampleUIUtils formatCurrency:val];
}

-(NSInteger)groupedData_amountSortCompareFunction:(NSObject*)obj1 :(NSObject*)obj2{
    if([obj1 isKindOfClass:[FLXSOrganization class]] && [obj2 isKindOfClass:[FLXSOrganization class]]){
        return ((FLXSOrganization*)obj1).relationshipAmount > ((FLXSOrganization*)obj2).relationshipAmount?NSOrderedDescending:NSOrderedAscending;

    }
    else if([obj1 isKindOfClass:[FLXSDeal class]] && [obj2 isKindOfClass:[FLXSDeal class]] ){
        return ((FLXSDeal*) obj1).dealAmount > ((FLXSDeal*)obj2).dealAmount?NSOrderedDescending:NSOrderedAscending;;
    }
    else if([obj1 isKindOfClass:[FLXSInvoice class] ]&& [obj2 isKindOfClass:[FLXSInvoice class]]){
        return ((FLXSInvoice*)obj1).invoiceAmount > ((FLXSInvoice*)obj2).invoiceAmount?NSOrderedDescending:NSOrderedAscending;;
    }
    return NSOrderedSame;

}

- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadGroupedDataToolBar:nil];
    [super viewDidUnload];
}
@end
