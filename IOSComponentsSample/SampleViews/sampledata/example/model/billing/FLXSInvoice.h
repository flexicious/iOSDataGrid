@class FLXSDeal;
@class FLXSReferenceData;

#import "FLXSBaseEntity.h"
@interface FLXSInvoice : FLXSBaseEntity
{

}

@property (nonatomic, weak) FLXSDeal * deal;
@property (nonatomic, strong) NSDate* invoiceDate;
@property (nonatomic, strong) NSDate* dueDate;
@property (nonatomic, weak) FLXSReferenceData * invoiceStatus;
@property (nonatomic, strong) NSMutableArray* lineItems;
@property (nonatomic, assign) BOOL hasPdf;
@property (nonatomic, assign) float invoiceSpecificAmount;

-(float)invoiceNumber;
-(float)invoiceAmount;

-(FLXSBaseEntity *)createNew;
-(FLXSBaseEntity *)parent  ;
-(NSArray*)children        ;

-(NSString*)invoiceStatusName;

@end

