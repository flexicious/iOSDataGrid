#import "FLXSAdvancedFilter.h"

static NSString* ALL_ITEM = @"All";

@implementation FLXSAdvancedFilter

@synthesize parentObject;
@synthesize level;

+(FLXSAdvancedFilter*)from:(FLXSFilter*)param
{
	FLXSAdvancedFilter* f=[[FLXSAdvancedFilter alloc] init];
	f.pageIndex=param.pageIndex;
	f.pageSize=param.pageSize;
	f.recordCount=param.recordCount;
    f.pageCount=param.pageCount;
	f.arguments=param.arguments;

	return f;
}

+ (NSString*)ALL_ITEM
{
	return ALL_ITEM;
}
@end

