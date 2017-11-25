
#import "FLXSTouchEvent.h"
static NSString * TAP = @"tap";
static NSString * DOUBLE_TAP = @"doubleTap";
static NSString * TOUCH_DOWN = @"touchDown";
static NSString * TOUCH_MOVE = @"touchMove";
static NSString * TOUCH_UP = @"touchUp";


@implementation FLXSTouchEvent {

@private
    float _localX;
    float _localY;
}
@synthesize localX = _localX;
@synthesize localY = _localY;

+ (NSString*)TAP
{
    return TAP;
}

+ (NSString*)DOUBLE_TAP
{
    return DOUBLE_TAP;
}

+ (NSString*)TOUCH_DOWN
{
    return TOUCH_DOWN;
}

+ (NSString*)TOUCH_MOVE
{
    return TOUCH_MOVE;
}
+ (NSString*)TOUCH_UP
{
    return TOUCH_UP;
}
@end