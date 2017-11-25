#import "FLXSAdvancedFilter.h"
#import "FLXSExtendedFilterPageSortChangeEvent.h"

static const NSString* FILTER_PAGE_SORT_CHANGE = @"filterPageSortChange";
static const NSString* FILTER_CHANGE = @"filterChange";
static const NSString* PAGE_CHANGE = @"pageChange";
static const NSString* SORT_CHANGE = @"sortChange";
static NSString* ITEM_LOAD = @"itemLoad";

@implementation FLXSExtendedFilterPageSortChangeEvent {
@private
    NSString *_cause;
}


@synthesize triggerEvent = _triggerEvent;
@synthesize filter = _filter;
@synthesize cause = _cause;

- (id)initWithType:(NSString *)type andFilter:(FLXSAdvancedFilter *)filter andBubbles:(BOOL)bubbles andCancelable:(BOOL)cancelable {
    self = [super initWithType:type andCancelable:cancelable andBubbles:bubbles];
    if (self)
	{
		self.triggerEvent = nil;

		self.filter=filter;
	}
	return self;
}

-(FLXSEvent*)clone
{
    FLXSExtendedFilterPageSortChangeEvent* evt = [[FLXSExtendedFilterPageSortChangeEvent alloc] initWithType:self.type andFilter:self.filter andBubbles:self.bubbles andCancelable:self.cancelable];
	evt.cause=self.cause;
	return evt;
}

+ (NSString*)FILTER_PAGE_SORT_CHANGE
{
	return [FILTER_PAGE_SORT_CHANGE description];
}
+ (NSString*)FILTER_CHANGE
{
	return [FILTER_CHANGE description];
}
+ (NSString*)PAGE_CHANGE
{
	return [PAGE_CHANGE description];
}
+ (NSString*)SORT_CHANGE
{
	return [SORT_CHANGE description];
}

+ (NSString*)ITEM_LOAD
{
    return [ITEM_LOAD description];
}

@end

