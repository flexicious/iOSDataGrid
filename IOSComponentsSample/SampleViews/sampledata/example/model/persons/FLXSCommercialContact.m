#import "FLXSCommercialContact.h"

@implementation FLXSCommercialContact
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
	return [[FLXSCommercialContact alloc] init];
}
@end

