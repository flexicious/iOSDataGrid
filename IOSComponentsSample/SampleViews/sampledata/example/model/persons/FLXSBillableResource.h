#import "FLXSBaseEntity.h"
#import "FLXSPerson.h"

@interface FLXSBillableResource : FLXSPerson
{
}

@property (nonatomic, assign) float billingRate;
@property (nonatomic, assign) float utilization;
@property (nonatomic, assign) float isCurrentlyUtilized;


-(FLXSBaseEntity *)createNew;

@end

