#import "FLXSBaseEntity.h"
#import "FLXSAddress.h"
#import "FLXSOrganization.h"

@interface FLXSProviderOrganization : FLXSOrganization
{
}

@property (nonatomic, strong) FLXSAddress * paymentAddress;


-(FLXSBaseEntity *)createNew;

@end

