#import "FLXSVersion.h"
#import <UIKit/UIKit.h>

@protocol FLXSCustomDatePickerPopoverController <UIPopoverControllerDelegate>;
- (void)didSetRFDateTimePopover:(id)owner;
@end

@interface FLXSCustomDatePickerPopoverController : UIPopoverController

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, assign) UIDatePickerMode uIDatePickerMode;

@property (nonatomic, assign) UIControl* owner;             //Owner currently support an instance of UIButton class
- (NSString *)getDateString;
- (NSString *)getTimeString;
@end    