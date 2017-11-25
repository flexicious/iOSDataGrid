#import "FLXSVersion.h"
#import "FLXSComboBox.h"
#import "FLXSDateRange.h"
#import "FLXSIRangeFilterControl.h"
#import "FLXSCustomDatePickerPopoverController.h"
#import "FLXSCustomDatePickerController.h"
#import "FLXSIDateComboBox.h"

@class FLXSCustomDatePickerController;
@protocol FLXSIDateComboBoxDelegate <NSObject>
@optional
-(void) didSelectIndex:(int)index;
@end

/**
	 * A ComboBox that implements IRangeFilterControl (IFilterControl)
	 * which enables it to be used within the filtering/binding infrasturcture.
	 * @see com.flexicious.controls.interfaces.filters.IFilterControl
	 * @see com.flexicious.controls.interfaces.databindings.IDataBoundControl
	 */
@interface FLXSDateComboBox : FLXSComboBox <FLXSIRangeFilterControl,FLXSIDateComboBox,UITableViewDelegate,UITableViewDataSource, FLXSCustomDatePickerPopoverController, FLXSIDateComboBoxDelegate, FLXSIRangeFilterControl>
{
    id<FLXSIDateComboBoxDelegate> dateComboBoxDelegate;
    FLXSCustomDatePickerPopoverController *customDatePicker;
    FLXSCustomDatePickerController *customDatePickerController;
}

@property (nonatomic, strong)id<FLXSIDateComboBoxDelegate> dateComboBoxDelegate;
@property (nonatomic, strong) FLXSCustomDatePickerController *customDatePickerController;
@property (nonatomic, strong) FLXSDateComboBox *dateComboBox;
@property (nonatomic, strong) UIViewController *controller;

@property (nonatomic, strong) FLXSDateRange * customDateRange;
@property (nonatomic) int millisecondsPerDay;
@property (nonatomic, strong) NSString* prevSelectedValue;
@property (nonatomic) BOOL customDateChosen;
@property (nonatomic, strong) UIView * popup;
@property (nonatomic, strong) NSArray* dateRangeOptions;
@property (nonatomic, strong) NSString* dateFormatString;
@property (nonatomic, strong) NSString* defaultDateRangeForDatePicker;
@property (nonatomic) BOOL showTimePicker;
@property (nonatomic, strong) NSString *styleName;
@property (nonatomic, strong) FLXSDateRange *dateRange;

@property (nonatomic, readonly) NSObject *searchRangeStart;
@property (nonatomic, readonly) NSObject *searchRangeEnd;

-(NSDate*)maxValue;
-(NSDate*)minValue;


@end

