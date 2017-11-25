#import "FLXSBaseEntity.h"

@class FLXSInvoice;

@interface FLXSLineItem : FLXSBaseEntity
{

}

@property (nonatomic, weak) FLXSInvoice* invoice;
@property (nonatomic, assign) float lineItemAmount;
@property (nonatomic, strong) NSString* lineItemDescription;
@property (nonatomic, assign) float units;


-(FLXSBaseEntity *)createNew;
-(FLXSBaseEntity *)parent  ;

@end

