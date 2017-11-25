#import "FLXSBaseEntity.h"
#import "FLXSAddress.h"
#import "FLXSCommercialContact.h"
#import "FLXSDeal.h"

@interface FLXSOrganization : FLXSBaseEntity
{
}

@property (nonatomic, strong) FLXSAddress * headquarterAddress;
@property (nonatomic, strong) FLXSAddress * mailingAddress;
@property (nonatomic, strong) NSString* legalName;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) FLXSCommercialContact * billingContact;
@property (nonatomic, strong) FLXSCommercialContact * salesContact;
@property (nonatomic, assign) float annualRevenue;
@property (nonatomic, assign) float numEmployees;
@property (nonatomic, assign) float earningsPerShare;
@property (nonatomic, assign) float lastStockPrice;
@property (nonatomic, strong) NSString* chartUrl;
@property (nonatomic, strong) NSMutableArray* deals;
@property (nonatomic, assign) BOOL isActive;
@property (nonatomic, assign) BOOL headQuartersSameAsMailing;
@property (nonatomic, assign) float relationshipAmountSaved;

-(float)orgIndex;

-(float)relationshipAmount;
-(FLXSBaseEntity *)createNew;
-(NSString*)name;
-(NSArray *)children;

@end

