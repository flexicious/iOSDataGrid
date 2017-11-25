#import "FLXSInvoice.h"
#import "FLXSLineItem.h"
#import "FLXSReferenceData.h"

@implementation FLXSInvoice

@synthesize deal;
@synthesize invoiceDate;
@synthesize dueDate;
@synthesize invoiceStatus;
@synthesize lineItems;
@synthesize hasPdf;
@synthesize invoiceSpecificAmount;



-(float)invoiceNumber
{
	return self.id;
}

-(float)invoiceAmount
{
    if(invoiceSpecificAmount>0)return invoiceSpecificAmount;
	float total=0;
	for(FLXSLineItem * lineItem in lineItems)
	{
		total+= lineItem.lineItemAmount;
	}
    invoiceSpecificAmount=total;
	return total;
}
-(void)setInvoiceAmount: (float) amt{
    invoiceSpecificAmount=amt;
}

-(id)init
{
	self = [super init];
	if (self)
	{
		lineItems = [[NSMutableArray alloc] init];
		hasPdf = true;
		
	}
	return self;
}


-(FLXSBaseEntity *)createNew
{
	return [[FLXSInvoice alloc] init];
}

-(NSArray*)children
{
	return self.lineItems;
}

-(FLXSBaseEntity *)parent
{
	return (FLXSBaseEntity *)self.deal;
}

-(void)parent:(FLXSBaseEntity *)val
{
	self.deal=(FLXSDeal*)val;
}

-(NSString*)invoiceStatusName
{
	return self.invoiceStatus.name;
}
-(NSString *)name{
    return [[NSNumber numberWithFloat:self.invoiceNumber] description];
}
-(NSString *)invoiceNumberString{
    return [[NSNumber numberWithFloat:self.invoiceNumber] description];
}
@end

