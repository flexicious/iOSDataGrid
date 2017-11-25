#import "FLXSVersion.h"
#import "FLXSIConverterControl.h"
#import "FLXSICustomMatchFilterControl.h"
#import "FLXSIFilterControl.h"
#import "FLXSIExtendedDataGrid.h"
#import "FLXSFilterPageSortChangeEvent.h"
#import "FLXSUIUtils.h"
#import "FLXSEvent.h"
#import "FLXSFilterExpression.h"
@class FLXSFilter;
/**
	 * A class that represents an individual filter expression
	 * A filter expression consists of a columnName (this is the
	 * property of the object to search), an operation type (one of the
	 * FILTER_OPERATION_TYPE constants) and an expression (the value to search on).
	 */
@interface FLXSFilterExpression : NSObject


@property (nonatomic) BOOL wasContains;
@property (nonatomic, strong) NSString* columnName;
@property (nonatomic, strong) NSString* filterOperation;
@property (nonatomic, strong) NSString* filterComparisonType;
@property (nonatomic, strong) NSObject* expression;
@property (nonatomic, strong) NSObject* filterControlValue;
@property (nonatomic, weak) FLXSFilter * filter;
@property (nonatomic, weak) UIView <FLXSIFilterControl>*filterControl;
@property (nonatomic) BOOL recurse;

-(FLXSFilterExpression *)copyFrom:(NSObject*)filterExpression;
-(FLXSFilterExpression *)clone;

- (id)initWithColumnName:(NSString *)columnName andFilterOperation:(NSString *)filterOperation andExpression:(NSObject *)expression;

+ (FLXSFilterExpression *)createFilterExpression:(FLXSFilter *)filter columnName:(NSString *)columnName filterOperation:(NSString *)filterOperation expression:(NSObject *)expression wasContains:(BOOL)wasContains;

+ (NSObject *)convert:(NSString *)filterComparisonType object:(NSObject *)object;

- (BOOL)isMatch:(NSObject *)src grid:(FLXSFlexDataGrid *)grid;
+(BOOL)parseBoolean:(NSString*)str;

+ (NSString*)FILTER_OPERATION_TYPE_NONE;
+ (NSString*)FILTER_OPERATION_TYPE_EQUALS;
+ (NSString*)FILTER_OPERATION_TYPE_NOT_EQUALS;
+ (NSString*)FILTER_OPERATION_TYPE_BEGINS_WITH;
+ (NSString*)FILTER_OPERATION_TYPE_ENDS_WITH;
+ (NSString*)FILTER_OPERATION_TYPE_CONTAINS;
+ (NSString*)FILTER_OPERATION_TYPE_DOES_NOT_CONTAIN;
+ (NSString*)FILTER_OPERATION_TYPE_GREATER_THAN;
+ (NSString*)FILTER_OPERATION_TYPE_LESS_THAN;
+ (NSString*)FILTER_OPERATION_TYPE_GREATER_THAN_EQUALS;
+ (NSString*)FILTER_OPERATION_TYPE_LESS_THAN_EQUALS;
+ (NSString*)FILTER_OPERATION_TYPE_IN_LIST;
+ (NSString*)FILTER_OPERATION_TYPE_NOT_IN_LIST;
+ (NSString*)FILTER_OPERATION_TYPE_BETWEEN;
+ (NSString*)FILTER_OPERATION_TYPE_IS_NOT_NULL;
+ (NSString*)FILTER_OPERATION_TYPE_IS_NULL;
+ (NSString*)FILTER_COMPARISON_TYPE_AUTO;
+ (NSString*)FILTER_COMPARISON_TYPE_STRING;
+ (NSString*)FILTER_COMPARISON_TYPE_NUMBER;
+ (NSString*)FILTER_COMPARISON_TYPE_DATE;
+ (NSString*)FILTER_COMPARISON_TYPE_BOOLEAN;
@end

