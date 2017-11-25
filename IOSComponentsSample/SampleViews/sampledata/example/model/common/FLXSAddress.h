#import "FLXSBaseEntity.h"
#import "FLXSReferenceData.h"

@interface FLXSAddress : FLXSBaseEntity
{
}

@property (nonatomic, weak) FLXSReferenceData * addressType;
@property (nonatomic, assign) BOOL isPrimary;
@property (nonatomic, strong) NSString* line1;
@property (nonatomic, strong) NSString* line2;
@property (nonatomic, strong) NSString* line3;
@property (nonatomic, weak) FLXSReferenceData * city;
@property (nonatomic, weak) FLXSReferenceData * state;
@property (nonatomic, weak) FLXSReferenceData * country;
@property (nonatomic, strong) NSString* postalCode;


-(FLXSBaseEntity *)createNew;
-(NSString *)concatenatedAddress;

@end

