#import "FLXSMyFilterExpression.h"
#import "FLXSDemoVersion.h"


@implementation FLXSMyFilterExpression

@synthesize columnName;
@synthesize filterOperation;
@synthesize expression;

-(id)initWithFilterExpression:(FLXSFilterExpression*)filterExpression
{
	self = [super init];
	if (self)
	{
		filterOperation = FLXSFilterExpression.FILTER_OPERATION_TYPE_EQUALS;
		
		self.columnName= filterExpression.columnName;
		self.filterOperation= filterExpression.filterOperation;
        self.expression = filterExpression.expression;
	}
	return self;
}

@end

