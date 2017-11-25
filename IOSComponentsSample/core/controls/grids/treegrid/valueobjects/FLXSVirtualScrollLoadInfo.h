#import "FLXSVersion.h"
@class FLXSFlexDataGridColumnLevel;

/**
	 * When grid.enableVirtualScroll=true, the grid dispatches a virtualScroll event when the grid scrolls.
	 * This event contains a recordsToLoad array, which contains an series of VirtualScrollLoadInfo records.
	 * This provides the application a list of record indexes to load, and which levels to load them at.
	 *
	 * In flat grids, the FlexDataGridVirtualScrollEvent.recordsToLoad will always contain a list of VirtualScrollLoadInfo records were level=1.
	 * For nested grids, depending on where the user scrolls and which items are open, you could get a list of records from multiple levels,
	 * for example. Records 1-3 from level 1, All children of record 3 from level 2, and then Record 4-10 from level 1.
	 *
	 * Setting enableVirtualScroll requires that you specify childrenCountField as well as selectedKeyField.
	 * Additionally, enableVirtualScroll also requires that you set filterPageSortMode=server and
	 * itemLoadMode=server. Finally, virtual scroll does not work with variableRowHeights.
	 */
@interface FLXSVirtualScrollLoadInfo : NSObject
{
}
/**
* FlexDataGridColumnLevel that this item belongs to
*/
@property (nonatomic, weak) FLXSFlexDataGridColumnLevel* level;
/**
		 * The record index.
		 * */
@property (nonatomic, assign) int recordIndex;
/**
		 * The verticalScrollPosition that this record appears at
		 */
@property (nonatomic, assign) float verticalScrollPosition;
/**
		 * The "area" covered by this item. Includes any children.
		 */
@property (nonatomic, assign) float itemHeight;
/**
		 * Pointer to the item. Should be populated before calling setVirtualScrollData.
		 */
@property (nonatomic, weak) NSObject* item;
/**
		 * Pointer to the parent item.
		 */
@property (nonatomic, weak) NSObject* parent;
/**
		 * Type of the row.
		 */
@property (nonatomic, assign) int rowType;

- (id)initWithLevel:(FLXSFlexDataGridColumnLevel *)level andRecordIndex:(int)recordIndex andVerticalScrollPosition:(float)verticalScrollPosition andItemHeight:(float)itemHeight andItem:(NSObject *)item andParent:(NSObject *)parent andRowType:(int)rowType;
/**
		 * The nest depth of the level
		 */
-(int)levelNestDepth;
-(float)itemArea;
-(BOOL)isParentOf:(FLXSVirtualScrollLoadInfo*)child;

@end

