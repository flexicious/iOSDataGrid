#import "FLXSDateUtils.h"
#import "FLXSVersion.h"


@interface FLXSDateRange : NSObject
{

}

@property (nonatomic, strong) NSDate* startDate;
@property (nonatomic, strong) NSDate* endDate;
@property (nonatomic, strong) NSString* dateRangeType;
@property (nonatomic) BOOL showTimePicker;

-(id)initWithDateRangeType:(NSString *)dateRangeType andStartDate:(NSDate *)startDate andEndDate:(NSDate*)endDate;
-(NSString *) getStringDateRange;

+ (NSDate *)getStartOfQuarter:(int)year quarter:(int)quarter;

+ (NSDate *)getEndOfQuarter:(int)year quarter:(int)quarter;

+ (NSString *)DATE_RANGE_LAST_SIXTY_MINUTES;
+ (NSString *)DATE_RANGE_LAST_12_HOURS;
+ (NSString *)DATE_RANGE_LAST_24_HOURS;
+ (NSString *)DATE_RANGE_LAST_7_DAYS;
+ (NSString *)DATE_RANGE_THIS_HOUR;
+ (NSString *)DATE_RANGE_LAST_HOUR;
+ (NSString *)DATE_RANGE_NEXT_HOUR;
+ (NSString *)DATE_RANGE_TODAY;
+ (NSString *)DATE_RANGE_YESTERDAY;
+ (NSString *)DATE_RANGE_TOMORROW;
+ (NSString *)DATE_RANGE_THIS_WEEK;
+ (NSString *)DATE_RANGE_LAST_WEEK;
+ (NSString *)DATE_RANGE_NEXT_WEEK;
+ (NSString *)DATE_RANGE_THIS_MONTH;
+ (NSString *)DATE_RANGE_LAST_MONTH;
+ (NSString *)DATE_RANGE_NEXT_MONTH;
+ (NSString *)DATE_RANGE_THIS_YEAR;
+ (NSString *)DATE_RANGE_LAST_YEAR;
+ (NSString *)DATE_RANGE_NEXT_YEAR;
+ (NSString *)DATE_RANGE_CUSTOM;
+ (NSString *)DATE_RANGE_THIS_QUARTER;
+ (NSString *)DATE_RANGE_NEXT_QUARTER;
+ (NSString *)DATE_RANGE_LAST_QUARTER;
+ (NSString *)DATE_RANGE_IN_THE_PAST;
+ (NSString *)DATE_RANGE_IN_THE_FUTURE;

@end

