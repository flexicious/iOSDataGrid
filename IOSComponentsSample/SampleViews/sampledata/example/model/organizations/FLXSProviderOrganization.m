#import "FLXSProviderOrganization.h"

@implementation FLXSProviderOrganization

@synthesize paymentAddress;

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
	return [[FLXSProviderOrganization alloc] init];
}

@end

