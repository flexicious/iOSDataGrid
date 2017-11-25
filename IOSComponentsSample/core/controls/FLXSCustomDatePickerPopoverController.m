
#import "FLXSUIUtils.h"
#import "FLXSCustomDatePickerPopoverController.h"
#import "FLXSConstants.h"


@interface FLXSCustomDatePickerPopoverController (private)
- (void)btnOkPressed:(id)sender;
@end

@implementation FLXSCustomDatePickerPopoverController {
@private
    UINavigationItem *navItem;
}

@synthesize datePicker, owner;
- (id)init
{
    //build our custom popover view
    UIViewController* popoverContent = [[UIViewController alloc] init];
    UIView* popoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 344)];
    popoverView.backgroundColor = [UIColor whiteColor];
    
    UIDatePicker* odatePicker = [[UIDatePicker alloc] init];
    odatePicker.datePickerMode = UIDatePickerModeDate;
    odatePicker.frame = CGRectMake(0, 44, 300, 300);

    //Nav bar
    UINavigationBar *onavBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0,0, 300, 44)];
    //[navBar setBarStyle:UIBarStyleDefault];
    UINavigationItem* onavItem = [[UINavigationItem alloc] initWithTitle:@"Select Date"];
    UIBarButtonItem *setBtn = [[UIBarButtonItem alloc] initWithTitle:@"Set" style:UIBarButtonItemStyleDone target:self action:@selector(btnOkPressed:)];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(btnCancelPressed:)];
    onavItem.leftBarButtonItem = setBtn;
    onavItem.rightBarButtonItem = cancelBtn;
    [onavBar pushNavigationItem:onavItem animated:NO];
    [popoverView addSubview:onavBar];
    [popoverView addSubview:odatePicker];
    popoverContent.view = popoverView;
    
    //resize the popover view shown
    //in the current view to the view's size
    popoverContent.contentSizeForViewInPopover = CGSizeMake(300, 244);
    
    if (![FLXSUIUtils isIPad]) {
        
        UINavigationController *  navigationController = [[UINavigationController alloc] initWithRootViewController:popoverContent];
        [navigationController setNavigationBarHidden:YES animated:NO ];
        
        self = [super initWithContentViewController:navigationController];
        if (self) {
            // Custom initialization
            self.datePicker=odatePicker;
            navItem=onavItem;
            self.uIDatePickerMode = UIDatePickerModeDateAndTime;
        }
        return self;
//        UIPopoverController* aPopover = [[UIPopoverController alloc]
//                                         initWithContentViewController:popupController];
    }
    else
    {
        self = [super initWithContentViewController:popoverContent];
        if (self) {
            // Custom initialization
            self.datePicker=odatePicker;
            navItem=onavItem;
            self.uIDatePickerMode = UIDatePickerModeDateAndTime;
        }
        return self;
        
    }
}



- (void)setUIDatePickerMode:(UIDatePickerMode)uIDatePickerMode {
    datePicker.datePickerMode = uIDatePickerMode;
    if (uIDatePickerMode==UIDatePickerModeDate)
        [navItem setTitle:@"Select Date"];
    else if (uIDatePickerMode==UIDatePickerModeTime)
        [navItem setTitle:@"Select Time"];
    else if (uIDatePickerMode==UIDatePickerModeDateAndTime)
        [navItem setTitle:@"Select Date/Time"];
    else
        [navItem setTitle:@"Select Date"];
}


- (void)btnOkPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didSetRFDateTimePopover:)])
        [(id)self.delegate didSetRFDateTimePopover:owner];
}

-(void)btnCancelPressed:(id)sender
{
        [self dismissPopoverAnimated:YES];
}

- (NSString *)getDateString
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:[FLXSConstants DATE_FORMAT]];
    NSString *dateString = [dateFormat stringFromDate:datePicker.date];
    return dateString;
}

- (NSString *)getTimeString
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeStyle:NSDateFormatterShortStyle];
    NSString *timeString = [dateFormat stringFromDate:datePicker.date];
    return timeString;
}

@end