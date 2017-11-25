#import "FLXSDateComboBox.h"
#import "FLXSFilterExpression.h"
#import "FLXSLabelData.h"
#import <QuartzCore/QuartzCore.h>

@implementation FLXSDateComboBox {
 }

@synthesize customDateRange;
@synthesize millisecondsPerDay;
@synthesize prevSelectedValue;
@synthesize customDateChosen=_customDateChosen;
@synthesize popup;
@synthesize dateRangeOptions=_dateRangeOptions;
@synthesize dateFormatString;
@synthesize defaultDateRangeForDatePicker;
@synthesize showTimePicker;
@synthesize dateComboBoxDelegate;
@synthesize customDatePickerController;
@synthesize controller;

-(void)_initWithIcon:(UIImage*)icon{
    [super _initWithIcon:icon];
    customDateRange = [[FLXSDateRange alloc] initWithDateRangeType:[FLXSDateRange.DATE_RANGE_CUSTOM stringByAppendingString:@""]
                                                      andStartDate:[self minValue]
                                                        andEndDate:[self maxValue]];
    millisecondsPerDay = 1000 * 60 * 60 * 24;
    defaultDateRangeForDatePicker = [FLXSDateRange.DATE_RANGE_LAST_7_DAYS stringByAppendingString:@""];
    showTimePicker = NO;
    self.dateFormatString =[FLXSConstants DATE_FORMAT];
    self.dateRangeOptions =[[NSMutableArray alloc] initWithObjects:[FLXSDateRange DATE_RANGE_LAST_SIXTY_MINUTES], [FLXSDateRange DATE_RANGE_LAST_24_HOURS], [FLXSDateRange DATE_RANGE_LAST_7_DAYS], [FLXSDateRange DATE_RANGE_LAST_HOUR], [FLXSDateRange DATE_RANGE_THIS_HOUR], [FLXSDateRange DATE_RANGE_NEXT_HOUR], [FLXSDateRange DATE_RANGE_YESTERDAY], [FLXSDateRange DATE_RANGE_TODAY], [FLXSDateRange DATE_RANGE_TOMORROW], [FLXSDateRange DATE_RANGE_LAST_WEEK], [FLXSDateRange DATE_RANGE_THIS_WEEK], [FLXSDateRange DATE_RANGE_NEXT_WEEK], [FLXSDateRange DATE_RANGE_LAST_MONTH], [FLXSDateRange DATE_RANGE_THIS_MONTH], [FLXSDateRange DATE_RANGE_NEXT_MONTH], [FLXSDateRange DATE_RANGE_LAST_QUARTER], [FLXSDateRange DATE_RANGE_THIS_QUARTER], [FLXSDateRange DATE_RANGE_NEXT_QUARTER], [FLXSDateRange DATE_RANGE_LAST_YEAR], [FLXSDateRange DATE_RANGE_THIS_YEAR], [FLXSDateRange DATE_RANGE_NEXT_YEAR], [FLXSDateRange DATE_RANGE_IN_THE_PAST], [FLXSDateRange DATE_RANGE_IN_THE_FUTURE], [FLXSDateRange DATE_RANGE_CUSTOM], nil];
    self.filterComparisonType=  [FLXSFilterExpression FILTER_COMPARISON_TYPE_DATE];
}


-(void)revertToPrevious
{
	self.selectedValue= prevSelectedValue;
}

-(void)setCustomDateChosen:(BOOL)value
{
    _customDateChosen = value;
    if(([self.selectedValue isEqual: [FLXSDateRange DATE_RANGE_CUSTOM]])
            && customDateRange && customDateRange.startDate && customDateRange.endDate && _customDateChosen)
    {
        NSDateFormatter* df= [[NSDateFormatter alloc] init];
        df.dateFormat = self.dateFormatString? self.dateFormatString: [FLXSConstants DATE_FORMAT] ;
         self.text= [[[df stringFromDate:customDateRange.startDate] stringByAppendingString:@" to "] stringByAppendingString:
            [df stringFromDate:customDateRange.endDate] ];
    }
}
- (void)comboBoxButtonClicked:(id)comboBoxButtonClicked {
    [super comboBoxButtonClicked:comboBoxButtonClicked];
    prevSelectedValue = self.selectedValue;
    self.customDateChosen = NO;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if([self.selectedValue isEqualToString:[FLXSDateRange DATE_RANGE_CUSTOM]])
    {
        if([dateComboBoxDelegate respondsToSelector:@selector(didSelectIndex:)])  {
            [dateComboBoxDelegate didSelectIndex:(int)indexPath.row];
        }
        

        [self   ButtonPressSelectDate];
    }
    else
    {
        self.customDateChosen=NO;
    }
}

-(void)dispatchEvent:(FLXSEvent*)event
{
    if([event.type isEqual: [FLXSEvent EVENT_CHANGE]])
    {
        if([self.selectedValue isEqualToString: [FLXSDateRange DATE_RANGE_CUSTOM]]
                && self.popOverController && self.popOverController.isPopoverVisible)
        {
            //dont dispatch when the popup is visible....
            return;
        }
    }
    [super dispatchEvent:event];
}

-(NSString*)getValue
{
    if([self.selectedValue isEqualToString: [FLXSDateRange DATE_RANGE_CUSTOM]])
    {
        FLXSDateRange * dt= [[FLXSDateRange alloc] initWithDateRangeType:self.defaultDateRangeForDatePicker andStartDate:nil andEndDate:nil];
        NSArray * formatted = @[[FLXSDateRange DATE_RANGE_CUSTOM],
                @"__",
        self.customDateRange.startDate? [FLXSDateUtils dateTimeFormat:self.customDateRange.startDate mask:[FLXSConstants DATE_FORMAT]]
                : [FLXSDateUtils dateTimeFormat:dt.startDate mask:[FLXSConstants DATE_FORMAT]],
        self.customDateRange.endDate? [FLXSDateUtils dateTimeFormat:self.customDateRange.endDate mask:[FLXSConstants DATE_FORMAT]]
                : [FLXSDateUtils dateTimeFormat:dt.endDate mask:[FLXSConstants DATE_FORMAT]]
                ];

        return [formatted componentsJoinedByString:@""];
    }
    else
        return [super getValue];
}


-(void)setValue:(NSString*)val
{
    if([val rangeOfString:[FLXSDateRange DATE_RANGE_CUSTOM]].location==0)
    {
        NSArray* split = [val componentsSeparatedByString:(@"__")];
        if([split count] ==3)
        {
            [super setValue:(split[0])];
            customDateRange.startDate = [FLXSDateUtils dateFromString:split[1] withFormat:[FLXSConstants DATE_FORMAT]];
            customDateRange.endDate = [FLXSDateUtils dateFromString:split[2] withFormat:[FLXSConstants DATE_FORMAT]];
            self.customDateChosen=YES;
        }
        else
        {
            [super setValue:val];
        }
    }
    else
        [super setValue:val];
}

-(FLXSDateRange *)dateRange
{
    if(![self.selectedValue isEqualToString: self.addAllItemText] && ![FLXSUIUtils nullOrEmpty:self.selectedValue])
    {
        if([self.selectedValue isEqualToString:[FLXSDateRange DATE_RANGE_CUSTOM]])
        {
            return (customDateRange.startDate!=nil&&
                    customDateRange.endDate!=nil&&
                    ![customDateRange.startDate isEqualToDate:
            customDateRange.endDate])?customDateRange:nil;
        }
        else
        {
            customDateRange= [[FLXSDateRange alloc] initWithDateRangeType:[FLXSDateRange DATE_RANGE_CUSTOM] andStartDate:nil andEndDate:nil];
            return [[FLXSDateRange alloc] initWithDateRangeType:self.selectedValue andStartDate:nil andEndDate:nil];
        }
    }
    return nil;
}

-(void)setDateRange:(FLXSDateRange *)value
{
    if(value == nil)return;
    for(NSObject* object in self.dataProviderFLXS)
    {
        if([[self itemToLabel:object] isEqualToString:value.dateRangeType])
        {
            self.selectedValue = [self itemToLabel:object];
            break;
        }
    }
}


-(NSObject*)searchRangeStart
{
	return self.dateRange?self.dateRange.startDate:nil;
}

-(NSObject*)searchRangeEnd
{
	return self.dateRange?self.dateRange.endDate:nil;
}

-(NSDate*)maxValue
{
	//I hope the world ends before 2099.
    NSString *dateStr = @"01012099";
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"ddMMyyyy"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    return date;
}

-(NSObject*)minValue
{
    NSString *dateStr = @"01011970";
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"ddMMyyyy"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    return date;
}


-(void)setDateRangeOptions:(NSArray*)val
{
	_dateRangeOptions= [val mutableCopy];
	NSMutableArray* coll=[[NSMutableArray alloc] init];
	for(NSString* dateRange in _dateRangeOptions)
		[coll addObject:[[FLXSLabelData alloc] initWithLabel:dateRange andData:dateRange]];
	self.dataProviderFLXS = coll;
	self.dataProviderFLXS = val;

}


- (void )ButtonPressSelectDate
{
    if ([FLXSUIUtils isIPad])
    {
        controller = [[UIViewController alloc] initWithNibName:nil bundle:nil];
        UIView *masterView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 600,600)];
        controller.view= masterView;
        controller.view.center = CGPointMake(self.center.x, self.center.y);
        [self   addSubview:controller.view];
        if (self.customDatePickerController == nil) {
            self.customDatePickerController =[[FLXSCustomDatePickerController alloc] initWithNibName:@"FLXSCustomSelectDate" bundle:nil];
            self.customDatePickerController.comboBox = self;
        }
        self.customDatePickerController.modalPresentationStyle = UIModalPresentationFormSheet;
        self.customDatePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal; //transition shouldn't matter
        [controller presentViewController:self.customDatePickerController animated:YES completion:nil];
        
        self.customDatePickerController.view.superview.frame = CGRectMake(0,400, 500, 250);//it's important to do this after
        self.customDatePickerController.view.superview.center = CGPointMake(roundf(self.center.x), roundf(self.center.y));
        [controller.view  removeFromSuperview];
    
    }
    else
    {
        CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
        controller = [[UIViewController alloc] initWithNibName:nil bundle:nil];
        UIView *masterView = [[UIView alloc] initWithFrame:mainFrame];
        [masterView  setBackgroundColor:[UIColor blackColor]];
        [masterView     setAlpha:0.6];
        controller.view= masterView;
        controller.view.tag = 100;
        [self   addSubview:controller.view];

        UIWindow *window = [FLXSUIUtils getTopLevelWindow];
        [window addSubview:controller.view];
        
        if (self.customDatePickerController == nil) {
            
            if (mainFrame.size.height >500) {
                self.customDatePickerController =[[FLXSCustomDatePickerController alloc] initWithNibName:@"FLXSCustomSelectDate_iPhone5" bundle:nil];
            }else{
                self.customDatePickerController =[[FLXSCustomDatePickerController alloc] initWithNibName:@"FLXSCustomSelectDate_iPhone4" bundle:nil];
            }
            
            self.customDatePickerController.view.frame = mainFrame;
            self.customDatePickerController.comboBox = self;
        }
        
        [controller presentViewController:self.customDatePickerController animated:YES completion:nil];
        
        [controller.view  removeFromSuperview];


    }
    
    
}


- (void)didSetRFDateTimePopover:(id)owner{
    if ([owner isKindOfClass:[UIButton class]])
    {
        if (customDatePicker.datePicker.datePickerMode==UIDatePickerModeDate)
            [((UIButton *)owner) setTitle:[customDatePicker getDateString] forState:UIControlStateNormal];
        else if (customDatePicker.datePicker.datePickerMode==UIDatePickerModeTime)
            [((UIButton *)owner) setTitle:[customDatePicker getTimeString] forState:UIControlStateNormal];
        else if (customDatePicker.datePicker.datePickerMode==UIDatePickerModeDateAndTime)
            [((UIButton *)owner) setTitle:[customDatePicker getDateString] forState:UIControlStateNormal];
        else
            [((UIButton *)owner) setTitle:[customDatePicker getDateString] forState:UIControlStateNormal];
    }
    [customDatePicker dismissPopoverAnimated:YES];
    
}


@end

