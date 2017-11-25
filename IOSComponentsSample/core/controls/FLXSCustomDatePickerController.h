#import "FLXSConstants.h"
#import "FLXSVersion.h"

#import <UIKit/UIKit.h>
#import "FLXSCustomDatePickerPopoverController.h"
#import "FLXSDateTimeButton.h"
#import "FLXSDateComboBox.h"
@class FLXSDateComboBox;
@interface FLXSCustomDatePickerController : UIViewController<FLXSCustomDatePickerPopoverController,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) FLXSDateComboBox   *comboBox;
@property (weak, nonatomic) IBOutlet FLXSDateTimeButton *btnEndDate;
@property (weak, nonatomic) IBOutlet FLXSDateTimeButton *btnStartDate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCancel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnOk;
@property (weak, nonatomic) IBOutlet UIView *viewPopup;
@property (weak, nonatomic) IBOutlet UIView *viewTransist;

- (IBAction)ButtonStartDatePress:(id)sender;
- (IBAction)btnCancelPressed:(id)sender;
- (IBAction)btnOkPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
