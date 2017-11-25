#import "FLXSFilter.h"
#import "FLXSFilterSort.h"
#import "FLXSFilterExpression.h"

static NSString* ALL_ITEM = @"All";

@implementation FLXSFilter

-(void)copyFrom:(FLXSFilter *)filter
{
	self.filterDescription = filter.filterDescription;
	self.pageSize = filter.pageSize;
	self.pageIndex = filter.pageIndex;
	self.pageCount = filter.pageCount;
	self.recordCount = filter.recordCount;
 	if(filter.arguments)
	{
		NSMutableArray * clonedArguments = [[NSMutableArray alloc] init];
		for(FLXSFilterExpression * arg in filter.arguments)
		{
			FLXSFilterExpression * filterExpression=[[FLXSFilterExpression alloc] init];
			[filterExpression copyFrom:arg];
			if(filterExpression.expression!=nil || filterExpression.filterControlValue)
				[clonedArguments addObject:filterExpression];
		}
		self.arguments=clonedArguments;
	}
	NSMutableArray* sortsCollection = filter.sorts;
	if(sortsCollection)
	{
        NSMutableArray* clonedSorts = [[NSMutableArray alloc] init];
		for(NSObject* argSort in sortsCollection)
		{
			FLXSFilterSort * filterSort=[[FLXSFilterSort alloc] init];
			[filterSort copyFrom:argSort];
			[clonedSorts addObject:filterSort];
		}
		self.sorts=clonedSorts;
	}
}

-(id)init
{
	self = [super init];
	if (self)
	{
		self.pageSize = 20;
		self.pageIndex = -1;
		self.arguments = [[NSMutableArray alloc] init];
		self.sorts = [[NSMutableArray alloc] init];

	}
	return self;
}

-(int)pageCount
{
	return _pageCount<1?1:0;
	//there is always at least 1 page...
}

- (void)addSort:(NSString *)sortColumn isAscending:(BOOL)isAscending sortComparisonType:(NSString *)sortComparisonType sortCompareFunction:(NSString *)sortCompareFunction {
	for(FLXSFilterSort * filterSort in self.sorts)
	{
		if(filterSort.sortColumn == sortColumn)
		{
			filterSort.isAscending = isAscending;
			filterSort.sortComparisonType = sortComparisonType;
			filterSort.sortCompareFunction = sortCompareFunction;
			return;
		}
	}
	FLXSFilterSort * newSort = [[FLXSFilterSort alloc] init];
	newSort.sortColumn = sortColumn;
	newSort.isAscending = isAscending;
	newSort.sortComparisonType=sortComparisonType;
	newSort.sortCompareFunction = sortCompareFunction;
	[self.sorts addObject:newSort];
}

- (void)addCriteria:(NSString *)columnName expression:(NSObject *)expression {
	[self addOperatorCriteria:columnName operation:[FLXSFilterExpression FILTER_OPERATION_TYPE_EQUALS] compareValue:expression wasContains:false ];
}

- (void)addOperatorCriteria:(NSString *)columnName operation:(NSString *)operation compareValue:(NSObject *)compareValue wasContains:(BOOL)wasContains {
	for(FLXSFilterExpression * filterExpression in self.arguments)
	{
		if([filterExpression.columnName isEqual: columnName])
		{
			filterExpression.expression = compareValue;
			filterExpression.filterOperation = operation;
			return;
		}
	}
	[self.arguments addObject:([FLXSFilterExpression createFilterExpression:self columnName:columnName filterOperation:operation expression:compareValue wasContains:wasContains])];
}

-(void)addFilterExpression:(FLXSFilterExpression *)filterExpression
{
	[self addOperatorCriteria:filterExpression.columnName operation:filterExpression.filterOperation compareValue:filterExpression.expression wasContains:filterExpression.wasContains];
}

-(void)removeCriteria:(NSString*)searchField
{
	NSObject* argument= [FLXSUIUtils doesArrayContainValue:self.arguments valFld:(@"ColumnName") compareVal:searchField];
	if(argument!=nil)
	{
		[self.arguments removeObjectAtIndex:([self.arguments indexOfObject:argument])];
	}
}

-(id)getFilterValue:(NSString*)fld
{
	for(FLXSFilterExpression * exp in self.arguments)
	{
		if([exp.columnName isEqual:fld])
		{
			return exp.filterControlValue?exp.filterControlValue:exp.expression;
		}
	}
	return nil;
}

-(id)getFilterExpression:(NSString*)fld
{
	for(FLXSFilterExpression * exp in self.arguments)
	{
		if([exp.columnName isEqual:fld])
		{
			return [exp clone];
		}
	}
	return nil;
}

+ (NSString*)ALL_ITEM
{
	return ALL_ITEM;
}
+(void)setALL_ITEM:(NSString *)val
{
    ALL_ITEM=val;
}

@end

