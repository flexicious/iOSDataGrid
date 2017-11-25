#import "FLXSSystemConstants.h"
#import "FLXSReferenceData.h"

static  FLXSReferenceData* usCountry = nil;//[[ReferenceData alloc] init:1 :(@"US") :(@"United States")];
static  NSArray* cities = nil;//[[[FLXSLabelData alloc] initWithLable:0 andData:'Grand Rapids'],[[ReferenceData alloc] init:2 :'Albany'],[[ReferenceData alloc] init:3 :'Stroudsburgh'],[[ReferenceData alloc] init:4 :'Barrie'],[[ReferenceData alloc] init:5 :'Springfield']];
static  NSArray* states= nil;
static  NSArray* dealStatuses= nil;
static  NSArray* invoiceStatuses= nil;
static  NSArray* billableConsultants= nil;

@implementation FLXSSystemConstants



+ (FLXSReferenceData*)usCountry
{
    if(!usCountry){
          usCountry= [[FLXSReferenceData alloc] initWithId:1 andCode:(@"US") andName:(@"United States")];
    }
	return usCountry;
}
+ (NSArray*)cities
{
    if(!cities){
        cities = [[NSArray alloc] initWithObjects:
                [[FLXSReferenceData alloc] initWithId:0 andCode:@"Grand Rapids" andName:@""],
                [[FLXSReferenceData alloc] initWithId:2 andCode:@"Albany" andName:@""],
                [[FLXSReferenceData alloc] initWithId:3 andCode:@"Stroudsburgh" andName:@""],
                [[FLXSReferenceData alloc] initWithId:4 andCode:@"Barrie" andName:@""],
                [[FLXSReferenceData alloc] initWithId:5 andCode:@"Springfield" andName:@""], nil];
    }
	return cities;
}
+ (NSArray*)states
{   if(!states){
        states = [[NSArray alloc] initWithObjects:

                [[FLXSReferenceData alloc] initWithId:1 andCode:@"MI" andName:@"Michigan"],
                [[FLXSReferenceData alloc] initWithId:2 andCode:@"NY" andName:@"New York"],
                [[FLXSReferenceData alloc] initWithId:3 andCode:@"PA" andName:@"Penn"],
                [[FLXSReferenceData alloc] initWithId:4 andCode:@"NJ" andName:@"New Jersey"],
                [[FLXSReferenceData alloc] initWithId:5 andCode:@"OH" andName:@"Ohio"],
                [[FLXSReferenceData alloc] initWithId:6 andCode:@"NC" andName:@"North Carolina"], nil];
    }
	return states;
}
+ (NSArray*)dealStatuses
{    if(!dealStatuses){
        dealStatuses = [[NSArray alloc] initWithObjects:


                [[FLXSReferenceData alloc] initWithId:1 andCode:@"Prospect" andName:@""],
                [[FLXSReferenceData alloc] initWithId:2 andCode:@"Qualified" andName:@""],
                [[FLXSReferenceData alloc] initWithId:3 andCode:@"In Process" andName:@""],
                [[FLXSReferenceData alloc] initWithId:4 andCode:@"Cancelled" andName:@""],
                [[FLXSReferenceData alloc] initWithId:5 andCode:@"Complete" andName:@""], nil];
    }
	return dealStatuses;
}
+ (NSArray*)invoiceStatuses
{    if(!invoiceStatuses){
        invoiceStatuses = [[NSArray alloc] initWithObjects:

                [[FLXSReferenceData alloc] initWithId:1 andCode:@"Draft" andName:@""],
                [[FLXSReferenceData alloc] initWithId:2 andCode:@"Approved" andName:@""],
                [[FLXSReferenceData alloc] initWithId:3 andCode:@"Transmitted" andName:@""],
                [[FLXSReferenceData alloc] initWithId:4 andCode:@"Paid" andName:@""],
                [[FLXSReferenceData alloc] initWithId:5 andCode:@"Cancelled" andName:@""], nil];
    }
	return invoiceStatuses;
}
+ (NSArray*)billableConsultants
{    if(!billableConsultants){
        billableConsultants = [[NSArray alloc] initWithObjects:

                [[FLXSReferenceData alloc] initWithId:1 andCode:@"Jason Bourne" andName:@""],
                [[FLXSReferenceData alloc] initWithId:2 andCode:@"Lars Wilson" andName:@""],
                [[FLXSReferenceData alloc] initWithId:3 andCode:@"Tarah Silverman" andName:@""],
                [[FLXSReferenceData alloc] initWithId:4 andCode:@"Betty White" andName:@""],
                [[FLXSReferenceData alloc] initWithId:5 andCode:@"Kristian Donovan" andName:@""], nil ];
    }
	return billableConsultants;
}
@end

