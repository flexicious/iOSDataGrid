#import "FLXSVersion.h"
#import "FLXSFlexDataGridCell.h"

@class FLXSFlexDataGridColumnGroup;
@class FLXSEvent;
@class FLXSFlexDataGridColumn;
/**
	 * A container class for all column group cells. In addition to the functionality it inherits from FlexDataGridCell,
	 * it adds support for the following feautres:
	 * <ul>
	 * <li>Ability to span across multiple columns to visually appear as a single column header</li>
	 * </ul>
	 * FlexDataGridColumnGroupCell inherits from FlexDataGridCell, which provides a bulk of the functionality to it.
	 * @inheritDoc
	 */

@interface FLXSFlexDataGridColumnGroupCell : FLXSFlexDataGridCell
{
}
/**
      * The column group associated with this cell.
      **/
@property (nonatomic, weak) FLXSFlexDataGridColumnGroup* columnGroup;
@property (nonatomic, assign) BOOL listenersAdded;
/**
		 * @private
		 */
@property (nonatomic, assign) BOOL background;
@property (nonatomic, assign) BOOL wxInvalid;

/**
		 * @inheritDoc
		 */
-(void)destroy;
/**
		 * @private
		 */
-(void)onColumnsResized:(FLXSEvent*)event;
/**
		 * If there is a columnGroup associated, returns its startColumn property. Else returns
		 * the default column associated with this cell.
		 */
-(FLXSFlexDataGridColumn*)columnFLXS;
/**
		 * @inheritDoc
		 */
-(BOOL)drawTopBorder;
/**
		 * @inheritDoc
		 */
-(void)refreshCell;
-(void)invalidateWX:(NSNotification *)ns;
/**
		 * @inheritDoc
		 */
 -(id)getRolloverColor;
/**
		 * @inheritDoc
		 */
-(id)getBackgroundColors;
/**
		 * @inheritDoc
		 */
-(id)getTextColors;

@end

