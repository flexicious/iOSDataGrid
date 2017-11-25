#import "FLXSVersion.h"

#import "FLXSEvent.h"


@interface FLXSTouchEvent : FLXSEvent

@property (nonatomic, assign) float localX;
@property (nonatomic, assign) float localY;
+ (NSString*) TAP;
+ (NSString*) DOUBLE_TAP;
+ (NSString*) TOUCH_DOWN;
+ (NSString*) TOUCH_MOVE;
+ (NSString*) TOUCH_UP;
@end