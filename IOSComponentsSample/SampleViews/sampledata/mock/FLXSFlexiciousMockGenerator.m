#import "FLXSFlexiciousMockGenerator.h"

static FLXSFlexiciousMockGenerator * _instance = nil;//[[FLXSFlexiciousMockGenerator alloc] init];
static NSMutableArray* lineItems = nil;// [[NSMutableArray alloc] init];
static NSMutableArray* simpleList;
static NSMutableArray* deepList;
static int _index = 0;
static FLXSSystemUser * sysAdmin;
static  NSArray* areaCodes = nil;// [@"201",@"732",@"212",@"646",@"800",@"866"] ;
static NSArray* streetTypes = nil;// [@"Ave",@"Blvd",@"Rd",@"St",@"Lane"];
static NSArray* streetNames = nil;// [@"Park",@"West",@"Newark",@"King",@"Gardner"];
static NSArray* companyNames=nil;
static NSArray* lastNames = nil;// [@"SMITH",@"JOHNSON",@"WILLIAMS",@"BROWN",@"JONES",@"MILLER",@"DAVIS",@"GARCIA",@"RODRIGUEZ",@"WILSON",@"MARTINEZ",@"ANDERSON",@"TAYLOR",@"THOMAS",@"HERNANDEZ",@"MOORE",@"MARTIN",@"JACKSON",@"THOMPSON",@"WHITE",@"LOPEZ",@"LEE",@"GONZALEZ",@"HARRIS",@"CLARK",@"LEWIS",@"ROBINSON",@"WALKER",@"PEREZ",@"HALL",@"YOUNG",@"ALLEN",@"SANCHEZ",@"WRIGHT",@"KING",@"SCOTT",nil];
static NSArray* firstNames=nil;
static NSString* mockNestedXml;

@implementation FLXSFlexiciousMockGenerator

@synthesize DEALS_PER_ORG;
@synthesize INVOICES_PER_DEAL;
@synthesize LINEITEMS_PER_INVOICE;
@synthesize progress;
@synthesize _pageIndex;
@synthesize _pageSize;
@synthesize index;

+(FLXSFlexiciousMockGenerator *)instance
{
    if(!_instance){
        _instance = [[FLXSFlexiciousMockGenerator alloc] init];
        lineItems = [[NSMutableArray alloc] init];
    }
	return _instance;
}

-(id)init
{
	self = [super init];
	if (self)
	{
		DEALS_PER_ORG = 2;
		INVOICES_PER_DEAL = 5;
		LINEITEMS_PER_INVOICE = 5;
		_pageIndex = 0;
		_pageSize = 30;
		index = 0;


        deepList=[[NSMutableArray alloc] init];
        index=0;
        [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
		
	}
	return self;
}
 
-(NSMutableArray*)getAllLineItems
{
	if([lineItems count] ==0)
	{
		[self getDeepOrgList] ;
	}
	return lineItems;
}

-(NSMutableArray*)getFlatOrgList
{
	if(!simpleList)
	{
		simpleList=[self getOrgList:NO];
        NSMutableArray* deeplist =[[FLXSFlexiciousMockGenerator instance]getDeepOrgList];
        
        for(FLXSOrganization* org in simpleList){
            for(FLXSOrganization* orgDeep in deeplist){
                if([org.name isEqualToString:orgDeep.name]){
                    org.relationshipAmountSaved = orgDeep.relationshipAmount;
                    break;
                }
            }
        }
        
    
	}
	return [simpleList mutableCopy];
}

-(NSMutableArray*)getDeepOrgList
{
	if(!deepList)
	{
		deepList=[self getOrgList:YES];
	}
	return deepList;
}

-(void)onTimer:(NSTimer*)timer
{
	for(int i=_pageIndex*_pageSize;i< MIN([FLXSFlexiciousMockGenerator companyNames].count,((_pageIndex+1)*_pageSize));i++)
	{
		NSString* nm =[FLXSFlexiciousMockGenerator companyNames][i];
		[deepList addObject:([self createOrganization:nm :YES])];
	}
	if((_pageIndex*_pageSize)>=[FLXSFlexiciousMockGenerator companyNames].count)
	{
        [timer invalidate];
        timer = nil;
        progress=100;
		[self dispatchEvent:([[FLXSEvent alloc] initWithType:(@"progress")])];
		return;
	}
	else
	{
		progress=(_pageIndex*_pageSize)*100/[FLXSFlexiciousMockGenerator companyNames].count;
		_pageIndex++;
		[self dispatchEvent:([[FLXSEvent alloc] initWithType:(@"progress")])];
 	}
}

-(NSMutableArray*)getOrgList:(BOOL)deep
{
	NSMutableArray* orgs=[[NSMutableArray alloc] init];
	for(int i=0;i<[FLXSFlexiciousMockGenerator companyNames].count;i++)
	{
		NSString* nm =[FLXSFlexiciousMockGenerator companyNames][i];
		[orgs addObject:([self createOrganization:nm :deep])];
	}
	return orgs;
}

-(FLXSOrganization *)getDeepOrg:(float)orgId
{
	for(FLXSOrganization * org in deepList)
	{
		if(org.id==orgId)
		{
			return (FLXSOrganization*)[org clone:YES];
		}
	}
	//throw [[Error alloc] initWithType:(@"Invalid org ID passed in : " + orgId)];
    return nil;
}

-(FLXSPagedResult *)getPagedOrganizationList:(FLXSFilter*)filter
{
	if(!simpleList)
	{
		simpleList=[self getOrgList:NO];
	}
	if([filter isKindOfClass:[FLXSPrintExportFilter class]])
	{
        FLXSPrintExportFilter* pef = (FLXSPrintExportFilter*)filter;
		if(pef.printExportOptions.printExportOption == [FLXSPrintExportOptions PRINT_EXPORT_ALL_PAGES])
		{
			filter.pageIndex=-1;
			//so we return all records.
			return [[FLXSPagedResult alloc]                                                       initWithCollection:([[NSMutableArray alloc]
                    initWithArray:([FLXSExtendedUIUtils filterPageSort:deepList filter:filter pages:nil flatFilter:NO ])]) andTotalRecords:filter.recordCount andSummaryData:nil andDeepClone:YES ];
		}
		else
		{
			return [[FLXSPagedResult alloc] initWithCollection:([[NSMutableArray alloc] initWithArray:
                    ([FLXSExtendedUIUtils                                               filterPageSort:deepList filter:filter pages:([[NSArray alloc] initWithObjects:[NSNumber numberWithInt:pef.printExportOptions.pageFrom]
                            , [NSNumber numberWithInt:pef.printExportOptions.pageTo], nil]) flatFilter:NO ])])            andTotalRecords:filter.recordCount andSummaryData:nil andDeepClone:YES ];
		}
	}
	else
        return [[FLXSPagedResult alloc]                                                         initWithCollection:([[NSMutableArray alloc]
                initWithArray:([FLXSExtendedUIUtils filterPageSort:simpleList filter:filter pages:nil flatFilter:NO ])]) andTotalRecords:filter.recordCount andSummaryData:nil andDeepClone:YES ];
}

-(FLXSPagedResult *)getDealsForOrganization:(float)orgId :(FLXSFilter*)filter
{
	for(FLXSOrganization * org in [self getDeepOrgList])
	{
		if(org.id==orgId)
		{
            NSMutableDictionary *additionalInformation = [[NSMutableDictionary alloc] init];
            [additionalInformation setObject:[NSNumber numberWithFloat:[FLXSUIUtils sum:org.deals fld:@"dealAmount"]] forKey:@"total"];
            [additionalInformation setObject:[NSNumber numberWithInt: (int)org.deals.count] forKey:@"count"];
            NSMutableArray* arr=org.deals;
			return [[FLXSPagedResult alloc]                                                                                initWithCollection:(filter.pageIndex >= 0 ?
                    [[NSMutableArray alloc] initWithArray:([FLXSExtendedUIUtils filterPageSort:arr filter:filter pages:nil flatFilter:NO ])] : arr) andTotalRecords:arr.count andSummaryData:additionalInformation andDeepClone:YES ];

		}
	}
	return [[FLXSPagedResult alloc] initWithCollection:([[NSMutableArray alloc] init]) andTotalRecords:0 andSummaryData:nil andDeepClone:YES ];
}

-(FLXSPagedResult *)getInvoicesForDeal:(float)dealId :(FLXSFilter*)filter
{
	for(FLXSOrganization * org in [self getDeepOrgList])
	{
		for(FLXSDeal * deal in org.deals)
		{
			if(deal.id==dealId)
			{
                NSMutableDictionary *additionalInformation = [[NSMutableDictionary alloc] init];
                [additionalInformation setObject:[NSNumber numberWithFloat:[FLXSUIUtils sum:deal.invoices fld:@"invoiceAmount"]] forKey:@"total"];
                [additionalInformation setObject:[NSNumber numberWithInt: (int)deal.invoices.count] forKey:@"count"];
                NSMutableArray* arr=deal.invoices;
				return [[FLXSPagedResult alloc]                                                                                initWithCollection:(filter.pageIndex >= 0 ?
                        [[NSMutableArray alloc] initWithArray:([FLXSExtendedUIUtils filterPageSort:arr filter:filter pages:nil flatFilter:NO ])] : arr) andTotalRecords:arr.count andSummaryData:additionalInformation andDeepClone:NO ];
			}
		}
	}
	return [[FLXSPagedResult alloc] initWithCollection:([[NSMutableArray alloc] init]) andTotalRecords:0 andSummaryData:nil andDeepClone:NO ];
}

-(FLXSPagedResult *)getLineItemsForInvoice:(float)invoiceId :(FLXSFilter*)filter
{
	for(FLXSOrganization * org in [self getDeepOrgList])
	{
		for(FLXSDeal * deal in org.deals)
		{
			for(FLXSInvoice * invoice in deal.invoices)
			{
				if(invoice.id==invoiceId)
				{
					NSMutableArray* arr=invoice.lineItems;
                    NSMutableDictionary *additionalInformation = [[NSMutableDictionary alloc] init];
                    [additionalInformation setObject:[NSNumber numberWithFloat:[FLXSUIUtils sum:arr fld:@"lineItemAmount"]] forKey:@"total"];
                    [additionalInformation setObject:[NSNumber numberWithInt: (int)arr.count] forKey:@"count"];

                    return [[FLXSPagedResult alloc]                                                                                initWithCollection:(filter.pageIndex >= 0 ?
                            [[NSMutableArray alloc] initWithArray:([FLXSExtendedUIUtils filterPageSort:arr filter:filter pages:nil flatFilter:NO ])] : arr) andTotalRecords:arr.count andSummaryData:additionalInformation andDeepClone:NO ];
				}
			}
		}
	}
	return [[FLXSPagedResult alloc] initWithCollection:([[NSMutableArray alloc] init]) andTotalRecords:0 andSummaryData:nil andDeepClone:NO ];
}

-(FLXSOrganization *)createOrganization:(NSString*)legalName :(BOOL)deep
{
	if(deep)_index++;
	FLXSCustomerOrganization * org = [[FLXSCustomerOrganization alloc] init];
	org.id= 20800 + [[FLXSFlexiciousMockGenerator companyNames] indexOfObject:legalName];
	org.legalName=legalName;
	org.headquarterAddress = [FLXSFlexiciousMockGenerator createAddress];
	org.mailingAddress = [FLXSFlexiciousMockGenerator createAddress];
	org.billingContact=[FLXSFlexiciousMockGenerator createContact];
	org.salesContact=[FLXSFlexiciousMockGenerator createContact];
	org.annualRevenue = [FLXSFlexiciousMockGenerator getRandom:1000 :60000]  ;
    org.numEmployees = [FLXSFlexiciousMockGenerator getRandom:1000 :60000]      ;
    org.earningsPerShare = [FLXSFlexiciousMockGenerator getRandom:1 :6] + ([FLXSFlexiciousMockGenerator getRandom:1 :99]/100);
	org.lastStockPrice = [FLXSFlexiciousMockGenerator getRandom:10 :30] + ([FLXSFlexiciousMockGenerator getRandom:1 :99]/100);
	org.url = [@"http://www.google.com/search?q=" stringByAppendingString: legalName];
    [FLXSFlexiciousMockGenerator setGlobals:org];
    org.chartUrl= [[[NSArray alloc] initWithObjects:@"http://www.flexicious.com/resources/images/chart",
    [NSNumber numberWithInt:[FLXSFlexiciousMockGenerator getRandom:1 :7]],
                    @".png",nil
    ] componentsJoinedByString:@""];
 
    if(deep)
	{
		for(int dealIdx=0;dealIdx<DEALS_PER_ORG;dealIdx++)
		{
			[org.deals addObject:([self createDeal:dealIdx :org :deep])];
		}
	}
	return org;
}

-(FLXSDeal *)createDeal:(int)idx :(FLXSCustomerOrganization *)org :(BOOL)deep
{
	FLXSDeal * deal = [[FLXSDeal alloc] init];
	deal.customer=org;
	deal.dealDate = [FLXSFlexiciousMockGenerator getRandomDate];
     NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit| NSMonthCalendarUnit| NSYearCalendarUnit fromDate:deal.dealDate];
    [deal setDealDescription: [NSString stringWithFormat:@"Project #  %i - %@ - %i/%i",(int)(org.deals.count+1),org.legalName,(int)(components.month+1),(int)components.year]];
 	deal.dealStatus= [[FLXSFlexiciousMockGenerator getRandomReferenceData:[FLXSSystemConstants dealStatuses]] cloneSpecial];
	deal.id = (org.id*10)+(idx);
	if(deep)
	{
		for(int invoiceIDx=0;invoiceIDx<INVOICES_PER_DEAL;invoiceIDx++)
		{
			[deal.invoices addObject:([self createInvoice:invoiceIDx :deal :deep])];
		}
	}
	[FLXSFlexiciousMockGenerator setGlobals:deal];
	return deal;
}

-(FLXSInvoice *)createInvoice:(int)idx :(FLXSDeal *)deal :(BOOL)deep
{
	FLXSInvoice * invoice = [[FLXSInvoice alloc] init];
	invoice.deal=deal;
	invoice.invoiceDate = [FLXSFlexiciousMockGenerator getRandomDate];
	invoice.id = (deal.id*10)+idx;
	invoice.invoiceStatus= [[FLXSFlexiciousMockGenerator getRandomReferenceData:[FLXSSystemConstants invoiceStatuses]] cloneSpecial];
	invoice.dueDate = [FLXSDateUtils addDatePart:[FLXSDateUtils DAY_OF_MONTH] numberToAdd:30 date:invoice.invoiceDate];
	invoice.hasPdf = [FLXSFlexiciousMockGenerator getRandom:1 :2]==1;
	if(deep)
	{
		for(int lineItemIDx=0;lineItemIDx<LINEITEMS_PER_INVOICE;lineItemIDx++)
		{
			FLXSLineItem * lineItem = [self createInvoiceLineItem:lineItemIDx :invoice :deep];
			[invoice.lineItems addObject:lineItem];
		}
	}
	[FLXSFlexiciousMockGenerator setGlobals:invoice];
	return invoice;
}

-(FLXSLineItem *)createInvoiceLineItem:(int)lineItemIdx :(FLXSInvoice *)invoice :(BOOL)deep
{
	FLXSLineItem * lineItem = [[FLXSLineItem alloc] init];
	lineItem.id=(invoice.id*10)+lineItemIdx;
	lineItem.invoice=invoice;
	lineItem.lineItemAmount=[FLXSFlexiciousMockGenerator getRandom:10000 :50000];
     lineItem.lineItemDescription = [NSString stringWithFormat:@"Professional Services - %@",[[FLXSFlexiciousMockGenerator getRandomReferenceData:[FLXSSystemConstants billableConsultants] ] cloneSpecial].name];
	
	lineItem.units = lineItem.lineItemAmount/100;
	[FLXSFlexiciousMockGenerator setGlobals:lineItem];
	[lineItems addObject:lineItem];
	return lineItem;
}

+(FLXSReferenceData *)getRandomReferenceData:(NSArray*)arr
{
	return [arr objectAtIndex:[FLXSFlexiciousMockGenerator getRandom:0 :(int)(arr.count-1)]];
}

+(FLXSCommercialContact *)createContact
{
	FLXSCommercialContact * commercialContact=[[FLXSCommercialContact alloc] init];
	commercialContact.firstName= [[FLXSFlexiciousMockGenerator firstNames] objectAtIndex:[FLXSFlexiciousMockGenerator getRandom:0 :(int)([FLXSFlexiciousMockGenerator firstNames] .count-1)]];
	commercialContact.lastName= [[FLXSFlexiciousMockGenerator lastNames]  objectAtIndex:[FLXSFlexiciousMockGenerator getRandom:0 :(int)([FLXSFlexiciousMockGenerator lastNames] .count-1)]];
	commercialContact.homeAddress=[self createAddress];
	commercialContact.telephone=[self generatePhone];
	[self setGlobals:commercialContact];
	return commercialContact;
}

+(void)setGlobals:(FLXSBaseEntity *)entity
{
	entity.addedBy=[self getSystemUser];
	entity.addedDate = [self getRandomDate];
	entity.updatedDate=entity.addedDate;
	entity.updatedBy=[self getSystemUser];
}

+(NSDate*)getRandomDate
{
    return [FLXSDateUtils dateWithYear:[FLXSFlexiciousMockGenerator getRandom:2010 :2013]
                                 month:[FLXSFlexiciousMockGenerator getRandom:0 :11]
                                   day:[FLXSFlexiciousMockGenerator getRandom:1 :29]
                                  hour:0 minute:0 second:0];
}

+(NSString*)generatePhone
{
    return [NSString stringWithFormat:@"%@-%i-%i",[areaCodes objectAtIndex:[FLXSFlexiciousMockGenerator getRandom:0 :3]],[FLXSFlexiciousMockGenerator getRandom:100 :999], [FLXSFlexiciousMockGenerator getRandom:1000 :9999 ]];
}

+(FLXSSystemUser *)getSystemUser
{
	if(sysAdmin)return sysAdmin;
	FLXSSystemUser * user=[[FLXSSystemUser alloc] init];
	user.addedBy=user;
	user.addedDate= [FLXSDateUtils dateWithYear:2013 month:2 day:5 hour:0 minute:0 second:0];
	//[[Date alloc] init:2010 :1 :1];
	user.updatedBy = user;
	user.updatedDate = [FLXSDateUtils dateWithYear:2013 month:2 day:5 hour:0 minute:0 second:0];
	user.id=1;
	user.firstName= [firstNames objectAtIndex:[FLXSFlexiciousMockGenerator getRandom:0 :(int)(firstNames.count-1)]];
	user.lastName= [lastNames objectAtIndex:[FLXSFlexiciousMockGenerator getRandom:0 :(int)(lastNames.count-1)]];
	user.loginNm =@"system_admin";
	sysAdmin=user;
	return user;
}

+(FLXSAddress *)createAddress
{
	FLXSAddress * address =[[FLXSAddress alloc] init];
     address.line1 = [NSString stringWithFormat:@"%i %@ %@ ",[FLXSFlexiciousMockGenerator getRandom:100 :999 ],
                     [[FLXSFlexiciousMockGenerator streetNames] objectAtIndex:[FLXSFlexiciousMockGenerator getRandom:0 :(int)([FLXSFlexiciousMockGenerator streetNames] .count-1)]],
                     [[FLXSFlexiciousMockGenerator streetTypes] objectAtIndex:[FLXSFlexiciousMockGenerator getRandom:0 :(int)([FLXSFlexiciousMockGenerator streetTypes] .count-1)]]];
	address.line2 = [NSString stringWithFormat:@"Suite # %i",[FLXSFlexiciousMockGenerator getRandom:1 :1000]];

	address.city= [[FLXSSystemConstants cities] objectAtIndex:[FLXSFlexiciousMockGenerator getRandom:0 :(int)([FLXSSystemConstants cities].count-1)]];
	address.state= [[FLXSSystemConstants states] objectAtIndex:[FLXSFlexiciousMockGenerator getRandom:0 :(int)([FLXSSystemConstants states].count-1)]];
	address.country = [FLXSSystemConstants usCountry];
	return address;
}

+(int)getRandom:(int)minNum :(int)maxNum
{
	return minNum + arc4random() % (maxNum - minNum);;
}

+(NSArray*)mockNestedData
{
    NSString *filePath;
    filePath = [[NSBundle mainBundle] pathForResource:@"FLXSNestedJsonData" ofType:@"json"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    NSError * error;
    id dic= [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableContainers error:&error];
    return [dic isKindOfClass:[NSArray class] ]?dic: ((NSDictionary *)dic).allValues;
}

+ (FLXSFlexiciousMockGenerator *)_instance
{
	return _instance;
}
+ (NSMutableArray*)lineItems
{
	return lineItems;
}
+ (NSMutableArray*)simpleList
{
	return simpleList;
}
+ (NSMutableArray*)deepList
{
	return deepList;
}
+ (int)_index
{
	return _index;
}
+ (FLXSSystemUser *)sysAdmin
{
	return sysAdmin;
}
+ (NSArray*)areaCodes
{
    if(!areaCodes){
        areaCodes = [[NSArray alloc] initWithObjects:@"Park",@"West",@"Newark",@"King",@"Gardner",nil];
    }
    return areaCodes;
}
+ (NSArray*)streetTypes
{
    if(!streetTypes){
        streetTypes = [[NSArray alloc] initWithObjects:@"Ave",@"Blvd",@"Rd",@"St",@"Lane",nil];
    }
    return streetTypes;
}
+ (NSArray*)streetNames
{
    if(!streetNames){
        streetNames = [[NSArray alloc] initWithObjects:@"Park",@"West",@"Newark",@"King",@"Gardner",nil];
    }
	return streetNames;
}
+ (NSArray*)companyNames
{
    if(!companyNames){
    companyNames= [[NSArray alloc] initWithObjects:@"3M Co",
                                                   @"Abbott Laboratories",
                                                   @"Adobe Systems",
                                                   @"Advanced Micro Dev",
                                                   @"Aetna Inc",
                                                   @"Affiliated Computer Svcs",
                                                   @"AFLAC Inc",
                                                   @"Air Products & Chem",
                                                   @"Airgas Inc",
                                                   @"AK Steel Holding",
                                                   @"Akamai Technologies",
                                                   @"Alcoa Inc",
                                                   @"Allegheny Energy",
                                                   @"Allegheny Technologies",
                                                   @"Allergan, Inc",
                                                   @"Allstate Corp",
                                                   @"Altera Corp",
                                                   @"Altria Group",
                                                   @"Amazon.com Inc",
                                                   @"Amer Electric Pwr",
                                                   @"Amer Express",
                                                   @"Amer Tower",
                                                   @"Ameren Corp",
                                                   @"Ameriprise Financial",
                                                   @"AmerisourceBergen Corp",
                                                   @"Amgen Inc",
                                                   @"Amphenol Corp",
                                                   @"Anadarko Petroleum",
                                                   @"Aon Corp",
                                                   @"Apache Corp",
                                                   @"Apartment Investment & Mgmt",
                                                   @"Apollo Group",
                                                   @"Apple Inc",
                                                   @"Archer-Daniels-Midland",
                                                   @"Assurant Inc",
                                                   @"AT&T Inc",
                                                   @"Automatic Data Proc",
                                                   @"AutoNation Inc",
                                                   @"AutoZone Inc",
                                                   @"AvalonBay Communities",
                                                   @"Avery Dennison Corp",
                                                   @"Avon Products",
                                                   @"Baker Hughes Inc",
                                                   @"Ball Corp",
                                                   @"Bank of America",
                                                   @"Bank of New York Mellon",
                                                   @"Bard (C.R.)",
                                                   @"Baxter Intl",
                                                   @"BB&T Corp",
                                                   @"Becton, Dickinson",
                                                   @"Bed Bath & Beyond",
                                                   @"Bemis Co",
                                                   @"Best Buy",
                                                   @"Biogen Idec",
                                                   @"Black & Decker Corp",
                                                   @"BMC Software",
                                                   @"Boeing Co",
                                                   @"Boston Properties",
                                                   @"Boston Scientific",
                                                   @"Bristol-Myers Squibb",
                                                   @"Broadcom Corp",
                                                   @"Burlington Northn Santa Fe",
                                                   @"C.H. Robinson Worldwide",
                                                   @"CA Inc",
                                                   @"Cabot Oil & Gas",
                                                   @"Cameron Intl",
                                                   @"Capital One Financial",
                                                   @"Carnival Corp",
                                                   @"Caterpillar Inc",
                                                   @"CB Richard Ellis Grp",
                                                   @"Celgene Corp",
                                                   @"CenterPoint Energy",
                                                   @"Cephalon Inc",
                                                   @"CF Industries Hldgs",
                                                   @"Chesapeake Energy",
                                                   @"Chevron Corp",
                                                   @"Chubb Corp",
                                                   @"Cincinnati Financial",
                                                   @"Cintas Corp",
                                                   @"Cisco Systems",
                                                   @"Citigroup Inc",
                                                   @"Citrix Systems",
                                                   @"Clorox Co",
                                                   @"CME Group Inc",
                                                   @"CMS Energy",
                                                   @"Coach Inc",
                                                   @"Coca-Cola Co",
                                                   @"Coca-Cola Enterprises",
                                                   @"Cognizant Tech Solutions",
                                                   @"Colgate-Palmolive",
                                                   @"Comcast Cl",
                                                   @"Comerica Inc",
                                                   @"Compuware Corp",
                                                   @"ConAgra Foods",
                                                   @"ConocoPhillips",
                                                   @"CONSOL Energy",
                                                   @"Consolidated Edison",
                                                   @"Constellation Brands",
                                                   @"Constellation Energy Group",
                                                   @"Convergys Corp",
                                                   @"Corning Inc",
                                                   @"Costco Wholesale",
                                                   @"Coventry Health Care",
                                                   @"CSX Corp",
                                                   @"Cummins Inc",
                                                   @"Danaher Corp",
                                                   @"Darden Restaurants",
                                                   @"DaVita Inc",
                                                   @"Dean Foods",
                                                   @"DENTSPLY Intl",
                                                   @"Devon Energy",
                                                   @"DeVry Inc",
                                                   @"Diamond Offshore Drilling",
                                                   @"Discover Financial Svcs",
                                                   @"Dominion Resources",
                                                   @"Donnelley(R.R.)& Sons",
                                                   @"Dover Corp",
                                                   @"Dow Chemical",
                                                   @"DTE Energy",
                                                   @"Duke Energy",
                                                   @"Dun & Bradstreet",
                                                   @"duPont(E.I.)deNemours",
                                                   @"E Trade Financial",
                                                   @"Eastman Chemical",
                                                   @"Eastman Kodak",
                                                   @"Eaton Corp",
                                                   @"eBay Inc",
                                                   @"Ecolab Inc",
                                                   @"El Paso Corp",
                                                   @"EMC Corp",
                                                   @"Emerson Electric",
                                                   @"ENSCO Intl",
                                                   @"Entergy Corp",
                                                   @"EQT Corp",
                                                   @"Equifax Inc",
                                                   @"Equity Residential",
                                                   @"Exelon Corp",
                                                   @"Expedia Inc",
                                                   @"Expeditors Intl,Wash",
                                                   @"Express Scripts",
                                                   @"Exxon Mobil",
                                                   @"Family Dollar Stores",
                                                   @"Fastenal Co",
                                                   @"Federated Investors ",
                                                   @"FedEx Corp",
                                                   @"Fidelity Natl Info Svcs",
                                                   @"Fifth Third Bancorp",
                                                   @"First Horizon Natl",
                                                   @"FirstEnergy Corp",
                                                   @"Fiserv Inc",
                                                   @"FLIR Systems",
                                                   @"Flowserve Corp",
                                                   @"FMC Corp",
                                                   @"FMC Technologies",
                                                   @"Ford Motor",
                                                   @"Forest Labs",
                                                   @"Fortune Brands",
                                                   @"FPL Group",
                                                   @"Franklin Resources",
                                                   @"Freept McMoRan Copper&Gold",
                                                   @"Frontier Communications",
                                                   @"Gannett Co",
                                                   @"Genl Dynamics",
                                                   @"Genl Electric",
                                                   @"Genl Mills",
                                                   @"Genuine Parts",
                                                   @"Genworth Financial",
                                                   @"Genzyme Corp",
                                                   @"Gilead Sciences",
                                                   @"Goldman Sachs Group",
                                                   @"Goodrich Corp",
                                                   @"Goodyear Tire & Rub",
                                                   @"Google Inc",
                                                   @"Grainger (W.W.)",
                                                   @"Halliburton Co",
                                                   @"Harley-Davidson",
                                                   @"Harman Intl",
                                                   @"Harris Corp",
                                                   @"Hartford Finl Svcs Gp",
                                                   @"Hasbro Inc",
                                                   @"HCP Inc",
                                                   @"Health Care REIT",
                                                   @"Hershey Co",
                                                   @"Hess Corp",
                                                   @"Honeywell Intl",
                                                   @"Hospira Inc",
                                                   @"Host Hotels & Resorts",
                                                   @"Hudson City Bancorp",
                                                   @"Humana Inc",
                                                   @"Huntington Bancshares",
                                                   @"Illinois Tool Works",
                                                   @"IMS Health",
                                                   @"Intel Corp",
                                                   @"IntercontinentalExchange Inc",
                                                   @"Interpublic Grp Cos",
                                                   @"Intl Bus. Machines",
                                                   @"Intl Flavors/Fragr",
                                                   @"Intl Paper",
                                                   @"Intuitive Surgical",
                                                   @"INVESCO Ltd",
                                                   @"Iron Mountain",
                                                   @"ITT Corp",
                                                   @"Jabil Circuit",
                                                   @"Janus Capital Group",
                                                   @"Johnson & Johnson",
                                                   @"Johnson Controls",
                                                   @"JPMorgan Chase & Co",
                                                   @"Juniper Networks",
                                                   @"KB HOME",
                                                   @"Kellogg Co",
                                                   @"KeyCorp",
                                                   @"Kimberly-Clark",
                                                   @"Kimco Realty",
                                                   @"KLA-Tencor Corp",
                                                   @"Kraft Foods",
                                                   @"L-3 Communications Hldgs",
                                                   @"Laboratory Corp Amer Hldgs",
                                                   @"Lauder (Estee) Co",
                                                   @"Legg Mason Inc",
                                                   @"Leggett & Platt",
                                                   @"Lennar Corp",
                                                   @"Lexmark Intl",
                                                   @"Life Technologies",
                                                   @"Lilly (Eli)",
                                                   @"Lincoln Natl Corp",
                                                   @"Linear Technology Corp",
                                                   @"Lockheed Martin",
                                                   @"Loews Corp",
                                                   @"Lorillard Inc",
                                                   @"LSI Corp",
                                                   @"M&T Bank",
                                                   @"Marathon Oil",
                                                   @"Marriott Intl",
                                                   @"Marsh & McLennan",
                                                   @"Marshall & Ilsley",
                                                   @"Masco Corp",
                                                   @"Massey Energy",
                                                   @"MasterCard Inc",
                                                   @"Mattel, Inc",
                                                   @"McAfee Inc",
                                                   @"McCormick & Co",
                                                   @"McDonalds Corp",
                                                   @"McGraw-Hill Companies",
                                                   @"McKesson Corp",
                                                   @"MeadWestvaco Corp",
                                                   @"Medco Health Solutions",
                                                   @"MEMC Electronic Materials",
                                                   @"Merck & Co",
                                                   @"Meredith Corp",
                                                   @"MetLife Inc",
                                                   @"Microchip Technology",
                                                   @"Micron Technology",
                                                   @"Microsoft Corp",
                                                   @"Molex Inc",
                                                   @"Molson Coors Brewing",
                                                   @"Monsanto Co",
                                                   @"Monster Worldwide",
                                                   @"Moodys Corp",
                                                   @"Morgan Stanley",
                                                   @"Motorola, Inc",
                                                   @"Murphy Oil",
                                                   @"Mylan Inc",
                                                   @"Nabors Indus",
                                                   @"Natl Oilwell Varco",
                                                   @"Natl Semiconductor",
                                                   @"New York Times",
                                                   @"Newell Rubbermaid",
                                                   @"Newmont Mining",
                                                   @"News Corp ",
                                                   @"NICOR Inc",
                                                   @"NIKE, Inc",
                                                   @"NiSource Inc",
                                                   @"Noble Energy",
                                                   @"Norfolk Southern",
                                                   @"Northeast Utilities",
                                                   @"Northern Trust",
                                                   @"Northrop Grumman",
                                                   @"Novellus Systems",
                                                   @"Nucor Corp",
                                                   @"NYSE Euronext",
                                                   @"OReilly Automotive",
                                                   @"Occidental Petroleum",
                                                   @"Office Depot",
                                                   @"Omnicom Group",
                                                   @"Oracle Corp",
                                                   @"Owens-Illinois",
                                                   @"PACCAR Inc",
                                                   @"Pactiv Corp",
                                                   @"Parker-Hannifin",
                                                   @"Paychex Inc",
                                                   @"Peabody Energy",
                                                   @"Peoples United Financial",
                                                   @"Pepco Holdings",
                                                   @"Pepsi Bottling Group",
                                                   @"PepsiCo Inc",
                                                   @"PerkinElmer Inc",
                                                   @"Pfizer, Inc",
                                                   @"PG&E Corp",
                                                   @"Philip Morris Intl",
                                                   @"Pinnacle West Capital",
                                                   @"Pioneer Natural Resources",
                                                   @"Pitney Bowes",
                                                   @"Plum Creek Timber",
                                                   @"PNC Financial Services Group",
                                                   @"Polo Ralph Lauren",
                                                   @"PPG Indus",
                                                   @"PPL Corp",
                                                   @"Praxair Inc",
                                                   @"Precision Castparts",
                                                   @"Principal Financial Grp",
                                                   @"Procter & Gamble",
                                                   @"Progress Energy",
                                                   @"Progressive Corp,Ohio",
                                                   @"ProLogis",
                                                   @"Prudential Financial",
                                                   @"Public Svc Enterprises",
                                                   @"Pulte Homes",
                                                   @"QLogic Corp",
                                                   @"QUALCOMM Inc",
                                                   @"Quanta Services",
                                                   @"Quest Diagnostics",
                                                   @"Questar Corp",
                                                   @"Qwest Communications Intl",
                                                   @"RadioShack Corp",
                                                   @"Range Resources",
                                                   @"Raytheon Co",
                                                   @"Red Hat Inc",
                                                   @"Regions Financial",
                                                   @"Republic Services",
                                                   @"Reynolds American",
                                                   @"Robert Half Intl",
                                                   @"Rockwell Collins",
                                                   @"Rowan Cos",
                                                   @"Ryder System",
                                                   @"Safeway Inc",
                                                   @"SanDisk Corp",
                                                   @"SCANA Corp",
                                                   @"Schering-Plough",
                                                   @"Schlumberger Ltd",
                                                   @"Schwab(Charles)Corp",
                                                   @"Sealed Air",
                                                   @"Sherwin-Williams",
                                                   @"Sigma-Aldrich",
                                                   @"Simon Property Group",
                                                   @"SLM Corp",
                                                   @"Smith Intl",
                                                   @"Snap-On Inc",
                                                   @"Southern Co",
                                                   @"Southwest Airlines",
                                                   @"Southwestern Energy",
                                                   @"Sprint Nextel Corp",
                                                   @"St. Jude Medical",
                                                   @"Stanley Works",
                                                   @"Starwood Hotels&Res Worldwide",
                                                   @"State Street Corp",
                                                   @"Stericycle Inc",
                                                   @"Stryker Corp",
                                                   @"SunTrust Banks",
                                                   @"Supervalu Inc",
                                                   @"Symantec Corp",
                                                   @"Sysco Corp",
                                                   @"T.Rowe Price Group",
                                                   @"TECO Energy",
                                                   @"Tellabs, Inc",
                                                   @"Tenet Healthcare",
                                                   @"Teradyne Inc",
                                                   @"Texas Instruments",
                                                   @"Textron, Inc",
                                                   @"Thermo Fisher Scientific",
                                                   @"Time Warner",
                                                   @"Torchmark Corp",
                                                   @"Total System Svcs",
                                                   @"Travelers Cos",
                                                   @"U.S. Bancorp",
                                                   @"U.S. Steel",
                                                   @"Union Pacific",
                                                   @"United Parcel",
                                                   @"United Technologies",
                                                   @"UnitedHealth Group",
                                                   @"Unum Group",
                                                   @"Valero Energy",
                                                   @"Varian Medical Systems",
                                                   @"Ventas Inc",
                                                   @"Verizon Communications",
                                                   @"VF Corp",
                                                   @"Viacom Inc",
                                                   @"Vornado Realty Trust",
                                                   @"Vulcan Materials",
                                                   @"Walgreen Co",
                                                   @"Washington Post",
                                                   @"Waste Management",
                                                   @"Waters Corp",
                                                   @"Watson Pharmaceuticals",
                                                   @"WellPoint Inc",
                                                   @"Wells Fargo",
                                                   @"Western Digital",
                                                   @"Western Union",
                                                   @"Whirlpool Corp",
                                                   @"Whole Foods Market",
                                                   @"Williams Cos",
                                                   @"Wisconsin Energy Corp",
                                                   @"Wyndham Worldwide",
                                                   @"Wynn Resorts",
                                                   @"Xcel Energy",
                                                   @"Xerox Corp",
                                                   @"Xilinx Inc",
                                                   @"XL Capital Ltd",
                                                   @"XTO Energy",
                                                   @"Yahoo Inc",
                                                   @"Yum Brands",
                                                   @"Zimmer Holdings@" ,nil];
    }
	return companyNames;
}
+ (NSArray*)lastNames
{
    if(!lastNames){
       lastNames = [[NSArray alloc] initWithObjects:@"SMITH",@"JOHNSON",@"WILLIAMS",@"BROWN",@"JONES",@"MILLER",@"DAVIS",@"GARCIA",@"RODRIGUEZ",@"WILSON",@"MARTINEZ",@"ANDERSON",@"TAYLOR",@"THOMAS",@"HERNANDEZ",@"MOORE",@"MARTIN",@"JACKSON",@"THOMPSON",@"WHITE",@"LOPEZ",@"LEE",@"GONZALEZ",@"HARRIS",@"CLARK",@"LEWIS",@"ROBINSON",@"WALKER",@"PEREZ",@"HALL",@"YOUNG",@"ALLEN",@"SANCHEZ",@"WRIGHT",@"KING",@"SCOTT",nil];
    }
	return lastNames;
}
+ (NSArray*)firstNames
{
    if(!firstNames){
        firstNames = [[NSArray alloc] initWithObjects:@"LATONYA",@"CANDY",@"MORGAN",@"CONSUELO",@"TAMIKA",@"ROSETTA",@"DEBORA",@"CHERIE",@"POLLY",@"DINA",@"JEWELL",@"FAY",@"JILLIAN",@"DOROTHEA",@"NELL",@"TRUDY",@"ESPERANZA",@"PATRICA",@"KIMBERLEY",@"FRANK",@"SCOTT",@"ERIC",@"STEPHEN",@"ANDREW",@"RAYMOND",@"GREGORY",@"JOSHUA",@"JERRY",@"DENNIS",@"WALTER",@"PATRICK",@"PETER",@"HAROLD",@"DOUGLAS",@"HENRY",@"CARL",@"ARTHUR",@"RYAN",nil];
    }
	return firstNames;
}
+ (NSString*)mockNestedXml
{
	return mockNestedXml;
}
@end

