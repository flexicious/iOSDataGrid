
@class FLXSFilterExpression;

@interface FLXSMyFilterExpression : NSObject
{

}

@property (nonatomic, strong) NSString* columnName;
@property (nonatomic, strong) NSString* filterOperation;
@property (nonatomic, strong) NSObject* expression;

-(id)initWithFilterExpression:(FLXSFilterExpression*)filterExpression;

@end

