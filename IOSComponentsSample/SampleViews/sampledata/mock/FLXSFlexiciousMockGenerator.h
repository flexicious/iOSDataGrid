#import "FLXSBaseEntity.h"
#import "FLXSInvoice.h"
#import "FLXSLineItem.h"
#import "FLXSAddress.h"
#import "FLXSPagedResult.h"
#import "FLXSReferenceData.h"
#import "FLXSSystemConstants.h"
#import "FLXSCustomerOrganization.h"
#import "FLXSCommercialContact.h"
#import "FLXSSystemUser.h"
#import "FLXSDeal.h"
#import "FLXSFlexiciousMockGenerator.h"
#import "FLXSDemoVersion.h"

@class FLXSFilter;

@class FLXSOrganization;
//This class is used to generate mock data

@interface FLXSFlexiciousMockGenerator : FLXSBaseUIControl
{
}

@property (nonatomic, assign) int DEALS_PER_ORG;
@property (nonatomic, assign) int INVOICES_PER_DEAL;
@property (nonatomic, assign) int LINEITEMS_PER_INVOICE;
@property (nonatomic, assign) float progress;
@property (nonatomic, assign) int _pageIndex;
@property (nonatomic, assign) int _pageSize;
@property (nonatomic, assign) int index;

+(FLXSFlexiciousMockGenerator *)instance;

-(NSMutableArray*)getAllLineItems;
-(NSMutableArray*)getFlatOrgList;
-(NSMutableArray*)getDeepOrgList;

-(NSMutableArray*)getOrgList:(BOOL)deep;
-(FLXSOrganization*)getDeepOrg:(float)orgId;
-(FLXSPagedResult *)getPagedOrganizationList:(FLXSFilter*)filter;
-(FLXSPagedResult *)getDealsForOrganization:(float)orgId :(FLXSFilter*)filter;
-(FLXSPagedResult *)getInvoicesForDeal:(float)dealId :(FLXSFilter*)filter;
-(FLXSPagedResult *)getLineItemsForInvoice:(float)invoiceId :(FLXSFilter*)filter;
-(FLXSOrganization*)createOrganization:(NSString*)legalName :(BOOL)deep;
-(FLXSDeal *)createDeal:(int)idx :(FLXSCustomerOrganization *)org :(BOOL)deep;
-(FLXSInvoice *)createInvoice:(int)idx :(FLXSDeal *)deal :(BOOL)deep;
-(FLXSLineItem *)createInvoiceLineItem:(int)lineItemIdx :(FLXSInvoice *)invoice :(BOOL)deep;
+(FLXSReferenceData *)getRandomReferenceData:(NSArray*)arr;
+(FLXSCommercialContact *)createContact;
+(void)setGlobals:(FLXSBaseEntity *)entity;
+(NSDate*)getRandomDate;
+(NSString*)generatePhone;
+(FLXSSystemUser *)getSystemUser;
+(FLXSAddress *)createAddress;
+(int)getRandom:(int)minNum :(int)maxNum;
+(NSArray*)mockNestedData;

+ (FLXSFlexiciousMockGenerator *)_instance;
+ (NSMutableArray*)lineItems;
+ (NSMutableArray*)simpleList;
+ (NSMutableArray*)deepList;
+ (int)_index;
+ (FLXSSystemUser *)sysAdmin;
+ (NSArray*)areaCodes;
+ (NSArray*)streetTypes;
+ (NSArray*)streetNames;
+ (NSArray*)companyNames;
+ (NSArray*)lastNames;
+ (NSArray*)firstNames;
+ (NSString*)mockNestedXml;
@end

