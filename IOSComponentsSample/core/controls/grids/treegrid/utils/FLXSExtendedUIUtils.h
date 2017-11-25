#import "FLXSVersion.h"
@class FLXSFilter;
@class FLXSFlexDataGridColumnLevel;
@class FLXSFilterExpression;
@protocol FLXSIExtendedDataGrid;
@class FLXSFlexDataGrid;

@interface FLXSExtendedUIUtils : NSObject
+(NSString*)toString:(NSObject*)host;

+ (id)resolveExpression:(NSObject *)host expression:(NSString *)expression valueToApply:(NSObject *)valueToApply returnUndefinedIfPropertyNotFound:(BOOL)returnUndefinedIfPropertyNotFound applyNullValues:(BOOL)applyNullValues;

+ (NSArray *)sortArray:(NSArray *)arrayIn sorts:(NSArray *)sorts delegateForSortCompareFunctions:(id)delegateForSortCompareFunctions;
+(UIColor *)getColorName:(UInt32)hex ;

+ (NSArray *)pageArray:(NSArray *)arrayIn pageIndex:(int)pageIndex pageSize:(int)pageSize;

+ (NSArray *)pageArrayByPageNumbers:(NSArray *)arrayIn pageIndexes:(NSArray *)pageIndexes pageSize:(int)pageSize;

+ (NSArray *)filterArray:(NSArray *)arrayIn filter:(FLXSFilter *)filter grid:(FLXSFlexDataGrid *)grid level:(FLXSFlexDataGridColumnLevel *)level hideIfNoChildren:(BOOL)hideIfNoChildren;

+ (BOOL)filterRecursive:(NSArray *)obj filter:(FLXSFilter *)filter level:(FLXSFlexDataGridColumnLevel *)level hideIfNoChildren:(BOOL)hideIfNoChildren;

+ (BOOL)recursiveMatch:(NSArray *)items filter:(FLXSFilter *)filter grid:(FLXSFlexDataGrid *)grid level:(FLXSFlexDataGridColumnLevel *)level recursingExpression:(FLXSFilterExpression *)recursingExpression;

+ (NSArray *)filterArrayFlat:(NSArray *)arrayIn filter:(FLXSFilter *)filter;

+ (NSArray *)filterPageSort:(NSArray *)flat filter:(FLXSFilter *)filter pages:(NSArray *)pages flatFilter:(BOOL)flatFilter;
+(float)nanToZero:(NSNumber *)input;

+ (void)gradientFill:(UIView *)comp colors:(NSArray *)colors paddingX:(int)paddingX paddingY:(int)paddingY;

+ (BOOL)isInUIHierarchy:(UIView *)child parent:(UIView *)parent;
@end

