#import "FLXSStringRepo.h"

static NSString* AUTO_REFRESH = @"Auto Refresh";
static NSString* AUTO_REFRESH_LAST_UPDATED_ON = @"Last Updated on";
static NSString* AUTO_REFRESH_DATE_FRMT = @"MM/DD/YYYY JJ:NN";

@implementation FLXSStringRepo



+ (NSString*)AUTO_REFRESH
{
	return AUTO_REFRESH;
}
+ (NSString*)AUTO_REFRESH_LAST_UPDATED_ON
{
	return AUTO_REFRESH_LAST_UPDATED_ON;
}
+ (NSString*)AUTO_REFRESH_DATE_FRMT
{
	return AUTO_REFRESH_DATE_FRMT;
}
@end

