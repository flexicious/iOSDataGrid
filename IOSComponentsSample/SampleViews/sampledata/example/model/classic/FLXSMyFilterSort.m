#import "FLXSMyFilterSort.h"
#import "FLXSDemoVersion.h"


@implementation FLXSMyFilterSort

@synthesize sortColumn;
@synthesize isAscending;

-(id)initWithFilterSort:(FLXSFilterSort*)filterSort
{
	self = [super init];
	if (self)
	{
		self.sortColumn= filterSort.sortColumn;
		self.isAscending= filterSort.isAscending;
	}
	return self;
}


@end

