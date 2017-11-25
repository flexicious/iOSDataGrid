
#import "iPadLevelItemRenderersViewController.h"
#import "FLXSBusinessService.h"
#import "SampleLevelRendererViewController.h"

@interface iPadLevelItemRenderersViewController (){
    FLXSExtendedFilterPageSortChangeEvent* evt1;
}

@end

@implementation iPadLevelItemRenderersViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.flxsDataGrid.delegate = self;


    [self initializeTitleOfToolBar:@"Inner Level Renderers"];
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSLevelRenderers"];

}
-(void)levelRenderers_creationCompleteHandler:(NSNotification*)ns
{
    evt1 = (FLXSExtendedFilterPageSortChangeEvent*)[ ns.userInfo objectForKey:@"event"];

    [[FLXSBusinessService getInstance] getDeepOrgList:@selector(getDeepOrgList_result:) :self ];
}

-(FLXSClassFactory *)levelRenderers_getNextLevelRenderer
{
    return [[FLXSClassFactory alloc] initWithNibName:@"SampleLevelRendererViewController"
                           andControllerClass:[SampleLevelRendererViewController class]
                               withProperties:nil];

}

-(void)getDeepOrgList_result:(NSArray*) result
{
    [self.flxsDataGrid setDataProviderFLXS:result];
}

- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
