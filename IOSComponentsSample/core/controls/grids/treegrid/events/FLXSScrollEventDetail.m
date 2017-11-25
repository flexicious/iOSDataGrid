
#import "FLXSScrollEventDetail.h"


/**
 *  Indicates that the scroll bar has moved down by one page.
 */
 static const NSString* PAGE_DOWN = @"pageDown";

/**
 *  Indicates that the scroll bar has moved left by one page.
 */
 static const NSString* PAGE_LEFT = @"pageLeft";

/**
 *  Indicates that the scroll bar has moved right by one page.
 */
 static const NSString* PAGE_RIGHT = @"pageRight";

/**
 *  Indicates that the scroll bar has moved up by one page.
 */
 static const NSString* PAGE_UP = @"pageUp";

/**
 *  Indicates that the scroll bar thumb has stopped moving.
 */
 static const NSString* THUMB_POSITION = @"thumbPosition";

/**
 *  Indicates that the scroll bar thumb is moving.
 */
 static const NSString* THUMB_TRACK = @"thumbTrack";
/**
 *  Indicates that the scroll bar is moving vertically.
 */
static const NSString* VERTICAL = @"vertical";
/**
 *  Indicates that the scroll bar is moving horizontally.
 */
static const NSString* HORIZONTAL = @"horizontal";


@implementation FLXSScrollEventDetail {

}
+ (NSString*)PAGE_DOWN
{
    return [PAGE_DOWN description];
}
+ (NSString*)PAGE_LEFT
{
    return [PAGE_LEFT description];
}
+ (NSString*)PAGE_RIGHT
{
    return [PAGE_RIGHT description];
}
+ (NSString*)PAGE_UP
{
    return [PAGE_UP description];
}
+ (NSString*)THUMB_POSITION
{
    return [THUMB_POSITION description];
}
+ (NSString*)THUMB_TRACK
{
    return [THUMB_TRACK description];
}
+ (NSString*)VERTICAL
{
    return [VERTICAL description];
}
+ (NSString*)HORIZONTAL
{
    return [HORIZONTAL description];
}

@end