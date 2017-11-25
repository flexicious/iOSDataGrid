#import "FLXSVersion.h"
#import "FLXSEvent.h"

@class FLXSFlexDataGrid;
@class FLXSFlexDataGridColumnLevel;
@protocol FLXSIFlexDataGridCell;
@class FLXSFlexDataGridColumn;
/**
	 * Event class for most FlexDataGridEvent Events
	 */

@interface FLXSFlexDataGridEvent : FLXSEvent
{

}
/**
* The column associated with the cell that triggered this event
*/
@property (nonatomic, weak) FLXSFlexDataGridColumn*columnFLXS;
/**
		 * The level associated with the cell that triggered this event
		 */
@property (nonatomic, weak) FLXSFlexDataGridColumnLevel* level;
/**
		 * The grid associated with the cell that triggered this event
		 */
@property (nonatomic, weak) FLXSFlexDataGrid* grid;
/**
		 * The cell that triggered this event
		 */
@property (nonatomic, weak) UIView <FLXSIFlexDataGridCell>*cellFLXS;
/**
		 * The data item associated with this cell
		 */
@property (nonatomic, weak) NSObject* item;
/**
		 * For ITEM_CLICK, this flag indicates if the item is being selected or unselected.
		 */
@property (nonatomic, assign) BOOL isItemSelected;
/**
		 * The event that triggered this event. For example, a mouse click on a cell triggers an Item Click on the grid.
		 */
@property (nonatomic, weak) FLXSEvent* triggerEvent;

- (id)initWithType:(NSString *)type andGrid:(FLXSFlexDataGrid *)grid andLevel:(FLXSFlexDataGridColumnLevel *)level andColumn:(FLXSFlexDataGridColumn *)column andCell:(UIView <FLXSIFlexDataGridCell> *)cell andItem:(NSObject *)item andTriggerEvent:(FLXSEvent *)triggerEvent andBubbles:(BOOL)bubbles andCancelable:(BOOL)cancelable;
-(FLXSEvent*)clone;

+ (NSString*)CHANGE;
+ (NSString*)CREATION_COMPLETE;

+ (NSString*)AUTO_REFRESH;
+ (NSString*)DATA_PROVIDER_CHANGE;
+ (NSString*)COLUMNS_RESIZED;
+ (NSString*)COLUMN_STRETCH;

+ (NSString*)COLUMNS_SHIFT;
+ (NSString*)COMPONENTS_CREATED;
+ (NSString*)COLUMN_RESIZED;
+ (NSString*)COLUMN_X_CHANGED;
+ (NSString*)HEADER_CLICKED;
+ (NSString*)SELECT_ALL_CHECKBOX_CHANGED;
+ (NSString*)ITEM_OPEN;
+ (NSString*)ITEM_OPENING;
+ (NSString*)ITEM_CLOSE;
+ (NSString*)ITEM_CLOSING;
+ (NSString*)ITEM_EDIT_CANCEL;
+ (NSString*)ITEM_EDIT_VALUE_COMMIT;
+ (NSString*)ITEM_EDIT_END;
+ (NSString*)ITEM_EDIT_BEGINNING;
+ (NSString*)ITEM_EDIT_BEGIN;
+ (NSString*)ITEM_EDITOR_CREATED;
+ (NSString*)ITEM_FOCUS_IN;
+ (NSString*)ITEM_ROLL_OVER;
+ (NSString*)ITEM_ROLL_OUT;
+ (NSString*)ITEM_CLICK;
+ (NSString*)ITEM_RIGHT_CLICK;
+ (NSString*)ITEM_DOUBLE_CLICK;
+ (NSString*)DYNAMIC_LEVEL_CREATED;
+ (NSString*)DYNAMIC_ALL_LEVELS_CREATED;
+ (NSString*)ICON_MOUSE_OVER;
+ (NSString*)ICON_CLICK;
+ (NSString*)ICON_MOUSE_OUT;
+ (NSString*)PREBUILT_FILTER_RUN;
+ (NSString*)RENDERER_INITIALIZED;
+ (NSString*)CELL_RENDERED;
+ (NSString*)CELL_CREATED;
+ (NSString*)PLACING_SECTIONS;
+ (NSString*)SCROLL;
@end

