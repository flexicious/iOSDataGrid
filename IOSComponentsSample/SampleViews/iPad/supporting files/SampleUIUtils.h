
#import "FLXSDemoVersion.h"

@interface SampleUIUtils : NSObject

+(NSNumberFormatter*) getCurrencyFormatter;
+(NSString*) formatCurrency:(float)currency;
+(NSString*) formatDate:(NSDate *)date;

@end