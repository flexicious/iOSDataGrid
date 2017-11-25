#import "FLXSFlexDataGridColumn.h"
#import "FLXSVersion.h"

/**
	 * An object that represents information about a cell.
	 */
@interface FLXSCellInfo : NSObject
{
}

@property (nonatomic, weak) NSObject* rowData;
@property (nonatomic, weak) FLXSFlexDataGridColumn*columnFLXS;

- (id)initWithRowData:(NSObject *)rowData andColumn:(FLXSFlexDataGridColumn *)column;

@end

