#import "FLXSFlexDataGridCell.h"
#import "UIView+UIViewAdditions.h"

@class FLXSFlexDataGridColumnLevel;

/**
	 * A container class for all header cells. In addition to the functionality it inherits from FlexDataGridCell,
	 * it adds support for the following feautres:
	 * <ul>
	 * <li>Ability to trigger a column resize</li>
	 * <li>Ability to render sort icons and multiColumnSort labels</li>
	 * <li>Ability to render and initialize the checkbox header</li>
	 * </ul>
	 *
	 * FlexDataGridHeaderCell inherits from FlexDataGridCell, which provides a bulk of the functionality to it.
	 * @inheritDoc
	 */
@interface FLXSFlexDataGridHeaderCell : FLXSFlexDataGridCell
{

}
/**
* @private
*/
@property (nonatomic, assign) BOOL resizing;
/**
		 * @private
		 */
@property (nonatomic, assign) BOOL resizingPrevious;
/**
		 * @private
		 */
@property (nonatomic, assign) BOOL sortAscending;
/**
		 * @private
		 */
@property (nonatomic, assign) BOOL sortable;
@property (nonatomic, weak) UIView* icon;
@property (nonatomic, weak) UIView* sortLabel;
@property (nonatomic, assign) float iconOffset;


/**
  * Removes the sort icon and the sort label
  */
-(void)destroySortIcon;
/**
		 * @private
		 */
-(void)columnFLXS:(FLXSFlexDataGridColumn*)value;
/**
		 * Creates the sort icon. Depending whether the enableMultiColumnSort
		 * flag is set to true, this method will create a sort label as well, which
		 * is responsible for initializing the icon.
		 */
-(void)createSortIcon:(UIView*)container;
/**
* Sets the size of the renderer, accounting for the width of the split header or the icon.
* If enableSplitHeader is set to true, reduces the renderer's width by grid.headerSortSeparatorRight
* If sort icon is rendererd, reduces the renderer's width by the icons width.
* @inheritDoc
*/
- (void)setRendererSize:(UIView *)cellRenderer width:(float)w height:(float)h;
/**
		 * @inheritDoc
		 */
-(void)destroy;
/**
		 * Returns icon!=null
		 */
-(BOOL)isSorted;
/**
		 * @inheritDoc
		 */
-(void)refreshCell;
/**
		 * Places the sort icon after it is created. By default the column is placed 3 pixels from the right, half way from the top.
		 * If the enableMultiColumnSort flag is set to true, the label is places above or below the icon based on if it is ascending or
		 * descending respectively.
		 */
-(void)placeSortIcon;
/**
		 * Draws the little gray line between the header that does the actual sort
		 * and the multi column sort part of the header that adds the current column to the existing sort.
		 */
-(void)drawSortSeparator;
/**
		 * @inheritDoc
		 */
-(id)getBackgroundColors;
/**
		 * @inheritDoc
		 */
-(id)getTextColors;
/**
		 * @inheritDoc
		 */
-(void)initializeCheckBoxRenderer:(UIView*)renderer;
/**
		 * Handler for checkbox check change.
		 * If the target is the top level (grid.columnLevel) checkbox, dispatches the SELECT_ALL_CHECKBOX_CHANGED event, and calls
		 * selectAll on the associated top level.
		 * Calls level.selectRow method based on checkbox state, and whether or not grid.enableSelectionExclusion is set to true.
		 */
-(void)onCheckChange:(NSNotification*)event;
/**
* Select all items passed in
*/
- (void)selectLevel:(FLXSFlexDataGridColumnLevel *)checkLevel items:(NSArray *)items checked:(BOOL)checked;
/**
		 * @inheritDoc
		 */
-(id)getRolloverColor;
/**
		 * @inheritDoc
		 */
-(NSString*)prefix;
/**
		 * @inheritDoc
		 */
-(BOOL)drawTopBorder;

@end

