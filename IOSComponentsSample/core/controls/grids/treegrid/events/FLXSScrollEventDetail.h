#import "FLXSVersion.h"


@interface FLXSScrollEventDetail : NSObject

/**
 *  Indicates that the scroll bar has moved down by one page.
 */
+ (NSString*)PAGE_DOWN;


/**
 *  Indicates that the scroll bar has moved left by one page.
 */
+ (NSString*)PAGE_LEFT;


/**
 *  Indicates that the scroll bar has moved right by one page.
 */
+ (NSString*)PAGE_RIGHT;


/**
 *  Indicates that the scroll bar has moved up by one page.
 */
+ (NSString*)PAGE_UP;


/**
 *  Indicates that the scroll bar thumb has stopped moving.
 */
+ (NSString*)THUMB_POSITION;


/**
 *  Indicates that the scroll bar thumb is moving.
 */
+ (NSString*)THUMB_TRACK;

/**
 *  Indicates that the scroll bar moved vertically.
 */
+ (NSString*)VERTICAL;


/**
 *  Indicates that the scroll bar moved horizontally.
 */
+ (NSString*)HORIZONTAL;


@end