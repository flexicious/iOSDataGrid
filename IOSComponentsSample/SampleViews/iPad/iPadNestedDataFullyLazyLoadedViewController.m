#import "iPadNestedDataFullyLazyLoadedViewController.h"
#import "FLXSOrganization.h"
#import "FLXSBusinessService.h"
#import "FLXSDemoVersion.h"

@interface iPadNestedDataFullyLazyLoadedViewController ()

@end

@implementation iPadNestedDataFullyLazyLoadedViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initializeTitleOfToolBar:@"Fully Lazy"];
    self.flexDataGrid.delegate = self;
    [self buildGrid:self.flexDataGrid FromXmlResource:@"FLXSFullyLazyLoaded"];
    //self.flexDataGrid.dataProviderFLXS = [[NSArray alloc] init];
    [self fullyLazyLoaded_CreationComplete :nil];
}
FLXSKeyValuePairCollection* _footerData;

-(NSString*)fullyLazyLoaded_getFooterLabel: (FLXSFlexDataGridFooterCell*)cell{
    if(!_footerData){
        _footerData = [[FLXSKeyValuePairCollection alloc]init];
    }
    if([_footerData getValue:cell.rowInfo.data ]){
       
        if([cell.columnFLXS.dataFieldFLXS isEqual:@"invoiceAmount"] || [cell.columnFLXS.dataFieldFLXS isEqual:@"lineItemAmount"] ||[cell.columnFLXS.dataFieldFLXS isEqual:@"dealAmount"] ){
            return [@"Total: " stringByAppendingString:[[((NSDictionary *) [_footerData getValue:cell.rowInfo.data]) objectForKey:@"total"] stringValue]];
        }
        else
            return [@"Count: " stringByAppendingString:[[((NSDictionary *) [_footerData getValue:cell.rowInfo.data]) objectForKey:@"count"] stringValue]];
    }
    return @"";
    
}
-(void)fullyLazyLoaded_grid_printExportDataRequestHandler:(NSNotification*) ns{
 }
-(void) getPagedOrganizationList_Result:(NSArray*) result
{
    self.flexDataGrid.printExportData = result;
}

FLXSExtendedFilterPageSortChangeEvent* evt1;

-(void)fullyLazyLoaded_flexdatagridcolumnlevel1_itemLoadHandler:(NSNotification*) ns{
    
    //this means we were requested to load all the details for a specific organization.
    evt1 = (FLXSExtendedFilterPageSortChangeEvent*)[ ns.userInfo objectForKey:@"event"];
    FLXSOrganization * org = (FLXSOrganization*)evt1.filter.parentObject;
    org = (FLXSOrganization *)[org clone:NO];
    [[FLXSBusinessService getInstance] getDealsForOrganization:org.id :evt1.filter :@selector(getDealsForOrganization_result:) :self ];
    
}
-(void)getDealsForOrganization_result:(FLXSPagedResult*)result{
    if(!_footerData){
        _footerData = [[FLXSKeyValuePairCollection alloc]init];
    }

    FLXSOrganization * org = (FLXSOrganization * )evt1.filter.parentObject;
    [_footerData addItem:org value:result.summaryData];
    [self.flexDataGrid setChildData:evt1.filter.parentObject children:result.collection level:evt1.filter.level.parentLevel totalRecords:result.totalRecords useSelectedKeyField:YES ];
    
}

-(void)fullyLazyLoaded_flexdatagridcolumnlevel2_itemLoadHandler:(NSNotification*) ns{

    //this means we were requested to load all the invoices for a specific deal.
    evt1 = (FLXSExtendedFilterPageSortChangeEvent*)[ ns.userInfo objectForKey:@"event"];

    FLXSDeal* deal=(FLXSDeal*)evt1.filter.parentObject;
    [[FLXSBusinessService getInstance] getInvoicesForDeal:deal.id :evt1.filter :@selector(getInvoicesForDeal_result2:) :self];


}
-(void)getInvoicesForDeal_result2:(FLXSPagedResult*) result{
    if(!_footerData){
        _footerData = [[FLXSKeyValuePairCollection alloc]init];
    }
    [_footerData addItem:evt1.filter.parentObject value:result.summaryData];
    [self.flexDataGrid setChildData:evt1.filter.parentObject children:[result.collection mutableCopy] level:evt1.filter.level.parentLevel totalRecords:result.totalRecords useSelectedKeyField:YES ];


}



-(void)fullyLazyLoaded_flexdatagridcolumnlevel3_itemLoadHandler:(NSNotification*) ns{
    
    //this means we were requested to load all the line items for a specific invoice.
    evt1 = (FLXSExtendedFilterPageSortChangeEvent*)[ ns.userInfo objectForKey:@"event"];

    FLXSInvoice *inv=(FLXSInvoice*)evt1.filter.parentObject;
    [[FLXSBusinessService getInstance] getLineItemsForInvoice:inv.id :evt1.filter :@selector(getLineItemsForInvoice_result:) :self];
    
}
-(void)getLineItemsForInvoice_result:(FLXSPagedResult*) result{
    if(!_footerData){
        _footerData = [[FLXSKeyValuePairCollection alloc]init];
    }
    [_footerData addItem:evt1.filter.parentObject value:result.summaryData];
    [self.flexDataGrid setChildData:evt1.filter.parentObject children:result.collection level:evt1.filter.level.parentLevel totalRecords:result.totalRecords useSelectedKeyField:YES ];
}
-(void)fullyLazyLoaded_flexdatagridcolumnlevel1_filterPageSortChangeHandler:(NSNotification*) ns{
    
    //this means that we paged, sorted or filtered the list of top level organization.
    evt1 = (FLXSExtendedFilterPageSortChangeEvent*)[ ns.userInfo objectForKey:@"event"];
    [[FLXSBusinessService getInstance] getPagedOrganizationList:evt1.filter :@selector(getPagedOrganizationList_result:) :self];
                                                                         

}
-(void)getPagedOrganizationList_result:(FLXSPagedResult*) result
{
    [self.flexDataGrid setPreservePager:YES];
    [self.flexDataGrid setDataProviderFLXS:result.collection];
    [self.flexDataGrid setTotalRecords:result.totalRecords];
   }
-(void)fullyLazyLoaded_flexdatagridcolumnlevel2_filterPageSortChangeHandler:(NSNotification*) ns{
    
    //this means that we paged, sorted or filtered the list of deals for an organization.
    evt1 = (FLXSExtendedFilterPageSortChangeEvent*)[ ns.userInfo objectForKey:@"event"];
    FLXSOrganization* org=(FLXSOrganization*)evt1.filter.parentObject;
    [[FLXSBusinessService getInstance] getDealsForOrganization:org.id :evt1.filter :@selector(getDealsForOrganization_result2:) :self];
                                                                         
    
}
-(void)getDealsForOrganization_result2:(FLXSPagedResult*) result{
    [self.flexDataGrid setChildData:evt1.filter.parentObject children:result.collection level:evt1.filter.level.parentLevel totalRecords:result.totalRecords useSelectedKeyField:NO ];
}
-(void)fullyLazyLoaded_flexdatagridcolumnlevel3_filterPageSortChangeHandler:(NSNotification*) ns{
    
    //this means that we paged, sorted or filtered the list of invoices for a deal.
    evt1 = (FLXSExtendedFilterPageSortChangeEvent*)[ ns.userInfo objectForKey:@"event"];

    FLXSDeal* deal=(FLXSDeal*)evt1.filter.parentObject;
    [[FLXSBusinessService getInstance] getInvoicesForDeal:deal.id :evt1.filter :@selector(getInvoicesForDeal_result:) :self];
       
}
-(void)getInvoicesForDeal_result:(FLXSPagedResult*) result{
    [self.flexDataGrid setChildData:evt1.filter.parentObject children:[result.collection mutableCopy] level:evt1.filter.level.parentLevel totalRecords:result.totalRecords useSelectedKeyField:NO ];
  
}
-(void)fullyLazyLoaded_flexdatagridcolumnlevel4_filterPageSortChangeHandler: (NSNotification*)ns{
    
    //this means that we paged, sorted or filtered the list of line items for an invoicef.
    evt1 = (FLXSExtendedFilterPageSortChangeEvent*)[ ns.userInfo objectForKey:@"event"];

    FLXSInvoice* inv=(FLXSInvoice*)evt1.filter.parentObject;
    [[FLXSBusinessService getInstance] getLineItemsForInvoice:inv.id :evt1.filter :@selector(getLineItemsForInvoice_result2) :self];
                                                                           
}
-(void)getLineItemsForInvoice_result2: (FLXSPagedResult*) result{
    [self.flexDataGrid setChildData:evt1.filter.parentObject children:[result.collection mutableCopy] level:evt1.filter.level.parentLevel totalRecords:result.totalRecords useSelectedKeyField:NO ];
}

-(void)fullyLazyLoaded_CreationComplete: (NSNotification*) evt1{
    
    
    FLXSFilter* f=[[FLXSFilter alloc] init];//new flexiciousNmsp.Filter();
    f.pageIndex=0;
    f.pageSize=self.flexDataGrid.pageSize;
    [[FLXSBusinessService getInstance] getPagedOrganizationList:f :@selector(getPagedOrganizationList_result2:) :self];



}
-(void)getPagedOrganizationList_result2:(FLXSPagedResult*) result
{
    [self.flexDataGrid setPreservePager:YES];
    [self.flexDataGrid setDataProviderFLXS:result.collection];
    [self.flexDataGrid setTotalRecords:result.totalRecords];

}

- (void)viewDidUnload {
    [self setFlexDataGrid:nil];
    //[self setIPadNestedDataFullyLazyToolbar:nil];
    [super viewDidUnload];
}
@end
