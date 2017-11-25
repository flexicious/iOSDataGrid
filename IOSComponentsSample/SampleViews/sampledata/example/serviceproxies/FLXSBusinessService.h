
#import "FLXSFlexiciousMockGenerator.h"
#import "FLXSServiceProxyBase.h"
#import "FLXSBusinessService.h"
#import "FLXSDemoVersion.h"

@interface FLXSBusinessService : FLXSServiceProxyBase
{
}


+(FLXSBusinessService *)getInstance;
-(void)getDeepOrgList:(SEL)resultHandler :(NSObject*)target;
-(void)getFlatOrgList:(SEL)resultHandler :(NSObject*)target;
-(void)getDeepOrg:(float)orgId :(SEL)resultHandler :(NSObject*)target;
-(void)getPagedOrganizationList:(FLXSFilter*)filter :(SEL)resultHandler :(NSObject*)target;
-(void)getDealsForOrganization:(float)orgId :(FLXSFilter*)filter :(SEL)resultHandler :(NSObject*)target;
-(void)getInvoicesForDeal:(float)dealId :(FLXSFilter*)filter :(SEL)resultHandler :(NSObject*)target;
-(void)getLineItemsForInvoice:(float)invoiceId :(FLXSFilter*)filter :(SEL)resultHandler :(NSObject*)target;
-(void)getAllLineItems:(SEL)resultHandler :(NSObject*)target;

+ (FLXSBusinessService *)instance;
@end

