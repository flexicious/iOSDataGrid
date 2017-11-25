#import "FLXSVersion.h"
#import "FLXSUIUtils.h"
@class FLXSFilterExpression;
/**
	 * A container object that encapsulates all the
	 * individual property filter settings, page settings
	 * and the sort state.
	 */
@interface FLXSFilter : NSObject
{

}
@property(nonatomic,assign) id delegateForSortCompareFunctions;                       // default nil. weak reference
/**
* Size of the page
* @return
*
*/
@property (nonatomic, assign) int pageSize;
/**
		 * The current page index.
		 * @return
		 *
		 */
@property (nonatomic, assign) int pageIndex;
/**
		 * The number of pages
		 * @return
		 *
		 */
@property (nonatomic, assign) int pageCount;
/**
		 * The total number of records
		 * @return
		 *
		 */
@property (nonatomic, assign) int recordCount;
/**
		 * A collection of com.flexicious.grids.filters.FilterExpression
		 * objects.
		 * @see com.flexicious.grids.filters.FilterExpression
		 */
@property (nonatomic, strong) NSMutableArray* arguments;
/**
		 * A collection of com.flexicious.grids.filters.FilterSort
		 * objects. Must be just 1 for Basic DataGrid, but can be
		 * more than one for advanced datagrid.
		 * @see com.flexicious.grids.filters.FilterExpression
		 */
@property (nonatomic, strong) NSMutableArray* sorts;
@property (nonatomic, strong) NSString* filterDescription;
@property (nonatomic, strong) NSObject* records;


-(void)copyFrom:(NSObject*)filter;

- (void)addSort:(NSString *)sortColumn isAscending:(BOOL)isAscending sortComparisonType:(NSString *)sortComparisonType sortCompareFunction:(NSString *)sortCompareFunction;

- (void)addCriteria:(NSString *)columnName expression:(NSObject *)expression;
/**
* Expression to add
* @param filterExpression
*
*/
- (void)addOperatorCriteria:(NSString *)columnName operation:(NSString *)operation compareValue:(NSObject *)compareValue wasContains:(BOOL)wasContains;
/**
		 * Expression to add
		 * @param filterExpression
		 *
		 */
-(void)addFilterExpression:(FLXSFilterExpression *)filterExpression;
/**
		 * Removes a previously added com.flexicious.grids.filters.FilterExpression from the current list
		 * that matches the specified search field.
		 * @param searchField
		 * @see com.flexicious.grids.filters.FilterExpression
		 */
-(void)removeCriteria:(NSString*)searchField;
/**
		 * Given a filter column, returns the corresponding value of the filter expression of that column.
		 */
-(id)getFilterValue:(NSString*)fld;
/**
		 * Given a filter column, returns the corresponding filter expression.
		 */
-(id)getFilterExpression:(NSString*)fld;

+ (NSString*)ALL_ITEM;
+(void)setALL_ITEM:(NSString *)val;

@end

