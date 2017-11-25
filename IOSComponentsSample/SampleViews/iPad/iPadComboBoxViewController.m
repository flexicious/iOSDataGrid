
#import "iPadComboBoxViewController.h"
#import "FLXSEmployee.h"
@interface iPadComboBoxViewController ()

@end

@implementation iPadComboBoxViewController


-(void)showComboBox{
    NSMutableArray* myDataSource = [[NSMutableArray alloc] init];
    [myDataSource addObject:@"one"];
    [myDataSource addObject:@"two"];
    [myDataSource addObject:@"three"];
    [myDataSource addObject:@"four"];
    [myDataSource addObject:@"five"];
    [myDataSource addObject:@"six"];
    [myDataSource addObject:@"seven"];
    [myDataSource addObject:@"eight"];
    [myDataSource addObject:@"nine"];
    [myDataSource addObject:@"ten"];
    [myDataSource addObject:@"eleven"];
    [myDataSource addObject:@"twelve"];
    [myDataSource addObject:@"thirteen"];
    self.flxsComboBox.dataProviderFLXS = myDataSource;
    self.flxsComboBox.addAllItem = YES;
    
    self.flxsComboBox_employee.dataProviderFLXS =[FLXSEmployee employees];
    self.flxsComboBox_employee.labelField=@"displayName";
    self.flxsComboBox_employee.dataFieldFLXS =@"employeeId";
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.backgroundView.layer.cornerRadius=15;
    self.backgroundView.layer.masksToBounds=YES;
    [self showComboBox];
    [self   initializeTitleOfToolBar:@"Combo Box"];

}
- (IBAction)btnSetSelectedValueClickHandler:(id)sender {
    self.flxsComboBox.selectedIndex=2;
}
- (IBAction)btnShowselectedValueClickHandler:(id)sender {
    [FLXSUIUtils showToast:self.flxsComboBox.selectedValue title:@"Selected Value"];
}

- (IBAction)btnClearSelectedValueClickHandler:(id)sender {
    [self.flxsComboBox clear ];
}

- (void)viewDidUnload {
     [self setFlxsComboBox:nil];
    [self setFlxsComboBox_employee:nil];
    [super viewDidUnload];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES; // support all types of orientation
}
@end
