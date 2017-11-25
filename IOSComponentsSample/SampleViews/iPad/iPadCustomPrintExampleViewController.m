
#import "iPadCustomPrintExampleViewController.h"

@interface iPadCustomPrintExampleViewController ()

@end

@implementation iPadCustomPrintExampleViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *filePath;
    filePath = [[NSBundle mainBundle] pathForResource:@"FLXSSelectionUI1" ofType:@"xml"];
    self.flxsDataGrid.delegate=self;
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    [self.flxsDataGrid buildFromXML:fileData];
}
-(void )cbxNav_changeHandler:(NSNotification*)ns
{
    
}

- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
