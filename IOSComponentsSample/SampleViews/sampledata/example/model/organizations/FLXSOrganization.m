#import "FLXSOrganization.h"
#import "FLXSFlexiciousMockGenerator.h"

@class FLXSFlexiciousMockGenerator;
@implementation FLXSOrganization

@synthesize headquarterAddress;
@synthesize mailingAddress;
@synthesize legalName;
@synthesize url;
@synthesize billingContact;
@synthesize salesContact;
@synthesize annualRevenue;
@synthesize numEmployees;
@synthesize earningsPerShare;
@synthesize lastStockPrice;
@synthesize chartUrl;
@synthesize deals;
@synthesize isActive;
@synthesize headQuartersSameAsMailing;
@synthesize relationshipAmountSaved;

-(float)orgIndex
{
	return [[FLXSFlexiciousMockGenerator simpleList] indexOfObject:self];
}

-(id)init
{
	self = [super init];
	if (self)
	{
		deals = [[NSMutableArray alloc] init];
		isActive = true;
		
	}
	return self;
}


-(float)relationshipAmount
{
	float total=0;
	for(FLXSDeal* deal in deals)
	{
		total+= deal.dealAmount;
	}
	return total;
}

-(FLXSBaseEntity *)createNew
{
	return [[FLXSOrganization alloc] init];
}

-(NSString*)name
{
	return self.legalName;
}

-(NSMutableArray *)children
{
	return self.deals;
}

@end

