#import "FLXSDateUtils.h"
#import "FLXSCustomDatePickerController.h"

@interface FLXSCustomDatePickerController ()  {
    FLXSCustomDatePickerPopoverController *customDatePickerPopoverController;
    NSInteger   currentIndexPath;
    NSIndexPath *indexpath;
    NSString    *startDate, *endDate;
}

@end

@implementation FLXSCustomDatePickerController
@synthesize btnStartDate, btnEndDate;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    if ([[UIDevice currentDevice] userInterfaceIdiom ] == UIUserInterfaceIdiomPhone)
    {
//        self.viewPopup.layer.borderColor =[UIColor  whiteColor].CGColor;
//        self.viewPopup.layer.borderWidth = 2.0f;
//        self.viewPopup.layer.cornerRadius = 10.0f;
//        self.viewPopup.layer.masksToBounds = YES;
//        self.viewPopup.opaque = YES;
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = [FLXSConstants DATE_FORMAT] ;
        NSString *dateString = [format stringFromDate:[NSDate   date]];
        startDate    = dateString   ;
        dateString   = [format  stringFromDate:[NSDate  dateWithTimeIntervalSinceNow:60*60*24]];
        endDate  = dateString   ;
        [self.datePicker addTarget:self action:@selector(updateLabelFromPicker:) forControlEvents:UIControlEventValueChanged];
    }
    else
    {
        customDatePickerPopoverController =[[FLXSCustomDatePickerPopoverController alloc] init];
    }
    
    [customDatePickerPopoverController setDelegate:self];
    [self.btnStartDate setButtonMode:UIDatePickerModeDate];
    [self.btnEndDate setButtonMode:UIDatePickerModeDate];
}

- (IBAction)ButtonStartDatePress:(id)sender
{
    
    //*************Set default value
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:[FLXSConstants DATE_FORMAT]];
    NSString* strVal = [dateFormat stringFromDate:[NSDate date]];
    [sender setTitle:strVal forState:UIControlStateNormal];
    [customDatePickerPopoverController setOwner:sender];
    
    if (((FLXSDateTimeButton *)sender).buttonMode==UIDatePickerModeDate)
    {
        customDatePickerPopoverController.uIDatePickerMode=UIDatePickerModeDate;
        NSString *curVal = [FLXSConstants DATE_FORMAT];
        if ([sender isKindOfClass:[UIButton class]])
            curVal =  ((UIButton *)sender).titleLabel.text;
        
        if ([curVal caseInsensitiveCompare:[FLXSConstants DATE_FORMAT]]==NSOrderedSame)
            [   customDatePickerPopoverController.datePicker setDate:[NSDate date]];
        else {
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:[FLXSConstants DATE_FORMAT]];
            if([dateFormat dateFromString:curVal] != nil)
                [customDatePickerPopoverController.datePicker setDate:[dateFormat dateFromString:curVal]];
            else
                [customDatePickerPopoverController.datePicker setDate:[NSDate date]];
        }
    }
    else { //Time picker
        customDatePickerPopoverController.uIDatePickerMode=UIDatePickerModeTime;
        NSString *curVal = @"hh:mm";
        if ([sender isKindOfClass:[UIButton class]])
            curVal =  ((UIButton *)sender).titleLabel.text;
        if ([curVal caseInsensitiveCompare:@"hh:mm"]==NSOrderedSame)
            [customDatePickerPopoverController.datePicker setDate:[NSDate date]];
        else {
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"hh:mm"];
            [dateFormat setTimeStyle:NSDateFormatterShortStyle];
            if([dateFormat dateFromString:curVal] != nil)
                [customDatePickerPopoverController.datePicker setDate:[dateFormat dateFromString:curVal]];
            else
                [customDatePickerPopoverController.datePicker setDate:[NSDate date]];
        }
    }
    
    UIView* superView = ((UIView*) sender).superview;
    [customDatePickerPopoverController presentPopoverFromRect:((FLXSDateTimeButton *) sender).frame
                                                       inView:superView
                                     permittedArrowDirections:UIPopoverArrowDirectionAny
                                                     animated:YES];
}

-(IBAction)selectDateForiPhone:(id)sender
{
    
}


- (void)didSetRFDateTimePopover:(id)owner{
    if ([owner isKindOfClass:[UIButton class]])
    {
        if (customDatePickerPopoverController.datePicker.datePickerMode==UIDatePickerModeDate)
            [((UIButton *)owner) setTitle:[customDatePickerPopoverController getDateString] forState:UIControlStateNormal];
        else if (customDatePickerPopoverController.datePicker.datePickerMode==UIDatePickerModeTime)
            [((UIButton *)owner) setTitle:[customDatePickerPopoverController getTimeString] forState:UIControlStateNormal];
        else if (customDatePickerPopoverController.datePicker.datePickerMode==UIDatePickerModeDateAndTime)
            [((UIButton *)owner) setTitle:[customDatePickerPopoverController getDateString] forState:UIControlStateNormal];
        else
            [((UIButton *)owner) setTitle:[customDatePickerPopoverController getDateString] forState:UIControlStateNormal];
    }
    [customDatePickerPopoverController dismissPopoverAnimated:YES];
    
}

- (IBAction)btnOkPressed:(id)sender
{
    /**
    var startDate:Date=dateFieldStartDate.selectedDate;
     var endDate:Date=dateFieldEndDate.selectedDate;
     if(!combo.showTimePicker){
     startDate.setHours(0);
     startDate.setMinutes(0);
     endDate.setHours(23);
     endDate.setMinutes(59);
     }
     startDate.setSeconds(0);
     startDate.setMilliseconds(0);
     endDate.setSeconds(59);
     endDate.setMilliseconds(999);
     dateRange=new DateRange(DateRange.DATE_RANGE_CUSTOM,
     startDate,
     endDate
     );
     combo.customDateRange=dateRange;
     combo.dispatchEvent(new Event(Event.CHANGE));
     PopUpManager.removePopUp(this);
     combo.customDateChosen=true;
     combo=nil;
     }
     }
     private var millisecondsPerDay:int = 1000 * 60 * 60 * 24;
     
     public var dateRange:DateRange;
     [Bindable()]
     * The owner combobox
     */
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([self compareDate] ) {
            [[[UIAlertView alloc]initWithTitle:@"Message!!" message:@"Start and End Dates are required and Start Date should be less than End Date." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show   ];
        }
        else{
            NSDateFormatter *dateFormatter =[[NSDateFormatter    alloc] init];
            //[dateFormatter      setDateStyle:NSDateFormatterShortStyle];
            dateFormatter.dateFormat = [FLXSConstants DATE_FORMAT] ;

            NSDate *dateStart = [dateFormatter dateFromString:startDate ];
            NSDate *dateEnd = [dateFormatter dateFromString:endDate];
            
            NSDateComponents *startComponents = [FLXSDateUtils componentsWithDate:dateStart];
            NSDateComponents *endComponents = [FLXSDateUtils componentsWithDate:dateEnd];
            dateStart  = [FLXSDateUtils dateWithYear:startComponents.year month:startComponents.month day:startComponents.day
                                                hour:0 minute:0 second:0];
            dateEnd= [FLXSDateUtils dateWithYear:endComponents.year month:endComponents.month day:endComponents.day
                                            hour:23 minute:59 second:59];
            
            FLXSDateRange *dateRange = [[FLXSDateRange alloc] initWithDateRangeType:FLXSDateRange
                    .DATE_RANGE_CUSTOM                                 andStartDate:dateStart andEndDate:dateEnd];
            self.comboBox.customDateRange   = dateRange;
            self.comboBox.customDateChosen = YES;
            
            [self.comboBox dispatchEvent:[[FLXSEvent alloc] initWithType:[FLXSComboBox EVENT_CHANGE]
                                                           andCancelable:false
                                                              andBubbles:false] ];
            [self dismissViewControllerAnimated:YES completion:^{
                [self       removeViewFromUIWindow];
            }];
           
            
        }
    
    }
    else{
        if ([self.btnEndDate.titleLabel.text isEqualToString:@"End Date"] || [self.btnStartDate.titleLabel.text isEqualToString:@"Start Date"] || [self compareDate] ) {
            [[[UIAlertView alloc]initWithTitle:@"Message!!" message:@"Start and End Dates are required and Start Date should be less than End Date." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show   ];
        }
        else{
            NSDate *startDate1 = [self       dateFromString:self.btnStartDate.titleLabel.text withFormat:[FLXSConstants DATE_FORMAT]];
            NSDate *endDate1= [self       dateFromString:self.btnEndDate.titleLabel.text withFormat:[FLXSConstants DATE_FORMAT]];
            NSDateComponents *startComponents = [FLXSDateUtils componentsWithDate:startDate1];
            NSDateComponents *endComponents = [FLXSDateUtils componentsWithDate:endDate1];
            startDate1  = [FLXSDateUtils dateWithYear:startComponents.year month:startComponents.month day:startComponents.day
                                                hour:0 minute:0 second:0];
            endDate1= [FLXSDateUtils dateWithYear:endComponents.year month:endComponents.month day:endComponents.day
                                            hour:23 minute:59 second:59];
            
            FLXSDateRange *dateRange = [[FLXSDateRange alloc] initWithDateRangeType:FLXSDateRange
                    .DATE_RANGE_CUSTOM                                 andStartDate:startDate1 andEndDate:endDate1];
            self.comboBox.customDateRange   = dateRange;
            self.comboBox.customDateChosen = YES;
            
            
            
            
            [self.comboBox dispatchEvent:[[FLXSEvent alloc] initWithType:[FLXSComboBox EVENT_CHANGE]
                                                           andCancelable:false
                                                              andBubbles:false] ];
            [self dismissViewControllerAnimated:YES completion:nil];
            [self       removeViewFromUIWindow];
        }
        
    }
}

- (IBAction)btnCancelPressed:(id)sender
{
    [self   dismissViewControllerAnimated:YES completion:^{
       [self       removeViewFromUIWindow];
    }];
}

-(BOOL)compareDate{
    
    NSDateFormatter *dateFormatter =[[NSDateFormatter    alloc] init];
    [dateFormatter      setDateFormat:[FLXSConstants DATE_FORMAT]];
    
    NSDate *dateStart = [dateFormatter dateFromString:self.btnStartDate.titleLabel.text];
    NSDate *dateEnd = [dateFormatter dateFromString:self.btnEndDate.titleLabel.text];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom ] == UIUserInterfaceIdiomPhone)
    {
        dateFormatter.dateFormat = [FLXSConstants DATE_FORMAT] ;
        dateStart = [dateFormatter      dateFromString:startDate];
        dateEnd = [dateFormatter        dateFromString:endDate];
    }
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                        fromDate:dateStart
                                                          toDate:dateEnd
                                                         options:0];
    if ([components day ] <= 0) {
        return YES;
    }
    return NO;
}

-(NSDate*)dateFromString:(NSString*)stringDate withFormat:(NSString*)format
{
    
    NSDateFormatter *dateFormatter =[[NSDateFormatter    alloc] init];
    [dateFormatter      setDateFormat:format    ];
   return  [dateFormatter dateFromString:stringDate ];
}

-(void)removeViewFromUIWindow{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIWindow *window = [FLXSUIUtils getTopLevelWindow];

        NSArray *subViewArray = [window subviews];
        [[subViewArray objectAtIndex:1] removeFromSuperview];

    }
}

#pragma mark- Table View ...

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil)
    {
        cell =[[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CELL"];
    }
    
    cell.selectionStyle =UITableViewCellSelectionStyleBlue;
    

    if (indexPath.row ==0)
    {
        cell.textLabel.text = @"Start Date";
        
        cell.detailTextLabel.text  =startDate   ;
    }
    if (indexPath.row ==1)
    {
        cell.textLabel.text = @"End Date";
        cell.detailTextLabel.text  = endDate    ;
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = [FLXSConstants DATE_FORMAT] ;
    
    NSDate *date = [format      dateFromString:cell.detailTextLabel.text];
    self.datePicker.date = date;

    NSString *dateString = [format stringFromDate:self.datePicker.date];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",dateString];
    
    cell.selectionStyle =UITableViewCellSelectionStyleBlue;
    indexpath = indexPath;
    
    if (indexPath.row ==0)
    {

        currentIndexPath     =0;
        startDate = dateString  ;
    }
    else if (indexPath.row ==1)
    {
        currentIndexPath         = 1;
        endDate     = dateString  ;
    }
}

- (IBAction)updateLabelFromPicker:(id)sender {
    
    
    if (currentIndexPath)
    {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = [FLXSConstants DATE_FORMAT] ;
        NSString *dateString = [format stringFromDate:self.datePicker.date];
        endDate     = dateString;
    }
    else
    {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = [FLXSConstants DATE_FORMAT] ;
        NSString *dateString = [format stringFromDate:self.datePicker.date];
        startDate= dateString;
    }
    
    [self.tableView reloadData];
    [self.tableView selectRowAtIndexPath:indexpath animated:YES scrollPosition:UITableViewScrollPositionNone];
    
}

- (void)viewDidUnload {
    [self setBtnCancel:nil];
    [self setBtnOk:nil];
    [self setViewPopup:nil];
    [self setViewTransist:nil];
    [self setTableView:nil];
    [self setDatePicker:nil];
    [super viewDidUnload];
}
@end
