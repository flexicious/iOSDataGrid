
#import "iPadCustomLoadingSpinnerViewController.h"
#import "FLXSBusinessService.h"

@interface iPadCustomLoadingSpinnerViewController (){
    FLXSEvent* evt;
}

@end

@implementation iPadCustomLoadingSpinnerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)hbox1_creationCompleteHandler:(NSNotification*)ns
{
    evt = (FLXSEvent*)[ ns.userInfo objectForKey:@"event"];

    [self loadData];
}


-(void) checkbox1_changeHandler:(NSNotification*)ns
{
    [self.flxsdataGrid showSpinner:@""];
    [self loadData];
}


-(void)loadData
{
    FLXSFilter* f=[[FLXSFilter alloc] init];
    f.pageIndex=0;
    f.pageSize=self.flxsdataGrid.pageSize;
    [[FLXSBusinessService getInstance] getPagedOrganizationList:f :@selector(getPagedOrganizationList_result:) :self];

}
-(void)getPagedOrganizationList_result:(FLXSPagedResult*)result
{
    self.flxsdataGrid.dataProviderFLXS =result.collection;
    self.flxsdataGrid.totalRecords=result.totalRecords;
    [self.flxsdataGrid hideSpinner];
}

- (void)viewDidUnload {
    [self setFlxsdataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
