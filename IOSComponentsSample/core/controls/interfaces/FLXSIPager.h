#import "FLXSVersion.h"
#import "FLXSIExtendedDataGrid.h"
/**
	 * @private
	 * A interface so we can write code that targets
	 * both grids without having to explicitly work
	 * against their concrete types
	 */
@protocol FLXSIExtendedDataGrid;

@protocol FLXSIPager

@property (nonatomic,assign) int pageIndex;
@property (nonatomic,assign) int totalRecords;
@property (nonatomic,assign) int pageSize;
@property (nonatomic,strong) FLXSFlexDataGrid* grid;

-(void)pagerPosition:(NSString*)val;
-(void)reset;
-(void)reBuild;
@end

