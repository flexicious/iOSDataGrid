@class FLXSFilter;

@interface FLXSMyFilter : NSObject
{

}

@property (nonatomic, assign) int pageSize;
@property (nonatomic, assign) int pageIndex;
@property (nonatomic, assign) int pageCount;
@property (nonatomic, assign) int recordCount;
@property (nonatomic, strong) NSString* recordType;
@property (nonatomic, strong) NSObject* records;
@property (nonatomic, strong) NSMutableArray* arguments;
@property (nonatomic, strong) NSMutableArray* sorts;

-(id)initWithFilter:(FLXSFilter*)filter;

@end

