#import "FLXSIFlexDataGridCell.h"
#import "FLXSFlexDataGridExpandCollapseHeaderCell.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSRowInfo.h"
#import "FLXSFlexDataGrid.h"

@implementation FLXSFlexDataGridExpandCollapseHeaderCell


-(BOOL)drawTopBorder
{
    //if we're at a nested level, grid does not draw horizontal lines,
    //and there is no filter row, we draw a line above us to seperate ourselves from the data item above.
    return super.drawTopBorder||((self.rowInfo.isHeaderRow && self.level.nestDepth>1
            && !([self.level.grid getStyle: @"horizontalGridLines" ])
            &&(self.level.filterRowHeight==0))
            ||(self.rowInfo.isFilterRow  && self.level.nestDepth>1 && !([self.level.grid getStyle: @"horizontalGridLines" ]))
    );
}


- (void)moveToX:(float)x y:(float)y {
    [super moveToX:x y:y];
}
@end

