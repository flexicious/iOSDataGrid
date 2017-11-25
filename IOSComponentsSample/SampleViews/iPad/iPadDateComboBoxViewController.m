

#import "iPadDateComboBoxViewController.h"

@interface iPadDateComboBoxViewController ()

@end

@implementation iPadDateComboBoxViewController



-(void)viewDidLoad{
    [super viewDidLoad];
    self.backgroundView.layer.cornerRadius=15;
    self.backgroundView.layer.masksToBounds=YES;
    [self       initializeTitleOfToolBar:@"Date Combo Box"];

    [self showDateComboBox];
}

- (IBAction)btnShowSelectedValuesClickHandler:(id)sender {
    [FLXSUIUtils showToast:self.flxsDateComboBox.selectedValue title:@"Selected Values"];
}
- (IBAction)btnSetSelectedValuesClickHandler:(id)sender {
    self.flxsDateComboBox.selectedIndex=2;
}
- (IBAction)btnClearSelectedValuesClickHandler:(id)sender {
    [self.flxsDateComboBox clear];
}



-(void)showDateComboBox{
    
   self.flxsDateComboBox.addAllItem = YES;
    [self.flxsDateComboBox addEventListenerOfType:[FLXSDateComboBox EVENT_CHANGE] usingTarget:self withHandler:@selector(onDateComboBoxChange:
    )];
    
}
- (void)onDateComboBoxChange:(NSNotification*)notification {

}
- (void)viewDidUnload {
     [self setBackgroundView:nil];
    [self setFlxsDateComboBox:nil];
    [super viewDidUnload];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES; // support all types of orientation
}
@end
