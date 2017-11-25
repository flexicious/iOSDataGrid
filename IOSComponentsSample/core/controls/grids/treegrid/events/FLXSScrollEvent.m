
#import "FLXSScrollEvent.h"
static const NSString* SCROLL = @"scroll";

@implementation FLXSScrollEvent {

@private
    float _delta;
    NSString *_detail;
    NSString *_direction;
    float _position;
}
@synthesize delta = _delta;
@synthesize detail = _detail;
@synthesize direction = _direction;
@synthesize position = _position;
+ (NSString*)SCROLL
{
    return [SCROLL description];
}
@end