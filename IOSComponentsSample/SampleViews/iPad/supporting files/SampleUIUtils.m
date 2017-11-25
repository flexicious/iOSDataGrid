
#import "SampleUIUtils.h"

@implementation SampleUIUtils {

}

+(NSNumberFormatter*) getCurrencyFormatter{
    NSNumberFormatter * cf=[[NSNumberFormatter alloc] init];
    cf.maximumFractionDigits=2;
    cf.currencySymbol = @"$";
    cf.numberStyle = NSNumberFormatterCurrencyStyle;
    return cf;

}
+(NSString*) formatCurrency:(float)currency{
    return [[SampleUIUtils getCurrencyFormatter] stringFromNumber:[NSNumber numberWithFloat:currency]];

}
+(NSString*) formatDate:(NSDate *)date{
    return [FLXSDateUtils dateToString:date withFormat:@"MMM-dd-YYYY"];
}

@end