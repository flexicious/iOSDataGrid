#import "FLXSPagedResult.h"


@implementation FLXSPagedResult

@synthesize collection;
@synthesize totalRecords;
@synthesize summaryData;

- (id)initWithCollection:(NSMutableArray *)collectionIn andTotalRecords:(float)totalRecordsIn andSummaryData:(NSDictionary *)summaryDataIn andDeepClone:(BOOL)deepClone {
	self = [super init];
	if (self)
	{
		self.collection=[[NSMutableArray alloc] init];
		for(FLXSBaseEntity * entity in collectionIn)
		{
			[self.collection addObject: ([entity clone:deepClone])];
		}
		self.totalRecords=totalRecordsIn;
		self.summaryData=summaryDataIn;
	}
	return self;
}


@end

