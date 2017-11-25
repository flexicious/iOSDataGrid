#import "FLXSVersion.h"
#import "FLXSEvent.h"
@interface FLXSScrollEvent : FLXSEvent
@property (nonatomic, assign) float delta;
@property (nonatomic, strong) NSString* detail;
@property (nonatomic, strong) NSString* direction;
@property (nonatomic, assign) float position;
+ (NSString*)SCROLL;

@end