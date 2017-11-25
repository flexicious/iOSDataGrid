#import "FLXSDateRange.h"


static NSString* DATE_RANGE_LAST_SIXTY_MINTUES = @"Last 60 Minutes";
static NSString* DATE_RANGE_LAST_12_HOURS = @"Last 12 Hours";
static NSString* DATE_RANGE_LAST_24_HOURS = @"Last 24 Hours";
static NSString* DATE_RANGE_LAST_7_DAYS = @"Last 7 Days";
static NSString* DATE_RANGE_THISHOUR = @"This Hour";
static NSString* DATE_RANGE_LASTHOUR = @"Last Hour";
static NSString* DATE_RANGE_NEXTHOUR = @"Next Hour";
static NSString* DATE_RANGE_TODAY = @"Today";
static NSString* DATE_RANGE_YESTERDAY = @"Yesterday";
static NSString* DATE_RANGE_TOMORROW = @"Tomorrow";
static NSString* DATE_RANGE_THISWEEK = @"This Week";
static NSString* DATE_RANGE_LASTWEEK = @"Last Week";
static NSString* DATE_RANGE_NEXTWEEK = @"Next Week";
static NSString* DATE_RANGE_THISMONTH = @"This Month";
static NSString* DATE_RANGE_LASTMONTH = @"Last Month";
static NSString* DATE_RANGE_NEXTMONTH = @"Next Month";
static NSString* DATE_RANGE_THISYEAR = @"This Year";
static NSString* DATE_RANGE_LASTYEAR = @"Last Year";
static NSString* DATE_RANGE_NEXTYEAR = @"Next Year";
static NSString* DATE_RANGE_CUSTOM = @"Custom";
static NSString* DATE_RANGE_THISQUARTER = @"This Quarter";
static NSString* DATE_RANGE_NEXTQUARTER = @"Next Quarter";
static NSString* DATE_RANGE_LASTQUARTER = @"Last Quarter";
static NSString* DATE_RANGE_IN_THE_PAST = @"In the Past";
static NSString* DATE_RANGE_IN_THE_FUTURE = @"In the Future";

@implementation FLXSDateRange

@synthesize startDate;
@synthesize endDate;
@synthesize dateRangeType;
@synthesize showTimePicker;


+ (NSInteger)dayWithDate:(NSDate*) date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger day = [components day];
    return day;
}
-(id)initWithDateRangeType:(NSString *)dateRangeTypeIn andStartDate:(NSDate *)startDateIn andEndDate:(NSDate*)endDateIn
{
	self = [super init];
	if (self)
	{
		self.startDate = [[NSDate alloc] init];
        self.endDate = [[NSDate alloc] init];
        self.dateRangeType = dateRangeTypeIn;
        self.showTimePicker = NO;
		
		
        NSDateComponents *now = [[NSCalendar currentCalendar]
                components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit
                | NSSecondCalendarUnit
                fromDate:[NSDate date]];

        if ([self.dateRangeType isEqual: DATE_RANGE_CUSTOM])
		{
			self.startDate=startDateIn;
			self.endDate=endDateIn;
		}
		else if ([self.dateRangeType isEqual: DATE_RANGE_IN_THE_PAST])
		{
			self.startDate = [FLXSDateUtils dateWithYear:1900 month:1 day:1 hour:0 minute:0 second:0];
			self.endDate = [FLXSDateUtils dateWithYear:[now year] month:[now month] day:[now day] hour:[now hour] minute:59 second:59];
		}
		else if ([self.dateRangeType isEqual: DATE_RANGE_IN_THE_FUTURE])
		{
			self.startDate = [FLXSDateUtils dateWithYear:[now year] month:[now month] day:[now day] hour:[now hour] minute:0 second:0];
			self.endDate = [FLXSDateUtils dateWithYear:2100 month:1 day:1 hour:0 minute:0 second:0];
		}
		else if ([self.dateRangeType isEqual: DATE_RANGE_THISHOUR])
		{
			self.startDate = [FLXSDateUtils dateWithYear:[now year] month:[now month] day:[now day] hour:[now hour] minute:0 second:0];
			self.endDate = [FLXSDateUtils dateWithYear:[now year] month:[now month] day:[now day] hour:[now hour] minute:59 second:59];
		}
		else if ([self.dateRangeType isEqual: DATE_RANGE_LAST_SIXTY_MINTUES])
		{
			self.startDate = [FLXSDateUtils addDatePart:[FLXSDateUtils MINUTES] numberToAdd:(-60) date:([[NSDate alloc] init])];
			self.endDate = [[NSDate alloc] init];
		}
		else if ([self.dateRangeType isEqual: DATE_RANGE_LAST_12_HOURS])
		{
			self.startDate = [FLXSDateUtils addDatePart:[FLXSDateUtils HOURS] numberToAdd:(-12) date:([[NSDate alloc] init])];
			self.endDate = [[NSDate alloc] init];
		}
		else if ([self.dateRangeType isEqual: DATE_RANGE_LAST_24_HOURS])
		{
			self.startDate = [FLXSDateUtils addDatePart:[FLXSDateUtils HOURS] numberToAdd:(-24) date:([[NSDate alloc] init])];
			self.endDate = [[NSDate alloc] init];
		}
		else if ([self.dateRangeType isEqual: DATE_RANGE_LAST_7_DAYS])
		{
			self.startDate = [FLXSDateUtils addDatePart:[FLXSDateUtils DAY_OF_MONTH] numberToAdd:(-7) date:([[NSDate alloc] init])];
			self.endDate = [[NSDate alloc] init];
		}
		else  if ([self.dateRangeType isEqual: DATE_RANGE_LASTHOUR])
		{
			self.startDate = [FLXSDateUtils addDatePart:[FLXSDateUtils HOURS] numberToAdd:(-1) date:[FLXSDateUtils dateWithYear:[now year] month:[now month] day:[now day] hour:[now hour] minute:0 second:0]];
			self.endDate = [FLXSDateUtils addDatePart:[FLXSDateUtils HOURS] numberToAdd:(-1) date:([FLXSDateUtils dateWithYear:[now year] month:[now month] day:[now day] hour:[now hour] minute:59 second:59])];
		}
		else  if ([self.dateRangeType isEqual: DATE_RANGE_NEXTHOUR])
		{
			self.startDate = [FLXSDateUtils addDatePart:[FLXSDateUtils HOURS] numberToAdd:1 date:[FLXSDateUtils dateWithYear:[now year] month:[now month] day:[now day] hour:[now hour] minute:0 second:0]];
			self.endDate = [FLXSDateUtils addDatePart:[FLXSDateUtils HOURS] numberToAdd:1 date:([FLXSDateUtils dateWithYear:[now year] month:[now month] day:[now day] hour:[now hour] minute:59 second:59])];
		}
		else  if ([self.dateRangeType isEqual: DATE_RANGE_TODAY])
		{
			self.startDate = [FLXSDateUtils dateWithYear:[now year] month:[now month] day:[now day] hour:0 minute:0 second:0];
			self.endDate = [FLXSDateUtils dateWithYear:[now year] month:[now month] day:[now day] hour:23 minute:59 second:59];
		}
		else  if ([self.dateRangeType isEqual: DATE_RANGE_YESTERDAY])
		{
			self.startDate = [FLXSDateUtils addDatePart:[FLXSDateUtils HOURS] numberToAdd:(-24) date:([FLXSDateUtils dateWithYear:[now year] month:[now month] day:[now day] hour:0 minute:0 second:0])];
			self.endDate = [FLXSDateUtils addDatePart:[FLXSDateUtils HOURS] numberToAdd:(-24) date:([FLXSDateUtils dateWithYear:[now year] month:[now month] day:[now day] hour:23 minute:59 second:59])];
		}
		else  if ([self.dateRangeType isEqual: DATE_RANGE_TOMORROW])
		{
			self.startDate = [FLXSDateUtils addDatePart:[FLXSDateUtils HOURS] numberToAdd:24 date:([FLXSDateUtils dateWithYear:[now year] month:[now month] day:[now day] hour:0 minute:0 second:0])];
			self.endDate = [FLXSDateUtils addDatePart:[FLXSDateUtils HOURS] numberToAdd:24 date:([FLXSDateUtils dateWithYear:[now year] month:[now month] day:[now day] hour:23 minute:59 second:59])];
		}
		else if ([self.dateRangeType isEqual: DATE_RANGE_THISWEEK] || [self.dateRangeType isEqual: DATE_RANGE_LASTWEEK] || [self.dateRangeType isEqual: DATE_RANGE_NEXTWEEK] )
		{
			self.startDate = [FLXSDateUtils dateWithYear:[now year] month:[now month] day:[now day] hour:0 minute:0 second:0];
			self.endDate = [FLXSDateUtils dateWithYear:[now year] month:[now month] day:[now day] hour:0 minute:0 second:0];
			while ([FLXSDateRange dayWithDate:self.startDate] != 1)
				  self.startDate = [FLXSDateUtils addDatePart:[FLXSDateUtils HOURS] numberToAdd:(-24) date:self.startDate];
			while ([FLXSDateRange dayWithDate:self.endDate] != 0)
				  self.endDate = [FLXSDateUtils addDatePart:[FLXSDateUtils HOURS] numberToAdd:24 date:self.endDate];
			self.endDate = [FLXSDateUtils addDatePart:[FLXSDateUtils MILLISECONDS] numberToAdd:(-1) date:([FLXSDateUtils addDatePart:[FLXSDateUtils HOURS] numberToAdd:24 date:self.endDate])];
			if([self.dateRangeType isEqual: DATE_RANGE_LASTWEEK])
			{
				self.startDate = [FLXSDateUtils addDatePart:[FLXSDateUtils HOURS] numberToAdd:(-24 * 7) date:self.startDate];
				self.endDate = [FLXSDateUtils addDatePart:[FLXSDateUtils HOURS] numberToAdd:(-24 * 7) date:self.endDate];
			}
			else if([self.dateRangeType isEqual: DATE_RANGE_NEXTWEEK])
			{
				self.startDate = [FLXSDateUtils addDatePart:[FLXSDateUtils HOURS] numberToAdd:(24 * 7) date:self.startDate];
				self.endDate = [FLXSDateUtils addDatePart:[FLXSDateUtils HOURS] numberToAdd:(24 * 7) date:self.endDate];
			}
		}
		else  if ([self.dateRangeType isEqual: DATE_RANGE_THISMONTH] || [self.dateRangeType isEqual: DATE_RANGE_LASTMONTH] || [self.dateRangeType isEqual: DATE_RANGE_NEXTMONTH])
		{
			self.startDate = [FLXSDateUtils dateWithYear:[now year] month:[now month] day:1 hour:0 minute:0 second:0];
			self.endDate = [FLXSDateUtils dateWithYear:[now year] month:([now month] + 1) day:0 hour:23 minute:59 second:59];
			//self.endDate = [FLXSDateUtils dateAdd:[FLXSDateUtils HOURS] :(-24) :self.endDate];
			if([self.dateRangeType isEqual: DATE_RANGE_LASTMONTH])
			{
				self.startDate = [FLXSDateUtils dateWithYear:[now year] month:([now month] - 1) day:1 hour:0 minute:0 second:0];
				self.endDate = [FLXSDateUtils dateWithYear:[now year] month:[now month] day:0 hour:23 minute:59 second:59];
			}
			else if([self.dateRangeType isEqual: DATE_RANGE_NEXTMONTH])
			{
				self.startDate = [FLXSDateUtils dateWithYear:[now year] month:([now month] + 1) day:1 hour:0 minute:0 second:0];
				self.endDate = [FLXSDateUtils dateWithYear:[now year] month:([now month] + 2) day:0 hour:23 minute:59 second:59];
			}
		}
		else  if ([self.dateRangeType isEqual: DATE_RANGE_THISQUARTER] || [self.dateRangeType isEqual: DATE_RANGE_LASTQUARTER] || [self.dateRangeType isEqual: DATE_RANGE_NEXTQUARTER])
		{
			int quarter = (int)([now month]) / 3 + 1;
            self.startDate = [FLXSDateRange getStartOfQuarter:(int)[now year] quarter:quarter];
            self.endDate = [FLXSDateRange getEndOfQuarter:(int)[now year] quarter:quarter];
			//self.endDate = [FLXSDateUtils dateAdd:[FLXSDateUtils HOURS] :(-24) :self.endDate];
			if([self.dateRangeType isEqual: DATE_RANGE_LASTQUARTER])
			{
				self.startDate = [FLXSDateRange getStartOfQuarter:(int)[now year] quarter:(quarter - 1)];
				self.endDate = [FLXSDateRange getEndOfQuarter:(int)[now year] quarter:(quarter - 1)];
			}
			else if([self.dateRangeType isEqual: DATE_RANGE_NEXTQUARTER])
			{
				self.startDate = [FLXSDateRange getStartOfQuarter:(int)[now year] quarter:(quarter + 1)];
				self.endDate = [FLXSDateRange getEndOfQuarter:(int)[now year] quarter:(quarter + 1)];
			}
		}
		else  if ([self.dateRangeType isEqual: DATE_RANGE_THISYEAR] || [self.dateRangeType isEqual: DATE_RANGE_LASTYEAR] || [self.dateRangeType isEqual: DATE_RANGE_NEXTYEAR])
		{
			self.startDate = [FLXSDateUtils dateWithYear:[now year] month:0 day:1 hour:0 minute:0 second:0];
			self.endDate = [FLXSDateUtils dateWithYear:[now year] month:11 day:31 hour:23 minute:59 second:59];
			if([self.dateRangeType isEqual: DATE_RANGE_LASTYEAR])
			{
				self.startDate = [FLXSDateUtils dateWithYear:([now year] - 1) month:0 day:1 hour:0 minute:0 second:0];
				self.endDate = [FLXSDateUtils dateWithYear:([now year] - 1) month:11 day:31 hour:23 minute:59 second:59];
			}
			else if([self.dateRangeType isEqual: DATE_RANGE_NEXTYEAR])
			{
				self.startDate = [FLXSDateUtils dateWithYear:([now year] + 1) month:0 day:1 hour:0 minute:0 second:0];
				self.startDate = [FLXSDateUtils dateWithYear:([now year] + 1) month:0 day:1 hour:0 minute:0 second:0];
				self.endDate = [FLXSDateUtils dateWithYear:([now year] + 1) month:11 day:31 hour:23 minute:59 second:59];
			}
		}
		else      {
            NSException* myException = [NSException
                    exceptionWithName:@"InvalidArgumentException"
                               reason:[@"Invalid date range type" stringByAppendingString: ((dateRangeTypeIn ==nil)?@"":dateRangeTypeIn)]
                             userInfo:nil];
            @throw myException;
        }
	}
	return self;
}


+ (NSDate *)getStartOfQuarter:(int)year quarter:(int)quarter {
	if(quarter<1)
	{
		quarter=4;
		year--;
	}
	if(quarter>4)
	{
		quarter=1;
		year++;
	}
	if( quarter == 1)    
		return [FLXSDateUtils dateWithYear:year month:0 day:1 hour:0 minute:0 second:0];
	else if( quarter == 2)
        return [FLXSDateUtils dateWithYear:year month:3 day:1 hour:0 minute:0 second:0];
	else if( quarter == 3)
        return [FLXSDateUtils dateWithYear:year month:6 day:1 hour:0 minute:0 second:0];
	else return [FLXSDateUtils dateWithYear:year month:9 day:1 hour:0 minute:0 second:0];
}

+ (NSDate *)getEndOfQuarter:(int)year quarter:(int)quarter {
	if(quarter<1)
	{
		quarter=4;
		year--;
	}
	if(quarter>4)
	{
		quarter=1;
		year++;
	}
	if( quarter == 1)    
		return [FLXSDateUtils dateWithYear:year month:2 day:([FLXSDateUtils daysInMonth:([FLXSDateUtils dateWithYear:year month:2 day:1 hour:0 minute:0 second:0])]) hour:0 minute:0 second:0];
	else if( quarter == 2)
        return [FLXSDateUtils dateWithYear:year month:5 day:30 hour:23 minute:59 second:59];
	else if( quarter == 3 ) 
        return [FLXSDateUtils dateWithYear:year month:8 day:30 hour:23 minute:59 second:59];
	else 
        return [FLXSDateUtils dateWithYear:year month:11 day:31 hour:23 minute:59 second:59];
}
-(NSString *) getStringDateRange {
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:3];
    [arr addObject:self.dateRangeType];
    [arr addObject:[FLXSDateUtils dateToString:self.startDate withFormat:[FLXSDateUtils RFC_822_MASK]]];
    [arr addObject:[FLXSDateUtils dateToString:self.endDate withFormat:[FLXSDateUtils RFC_822_MASK]]];
    return [arr componentsJoinedByString:@" : "];
}

+ (NSString *)DATE_RANGE_LAST_SIXTY_MINUTES
{
	return DATE_RANGE_LAST_SIXTY_MINTUES;
}
+ (NSString *)DATE_RANGE_LAST_12_HOURS
{
	return DATE_RANGE_LAST_12_HOURS;
}
+ (NSString *)DATE_RANGE_LAST_24_HOURS
{
	return DATE_RANGE_LAST_24_HOURS;
}
+ (NSString *)DATE_RANGE_LAST_7_DAYS
{
	return DATE_RANGE_LAST_7_DAYS;
}
+ (NSString *)DATE_RANGE_THIS_HOUR
{
	return DATE_RANGE_THISHOUR;
}
+ (NSString *)DATE_RANGE_LAST_HOUR
{
	return DATE_RANGE_LASTHOUR;
}
+ (NSString *)DATE_RANGE_NEXT_HOUR
{
	return DATE_RANGE_NEXTHOUR;
}
+ (NSString *)DATE_RANGE_TODAY
{
	return DATE_RANGE_TODAY;
}
+ (NSString *)DATE_RANGE_YESTERDAY
{
	return DATE_RANGE_YESTERDAY;
}
+ (NSString *)DATE_RANGE_TOMORROW
{
	return DATE_RANGE_TOMORROW;
}
+ (NSString *)DATE_RANGE_THIS_WEEK
{
	return DATE_RANGE_THISWEEK;
}
+ (NSString *)DATE_RANGE_LAST_WEEK
{
	return DATE_RANGE_LASTWEEK;
}
+ (NSString *)DATE_RANGE_NEXT_WEEK
{
	return DATE_RANGE_NEXTWEEK;
}
+ (NSString *)DATE_RANGE_THIS_MONTH
{
	return DATE_RANGE_THISMONTH;
}
+ (NSString *)DATE_RANGE_LAST_MONTH
{
	return DATE_RANGE_LASTMONTH;
}
+ (NSString *)DATE_RANGE_NEXT_MONTH
{
	return DATE_RANGE_NEXTMONTH;
}
+ (NSString *)DATE_RANGE_THIS_YEAR
{
	return DATE_RANGE_THISYEAR;
}
+ (NSString *)DATE_RANGE_LAST_YEAR
{
	return DATE_RANGE_LASTYEAR;
}
+ (NSString *)DATE_RANGE_NEXT_YEAR
{
	return DATE_RANGE_NEXTYEAR;
}
+ (NSString *)DATE_RANGE_CUSTOM
{
	return DATE_RANGE_CUSTOM;
}
+ (NSString *)DATE_RANGE_THIS_QUARTER
{
	return DATE_RANGE_THISQUARTER;
}
+ (NSString *)DATE_RANGE_NEXT_QUARTER
{
	return DATE_RANGE_NEXTQUARTER;
}
+ (NSString *)DATE_RANGE_LAST_QUARTER
{
	return DATE_RANGE_LASTQUARTER;
}
+ (NSString *)DATE_RANGE_IN_THE_PAST
{
	return DATE_RANGE_IN_THE_PAST;
}
+ (NSString *)DATE_RANGE_IN_THE_FUTURE
{
	return DATE_RANGE_IN_THE_FUTURE;
}
@end

