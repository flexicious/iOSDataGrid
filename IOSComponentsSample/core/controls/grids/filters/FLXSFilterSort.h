#import "FLXSVersion.h"

/**
	 * The advanced grid supports multi column sorting
	 * This class was created in order to provide server
	 * support for multi column sorting.
	 */
@interface FLXSFilterSort : NSObject

@property (nonatomic, strong) NSObject*columnFLXS;
@property (nonatomic, strong) NSString* sortColumn;
@property (nonatomic, strong) NSString* sortCompareFunction;
@property (nonatomic, assign) BOOL isAscending;
@property (nonatomic, strong) NSString* sortComparisonType;
/**
		 * Ultimate has support to define caseInsensitive sorts
		 */
@property (nonatomic, assign) BOOL sortCaseInsensitive;
/**
		 * Ultimate has support to define numeric sorts
		 */
@property (nonatomic, assign) BOOL sortNumeric;

- (id)initWithSortColumn:(NSString *)sortColumn andIsAscending:(BOOL)isAscending;
-(void)copyFrom:(NSObject*)filterSort;

@end

