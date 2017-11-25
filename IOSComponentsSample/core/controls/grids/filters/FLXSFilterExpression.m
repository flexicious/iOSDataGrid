#import "FLXSFilterExpression.h"
#import "FLXSFlexDataGridColumn.h"
#import "FLXSExtendedUIUtils.h"
#import <objc/message.h>


static NSString* FILTER_OPERATION_TYPE_NONE = @"None";
static NSString* FILTER_OPERATION_TYPE_EQUALS = @"Equals";
static NSString* FILTER_OPERATION_TYPE_NOT_EQUALS = @"NotEquals";
static NSString* FILTER_OPERATION_TYPE_BEGINS_WITH = @"BeginsWith";
static NSString* FILTER_OPERATION_TYPE_ENDS_WITH = @"EndsWith";
static NSString* FILTER_OPERATION_TYPE_CONTAINS = @"Contains";
static NSString* FILTER_OPERATION_TYPE_DOES_NOT_CONTAIN = @"DoesNotContain";
static NSString* FILTER_OPERATION_TYPE_GREATER_THAN = @"GreaterThan";
static NSString* FILTER_OPERATION_TYPE_LESS_THAN = @"LessThan";
static NSString* FILTER_OPERATION_TYPE_GREATER_THAN_EQUALS = @"GreaterThanEquals";
static NSString* FILTER_OPERATION_TYPE_LESS_THAN_EQUALS = @"LessThanEquals";
static NSString* FILTER_OPERATION_TYPE_IN_LIST = @"InList";
static NSString* FILTER_OPERATION_TYPE_NOT_IN_LIST = @"NotInList";
static NSString* FILTER_OPERATION_TYPE_BETWEEN = @"Between";
static NSString* FILTER_OPERATION_TYPE_IS_NOT_NULL = @"IsNotNull";
static NSString* FILTER_OPERATION_TYPE_IS_NULL = @"IsNull";
static NSString* FILTER_COMPARISON_TYPE_AUTO = @"auto";
static NSString* FILTER_COMPARISON_TYPE_STRING = @"string";
static NSString* FILTER_COMPARISON_TYPE_NUMBER = @"number";
static NSString* FILTER_COMPARISON_TYPE_DATE = @"date";
static NSString* FILTER_COMPARISON_TYPE_BOOLEAN = @"boolean";

@implementation FLXSFilterExpression

@synthesize wasContains;
@synthesize columnName;
@synthesize filterOperation;
@synthesize filterComparisonType;
@synthesize expression;
@synthesize filterControlValue;
@synthesize filter;
@synthesize recurse;
@synthesize filterControl;

-(FLXSFilterExpression *)copyFrom:(FLXSFilterExpression *)filterExpression
{
	self.columnName=filterExpression.columnName;
	self.filterOperation = filterExpression.filterOperation;
	self.filterComparisonType = filterExpression.filterComparisonType;
	self.filterControlValue = filterExpression.filterControlValue;
	self.recurse=filterExpression.recurse;
	self.expression = !filterExpression.expression?nil:
            ([filterExpression.expression isKindOfClass:[NSMutableArray class]]
    )? filterExpression.expression :
    ([filterExpression.expression respondsToSelector:NSSelectorFromString(@"item")])?
            [filterExpression.expression valueForKey:@"item"] :
            ([filterExpression.expression respondsToSelector:NSSelectorFromString(@"object")])?
                    [filterExpression.expression valueForKey:@"object"] :filterExpression.expression;
	return self;
}

-(FLXSFilterExpression *)clone
{
	FLXSFilterExpression * filterExpression=[[FLXSFilterExpression alloc] init];
	filterExpression.columnName=self.columnName;
	filterExpression.filterOperation = self.filterOperation;
	filterExpression.filterComparisonType = self.filterComparisonType;
	filterExpression.expression = self.expression;
	filterExpression.filterControlValue=self.filterControlValue;
	filterExpression.recurse=self.recurse;
	return filterExpression;
}

- (id)initWithColumnName:(NSString *)columnNameIn andFilterOperation:(NSString *)filterOperationIn andExpression:(NSObject *)expressionIn {
	self = [super init];
	if (self)
	{
		self.wasContains = NO;
        self.filterOperation = FILTER_OPERATION_TYPE_EQUALS;
        self.filterComparisonType = FILTER_COMPARISON_TYPE_AUTO;
        self.recurse = NO;

		self.columnName = columnNameIn;
		self.filterOperation = filterOperationIn;
		self.expression = expressionIn;
	}
	return self;
}


+ (FLXSFilterExpression *)createFilterExpression:(FLXSFilter *)filter columnName:(NSString *)columnName filterOperation:(NSString *)filterOperation expression:(NSObject *)expression wasContains:(BOOL)wasContains {
	FLXSFilterExpression * filterExpression =  [[FLXSFilterExpression alloc] init];
	filterExpression.filter = filter;
	filterExpression.columnName = columnName;
	filterExpression.expression = expression;
	filterExpression.filterOperation = filterOperation;
	filterExpression.wasContains=wasContains;
	return filterExpression;
}

+ (NSObject *)convert:(NSString *)filterComparisonType object:(NSObject *)object {
	if(object == nil)return object;
	@try
	{
		if([filterComparisonType isEqual: [FLXSFilterExpression FILTER_COMPARISON_TYPE_NUMBER]] && !([object isKindOfClass:[NSNumber class] ]))
		{
			return [NSNumber numberWithFloat:[[object description] floatValue]];
		}
		else if([filterComparisonType isEqual: [FLXSFilterExpression FILTER_COMPARISON_TYPE_DATE]] && !([object isKindOfClass:[NSDate class]]))
		{
			NSString* str =[object description];
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
            NSDate *myDate = [df dateFromString: str];
			return myDate;
		}
		else if([filterComparisonType isEqual: [FLXSFilterExpression FILTER_COMPARISON_TYPE_BOOLEAN]] && !([object isKindOfClass:[NSNumber class]]))
		{
            return [NSNumber numberWithFloat:[[object description] boolValue]];
		}
		else if([filterComparisonType isEqual: [FLXSFilterExpression FILTER_COMPARISON_TYPE_STRING]] && !([object isKindOfClass:[NSString class]] ))
		{
			return [object description];
		}
	}
	@catch(NSException *ex)
	{
        return nil;
	}
	return object;
}

- (BOOL)isMatch:(NSObject *)src grid:(FLXSFlexDataGrid *)grid {

     if ([self.filterControl conformsToProtocol:@protocol(FLXSICustomMatchFilterControl)] )
    {
        NSObject <FLXSICustomMatchFilterControl> *vc = (NSObject <FLXSICustomMatchFilterControl> *) self.filterControl;
        return [vc isMatch:src];
	}
	if([self.filterOperation isEqual: FILTER_OPERATION_TYPE_NONE] ||
		self.expression == nil || src == nil || self.columnName ==nil)return YES;
	NSObject* object=nil;
	FLXSFlexDataGridColumn* col = (FLXSFlexDataGridColumn* )[grid getFilterColumn:self.columnName];
	if(col.filterCompareFunction!=nil)
	{
        //		[return col filterCompareFunction:src :self];
        SEL selector = NSSelectorFromString(col.filterCompareFunction);
        id target = grid.delegate;
        //FLXSFilterExpression *cellRenderedarg = self;
        NSNumber * result = ((NSNumber *(*)(id, SEL, NSObject *, FLXSFlexDataGridColumn *))objc_msgSend)(target, selector, src, col);
        return [result boolValue];
 	}
	if(col.useLabelFunctionForFilterCompare)
	{
		object=[col itemToLabel:src:nil];
	}
	else if(col.filterConverterFunction!=nil)
	{
		//object=[col filterConverterFunction:src :col];

        SEL selector = NSSelectorFromString(col.filterCompareFunction);
        id target = grid.delegate;
        object = ((NSObject*(*)(id, SEL, NSObject*,FLXSFlexDataGridColumn *))objc_msgSend)(target, selector, src, col);
	}
	else if([self.columnName rangeOfString:(@".")].location!=NSNotFound)
	{
		object = [FLXSExtendedUIUtils resolveExpression:src expression:columnName valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];
		if(object==nil)
			return YES;
		//self means the item does not have our field/
	}
	else if([src respondsToSelector:NSSelectorFromString(self.columnName)])
        object =[src valueForKey:self.columnName];
    else if([src isKindOfClass:[NSDictionary class]]){
        object = [FLXSExtendedUIUtils resolveExpression:src expression:columnName valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];

    }
	else
        return YES;
	if(object ==nil)return NO;
	if ([self.filterControl conformsToProtocol:@protocol(FLXSIConverterControl) ] )
	{
		object= [((UIView<FLXSIConverterControl>*)self.filterControl) convert:([object description])];
	}
	else if(![filterComparisonType isEqual: FILTER_COMPARISON_TYPE_AUTO])
	{
		object= [FLXSFilterExpression convert:filterComparisonType object:object];
	}
	//begins with operation - comapre text
    NSString * lhs =   [[object description] lowercaseString];
    NSString * rhs =   [[self.expression description] lowercaseString];
	if([self.filterOperation isEqual: FILTER_OPERATION_TYPE_BEGINS_WITH])
		return ([lhs rangeOfString:rhs].location == 0);
		else if([self.filterOperation isEqual: FILTER_OPERATION_TYPE_CONTAINS])
        return ([lhs rangeOfString:rhs].location != NSNotFound);
		else if([self.filterOperation isEqual: FILTER_OPERATION_TYPE_DOES_NOT_CONTAIN])
            return ([lhs rangeOfString:rhs].location == NSNotFound);
		else if([self.filterOperation isEqual: FILTER_OPERATION_TYPE_BETWEEN])
	{
		NSMutableArray* arr = (NSMutableArray*)self.expression;
		if(arr==nil && ([self.expression isKindOfClass:[NSArray class]]))
		{
			arr = [[NSMutableArray alloc] initWithArray:((NSArray*)(self.expression))];
		}
		//if(arr==nil)throw [[Error alloc] initWithType:(@"Expression is not an array collection for between filter operation")];
        if(arr==nil){
            [FLXSUIUtils raiseExceptionWithType:@"InvalidArgumentException"
                                     andMessage:@"Expression is not an array collection for between filter operation"];
        }
        
		if([arr count] != 2){
            [FLXSUIUtils raiseExceptionWithType:@"InvalidArgumentException" andMessage:@"Invalid expression for between filter operation. Between filter operation requires array colletion with exactly 2 items."];
        }
        if([object isKindOfClass:[NSDate class] ]){
            NSDate *date = (NSDate *)object;
            return ([date compare:arr[0]] == NSOrderedDescending) &&
                    ([date compare:arr[1]] == NSOrderedAscending);
        }
		return (arr[0] <= object) && ( object<=arr[1]);
	}
	else if(self.filterOperation ==  FILTER_OPERATION_TYPE_ENDS_WITH)
        return ([[[object description] lowercaseString] rangeOfString:[[self.expression description] lowercaseString] options:NSBackwardsSearch].location == [object description].length-[self.expression description].length);
else if(self.filterOperation ==  FILTER_OPERATION_TYPE_EQUALS)
return object == self.expression;
	else if(self.filterOperation ==  FILTER_OPERATION_TYPE_GREATER_THAN)
return object > self.expression;
	else if(self.filterOperation ==  FILTER_OPERATION_TYPE_GREATER_THAN_EQUALS)
return object >= self.expression;
	else if(self.filterOperation ==  FILTER_OPERATION_TYPE_IN_LIST)
	{
		NSArray* arr = (NSArray*)self.expression;
		if(arr==nil)
		{
			if([self.expression isKindOfClass:[ NSArray class]])
				arr=[[NSMutableArray alloc] initWithArray:(NSArray*)self.expression];
		}
		if(arr==nil)
        [FLXSUIUtils raiseExceptionWithType:@"InvalidArgumentException" andMessage:@"expression is not an array collection for between filter operation"];
		for(NSObject* obj in arr)
		{
			if(wasContains && obj!=nil && object!=nil)
			{
				if ([[object description] rangeOfString:[obj description]].location != NSNotFound)
				{
					return YES;
				}
			}
			else if([obj isEqual:object])
return YES;
		}
		return NO;
	}
	else if([self.filterOperation isEqual:  FILTER_OPERATION_TYPE_IS_NOT_NULL])
	{
		return object != nil;
	}
	else if([self.filterOperation isEqual:  FILTER_OPERATION_TYPE_LESS_THAN])
return object < self.expression;
	else if([self.filterOperation isEqual:  FILTER_OPERATION_TYPE_LESS_THAN_EQUALS])
return object <= self.expression;
	else if([self.filterOperation isEqual:  FILTER_OPERATION_TYPE_NOT_EQUALS])
return ![object isEqual: self.expression];
	else if([self.filterOperation isEqual:  FILTER_OPERATION_TYPE_NOT_IN_LIST])
	{
		NSMutableArray* arr =(NSMutableArray*) self.expression;
		if(arr==nil)                {
            [FLXSUIUtils raiseExceptionWithType:@"InvalidArgumentException"  andMessage:@"expression is not an array collection for between filter operation"];
        }
        for(NSObject* obj in arr)
		{
			if(obj == object)
				return NO;
		}
		return YES;
	}
	else
    {
        NSException* myException = [NSException
                exceptionWithName:@"InvalidArgumentException"
                           reason:[@"Invalid expression for FLXSFilter expression" stringByAppendingString: [object description]]
                         userInfo:nil];
        @throw myException;
    }
}

+(BOOL)parseBoolean:(NSString*)str
{
    str = [str lowercaseString];
    if([str isEqualToString: @"1"]
            ||[str isEqualToString: @"yes"]
            ||[str isEqualToString: @"y"]
            ||[str isEqualToString: @"true"]
            )
        return YES;
    else
        return NO;
}

+ (NSString*)FILTER_OPERATION_TYPE_NONE
{
	return FILTER_OPERATION_TYPE_NONE;
}
+ (NSString*)FILTER_OPERATION_TYPE_EQUALS
{
	return FILTER_OPERATION_TYPE_EQUALS;
}
+ (NSString*)FILTER_OPERATION_TYPE_NOT_EQUALS
{
	return FILTER_OPERATION_TYPE_NOT_EQUALS;
}
+ (NSString*)FILTER_OPERATION_TYPE_BEGINS_WITH
{
	return FILTER_OPERATION_TYPE_BEGINS_WITH;
}
+ (NSString*)FILTER_OPERATION_TYPE_ENDS_WITH
{
	return FILTER_OPERATION_TYPE_ENDS_WITH;
}
+ (NSString*)FILTER_OPERATION_TYPE_CONTAINS
{
	return FILTER_OPERATION_TYPE_CONTAINS;
}
+ (NSString*)FILTER_OPERATION_TYPE_DOES_NOT_CONTAIN
{
	return FILTER_OPERATION_TYPE_DOES_NOT_CONTAIN;
}
+ (NSString*)FILTER_OPERATION_TYPE_GREATER_THAN
{
	return FILTER_OPERATION_TYPE_GREATER_THAN;
}
+ (NSString*)FILTER_OPERATION_TYPE_LESS_THAN
{
	return FILTER_OPERATION_TYPE_LESS_THAN;
}
+ (NSString*)FILTER_OPERATION_TYPE_GREATER_THAN_EQUALS
{
	return FILTER_OPERATION_TYPE_GREATER_THAN_EQUALS;
}
+ (NSString*)FILTER_OPERATION_TYPE_LESS_THAN_EQUALS
{
	return FILTER_OPERATION_TYPE_LESS_THAN_EQUALS;
}
+ (NSString*)FILTER_OPERATION_TYPE_IN_LIST
{
	return FILTER_OPERATION_TYPE_IN_LIST;
}
+ (NSString*)FILTER_OPERATION_TYPE_NOT_IN_LIST
{
	return FILTER_OPERATION_TYPE_NOT_IN_LIST;
}
+ (NSString*)FILTER_OPERATION_TYPE_BETWEEN
{
	return FILTER_OPERATION_TYPE_BETWEEN;
}
+ (NSString*)FILTER_OPERATION_TYPE_IS_NOT_NULL
{
	return FILTER_OPERATION_TYPE_IS_NOT_NULL;
}
+ (NSString*)FILTER_OPERATION_TYPE_IS_NULL
{
	return FILTER_OPERATION_TYPE_IS_NULL;
}
+ (NSString*)FILTER_COMPARISON_TYPE_AUTO
{
	return FILTER_COMPARISON_TYPE_AUTO;
}
+ (NSString*)FILTER_COMPARISON_TYPE_STRING
{
	return FILTER_COMPARISON_TYPE_STRING;
}
+ (NSString*)FILTER_COMPARISON_TYPE_NUMBER
{
	return FILTER_COMPARISON_TYPE_NUMBER;
}
+ (NSString*)FILTER_COMPARISON_TYPE_DATE
{
	return FILTER_COMPARISON_TYPE_DATE;
}
+ (NSString*)FILTER_COMPARISON_TYPE_BOOLEAN
{
	return FILTER_COMPARISON_TYPE_BOOLEAN;
}
@end

