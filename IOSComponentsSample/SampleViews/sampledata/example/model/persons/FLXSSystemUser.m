#import "FLXSSystemUser.h"

@implementation FLXSSystemUser

@synthesize loginNm;

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
	return [[FLXSSystemUser alloc] init];
}

@end

