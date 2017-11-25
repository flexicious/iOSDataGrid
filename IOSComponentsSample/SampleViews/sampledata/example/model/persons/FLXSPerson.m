#import "FLXSPerson.h"


@implementation FLXSPerson

@synthesize firstName;
@synthesize lastName;
@synthesize telephone;
@synthesize homeAddress;

-(NSString*)displayName
{
	return [NSString stringWithFormat:@"%@\t%@", firstName, lastName];

}

-(FLXSBaseEntity *)createNew
{
	return [[FLXSPerson alloc] init];
}

@end

