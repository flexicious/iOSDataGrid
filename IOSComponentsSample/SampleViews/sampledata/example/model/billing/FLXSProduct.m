#import "FLXSProduct.h"


@implementation FLXSProduct

@synthesize name;
@synthesize unitPrice;
@synthesize description;
@synthesize partNumber;

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
	return [[FLXSProduct alloc] init];
}

@end

