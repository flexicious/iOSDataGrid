#import "FLXSMyFilter.h"
#import "FLXSMyFilterExpression.h"
#import "FLXSMyFilterSort.h"
#import "FLXSDemoVersion.h"


@implementation FLXSMyFilter

@synthesize pageSize;
@synthesize pageIndex;
@synthesize pageCount;
@synthesize recordCount;
@synthesize recordType;
@synthesize records;
@synthesize arguments;
@synthesize sorts;

-(id)initWithFilter:(FLXSFilter*)filter
{
	self = [super init];
	if (self)
	{
		pageSize = 20;
		pageIndex = -1;
		arguments = [[NSMutableArray alloc] init];
		sorts = [[NSMutableArray alloc] init];
		
		if(filter!=nil)
		{
			self.pageSize=filter.pageSize;
			self.pageIndex = filter.pageIndex;
			self.pageCount = filter.pageCount;
			self.recordCount=filter.recordCount;
			for(FLXSFilterExpression* arg in filter.arguments)
			{
				[self.arguments addObject:([[FLXSMyFilterExpression alloc] initWithFilterExpression:arg])];
			}
			for(FLXSFilterSort* sort in filter.sorts)
			{
				[self.sorts addObject:([[FLXSMyFilterSort alloc] initWithFilterSort:sort])];
			}
		}
	}
	return self;
}

@end

