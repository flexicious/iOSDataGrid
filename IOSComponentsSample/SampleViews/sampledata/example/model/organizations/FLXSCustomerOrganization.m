#import "FLXSCustomerOrganization.h"

@implementation FLXSCustomerOrganization

@synthesize billingAddress;

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
	return [[FLXSCustomerOrganization alloc] init];
}

@end

