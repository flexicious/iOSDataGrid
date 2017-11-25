

@class FLXSFilterSort;

@interface FLXSMyFilterSort : NSObject
{
	@public
		NSString* sortColumn;
		BOOL isAscending;
}

@property (nonatomic, strong) NSString* sortColumn;
@property (nonatomic, assign) BOOL isAscending;

-(id)initWithFilterSort:(FLXSFilterSort*)filterSort;

@end

