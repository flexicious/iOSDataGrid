#import "FLXSVersion.h"
#import "FLXSEvent.h"
#import "FLXSIEventDispatcher.h"

@class FLXSFlexDataGrid;
@class FLXSExportOptions;
@class FLXSFilter;
@class FLXSAdvancedFilter;
@class FLXSCellInfo;
@class FLXSFlexDataGridColumn;
@protocol FLXSIFlexDataGridCell;
@class FLXSFilterSort;

@class FLXSClassFactory;
@class FLXSRowPositionInfo;
@class FLXSFlexDataGridColumnGroup;
@class  FLXSFilterExpression;

/**
	 * <p>
	 * A class that contains information about a nest level of grid. This includes the columns at this
	 * level, information about whether or not to enable paging, footers, filters, the row sizes of each,
	 * the property of the dataprovider to be used as the key for selection, the property of the data provider
	 * to be used as the children field, the renderers for each of the cells, etc.The Grid always contains
	 * at least one level. This is the top level, and is accessible via the columnLevel property of the grid.
	 * </p>
	 * <p>
	 * One of the most important concepts behind the Architecture of Flexicious Ultimate arose from the
	 * fundamental requirement that the product was created for - that is display of Heterogeneous
	 * Hierarchical Data.
	 * </p>
	 * <p>
	 * The notion of nested levels is baked in to the grid via the "columnLevel" property.
	 * This is a property of type "FlexDataGridColumnLevel". The grid always has at least one column level.
	 * This is also referred to as the top level, or the root level. In flat grids (non hierarchical),
	 * this is the only level. But in nested grids, you could have any number of nested levels.
	 * </p>
	 * <p>
	 * The columns collection actually belongs to the columnLevel, and since there is one root level,
	 * the columns collection of the grid basically points to the columns collection of this root level.
	 * The FlexDataGridColumnLevel class has a "nextLevel" property, which is a pointer to another instance
	 * of the same class, or a "nextLevelRenderer" property, which is a reference to a
	 * ClassFactory the next level. Please note, currently, if you specify nextLevelRenderer, the nextLevel
	 * is ignored. This means, at the same level, you cannot have both a nested subgrid as well as a
	 * level renderer. Bottom line - use nextLevelRenderer only at the innermost level.
	 * Our examples demonstrate this.
	 * </p>
	 * */
@interface FLXSFlexDataGridColumnLevel : NSObject <FLXSIEventDispatcher>
{

}
/**
 * Setting this flag to true will resuse the columns from the previous level. 
 * 
 * Set this flag to true if you want the grid to behave like the advanced datagrid, where
 * there is one set of columns for hierarchical data.  
 * 
 */	
@property (nonatomic, assign) BOOL reusePreviousLevelColumns;
/**
* Height of the row for this level. Defaults to 25  
*/			
@property (nonatomic, assign) float rowHeight;


/**
* Height of the header for this level. Defaults to 25 
*/		
@property (nonatomic, assign) float headerHeight;
@property (nonatomic, strong) NSMutableArray* selectedObjects;
@property (nonatomic, strong) NSString* selectedKeyField;
@property (nonatomic, strong) NSString* selectableField;
@property (nonatomic, strong) NSString* disabledField;
@property (nonatomic, strong) NSString* childrenCountField;
@property (nonatomic, strong) NSString* childrenField;
@property (nonatomic, strong) NSString* parentField;
@property (nonatomic, strong) NSString* levelName;
@property (nonatomic, assign) float headerSeparatorWidth;
/**
 *The indentation to apply to each progressive nest level.
 * @default 15
 */	
@property (nonatomic, assign) float nestIndent;
@property (nonatomic, strong) NSMutableArray* currentSorts;
/**
 * How deep in the nesting hierarchy is this item.
 * Starts at 1 for the columnLevel that belongs to the grid.
 * @return 
 */		
@property (nonatomic, assign) int nestDepth;
@property (nonatomic, strong) NSMutableArray* filterArgs;
@property (nonatomic, strong) NSMutableArray* selectedKeys;
@property (nonatomic, strong) NSMutableArray* calculatedSelectedKeys;
@property (nonatomic, weak) FLXSFlexDataGridColumnLevel* parentLevel;
@property (nonatomic, strong) NSArray* columnGroups;
@property (nonatomic, strong) NSArray* groupedColumns;
@property (nonatomic, assign) BOOL hasGroupedColumns;
@property (nonatomic, strong) NSMutableArray* columns;
/**
 * The number of records to inspect to identify the max size of the data in the column when columnWidthMode=fitToContent.
 * 
 * When you have very large datasets, it will be very slow if you inspect every row to identify the largest string to 
 * come up with the column width. So we inspect only the first columnWidthModeFitToContentSampleSize rows.
 * 
 * @default 100
 */	
@property (nonatomic, assign) float columnWidthModeFitToContentSampleSize;
@property (nonatomic, strong) FLXSFlexDataGridColumnLevel* nextLevel;
@property (nonatomic, strong) NSString* initialSortField;
/**
 * If true, initial sort direction for this level is ascending. Defaults to true.
 */		
@property (nonatomic, assign) BOOL initialSortAscending;
/**
 * Flag to indicate whether or not to enable paging functionality
 * @return
 */
@property (nonatomic, assign) BOOL enablePaging;
/**
 * @private
 * @param val
 *
 */
@property (nonatomic, assign) BOOL forcePagerRow;
@property (nonatomic, strong) FLXSClassFactory* pagerRenderer;
/**
 * The number of records to display per page
 * @return
 */
@property (nonatomic, assign) int pageSize;
@property (nonatomic, assign) int pageIndex;
@property (nonatomic, strong) NSString* pagerPosition;
/**
 * Flag that indicates whether or not to show the footer
 * @param value
 */
@property (nonatomic, assign) BOOL enableFooters;
/**
 * If you have enableFooters set to true but want the footer row to not
 * appear, you can set this value.
 * @return
 */
@property (nonatomic, assign) BOOL footerVisible;
/**
 * If you have enablePaging set to true but want the pager row to not
 * appear, you can set this value.
 * @return
 */
@property (nonatomic, assign) BOOL pagerVisible;
/**
 * Height of the footer for this level. Defaults to 25 
 */		
@property (nonatomic, assign) float footerRowHeight;
/**
 * The height of the pager row.
 * If not set, defaults to the value of the rowHeight property
 */
@property (nonatomic, assign) float pagerRowHeight;
/**
 * Height of the filter for this level. Defaults to 25 
 */	
@property (nonatomic, assign) float filterRowHeight ;
/**
 * Flag that indicates whether or not to show the filter
 * @param value
 */
@property (nonatomic, assign) BOOL enableFilters;
/**
 * If you have enableFilters set to true but want the filter row to not
 * appear, you can set this value.
 * @return
 */
@property (nonatomic, assign) BOOL filterVisible;
/**
 * Whether or not to show the header row
 * @return
 */
@property (nonatomic, assign) BOOL headerVisible;
@property (nonatomic, strong) NSString* filterPageSortMode;
@property (nonatomic, strong) NSString* itemLoadMode;
@property (nonatomic, strong) FLXSClassFactory* nextLevelRenderer;
/**
 * Height to assign to the renderer for each level. If not specified, a new instance of the level renderer is created, and the height 
 * is defaulted to the height of that one instance. The same height is then reused for subsequent renderers of the same type. 
 */		
@property (nonatomic, assign) float levelRendererHeight;
@property (nonatomic, strong) FLXSClassFactory* expandCollapseCellRenderer;
@property (nonatomic, strong) FLXSClassFactory* expandCollapseHeaderCellRenderer;
@property (nonatomic, strong) FLXSClassFactory* nestIndentPaddingCellRenderer;
@property (nonatomic, strong) FLXSClassFactory* nestIndentPaddingRenderer;
@property (nonatomic, strong) FLXSClassFactory* scrollbarPadRenderer;


@property (nonatomic, strong) FLXSClassFactory* pagerCellRenderer;
@property (nonatomic, strong) NSString* displayOrder;
@property (nonatomic, strong) NSMutableDictionary* cachedVisibleColumns;
@property (nonatomic, strong) NSMutableDictionary* lockCache;
@property (nonatomic, strong) NSMutableArray* flowColumns;
@property (nonatomic, strong) NSMutableArray* flowHeaderColumns;
@property (nonatomic, strong) NSMutableArray* flowHeaderColumnGroups;
@property (nonatomic, assign) BOOL wxInvalid;
@property (nonatomic, assign) BOOL enableRowNumbers;
@property (nonatomic, strong) NSString* selectedField;
@property (nonatomic, strong) NSString* defaultSelectionField;
@property (nonatomic, assign) BOOL enableSingleSelect;
@property (nonatomic, strong) NSMutableArray* unSelectedObjects;
@property (nonatomic, strong) NSMutableArray* pendingStyles;
@property (nonatomic, weak) FLXSFlexDataGrid* grid;
/**
 * @private 
 */
@property (nonatomic, assign) float calculatedSumHeaderAndColumnGroupHeights;
/**
 * @private 
 */
@property (nonatomic, assign) float userDefinedHeaderHeight;
/**
 * minimu header height
 */
@property (nonatomic, assign) float minHeaderHeight;
/**
 * Gets nestindent recursively
 * @return 
 */	
@property (nonatomic, readonly) int deepNestIndent;
/**
 * Gets the width of the padding cell. 
 * @return 
 */	
@property (nonatomic, readonly) float maxPaddingCellWidth;
/**
 * Gets the max disclosure cell width.
 * @return 
 */		
@property (nonatomic, readonly) float maxDisclosureCellWidth;
@property (nonatomic, readonly) FLXSFlexDataGridColumnLevel* columnOwnerLevel;

@property (nonatomic, strong) NSString* filterFunction;
@property (nonatomic, strong) NSString* additionalFilterArgumentsFunction;
@property (nonatomic, strong) NSString* rowDisabledFunction;
@property (nonatomic, strong) NSString* rowSelectableFunction;
@property (nonatomic, strong) NSString* rowBackgroundFunction;
@property (nonatomic, strong) NSString* rowTextColorFunction;
@property (nonatomic, strong) NSString* cellBorderFunction;
@property (nonatomic, strong) NSString* cellCustomDrawFunction;
@property (nonatomic, strong) NSString* cellCustomBackgroundDrawFunction;
@property (nonatomic, strong) NSString* rowBackgroundColorFunction;


- (NSObject *)getSortIndex:(FLXSFlexDataGridColumn *)fld return1:(BOOL)return1 returnSortObject:(BOOL)returnSortObject;
-(FLXSFilterSort*)hasSort:(FLXSFlexDataGridColumn*)fld;
/**
 * For multi column sort support. 
 * @param coll
 * 
 */	
-(void)addSort:(FLXSFilterSort*)sort;
/**
 * Removes all the sorts and calls doInvalidate. 
 */	
-(void)removeAllSorts;

/**
 * Clears out the current sort collection and sets it to the passed in values
 * @param fld
 * @param asc
 * 
 */
- (void)setCurrentSort:(FLXSFlexDataGridColumn *)fld asc:(BOOL)asc;
-(UIView*)createAscendingSortIcon;
-(UIView*)createDescendingSortIcon;
-(UIView*)createSortArrow:(BOOL)d;
/**
 * Returns true if filterPageSortMode==client. 
 */	
-(BOOL)isClientFilterPageSortMode;
/**
 * Returns true if itemLoadMode==client. 
 */	
-(BOOL)isClientItemLoadMode;

/**
 * IF rowSelectableFunction is specified, returns result of that.
 * If selectableField is specified, returns value of that on the obj object
 * Else returns true
 */
- (BOOL)checkRowSelectable:(UIView <FLXSIFlexDataGridCell> *)cell object:(NSObject *)obj;
/**
 * @private 
 */
-(float)calculateChromeTopHeight;
/**
 * @private 
 */
-(float)calculateChromeBottomHeight;
-(void)initializeDepth:(int)nestLevel;
-(void)initializeParentLevel;
/**
 * @private 
 */		
-(void)invalidateCache;
-(void)initializeColumnLevel;

/**
 * @private 
 */		
-(void)invalidateCalculationsDown;
/**
 * Clears the checked rows and cells.
 */		
-(void)clearSelection:(BOOL)dispatch;
/**
 * @private 
 * @param grid
 * 
 */
-(void)initializeLevel:(FLXSFlexDataGrid*)grid;

/**
 * Applies the passed in value to the provided property and cascades that value down to the next level, if one exists. 
 * @param prp	The property to apply
 * @param value	The value to apply
 */
- (void)cascadeProperty:(NSString *)prp value:(id)value;

/**
 * @private 
 */
- (void)transferProps:(FLXSFlexDataGridColumnLevel *)from to:(FLXSFlexDataGridColumnLevel *)to checkForChanges:(BOOL)checkForChanges;
-(FLXSFlexDataGridColumnLevel*)clone:(BOOL)transferCols;
-(NSObject*)cloneColumn:(NSObject*)col;
/**
 * Gets the height of the header, footer, pager if visible.  
 */	
-(float)getRowHeight:(int)chromeLevel;
/**
 * Gets the sum of all column widths. 
 */	
-(float)getSumOfColumnWidths:(NSArray*)modes;
/**
 * All columns where visible=true and lock modes match the specified lock modes.  
 */	
-(NSArray*)getVisibleColumns:(NSArray*)lockModes;

/**
 * All visible columns where excludeFromExport=false
 */
- (NSArray *)getExportableColumns:(NSArray *)lockModes deep:(BOOL)deep options:(FLXSExportOptions *)options;
/**
 * All visible columns where sortable=true
 */		
-(NSArray*)getSortableColumns;
/**
 * Gets the list of filter arguments at this level.  
 */	
-(NSArray*)getFilterArguments;
/**
 * Removes the filter at this level, and all of this child levels, if specified.
 */	
-(void)clearFilter:(BOOL)recursive;

/**
 *All columns that can be "hidden"
 */
- (NSArray *)getShowableColumns:(NSArray *)lockModes deep:(BOOL)deep;

/**
 * All visible columns where excludeFromPrint=false
 */
- (NSArray *)getPrintableColumns:(NSArray *)lockModes deep:(BOOL)deep;

/**
 * Returns the filter for this level 
 */
- (FLXSAdvancedFilter *)createFilter:(NSObject *)parentObject inFilter:(FLXSFilter *)inFilter;
/**
 * Returns the widest right locked width.
 */	
-(float)getWidestRightLockedWidth:(float)widestRightLockedWidth;
-(float)rightLockedWidth;
-(float)getWidestLeftLockedWidth:(float)widestLeftLockedWidth;
/**
 * Gets all left locked columns
 */	
-(NSArray*)leftLockedColumns;
/**
 * Gets all right locked columns
 */	
-(NSArray*)rightLockedColumns;
/**
 * Gets all unlocked columns
 */	
-(NSArray*)unLockedColumns;
/**
 * List of visible columns of the specified lock modes. 
 */	
-(NSArray*)getColumns:(NSArray*)types;
/**
 * Gets the sum of left lock column widths
 */	
-(float)leftLockedWidth;
/**
 * Gets the sum of left lock column widths
 */	
-(float)unLockedWidth;

/**
 * At each level, get the sum of column widths, and return the width at the 
 * level with the widest width. Only includes locked columns by default.
 */
- (float)getWidestWidth:(float)widestWidth deep:(BOOL)deep;
-(NSArray*)getColumnsByWidthMode:(NSArray*)modes;
/**
 * Goes through the unlocked columns, figures out the widest width needed by each of the columns
 * by going through the data provider, and sets the width accordingly.
 * 
 * If the equally parameter is set to true, all column settings are ignored, and the grid's width
 * is distributed equally across all columns
 * 
 * Below is a description of the logic used:
 * 
 * @copy com.flexicious.nestedtreedatagrid.FlexDataGridColumn#columnWidthMode
 */	
-(void)setColumnWidthsUsingWidthMode:(BOOL)equally;

/**
 * Given a column and a dataprovider, measures the width required to render the text in the column, and if such width
 * is greater than the minwidth of the column, applies that width to the column
 *   
 * @param col		The FlexDataGridColumn object
 * @param provider	The provider used to figure out the text width. You may use the grid.flatten(this.nestDepth,false,true,true,true,columnWidthModeFitToContentSampleSize);
 */
- (void)applyColumnWidthFromContent:(FLXSFlexDataGridColumn *)col provider:(NSArray *)provider;
/**
 * If the grid's horizontal scroll policy is off, then returns the width of the 
 * unlocked section minus the width of the scroll bar else returns the sum of all
 * column widths.
 */	
-(float)getAvailableWidth;

/**
 * Once we have the widest width, since we dont want the grid to appear jagged in multi levels
 * Adjust all columns where the widths are same so it looks like a contiguous rectangle.
 * 
 * If the equally parameter is set to true, it will sum up the total column widths, and resize them 
 * all equally. 
 */
- (void)adjustColumnWidths:(float)widestWidth equally:(BOOL)equally;
/**
 * If a value exists for a style property at the  level return it, else return the value of the property at the grid level.
 */	
-(id)getStyleValue:(NSString*)styleProp;
/**
 * @private 
 */		
-(void)invalidateList;

/**
 * For header checkbox state, returns if all items in the grid are checked.
 */
- (BOOL)areAllSelected:(NSArray *)items checkLength:(BOOL)checkLength;

/**
 * If there is a checked key field (usually a field that uniquely identifies an object)
 * returns the value of the selectedKeyField property of the item else returns the item itself. 
 * If saveLevel is set to true, returns a string in the format key|levelNestDepth. Use this
 * in cases where you wish to refresh the grid with new data from the server and open items
 * should only refer to the keys so the open state can be persisted across server roundtrips.
 */
- (NSObject *)getItemKey:(NSObject *)item saveLevel:(BOOL)saveLevel;
/**
 * If value is primitive, does a tostring, if XMLList, returns the text. 
 * @param val
 * @return 
 * 
 */	
-(NSObject*)getValue:(NSObject*)val;

/**
 * Provided an item or a key, and a flag that indicates what it is,
 * returns true if the item matches the respective comparison. 
 * @param itemOrKey
 * @param useItemKeyForCompare
 * @return 
 * 
 */
- (BOOL)isItemEqual:(NSObject *)itemOrKeyToCompare rowData:(NSObject *)rowData useItemKeyForCompare:(BOOL)useItemKeyForCompare;

- (BOOL)areItemsEqual:(NSObject *)itemA itemB:(NSObject *)itemB;

/**
 * Provided an item key, loops through the data provider, and finds
 * the item with the provided key. 
 */
- (NSObject *)getItemFromKey:(id)itemKey flat:(NSArray *)flat;

/**
 * Returns true if the getItemKey for the specified item exists in the selectedKeys collection.
 */
- (BOOL)isItemSelected:(NSObject *)item useExclusion:(BOOL)useExclusion;
/**
 * Returns true if the getItemKey for the specified item exists in the selectedKeys collection.
 */	
-(BOOL)isItemOpen:(NSObject*)item;

/**
 * Returns true if the CellInfo for the specified item and column exists in the selectedCells collection.
 */
- (FLXSCellInfo *)isCellSelected:(NSObject *)item column:(FLXSFlexDataGridColumn *)col;

/**
 *Selects or unselects a cell 
 */
- (void)selectCell:(UIView <FLXSIFlexDataGridCell> *)cell selected:(BOOL)selected;

- (void)selectCellByRowPositionInfo:(FLXSRowPositionInfo *)rowInfo column:(FLXSFlexDataGridColumn *)col selected:(BOOL)selected;

/**
 * Inserts the column specified column before the specified column
 */
- (void)shiftColumns:(FLXSFlexDataGridColumn *)columnToInsert insertBefore:(FLXSFlexDataGridColumn *)insertBefore movingCg:(BOOL)movingCg;

- (void)swapColumns:(FLXSFlexDataGridColumnGroup *)cg columnToInsert:(FLXSFlexDataGridColumn *)columnToInsert insertBefore:(FLXSFlexDataGridColumn *)insertBefore;

/**
 * Selects or unselects everything
 */
- (BOOL)selectAll:(BOOL)select dispatch:(BOOL)dispatch provider:(NSArray *)provider subset:(NSArray *)subset useKeys:(BOOL)useKeys openItems:(BOOL)openItems;

/**
 * Selects or unselects a row - please note that the level that you call this method on should correspond to the 
 * item that you are selecting, in other words, if you are selecting an item at level 2 (child of the top level records)
 * then you should call it on the second level, i.e. grid.columnLevel.nextLevel.selctRow(...
 * @param item		Item being checked
 * @param checked	Whether or not the item should be checked
 * @param dispatch	Whether or not to dispatch the change event
 * @param recurse	Whether or not to recursively select children 
 * @param bubble	Whether or not to recursively update the parent state
 * @param parent	Parent of the item being checked. Needed for inner level single select support.
 * 
 */
- (void)selectRow:(NSObject *)item selected:(BOOL)selected dispatch:(BOOL)dispatch recurse:(BOOL)recurse bubble:(BOOL)bubble parent:(NSObject *)parent;
/**
 * @private
 */		
-(void)bubbleSelection:(NSObject *)item;
/**
 * @private
 */	
-(BOOL)existsInCursor:(NSObject*)item;
-(void)addSelectedItem:(NSObject*)item;
-(void)storeChain:(NSObject*)item;

/**
 * @param chain
 */
- (void)pushIntoChain:(NSMutableArray *)chain item:(NSObject *)item;
/**
 * @private
 */		
-(void)removeSelectedItem:(NSObject*)item;
/**
 * Sets the checked state at this level. If you specify checked, adds all rows
 * to the checked keys collection.
 * @param val
 */
-(void)setSelectedKeysState:(NSString*)val;

/**
 * For nested/grouped hierarchical datagrids, used to select records.
 * Iterates through the data provider, matching each object, and if matches, adds the object
 * to the selectedObjects for the level
 */
- (void)setSelectedObjects:(NSArray *)objects openItems:(BOOL)openItems;

/**
 * For nested/grouped hierarchical datagrids, used to select records.
 * Iterates through the data provider, matching each object, and if matches, adds the object
 * to the selectedObjects for the level
 */
- (void)setSelectedKeys:(NSArray *)objects openItems:(BOOL)openItems;

/**
 * For nested datagrids, used to get all records at all levels
 */
- (void)getSelectedObjects:(NSMutableArray *)soFar getKey:(BOOL)getKey unSelected:(BOOL)unSelected;
/**
 * If all items are checked, returns TriStateCheckBox.STATE_CHECKED.
 * If none are checked, returns TriStateCheckBox.STATE_UNCHECKED
 * else returns TriStateCheckBox.STATE_MIDDLE
 */	
-(NSString*)getSelectedKeysState:(NSArray*)allItems;

/**
 * Returns true if there is atleast one item in the checked keys collection
 * for this level, or if the next level uses this levels columns, then  the 
 * checked keys collection for the next level.
 */
- (BOOL)areAnySelected:(NSArray *)itemsToCheck recursive:(BOOL)recursive;

/**
 * If the dataprovider is IHierarchicalCollectionView, calls the getChildren method on the incoming object.
 * Else returns the value of the level.childrenField property on the object being passed in
 */
- (NSArray *)getChildren:(NSObject *)object filter:(BOOL)filter page:(BOOL)page sort:(BOOL)sort;

/**
 * Calls getChildren, and if result is XML or XMLList, returns length() else returns length;
 */
- (int)getChildrenLength:(NSObject *)object filter:(BOOL)filter page:(BOOL)page sort:(BOOL)sort;
/**
 * Sets the visible flag on all columns except the ones specified in the list to false.
 */	
-(void)showColumns:(NSArray*)colsToShow;
/**
 * Sets the visible flag on all columns except the ones where excludeFromPrint=true.
 */	
-(void)showPrintableColumns;

/**
 *Returns the column with the specified datafield
 */
- (FLXSFlexDataGridColumn *)getColumnByDataField:(NSString *)fld by:(NSString *)by;
/**
 *Returns the column with the specified UniqueIdentifier
 */	
-(FLXSFlexDataGridColumn*)getColumnByUniqueIdentifier:(NSString*)fld;
/**
 * Clears out all the columns of the grid 
 * If the parameter to rebuild is true, the grid will be rebuilt.
 * Otherwise, just the columns will be cleared, and the consumer code
 * should rebuild the grid.
 */
-(void)clearColumns:(BOOL)rebuild;
/**
 * Adds the column to the collection of columns at this level.
 * Deprecated. Use columns setter instead. <br/> 
 * var cols:Array=level.columns;<br/> 
 * //manipulate cols<br/> 
 * level.columns=cols;<br/> 
 */	
-(void)addColumn:(FLXSFlexDataGridColumn*)col;
/**
 * Removes the column from the collection of columns at this level.
 */
-(void)removeColumn:(FLXSFlexDataGridColumn*)col;
/**
 * Modifies the columns so the width is distributed equally.
 * Columns that are fixedWidth are not updated. 
 */	
-(void)distributeColumnWidthsEqually;

/**
 * Returns the column groups specified at the level cgLevel.
 */
- (NSArray *)getColumnGroupsAtLevel:(int)cgLevel grps:(NSArray *)grps result:(NSMutableArray *)result start:(float)start all:(BOOL)all;
-(NSString*)traceCols;
-(void)ensureRowNumberColumn;

/**
 * A list of ID values, based on the selectedKeyField property.
 * For hierarchical datagrids, used to get all open(expanded) records at all levels.
 * Please NOTE - this is a read only collection. Adding to this does nothing. 
 * 
 * If you want to programatically modify the collapse expand, use the setOpenKeys instead, or add directly to the open items.
 * */
- (void)getOpenKeys:(NSMutableArray *)keys provider:(NSArray *)provider;

/**
 * Sets the open keys at this level.
 * */
- (void)setOpenKeys:(NSArray *)keys provider:(NSArray *)provider;
-(BOOL)hasFilterFunction;

/**
 * Iterates through items, checks to see if the checked bit is on, and if so, adds it to the open list.
 */
- (BOOL)setSelectedItemsBasedOnSelectedField:(NSArray *)items parent:(NSObject *)parent openItems:(BOOL)openItems;
-(void)addUnSelectedItem:(NSObject*)item;
/**
 * @private
 */	
-(void)removeUnSelectedItem:(NSObject*)item;

/**
 * @private
 */
- (void)selectRowExclusion:(NSObject *)item selected:(BOOL)selected;

- (NSString *)getCheckBoxStateBasedOnExclusion:(NSObject *)item useBubble:(BOOL)useBubble checkDisabled:(BOOL)checkDisabled;
/**
 * Returns true if the getItemKey for the specified item exists in the selectedKeys collection.
 */	
-(BOOL)isItemUnSelected:(NSObject*)item;
-(int)getNumChildren:(NSObject*)item;

/**
 * @private
 */
- (NSArray *)getItemsInSelectionHierarchy:(NSObject *)parent recurse:(BOOL)recurse inNestDepth:(float)inNestDepth retVal:(NSArray *)retVal clear:(BOOL)clear getUnSelected:(BOOL)getUnSelected;
/**
 * Returns the first item from the selectedObjects collection, if one exists at this level. If there is none,
 * then returns the selectedItem collection of the next level.
 */	
-(NSObject*)selectedItem;
/**
 * For columns with headerWordWrap, calculates the height required to display text in full.
 */
-(void)calculateHeaderHeights;
/**
 * Goes through all the columns, adds up headerHeight, and the parent column groups until it reaches the top.
 * Gets the max, and returns that number
 */	
-(float)sumHeaderAndColumnGroupHeights;
/**
 * Get the maximum  depth of column groups. 
 */	
-(float)getMaxColumnGroupDepth;

/**
 *  @private
 */
- (void)setStyle:(NSString *)styleProp value:(id)value;
/**
 * If a value exists for a style property at the  level return it, else return the value of the property at the grid level.
 */		
-(id)getStyle:(NSString*)styleProp;

+ (NSArray*)static_columnProps;


//FLXSIEventDispatcher methods
/**
 * Whenever a tree datagrid event is dispatched at any level,
 * we also dispatch it from the top level grid so if someone wants
 * to listen for an event at all levels...
 */	
-(void)dispatchEvent:(FLXSEvent *)event;

- (void)addEventListenerOfType:(NSString *)type usingTarget:(NSObject *)target withHandler:(SEL)handler;
-(void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler;
//End FLXSIEventDispatcher methods

@end