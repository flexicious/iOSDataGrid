#import "FLXSVersion.h"
#import "FLXSEvent.h"

@interface FLXSCloseEvent : FLXSEvent
@property (nonatomic,strong) NSString* detail;

+ (NSString *)CLOSE;
+ (NSString *)OK;
+ (NSString *)CANCEL;

@end