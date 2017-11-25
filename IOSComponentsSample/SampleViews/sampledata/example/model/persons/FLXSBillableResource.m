#import "FLXSBillableResource.h"

@implementation FLXSBillableResource

@synthesize billingRate;
@synthesize utilization;
@synthesize isCurrentlyUtilized;

-(id)init
{
	self = [super init];
	if (self)
	{
	}
	return self;
}


-(FLXSBaseEntity *)createNew
{
	return [[FLXSBillableResource alloc] init];
}

@end

