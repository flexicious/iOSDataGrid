#import "FLXSLineItem.h"


@implementation FLXSLineItem

@synthesize invoice;
@synthesize lineItemAmount;
@synthesize lineItemDescription;
@synthesize units;

-(FLXSBaseEntity *)createNew
{
	return [[FLXSLineItem alloc] init];
}

-(FLXSBaseEntity *)parent  ;
{
	return (FLXSBaseEntity*)self.invoice;
}

-(void)setParent:(FLXSBaseEntity *)val
{
	self.invoice=(FLXSInvoice*)val;
}

@end

