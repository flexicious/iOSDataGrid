

#import "iPadColumnWidthModeViewController.h"
#import "FLXSEmployee.h"

@interface iPadColumnWidthModeViewController ()

@end

@implementation iPadColumnWidthModeViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.flxsDataGrid.delegate = self;
   
    
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSColumnWidthMode"];
    [self initializeTitleOfToolBar:@"ColumnWidthMode"];
    
    self.flxsDataGrid.dataProviderFLXS = [FLXSEmployee employees];
}


- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [super viewDidUnload];
}
@end
