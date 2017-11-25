#import "iPadNestedDataPartialLazyLoadedViewController.h"
#import "FLXSFlexiciousMockGenerator.h"
#import "FLXSBusinessService.h"


@interface iPadNestedDataPartialLazyLoadedViewController ()

@end

@implementation iPadNestedDataPartialLazyLoadedViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.flexDataGrid.delegate = self;
    [self initializeTitleOfToolBar:@"Partial Lazy"];
    [self buildGrid:self.flexDataGrid FromXmlResource:@"FLXSPartialLazyLoaded"];
    

}
FLXSExtendedFilterPageSortChangeEvent* evt1;

-(void)partialLazyLoaded_flexdatagridcolumnlevel1_itemLoadHandler: (NSNotification*)ns {

    [self.flexDataGrid showSpinner:self.flexDataGrid.spinnerLabel];
    evt1 = (FLXSExtendedFilterPageSortChangeEvent*)[ ns.userInfo objectForKey:@"event"];
    //this means we were requested to load all the details for a specific organization.
    FLXSOrganization *org=(FLXSOrganization*)evt1.filter.parentObject;
    [[FLXSBusinessService getInstance] getDealsForOrganization:org.id :evt1.filter :@selector(getDealsForOrganization_result:) :self];

};
-(void) getDealsForOrganization_result:(FLXSPagedResult*) result{
    [self.flexDataGrid hideSpinner];
    [self.flexDataGrid setChildData:evt1.filter.parentObject children:result.collection level:evt1.filter.level.parentLevel totalRecords:result.totalRecords useSelectedKeyField:NO ];
    //self.flexDataGrid.setChildData(evt1.filter.parentObject,evt.result.deals,evt1.filter.level.getParentLevel());
}
-(void)partialLazyLoaded_CreationComplete: (NSNotification*)ns {
   // FLXSFlexDataGridEvent * evt = (FLXSFlexDataGridEvent*)[ns.userInfo objectForKey:@"event"];

    [[FLXSBusinessService getInstance] getFlatOrgList :@selector(getFlatOrgList_Result:) :self];
}

-(void) getFlatOrgList_Result:( NSArray*)result{
    self.flexDataGrid.preservePager=YES;
    self.flexDataGrid.dataProviderFLXS =result;
}


- (void)viewDidUnload {
    [self setIpadNestedDataPrtialLazyToolBar:nil];
    [self setFlexDataGrid:nil];
    [super viewDidUnload];
}
@end
