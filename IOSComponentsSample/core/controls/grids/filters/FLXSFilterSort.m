#import "FLXSFilterSort.h"


@implementation FLXSFilterSort

@synthesize columnFLXS;
@synthesize sortColumn;
@synthesize sortCompareFunction;
@synthesize isAscending;
@synthesize sortComparisonType;
@synthesize sortCaseInsensitive;
@synthesize sortNumeric;

- (id)initWithSortColumn:(NSString *)sortColumnIn andIsAscending:(BOOL)isAscendingIn {
	self = [super init];
	if (self)
	{
		self.isAscending = YES;
		self.sortComparisonType = @"auto";
		self.sortCaseInsensitive = NO;
		self.sortNumeric = NO;

		self.sortColumn=sortColumnIn;
		self.isAscending= isAscendingIn;
	}
	return self;
}

-(void)copyFrom:(FLXSFilterSort *)filterSort
{
	self.sortColumn=filterSort.sortColumn;
	self.isAscending = filterSort.isAscending;
	self.sortComparisonType = filterSort.sortComparisonType;
	self.sortCaseInsensitive = filterSort.sortCaseInsensitive;
	self.sortNumeric=filterSort.sortNumeric;
}

@end

