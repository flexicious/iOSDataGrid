#import "FLXSCellInfo.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSFlexDataGrid.h"


@implementation FLXSCellInfo

@synthesize rowData;
@synthesize columnFLXS;

- (id)initWithRowData:(NSObject *)rowDataIn
            andColumn:(FLXSFlexDataGridColumn *)columnIn {
	self = [super init];
	if (self)
	{
		self.rowData = rowDataIn;
		self.columnFLXS = columnIn;
	}
	return self;
}
-(NSString *) cellDescription{
    return [[[NSArray alloc] initWithObjects:@"Cell Index:", [NSNumber numberWithInt:self.columnFLXS.colIndex], @", Row Index: ",
                    [NSNumber numberWithInt:(int)[self.columnFLXS.level.grid.dataProviderFLXS indexOfObject:self.rowData]],nil] componentsJoinedByString:@""];
}
@end

