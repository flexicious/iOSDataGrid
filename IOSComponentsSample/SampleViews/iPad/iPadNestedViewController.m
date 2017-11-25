

#import "iPadNestedViewController.h"
#import "FLXSFlexiciousMockGenerator.h"

@implementation iPadNestedViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.flxsFlexDataGrid.delegate = self;
    [self buildGrid:self.flxsFlexDataGrid FromXmlResource:[FLXSUIUtils isIPad]?@"FLXSNested":@"FLXSNestedIPhone"];
    self.flxsFlexDataGrid.dataProviderFLXS = [[FLXSFlexiciousMockGenerator instance] getDeepOrgList];
    
}

- (void)viewDidUnload {
    self.flxsFlexDataGrid=nil;
    [self setToolBar:nil];
    [super viewDidUnload];
}
-(void)nested_grid_itemDoubleClickHandler:(NSNotification*) ns{
    //FLXSFlexDataGridEvent *event = [ns.userInfo objectForKey:@"event"];
    //[FLXSUIUtils showToast:[@"You double tapped on " stringByAppendingString:event.cell.text] title:@"Double Tap"];
}
-(void)nested_grid_ClickHandler:(NSNotification*) ns{
    //FLXSFlexDataGridEvent *event = [ns.userInfo objectForKey:@"event"];
    //[FLXSUIUtils showToast:[@"You tapped on " stringByAppendingString:event.cell.text] title:@"Tap"];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIDeviceOrientationLandscapeLeft || toInterfaceOrientation == UIDeviceOrientationLandscapeRight) {
        
        CGRect frameToolBar= self.toolBar.frame;
        frameToolBar.size.width = 1024;
        self.toolBar.frame = frameToolBar;
    }
    else{
        CGRect frameToolBar= self.toolBar.frame;
        frameToolBar.size.width = 768;
        self.toolBar.frame = frameToolBar;
    }
}

@end
