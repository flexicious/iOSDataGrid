#import "FLXSVersion.h"
#import "FLXSFlexDataGridCell.h"
#import "FLXSIFlexDataGridDataCell.h"
/**
	 * @inheritDoc
	 */

@interface FLXSFlexDataGridDataCell : FLXSFlexDataGridCell     <FLXSIFlexDataGridDataCell>
{
}

@property (nonatomic, assign) int colSpan;
@property (nonatomic, assign) int rowSpan;
/**
  * @copy com.flexicious.nestedtreedatagrid.cells.FlexDataGridCell#refreshCell
  */
-(void)refreshCell;
/**
		 * In case of column.enableHierarchicalNestIndent, returns maxPaddingCellWidth else returns zero
		 */
-(float)getLeftPadding;

@end

