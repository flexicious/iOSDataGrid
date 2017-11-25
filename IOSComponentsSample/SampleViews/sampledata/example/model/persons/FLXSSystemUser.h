#import "FLXSBaseEntity.h"
#import "FLXSPerson.h"

@interface FLXSSystemUser : FLXSPerson
{
}

@property (nonatomic, strong) NSString* loginNm;


-(FLXSBaseEntity *)createNew;

@end

