#import "FLXSFlexDataGridContainerBase.h"
#import "FLXSGridBackground.h"
#import "FLXSVersion.h"

@class FLXSRowPositionInfo;
@class FLXSKeyValuePairCollection;
@class FLXSFlexDataGrid;
@class FLXSFilterPageSortChangeEvent;
@class FLXSEvent;
@class FLXSFlexDataGridColumnLevel;
@class FLXSRowInfo;
@class FLXSFlexDataGridColumn;
@class FLXSComponentInfo;
@protocol FLXSIFlexDataGridCell;

@class FLXSComponentAdditionResult;
@protocol FLXSIExpandCollapseComponent;
@class FLXSFlexDataGridHeaderCell;

/**
	 * FlexDataGridBodyContainer is the container for the unlocked section of the datagrid. This is the only container in the entire
	 * component tree that scrolls.
	 * In addition to all the base functionality that it inherits from FlexDataGridContainerBase, it adds the following pieces of functionality:
	 *
	 * <ul>
	 * <li>Vertical Scroll Renderer Recycling</li>
	 * </ul>
	 *
	 * @inheritDoc
	 */
@interface FLXSFlexDataGridBodyContainer : FLXSFlexDataGridContainerBase
{

}
/**
		 * A list of items that the user has opened. Only applicable grids with nested column levels.
		 */	
@property (nonatomic, strong) NSMutableArray* openItems;
@property (nonatomic, strong) FLXSGridBackground* backgroundForFillerRows;
@property (nonatomic, strong) UIView * refreshControl;
/**
		 * @private
		 */
@property (nonatomic, assign) float calculatedTotalHeight;
@property (nonatomic, assign) BOOL heightCalculated;
@property (nonatomic, assign) BOOL processing;
@property (nonatomic, assign) BOOL drawDirty;
@property (nonatomic, assign) BOOL recreateRows;
@property (nonatomic, strong) NSMutableDictionary* rowCache;
@property (nonatomic, strong) FLXSRowPositionInfo* currentRowPointer;
@property (nonatomic, strong) NSMutableArray* visibleRange;
@property (nonatomic, strong) NSMutableArray* visibleRangeH;
@property (nonatomic, strong) NSMutableArray* fillerRows;
/**
		 * @private
		 */
@property (nonatomic, assign) BOOL onDisabledCell;
@property (nonatomic, assign) float verticalScrollPending;
@property (nonatomic, strong) FLXSKeyValuePairCollection* parentMap;
@property (nonatomic, strong) FLXSKeyValuePairCollection* variableRowHeightRenderers;



-(id)initWithGrid:(FLXSFlexDataGrid*)grid;
/**
		 * @private
		 */	
//-(void)createChildren;

/**
		 * @private
		 */
//- (void)updateDisplayList:(float)unscaledWidth unscaledHeight:(float)unscaledHeight;
/**
		 * @private
		 */
-(void)scrollChildren;
//-(void)onFilterChange:(FLXSFilterPageSortChangeEvent*)event;
-(void)onPageChange:(NSNotification*)event;
 -(BOOL)validNextPage;

- (FLXSRowPositionInfo *)getFLXSRowPositionInfo:(NSObject *)item level:(FLXSFlexDataGridColumnLevel *)lvl;
-(FLXSRowPositionInfo*)getFLXSRowPositionInfoFromRows:(NSObject*)item;

- (FLXSRowPositionInfo *)binarySearch:(NSArray *)arr verticalPosition:(float)verticalPos low:(int)low high:(int)high;
-(NSArray*)getItemVerticalPositions;
-(FLXSRowPositionInfo*)getItemAtPosition:(float)position;
-(void)setVisibleRange;

- (void)createComponents:(FLXSFlexDataGridColumnLevel *)level currentScroll:(int)currentScroll flat:(NSObject *)flat;

- (void)hideRefreshControl;

- (void)recycleH:(FLXSFlexDataGridColumnLevel *)level scrollRight:(BOOL)scrollRight;
-(NSObject*)getRowsForRecycling;

- (void)recycle:(FLXSFlexDataGridColumnLevel *)level scrollDown:(BOOL)scrollDown scrollDelta:(float)scrollDelta scrolling:(BOOL)scrolling;

- (void)drawRowsUsingCache:(FLXSRowPositionInfo *)start end:(FLXSRowPositionInfo *)end scrollDown:(BOOL)scrollDown offPage:(BOOL)offPage;

- (void)processItemPositionInfoUsingCache:(FLXSRowPositionInfo *)seed insertionPoint:(int)insertionPoint scrollDown:(BOOL)scrollDown;
-(void)checkInconsistency;
-(NSObject*)positionExists:(FLXSRowPositionInfo*)seed;
//-(void)verticalScrollPosition:(float)val;
-(void)validateDisplayList;
-(BOOL)rowExists:(FLXSRowPositionInfo*)rowPos;
-(void)removeAllComponents:(BOOL)recycle;
-(void)saveRowInCache:(FLXSRowInfo*)row;

- (void)shiftColumns:(FLXSFlexDataGridColumn *)columnToInsert insertBefore:(FLXSFlexDataGridColumn *)insertBefore;
-(BOOL)drawRows:(BOOL)forceFiller;
-(void)drawFiller:(FLXSRowPositionInfo*)end;
-(void)adjustFiller:(float)offset;
-(void)setBackgroundFillerSize;
-(void)onWidthChanged:(FLXSEvent*)event;
-(void)onHeightChanged:(FLXSEvent*)event;
-(void)resizeFillerCells;

- (void)processRowPositionInfo:(FLXSRowPositionInfo *)rowPositionInfo scrollDown:(BOOL)scrollDown existingRow:(FLXSRowInfo *)existingRow existingComponents:(NSArray *)existingComponents;
-(FLXSComponentInfo*)addEventListeners:(FLXSComponentInfo*)comp;
-(void)onCellDragComplete:(FLXSEvent*)event;
-(void)removeEventListeners:(FLXSComponentInfo*)comp;

- (void)handleSpaceBar:(UIView <FLXSIFlexDataGridCell> *)cell triggerEvent:(FLXSEvent *)triggerEvent;

- (BOOL)handleArrowKey:(UIView <FLXSIFlexDataGridCell> *)cell keyCode:(int)keyCode triggerEvent:(FLXSEvent *)triggerEvent;

- (FLXSRowInfo *)processItem:(FLXSRowPositionInfo *)rowPositionInfo scrollDown:(BOOL)scrollDown existingRow:(FLXSRowInfo *)existingRow existingComponents:(NSArray *)existingComponents;

- (FLXSComponentAdditionResult *)pushCell:(FLXSFlexDataGridColumn *)column row:(FLXSRowInfo *)row existingComponents:(NSArray *)existingComponents;
-(void)gridMouseOut;
-(void)onExpandCollapse:(FLXSEvent*)event;
-(void)handleExpandCollapse:(UIView<FLXSIExpandCollapseComponent>*)disclosureCell;
-(BOOL)gotoRow:(int)rowIndex;
-(void)selectText:(NSString*)txt;

- (NSArray *)quickFind:(NSString *)whatToFind flat:(NSObject *)flat level:(FLXSFlexDataGridColumnLevel *)level result:(NSArray *)result searchColumns:(NSArray *)searchCols breakAfterFind:(BOOL)breakAfterFind captureColumns:(BOOL)captureCols;

- (BOOL)gotoItem:(NSObject *)item highlight:(BOOL)highlight useItemKeyForCompare:(BOOL)useItemKeyForCompare level:(FLXSFlexDataGridColumnLevel *)level rebuild:(BOOL)rebuild;

- (BOOL)getObjectStack:(NSArray *)itemToFind stackSoFar:(NSMutableArray *)stackSoFar useItemKeyForCompare:(BOOL)useItemKeyForCompare flat:(NSArray *)flat level:(FLXSFlexDataGridColumnLevel *)level;

- (void)scrollToExistingRow:(float)vsp scrollDown:(BOOL)scrollDown;
-(BOOL)isOutOfVisibleArea:(FLXSRowInfo*)row;

- (BOOL)isYOutOfVisibleArea:(float)numY numH:(float)numH;
-(void)gotoVerticalPosition:(float)vsp;

- (BOOL)isLoading:(NSObject *)item level:(FLXSFlexDataGridColumnLevel *)level useSelectedKeyField:(BOOL)useSelectedKeyField;

- (void)setChildData:(NSObject *)item children:(NSArray *)children level:(FLXSFlexDataGridColumnLevel *)level totalRecords:(int)totalRecords useSelectedKeyField:(BOOL)useSelectedKeyField;

- (void)expandCollapse:(NSObject *)expandingDataItem rowPositionInfo:(FLXSRowPositionInfo *)rowPositionInfo forceScrollBar:(BOOL)forceScrollBar;

- (void)adjustRowPositions:(FLXSRowPositionInfo *)rowPositionInfo howManyToRemove:(int)howManyToRemove heightRemoved:(int)heightRemoved;
-(void)invalidateCalculatedHeight;
-(BOOL)setCurrentRowAtScrollPosition:(float)vsp;

- (NSArray *)getFilteredPagedSortedData:(FLXSKeyValuePairCollection *)dictionary applyFilter:(BOOL)applyFilter applyPaging:(BOOL)applyPaging applySort:(BOOL)applySort pages:(NSArray *)pages flatten:(BOOL)flatten;

- (void)gatherFilteredPagedSortedData:(FLXSKeyValuePairCollection *)dictionary result:(NSMutableArray *)result flat:(NSArray *)flat level:(FLXSFlexDataGridColumnLevel *)level parentObject:(NSObject *)parentObject applyFilter:(BOOL)applyFilter applyPaging:(BOOL)applyPaging applySort:(BOOL)applySort pages:(NSArray *)pages flatten:(BOOL)flatten;
-(NSArray*)getRootFlat;
-(float)calculateTotalHeightNoParam;

- (float)calculateTotalHeight:(NSArray *)flat level:(FLXSFlexDataGridColumnLevel *)level heightSoFar:(float)heightSoFar nestLevel:(int)nestLevel expanding:(FLXSRowPositionInfo *)expanding addedRows:(NSArray *)addedRows parentObject:(NSObject *)parentObject isRecursive:(BOOL)isRecursive;
-(void)clearVariableRowHeightRenderers;

- (float)processSection:(NSArray *)addedRows rowIndex:(int)rowIndex parentObject:(NSObject *)parentObject heightSoFar:(float)heightSoFar level:(FLXSFlexDataGridColumnLevel *)level parentObject5:(NSObject *)parentObject5 chromeType:(int)chromeType expanding:(FLXSRowPositionInfo *)expanding expandingLevel:(FLXSFlexDataGridColumnLevel *)expandingLevel;
-(int)getChromeType:(NSString*)name;
-(void)checkAutoAdjust;
-(void)ensureAutoAdjustHeight;

- (float)addToVerticalPositions:(NSObject *)item heightSoFar:(float)heightSoFar level:(FLXSFlexDataGridColumnLevel *)level parent:(NSObject *)parent rowType:(int)rowType;

- (float)addToExpandingPositions:(NSArray *)array parentRowIndex:(int)parentRowIndex item:(NSObject *)item heightSoFar:(float)heightSoFar level:(FLXSFlexDataGridColumnLevel *)level parent:(NSObject *)parent rowType:(int)rowType;

- (FLXSComponentAdditionResult *)addCell:(UIView *)component row:(FLXSRowInfo *)row existingComponent:(FLXSComponentInfo *)existingComponent;

- (void)onHeaderCellClicked:(FLXSFlexDataGridHeaderCell *)headerCell triggerEvent:(FLXSEvent *)triggerEvent isMsc:(BOOL)isMsc useMsc:(BOOL)useMsc direction:(NSString *)direction;
-(void)onChildHeaderClicked:(FLXSFlexDataGridHeaderCell*)headerCell;
-(void)onSelectAllChanged:(FLXSEvent*)event;

- (FLXSRowInfo *)addRow:(float)ht scrollDown:(BOOL)scrollDown rowPositionInfo:(FLXSRowPositionInfo *)rowPositionInfo;
-(void)nextPage;
-(NSArray*)onScreenRows;
-(int)getColumnGroupDepth:(FLXSRowInfo*)row;
-(int)numTotalRows;
-(void)clearAllCollections;
-(void)clearOpenItems;

- (void)addOpenItem:(NSObject *)item rowPositionInfo:(FLXSRowPositionInfo *)rowPositionInfo;

- (void)removeOpenItem:(NSObject *)item rowPositionInfo:(FLXSRowPositionInfo *)rowPositionInfo;

@end

