#import "FLXSVersion.h"
#import "FLXSFilter.h"
#import "FLXSEvent.h"

/**
	 * Event fired when the filter, page or sort state of the grid changes.
	 */
@interface FLXSFilterPageSortChangeEvent : FLXSEvent
{

}
/**
     *  The filter that is associated with this event.
     */
@property (nonatomic, strong) FLXSFilter * filter;
/**
		 * The original event that triggered the
		 * filter event
		 */
@property (nonatomic, strong) FLXSEvent * triggerEvent;
/**
		 * Whether it was a filter,page or sort that caused this change.
		 */
@property (nonatomic, strong) NSString* cause;

-(id)initWithType:(NSString*)type :(FLXSFilter *)filter :(BOOL)bubbles :(BOOL)cancelable;
/**
		 *  @private
		 */
-(FLXSEvent *)clone;

+ (NSString *)FILTER_PAGE_SORT_CHANGE;
+ (NSString *)FILTER_CHANGE;
+ (NSString *)PAGE_CHANGE;
+ (NSString *)SORT_CHANGE;
+ (NSString *)DESTROY;
@end

