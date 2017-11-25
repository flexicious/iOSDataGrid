#import "FLXSDateUtils.h"

static NSString * MONDAY = @"monday";
static NSString * TUESDAY = @"tuesday";
static NSString * WEDNESDAY = @"wednesday";
static NSString * THURSDAY = @"thursday";
static NSString * FRIDAY = @"friday";
static NSString * SATURDAY = @"saturday";
static NSString * SUNDAY = @"sunday";
static NSString * JANUARY = @"january";
static NSString * FEBRUARY = @"february";
static NSString * MARCH = @"march";
static NSString * APRIL = @"april";
static NSString * MAY = @"may";
static NSString * JUNE = @"june";
static NSString * JULY = @"july";
static NSString * AUGUST = @"august";
static NSString * SEPTEMBER = @"september";
static NSString * OCTOBER = @"october";
static NSString * NOVEMBER = @"november";
static NSString * DECEMBER = @"december";
static NSString * YEAR = @"fullYear";
static NSString * MONTH = @"month";
static NSString * WEEK = @"week";
static NSString * DAY_OF_MONTH = @"date";
static NSString * HOURS = @"hours";
static NSString * MINUTES = @"minutes";
static NSString * SECONDS = @"seconds";
static NSString * MILLISECONDS = @"milliseconds";
static NSString * DAY_OF_WEEK = @"day";
static const float LAST = -1;
static NSString * SHORT_DATE_MASK = @"MM/DD/YY";
static NSString * MEDIUM_DATE_MASK = @"MMM D, YYYY";
static NSString * LONG_DATE_MASK = @"MMMM D, YYYY";
static NSString * FULL_DATE_MASK = @"EEEE, MMMM D, YYYY";
static NSString * SHORT_TIME_MASK = @"L:NN A";
static NSString * MEDIUM_TIME_MASK = @"L:NN:SS A";
static NSString * LONG_TIME_MASK = @"L:NN:SS A TZD";
static NSString * RFC_822_MASK = @"yyyy-MM-dd'T'HH:mm:ssZZZ";

static const int SECOND_VALUE = 1000;
static const int MINUTE_VALUE = 1000 * 60;
static const int HOUR_VALUE = 1000 * 60 * 60;
static const int DAY_VALUE =  1000 * 60 * 60* 24;
static const int WEEK_VALUE = 1000 * 60 * 60* 24 * 7;
static NSMutableDictionary* _objDaysOfWeek = nil;
static NSMutableDictionary* _objMonth = nil;

@implementation FLXSDateUtils



+(NSObject*)objDaysOfWeek
{
	if ( !_objDaysOfWeek )
	{
		_objDaysOfWeek = [[NSMutableDictionary alloc] init];
		_objDaysOfWeek[ [FLXSDateUtils SUNDAY] ]= [NSNumber numberWithInteger:0];
		_objDaysOfWeek[ [FLXSDateUtils MONDAY] ]= [NSNumber numberWithInteger:1];
		_objDaysOfWeek[ [FLXSDateUtils TUESDAY] ]= [NSNumber numberWithInteger:2];
		_objDaysOfWeek[ [FLXSDateUtils WEDNESDAY] ]= [NSNumber numberWithInteger:3];
		_objDaysOfWeek[ [FLXSDateUtils THURSDAY] ]= [NSNumber numberWithInteger:4];
		_objDaysOfWeek[ [FLXSDateUtils FRIDAY] ]= [NSNumber numberWithInteger:5];
		_objDaysOfWeek[ [FLXSDateUtils SATURDAY] ]= [NSNumber numberWithInteger:6];
	}
	return _objDaysOfWeek;
}

+(NSObject*)objMonth
{
	if ( !_objMonth )
	{
		_objMonth = [[NSMutableDictionary alloc] init];
        _objMonth[ [FLXSDateUtils JANUARY] ]= [NSNumber numberWithInteger:0];
		_objMonth[ [FLXSDateUtils FEBRUARY] ]= [NSNumber numberWithInteger:1];
		_objMonth[ [FLXSDateUtils MARCH] ]= [NSNumber numberWithInteger:2];
		_objMonth[ [FLXSDateUtils APRIL] ]= [NSNumber numberWithInteger:3];
		_objMonth[ [FLXSDateUtils MAY] ]= [NSNumber numberWithInteger:4];
		_objMonth[ [FLXSDateUtils JUNE] ]= [NSNumber numberWithInteger:5];
		_objMonth[ [FLXSDateUtils JULY] ]= [NSNumber numberWithInteger:6];
		_objMonth[ [FLXSDateUtils AUGUST] ]= [NSNumber numberWithInteger:7];
		_objMonth[ [FLXSDateUtils SEPTEMBER] ]= [NSNumber numberWithInteger:8];
		_objMonth[ [FLXSDateUtils OCTOBER] ]= [NSNumber numberWithInteger:9];
		_objMonth[ [FLXSDateUtils NOVEMBER] ]= [NSNumber numberWithInteger:10];
		_objMonth[ [FLXSDateUtils DECEMBER] ]= [NSNumber numberWithInteger:11];
	}
	return _objMonth;
}

-(id)init
{
	self = [super init];
	if (self)
	{
	}
	return self;
}
+(NSDate *)dateFromString:(NSString *)dateStr withFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter dateFromString:dateStr];
}
+(NSString *)dateToString:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter stringFromDate:date];
}

+ (NSString *)removeInvalidDateTimeCharacters:(NSString *)mask pattern:(NSString *)pattern defaultValue:(NSString *)defaultValue {
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];

    // test for invalid date and time characters
	if ([regex matchesInString:mask options:0 range:NSMakeRange(0, [mask length])])
	{
		// if user is passing an invalid mask, default to defaultValue
		mask = defaultValue;
	}
	// temporarily replace TZD with lowercase tzd for replacing later
	return [mask stringByReplacingOccurrencesOfString:@"TZD" withString:@"tzd"];
}

+ (NSString *)dateTimeFormat:(NSDate *)date mask:(NSString *)mask {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:mask];
    return [dateFormat stringFromDate:date];

    
//	return [self buildDateTime:date mask:mask pattern:(@"(Y|M|D|E|A|J|H|K|L|N|S|TZD|\\W)+") defaultValue:[[[FLXSDateUtils SHORT_DATE_MASK] stringByAppendingString:@ " "] stringByAppendingString:[FLXSDateUtils SHORT_TIME_MASK]]];
}

+ (NSString *)timeFormat:(NSDate *)date mask:(NSString *)mask {
	return [self buildDateTime:date mask:mask pattern:(@"(A|:|J|H|K|L|N|S|TZD|\\s)+") defaultValue:[FLXSDateUtils SHORT_TIME_MASK]];
}

+ (NSString *)dateFormat:(NSDate *)date mask:(NSString *)mask {
	return [self buildDateTime:date mask:mask pattern:(@"(Y|M|D|E|\\W)+") defaultValue:[FLXSDateUtils SHORT_DATE_MASK]];
}

+ (NSString *)buildDateTime:(NSDate *)date mask:(NSString *)mask pattern:(NSString *)pattern defaultValue:(NSString *)defaultValue {
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"TZD"
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = [self removeInvalidDateTimeCharacters:mask pattern:pattern defaultValue:defaultValue];
    NSMutableString  * dateStr= [NSMutableString stringWithString:[dateFormatter stringFromDate:date]];
    [regex replaceMatchesInString:dateStr options:0 range:NSMakeRange(0, [dateStr length]) withTemplate:nil];
    return dateStr;
}

+(NSInteger)getTimezoneOffset:(NSDate*)date
{
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    return [destinationTimeZone secondsFromGMTForDate:date] / 60;
}
+(NSString*)buildTimeZoneDesignation:(NSDate*)date
{
	if ( !date )
	{
		return @"";
	}
	NSString* timeZoneAsString = @"GMT ";
	// timezoneoffset is the number that needs to be added to the local time to get to GMT, so
	// a positive number would actually be GMT -X hours
	if ( [FLXSDateUtils getTimezoneOffset:date] / 60 > 0 && [FLXSDateUtils getTimezoneOffset:date] / 60 < 10 )
	{
        timeZoneAsString  = [[timeZoneAsString stringByAppendingString: @"-0"] stringByAppendingFormat:@"%d",  ([FLXSDateUtils getTimezoneOffset:date] / 60)];
	}
	else if ( [FLXSDateUtils getTimezoneOffset:date] < 0 && [FLXSDateUtils getTimezoneOffset:date] / 60 > -10 )
	{
        timeZoneAsString  = [[timeZoneAsString stringByAppendingString: @"0"] stringByAppendingFormat:@"%d",  (-1 *[FLXSDateUtils getTimezoneOffset:date] / 60)];
	}
	// add zeros to match standard format
    timeZoneAsString=[timeZoneAsString stringByAppendingString:@"00"];
	return timeZoneAsString;
}

+ (NSDate *)addDatePart:(NSString *)datePart numberToAdd:(float)number date:(NSDate *)date {
	NSDate* _returnDate;// = [[NSDate alloc] initWithTimeInterval:0 sinceDate: date ];
//
//	switch ( datePart )
//	{
//		case [FLXSDateUtils YEAR]:case [FLXSDateUtils MONTH]:case [FLXSDateUtils DAY_OF_MONTH]:case [FLXSDateUtils HOURS]:case [FLXSDateUtils MINUTES]:case [FLXSDateUtils SECONDS]:case [FLXSDateUtils MILLISECONDS]:_returnDate[ datePart ] += number;
//		break;
//		case [FLXSDateUtils WEEK]:_returnDate[ [FLXSDateUtils DAY_OF_MONTH] ] += number * 7;
//		break;
//		default:/* Unknown date part, do nothing. */
//		break;
//	}
    NSDateComponents* dateComponents = [[NSDateComponents alloc]init];
    NSCalendar* calendar = [NSCalendar currentCalendar];

    if([datePart isEqualToString:[FLXSDateUtils YEAR]]){
        [dateComponents setYear:number];
    }else if([datePart isEqualToString:[FLXSDateUtils MONTH]]){
        [dateComponents setMonth:number];
    }else if([datePart isEqualToString:[FLXSDateUtils DAY_OF_MONTH]]){
        [dateComponents setDay:number];
    }
    else if([datePart isEqualToString:[FLXSDateUtils HOURS]]){
        [dateComponents setHour:number];
    }
    else if([datePart isEqualToString:[FLXSDateUtils MINUTES]]){
        [dateComponents setMinute:number];
    }
    else if([datePart isEqualToString:[FLXSDateUtils SECONDS]]){
        [dateComponents setSecond:number];
    }
    else if([datePart isEqualToString:[FLXSDateUtils MILLISECONDS]]){
        [dateComponents setSecond:number/1000];
    }
    else if([datePart isEqualToString:[FLXSDateUtils WEEK]]){
        [dateComponents setDay:number * 7];
    }
    _returnDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
	return _returnDate;
}

+(float)dayOfWeek:(NSDate*)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];

    NSInteger weekday = [weekdayComponents weekday];
    return weekday;
}

+(float)dayOfYear:(NSDate*)date
{
    NSCalendar *gregorian =
            [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger dayOfYear =
            [gregorian ordinalityOfUnit:NSDayCalendarUnit
                                 inUnit:NSYearCalendarUnit forDate:[NSDate date]];
    return dayOfYear;

}

+(float)weekOfYear:(NSDate*)date
{
	return ceil( [FLXSDateUtils dayOfYear:date] / 7 );
}

+(float)toFlexDayOfWeek:(float)localDayOfWeek
{
	return ( localDayOfWeek > 0 && localDayOfWeek < 8 ) ? localDayOfWeek - 1 : 0;
}
+ (NSDateComponents *)componentsWithDate:(NSDate *)date{
  return [[NSCalendar currentCalendar]
          components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit
                  | NSSecondCalendarUnit
            fromDate:date];
}

+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    [components setHour:hour];
    [components setMinute: minute];
    [components setSecond:second];
    return [calendar dateFromComponents:components];
}

+ (NSDate *)dayOfWeekIterationOfMonth:(float)iteration dayOfWeek:(NSString *)strDayOfWeek date:(NSDate *)date {
	// get the numeric day of the week for the requested day
	float _dayOfWeek = [self dayOfWeekAsNumber: strDayOfWeek ];
    NSDateComponents *now = [FLXSDateUtils componentsWithDate:date];
	// get the date for the first of the month
	NSDate* _firstOfMonth = [FLXSDateUtils dateWithYear:[now year] month:[now month] day:1 hour:0 minute:0 second:0];
	// calculate how many days to add to get to the requested day from the first of the month
	float _daysToAdd = _dayOfWeek - [FLXSDateUtils dayOfWeek:_firstOfMonth];
	// if dayOfWeek is before the first of the month, get the dayOfWeek for the following week
	if ( _daysToAdd < 0 )
	{
		_daysToAdd += 7;
	}
	// set the date to the first day of the week for the requested date
	NSDate* _firstDayOfWeekOfMonth = [FLXSDateUtils addDatePart:[FLXSDateUtils DAY_OF_MONTH] numberToAdd:_daysToAdd date:_firstOfMonth];
	// return the date if iteration is 1
	if ( iteration == 1 )
	{
		return _firstDayOfWeekOfMonth;
	}
	else
	{
		// if requesting an iteration that is more than is in that month or requesting the last day of week of month
		// return last date for that day of week of month
		if ( ( [FLXSDateUtils totalDayOfWeekInMonth:strDayOfWeek :date] < iteration ) || ( iteration == [FLXSDateUtils LAST] ) )
		{
			iteration = [FLXSDateUtils totalDayOfWeekInMonth:strDayOfWeek :date];
		}
		// subtract 1 as it starts from the first dayOfWeek of month
        return [FLXSDateUtils addDatePart:[FLXSDateUtils WEEK] numberToAdd:iteration - 1 date:_firstDayOfWeekOfMonth];
	}
}

+(float)daysInMonth:(NSDate*)date
{
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:date];
    return days.length;
}

+(float)totalDayOfWeekInMonth:(NSString*)strDayOfWeek :(NSDate*)date
{
	NSDate* _startDate = [FLXSDateUtils dayOfWeekIterationOfMonth:1 dayOfWeek:strDayOfWeek date:date];

    NSDateComponents *now = [FLXSDateUtils componentsWithDate:date];

    float _totalDays = [FLXSDateUtils dateDiff:[FLXSDateUtils DAY_OF_MONTH] withStartDate:_startDate andEndDate:[FLXSDateUtils dateWithYear:[now year]
                                                                                                                                      month:[now month]
                                                                                                                                        day:[FLXSDateUtils daysInMonth:date]
                                                                                                                                       hour:0
                                                                                                                                     minute:0
                                                                                                                                     second:0]];

	// have to add 1 because have to include first day that is found i.e. if wed is on 2nd of 31 day month, would total 5, of if wed on 6th, would total 4
	return  floor( _totalDays / 7 ) + 1;
}

+(float)toFlexMonth:(float)localMonth
{
	return ( localMonth > 0 && localMonth < 13 ) ? localMonth - 1 : 0;
}

+(NSString*)dayOfWeekAsString:(NSDate*)date
{
    NSDate *today = [NSDate date];
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
    [myFormatter setDateFormat:@"EEEE"]; // day, like "Saturday"
    [myFormatter setDateFormat:@"c"]; // day number, like 7 for saturday

    NSString *dayOfWeek = [myFormatter stringFromDate:today];
    return dayOfWeek;
}

+(float)dayOfWeekAsNumber:(NSString*)strDayOfWeek
{
    return ([_objDaysOfWeek objectForKey:strDayOfWeek] >=0) ? [[_objDaysOfWeek objectForKey:strDayOfWeek] integerValue] : -1;

    //return ( objDaysOfWeek[ strDayOfWeek ] >= 0 ) ? objDaysOfWeek[ strDayOfWeek ] : -1;
}

+(NSString*)monthAsString:(NSDate*)date
{
	return [FLXSDateUtils dateFormat:date mask:(@"MMMM")];
}

+(float)monthAsNumber:(NSString*)strMonth
{
    return ([_objMonth objectForKey:strMonth] >=0 )? [[_objMonth objectForKey:strMonth] integerValue]: -1;
	//return ( objMonth[ strMonth ] >= 0 ) ? objMonth[ strMonth ] : -1;
}

+(float)daysInYear:(NSDate*)date
{
    NSDateComponents *now = [FLXSDateUtils componentsWithDate:date];
    NSDate * firstOfYear = [FLXSDateUtils dateWithYear:[now year]
                                                 month:[FLXSDateUtils monthAsNumber:[FLXSDateUtils JANUARY]]
                                                   day:1
                                                  hour:0
                                                minute:0
                                                second:0];

    return [FLXSDateUtils dateDiff:[FLXSDateUtils DAY_OF_MONTH]
                     withStartDate:firstOfYear
                        andEndDate:[FLXSDateUtils addDatePart:[FLXSDateUtils YEAR] numberToAdd:1 date:firstOfYear]];
}

+(BOOL)isLeapYear:(NSDate*)date
{
	return [FLXSDateUtils daysInYear:date] > 365;
}

+(float)dateDiff:(NSString*)datePart withStartDate:(NSDate*)startDate andEndDate:(NSDate*)endDate
{
    float _returnValue = 0;
    if ([datePart isEqualToString:[FLXSDateUtils MILLISECONDS]]) {
        _returnValue = [endDate timeIntervalSince1970] - [startDate timeIntervalSince1970];
    } else if ([datePart isEqualToString:[FLXSDateUtils SECONDS]]) {
        _returnValue = floor([FLXSDateUtils dateDiff:[FLXSDateUtils MILLISECONDS] withStartDate:startDate andEndDate:endDate] / [FLXSDateUtils SECOND_VALUE]);
    } else if ([datePart isEqualToString:[FLXSDateUtils MINUTES]]) {
        _returnValue = floor([FLXSDateUtils dateDiff:[FLXSDateUtils MILLISECONDS] withStartDate:startDate andEndDate:endDate] / [FLXSDateUtils MINUTE_VALUE]);
    } else if ([datePart isEqualToString:[FLXSDateUtils HOURS]]) {
        _returnValue = floor([FLXSDateUtils dateDiff:[FLXSDateUtils MILLISECONDS] withStartDate:startDate andEndDate:endDate] / [FLXSDateUtils HOUR_VALUE]);
    } else if ([datePart isEqualToString:[FLXSDateUtils DAY_OF_MONTH]]) {
        _returnValue = floor([FLXSDateUtils dateDiff:[FLXSDateUtils MILLISECONDS] withStartDate:startDate andEndDate:endDate] / [FLXSDateUtils DAY_VALUE]);
    } else if ([datePart isEqualToString:[FLXSDateUtils WEEK]]) {
        _returnValue = floor([FLXSDateUtils dateDiff:[FLXSDateUtils MILLISECONDS] withStartDate:startDate andEndDate:endDate] / [FLXSDateUtils WEEK_VALUE]);
    } else if ([datePart isEqualToString:[FLXSDateUtils MONTH]]) {
        if ([FLXSDateUtils dateDiff:[FLXSDateUtils MILLISECONDS] withStartDate:startDate andEndDate:endDate] < 0) {
            _returnValue -= [FLXSDateUtils dateDiff:[FLXSDateUtils MONTH] withStartDate:endDate andEndDate:startDate];
        }
        else {
            // get number of months based upon years
            _returnValue = [FLXSDateUtils dateDiff:[FLXSDateUtils YEAR] withStartDate:startDate andEndDate:endDate] * 12;
            NSDateComponents *startDateComponents = [FLXSDateUtils componentsWithDate:startDate];
            NSDateComponents *endDateComponents = [FLXSDateUtils componentsWithDate:endDate];

            // subtract months then perform test to verify whether to subtract one month or not
            // the check below gets the correct starting number of [self months:but may need to have one month removed after check]
            if ([endDateComponents month] != [startDateComponents month]) {
                _returnValue += ([endDateComponents month] <= [startDateComponents month]) ? 12 - [startDateComponents month] + [endDateComponents month] : [endDateComponents month] - [startDateComponents month];
            }
            // have to perform same checks as YEAR
            // i.e. if end date day is <= start date day, and end date milliseconds < start date milliseconds
            if (([endDateComponents day] < [startDateComponents day]) ||
                    ([endDateComponents day] == [startDateComponents day] &&
                            [endDateComponents second] < [startDateComponents second])) {
                _returnValue -= 1;
            }
        }
    } else if ([datePart isEqualToString:[FLXSDateUtils YEAR]]) {
        // self fixes the previous problem with dates that ran into 2 calendar years
        // previously, if 2 dates were in separate calendar years, but the months were not > 1 year apart, then it was returning too many years
        // e.g. 11/2008 to 2/2009 was returning 1, but should have been returning [self 0:zero]
        // if start date before end date and months are less than 1 year apart, add 1 to year to fix offset issue
        // if end date before start date and months are less than 1 year apart, subtract 1 year to fix offset issue
        // added month and milliseconds check to make sure that a date that was e.g. 9/11/07 9:15AM would not return 1 year if the end date was 9/11/08 9:14AM
        if (_returnValue != 0) {
            NSDateComponents *startDateComponents = [FLXSDateUtils componentsWithDate:startDate];
            NSDateComponents *endDateComponents = [FLXSDateUtils componentsWithDate:endDate];

            // if start date is after end date
            if (_returnValue < 0) {
                // if end date month is >= start date month, and end date day is >= start date day, and end date milliseconds > start date milliseconds
                if (([endDateComponents month] > [startDateComponents month]) ||
                        ([endDateComponents month] == [startDateComponents month] && [endDateComponents day] > [startDateComponents day]) ||
                        ([endDateComponents month] == [startDateComponents month] && [endDateComponents day] == [startDateComponents day] &&
                                [endDateComponents second] > [startDateComponents second])) {
                    _returnValue += 1;
                }
            }
            else {
                // if end date month is <= start date month, and end date day is <= start date day, and end date milliseconds < start date milliseconds
                if (([endDateComponents month] < [startDateComponents month]) ||
                        ([endDateComponents month] == [startDateComponents month] && [endDateComponents day] < [startDateComponents day]) ||
                        ([endDateComponents month] == [startDateComponents month] && [endDateComponents day] == [startDateComponents day] &&
                                [endDateComponents second] < [startDateComponents second])) {
                    _returnValue -= 1;
                }
            }
        }
    }
    return _returnValue;
    NSException *myException = [NSException
            exceptionWithName:@"InvalidArgumentException"
                       reason:[@"Invalid date part type" stringByAppendingString:datePart]
                     userInfo:nil];
    @throw myException;
}

+ (NSString *)MONDAY
{
	return MONDAY;
}
+ (NSString *)TUESDAY
{
	return TUESDAY;
}
+ (NSString *)WEDNESDAY
{
	return WEDNESDAY;
}
+ (NSString *)THURSDAY
{
	return THURSDAY;
}
+ (NSString *)FRIDAY
{
	return FRIDAY;
}
+ (NSString *)SATURDAY
{
	return SATURDAY;
}
+ (NSString *)SUNDAY
{
	return SUNDAY;
}
+ (NSString *)JANUARY
{
	return JANUARY;
}
+ (NSString *)FEBRUARY
{
	return FEBRUARY;
}
+ (NSString *)MARCH
{
	return MARCH;
}
+ (NSString *)APRIL
{
	return APRIL;
}
+ (NSString *)MAY
{
	return MAY;
}
+ (NSString *)JUNE
{
	return JUNE;
}
+ (NSString *)JULY
{
	return JULY;
}
+ (NSString *)AUGUST
{
	return AUGUST;
}
+ (NSString *)SEPTEMBER
{
	return SEPTEMBER;
}
+ (NSString *)OCTOBER
{
	return OCTOBER;
}
+ (NSString *)NOVEMBER
{
	return NOVEMBER;
}
+ (NSString *)DECEMBER
{
	return DECEMBER;
}
+ (NSString *)YEAR
{
	return YEAR;
}
+ (NSString *)MONTH
{
	return MONTH;
}
+ (NSString *)WEEK
{
	return WEEK;
}
+ (NSString *)DAY_OF_MONTH
{
	return DAY_OF_MONTH;
}
+ (NSString *)HOURS
{
	return HOURS;
}
+ (NSString *)MINUTES
{
	return MINUTES;
}
+ (NSString *)SECONDS
{
	return SECONDS;
}
+ (NSString *)MILLISECONDS
{
	return MILLISECONDS;
}
+ (NSString *)DAY_OF_WEEK
{
	return DAY_OF_WEEK;
}
+ (float)LAST
{
	return LAST;
}
+ (NSString *)SHORT_DATE_MASK
{
	return SHORT_DATE_MASK;
}
+ (NSString *)MEDIUM_DATE_MASK
{
	return MEDIUM_DATE_MASK;
}
+ (NSString *)LONG_DATE_MASK
{
	return LONG_DATE_MASK;
}
+ (NSString *)FULL_DATE_MASK
{
	return FULL_DATE_MASK;
}
+ (NSString *)SHORT_TIME_MASK
{
	return SHORT_TIME_MASK;
}
+ (NSString *)MEDIUM_TIME_MASK
{
	return MEDIUM_TIME_MASK;
}
+ (NSString *)LONG_TIME_MASK
{
	return LONG_TIME_MASK;
}

+ (NSString *)RFC_822_MASK
{
    return RFC_822_MASK;
}

+ (int)SECOND_VALUE
{
	return SECOND_VALUE;
}
+ (int)MINUTE_VALUE
{
	return MINUTE_VALUE;
}
+ (int)HOUR_VALUE
{
	return HOUR_VALUE;
}
+ (int)DAY_VALUE
{
	return DAY_VALUE;
}
+ (int)WEEK_VALUE
{
	return WEEK_VALUE;
}
@end

