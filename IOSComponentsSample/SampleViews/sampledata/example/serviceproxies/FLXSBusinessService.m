#import "FLXSBusinessService.h"

static FLXSBusinessService * instance;

@implementation FLXSBusinessService



+(FLXSBusinessService *)getInstance
{
	if (instance == nil)
	{
		instance = [[FLXSBusinessService alloc] init];
	}
	return instance;
}

-(void)getDeepOrgList:(SEL)resultHandler :(NSObject*)target
{
	[self callServiceMethod:([[FLXSFlexiciousMockGenerator instance] getDeepOrgList]) :resultHandler :target];
}

-(void)getFlatOrgList:(SEL)resultHandler :(NSObject*)target
{
	[self callServiceMethod:([[FLXSFlexiciousMockGenerator instance] getFlatOrgList]) :resultHandler :target];
}

-(void)getDeepOrg:(float)orgId :(SEL)resultHandler :(NSObject*)target
{
	[self callServiceMethod:([[FLXSFlexiciousMockGenerator instance] getDeepOrg:orgId]) :resultHandler :target];
}

-(void)getPagedOrganizationList:(FLXSFilter*)filter :(SEL)resultHandler :(NSObject*)target
{
	[self callServiceMethod:([[FLXSFlexiciousMockGenerator instance] getPagedOrganizationList:filter]) :resultHandler :target];
}

-(void)getDealsForOrganization:(float)orgId :(FLXSFilter*)filter :(SEL)resultHandler :(NSObject*)target
{
	[self callServiceMethod:([[FLXSFlexiciousMockGenerator instance] getDealsForOrganization:orgId :filter]) :resultHandler :target];
}

-(void)getInvoicesForDeal:(float)dealId :(FLXSFilter*)filter :(SEL)resultHandler :(NSObject*)target
{
	[self callServiceMethod:([[FLXSFlexiciousMockGenerator instance] getInvoicesForDeal:dealId :filter]) :resultHandler :target];
}

-(void)getLineItemsForInvoice:(float)invoiceId :(FLXSFilter*)filter :(SEL)resultHandler :(NSObject*)target
{
	[self callServiceMethod:([[FLXSFlexiciousMockGenerator instance] getLineItemsForInvoice:invoiceId :filter]) :resultHandler :target];
}

-(void)getAllLineItems:(SEL)resultHandler :(NSObject*)target
{
	[self callServiceMethod:([[FLXSFlexiciousMockGenerator instance] getAllLineItems]) :resultHandler :target];
}

+ (FLXSBusinessService *)instance
{
	return instance;
}
@end

