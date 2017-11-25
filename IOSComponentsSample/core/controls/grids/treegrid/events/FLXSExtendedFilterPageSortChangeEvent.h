#import "FLXSVersion.h"
#import "FLXSAdvancedFilter.h"
#import "FLXSEvent.h"

/**
	 * A version of the FilterPageSortChangeEvent, however, this one has a advanced filter which
	 * contains the level information in addition to the regular filter.
	 */
@interface FLXSExtendedFilterPageSortChangeEvent : FLXSEvent
{
}
/**
* Event that cused this event to happen. Usually the change event from the filter control
*/
@property (nonatomic, weak) FLXSEvent* triggerEvent;
/**
		 * The filter object that contains all the information about the filter arguments, sorts, etc.
		 */
@property (nonatomic, strong) FLXSAdvancedFilter* filter;
/**
		 * Could be one of three values : filterChange, sortChange, or pageChange.
		 */
@property (nonatomic, strong) NSString* cause;

- (id)initWithType:(NSString *)type andFilter:(FLXSAdvancedFilter *)filter andBubbles:(BOOL)bubbles andCancelable:(BOOL)cancelable;
/**
		 * Creates a new instance of this event.
		 */
-(FLXSEvent*)clone;

+ (NSString*)FILTER_PAGE_SORT_CHANGE;
+ (NSString*)FILTER_CHANGE;
+ (NSString*)PAGE_CHANGE;
+ (NSString*)SORT_CHANGE;
+ (NSString*)ITEM_LOAD;
@end

