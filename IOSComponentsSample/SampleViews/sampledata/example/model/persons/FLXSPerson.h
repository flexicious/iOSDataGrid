#import "FLXSBaseEntity.h"
#import "FLXSAddress.h"

@interface FLXSPerson : FLXSBaseEntity
{
}

@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic, strong) NSString* telephone;
@property (nonatomic, strong) FLXSAddress * homeAddress;

-(NSString*)displayName;

-(FLXSBaseEntity *)createNew;

@end

