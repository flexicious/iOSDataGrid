#import "FLXSVersion.h"
#import "FLXSUIUtils.h"
#import "FLXSFlexDataGridItemEditEvent.h"
#import "FLXSFlexDataGridCheckBoxColumn.h"
#import "FLXSFlexDataGridFooterCell.h"
#import "FLXSFlexDataGridFilterCell.h"
#import "FLXSFlexDataGridPagerCell.h"
#import "FLXSFlexDataGridLevelRendererCell.h"
#import "FLXSFlexDataGridExpandCollapseCell.h"
#import "FLXSFlexDataGridColumnGroupCell.h"
#import "FLXSFlexDataGridExpandCollapseHeaderCell.h"
#import "FLXSISelectFilterControl.h"

@class FLXSEvent;
@class FLXSFlexDataGrid;
@protocol FLXSIFlexDataGridCell;
@class FLXSRowPositionInfo;
@class FLXSFlexDataGridColumnLevel;
@class FLXSComponentInfo;
@class FLXSRowInfo;
@class FLXSFlexDataGridFooterCell;
@class FLXSFlexDataGridColumn;
@class FLXSItemLoadInfo;
@class FLXSComponentAdditionResult;
@class FLXSFilterPageSortChangeEvent;
@class FLXSClassFactory;
@class FLXSAdvancedFilter;
@class FLXSFlexDataGridColumnGroupCell;
@protocol FLXSIFlexDataGridDataCell;
@class FLXSFlexDataGrid;
@class FLXSFlexDataGridHeaderCell;
@class FLXSFlexDataGridCell;
@class FLXSFlexDataGridHeaderSeparator;
@class FLXSFlexDataGridPaddingCell;
@protocol FLXSIFilterControl;
@class FLXSFlexDataGridColumnGroup;
@class FLXSUIUtils;
@class FLXSFlexDataGridCheckBoxColumn;
@class FLXSKeyValuePairCollection;

/**
	 * FlexDataGridContainerBase is the base class for each of the containers of the grid. The Header, Footer, Pager and Filter Rows.
	 * The grid has the following containers:
	 * <ul>
	 * <li>leftLockedHeader (com.flexicious.nestedtreedatagrid.cells.LockedContent) - The container for the left locked filter and header cells. This is an instance of the LockedContent class, which basically is an extended UIComponent that manages the filter and footer cell visibility, heights, and the y positions.</li>
	 * <li>leftLockedContent (com.flexicious.nestedtreedatagrid.cells.ElasticContainer) - The container for the left locked data cells. This is an instance of the ElasticContainer class, which basically attaches to the owner component (which is the bodyContainer) and scrolls vertically along with it. The horizontal scroll of this component is set to off)</li>
	 * <li>leftLockedFooter (com.flexicious.nestedtreedatagrid.cells.LockedContent)</li>
	 * <li>filterContainer (com.flexicious.nestedtreedatagrid.cells.FlexDataGridChromeContainer)</li>
	 * <li>headerContainer (com.flexicious.nestedtreedatagrid.cells.FlexDataGridChromeContainer)</li>
	 * <li>bodyContainer(com.flexicious.nestedtreedatagrid.cells. FlexDataGridBodyContainer)</li>
	 * <li>footerContainer (com.flexicious.nestedtreedatagrid.cells.FlexDataGridChromeContainer)</li>
	 * <li>rightLockedHeader (com.flexicious.nestedtreedatagrid.cells.LockedContent)</li>
	 * <li>rightLockedContent (com.flexicious.nestedtreedatagrid.cells.ElasticContainer)</li>
	 * <li>rightLockedFooter (com.flexicious.nestedtreedatagrid.cells.LockedContent)</li>
	 * <li>pagerContainer (com.flexicious.nestedtreedatagrid.cells.FlexDataGridChromeContainer) </li>
	 * </ul>
	 *
	 * The filter, header, footer and pager containers are of type FlexDataGridChromeContainer that inherit from FlexDataGridContainerBase.
	 */
@interface FLXSFlexDataGridContainerBase : UIScrollView <UIScrollViewDelegate>
{

}
/**
 * The grid that we belong to
 */
@property (nonatomic, weak) FLXSFlexDataGrid* grid;
/**
		 * @private
		 */
@property (nonatomic, assign) BOOL verticalSpill;
/**
		 * Collection of RowInfo objects currently being displayed. The Header,Footer and Filter containers
		 * usually have only one row, while the body container has as many rows an be shown in the currently
		 * visible area.
		 */
@property (nonatomic, strong) NSMutableArray* rows;
/**
		 * @private
		 */
@property (nonatomic, strong) FLXSKeyValuePairCollection* sortInfo;
/**
		 * @private
		 */
@property (nonatomic, strong) NSMutableArray* loadedItems;
/**
		 * Row positions
		 * @return
		 */
@property (nonatomic, strong) NSMutableArray* itemVerticalPositions;
/**
		 * @private
		 */
@property (nonatomic, assign) float verticalMask;
/**
		 * @private
		 */
@property (nonatomic, assign) float horizontalMask;
/**
		 * @private
		 */
@property (nonatomic, assign) float horizontalScrollPending;
/**
		 * Flag to turn on horizontal scroll recycle. Should be turned off in case of using ICustomMatchFilterControl, since you do not want these
		 * controls to be recycled.
		 */
@property (nonatomic, assign) BOOL enableHorizontalRecycling;
@property (nonatomic, assign) BOOL columnDraggingToRight;
@property (nonatomic, assign) BOOL keyboardhandled;
@property (nonatomic, strong) UIView<FLXSIFlexDataGridCell>* lastMouseOutCell;
/**
		 *  Last selected Row Index
		 */
@property (nonatomic, assign) int lastSelectedRowIndex;
/**
		 * Timer to prevent double click from causing two item clicks.
		 */
@property (nonatomic, strong) NSTimer* itemClickTimer;
/**
		 * Duration, in milliseconds to wait until dispatching a new ITEM_CLICK event. Prevents two ITEM_CLICK events when user double clicks. Defaults to 250
		 */
@property (nonatomic, assign) float itemClickTimerDuration;
/**
		 * Returns true if grid is in edit mode
		 * @return
		 *
		 */
@property (nonatomic, assign) BOOL inEdit;
@property (nonatomic, assign) BOOL prevDefaultButtonEnabled;
@property (nonatomic, assign) BOOL validationFailed;
/**
		 * @private
		 */
@property (nonatomic, assign) int resizeCursorID;

/**
		 * When a column is being resized, this variable
		 * holds the cell that initiated the resize operation. We render a
		 * glyph that trails the users mouse pointer during the resize operation
		 * This variable simply holds a reference to the
		 * header cell associated with the column being resized.
		 * */
@property (nonatomic, weak) FLXSFlexDataGridHeaderCell* columnResizingCell;
/**
		 * When a column is being dragged and dropped into a different location, this variable
		 * holds the cell that is being dragged. The cell actually does not drag, we render a
		 * glyph that trails the users mouse pointer. This variable simply holds a reference to the
		 * header cell associated with the column being dragged.
		 */
@property (nonatomic, weak) FLXSFlexDataGridCell* columnDraggingDragCell;
/**
		 * @private
		 */
@property (nonatomic, strong) UIView<FLXSIFlexDataGridCell>* columnDraggingDropTargetCell;
/**
		 * @private
		 */
@property (nonatomic, weak) FLXSFlexDataGridHeaderSeparator* columnResizingGlyph;
/**
		 * @private
		 */
@property (nonatomic, strong) UIView* columnDraggingGlyph;
@property (nonatomic, assign) float startX;
@property (nonatomic, strong) NSMutableArray* cellsWithColSpanOrRowSpan;
@property (nonatomic, assign) float lastContentOffsetX;
@property (nonatomic, assign) float lastContentOffsetY;
@property (nonatomic, strong) NSString* horizontalScrollPolicy;
@property (nonatomic, strong) NSString* verticalScrollPolicy;


typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown
} ScrollDirection;


-(id)initWithGrid:(FLXSFlexDataGrid*)grid;
/**
		 * @private
		 */
-(UIView<FLXSIFlexDataGridCell>*)getCellFromMouseEventTarget:(NSObject*)target;
/**
		 * End the edit, if active, call removeComponent on each of the rows, and remove all the children.
		 */
-(void)removeAllComponents:(BOOL)recycle;
/**
* @private
*/
- (void)createComponents:(FLXSFlexDataGridColumnLevel *)level currentScroll:(int)currentScroll flat:(NSObject *)flat;
/**
* Returns true if the passed in cordinates are in the visible ViewPort
*/
- (BOOL)isInVisibleHorizontalRange:(float)x width:(float)width;
/**
		 * Removes the component from its parents hierarchy, and calls destroy method, if the component is a IFlexDataGridCell object
		 * Hangs on to the component in the cache for further reuse.
		 */
-(void)removeComponent:(FLXSComponentInfo*)comp;
/**
		 * Calls removeAllComponents, createComponents, validateNow, and snapToColumnWidths
		 *
		 */
-(void)reDraw;

/**
 * @private
 */
- (void)recycleH:(FLXSFlexDataGridColumnLevel *)level scrollRight:(BOOL)scrollRight;
-(NSArray*)getRowsForRecycling;

/**
 * @private
 */
- (void)processRowPositionInfo:(FLXSRowPositionInfo *)rowPositionInfo scrollDown:(BOOL)scrollDown existingRow:(FLXSRowInfo *)existingRow existingComponents:(NSArray *)existingComponents;
/**
		 * Iterates through all rows and calls removeComponent on each of the cells.
		 * Removes event listeners added to the RowInfo object
		 * @param row
		 *
		 */
-(void)removeComponents:(FLXSRowInfo*)row;
/**
		 * Sets the current highlight cell to the first available cell.
		 */
-(void)setCurrentCellToFirst;

/**
		 * Gets the first cell of the first column.
		 *
		 */
- (UIView <FLXSIFlexDataGridCell> *)getFirstAvailableCell:(UIView <FLXSIFlexDataGridCell> *)cell up:(BOOL)up;

- (UIView <FLXSIFlexDataGridCell> *)getFirstHoverableCell:(FLXSRowInfo *)row dataOnly:(BOOL)dataOnly editableOnly:(BOOL)editableOnly;
/**
		 * Can this cell accept hover. Returns true if
		 * (cell is IFlexDataGridDataCell
		 * 		or cell is FlexDataGridHeaderCell
		 *		or cell is FlexDataGridFooterCell
		 *		or cell is FlexDataGridFilterCell
		 *		or cell is FlexDataGridPagerCell
		 *		or cell is FlexDataGridLevelRendererCell
		 *		or cell is FlexDataGridExpandCollapseCell
		 *		or cell is FlexDataGridColumnGroupCell) and cell.enabled and not cell is FlexDataGridExpandCollapseHeaderCell
		 */
-(BOOL)isHoverableCell:(UIView<FLXSIFlexDataGridCell>*)cell;
/**
		 * Based upon the type of the cell, adds various event listeners to them
		 * to respond to mouse overs, clicks, double clicks, mouse outs, keyboard input,
		 * etc.
		 */
-(FLXSComponentInfo*)addEventListeners:(FLXSComponentInfo*)comp;
/**
* Handles mouse over for data cells.
* Calls highlightRow for item rollovers.
*/
- (void)handleMouseOver:(UIView <FLXSIFlexDataGridCell> *)cell triggerEvent:(FLXSEvent *)triggerEvent;
/**
		 * @private
		 */
-(void)onCellMouseOut:(FLXSEvent*)event;

/**
		 * Handles mouse out. Dispatches the Item Roll Out event
		 */
- (void)handleMouseOut:(UIView <FLXSIFlexDataGridCell> *)cell triggerEvent:(FLXSEvent *)triggerEvent;
/**
		 * @private
		 */
-(void)onCellDoubleClick:(FLXSEvent*)event;

/**
		 * Handles the Double Click. If ther enableDoubleClickEdit and editableon the column is set to true, starts the edit session
		 */
- (void)handleDoubleClick:(UIView <FLXSIFlexDataGridCell> *)cell triggerEvent:(FLXSEvent *)triggerEvent;
/**
		 * Used by accesibility
		 *
		 */
-(void)emulateClick:(UIView<FLXSIFlexDataGridCell>*)cell;
/**
		 * Handles the Mouse click. Dispatches ITEM_CLICK. If the Cell is a header cell, calls
		 * onHeaderCellClicked. If the cells is the checkbox selection cell, updates the grid selection.
		 * Updates the Selected Cells, if grid.isCellSelectionMode.
		 * If the column is editable, begins the edit session.
		 */

- (void)handleMouseClick:(UIView <FLXSIFlexDataGridCell> *)cell triggerEvent:(FLXSEvent *)triggerEvent checkTimer:(BOOL)checkTimer;

/**
		 * Handles cell key up. Handles KeyBoard.UP,KeyBoard.DOWN,KeyBoard.LEFT,KeyBoard.RIGHT
		 */
- (BOOL)handleArrowKey:(UIView <FLXSIFlexDataGridCell> *)cell keyCode:(int)keyCode triggerEvent:(FLXSEvent *)triggerEvent;

- (void)handleCellKeyUp:(UIView <FLXSIFlexDataGridCell> *)cell keyCode:(int)keyCode triggerEvent:(FLXSEvent *)triggerEvent;

- (void)handleSpaceBar:(UIView <FLXSIFlexDataGridCell> *)cell triggerEvent:(FLXSEvent *)triggerEvent;
/**
		 * Starts the Edit Session.
		 */
-(void)beginEdit:(UIView<FLXSIFlexDataGridDataCell>*)cell;

- (void)initializeEditor:(UIView <FLXSIFlexDataGridDataCell> *)editCell editor:(UIView *)editor pare:(UIView *)pare;
/**
		 * Re-evaluates all the visible cell contents.
		 */
-(void)refreshCells;
/**
		 *  @private
		 */
-(void)onStageResize:(FLXSEvent*)event;
/**
		 * @private
		 */
-(void)doInvalidate;
-(void)invalidateDisplayList;
/**
		 * @private
		 * @param vsp
		 *
		 */
-(void)gotoHorizontalPosition:(float)hsp;

/**
		 * Abstract
		 */
- (void)scrollToExistingRow:(float)vsp scrollDown:(BOOL)scrollDown;
/**
		 * Abstract
		 */
-(BOOL)isOutOfVisibleArea:(FLXSRowInfo*)row;

/**
		 * Dispatches ITEM_EDIT_END.
		 * Removes Event listeners
		 * @param editor
		 */
- (void)endEdit:(UIView *)editor event:(FLXSEvent *)event;
/**
		 * Cancels the current running edit. Dispatches ITEM_EDIT_CANCEL.
		 */
-(void)cancelEdit:(FLXSEvent*)event;
/**
		 * @private
		 * @param event
		 * @return
		 *
		 */
-(void)onEditorValueCommit:(FLXSEvent*)event;

/**
		 * Applies the value from the editor back to the model object.
		 * Dispatches ITEM_EDIT_VALUE_COMMIT
		 */
- (BOOL)populateValue:(FLXSEvent *)event itemEditor:(UIView *)itemEditor;
/**
		 * Calls invalidateBackground() on each of the cells.
		 */
-(void)invalidateCells;
/**
		 * Gets the Rows Collection
		 * @return
		 *
		 */
-(NSMutableArray*)getAllRows;

/**
		 * @private
		 * @param cell
		 * @param row
		 * @param highLight
		 */
- (void)highlightRow:(UIView <FLXSIFlexDataGridCell> *)cell row:(FLXSRowInfo *)row highLight:(BOOL)highLight highLightColor:(id)highLightColor;

/**
		 * Gets the cell in the specified direction of the provided cell
		 * @param thisCell		The cell to start searching at.
		 * @param direction	The direction to search. Should be one of FlexDataGrid.CELL_POSITION_XXXX constants
		 * @param dataOnly	Boolean flag to look only for data cells (IFlexDataGridDataCell)
		 * @param editableOnly	Boolean flag to look only for editable cells
		 * @param scrollIfNecessary	If next visible cell is beyond scrollable area, recycle and then search again.
		 * @param hoverableOnly	Boolean flag to look only for cells where isHoverable(cell) is true.
		 * @return The cell, if one matches the provided criteria, or null
		 */
- (UIView <FLXSIFlexDataGridCell> *)getCellInDirection:(UIView <FLXSIFlexDataGridCell> *)thisCell direction:(NSString *)direction dataOnly:(BOOL)dataOnly editableOnly:(BOOL)editableOnly scrollIfNecessary:(BOOL)scrollIfNecessary hoverableOnly:(BOOL)hoverableOnly;

- (UIView <FLXSIFlexDataGridCell> *)checkRowSpanColSpan:(UIView <FLXSIFlexDataGridCell> *)retCell thisCell:(UIView <FLXSIFlexDataGridCell> *)thisCell direction:(NSString *)direction dataOnly:(BOOL)dataOnly editableOnly:(BOOL)editableOnly scrollIfNecessary:(BOOL)scrollIfNecessary hoverableOnly:(BOOL)hoverableOnly;

-(BOOL)isCoveredByRowSpanOrColspan:(UIView<FLXSIFlexDataGridCell>*)cell;
/**
		 * Given a cell, returns true if the cell is "hidden" by another cell that has a row span which will cover this cell.
		 * @param cell	The cell to check
		 */
-(BOOL)isCoveredByRowSpan:(UIView<FLXSIFlexDataGridCell>*)cell;
/**
		 * Given a cell, returns true if the cell is "hidden" by another cell that has a col span which will cover this cell.
		 * @param cell	The cell to check
		 */
-(BOOL)isCoveredByColSpan:(UIView<FLXSIFlexDataGridCell>*)cell;

/**
		 * Given a column and a data object, returns the cell associated with the data object. If the column is null, will
		 * return the first unlocked cell of the row associated with the data object, if includeExp is set to true, returns the
		 * expand collapse cell. Please note, this only checks the rows that are currently drawn, not the entire dataprovider.
		 * Only the data objects that have currently drawn rows (the visible viewport) will return a cell object, others will reuturn null
		 * @param dataObject	An item in the dataprovider.
		 * @param col			A column to match. Can be null.
		 * @param includeExp	Whether or not to include the expand collapse cell.
		 * @return IFlexDataGridCell
		 */
- (UIView <FLXSIFlexDataGridCell> *)getCellForRowColumn:(NSObject *)dataObject column:(FLXSFlexDataGridColumn *)col includeExp:(BOOL)includeExp;
/**
		 * @private
		 */
-(void)removeEventListeners:(FLXSComponentInfo*)comp;
/**
* @private
*/
- (FLXSRowInfo *)addRow:(float)ht scrollDown:(BOOL)scrollDown rowPositionInfo:(FLXSRowPositionInfo *)rowPositionInfo;
/**
* @private
*/
- (FLXSComponentAdditionResult *)addCell:(UIView *)component row:(FLXSRowInfo *)row existingComponent:(FLXSComponentInfo *)existingComponent;
/**
* @private
*/
- (FLXSComponentInfo *)addToSection:(UIView <FLXSIFlexDataGridCell> *)cell row:(FLXSRowInfo *)row lockDir:(NSString *)lockDir existingComponent:(FLXSComponentInfo *)existingComponent;
/**
* In lazy loaded grids, gets the loaded info of the provided object.
*/
- (FLXSItemLoadInfo *)findLoadingInfo:(NSObject *)item level:(FLXSFlexDataGridColumnLevel *)level useSelectedKeyField:(BOOL)useSelectedKeyField;
/**
* @private
*/
- (BOOL)processRendererLevel:(FLXSRowPositionInfo *)rowPositionInfo scrollDown:(BOOL)scrollDown;
/**
		 * @private
		 */
-(void)placeComponents;
/**
* @private
*/
- (BOOL)processHeaderLevel:(FLXSFlexDataGridColumnLevel *)level rowPositionInfo:(FLXSRowPositionInfo *)rowPositionInfo scrollDown:(BOOL)scrollDown item:(NSObject *)item chromeLevel:(int)chromeLevel existingRow:(FLXSRowInfo *)existingRow existingComponents:(NSArray *)existingComponents;
/**
		 * @private
		 */
-(NSString*)traceRows;
/**
		 * @private
		 */
-(NSString*)traceCells;
/**
		 * @private
		 */
-(float)getPagerWidth;
/**
* @private
*/
- (void)processFilterCell:(FLXSFlexDataGridColumnLevel *)level columns:(NSArray *)cols colIndex:(int)colIndex row:(FLXSRowInfo *)row item:(NSObject *)item flatDp:(NSArray *)flatDp existingComponents:(NSArray *)existingComponents;

/**
		 * Given a filter control, initializes it from the provided column
		 * @param filterRenderer	The filtercontrol
		 * @param filterColumn		The column to initialize the control with
		 * @param item				The item (only required for inner level filters)
		 * @param flatDp			The dataprovider
		 * @param level				The level against which to initialize the filter.
		 */
- (void)initializeFilterRenderer:(UIView <FLXSIFilterControl> *)filterRenderer filterColumn:(FLXSFlexDataGridColumn *)filterColumn item:(NSObject *)item flatDp:(NSArray *)flatDp level:(FLXSFlexDataGridColumnLevel *)level;
/**
* @private
*/
- (void)buildFilter:(UIView<FLXSISelectFilterControl>  *)iSelectFilterControl column:(FLXSFlexDataGridColumn *)column parentObject:(NSObject *)parentObject flatValues:(NSArray *)flatValues;
/**
* @private
*/
- (void)processFooterCell:(FLXSFlexDataGridColumnLevel *)level columns:(NSArray *)cols colIndex:(int)colIndex row:(FLXSRowInfo *)row item:(NSObject *)item existingComponents:(NSArray *)existingComponents;
/**
* @private
*/
- (FLXSFlexDataGridColumnGroupCell *)processColumnGroupCell:(FLXSFlexDataGridColumnLevel *)level rendererFactory:(FLXSClassFactory *)rendererFactory row:(FLXSRowInfo *)row item:(NSObject *)item rowHeight:(float)rowHeight columnGroup:(FLXSFlexDataGridColumnGroup *)columnGroup existingComponents:(NSArray *)existingComponents;
/**
* @private
*/
- (void)processHeaderCell:(FLXSFlexDataGridColumnLevel *)level columns:(NSArray *)cols colIndex:(int)colIndex row:(FLXSRowInfo *)row item:(NSObject *)item rowHeight:(float)rowHeight existingComponents:(NSArray *)existingComponents;
/**
* @private
*/
- (FLXSComponentInfo *)getExistingCell:(NSArray *)existingComponents rendererFactory:(FLXSClassFactory *)rendererFactory col:(FLXSFlexDataGridColumn *)col;
/**
		 * @private
		 */
-(void)onFilterChange:(NSNotification*)ns;
/**
		 * @private
		 */
-(void)onPageChange:(NSNotification*)event;
/**
		 * @private
		 */
-(void)rootPageChange:(NSNotification*)event;
/**
* @private
*/
-(void)dispatchPageChange:(FLXSEvent*)event;

/**
		 * @private
		 */
- (FLXSAdvancedFilter *)createFilter:(FLXSFlexDataGridColumnLevel *)level parentObject:(NSObject *)parentObject;
/**
		 * @private
		 */
-(void)killResize;
///**
//		 * The IFlexDataGridCell under edit currently. Please note, this is the IFlexDataGridCell component, not the editor component.
//		 * This will be populated only after an edit session has started. To access the actual editor, please use the
//		 * getCurrentEditor property
//		 */
//-(UIView<FLXSIFlexDataGridCell>*)getCurrentEditCell;
///**
//		 * The editor being used as the current component to edit. This is an instance of the itemEditor class factory.
//		 * This will be populated only after an edit session has started.
//		 */
//-(UIView*)getCurrentEditor;
///**
//		 * @copy com.flexicious.nestedtreedatagrid.FlexDataGridContainerBase#getCurrentEditCell
//		 */
//-(UIView<FLXSIFlexDataGridDataCell>*)editCell;
//
///**
//		 * @private
//		 */
//-(void)editor:(UIView*)val;
/**
		 * @private
		 */
-(void)columnResizeMouseUpHandler:(FLXSEvent*)event;
/**
		 * @private
		 */
-(void)snapToColumnWidths;
/**
		 * Given a cell, gets the colspan associated with that cell by calling the grid.colSpanFunction.
		 */
-(int)getColSpan:(UIView<FLXSIFlexDataGridCell>*)cell;
/**
		 * Given a cell, gets the rowSpan associated with that cell by calling the grid.rowSpanFunction.
		 */
-(int)getRowSpan:(UIView<FLXSIFlexDataGridCell>*)cell;
-(float)getCellWidth:(UIView<FLXSIFlexDataGridCell>*)cell;
-(float)getCellHeight:(UIView<FLXSIFlexDataGridCell>*)cell;
/**
		 * Once the snapToColumnWidths finishes, the cellsWithColSpanOrRowSpan array contains all cells
		 * that have a row or col span. This method will bring such cells to the top so they hide the ones that are covered.
		 */
-(void)hideSpannedCells;
-(NSArray*)getRowsForSnapping;
-(void)snapRowToColumnWidth:(FLXSRowInfo*)row;
-(void)placeSortIcon:(FLXSEvent*)event;
-(void)selectAllChangedHandler:(FLXSEvent*)event;
-(void)onSelectAllChanged:(FLXSEvent*)event;

- (void)sortByColumn:(FLXSFlexDataGridColumn *)col direction:(NSString *)direction;

- (void)onHeaderCellClicked:(FLXSFlexDataGridHeaderCell *)cell triggerEvent:(FLXSEvent *)triggerEvent isMsc:(BOOL)isMsc useMsc:(BOOL)useMsc direction:(NSString *)direction;

- (void)storeSort:(NSObject *)item column:(FLXSFlexDataGridColumn *)column ascending:(BOOL)ascending;
-(void)sortByCell:(FLXSFlexDataGridHeaderCell*)cell;

- (NSArray *)filterPageSort:(NSArray *)flat level:(FLXSFlexDataGridColumnLevel *)level parentObj:(NSObject *)parentObj applyFilter:(BOOL)applyFilter applyPaging:(BOOL)applyPaging applySort:(BOOL)applySort pages:(NSArray *)pages updatePager:(BOOL)updatePager;

- (FLXSFlexDataGridPaddingCell *)addPadding:(int)nestLevel row:(FLXSRowInfo *)row paddingHeight:(float)paddingHeight level:(FLXSFlexDataGridColumnLevel *)level forceRightLock:(BOOL)forceRightLock scrollPad:(BOOL)scrollPad width:(float)width;

/**
		 * Used by accesibility
		 */
-(void)getChildIds:(NSArray*)arr;
/**
		 * Used by accesibility
		 */
-(NSArray*)getSelectedIds:(int)bodyStart;
/**
		 * Used by accesibility
		 */
-(int)getChildId:(NSArray*)arr :(UIView<FLXSIFlexDataGridCell>*)cell;
/**
* Used by accesibility
*/
- (UIView <FLXSIFlexDataGridCell> *)getChildAtId:(NSMutableArray *)arr id:(int)id;
-(void)refreshCheckBoxes;

+ (void)initializeRendererFromColumn:(UIView <FLXSIFilterControl> *)filterRenderer filterColumn:(FLXSFlexDataGridColumn *)filterColumn;

+ (FLXSClassFactory*) levelRendererFactory;
+ (FLXSClassFactory*) labelFieldFactory;


//FLXSIEventDispatcher methods
-(void)dispatchEvent:(FLXSEvent *)event;

- (void)addEventListener:(NSString *)type target:(NSObject *)target handler:(SEL)handler;
-(void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler;
//End FLXSIEventDispatcher methods

@end
