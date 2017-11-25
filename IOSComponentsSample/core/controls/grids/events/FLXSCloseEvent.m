

#import "FLXSCloseEvent.h"


@implementation FLXSCloseEvent {

}
@synthesize detail = _detail;

+ (NSString *)CLOSE
{
    return @"close";
}
+ (NSString *)OK
{
    return @"ok";
}

+ (NSString *)CANCEL
{
    return @"cancel";
}

@end