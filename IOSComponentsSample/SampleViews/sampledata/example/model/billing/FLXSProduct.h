#import "FLXSBaseEntity.h"

@interface FLXSProduct : FLXSBaseEntity
{

}

@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) float unitPrice;
@property (nonatomic, strong) NSString* description;
@property (nonatomic, strong) NSString* partNumber;


-(FLXSBaseEntity *)createNew;

@end

