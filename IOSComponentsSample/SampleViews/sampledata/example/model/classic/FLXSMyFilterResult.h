
@interface FLXSMyFilterResult : NSObject
{
	@public
		NSMutableArray* records;
		float totalRecords;
}

@property (nonatomic, strong) NSMutableArray* records;
@property (nonatomic, assign) float totalRecords;


@end

