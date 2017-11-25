#import "FLXSBaseEntity.h"
#import "FLXSInvoice.h"
#import "FLXSReferenceData.h"

@class FLXSOrganization;

@interface FLXSDeal : FLXSBaseEntity
{
}

@property (nonatomic, weak) FLXSOrganization * customer;
@property (nonatomic, strong) NSMutableArray* invoices;
@property (nonatomic, strong) NSDate* dealDate;
@property (nonatomic, weak) FLXSReferenceData * dealStatus;
@property (nonatomic, strong) NSString* dealDescription;
@property (nonatomic, assign) BOOL finalized;
@property (nonatomic, weak) FLXSOrganization* provider;
@property (nonatomic, strong) NSMutableArray* dealContacts;

-(float)dealAmount;
-(BOOL)isBillable;

-(FLXSBaseEntity *)createNew;
-(NSString*)name;
-(NSArray *)children;
-(FLXSBaseEntity *)parent;
-(void)parent:(FLXSBaseEntity *)val;

@end

