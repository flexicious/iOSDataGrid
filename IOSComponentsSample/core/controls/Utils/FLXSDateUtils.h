
#import "FLXSVersion.h"

@interface FLXSDateUtils : NSObject
{
}

+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second;

+(NSMutableDictionary*)objDaysOfWeek;
+(NSMutableDictionary*)objMonth;

+ (NSString *)removeInvalidDateTimeCharacters:(NSString *)mask pattern:(NSString *)pattern defaultValue:(NSString *)defaultValue;

+ (NSString *)dateTimeFormat:(NSDate *)date mask:(NSString *)mask;

+ (NSString *)timeFormat:(NSDate *)date mask:(NSString *)mask;

+ (NSString *)dateFormat:(NSDate *)date mask:(NSString *)mask;

+ (NSString *)buildDateTime:(NSDate *)date mask:(NSString *)mask pattern:(NSString *)pattern defaultValue:(NSString *)defaultValue;
+(NSString*)buildTimeZoneDesignation:(NSDate*)date;

+ (NSDate *)addDatePart:(NSString *)datePart numberToAdd:(float)number date:(NSDate *)date;
+(float)dayOfWeek:(NSDate*)date;
+(float)dayOfYear:(NSDate*)date;
+(float)weekOfYear:(NSDate*)date;
+(float)toFlexDayOfWeek:(float)localDayOfWeek;

+ (NSDateComponents *)componentsWithDate:(NSDate *)date;

+ (NSDate *)dayOfWeekIterationOfMonth:(float)iteration dayOfWeek:(NSString *)strDayOfWeek date:(NSDate *)date;
+(float)daysInMonth:(NSDate*)date;
+(float)totalDayOfWeekInMonth:(NSString*)strDayOfWeek :(NSDate*)date;
+(float)toFlexMonth:(float)localMonth;
+(NSString*)dayOfWeekAsString:(NSDate*)date;
+(float)dayOfWeekAsNumber:(NSString*)strDayOfWeek;
+(NSString*)monthAsString:(NSDate*)date;
+(float)monthAsNumber:(NSString*)strMonth;
+(float)daysInYear:(NSDate*)date;
+(BOOL)isLeapYear:(NSDate*)date;
+(float)dateDiff:(NSString*)datePart withStartDate:(NSDate*)startDate andEndDate:(NSDate*)endDate;
+ (NSDate*) dateFromString:(NSString*)dateStr withFormat:(NSString*)format;
+ (NSString*) dateToString:(NSDate*)date withFormat:(NSString*)format;
+ (NSString*)MONDAY;
+ (NSString*)TUESDAY;
+ (NSString*)WEDNESDAY;
+ (NSString*)THURSDAY;
+ (NSString*)FRIDAY;
+ (NSString*)SATURDAY;
+ (NSString*)SUNDAY;
+ (NSString*)JANUARY;
+ (NSString*)FEBRUARY;
+ (NSString*)MARCH;
+ (NSString*)APRIL;
+ (NSString*)MAY;
+ (NSString*)JUNE;
+ (NSString*)JULY;
+ (NSString*)AUGUST;
+ (NSString*)SEPTEMBER;
+ (NSString*)OCTOBER;
+ (NSString*)NOVEMBER;
+ (NSString*)DECEMBER;
+ (NSString*)YEAR;
+ (NSString*)MONTH;
+ (NSString*)WEEK;
+ (NSString*)DAY_OF_MONTH;
+ (NSString*)HOURS;
+ (NSString*)MINUTES;
+ (NSString*)SECONDS;
+ (NSString*)MILLISECONDS;
+ (NSString*)DAY_OF_WEEK;
+ (float)LAST;
+ (NSString*)SHORT_DATE_MASK;
+ (NSString*)MEDIUM_DATE_MASK;
+ (NSString*)LONG_DATE_MASK;
+ (NSString*)FULL_DATE_MASK;
+ (NSString*)SHORT_TIME_MASK;
+ (NSString*)MEDIUM_TIME_MASK;
+ (NSString*)LONG_TIME_MASK;
+ (NSString*)RFC_822_MASK;

+ (int)SECOND_VALUE;
+ (int)MINUTE_VALUE;
+ (int)HOUR_VALUE;
+ (int)DAY_VALUE;
+ (int)WEEK_VALUE; 
@end

