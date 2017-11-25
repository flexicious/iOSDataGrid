
#import "iPadMultiSelectComboBoxViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FLXSEmployee.h"

@interface iPadMultiSelectComboBoxViewController (){
     UIPopoverController* masterPopOverController;
}

@end

@implementation iPadMultiSelectComboBoxViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.backgroundView.layer.cornerRadius=15;
    self.backgroundView.layer.masksToBounds=YES;
    [self       initializeTitleOfToolBar:@"MultiSelect ComboBox"];

    [self showMultiSelectCombobox];
}


-(void)showMultiSelectCombobox{
   
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
   
    self.flxsMultiSelectComboBox_simple.addAllItem = YES;
    [self.flxsMultiSelectComboBox_simple addEventListenerOfType:[FLXSDateComboBox EVENT_CHANGE] usingTarget:self withHandler:@selector(onCheckBoxListChange:
    )];
    self.flxsMultiSelectComboBox_simple.dataProviderFLXS = myDataSource;
    
    self.flxsMultiSelectComboBox_complex.addAllItem=YES;
    [self.flxsMultiSelectComboBox_complex addEventListenerOfType:[FLXSDateComboBox EVENT_CHANGE] usingTarget:self withHandler:@selector(onCheckBoxListChange:)];
    self.flxsMultiSelectComboBox_complex.labelField=@"displayName";
    self.flxsMultiSelectComboBox_complex.dataFieldFLXS =@"employeeId";
    self.flxsMultiSelectComboBox_complex.dataProviderFLXS =[FLXSEmployee employees];
    
}
- (void)onCheckBoxListChange:(NSNotification*)notification {
    //FLXSEvent *evt = [notification.userInfo valueForKey:@"event"];
    //FLXSCheckBoxList *checkBoxList = (FLXSCheckBoxList *)evt.target;
}
- (IBAction)btnShowSelectedValueClickHandler:(id)sender {
    [FLXSUIUtils showToast:[self.flxsMultiSelectComboBox_simple.selectedValues description] title:@"Selected Values"];
}
- (IBAction)btnSetSelectedValueClickHandler:(id)sender {
    self.flxsMultiSelectComboBox_simple.selectedValues=[[NSMutableArray alloc] initWithObjects:[self.flxsMultiSelectComboBox_simple.dataProviderFLXS objectAtIndex:2],[self.flxsMultiSelectComboBox_simple.dataProviderFLXS objectAtIndex:3], nil];
}
- (IBAction)btnClearSelectedValueClickHandler:(id)sender {
    [self.flxsMultiSelectComboBox_simple clear];
}
- (void)viewDidUnload {
    [self setBackgroundView:nil];
    [self setFlxsMultiSelectComboBox_simple:nil];
    [self setFlxsMultiSelectComboBox_complex:nil];
    [super viewDidUnload];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES; // support all types of orientation
}
@end
