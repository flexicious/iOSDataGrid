#import "FLXSBaseEntity.h"
#import "FLXSAddress.h"
#import "FLXSOrganization.h"

@class FLXSOrganization;

@interface FLXSCustomerOrganization : FLXSOrganization
{
}

@property (nonatomic, strong) FLXSAddress * billingAddress;


-(FLXSBaseEntity *)createNew;

@end

