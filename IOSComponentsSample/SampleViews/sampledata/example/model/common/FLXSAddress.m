#import "FLXSAddress.h"


@implementation FLXSAddress

@synthesize addressType;
@synthesize isPrimary;
@synthesize line1;
@synthesize line2;
@synthesize line3;
@synthesize city;
@synthesize state;
@synthesize country;
@synthesize postalCode;

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
	return [[FLXSAddress alloc] init];
}
-(NSString *)concatenatedAddress{
       return [NSString stringWithFormat:@"%@,%@,%@,%@,%@",line1,line2,city.name , state.name ,country.name];
    
}
@end

