#import "FLXSDeal.h"

@implementation FLXSDeal

@synthesize customer;
@synthesize invoices;
@synthesize dealDate;
@synthesize dealStatus;
@synthesize dealDescription;
@synthesize finalized;
@synthesize provider;
@synthesize dealContacts;

-(float)dealAmount
{
	float total=0;
	for(FLXSInvoice * inv in invoices)
	{
		total+= inv.invoiceAmount;
	}
	return total;
}

-(BOOL)isBillable
{
	return ![dealStatus.code isEqual:@"Prospect"];
}

-(id)init
{
	self = [super init];
	if (self)
	{
		invoices = [[NSMutableArray alloc] init];
		finalized = true;
		
	}
	return self;
}

-(FLXSBaseEntity *)createNew
{
	return [[FLXSDeal alloc] init];
}

-(NSString*)name
{
	return self.dealDescription;
}

-(NSArray *)children
{
	return self.invoices;
}

-(FLXSBaseEntity *)parent
{
	return (FLXSBaseEntity*)self.customer;
}

-(void)parent:(FLXSBaseEntity *)val
{
	self.customer=(FLXSOrganization*)val;
}

@end

