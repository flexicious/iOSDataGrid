#import "FLXSBaseEntity.h"

@interface FLXSPagedResult : NSObject
{
}

@property (nonatomic, strong) NSMutableArray* collection;
@property (nonatomic, assign) int totalRecords;
@property (nonatomic, strong) NSDictionary* summaryData;

- (id)initWithCollection:(NSMutableArray *)collection andTotalRecords:(float)totalRecords andSummaryData:(NSDictionary *)summaryData andDeepClone:(BOOL)deepClone;

@end

