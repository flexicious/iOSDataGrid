#import "FLXSFilterPageSortChangeEvent.h"

static NSString * FILTER_PAGE_SORT_CHANGE = @"filterPageSortChange";
static NSString * FILTER_CHANGE = @"filterChange";
static NSString * PAGE_CHANGE = @"pageChange";
static NSString * SORT_CHANGE = @"sortChange";
static NSString * DESTROY = @"destroy";

@implementation FLXSFilterPageSortChangeEvent

@synthesize filter;
@synthesize triggerEvent;
@synthesize cause;

-(id)initWithType:(NSString*)type :(FLXSFilter *)filterIn :(BOOL)bubbles :(BOOL)cancelable
{
    self = [super initWithType:type andCancelable:cancelable andBubbles:bubbles];
    if (self)
	{
		self.filter=filterIn;
	}
	return self;
}


-(FLXSEvent*)clone
{
	return [[FLXSFilterPageSortChangeEvent alloc] initWithType:self.type :self.filter :self.bubbles :self.cancelable];
}

+ (NSString *)FILTER_PAGE_SORT_CHANGE
{
	return FILTER_PAGE_SORT_CHANGE;
}
+ (NSString *)FILTER_CHANGE
{
	return FILTER_CHANGE;
}
+ (NSString *)PAGE_CHANGE
{
	return PAGE_CHANGE;
}
+ (NSString *)SORT_CHANGE
{
	return SORT_CHANGE;
}
+ (NSString *)DESTROY
{
	return DESTROY;
}
@end

