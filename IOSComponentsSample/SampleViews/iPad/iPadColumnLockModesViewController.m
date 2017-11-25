

#import "iPadColumnLockModesViewController.h"
#import "FLXSFlexiciousMockGenerator.h"

@interface iPadColumnLockModesViewController ()

@end

@implementation iPadColumnLockModesViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.flxsDataGrid.delegate = self;
       
    [self buildGrid:self.flxsDataGrid FromXmlResource:[FLXSUIUtils isIPad]?@"FLXSColumnLockModes":@"FLXSColumnLockModesIPhone"];
    [self initializeTitleOfToolBar:@"Column Lock Modes"];
    self.flxsDataGrid.dataProviderFLXS = [[FLXSFlexiciousMockGenerator instance] getFlatOrgList];
}
-(void)button1_clickHandler:(NSNotification*)ns
{
    [self.flxsDataGrid invalidateCells];
}
- (void)viewDidUnload {
    [self setIPadToolBar:nil];
    [self setFlxsDataGrid:nil];
    [super viewDidUnload];
}
@end
