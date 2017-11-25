#import "FLXSVersion.h"
#import "FLXSNdgBase.h"
#import "FLXSRowPositionInfo.h"
#import "FLXSElasticContainer.h"
#import "FLXSPreferenceInfo.h"
#import "FLXSIExtendedDataGrid.h"
@class FLXSStyleManager;
@class FLXSSavePreferenceViewController;
@class FLXSRendererCache;
@class FLXSExporter;
@class FLXSFlexDataGridColumnLevel;
@class FLXSUserSettingsController;
@class FLXSToolbarAction;
@protocol FLXSIFlexDataGridDataCell;
@class FLXSFilter;
@protocol FLXSIFlexDataGridCell;
@class FLXSFlexDataGridColumn;
@class FLXSPrintExportOptions;
 @class FLXSRowPositionInfo;
@protocol FLXSIExtendedPager;
@class FLXSExportOptions;
@class FLXSComponentInfo;
@class FLXSRowInfo;
@class FLXSFlexDataGridEvent;
@class FLXSFlexDataGridHeaderCell;
@class FLXSExtendedFilterPageSortChangeEvent;
@class FLXSFilterPageSortChangeEvent;
@protocol FLXSIFilterControl;
@class FLXSFlexDataGridBodyContainer;
@class FLXSFlexDataGridVirtualBodyContainer;
@class FLXSFlexDataGridHeaderContainer;
@class FLXSLockedContent;
@class FLXSColumnHeaderOperationBehavior;
@class FLXSRowEditBehavior;
@class FLXSTooltipBehavior;
@class FLXSSpinnerBehavior;
@protocol FLXSISpinner;
@class FLXSInsertionLocationInfo;
@class FLXSFlexDataGridContainerBase;
@protocol FLXSIPager;
@class FLXSFlexDataGridColumnGroup;

@class FLXSSelectionInfo;
@class FLXSPrintOptions;
@class FLXSGridPreferencesInfo;
@class FLXSUserSettingsOptions;
@class FLXSKeyValuePairCollection;
@class FLXSExportOptionsViewController;
@class FLXSFontInfo;

#import "FLXSIEventDispatcher.h"
#import "FLXSIPersistable.h"
#import "FLXSISpinnerOwner.h"

@protocol FLXSFlexDataGridDelegate<NSObject>

@optional

@end
/**
    * <p>
    * FLXSFlexDataGrid is the class name for Flexicious Ultimate, a DataGrid component built for the IOS from the ground up to cater to the needs of UI developers who create complex Line of Business applications.<br/><br/>
    * </p>
    * <ol>
    * <li>Ability to organize information as rows and columns, with locked headers</li>
    * <li>Ability to Customize the appearance Rows and Columns</li>
    * <li>Inline Editing, Customizable Editors, with validation hooks</li>
    * <li>User Interactive, Draggable, Resizable, Sortable and Editable Columns</li>
    * <li>Multi Column Sort</li>
    * <li>Multi Level, Expand Collapse enabled Grouped Column Headers</li>
    * <li>Single Cell, Single Row, Multiple Cell, Multiple Row selection modes.</li>
    * <li>Support for UI skinning via styles, factories, as well as programmatic control</li>
    * <li>Display of Homogenous Hierarchical Data (Single Set Of Columns)</li>
    * <li><em>Inline Filtering, with numerous built in Filter Controls, and extensible architecture to define your own.</em></li>
    * <li><em>Server and Client based Paging, with a fully Customizable Pager UI.</em></li>
    * <li><em>Summary Footers, with fine tuned control over Formula, Precision, Formatting, Placement and Rendering of Footers.</em></li>
    * <li><em>Print and Live Print Preview, with ability to control Page Size, Orientation, Columns To Print, Page/Report Headers and Footers.</em></li>
    * <li><em>Ability to Export the Print output to any ActionScript PDF library, including Alive PDF</em></li>
    * <li><em>Ability to create Customizable Reports with your own Headers/Footers.</em></li>
    * <li><em>Ability to Export to Excel, Word, Text, XML and other formats. Ability to plug in your own Exporters</em></li>
    * <li><em>Preference Persistence (Ability for your end users to save viewing preferences)</em></li>
    * <li><em>CheckBox based selection of data, with Tri State CheckBox Header</em></li>
    * <li><em>Customizable loading Animation</em></li>
    * <li><b>Smooth Scrolling</b></li>
    * <li><b>Display of Heterogonous Hierarchical Data (Multiple Sets Of Columns)</b></li>
    * <li><b>Ability to define paging, filtering and summary footers at each hierarchical level</b></li>
    * <li><b>Ability to define Fully Lazy Loaded, Partially Lazy Loaded and Initial Loaded Flat as well as Hierarchical Data Grids.</b></li>
    * <li><b>Left and Right Locked columns</b></li>
    * <li>A vast number of Business Scenarios supported out of the box:</li>
    * 	<ul>
    * 	<li><b>Cascading of row selection for hierarchical data</b></li>
    * 	<li><b>Ability to control whether or not rows with no children are shown (For grouped entries)</b></li>
    * 	<li><b>Drill Down/Drill Up/Drill To of Hierarchical data</b></li>
    * 	<li><b>Toolbar action icons, with ability to define custom actions</b></li>
    * 	<li><b>Ability to define initial sort values at any level</b></li>
    * 	<li><b>Ability to programmatically navigate to a row</b></li>
    * 	<li><b>Ability to show custom tooltip on hover over</b></li>
    * 	<li><b>Ability to fully customize sizes, borders, backgrounds, and styles for any cell programmatically as well as via CSS</b></li>
    * 	<li><b>Ability to define custom logic that control row selection, enabled, background, border.</b></li>
    * 	<li><b>Auto adjustment of the height on basis of the number of rows displayed</b></li>
    * 	<li><em>Read write nested properties of complex objects</em></li>
    * 	<li><em>Automatic column width adjustment on basis of data</em></li>
    * 	<li><em>Ability to define various column width modes, like fitToContent, Percentage and Fixed</em></li>
    * 	</ul>
    * </ol>
   */
@interface FLXSFlexDataGrid : FLXSNdgBase <NSXMLParserDelegate,FLXSIEventDispatcher,FLXSISpinnerOwner,FLXSIPersistable>
{

}
@property(nonatomic,assign) id<FLXSFlexDataGridDelegate> delegate;                       // default nil. weak reference
/**
 * Returns the list of columns at the root level. 
 * The grid always has at least one column level. This is also referred to as the top level, or the root level. 
 * In flat grids (non hierarchical), this is the only level. But in nested grids, you could have any number of nested levels. 
 * The columns collection actually belongs to the columnLevel, and since there is one root level, 
 * the columns collection of the grid basically points to the columns collection of this root level.
 * 
 * Note : If you set the columns or the grouped columns dynamically, ensure you call grid.columnLevel.initializeLevel(grid);
 */
@property (nonatomic, strong  ) NSMutableArray* columns;
/**
 * Returns the list of groupedColumns at the root level. 
 * The grid always has at least one column level. This is also referred to as the top level, or the root level. 
 * In flat grids (non hierarchical), this is the only level. But in nested grids, you could have any number of nested levels. 
 * The groupedColumns collection actually belongs to the columnLevel, and since there is one root level, 
 * the groupedColumns collection of the grid basically points to the groupedColumns collection of this root level.
* Note : If you set the columns or the grouped columns dynamically, ensure you call grid.columnLevel.initializeLevel(grid); 
*/		
@property (nonatomic, strong) NSArray* groupedColumns;
/**
 * @private 
 */
@property (nonatomic, strong) FLXSRendererCache* rendererCache;

@property (nonatomic, strong) FLXSFlexDataGridBodyContainer* treeDataGridContainer;
/**
 * The Root Column Level. This is a property of type "FlexDataGridColumnLevel". 
 * This grid always has at least one column level. This is also referred to as the top level, or the root level. 
 * In flat grids (non hierarchical), this is the only level. But in nested grids, you could have any number of nested levels. 
 * The columns collection actually belongs to the columnLevel, and since there is one root level, the columns collection 
 * of the grid basically points to the columns collection of this root level.
 * 
 * The FlexDataGridColumnLevel class has a "nextLevel" property, which is a pointer to another instance of the same class, 
 * or a "nextLevelRenderer" property, which is a reference to a ClassFactory the next level. 
 * Please note, currently, if you specify nextLevelRenderer, the nextLevel is ignored. 
 * This means, at the same level, you cannot have both a nested subgrid as well as a level renderer.
 */	
@property (nonatomic, strong) FLXSFlexDataGridColumnLevel* columnLevel;
@property (nonatomic, strong) FLXSFlexDataGridHeaderContainer* treeDataGridHeader;
@property (nonatomic, strong) FLXSFlexDataGridHeaderContainer* treeDataGridFilter;
@property (nonatomic, strong) FLXSFlexDataGridHeaderContainer* treeDataGridFooter;
@property (nonatomic, strong) FLXSFlexDataGridHeaderContainer* treeDataGridPager;
/**
 * The cell that is the current mouse over. This could be any type of a cell, including header, footer, filter, pager or data cell.
 * If enableActiveCellHighlight is set to true, this cell will be highlighted using the activeCellColor style property.
 */	
@property (nonatomic, strong) UIView<FLXSIFlexDataGridCell>* currentCell;
/**
 * The container for the left locked filter and header cells. 
 * This is an instance of the LockedContent class, which basically is an extended 
 * UIComponent that manages the filter and footer cell visiblity, heights, and the y positions.
 * 
 * To access all the filter/header cells, please use the rows collection of the headerContainer
 * or filterContainer. This contains a single RowInfo object, which contains a cells collection.
 * The cells collection contains ComponentInfo objects, that has a component property, which is
 * an instance of one of the subclasses of FlexDataGridCell. The cell will have a renderer property
 * which is the actual UI control that is being displayed.
 */
@property (nonatomic, strong) FLXSLockedContent* leftLockedHeader;
/**
 * The container for the left locked data cells. This is an instance of the ElasticContainer class, 
 * which basically attaches to the owner component (which is the bodyContainer) and scrolls vertically along with it. 
 * The horizontal scroll of this component is set to off) 
 * 
 * To access all the data cells, please use the rows collection of the bodyContainer
 * This contains RowInfo objects, which contains a cells collection.
 * The cells collection contains ComponentInfo objects, that has a component property, which is
 * an instance of one of the subclasses of FlexDataGridCell. The cell will have a renderer property
 * which is the actual UI control that is being displayed.
 */
@property (nonatomic, strong) FLXSElasticContainer* leftLockedContent;
/**
 * The container for the left locked footer cells. 
 * This is an instance of the LockedContent class, which basically is an extended 
 * UIComponent that manages the filter and footer cell visiblity, heights, and the y positions.
 * 
 * To access all the footer cells, please use the rows collection of the footerContainer
 * This contains a single RowInfo object, which contains a cells collection.
 * The cells collection contains ComponentInfo objects, that has a component property, which is
 * an instance of one of the subclasses of FlexDataGridCell. The cell will have a renderer property
 * which is the actual UI control that is being displayed.
 */
@property (nonatomic, strong) FLXSLockedContent* leftLockedFooter;
/**
 *The container for the right locked filter and header cells. 
 * This is an instance of the LockedContent class, which basically is an extended 
 * UIComponent that manages the filter and footer cell visiblity, heights, and the y positions.
 * 
 * To access all the filter/header cells, please use the rows collection of the headerContainer
 * or filterContainer. This contains a single RowInfo object, which contains a cells collection.
 * The cells collection contains ComponentInfo objects, that has a component property, which is
 * an instance of one of the subclasses of FlexDataGridCell. The cell will have a renderer property
 * which is the actual UI control that is being displayed.
 */
@property (nonatomic, strong) FLXSLockedContent* rightLockedHeader;
/**
 * The container for the right locked data cells. This is an instance of the ElasticContainer class, 
 * which basically attaches to the owner component (which is the bodyContainer) and scrolls vertically along with it. 
 * The horizontal scroll of this component is set to off) 
 * 
 * To access all the data cells, please use the rows collection of the bodyContainer
 * This contains RowInfo objects, which contains a cells collection.
 * The cells collection contains ComponentInfo objects, that has a component property, which is
 * an instance of one of the subclasses of FlexDataGridCell. The cell will have a renderer property
 * which is the actual UI control that is being displayed.
 */
@property (nonatomic, strong) FLXSElasticContainer* rightLockedContent;
/**
 * The container for the right locked footer cells. 
 * This is an instance of the LockedContent class, which basically is an extended 
 * UIComponent that manages the filter and footer cell visiblity, heights, and the y positions.
 * 
 * To access all the footer cells, please use the rows collection of the footerContainer. 
 * This contains a single RowInfo object, which contains a cells collection.
 * The cells collection contains ComponentInfo objects, that has a component property, which is
 * an instance of one of the subclasses of FlexDataGridCell. The cell will have a renderer property
 * which is the actual UI control that is being displayed.
 */
@property (nonatomic, strong) FLXSLockedContent* rightLockedFooter;
/**
 * @private 
 */
@property (nonatomic, strong) FLXSInsertionLocationInfo* currentPoint;


/**
 * @private 
 */	
@property (nonatomic, assign) float isHScrollBarVisible;
/**
 * @private 
 */	
@property (nonatomic, assign) float isVScrollBarVisible;
@property (nonatomic, assign) BOOL doubleClickEnabled;

/**
 *	Flag that controls whether items are highlighted as the mouse rolls over them. 
 *  If true, rows are highlighted as the mouse rolls over them. 
 *  If false, rows are highlighted only when checked.
 *  @default true
 */
@property (nonatomic, assign) BOOL useRollOver;
@property (nonatomic, assign) BOOL dataProviderSet;
/**
 * The data provider for the grid. Needs to be a ListCollectionView. 
 * (ArrayCollection or XMLListCollection) or a HierarchicalCollectionView.
 * <p>
 * Please note, for hierarchical data, hierarchy is setup in the Grid itself, so 
 * it is not necessary to provide a HierarchicalCollectionView in order to display
 * Hierarchical Nested Data. Flexicious Ultimate was designed with multi Level Heterogeneous and 
 * Homogeneous Hierarchical Data in mind, so we do not have the need to implement a customized data 
 * structure to morph object graphs into nested data. We are able to consume flat 
 * ArrayCollections, and display a hierarchical UI. We provide numerous examples of this concept in our sample project. 
 * </p>
 * <p>
 * The Grid provides the concept of "columnLevels". In fact, a non-hierarchical 
 * Flexicious Ultimate Grid is simply a grid with just one column level. Please 
 * refer to the documentation of the FlexDataGridColumnLevel class.
 * </p>
 * <p>
 * When you have multiple levels of data (i.e. multiple Column Levels), 
 * you can just assign a flat collection to the top level, and within the flat collection 
 * specify which property contains the next level of data, via the childrenField property.  
 * </p>
 * <p>
 * If you specify a HierarchicalCollectionView, the grid will probe call its getChildren()
 * method until it reaches the depth of the inner most FlexDataGridColumnLevel. If you specify
 * an ArrayCollection, the grid uses the childrenField property to get the next level of data.
 * If you specify an XMLListCollection, the grid calls children() method on the XML object to 
 * get the next level of data.
 * </p>
 */	
@property (nonatomic, strong) NSArray *dataProviderFLXS;
/**
 * If you set this to true, the next call to rebuild will not rebuild the pager control
 * Needed in cases where there is user interaction in the pager control that we do not want 
 * to loose, but we want to rebuild the rest of the grid. 
 */
@property (nonatomic, assign) BOOL preservePager;
/**
 * A box to cover the space left behind by the horizontal scrollbar when horizontalScrollPolicy=on and there are left locked columns. 
 */
@property (nonatomic, strong) UIView* bottomBarLeft;
/**
 * A box to cover the space left behind by the horizontal scrollbar when horizontalScrollPolicy=on and there are left locked columns. 
 */
@property (nonatomic, strong) UIView* bottomBarRight;
/**
 * Set to true when the context menu is shown. 
 */	
@property (nonatomic, assign) BOOL contextMenuShown;
/**
 * By default, there is no filter applied. This is used by enableHideIfNoChildren, to hide items if there is a filter and no children qualify. 
 */	
@property (nonatomic, assign) BOOL hasFilter;
/**
 * A Class that is responsible for the multi column sort view. Defaults to MultiColumnSortRenderer. You 
 * can provide your own implementation by specifying a custom MultiColumnSortRenderer. 
 */
@property (nonatomic, strong) FLXSClassFactory* multiSortRenderer;
/**
 * @private 
 */	
@property (nonatomic, assign) BOOL isScrolling;
@property (nonatomic, assign) BOOL needHorizontalRecycle;
/**
 * @private 
 */	
@property (nonatomic, strong) NSString* childrenField;
/**
 * The column that initiated the drag 
 * @return 
 */	
@property (nonatomic, strong) FLXSFlexDataGridColumn* dragColumn;
/**
 * Flag to enable export to word and excel. 
 */
@property (nonatomic, assign) BOOL enableExport;
@property (nonatomic, assign) BOOL enableMultiColumnSort;
/**
 * Flag to indicate whether or not to enable paging functionality
 * @return
 */
@property (nonatomic, assign) BOOL enablePaging;
/**
 * The page size of the top(root) level. To control page sizes at inner levels, set the pageSize property on the inner level.  
 */	
@property (nonatomic, assign) int pageSize;

/**
 * Flag that indicates whether or not to show the footer
 * @param value
 */
@property (nonatomic, assign) BOOL enableFooters;


/**
 * Flag to enable edit on doubleclick as opposed to single click.
 * 
 * Editable columns begin edit when the user clicks on their cells. 
 * In cases where you have a cell based selection mode, this conflicts
 * with the user gesture of selecting a cell. In scenarios like this, you 
 * may wish to  set enableDoubleClickEdit=true
 * 
 * 
 * @default false
 */	
@property (nonatomic, assign) BOOL enableDoubleClickEdit;
/**
 * When enableVirtualScroll=true, setting this to true will cause each scroll event to issue a server request..
 * When this is set to false, the grid will only dispatch a virtualScroll event
 * when the uses pauses scroll, as opposed to continuously as they scroll. 
 * @default false
 */		
@property (nonatomic, assign) BOOL enableDrawAsYouScroll;
/**
* Flag to enable creation of the next level dynamically as the hierarchy is set.
* 
* For grouped nested datagrids where the Nest Hierarchy is not known at the outset,
* set this to true. When the grid hits the last "predefined" level, it calls the 
* dynamicLevelHasChildrenFunction function on the grid to see if there are more children.
* If this function returns true, a FlexDataGridColumnLevel object will automatically be created.
* This level will be a clone of the base level.
* 
* @default false
*/	
@property (nonatomic, assign) BOOL enableDynamicLevels;
/**
* Flag to enable tristate behavior for selection checkboxes.
* Applicable in nested grids, where if you select a child, the parent goes into middle state, indicating visually that
* atleast one of the children is checked.
* Post 2.6, this property works in tandem with enableSelectionBubble and enableSelectionCascade.
* Setting this to true requires that you also set enableSelectionBubble and enableSelectionCascade to true
* @default true
*/	
@property (nonatomic, assign) BOOL enableTriStateCheckbox;
/**
* A flag to bubble up selection from children to parents.
* If this is set to true, If all of the parents children
* are checked, the parent will be added to its corresponding levels selectedObjects property
* If any of the children are unselected, the parent will be removed from its corresponding levels selectedObjects Property, in addition
* to the child being removed from its corresponding level.
* 
* Please note - if your dataprovider is a flat array collection, along with childrenfield, you will also need to specify a parentField
* that exists on the children object to point back to the parent.
* 
* Post 2.6, this property works in tandem with enableSelectionCascade and enableTristateCheckbox.
* Setting this to true requires that you also set enableSelectionCascade and enableTristateCheckbox to true
* @default true
*/	
@property (nonatomic, assign) BOOL enableSelectionBubble;
/**
 * Flag to cascade checkbox or row selection down from the selection level.
 * Post 2.6, this property works in tandem with enableSelectionBubble and enableTristateCheckbox.
 * Setting this to true requires that you also set enableSelectionBubble and enableTristateCheckbox to true
 * @default true
 */
@property (nonatomic, assign) BOOL enableSelectionCascade;
/**
 * Flag to size the grid on basis of the number of rows displayed. When set to true, 
 * the grid will shrink or expand to show all the rows displayed, 
 * upto a maximum of the maxAutoAdjustHeight (which defaults to 500).
 * 
 * 
 * @default false
 */	
@property (nonatomic, assign) BOOL enableHeightAutoAdjust;
/**
 * The maximum height to adjust the grid when enableHeightAutoAdjust is set to true.
 * When enableHeightAutoAdjust set to true, the grid will shrink or expand to show all the rows displayed, 
 * upto a maximum of the maxAutoAdjustHeight (which defaults to 500).
 * 
 * @default 500
 */		
@property (nonatomic, assign) float maxAutoAdjustHeight;
/**
 * Flag to control whether or not an item that has no children is filtered out or not.
 * @default false
 */	
@property (nonatomic, assign) BOOL enableHideIfNoChildren;
/**
 * Flag to control whether or not to show the built in context menu items.
 * @default true
 */	
@property (nonatomic, assign) BOOL enableHideBuiltInContextMenuItems;
/**
 * Flag to enable the context menu copy items. If set to true, three custom context menu items will be added. <br/>
 * 1) The copy Cell context menu item, text controlled via the copyCellMenuText property. <br/>
 * Will call itemToLabel on the column associated with the current cell under the mouse passing in the rowData object of the rowInfo.<br/> 
 * 2) The copy Row context menu item, text controlled via the copyRowMenuText property. <br/>
 * Will call itemToLabel on all the visible columns associated with the level of the current cell under the mouse passing in the rowData object of the rowInfo.<br/>
 * 3) The copy All Rows context menu item, text controlled via the copyAllRowsMenuText property. <br/>
 * Will basically perform a inbuilt export to TXT<br/>
 * 
 * The result of the copy operation is pasted to the clipboard
 */	
@property (nonatomic, assign) BOOL enableCopy;
/**
 * Enables the print operation. This is simply a flag that the pager control looks for to show or hide the print and pdf buttons. 
 */		
@property (nonatomic, assign) BOOL enablePrint;
@property (nonatomic, strong) NSString* useSelectedSelectAllState;
/**
 * If all items from the top level are checked, returns TriStateCheckBox.STATE_CHECKED.
 * If none are checked, returns TriStateCheckBox.STATE_UNCHECKED
 * else returns TriStateCheckBox.STATE_MIDDLE
 */	
@property (nonatomic, strong) NSString* selectAllState;
@property (nonatomic, strong) UIView* editor;
@property (nonatomic, strong) UIView<FLXSIFlexDataGridDataCell>* editCell;
@property (nonatomic, assign) BOOL triggerEvent;
@property (nonatomic, assign) BOOL filterDirty;
@property (nonatomic, assign) int currentExpandLevel;
/**
 * @private 
 */	
@property (nonatomic, assign) BOOL updateTotalRecords;

/**
 * The total number of records at the root level (needs to be set only in server mode,
 * because there is no way for the grid to know how many records on
 * the server match the filter criteria)
 * In client mode, the count of the data provider is used instead.
 * @return
 */
@property (nonatomic, assign) int totalRecords;

/**
 * @private 
 */	
@property (nonatomic, assign) BOOL inRebuildBody;
/**
* Attaches the tooltip behavior to any UI component. The behavior does not
* automatically trigger, however, it does wrap all the functionality needed to 
* display a tooltip type control next to the requesting control.
*/
@property (nonatomic, strong) FLXSTooltipBehavior* tooltipBehavior;
/**
 * @private 
 */	
@property (nonatomic, strong) FLXSFlexDataGridColumnLevel* currentExportLevel;
/**
 * Last time the auto refresh timer was triggered 
 * @return 
 */	
@property (nonatomic, strong) NSDate* lastAutoRefresh;
/**
 * If flag is set to true, grid will dispatch an AUTO_REFRESH event every autoRefreshInterval milliseconds. 
 */
@property (nonatomic, assign) BOOL enableAutoRefresh;
/**
 * The number of milliseconds to wait before issuing an autorefresh call.
 * Defaults to 30000 (30 seconds) 
 */
@property (nonatomic, assign) float autoRefreshInterval;
/**
 * Timer instance to work with the auto refresh mechanism
 */	
@property (nonatomic, strong) NSTimer* autoRefreshTimer;
//@property (nonatomic, assign) SEL createRowNumberColumnFunction;
//@property (nonatomic, assign) SEL getRowIndexFunction;
/**
 * Tooltip to display when user hovers over expand icon 
 */
@property (nonatomic, strong) NSString* expandTooltip;
/**
 * @private
 * @param val
 *
 */
@property (nonatomic, strong) NSString* itemLoadMode;
/**
 * Tooltip to display when user hovers over collapse icon 
 */
@property (nonatomic, strong) NSString* collapseTooltip;
//@property (nonatomic, assign) SEL expandCollapseTooltipFunction;
/**
 * Comma delimited string of the following words: edit,delete,moveTo,moveUp,moveDown,addRow,filter
 */
@property (nonatomic, strong) NSString* builtInActions;
/**
 * @private 
 */		
@property (nonatomic, strong) FLXSKeyValuePairCollection* errorMap;
/**
 * A Flag that indicates if there are any errors 
 */	
@property (nonatomic, assign) BOOL hasErrors;
/**
 * Flag to enable dragging multiple rows. 
 */		
@property (nonatomic, assign) BOOL allowMultipleRowDrag;
/**
 * A flag that indicates whether the individual rows can have different height. 
 * Please note, atleast one column needs to have the wordWrap flag set to true. If you use custom item rendereres, these are not accounted for in the height measurement for performance reasons. In this case, you should override the getRowHeight method or define a getRowHeightFunction and provide your own implementation which is optimized for your situation. 
 */
@property (nonatomic, assign) BOOL variableRowHeight;
/**
 * By default, the flexicious Ultimate Grid does not instantiate and 
 * measure each cell renderer when you set variable row heights. It 
 * just uses the measureText functionality to estimate the height required
 * to fit the given text. In case where you have custom item renderers that have
 * other flex components that affect the heights of the cells, the grid does not 
 * take these into consideration, for performance reasons. 
 * 
 * This flag, introduced in 2.8 will change this behavior so such cells will be
 * taken in to account and a renderer will be instantiated. The grid will instantiate
 * a renderer, set its data, and then measure it to calculate the height required to render
 * it. Please note, this may slightly degrade performance, so set this flag to true only if you
 * need it. Specifying a getRowHeightFunction and estimating the height without involving 
 * display objects will be usually faster.
 */
@property (nonatomic, assign) BOOL variableRowHeightUseRendererForCalculation;
/**
 * In case the calculations of the row height with text measurements is not
 * accurate (Flash player bug) you can use this variable to adjust the calculation
 * based on your scenario 
 */	
@property (nonatomic, assign) float variableRowHeightOffset;
/**
 * Flag that controls whether or not to rebuild the entire grid on dataprovider change. If you set this to false, only the body will be rebuilt.
 */	
@property (nonatomic, assign) BOOL rebuildGridOnDataProviderChange;
/**
 * Flag that controls whether or not to clear out selectedObjects and selectedKeys when the data provider changes
 * Defaults to true, so if you are using server paging, set this false
 */	
@property (nonatomic, assign) BOOL clearSelectionOnDataProviderChange;
/**
 * Flag that controls whether or not to clear out openItems when the data provider changes
 * Defaults to true, so if you are using server paging, set this false
 */	
@property (nonatomic, assign) BOOL clearOpenItemsOnDataProviderChange;
/**
 * Flag that controls whether or not to clear out errors when the data provider changes
 * Defaults to true, so if you are using server paging, set this false
 */	
@property (nonatomic, assign) BOOL clearErrorsOnDataProviderChange;
/**
 * Flag that controls whether or not to clear out changes when the data provider changes
 * Defaults to true, so if you are refreshing the grid prior to savign it, set this to false.
 */	
@property (nonatomic, assign) BOOL clearChangesOnDataProviderChange;
/**
 * Flag that controls whether or not to clear out selectedObjects and selectedKeys when the filter changes
 * Defaults to false
 */		
@property (nonatomic, assign) BOOL clearSelectionOnFilter;
/**
 * Flag to automatically generate columns. If the data provider is set, has atleast one item, and there are no columns specified the grid will attempt
 * to introspect the first item and create columns on basis of the properties on the first item. Set this flag to false if you do not want this behavior.
 */		
@property (nonatomic, assign) BOOL generateColumns;
@property (nonatomic, assign) BOOL editable;
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
@property (nonatomic, assign) BOOL enableVirtualScroll;
/**
 * A function that can be used to control the background color of each cell in this column. 
 * If this function is null or returns null, the cell  will
 * use the alternatingItemColors style property. This function should take a IFlexDataGridDataCell 
 * object, which has a pointer to the row data (data) as well as other related information
 * found in the documentation of the FlexDataGridDataCell class. This function
 * should return an array of colors for a gradient fill, or a single color 
 * hex code (uint) for a single color fill.
 */
@property (nonatomic, strong) NSString* cellBackgroundColorFunction;
/**
 * In addition to the filter row, if you wish to apply external filters, or to apply filters at inner nested levels, you may use this property.
 * Works just like ListCollectionView.filterFunction 
 */
@property (nonatomic, strong) NSString* filterFunction;
/**
 * A function that can be used to control the Text color of each cell in this column. 
 * If this function is null or returns null, the cell Text will
 * use the alternatingTextColors style property. This function should take a IFlexDataGridDataCell 
 * object, which has a pointer to the row data (data) as well as other related information
 * found in the documentation of the FlexDataGridDataCell class. This function
 * should return  a single color hex code (uint).
 * 
 */
@property (nonatomic, strong) NSString* cellTextColorFunction;
/**
 * By default, the grid draws a set of expand collapse icons on the left locked section.
 * In case when you have a column with enableExpandCollapseIcon=true, you may choose to 
 * set this flag to false. 
 */
@property (nonatomic, assign) BOOL enableDefaultDisclosureIcon;
/**
 * An array of ChangeInfo objects that contains all the changes made to the data provider using the grid editing mechanism.
 */
@property (nonatomic, strong) NSMutableArray* changes;
/**
 * Flag to enable change tracking
 * If set to true, each addition, update(via the grid) or deletion to the data provider will be tracked. These can then be retrieved using the 
 * changes collection on the grid. The Changes Collection is an array of ChangeInfo objects that contains all the changes made to the data provider using the grid editing mechanism.
 */
@property (nonatomic, assign) BOOL enableTrackChanges;
/**
 * Flag to enable dataprovider based preselection of data. Please ensure you set selectedField at all appropriate columns levels. 
 */
@property (nonatomic, assign) BOOL enableSelectionBasedOnSelectedField;
/**
 *  Performance optimization, set this to true only if you are listening for the FlexDataGridEvent.CELL_RENDERED event
 */	
@property (nonatomic, assign) BOOL dispatchCellRenderered;
/**
 *  Performance optimization, set this to true only if you are listening for the FlexDataGridEvent.RENDERER_INITIALIZED event
 */
@property (nonatomic, assign) BOOL dispatchRendererInitialized;
/**
 *  Performance optimization, set this to true only if you are listening for the FlexDataGridEvent.CELL_CREATED event
 */	
@property (nonatomic, assign) BOOL dispatchCellCreated;
/**
 * Flag to hightlight the active cell. If set to true (default) the cell under the mouse or if navigating via keyboard, the current reference cell will be highlighted with the activeCellColor style. 
 */		
@property (nonatomic, assign) BOOL enableActiveCellHighlight;

/**
 * Flag to enable pull to refresh.
 */
@property (nonatomic, assign) BOOL enablePullToRefresh;
/**
 * Flag to enable pull to refresh.
 */
@property (nonatomic, strong) NSAttributedString * pullToRefreshAttributedTitle;


/**
 * Flag to hightlight the edit row. If set to true (default) the edit row will be highlighted with the editItemColors style. 
 */		
@property (nonatomic, assign) BOOL enableEditRowHighlight;
/**
 * The number of field dropdowns to display in the multi column sort popup. 
 */	
@property (nonatomic, assign) float multiColumnSortNumberFields;
/**
 * By default, for hierarchical datagrids, when there is a object that does not have the property being searched for, these objects are included in the filter match. Set this flag to true to exclude such objects 
 */	
@property (nonatomic, assign) BOOL filterExcludeObjectsWithoutMatchField;
/**
 * Function to control all the filtering at all levels. If you specify this, all built in filtering mechanics are ignored. This allows you to have full control over filtering.
 */
@property (nonatomic, strong) NSString* globalFilterMatchFunction;
/**
 * A function that can be used to control the enabled flag of each cell in this level. 
 * If this function is null or returns null, the cell will be enabled, selectable, and rollovers
 * will work. If this function returns false, the cell will not be selectable, the item renderers will
 * be disabled and it will have no rollovers.
 * This function has two parameters: 
 * 1) IFlexDataGridDataCell : Cell object which has a pointer to the row data (data) as well as other related information
 * found in the documentation of the FlexDataGridDataCell class. This parameter can be null, when the 
 * function is called as a response to a higher level checkbox select. For example, when the user hits 
 * select all. In this case, we do not always have a cell, and it will be passed in as null
 * 2) The actual data object bound to the row. 
 * This function should true or false.
 * 
 * For example:
 * 
 * private function rowDisabledFunction(cell:FlexDataGridCell,data:Object):Boolean{
 * 		return data.enabledl
 * }
 * 
 */
@property (nonatomic, strong) NSString*    rowDisabledFunction;
/**
 * A function that can be used to control whether clicking on any cell in this level will select it.  
 * If this function is null or returns false, clicking on the cell will not result in the row being checked.
 * If this function returns true, clicking on the cell will result in the row being checked in row selection modes only.
 * This function has two parameters: 
 * 1) IFlexDataGridDataCell : Cell object which has a pointer to the row data (data) as well as other related information
 * found in the documentation of the IFlexDataGridDataCell class. This parameter can be null, when the 
 * function is called as a response to a higher level checkbox select. For example, when the user hits 
 * select all. In this case, we do not always have a cell, and it will be passed in as null
 * 2) The actual data object bound to the row. 
 * This function should true or false.
 * 
 * For example:
 * 
 * private function rowSelectableFunction(cell:FlexDataGridCell,data:Object):Boolean{
 * 		return data.enabled;
 * }
 * 
 */
@property (nonatomic, strong) NSString* rowSelectableFunction;
/**
 * If enabled (set to a string with length>0), when a dataprovider with zero items is set, or when filter criteria returns no records, a message is shown with this data. To disable this functionality, please set this property to a blank string.
 */	
@property (nonatomic, strong) NSString* noDataMessage;
/**
 * When enableMultiColumnSort=true, setting this flag to on will enable AdvancedDataGrid like Split headers to enable multi column sort. 
 */
@property (nonatomic, assign) BOOL enableSplitHeader;
/**
 * Support for selection based on exclusion. In scenarios where you have lazy loaded grids, selection cascade and select all will 
 * simply set flags on the selectionInfo object. The selectedObjects and selectedKeys no longer contain references to data that is checked
 * Instead, they contain the items that the user explicitly checked. unSelectedObjects will contain items that the user explicitly unselected.
 * This helps maintain selection across very large lazy loaded datasets. When you set the enableSelectionExclusion flag to true, use the selectionInfo object to 
 * access the selection (or build a query on the server) to identify the objects user checked. Selection
 */	
@property (nonatomic, assign) BOOL enableSelectionExclusion;
/**
 * @private
 * 
 * When grid.enableSelectionExclusion=true, we keep track of chains of each explicitly checked/unselected item. We need to do this
 * in order to correctly put the parents in the chain to middle state.
 */	
@property (nonatomic, strong) NSMutableDictionary* selectionChain;
/**
 *  @private
 */
@property (nonatomic, strong) NSString* childrenCountField;
/**
 * If rowSpanFunction!=null or colSpanFunction!=null 
 */
@property (nonatomic, assign) BOOL hasRowSpanOrColSpan;
/**
 * A function that takes in a data object, and a column, and returns a number. -1 indicates that the row should span the entire height of the grid.
 * Please note, rowspans and col spans are only supported for data rows.
 */
@property (nonatomic, strong) NSString*  rowSpanFunction;
/**
 * A function that takes in a data object, and a column, and returns a number. -1 indicates that the row should span the entire width of the grid.
 * Please note, rowspans and col spans are only supported for data rows.
 * 
 * Since this function is defined on the grid, it will get a IFlexDataGridCell object that you should use to return a rowSpan or colSpan.
 * 
 */
@property (nonatomic, strong) NSString*  colSpanFunction;
/**
 * By default, the grid renders when the dataprovider is set. This might lead to a blank area being shown while the data is being fetched. 
 * If you set this flag to true, the grid will draw the columns, filter, pager, etc and then re-render when the data is fetched. This might add to the 
 * overall render time, but would be a better user experience if there is a slower backed with a significant lag in data load time. For faster backends,
 * it is recommended that this flag remain false, for slower backends, it should be set to true. It is also recommended that you set the showSpinnerOnFilterPageSort
 * flag to true, so a spinning animation will be shown while the data is being fetched.
 */
@property (nonatomic, assign) BOOL enableEagerDraw;
/**
 * When variableRowHeight =true, atleast one column needs to have the wordWrap flag set to true. If you use custom item rendereres, these are not accounted for in the 
 * height measurement for performance reasons. In this case, you should define a getRowHeightFunction and provide your own implementation which is optimized for your situation.
 * It should take the following parameters 
 * <ul>
 * <li>param item		The item being displayed</li>
 * <li>param level		The FlexDataGridColumnLevel object that the item belongs to</li>
 * <li>param rowType	The type of the row, one of the RowPositionInfo.ROW_TYPE_XXXX constants </li>
 * </ul>
 * and return 			Height of the row
 */	
@property (nonatomic, strong) NSString* getRowHeightFunction;
@property (nonatomic, strong) FLXSClassFactory* printComponentFactory;
/**
 * Only applicable when selectionMode=multipleRows or multipleCells
 * By default, when you click on a row (or cell), the grid will add it to the selection. If you click again, the grid will remove it from selection. 
 * If you click on another row (or cell), the grid will add that row/cell to the selection.
 * 
 * When you set this to false, when you click on a row, the grid will add it to selection, If you click again nothing will happen. If you click with the control key down
 * the grid will remove it from selection. If you click another row/cell, the originally checked row/cell will be unselected. If you CTRL click on another row,
 * the grid will add that row in addition to the previously checked row. In short, the grid will behave like the SDK MX datagrid.
 * @default true
 */
@property (nonatomic, assign) BOOL enableStickyControlKeySelection;
/**
 * By default, for performance reasons, the grid will only draw one large row to fill up the bottom in case that the grid is taller than
 * the sum of the row heights. However, for consistency with the MX grids, setting this property to true will cause the grid to draw
 * blank rows similar to the other data rows.
 */
@property (nonatomic, assign) BOOL enableFillerRows;
/**
 * Flag to turn on the highly optimized FlexDataGridDataCell3.
 * FlexDataGridDataCell3 is a light weight class introduced in Flexicious 2.7,  that renders 
 * 30% faster than its predecessor, FlexDataGridDataCell2. Since it is very lightweight, it only
 * supports the basics of text rendering, like fontFamily, pointSize, fontWeight, fontStyle
 * ,color, background, textAlign, and textDecoration. In most cases, this covers the range of things
 * that a typical application developer needs. But incase you need advanced text capabilities, like
 * TLF fonts, RTL, etc, you may need to turn off this flag either on the grid, or on specific
 * columns that you need advanced features on.
 * 
 * Once FDG3 is fully settled in the field, this flag will be removed and we will retire FDGC2.
 * As of right now, the FDGC3 cannot handle wordwrap, doubleclick, truncateToFit, handCursor.
 * The grid automatically swaps out the FDG3 with FDG when you set any of these flags. If you notice
 * any inconsistency when you enable this flag, you can turn this same flag off for the column that 
 * you notice the inconsistency on, and the grid will fall back to the older mechanism to display 
 * that column. Please send a message to support@flexicious.com with reproducible test case so we 
 * can equip FDGC3 to handle this scenario. 
 * 
 * In order to reduce impact, this flag will default to false for 2.8. In 2.9, this will be defaulted to true
 */	
@property (nonatomic, assign) BOOL enableDataCellOptmization;
/**
 * Flag should be set to true when you have large variable height based rows that are potentially
 * taller than the grid itself. The first row in view is the reference view. As you scroll,
 * newer rows become the reference rows and the view port end updated. However, when you have rows
 * that are taller than the grid, or when they account for a disproportionate amount of the viewport 
 * the grid no longer renders view port end becuase the reference row is large and has not scrolled
 * out of view. This flag is used to instruct the grid to check after
 * each scroll gesture whether or not additional rows have come into view.
 */
@property (nonatomic, assign) BOOL recalculateSeedOnEachScroll;
//typedef NSArray *(^FLXSGetChildrenFunctionBlock)(NSObject *, FLXSFlexDataGridColumnLevel*);
/**
 * This function basically gives you the opportunity to tie in to the grids hierarchy lookup mechanism. 
 * By default, the grid will call the getChildren method on this class to get the children of any object
 * when it is time to draw the hierarchy. By defining a custom getChildrenFunction, you can intercept
 * this mechanism to provide your own implementation of retrieving children. 
 * The signature of this function should be like below:
 * getChildren(object:Object,level:FlexDataGridColumnLevel):Object
 */	
@property (nonatomic, strong) NSString* getChildrenFunction;
/**
 * The spinner component. Will be null unless showSpinner is called. 
 */
@property (nonatomic, strong) UIView<FLXSISpinner>* spinner;
/**
* Attaches the spinner behavior to the owner component. 
* When the startspin method of this behavior is called, the 
* behavior will instantiate a new spinner based on the owners
* Spinner Factory, and position it in the middle of the owner
* components display area.
* When the stop spin method is called, the behavior will remove
* the spinner from the owner component and stop the spin.
*/
@property (nonatomic, strong) FLXSSpinnerBehavior* spinnerBehavior;
/**
 * Added in 2.9 to avoid flicker. 
 */	
@property (nonatomic, assign) BOOL enableLocalStyles;
/**
 * Added in 2.9 to avoid multiple change events from firing. 
 */	
@property (nonatomic, assign) BOOL enableDelayChange;
/**
 * Added in 2.9 to force columns to take the widths that the user specified.
 * Once the user resizes the column, the column widths basically are set to "fixed". 
 */	
@property (nonatomic, assign) BOOL enableColumnWidthUserOverride;
@property (nonatomic, assign) BOOL inUpdate;
@property (nonatomic, assign) BOOL changePending;
@property (nonatomic, assign) BOOL rebuildBodyPending;
/**
 * When you enable headerWordWrap=true, then we need to set this to true, because
 * we will dyamically adjust the height of the header row. Please be advised, currently, (as of 2.9)
 * columnGroups get the same height as the header cells.
 */	
@property (nonatomic, assign) BOOL variableHeaderHeight;
@property (nonatomic, assign) BOOL fillerInvalidated;
/**
 * If this is defined, in addition to checking if the column is editable, this call back is called
 * for each cell in this column to ensure that the cell is editable.  
 * 
 * This allows you to conditionally define editable flag on a cell basis.
 */		
@property (nonatomic, strong) NSString* cellEditableFunction;
/**
 * @private 
 */
@property (nonatomic, strong) FLXSColumnHeaderOperationBehavior* columnHeaderOperationBehavior;
/**
 * Flag to enable column header operations.
 */	
@property (nonatomic, assign) BOOL enableColumnHeaderOperation;
/**
 * @private 
 */
@property (nonatomic, strong) FLXSRowEditBehavior* rowEditBehavior;
/**
 * A flag to disable the double click timer mechanism. When the user double clicks on a row, it typically 
 * has the net effect of 2 clicks, which selects and then unselects that row. To combat this, we have a timer
 * that discards the second click. However, in scenarios where this is not the desired behavior, you can set this
 * flag to false, and the timer will no longer execute.
 */	
@property (nonatomic, assign) BOOL enableDoubleClickTimer;
/**
 * Flag to enable full row edit behavior. In this mode, editing a cell causes the entire row
 * to present its editors. 
 */
@property (nonatomic, assign) BOOL enableRowEdit;

/**
 * The default exporter in flexicious is a pure CSV exporter. 
 * This property lets you hook in a native excel exporter using a libary
 * like as3xls. Just like Alive PDF, as3xls is not embedded in to the 
 * core flexicious library, instead it is distributed as a part of the sample.
 * Just like for pdf, you hook up the AlivePdfPrinter, you use the nativeExcelExporter to 
 * hookup an implementation of the flexicious expoter that interfaces with the as3xls library
 * to provide native excel export 
 */
@property (nonatomic, strong) FLXSExporter* nativeExcelExporter;
/**
 * A comma seperated list of the following strings:
 * filter,header,body,footer,pager.
 * 
 * Changes the order in which the grid displays the
 * filter,header,body,footer,pager
 * The order in which the various sections of the grid
 * are laid out.
 * 
 * Defaults to pager,filter,body,footer
 */
@property (nonatomic, strong) NSString*displayOrder;
/**
 * Returns the top level selectedObjects
 */
@property (nonatomic, readonly)NSArray*selectedItems;
/**
 * A field on the dataprovider that indicates that this item should be checked
 */
@property (nonatomic, strong)NSString* selectedField;

@property (nonatomic, strong) FLXSPrintOptions * printOptions;
@property (nonatomic, strong) FLXSPrintOptions * pdfOptions;
@property (nonatomic, strong) FLXSExportOptions * excelOptions;
@property (nonatomic, strong) FLXSExportOptions * wordOptions;
/**
 * Flag that indicates whether or not to show the filter
 * @param value
 */
@property (nonatomic, assign) BOOL enableFilters;
@property (nonatomic, readonly) BOOL forceColumnsToFitVisibleArea;


@property (nonatomic, strong) NSString* preferencesToPersist;
@property (nonatomic, assign) BOOL enablePreferencePersistence;
@property (nonatomic, strong) NSString* preferencePersistenceMode;
@property (nonatomic, strong) NSString* preferencePersistenceKey;
@property (nonatomic, strong) NSString* preferences;
@property (nonatomic, strong) NSString* lastPrintOptionsString;
@property (nonatomic, strong) NSString* persistedPrintOptionsString;
/**
 * @private 
 */	
@property (nonatomic, strong) NSArray* printExportData;


@property (nonatomic, assign) BOOL preferencesSet;
@property (nonatomic, assign) BOOL userPersistedColumnWidths;
@property (nonatomic, assign) BOOL useCompactPreferences;
@property (nonatomic, assign) BOOL preferencesLoaded;
@property (nonatomic, strong) NSString* userSettingsOptionsFunction;
@property (nonatomic, assign) BOOL enableMultiplePreferences;
@property (nonatomic, strong) FLXSGridPreferencesInfo* gridPreferencesInfo;
@property (nonatomic, strong) FLXSPreferenceInfo* currentPreference;
@property (nonatomic, assign) BOOL autoLoadPreferences;
@property (nonatomic, strong) FLXSClassFactory* popupFactorySaveSettingsPopup;
@property (nonatomic, strong) FLXSClassFactory* popupFactoryOpenSettingsPopup;
@property (nonatomic, strong) FLXSClassFactory* popupFactorySettingsPopup;
@property (nonatomic, strong) FLXSClassFactory* popupFactoryPrintOptions;
@property (nonatomic, strong) FLXSClassFactory* popupFactoryExportOptions;

/**
 * Gets the pager row height at the top level.
 */	
@property (nonatomic, assign) float  pagerRowHeight;
/**
 * Returns the sum of: <br/>
 * If enableFooters, then footerRowHeight else 0
 * @return 
 */
@property (nonatomic, assign) float  footerRowHeight;
/**
* Height of the row
* @return
*/
@property (nonatomic, assign) float  rowHeight;
/**
* Height of the header row
* @return
*/
@property (nonatomic, assign) float  headerRowHeight;

/**
 * Sets the filter row height at the top level.
 */	
@property (nonatomic, assign) float  filterRowHeight;
/**
 * Returns true if the pager row is visible at the top level.
 */	
@property (nonatomic, assign) BOOL  pagerVisible;
/**
 * Returns true if the filter row is visible at the top level.
 */
@property (nonatomic, assign) BOOL  filterVisible;
/**
 * Returns true if the footer row is visible at the top level.
 */
@property (nonatomic, assign) BOOL  footerVisible;
/**
 * Returns true if the header row is visible at the top level.
 */
@property (nonatomic, assign) BOOL  headerVisible;

/**
 * The horizontal scroll position of the body container. The body container is
 * the only section to have a scroll bar. The left and right locked containers scroll
 * along with it.
 */	
@property (nonatomic, assign) float horizontalScrollPosition;
/**
 * The vertical scroll position of the body container. The body container is
 * the only section to have a scroll bar. The left and right locked containers scroll
 * along with it.
 */		
@property (nonatomic, assign) float verticalScrollPosition;
/**
 * @private
 */
@property (nonatomic, strong) NSString* horizontalScrollPolicy;
/**
 * @private 
 */	
@property (nonatomic, strong) NSString* verticalScrollPolicy;

//styles

/**
 * Colors for the spinners as an array.
 * First element for the circle color and second for the spinner color
 * [Style(name="spinnerColors",type="Array",format="Color")]
 * @type {null}
 * @property spinnerColors
 * @default null
 */
@property (nonatomic, strong) UIColor * spinnerColor ;
/**
 * Spinner radius , default value is 10
 *
 * [Style(name="spinnerRadius", type="Number", format="Length", minValue="0.0")]
 * @type {null}
 * @property spinnerRadius
 * @default null
 */
@property (nonatomic, assign) int spinnerRadius ;
/**
 * Background color of the grid when the spinner is active
 * [Style(name="spinnerGridAlpha", type="Number", format="Length", minValue="0.0")]
 * @type {null}
 * @property spinnerGridAlpha
 * @default null
 */

@property (nonatomic, assign) float spinnerGridAlpha ;
/**
 * Bacground color for the box in which the label is displayed
 *
 */
@property (nonatomic, strong) UIColor * spinnerLabelBackgroundColor ;


/**
 * A flag that controls whether or not to show the spinner.
 */
@property (nonatomic, assign) BOOL spinnerLabelShowBackground ;

/**
 * Label color for the spinner
 */
@property (nonatomic, strong) UIColor * spinnerLabelColor ;


/**
 *  Alignment of text within a container.
 *  Possible values are <code>"left"</code>, <code>"right"</code>,
 *  or <code>"center"</code>.
 *
 *  <p>The default value for most components is <code>"left"</code>.
 *  For the FormItem component,
 *  the default value is <code>"right"</code>.
 *  For the Button, LinkButton, and AccordionHeader components,
 *  the default value is <code>"center"</code>, and
 *  this property is only recognized when the
 *  <code>labelPlacement</code> property is set to <code>"left"</code> or
 *  <code>"right"</code>.
 *  If <code>labelPlacement</code> is set to <code>"top"</code> or
 *  <code>"bottom"</code>, the text and any icon are centered.</p>
 *
 * [Style(name="textAlign", type="String", enumeration="left,center,right", inherit="yes")]
 * @type {null}
 * @property textAlign
 * @default null
 */

@property (nonatomic, strong) NSString * textAlign ;
/**
 *  The width of  the numeric value representing the order of the column sort.
 *  @default 10
 *
 * [Style(name="multiColumnSortNumberWidth", type="Number", inherit="no")]
 * @type {null}
 * @property multiColumnSortNumberWidth
 * @default null
 */

@property (nonatomic, assign) float multiColumnSortNumberWidth ;
/**
 *  The height of  the numeric value representing the order of the column sort.
 *  @default 15
 *
 * [Style(name="multiColumnSortNumberHeight", type="Number", inherit="no")]
 * @type {null}
 * @property multiColumnSortNumberHeight
 * @default null
 */

@property (nonatomic, assign) float multiColumnSortNumberHeight ;
/**
 *  The name of a CSS style declaration for controlling other aspects of
 *  the appearance of the numeric value representing the order of the column sort.
 *  @default "multiColumnSortNumberStyle"
 *
 * [Style(name="multiColumnSortNumberStyleName", type="String", inherit="no")]
 * @type {null}
 * @property multiColumnSortNumberStyleName
 * @default null
 */

@property (nonatomic, strong) NSString * multiColumnSortNumberStyleName ;
/**
 *  The name of a CSS style declaration for controlling other aspects of
 *  the appearance of the column groups.
 *  @default "columnGroupStyle"
 *
 * [Style(name="columnGroupStyleName", type="String", inherit="no")]
 * @type {null}
 * @property columnGroupStyleName
 * @default null
 */

@property (nonatomic, strong) FLXSFontInfo * columnGroupStyleName ;
/**
 *  The name of a CSS style declaration for controlling other aspects of
 *  the appearance of the column headers.
 *  @default "dataGridStyles"
 *
 * [Style(name="headerStyleName", type="String", inherit="no")]
 * @type {null}
 * @property headerStyleName
 * @default null
 */

@property (nonatomic, strong) FLXSFontInfo * headerStyleName ;
/**
 *  The name of a CSS style declaration for controlling other aspects of
 *  the appearance of the pager bar(toolbar).
 *
 * [Style(name="pagerStyleName", type="String", inherit="no")]
 * @type {null}
 * @property pagerStyleName
 * @default null
 */
@property (nonatomic, strong) FLXSFontInfo * pagerStyleName;
/**
 *  The name of a CSS style declaration for controlling other aspects of
 *  the appearance of the column headers.
 *  @default "dataGridStyles"
 * [Style(name="footerStyleName", type="String", inherit="no")]
 * @type {null}
 * @property footerStyleName
 * @default null
 */

@property (nonatomic, strong) FLXSFontInfo * footerStyleName ;
/**
 *  Flag that indicates whether to show vertical grid lines between
 *  the columns.
 *  If <code>true</code>, shows vertical grid lines.
 *  If <code>false</code>, hides vertical grid lines.
 *  @default true
 * [Style(name="verticalGridLines", type="Boolean", inherit="no")]
 * @type {null}
 * @property verticalGridLines
 * @default null
 */

@property (nonatomic, assign) BOOL verticalGridLines ;
/**
 *  Flag that indicates whether to show horizontal grid lines between
 *  the rows.
 *  If <code>true</code>, shows horizontal grid lines.
 *  If <code>false</code>, hides horizontal grid lines.
 *  @default false
 * [Style(name="horizontalGridLines", type="Boolean", inherit="no")]
 * @type {null}
 * @property horizontalGridLines
 * @default null
 */

@property (nonatomic, assign) BOOL  horizontalGridLines ;
/**
 *  The color of the vertical grid lines.
 *  @default 0x666666
 * [Style(name="verticalGridLineColor", type="uint", format="Color", inherit="yes")]
 * @type {null}
 * @property verticalGridLineColor
 * @default null
 */

@property (nonatomic, strong) UIColor*  verticalGridLineColor ;
/**
 *  The color of the horizontal grid lines.
 * [Style(name="horizontalGridLineColor", type="uint", format="Color", inherit="yes")]
 * @type {null}
 * @property horizontalGridLineColor
 * @default null
 */

@property (nonatomic, strong) UIColor* horizontalGridLineColor ;
/**
 *  Thickness of the horizontal grid lines.
 *  @default 1
 * [Style(name="horizontalGridLineThickness", type="Number", format="Length", inherit="yes")]
 * @type {null}
 * @property horizontalGridLineThickness
 * @default null
 */

@property (nonatomic, assign) int horizontalGridLineThickness;
/**
 *  Thickness of the vertical grid lines.
 *  @default 1
 * [Style(name="verticalGridLineThickness", type="Number", format="Length", inherit="yes")]
 * @type {null}
 * @property verticalGridLineThickness
 * @default null
 */

@property (nonatomic, assign) int  verticalGridLineThickness ;
/**
 *  Flag that indicates whether to show vertical grid lines between
 *  the columns.
 *  If <code>true</code>, shows vertical grid lines.
 *  If <code>false</code>, hides vertical grid lines.
 *  @default true
 * [Style(name="headerVerticalGridLines", type="Boolean", inherit="no")]
 * @type {null}
 * @property headerVerticalGridLines
 * @default null
 */

@property (nonatomic, assign) BOOL  headerVerticalGridLines ;
/**
 *  Flag that indicates whether to show horizontal grid lines between
 *  the rows.
 *  If <code>true</code>, shows horizontal grid lines.
 *  If <code>false</code>, hides horizontal grid lines.
 *  @default false
 * [Style(name="headerHorizontalGridLines", type="Boolean", inherit="no")]
 * @type {null}
 * @property headerHorizontalGridLines
 * @default null
 */

@property (nonatomic, assign) BOOL  headerHorizontalGridLines ;
/**
 *  The color of the vertical grid lines.
 *  @default 0x666666
 * [Style(name="headerVerticalGridLineColor", type="uint", format="Color", inherit="yes")]
 * @type {null}
 * @property headerVerticalGridLineColor
 * @default null
 */

@property (nonatomic, strong) UIColor* headerVerticalGridLineColor ;
/**
 *  The color of the horizontal grid lines.
 * [Style(name="headerHorizontalGridLineColor", type="uint", format="Color", inherit="yes")]
 * @type {null}
 * @property headerHorizontalGridLineColor
 * @default null
 */

@property (nonatomic, strong) UIColor* headerHorizontalGridLineColor ;
/**
 *  Thickness of the header horizontal grid lines.
 *  @default 1
 * [Style(name="headerHorizontalGridLineThickness", type="Number", format="Length")]
 * @type {null}
 * @property headerHorizontalGridLineThickness
 * @default null
 */

@property (nonatomic, assign) float headerHorizontalGridLineThickness ;
/**
 *  Thickness of the header vertical grid lines.
 *  @default 1
 * [Style(name="headerVerticalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float headerVerticalGridLineThickness ;
/**
 *  Flag that indicates whether to force the top border
 *  @default false
 * [Style(name="headerDrawTopBorder", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL headerDrawTopBorder ;
/**
 *  Flag that indicates whether to show vertical grid lines between
 *  the columns.
 *  If <code>true</code>, shows vertical grid lines.
 *  If <code>false</code>, hides vertical grid lines.
 *  @default true
 * [Style(name="columnGroupVerticalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL columnGroupVerticalGridLines ;
/**
 *  Flag that indicates whether to show horizontal grid lines between
 *  the rows.
 *  If <code>true</code>, shows horizontal grid lines.
 *  If <code>false</code>, hides horizontal grid lines.
 *  @default false
 * [Style(name="columnGroupHorizontalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL columnGroupHorizontalGridLines ;
/**
 *  The color of the vertical grid lines.
 *  @default 0x666666
 * [Style(name="columnGroupVerticalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* columnGroupVerticalGridLineColor ;
/**
 *  The color of the horizontal grid lines.
 * [Style(name="columnGroupHorizontalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* columnGroupHorizontalGridLineColor ;
/**
 *  Thickness of the header horizontal grid lines.
 *  @default 1
 * [Style(name="columnGroupHorizontalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float columnGroupHorizontalGridLineThickness ;
/**
 *  Thickness of the header vertical grid lines.
 *  @default 1
 * [Style(name="columnGroupVerticalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float columnGroupVerticalGridLineThickness ;
/**
 *  Flag that indicates whether to force the top border
 *  @default false
 * [Style(name="columnGroupDrawTopBorder", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL columnGroupDrawTopBorder ;
/**
 *  Flag that indicates whether to show vertical grid lines between
 *  the columns.
 *  If <code>true</code>, shows vertical grid lines.
 *  If <code>false</code>, hides vertical grid lines.
 *  @default true
 * [Style(name="filterVerticalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic,assign) BOOL filterVerticalGridLines ;
/**
 *  Flag that indicates whether to show horizontal grid lines between
 *  the rows.
 *  If <code>true</code>, shows horizontal grid lines.
 *  If <code>false</code>, hides horizontal grid lines.
 *  @default false
 * [Style(name="filterHorizontalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL filterHorizontalGridLines ;
/**
 *  The color of the vertical grid lines.
 *  @default 0x666666
 * [Style(name="filterVerticalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* filterVerticalGridLineColor ;
/**
 *  The color of the horizontal grid lines.
 * [Style(name="filterHorizontalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* filterHorizontalGridLineColor ;
/**
 *  Thickness of the filter horizontal grid lines.
 *  @default 1
 * [Style(name="filterHorizontalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float filterHorizontalGridLineThickness ;
/**
 *  Thickness of the filter vertical grid lines.
 *  @default 1
 * [Style(name="filterVerticalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float filterVerticalGridLineThickness ;
/**
 *  Flag that indicates whether to force the top border, when horizontal gridlines are not drawn
 *  @default false
 * [Style(name="filterDrawTopBorder", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL filterDrawTopBorder ;
/**
 *  Flag that indicates whether to show vertical grid lines between
 *  the columns.
 *  If <code>true</code>, shows vertical grid lines.
 *  If <code>false</code>, hides vertical grid lines.
 *  @default true
 * [Style(name="footerVerticalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign)BOOL footerVerticalGridLines ;
/**
 *  Flag that indicates whether to show horizontal grid lines between
 *  the rows.
 *  If <code>true</code>, shows horizontal grid lines.
 *  If <code>false</code>, hides horizontal grid lines.
 *  @default false
 * [Style(name="footerHorizontalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL footerHorizontalGridLines ;
/**
 *  The color of the vertical grid lines.
 *  @default 0x666666
 * [Style(name="footerVerticalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* footerVerticalGridLineColor ;
/**
 *  The color of the horizontal grid lines.
 * [Style(name="footerHorizontalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* footerHorizontalGridLineColor ;
/**
 *  Thickness of the footer horizontal grid lines.
 *  @default 1
 * [Style(name="footerHorizontalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float footerHorizontalGridLineThickness ;
/**
 *  Thickness of the footer vertical grid lines.
 *  @default 1
 * [Style(name="footerVerticalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float footerVerticalGridLineThickness ;
/**
 *  Flag that indicates whether to force the top border, when horizontal gridlines are not drawn
 *  @default false
 * [Style(name="footerDrawTopBorder", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL footerDrawTopBorder ;
/**
 *  Flag that indicates whether to show vertical grid lines between
 *  the columns.
 *  If <code>true</code>, shows vertical grid lines.
 *  If <code>false</code>, hides vertical grid lines.
 *  @default true
 * [Style(name="pagerVerticalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL pagerVerticalGridLines ;
/**
 *  Flag that indicates whether to show horizontal grid lines between
 *  the rows.
 *  If <code>true</code>, shows horizontal grid lines.
 *  If <code>false</code>, hides horizontal grid lines.
 *  @default false
 * [Style(name="pagerHorizontalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL pagerHorizontalGridLines ;
/**
 *  The color of the vertical grid lines.
 *  @default 0x666666
 * [Style(name="pagerVerticalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* pagerVerticalGridLineColor ;
/**
 *  The color of the horizontal grid lines.
 * [Style(name="pagerHorizontalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* pagerHorizontalGridLineColor ;
/**
 *  Thickness of the pager horizontal grid lines.
 *  @default 1
 * [Style(name="pagerHorizontalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float pagerHorizontalGridLineThickness ;
/**
 *  Thickness of the pager vertical grid lines.
 *  @default 1
 * [Style(name="pagerVerticalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float pagerVerticalGridLineThickness ;
/**
 *  Flag that indicates whether to force the top border, when horizontal gridlines are not drawn
 *  @default false
 * [Style(name="pagerDrawTopBorder", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL pagerDrawTopBorder ;
/**
 *  Flag that indicates whether to show vertical grid lines between
 *  the columns.
 *  If <code>true</code>, shows vertical grid lines.
 *  If <code>false</code>, hides vertical grid lines.
 *  @default true
 * [Style(name="rendererVerticalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic,assign) BOOL rendererVerticalGridLines ;
/**
 *  Flag that indicates whether to show horizontal grid lines between
 *  the rows.
 *  If <code>true</code>, shows horizontal grid lines.
 *  If <code>false</code>, hides horizontal grid lines.
 *  @default false
 * [Style(name="rendererHorizontalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL rendererHorizontalGridLines ;
/**
 *  The color of the vertical grid lines.
 *  @default 0x666666
 * [Style(name="rendererVerticalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* rendererVerticalGridLineColor ;
/**
 *  The color of the horizontal grid lines.
 * [Style(name="rendererHorizontalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic,strong) UIColor* rendererHorizontalGridLineColor ;
/**
 *  Thickness of the renderer horizontal grid lines.
 *  @default 1
 * [Style(name="rendererHorizontalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float rendererHorizontalGridLineThickness ;
/**
 *  Thickness of the renderer vertical grid lines.
 *  @default 1
 * [Style(name="rendererVerticalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float rendererVerticalGridLineThickness ;
/**
 *  Flag that indicates whether to force the top border, when horizontal gridlines are not drawn
 *  @default false
 * [Style(name="rendererDrawTopBorder", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL rendererDrawTopBorder ;
/**
 *  Flag that indicates whether to force the top border, when horizontal gridlines are not drawn
 *  @default false
 * [Style(name="headerDrawTopBorder", type="Boolean", inherit="no")]
 */
/**
 *  The color of the background for the row when the user selects
 *  an item renderer in the row.
 *
 *  The default value for the Halo theme is <code>0x7FCEFF</code>.
 *  The default value for the Spark theme is <code>0xA8C6EE</code>.
 * [Style(name="selectionColorFLXS", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray* selectionColorFLXS;

/**
 *  The class to use as the skin for the arrow that indicates the column sort
 *  direction.
 *  The default value for the Halo theme is <code>mx.skins.halo.DataGridSortArrow</code>.
 *  The default value for the Spark theme is <code>mx.skins.spark.DataGridSortArrow</code>.
 * [Style(name="sortArrowSkin", type="Class", inherit="no")]
 */

@property (nonatomic, strong) NSString * sortArrowSkin ;
/**
 *  Number of pixels between the control's left border
 *  and the left edge of its content area.
 *
 *  @default 1
 * [Style(name="paddingLeft", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float paddingLeft ;
/**
 *  Number of pixels between the control's right border
 *  and the right edge of its content area.
 *
 *  @default 0
 * [Style(name="paddingRight", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float paddingRight ;
/**
 *  Number of pixels between the control's left border
 *  and the left edge of its content area.
 *
 *  @default 2
 * [Style(name="paddingTop", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float paddingTop ;
/**
 *  Number of pixels between the control's right border
 *  and the right edge of its content area.
 *
 *  @default 2
 * [Style(name="paddingBottomFLXS", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float paddingBottomFLXS;
/**
 *  Number of pixels between the control's left border
 *  and the left edge of its content area.
 *
 *  @default 1
 * [Style(name="headerPaddingLeft", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float headerPaddingLeft ;
/**
 *  Number of pixels between the control's right border
 *  and the right edge of its content area.
 *
 *  @default 0
 * [Style(name="headerPaddingRight", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float headerPaddingRight ;
/**
 *  Number of pixels between the control's left border
 *  and the left edge of its content area.
 *
 *  @default 2
 * [Style(name="headerPaddingTop", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float headerPaddingTop ;
/**
 *  Number of pixels between the control's right border
 *  and the right edge of its content area.
 *
 *  @default 2
 * [Style(name="headerPaddingBottom", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float headerPaddingBottom ;
/**
 *  Number of pixels between the control's left border
 *  and the left edge of its content area.
 *
 *  @default 1
 * [Style(name="columnGroupPaddingLeft", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float columnGroupPaddingLeft ;
/**
 *  Number of pixels between the control's right border
 *  and the right edge of its content area.
 *
 *  @default 0
 * [Style(name="columnGroupPaddingRight", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float columnGroupPaddingRight ;
/**
 *  Number of pixels between the control's left border
 *  and the left edge of its content area.
 *
 *  @default 2
 * [Style(name="columnGroupPaddingTop", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float columnGroupPaddingTop ;
/**
 *  Number of pixels between the control's right border
 *  and the right edge of its content area.
 *
 *  @default 2
 * [Style(name="columnGroupPaddingBottom", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float columnGroupPaddingBottom ;

/**
 *  Number of pixels between the control's left border
 *  and the left edge of its content area.
 *
 *  @default 1
 * [Style(name="footerPaddingLeft", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float footerPaddingLeft ;
/**
 *  Number of pixels between the control's right border
 *  and the right edge of its content area.
 *
 *  @default 0
 * [Style(name="footerPaddingRight", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float footerPaddingRight ;
/**
 *  Number of pixels between the control's left border
 *  and the left edge of its content area.
 *
 *  @default 2
 * [Style(name="footerPaddingTop", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float footerPaddingTop ;
/**
 *  Number of pixels between the control's right border
 *  and the right edge of its content area.
 *
 *  @default 2
 * [Style(name="footerPaddingBottom", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float footerPaddingBottom ;
/**
 *  Number of pixels between the control's left border
 *  and the left edge of its content area.
 *
 *  @default 1
 * [Style(name="filterPaddingLeft", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float filterPaddingLeft ;
/**
 *  Number of pixels between the control's right border
 *  and the right edge of its content area.
 *
 *  @default 0
 * [Style(name="filterPaddingRight", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float filterPaddingRight ;
/**
 *  Number of pixels between the control's left border
 *  and the left edge of its content area.
 *
 *  @default 2
 * [Style(name="filterPaddingTop", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float filterPaddingTop ;
/**
 *  Number of pixels between the control's right border
 *  and the right edge of its content area.
 *
 *  @default 2
 * [Style(name="filterPaddingBottom", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float filterPaddingBottom ;
/**
 *  Number of pixels between the control's left border
 *  and the left edge of its content area.
 *
 *  @default 1
 * [Style(name="pagerPaddingLeft", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float pagerPaddingLeft ;
/**
 *  Number of pixels between the control's right border
 *  and the right edge of its content area.
 *
 *  @default 0
 * [Style(name="pagerPaddingRight", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float pagerPaddingRight ;
/**
 *  Number of pixels between the control's left border
 *  and the left edge of its content area.
 *
 *  @default 2
 * [Style(name="pagerPaddingTop", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float pagerPaddingTop ;
/**
 *  Number of pixels between the control's right border
 *  and the right edge of its content area.
 *
 *  @default 2
 * [Style(name="pagerPaddingBottom", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float pagerPaddingBottom ;
/**
 *  Number of pixels between the control's left border
 *  and the left edge of its content area.
 *
 *  @default 1
 * [Style(name="rendererPaddingLeft", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float rendererPaddingLeft ;
/**
 *  Number of pixels between the control's right border
 *  and the right edge of its content area.
 *
 *  @default 0
 * [Style(name="rendererPaddingRight", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float rendererPaddingRight ;
/**
 *  Number of pixels between the control's left border
 *  and the left edge of its content area.
 *
 *  @default 2
 * [Style(name="rendererPaddingTop", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float rendererPaddingTop ;
/**
 *  Number of pixels between the control's right border
 *  and the right edge of its content area.
 *
 *  @default 2
 * [Style(name="rendererPaddingBottom", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float rendererPaddingBottom ;
/**
 *  The colors to use for the backgrounds of the items in the grid.
 *  The value is an array of two or more colors.
 *  The backgrounds of the list items alternate among the colors in the array.
 *  @default undefined
 * [Style(name="alternatingItemColors", type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray * alternatingItemColors ;
/**
 *  The colors to use for the text of the items in the grid.
 *  The value is an array of two colors.
 *  The text color of the list items alternate among the colors in the array.
 *  @default [ #000000, #000000]
 * [Style(name="alternatingTextColors", type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray * alternatingTextColors ;
/**
 *  The colors to use for the backgrounds of the items in the grid in the editable mode.
 *  The value is an array two colors.
 *  @default undefined
 * [Style(name="editItemColor", type="Array", arrayType="uint", format="Color")]
 */

@property (nonatomic, strong) NSArray * editItemColors ;
/**
 *  The colors to use for the text of the items in the editable grid.
 * [Style(name="editTextColor", format="Color")]
 */

@property (nonatomic, strong) UIColor * editTextColor ;

/**
 *  The color of the background of a renderer when the component is disabled.
 *  @default null
 * [Style(name="selectionDisabledColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor*  selectionDisabledColor ;
/**
 *  The icon that is displayed next to an open branch node of the navigation tree.
 *  The default value is <code>TreeDisclosureOpen</code> in the assets.swf file.
 * [Style(name="disclosureOpenIcon", type="Class", format="EmbeddedFile", inherit="no")]
 */

@property (nonatomic, strong) NSString * disclosureOpenIcon ;
/**
 *  The icon that is displayed next to a closed branch node of the navigation tree.
 *
 *  The default value is <code>TreeDisclosureClosed</code> in the assets.swf file.
 * [Style(name="disclosureClosedIcon", type="Class", format="EmbeddedFile", inherit="no")]
 */

@property (nonatomic, strong) NSString * disclosureClosedIcon ;
/**
 *  The icon that is displayed next to an open column group.
 *
 *  The default value is <code>TreeDisclosureOpen</code> in the assets.swf file.
 * [Style(name="columnGroupOpenIcon", type="Class", format="EmbeddedFile", inherit="no")]
 */

@property (nonatomic, strong) NSString * columnGroupOpenIcon ;
/**
 *  The icon that is displayed next to a closed column group.
 *
 *  The default value is <code>TreeDisclosureClosed</code> in the assets.swf file.
 * [Style(name="columnGroupClosedIcon", type="Class", format="EmbeddedFile", inherit="no")]
 */

@property (nonatomic, strong) NSString * columnGroupClosedIcon ;
/**
 *  The color of the row background when the user rolls over the row.
 *
 *  The default value for the Halo theme is <code>0xB2E1FF</code>.
 *  The default value for the Spark theme is <code>0xCEDBEF</code>.
 * [Style(name="rollOverColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic,strong) UIColor* rollOverColor ;
/**
 *  The color of the cell directly under the mouse or if using keyboard navigation, current keyboard seed.
 * @default #000000
 * [Style(name="activeCellColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* activeCellColor ;
/**
 *  An array of two colors used to draw the footer background gradient.
 *  The first color is the top color.
 *  The second color is the bottom color.
 *  @default [0xCFCFCF, 0xCCCCCC]
 * [Style(name="footerColors", type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray * footerColors ;
/**
 *  The color of the row background when the user rolls over the footer.
 *  The default value is [0xCCCCCC,0xCFCFCF]
 * [Style(name="footerRollOverColors",  type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray * footerRollOverColors ;
/**
 *  The color of the row background for the filter.
 *  The default value is [0xCFCFCF,0xCFCFCF]
 * [Style(name="filterColors",  type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray * filterColors ;
/**
 *  The color of the row background when the user rolls over the filter.
 *  The default value is [0xCFCFCF,0xCFCFCF]
 * [Style(name="filterRollOverColors",  type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray * filterRollOverColors ;
/**
 *  An array of two colors used to draw the header background gradient.
 *  The first color is the top color.
 *  The second color is the bottom color.
 *  @default [0xFFFFFF, 0xE6E6E6]
 * [Style(name="headerColors", type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray * headerColors ;
/**
 *  The color of the row background when the user rolls over the header.
 *
 *  The default value is [0xE6E6E6,0xFFFFFF]
 * [Style(name="headerRollOverColors",  type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray * headerRollOverColors ;
/**
 *  An array of two colors used to draw the Column Groups background gradient.
 *  The first color is the top color.
 *  The second color is the bottom color.
 *  @default [0xFFFFFF, 0xE6E6E6]
 * [Style(name="columnGroupColors", type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray * columnGroupColors ;
/**
 *  The color of the row background when the user rolls over the Column Groups.
 *
 *  The default value is [0xE6E6E6,0xFFFFFF]
 * [Style(name="columnGroupRollOverColors",  type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray * columnGroupRollOverColors ;
/**
 *  An array of two colors used to draw the renderer background gradient.
 *  The first color is the top color.
 *  The second color is the bottom color.
 *  @default [0xFFFFFF, 0xFFFFFF]
 * [Style(name="rendererColors", type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray * rendererColors ;
/**
 *  The color of the row background when the user rolls over a level renderer.
 *  The default value is [0xFFFFFF,0xFFFFFF]
 * * [Style(name="rendererRollOverColors", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic,strong) NSArray* rendererRollOverColors ;
/**
 *  An array of two colors used to draw the pager background gradient.
 *  The first color is the top color.
 *  The second color is the bottom color.
 *  @default [0xCCCCCC, 0xCCCCCC]
 * [Style(name="pagerColors", type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray * pagerColors ;
/**
 *  The color of the row background when the user rolls over the pager.
 *  The default value is [0xE6E6E6,0xFFFFFF]
 * [Style(name="pagerRollOverColors",type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray * pagerRollOverColors ;
/**
 *  Color of the text when the user selects a row.
 *  @default 0x000000
 * [Style(name="textSelectedColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* textSelectedColor ;
/**
 *  Color of the text when the user rolls over a row.
 *
 *  @default 0x000000
 * [Style(name="textRollOverColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* textRollOverColor ;
/**
 *  The color of the text of a renderer when the component is disabled.
 *  @default 0xDDDDDD
 * [Style(name="textDisabledColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* textDisabledColor ;

/**
 *  The width of the vertical seperators for the locked content.
 * @default 1
 * [Style(name="lockedSeparatorThickness", type="Number", inherit="yes")]
 */

@property (nonatomic, assign) float lockedSeparatorThickness;
/**
 *  The color of the vertical separators for the locked content.
 * @default #000000
 * [Style(name="lockedSeparatorColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor*lockedSeparatorColor;
/**
 * The background color of the row that has the error .
 * @default #FCDCDF
 * [Style(name="errorBackgroundColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* errorBackgroundColor ;
/**
 * The border color of the cell that has the error .
 * @default #F23E2C
 * [Style(name="errorBorderColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* errorBorderColor ;
/**
 *  Alpha for the drag operation.
 *  @default 0.8
 * [Style(name="dragAlpha", type="Number")]
 */

@property (nonatomic, assign) float dragAlpha ;
/**
 *  Border for the drag row for the drag operation.
 *  @default 0.8
 * [Style(name="dragRowBorderStyle", type="String")]
 */

@property (nonatomic, strong) NSString * dragRowBorderStyle ;

/**
 * A box to cover the space left behind by the horizontal scrollbar when horizontalScrollPolicy=on and there are left locked columns
 * [Style(name="fixedColumnFillColors", type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray * fixedColumnFillColors ;

/**
 * The color of the line to draw when the user is moving or resizing the column
 * [Style(name="columnMoveResizeSeparatorColor", format="Color")]
 */

@property (nonatomic, strong) UIColor * columnMoveResizeSeparatorColor ;
/**
 * The color of the line between header and the sort section for multi column sort
 * [Style(name="headerSortSeparatorColor", format="Color")]
 */

@property (nonatomic, strong) UIColor * headerSortSeparatorColor ;
/**
 * The distance between the sort line and the right edge of the header cell
 * [Style(name="headerSortSeparatorRight", format="int")]
 */

@property (nonatomic, assign) int headerSortSeparatorRight ;
/**
 * The alpha to apply to the glyph when moving the column.
 * @deprecated    Starting in 2.9 we no longer draw a glyph, we simply draw a line. This is to add support
 * for dropping column on both sides of the target cell.
 * [Style(name="columnMoveAlpha")]
 */

@property (nonatomic, assign) float columnMoveAlpha ;

@property (nonatomic, strong) NSString* fontName ;
@property (nonatomic, assign) float fontSize ;

/**
 * Returns showSpinnerOnFilterPageSort
 */		
@property (nonatomic, assign) BOOL showSpinnerOnCreationComplete;
/**
 Export type like html, Excel, word, etc
 */
@property (nonatomic, strong) NSArray *exportTypeList;

-(void)clearPreferences;

- (void)persistPreferences:(NSString *)name isDefault:(BOOL)isDefault;
-(void)loadPreferences;
-(void)applyPreferences:(NSMutableArray*)arrayCollection;
-(FLXSUserSettingsOptions*)defaultUseSettingsOptionsFunction;

/**
 * The container for the left locked filter and header cells. 
 * This is an instance of the LockedContent class, which basically is an extended 
 * UIComponent that manages the filter and footer cell visiblity, heights, and the y positions.
 * 
 * To access all the filter/header cells, please use the rows collection of the headerContainer
 * or filterContainer. This contains a single RowInfo object, which contains a cells collection.
 * The cells collection contains ComponentInfo objects, that has a component property, which is
 * an instance of one of the subclasses of FlexDataGridCell. The cell will have a renderer property
 * which is the actual UI control that is being displayed.
 */
-(FLXSLockedContent*)leftLockedHeader;
/**
 * The container for the left locked data cells. This is an instance of the ElasticContainer class, 
 * which basically attaches to the owner component (which is the bodyContainer) and scrolls vertically along with it. 
 * The horizontal scroll of this component is set to off) 
 * 
 * To access all the data cells, please use the rows collection of the bodyContainer
 * This contains RowInfo objects, which contains a cells collection.
 * The cells collection contains ComponentInfo objects, that has a component property, which is
 * an instance of one of the subclasses of FlexDataGridCell. The cell will have a renderer property
 * which is the actual UI control that is being displayed.
 */
-(FLXSElasticContainer*)leftLockedContent;
/**
 * The container for the left locked footer cells. 
 * This is an instance of the LockedContent class, which basically is an extended 
 * UIComponent that manages the filter and footer cell visiblity, heights, and the y positions.
 * 
 * To access all the footer cells, please use the rows collection of the footerContainer
 * This contains a single RowInfo object, which contains a cells collection.
 * The cells collection contains ComponentInfo objects, that has a component property, which is
 * an instance of one of the subclasses of FlexDataGridCell. The cell will have a renderer property
 * which is the actual UI control that is being displayed.
 */
-(FLXSLockedContent*)leftLockedFooter;
/**
 *The container for the right locked filter and header cells. 
 * This is an instance of the LockedContent class, which basically is an extended 
 * UIComponent that manages the filter and footer cell visiblity, heights, and the y positions.
 * 
 * To access all the filter/header cells, please use the rows collection of the headerContainer
 * or filterContainer. This contains a single RowInfo object, which contains a cells collection.
 * The cells collection contains ComponentInfo objects, that has a component property, which is
 * an instance of one of the subclasses of FlexDataGridCell. The cell will have a renderer property
 * which is the actual UI control that is being displayed.
 */
-(FLXSLockedContent*)rightLockedHeader;
/**
 * The container for the right locked data cells. This is an instance of the ElasticContainer class, 
 * which basically attaches to the owner component (which is the bodyContainer) and scrolls vertically along with it. 
 * The horizontal scroll of this component is set to off) 
 * 
 * To access all the data cells, please use the rows collection of the bodyContainer
 * This contains RowInfo objects, which contains a cells collection.
 * The cells collection contains ComponentInfo objects, that has a component property, which is
 * an instance of one of the subclasses of FlexDataGridCell. The cell will have a renderer property
 * which is the actual UI control that is being displayed.
 */
-(FLXSElasticContainer*)rightLockedContent;
/**
 * The container for the right locked footer cells. 
 * This is an instance of the LockedContent class, which basically is an extended 
 * UIComponent that manages the filter and footer cell visiblity, heights, and the y positions.
 * 
 * To access all the footer cells, please use the rows collection of the footerContainer. 
 * This contains a single RowInfo object, which contains a cells collection.
 * The cells collection contains ComponentInfo objects, that has a component property, which is
 * an instance of one of the subclasses of FlexDataGridCell. The cell will have a renderer property
 * which is the actual UI control that is being displayed.
 */
-(FLXSLockedContent*)rightLockedFooter;
/**
 * The main scrollable area of the grid. This is an instance of the FlexDataGridBodyContainer class, which
 * derives from FlexDataGridContainerBase. The Body container manages renderer recycling, scrolling, expand
 * collapse, editing, etc. The bodyContainer contains a rows collection, which is a visual representation of 
 * the current ViewPort, that is, it shows the currently visible cells based on the vertical and horizontal
 * scroll postions. You can iterate through the currently visible cells via looping through the rows property
 * and going through the cells collection of each RowInfo. Please note, this will only get you the currently
 * visible cells. If you wish to access each cell as it is being initialized (or revived from a recyclable state)
 * please wire up the rendererInitialized event on the grid.
 */
-(FLXSFlexDataGridBodyContainer*)bodyContainer;
/**
 * @copy bodyContainer
 * Specialized getter when enableVirtualScroll=true
 */	
-(FLXSFlexDataGridVirtualBodyContainer*)virtualBodyContainer;
/**
 * The container for the header cells. This is an instance of the FlexDataGridHeaderContainer class.
 * This class manages cell initialization, recycling, mouse events on each cell, etc. The rows collection
 * of this object will aways contain a single RowInfo object, which has a cells collection. This will
 * be a series of ComponentInfo objects, which has a component property that will be an instance of FlexDataGridHeaderCell
 * Although the parent property of each of the cells could be either the 
 * leftLockedHeader, rightLockedHeader or the headerContainer, the rowInfo is the same, so the cells will
 * include left, right, and unlocked cells.
 */
-(FLXSFlexDataGridHeaderContainer*)headerContainer;
/**
 * The container for the filter cells. This is an instance of the FlexDataGridHeaderContainer class.
 * This class manages cell initialization, recycling, mouse events on each cell, etc. The rows collection
 * of this object will aways contain a single RowInfo object, which has a cells collection. This will
 * be a series of ComponentInfo objects, which has a component property that will be an instance of FlexDataGridFilterCell
 * Although the parent property of each of the cells could be either the 
 * leftLockedHeader, rightLockedHeader or the filterContainer, the rowInfo is the same, so the cells will
 * include left, right, and unlocked cells.
 */
-(FLXSFlexDataGridHeaderContainer*)filterContainer;
/**
 * The container for the footer cells. This is an instance of the FlexDataGridHeaderContainer class.
 * This class manages cell initialization, recycling, mouse events on each cell, etc. The rows collection
 * of this object will aways contain a single RowInfo object, which has a cells collection. This will
 * be a series of ComponentInfo objects, which has a component property that will be an instance of FlexDataGridFooterCell
 * Although the parent property of each of the cells could be either the 
 * leftLockedFooter, rightLockedFooteror the footerContainer, the rowInfo is the same, so the cells will
 * include left, right, and unlocked cells.
 */
-(FLXSFlexDataGridHeaderContainer*)footerContainer;
/**
 * The container for the pager cells. This is an instance of the FlexDataGridHeaderContainer class.
 * This will contain a rows collection, which will contain a single RowInfo object. The Single RowInfo
 * object has a cells Collection that will contain a single FlexDataGridPagerCell. The actual IPager
 * is the renderer property of the FlexDataGridPagerCell.
 */
-(FLXSFlexDataGridHeaderContainer*)pagerContainer;
/**
 * @private 
 */		
-(BOOL)verticalSpill;
/**
 * Method to create an instance of the FlexDataGridBodyContainer class. 
 * In case you need to implement custom logic by extending the FlexDataGridBodyContainer you will need to override this method.
 * Creates an instance of FlexDataGridVirtualBodyContainer if enableVirtualScroll, else creates FlexDataGridBodyContainer
 */	
-(FLXSFlexDataGridBodyContainer*)createBodyContainer;
/**
 * Method to create an instance of the FlexDataGridHeaderContainer class. 
 * In case you need to implement custom logic by extending the FlexDataGridHeaderContainer you will need to override this method.
 */	
-(FLXSFlexDataGridHeaderContainer*)createChromeContainer;
/**
 * Method to create an instance of the LockedContent class. 
 * In case you need to implement custom logic by extending the LockedContent you will need to override this method.
 * The Left Locked Header, Left Locked Footer,Right Locked Header, and Right Locked Footer are all instance of LockedContent
 */	
-(FLXSLockedContent*)createLockedContent;
/**
 * Method to create an instance of the ElasticContainer class. 
 * In case you need to implement custom logic by extending the ElasticContainer you will need to override this method.
 * The Left Locked Content, and Right Locked Content are instances of ElasticContainer
 */	
-(FLXSElasticContainer*)createElasticContainer;
//
///**
// *  @private
// *  Measures the DataGrid based on its contents,
// *  summing the total of the visible column widths.
// */
//-(void)measure;
//
//- (void)updateDisplayList:(float)unscaledWidth unscaledHeight:(float)unscaledHeight;
/**
 * Called when you scroll and expand collapse. When you do this, previously drawn rows  
 * may have been drawn with a different horizontal scroll position. So the cells that are 
 * currently in view may not have been drawn. This method will ensure that a pass at the
 * horizontal recycle runs at the next update and we render the correct cells. 
 */		
-(void)invalidateHorizontalScroll;
/**
 * When you have left or right locked sections, the scroll bar only covers the area occupied by the body container, 
 * or the unlocked columns section. So we do not show a blank whitespace in the area of the scroll bar in the locked
 * sections, we place two sprites there, and this method is responsible for drawing and positioning these sprites.
 */	
-(void)placeBottomBar;

- (void)ensureLevelsCreated:(NSArray *)item level:(FLXSFlexDataGridColumnLevel *)level;
-(void)onCreationComplete:(FLXSEvent*)event;
-(void)keyUpOrDown:(int)keyCode;
/**
 * Returns true if the top column level filterPageSortMode is client. 
 * @return 
 * 
 */	
-(BOOL)isClientFilterPageSortMode;
-(void)checkNoDataMessage:(BOOL)force;
/**
 * Clears out the following collections 
 * <ul>
 * <li>All Open Items</li>
 * <li>All Errors</li>
 * <li>Selection (only if clearSelectionOnDataProviderChange==true)</li>
 * <li>Some internal housekeeping collections</li>
 * </ul>
 */	
-(void)clearAllCollections;
/**
 * Sets changes to an empty array.
 */	
-(void)clearChanges;
/**
 * By default, when you set the dataprovider, we add a change event listener to it.
 * When you reset the collection, this method will clear out the selection, and check for no data, and issue a rebuild.
 * When you add an item to the data provider, it will call the trackChange method (see enableChangeTracking) and issue a rebuild.
 * When you remove an item from the data provider, it will call the trackChange method (see enableChangeTracking) and issue a rebuild,
 * and if the item is checked, remove it from the selection.
 * Finally, it will dispatct a dataProviderChange event.
 * 
 * Keep in mind, the rebuildGridOnDataProviderChange is not taken into account if you reset the dataprovider. That flag is only
 * applied if you explicitly replace the dataprovider using grid.dataProviderFLXS = newDataProvider;
 */	
-(void)onCollectionChange:(FLXSEvent*)event;
/**
 * The grid is composed of the following sections:
 * 
 * Left Locked Header <br/>
 * Left Locked Content <br/>
 * Left Locked Footer <br/>
 * Right Locked Header <br/> 
 * Right Locked Content <br/> 
 * Right Locked Footer <br/> 
 * UnLocked Header <br/> 
 * UnLocked Content <br/> 
 * UnLocked Footer <br/>
 * 
 * On basis of the column lock modes specified, this method will
 * size each section and place them in the correct location. 
 */	
-(void)placeSections;
-(float)getFilterX:(UIView <FLXSIFilterControl>*)renderer;
/**
 * For some operations, like shift tab and tab key up, purposely pause the Container keyboard listenters, 
 * so we do not overwrite the work of one keyboard handler by triggering another.
 */	
-(void)pauseKeyboardListeners:(NSObject*)filterRenderer;
/**
 * Given a IFlexDataGridCell, returns a container that holds that cell.  
 * @param cell The IFlexDataGridCell object to get the container for. 
 * @return The container that holds the provided cell. Can be either one of the below:
 * <ul>
 * <li>headerContainer</li>
 * <li>filterContainer</li>
 * <li>footerContainer</li>
 * <li>pagerContainer</li>
 * <li>bodyContainer</li>
 * </ul>
 */	
-(FLXSFlexDataGridContainerBase*)getContainerForCell:(UIView<FLXSIFlexDataGridCell>*)cell;

/**
 * Returns the section above or below the provided section. Based on the displayOrder property,
 * the grid will stack the various sections in order specified by the user. This method uses
 * the displayOrder property to figure out which container exists above or below the specified 
 * section.
 * @param name	Name of the section. Must be one of the displayOrder strings (filter,header,body,footer,pager).
 * @param up	Whether to return the section above or below
 * @return A FlexDataGridContainerBase object
 */
- (FLXSFlexDataGridContainerBase *)getContainerInDirection:(NSString *)container up:(BOOL)up;
/**
 * Given a container, returns its displayOrder string equivalent. Based on the displayOrder property,
 * the grid will stack the various sections in order specified by the user. This method uses
 * the takes a container and returns the associated displayOrder property.
 * Container Should be one of the following: 
 * <ul>
 * <li>headerContainer</li>
 * <li>filterContainer</li>
 * <li>footerContainer</li>
 * <li>pagerContainer</li>
 * <li>bodyContainer</li>
 * </ul>
 * Will return one of the following:
 * <ul>
 * <li>header</li>
 * <li>filter</li>
 * <li>footer</li>
 * <li>pager</li>
 * <li>body</li>
 * </ul>
 * @param container	The container to look for. 
 */	
-(NSString*)getContainerName:(FLXSFlexDataGridContainerBase*)container;
/**
 * Given a displayOrder string , returns its container equivalent. Based on the displayOrder property,
 * the grid will stack the various sections in order specified by the user. This method uses
 * the takes a displayOrder string and returns the associated container.
 * Display Order String Should be one of the following: 
 * <ul>
 * <li>header</li>
 * <li>filter</li>
 * <li>footer</li>
 * <li>pager</li>
 * <li>body</li>
 * </ul>
 * Will return one of the following:
 * <ul>
 * <li>headerContainer</li>
 * <li>filterContainer</li>
 * <li>footerContainer</li>
 * <li>pagerContainer</li>
 * <li>bodyContainer</li>
 * </ul>
 */
-(FLXSFlexDataGridContainerBase*)getNamedContainer:(NSString*)name;

/**
 * @private
 */
- (float)placeSectionByName:(NSString *)name thisY:(float)thisY;
/**
 * Goes through all the sections and resizes the cells to match the current column widths.
 * If you update the column widths programatically, call this to resize the currently visible cells. 
 */		
-(void)snapToColumnWidths;
/**
 * @private
 */		
-(void)createComponents:(int)currentScroll;

/**
 * Iterates through the passed in cols, calls itemToLabel on each of them
 * passing in the item, and return the resulting string in tab delimited format.
 * Converts an objects properties into tab delimited format
 * @param event
 */
- (NSString *)getRowText:(NSObject *)item columns:(NSArray *)cols;
/**
 * @private 
 */	
-(void)onRootFilterChange:(NSNotification*)ns;
/**
 * Processes filters at the root level. 
 * 1) Ensures the root filter exists<br/>
 * 2) In filterPageSortMode="client", invalidates the row position info objects, so they are rebuilt<br/>
 * 3) In filterPageSortMode="client", Calls the create components method on each of the container sections.<br/>
 * 4) In Server mode, gathers the filter information, and dispatches a filterPageSortChange event, for the client code to listen to.<br/>
 */	
-(void)processFilter;
/**
 * @private
 */	
-(void)processRootFilter:(FLXSFilterPageSortChangeEvent*)triggerEvent;
/**
 * @private
 * @param event
 */	
-(void)onRootPageChange:(FLXSExtendedFilterPageSortChangeEvent*)event;

/**
 * @private 
 */
- (void)showHideVScroll:(BOOL)show scrollBarWidth:(int)scrollBarWidth;

/**
 * @private 
 */
- (void)showHideHScroll:(BOOL)show scrollBarHeight:(int)scrollBarHeight;
/**
 * A Class that is responsible for the multi column sort view. Defaults to MultiColumnSortRenderer. You 
 * can provide your own implementation by specifying a custom MultiColumnSortRenderer. 
 */
-(FLXSClassFactory*)multiSortRenderer;
/**
 * A Class that is responsible for the multi column sort view. Defaults to MultiColumnSortRenderer. You 
 * can provide your own implementation by specifying a custom MultiColumnSortRenderer. 
 */
//-(void)multiSortRenderer:(FLXSClassFactory*)value;
/**
 * Gets the text of the tooltip to show to the user to prompt for the multi column sort.
 */	
-(NSString*)multiColumnSortGetTooltip:(FLXSFlexDataGridHeaderCell*)cell;
/**
 * Creates an instance of the multiSortRenderer and pushes it into view
 */	
-(void)multiColumnSortShowPopup;
/**
 * Returns the sum of: <br/>
 * If enableFilters, then filterRowHeight else 0 plus<br/>
 * headerHeight
 * @return 
 */	
-(float)headerSectionHeight;
/**
 * Updates the visible state of all row selection checkboxes and header checkboxes. 
 */		
-(void)refreshCheckBoxes;
/**
 * Calls the refresh cell method on all visible cells in the bodyContainer section. <br/>
 * The refreshCell method re-evaulates the following properties:<br/>
 * <ul>
 * <li> Cell Text </li>
 * <li> Cell Enabled </li>
 * <li> Cell data </li>
 * <li> Various style properties like text decoration, underline </li>
 * <li> Sets the width, and places the renderer appropriately. </li>
 * <li> Dispatches the renderer intialized event. </li>
 * </ul>
 * If you wish to re evaluate the background/border, use the invalidate cells instead.
 */
-(void)refreshCells;
/**
 * @private 
 */	
-(void)onColumnResized:(FLXSEvent*)event;
/**
 * @private 
 */	
-(void)onSelectAllChanged:(FLXSFlexDataGridEvent*)event;
/**
 * @private 
 */	
-(void)onSelectChanged:(FLXSFlexDataGridEvent*)event;
/**
 * @private 
 */	
-(BOOL)isScrolling;
/**
 * @private 
 */	
-(void)recycleH:(BOOL)right;

/**
 * In lazy loaded grid levels, (filterPageSortMode=server), when 
 * the user expands a level for the first time, since the data 
 * is not loaded, the level dispatches the filterPageSortChange, or itemLoad.
 * 
 * This event is then handled by client code, and when the data
 * is retreieved from the server, this method should be called
 * with the item being expanded, and children to insert.
 * 
 * @param item 		The item that is being expanded. You can pass in an ID value if you set useSelectedKeyField=true (default)
 * @param children 	The list of items to add to the children collection of the item being expanded
 * @param totalRecords Total number of child records. Only applicable if the filterPageSortMode for the child level is server. Use this parameter to tell the level that you are showing the first page of totalRecords records 
 * @param level	The parent level (the level at which the item object is located). 
 * @param useSelectedKeyField	Flag to indicate whether to use the selectedKeyField to identify the item being expanded, or 
 * to compare against the item directly against the list of items pending expansion.
 */
- (void)setChildData:(NSObject *)item children:(NSArray *)children level:(FLXSFlexDataGridColumnLevel *)level totalRecords:(int)totalRecords useSelectedKeyField:(BOOL)useSelectedKeyField;
/**
 * Invalidates the display (Calls invalidateDisplayList of all the cells). 
 * This will re-evaluate the backgroud and borders of each cell.
 * There are four functions that you can use to redraw the grid, on basis of what your needs are.
 * <ul>
 * <li>rebuild : Most expensive. Rebuilds the entire grid. This is also the most expensive function</li>
 * <li>reDraw  : Removes the cells in view, and redraws them. Should be used when there are no additions/removals to the data provider</li>
 * <li>refreshCells : Resets the text,enabled, styles and border/background etc. of the currently visible cells. See the refreshCells() function for details.</li>
 * <li>invalidateCells : Least expensive. Only resets the border/background of the currently visible cells. </li>
 * </ul>
 * */
-(void)invalidateCells;
/**
 * Calls the rebuild function, which basically rebuild the entire grid. This is also the most expensive functions.
 * There are four functions that you can use to redraw the grid, on basis of what your needs are.
 * <ul>
 * <li>rebuild : Most expensive. Rebuilds the entire grid. This is also the most expensive function</li>
 * <li>reDraw  : Removes the cells in view, and redraws them. Should be used when there are no additions/removals to the data provider</li>
 * <li>refreshCells : Resets the text,enabled, styles and border/background etc. of the currently visible cells. See the refreshCells() function for details.</li>
 * <li>invalidateCells : Least expensive. Only resets the border/background of the currently visible cells. </li>
 * </ul>
 */	
-(void)invalidateList;
/**
 * Clears the checked rows and cells.
 */	
-(void)clearSelection;

/**
 * Gets the cell in the specified direction of the provided cell 
 * @param cell		The cell to start searching at.
 * @param direction	The direction to search. Should be one of FlexDataGrid.CELL_POSITION_XXXX constants
 * @return The cell, if one matches the provided criteria, or null
 */
- (UIView <FLXSIFlexDataGridCell> *)getCellInDirection:(UIView <FLXSIFlexDataGridCell> *)cell direction:(NSString *)direction;
/**
 * Returns a iterable representation of the dataprovider. If it is a hierarchical collection
 * view, returns the source property of the underlying Hierarchical Data object else returns dataprovider as is.
 */	
-(NSArray*)getRootFlat;

/**
 * For hierarchical data grids, returns the data provider as a flat list that matches the 
 * specified criteria.
 * 
 * @param depthRequested	The depth until which to recurse.
 * @param inclusive			Whether to add the parent object to the resulting 
 * @param filter			Whether to run filter while getting children of parent objects
 * @param page				Whether to page while getting children of parent objects
 * @param sort				Whether to sort while getting children of parent objects	
 * @param max				The maximum number of records to return
 * @param dic				
 * @return 
 */
- (NSArray *)flatten:(int)depthRequested inclusive:(BOOL)inclusive filter:(BOOL)filter page:(BOOL)page sort:(BOOL)sort max:(float)max;
/**
 * When the dataprovider changes or when new data comes in from the server for lazy loaded grids, you can call this to clear out the flattened cache. 
 * 
 */	
-(void)clearFlattenedCache;

/**
 * @private 
 */
+ (void)flattenRecursive:(int)depthRequested result:(NSMutableArray *)result parent:(NSObject *)parent level:(FLXSFlexDataGridColumnLevel *)level inclusive:(BOOL)inclusive filter:(BOOL)filter page:(BOOL)page sort:(BOOL)sort;

/**
 * On basis of the highLight flag, removes or adds highlight to the row in question. Triggered in response
 * to a rollover event.
 * 
 * Sets the currentBackgroundColors property is a result of the following logic.
 * When highLight=true
 * <ul>
 * <li>If enableActiveCellHighlight=true uses the value of the activeCellColor style.</li>
 * <li>Else, uses the value of the rollOverColor style property.</li>
 * </ul>
 * When highLight=false, sets it to null.
 * <br/>
 * Sets the currentTextColors property is a result of the following logic.
 * <ul>
 * <li>When highLight=true, sets it to value of the textRollOverColor property</li>
 * <li>When highLight=false, sets it to null.</li>
 * </ul>
 * 
 * @param cell	The IFlexDataGridCell to highligh or remove the highlight from
 * @param row	The rowInfo object associated with this cell.
 * @param highLight	Whether to add a highlight or remove the highlight
 * @param highLightColor	If you want to override the color that is calculated using the logic above.
 */
- (void)highlightRow:(UIView <FLXSIFlexDataGridCell> *)cell row:(FLXSRowInfo *)row highLight:(BOOL)highLight highLightColor:(id)highLightColor;
//next version  v1.2
//-(void)dragComplete:(UIView<FLXSIFlexDataGridCell>*)cell;
//-(void)dragBegin:(MouseEvent*)event;
//-(void)dragEnterInternal:(DragEvent*)event;
//-(void)dragDropInternal:(DragEvent*)event;
//-(void)dragEnter:(DragEvent*)event;
//-(void)dragAcceptReject:(UIView<FLXSIFlexDataGridCell>*)cell;
//-(void)dragDrop:(DragEvent*)event;
/**
 * Scrolls to the row that appears at the specified vertical position 
 * @param vsp			Vertical Position to Scroll to
 * @param scrollDown 	Whether you are scrolling up or down
 * 
 */
- (void)scrollToExistingRow:(float)vsp scrollDown:(BOOL)scrollDown;

/**
 * Given a data object and a colum, return the IFlexDataGridDataCell object for the combination 
 * @param data		The row data
 * @param column 	The FlexDataGridColumn
 */
- (UIView <FLXSIFlexDataGridDataCell> *)getCellForRowColumn:(NSObject *)data column:(FLXSFlexDataGridColumn *)column;
/**
 * Called to show the drop indicator below the passed in cells row. IF you
 * wish to see custom drop signs, override this function.
 */	
-(void)showDropIndicator:(UIView<FLXSIFlexDataGridCell>*)cell;
/**
 * Generates a snapshot of the row for the drag visual indicator
 * @param cell
 * @return 
 */	
-(UIImage*)generateImageForDrag:(UIView<FLXSIFlexDataGridCell>*)cell;
/**
 * @private 
 */
-(void)invalidateSelection;
/**
 * @private 
 */
-(void)placeComponents:(FLXSRowInfo*)row;
/**
 * @private 
 */
-(void)placeChildComponents:(NSArray*)components;
/**
 * Corner areas are special containers that exist to hold filter and header on the top
 * and Pager and Footer on the bottom
 * If I am filter cell, return 0 if filter is above header (true always)
 * IF I am header cell, return filterHeight + (headerHeight * header Depth)
 * If I am footer cell, return 0
 * If I am pager cell, return pager footer height
 */	
-(float)getCornerY:(FLXSComponentInfo*)comp;
/**
 * @private 
 */
-(void)placeComponent:(FLXSComponentInfo*)comp;
/**
 * @private 
 */
-(void)addComponent:(UIView*)component;
/**
 * @private 
 */
-(void)drawDefaultSeparators;
/**
 * Goes to the specified horizontal position. Going to a specified horizontal
 * scroll position requires the renderers to recycle if the set of visible
 * columns changes. 
 */		
-(void)gotoHorizontalPosition:(float)vsp;
/**
 * Goes to the specified vertical position. Going to a specified horizontal
 * scroll position requires the renderers to recycle if the set of visible
 * rows changes. 
 */	
-(void)gotoVerticalPosition:(float)vsp;
/**
 * Returns the list of columns groups at the root level. 
 * The grid always has at least one column level. This is also referred to as the top level, or the root level. 
 * In flat grids (non hierarchical), this is the only level. But in nested grids, you could have any number of nested levels. 
 * The column groups collection actually belongs to the columnLevel, and since there is one root level, 
 * the column groups collection of the grid basically points to the column groups collection of this root level.
 */	
-(NSArray*)columnGroups;
/**
 *Returns the columns where visible=true
 */	
-(NSArray*)visibleColumns;
/**
 *Returns the columns where excludeFromExport=false
 */
-(NSArray*)exportableColumns;
/**
 * Returns all columns at all levels. 
 * @return 
 * 
 */	
-(NSArray*)getExportableColumns:(FLXSExportOptions*)exportOptions;
/**
 *Returns the columns where excludeFromExport=false
 */
-(NSArray*)sortableColumns;
/**
 * Return the FilterSort objects at the top level
 */		
-(NSMutableArray*)currentSorts;
/**
 * Removes all the sorts and calls doInvalidate. 
 * 
 */	
-(void)removeAllSorts;
/**
 * Returns the columns where excludeFromSettings=false
 */
-(NSArray*)settingsColumns;
/**
* @private 
* A interface so we can write code that targets
* both grids without having to explicitly work
* against their concrete types
*/
-(NSArray*)getPrintableColumns:(FLXSPrintOptions*)options;
/**
 * Returns the columns where excludeFromPrint=false
 */
-(NSArray*)printableColumns;
/**
 * Returns the number of rows currently visible.
 */	
-(int)rowCount;
/**
 * Returns the TOP level data without any filters.
 */
-(NSObject*)dataProviderNoFilters;
/**
 * Returns the TOP level data without any paging, but with filters.
 */
-(NSObject*)dataProviderNoPaging;
/**
 * The Filter/Page/Sort Mode. Can be either "server" or "client".
 * In client mode, the grid will take care of paging, sorting and
 * filtering once the dataprovider is set.
 * In server mode, the grid will fire a com.flexicious.grids.events.FilterPageSortChangeEvent
 * named filterPageSortChange
 * that should be used to construct an appropriate query to be sent to the
 * backend.
 * 
 * @defaultValue "client"
 * @see com.flexicious.grids.events.FilterPageSortChangeEvent
 */
-(NSString*)filterPageSortMode;
/**
 * Returns the top level filter. 
 */	
-(FLXSFilter*)createFilter;
/**
 * Clears filters at all levels and rebuilds the grid. 
 */		
-(void)clearAllFilters;
/**
 * Clears the filters at all levels 
 */		
-(void)clearFilter;
/**
 * Clears the filters at all levels 
 */	
-(void)clearFilterByField:(NSString*)col;

/**
 * Inserts the column specified column before the specified column
 */
- (void)shiftColumns:(FLXSFlexDataGridColumn *)columnToInsert insertBefore:(FLXSFlexDataGridColumn *)insertBefore level:(FLXSFlexDataGridColumnLevel *)level movingCg:(BOOL)movingCg;

/**
 * Returns the pager control at the root level.
 */	
-(UIView<FLXSIExtendedPager>*)pagerControl;

/**
 * Sets the filter row height at the top level.
 */	
- (float)filterRowHeight;

/**
 * The column that initiated the drag 
 * @return 
 */	
-(FLXSFlexDataGridColumn*)dragColumn;

/**
 * Evaluates whether the given toolbar action is valid or not.
 * 
 * If toolbarActionValidFunction is not null, returns the result of the function passing in the given ToolbarAction. 
 * Else returns true. 
 */
- (BOOL)isToolbarActionValid:(FLXSToolbarAction *)action currentTarget:(NSObject *)currentTarget extendedPager:(UIView <FLXSIExtendedPager> *)extendedPager;

/**
 * In addition to initial enable/disable of toolbar actions, this function
 * can be used to enable or disable toolbar actions at run time.
 */
- (void)enableDisableToolbarAction:(NSString *)code enable:(BOOL)enable;
/**
 * Gets the actual button object for the provided toolbar action. 
 * @param code
 * @return 
 */	
-(UIView*)getToolbarActionButton:(NSString*)code;

/**
 * Sets a property or a style of the button object associated with the toolbar action
 * that has the given code.
 */
- (void)setToolbarActionButtonProperty:(NSString *)toolbarActionCode property:(NSString *)property value:(id)value;
typedef BOOL (^FLXSDynamicLevelHasChildrenFunctionBlock)(NSObject *);
@property (nonatomic, strong) FLXSDynamicLevelHasChildrenFunctionBlock dynamicLevelHasChildrenFunction;

/**
 *  Unused/Not Applicable. For legacy purposes only 
 */
-(int)lockedColumnCount;
/**
 * Unused/Not Applicable. For legacy purposes only. For flexicious Ultimate, the columnLockMode is set on the 
 * FlexDataGridColumn object itself.
 */
-(float)lockedColumnWidth;
/**
 * Returns the maximum width of right locked columns. If there are multiple levels, goes through each of the levels and gets the maximum
 */	
-(float)rightLockedWidth;
/**
 * A list of ID values, based on the selectedKeyField property.
 * Returns the checked keys for the top column level. Please NOTE - this is a read only collection.
 * Adding to this does nothing. If you want to programatically modify the selection, use the selectedObjects instead.
 * 
 * Please note, for hierarchical grids, each level has its own collection of checked keys.
 * The grid.selectedKeys returns the selectedKeys at the top level. To access the checked keys
 * at a lower level, you may navigate to that level using grid.columnLevel.nextLevel...nextLevel.selectedKeys
 * 
 * You can also call grid.getSelectedObjects to get checked objects at all levels. */
-(NSMutableArray*)selectedKeys;
/**
 * A list of checked objects from the data provider. This is the sdk equivalent of selectedItems.
 * We do not have selectedItems, but selectedObjects will almost always be the same as selectedItems. 
 * The only exception is when you use server side paging. In this case, selectedObjects will contain all the items
 * checked, on all pages.
 * 
 * When a row is checked in the grid, we store the  the checked object in the selectedObects array collection.
 * This allows for multiple pages of data that comes down from the server and not maintained in memory 
 * to still keep track of the objects that were checked on other pages.
 * 
 * Please note, for hierarchical grids, each level has its own collection of checked keys.
 * The grid.selectedObjects returns the selectedKeys at the top level. To access the checked keys
 * at a lower level, you may navigate to that level using grid.columnLevel.nextLevel...nextLevel.selectedKeys 
 * You can also call grid.getSelectedObjects to get checked objects at all levels.
 * 
 * @deprecated Please use the getSelectedObjects and setSelectedObjects instead.
 * */	
-(NSMutableArray*)selectedObjects;
/**
 * For nested datagrids, used to get all items checked at all levels.
 * If you specify getKey=true, the resulting array will only contain
 * the value of the selectedKeyField at each level.
 */
-(NSArray*)getSelectedObjects:(BOOL)getKey :(BOOL)unSelected;
/**
 * Returns a copy of the open items array.
 */	
-(NSMutableArray*)getOpenObjects;
/**
 * A list of ID values, based on the selectedKeyField property.
 * For hierarchical datagrids, used to get all open(expanded) records at all levels.
 * Please NOTE - this is a read only collection. Adding to this does nothing. 
 * 
 * If you want to programatically modify the collapse expand, use the setOpenKeys instead, or add directly to the open items.
 * */
-(NSArray*)getOpenKeys;
/**
 * For nested/grouped hierarchical datagrids, used to select records.
 * Iterates through the data provider, matching each object, and if matches, adds the object
 * to the grid.openItems
 * 
 * When you reset the dataprovider via server call, the original objects that we were tracking with 
 * openItems are gone, so the grid no longer has  a handle to know which items to retain open. To combat
 * this, you may use the following snippet:
 * 
 * <p>
 * var openKeys:Array=grid.getOpenKeys(); <br/>
 * grid.dataProviderFLXS=yourNewDataProvider;<br/>
 * grid.setOpenKeys(openKeys);<br/>
 * </p>
 * 
 * Please note, these API calls rely on the selectedKeyField being defined at each level, as well as the key values being unique.
 */
-(void)setOpenKeys:(NSArray*)keys;

/**
 * For nested/grouped hierarchical datagrids, used to select records.
 * Iterates through the data provider, matching each object, and if matches, adds the object
 * to the selectedObjects for the level
 * 
 * Please see the documentation of setSelectedKeys for instructions on maintaining grid selection
 * post a data provider refresh.
 */
- (void)setSelectedObjects:(NSArray *)objects openItems:(BOOL)openItems;

/**
 * For nested/grouped hierarchical datagrids, used to select records.
 * Iterates through the data provider, matching each object, and if matches, adds the object
 * to the selectedObjects for the level. Ensure that the selectedKeyField is set at the level.
 * 
 * When you reset the dataprovider via server call, the original objects that we were tracking with 
 * checked objects are gone, so the grid no longer has  a handle to know which items to retain checked. To combat
 * this, you may use the following snippet:
 * 
 * <p>
 * var selectedKeys:Array=grid.getSelectedKeys(); <br/>
 * grid.dataProviderFLXS=yourNewDataProvider;<br/>
 * grid.setSelectedKeys(selectedKeys);<br/>
 * </p>
 * 
 * Please note, these API calls rely on the selectedKeyField being defined at each level, as well as the key values being unique.
 */
- (void)setSelectedKeys:(NSArray *)objects openItems:(BOOL)openItems;
/**
 * For nested datagrids, used to get all records at all levels. 
 * Please see the documentation of setSelectedKeys for instructions on maintaining grid selection
 * post a data provider refresh.
 */	
-(NSArray*)getSelectedKeys;
/**
 * When enableSelectionExclusion, returns a list of items that the user explicitly unselected.
 */	
-(NSArray*)getUnSelectedKeys;
/**
 * @private 
 */	
-(NSMutableArray*)openItems;
/**
 * A list of items that the user has opened. Only applicable grids with nested column levels. 
 * If you programatically modify this collection, call the rebuild method.
 * Please see the documentation of setOpenKeys for instructions on maintaining grid expand/collapse state
 * post a data provider refresh.
 * 
 * @deprecated Please use the getOpenKeys and getOpenItems instead.
 */	
//-(void)openItems:(NSMutableArray*)val;
//diagnostics:
-(NSString*)traceRows; 
/**
 * @private 
 * @param val
 * 
 */	
//-(void)itemFilters:(NSMutableDictionary*)val;
/**
 * Given a row index (less than the total number of rows, goes to the row in question).
 * Row index becomes the first visible row. Please note this is a 1 based index.
 * @param pageIndex
 */	
-(void)gotoRow:(int)rowIndex;
/**
 * Selects the provided text in the currently visible cells
 * that have the default item renderer, or if the item renderer
 * has the selection property
 */	
-(void)selectText:(NSString*)txt;

/**
 * Given a data item, scrolls to that item in the datagrid
 * 
 * Flexicious by default will only build RowPositionInfo objects
 * for open items that the user can visually scroll to. So items that 
 * are closed, or are on a different page, will not be built, and cannot be scrolled to.
 * This function will will inspect the data provider to find the item in question, and build the RowPositionInfo for it
 * if its not found in the currently built RowPositionInfo objects.
 */
- (void)gotoItem:(NSObject *)item highlight:(BOOL)highlight level:(FLXSFlexDataGridColumnLevel *)level;

/**
 * Given a key, scrolls to the item that has the provided value for the selectedKeyField at that level
 * 
 * Flexicious by default will only build RowPositionInfo objects
 * for open items that the user can visually scroll to. So items that 
 * are closed, or are on a different page, will not be built, and cannot be scrolled to.
 * This function will will inspect the data provider to find the item in question, and build the RowPositionInfo for it
 * if its not found in the currently built RowPositionInfo objects.
 */
- (void)gotoKey:(NSObject *)key highlight:(BOOL)highlight level:(FLXSFlexDataGridColumnLevel *)level;

/**
 * Iterates through the data provider to get a list of row positions
 * that match the text provided.
 */
- (NSArray *)quickFind:(NSString *)whatToFind searchCols:(NSArray *)searchCols breakAfterFind:(BOOL)breakAfterFind captureCols:(BOOL)captureCols;
/**
 * Gets the cell that is currently being edited.
 */	
-(UIView<FLXSIFlexDataGridCell>*)getCurrentEditingCell;
/**
 * Gets the editor that is currently being edited.
 */	
-(UIView*)getCurrentEditor;
/**
 * Synchronizes the vertical scroll positions of the three locked sections
 */	
-(void)synchronizeLockedVerticalScroll;
/**
 * Synchronizes the vertical scroll positions of the three locked sections
 */	
-(void)synchronizeHorizontalScroll;

/**
 * Returns the data provider, with filter, paging and sorting applied on basis 
 * of the boolean flags specified. The passed in dictionary contains a map of each
 * item in the resulting collection to the level that it belongs to.
 * @param dictionary	Map of each item in the resulting collection to the level that it belongs to
 * @param applyFilter	Whether or not to apply the filter
 * @param applyPaging	Whether or not to apply paging
 * @param applySort		Whether or not to apply sort
 * @param pages			Which pages to get, only needed if you want a page range. specify null(default) if you want only the current page.
 * @param flatten		If this is set to true, will iterate through children to get child data as well.
 * @return A flat array of all items that match the criteria generated on basis of the parameters above.
 * 
 */
- (NSArray *)getFilteredPagedSortedData:(FLXSKeyValuePairCollection *)dictionary applyFilter:(BOOL)applyFilter applyPaging:(BOOL)applyPaging applySort:(BOOL)applySort pages:(NSArray *)pages;
/**
 *Returns the RowPosition Info object for the item at the given vertical scroll position 
 */
-(FLXSRowPositionInfo*)getItemAtPosition:(float)position;
/**
 *Returns the container for the given cell
 */
-(FLXSFlexDataGridContainerBase*)getParentContainer:(UIView<FLXSIFlexDataGridCell>*)cell;

/**
 * Calls getChildren, and if result is XML or XMLList, returns length() else returns length;
 */
- (int)getChildrenLength:(NSObject *)object level:(FLXSFlexDataGridColumnLevel *)level filter:(BOOL)filter page:(BOOL)page sort:(BOOL)sort;
/**
 * If arr is XML or XMLList, returns length() else returns length;
 */	
-(int)getLength:(NSObject*)arr;

/**
 * If the dataprovider is IHierarchicalCollectionView, calls the getChildren method on the incoming object.
 * If object is XMLList or XML, returns the result of its "children" method.
 * Else returns the value of the level.childrenField property on the object being passed in
 * 
 * Prior to returning, applies filter, page or sort as specified by the parameters.
 * You can intercept calls to this function by defining a custom getChildrenFunction
 */
- (NSArray *)getChildren:(NSObject *)object level:(FLXSFlexDataGridColumnLevel *)level filter:(BOOL)filter page:(BOOL)page sort:(BOOL)sort;

/**
 * Returns the parent object for the passed in object.
 * Please note, if your data provider is xml or hierarchical collection view,
 * grid will use the getParent method or getParentItem method on such data providers
 * respectively. If you have specified a parentField, which is a pointer 
 * on the object that points back to the parent, the grid will use that. 
 * If none of the above is true, the grid will use its built in map of 
 * hierarchical data, but this has a limitation of only being able to return
 * parents of items that are on the current page of data. 
 * */
- (NSObject *)getParent:(NSObject *)object level:(FLXSFlexDataGridColumnLevel *)level;
/**
 * Called by PrintController and ExportController to get the data on basis of PrintOptions and ExportOptions
 */	
-(NSArray*)getDataForPrintExport:(FLXSPrintExportOptions*)printOptions;
/**
 * Sets the visible flag on all columns except the ones speicified in the list to false.
 */	
-(void)showColumns:(NSMutableArray*)colsToShow;
/**
 * Sets the visible flag on all columns except the ones where excludeFromPrint=true.
 */
-(void)showPrintableColumns;
/**
 *Returns the filter at the top level.
 */	
-(NSMutableArray*)getFilterArguments;
/**
 *Gets the filter at the root level 
 */		
-(FLXSFilter*)getRootFilter;

/**
 * Used to get the current value of the filter.
 * @param column		The dataFieldFLXS of the column to get the filter value for
 */
- (void)setFilterValue:(NSString *)col value:(NSObject *)val triggerEvent:(BOOL)triggerEvent;
/**
 * Sets the filter at the top level.
 * 
 * @param fld	The string to match the searchField property of the filter control with.
 * @return 		True if focus was set, false if otherwise.<br/>
 * Focus may not be set if the given search field does not exist, <br/>
 * or if the filter control for the given search field does not  <br/>
 * implement IFocusManagerComponent.
 */	
-(BOOL)setFilterFocus:(NSString*)fld;
/**
 * Used to get the current value of the filter.
 * @param column		The dataFieldFLXS of the column to get the filter value for
 */	
-(id)getFilterValue:(NSString*)col;
/**
 * Used by state persistence to load sort settings that were
 * persisted previously.
 * @param sorts
 * @return 
 * 
 */	
-(void)processSort:(NSMutableArray*)sorts;
/**
 * Clears out all the columns of the grid 
 * If the parameter to rebuild is true, the grid will be rebuilt.
 * Otherwise, just the columns will be cleared, and the consumer code
 * should rebuild the grid.
 */		
-(void)clearColumns:(BOOL)rebuild;
/**
 * Adds the column to the collection of columns at the root level.
 */		
-(void)addColumn:(FLXSFlexDataGridColumn*)col;
/**
 * Removes the column from the collection of columns at this level.
 */	
-(void)removeColumn:(FLXSFlexDataGridColumn*)col;
/**
 *Returns the column with the specified datafield, only at the root level
 */
-(FLXSFlexDataGridColumn*)getColumnByDataField:(NSString*)fld;
/**
 *Returns the column with the specified UniqueIdentifier, only at the root level
 */	
-(FLXSFlexDataGridColumn*)getColumnByUniqueIdentifier:(NSString*)fld;
/**
 * Modifies the columns so the width is distributed equally.
 * Columns that are fixedWidth are not updated. 
 */	
-(void)distributeColumnWidthsEqually;
/**
 * Returns the max depth possible for nested datagrids
 */
-(int)maxDepth;
/**
 * Returns true of this is a nested grid, and we have expanded to a level below 1. 
 */	
-(BOOL)canExpandUp;
/**
 * Returns true of this is a nested grid, and we have not expanded to the lowest level 
 */	
-(BOOL)canExpandDown;
/**
 * Returns FlexDataGridColumnLevel object at the specified depth
 */
-(FLXSFlexDataGridColumnLevel*)getLevel:(int)levelDepth;
/**
 * For nested datagrids, expands all items to the level specified. 
 */	
-(void)expandToLevel:(int)level;
/**
 * A method that simply rebuilds the body as opposed to rebuilding the entire grid.  
 * Please note, that this method is not a "deferred" execution method. In that, if you
 * call this multiple times, the performance will get affected negatively. If you have 
 * rapidly changing data, consider using the refreshCells method, if new records are not 
 * being added, or existing records are not being deleted. If new records are being added/deleted
 * use rebuildBodyDeferred;
 */	
-(void)rebuildBody:(BOOL)vupdateTotalRecords;
/**
 * Same as rebuildBody, but ideal for scenarios where you have to call rebuildBody frequently (i.e. more than once 
 * within a validation/invalidation cycle).  
 */	
-(void)rebuildBodyDeferred;
/**
 * A method that simply rebuilds the header as opposed to rebuilding the entire grid.  
 */		
-(void)rebuildHeader;
/**
 * A method that simply rebuilds the pager as opposed to rebuilding the entire grid.  
 */		
-(void)rebuildPager;
/**
 * A method that simply rebuilds the footer as opposed to rebuilding the entire grid.  
 */		
-(void)rebuildFooter;
/**
 * A method that simply rebuilds the footer as opposed to rebuilding the entire grid.  
 */	
-(void)rebuildFilter;
/**
 * A method that simply redraws the body as opposed to rebuilding the entire grid.  
 * As opposed to rebuild, does not recalculate row positions and heights, just refreshes
 * the currently drawn rows.
 */		
-(void)redrawBody;
/**
 *For nested datagrids, expands all items one level up 
 */		
-(void)expandUp;
/**
 * For nested datagrids, expands all items one level down 
 */	
-(void)expandDown;
/**
 * For grids with column groups, expands them all.
 */	
-(void)expandAllColumnGroups:(int)lvl;
/**
 * For grids with column groups, expands them all.
 */		
-(void)collapseAllColumnGroups:(int)lvl;
/**
 * For nested datagrids, expands all items one level down 
 */	
-(void)expandAll;
/**
 * For nested datagrids, expands all items one level down 
 */	
-(void)collapseAll;
/**
 * The current tooltip object. 
 */		
-(UIView*)currentTooltip;
/**
 * The current tooltip object trigger. 
 */
-(UIView*)currentTooltipTrigger;

/**
 * Displays a tooltip for the control in question. The tooltip will disappear if the mouse
 * moves over an area that is not the 'relativeTo' component or the tooltip component.. 
 * @param relativeTo Which component to position the popup relative to
 * @param tooltip The popup to display
 * @param dataContext If the popup has a data property, it will be set to this value
 * @param point If you specify this, the relativeTo is ignored, and the popup appears at the exact point you specify. Please ensure that the X and Y are relative to the Grid.
 * @param leftOffset Whether to shift the popup left after calculating the positions, for customizing the actual position
 * @param topOffset	Whether to shift the popup top after calculating the positions, for customizing the actual position
 * @param offScreenMath	Whether or not to adjust the popup if it appears off screen
 * @param where		One of three values, left, right or none. If left, positions to bottom left, if right, positions to bottom right, if none, positions right below the relativeTo component.
 * @param container	The holder for the tooltip, defaults to UIUtils.getTopLevelApplication(). You may need to override in multi window Air apps.
 * By default, the tooltip will go away once you hover the mouse out of the trigger cell or the tooltip and stayed that way for tooltipWatcherTimeout. You may also
 * manually remove the tooltip by calling the hideToolTip() function. 
 */
- (void)showTooltip:(UIView *)relativeTo tooltip:(UIView *)tooltip dataContext:(NSObject *)dataContext point:(Point *)point leftOffset:(float)leftOffset topOffset:(float)topOffset offScreenMath:(BOOL)offScreenMath where:(NSString *)where container:(NSObject *)container;
/**
 * Hides the current tooltip. 
 */
-(void)hideTooltip;

- (FLXSFilter *)getItemFilter:(FLXSFlexDataGridColumnLevel *)level item:(NSObject *)item;
/**
 * A comma seperated list of the following strings:
 * filter,header,body,footer,pager.
 * 
 * Changes the order in which the grid displays the
 * filter,header,body,footer,pager
 * The order in which the various sections of the grid
 * are laid out.
 * 
 * Defaults to pager,filter,body,footer
 */
-(NSString*)displayOrder;
-(void)setDisplayOrder:(NSString*)value;
/**
 * Handle for the auto refresh.
 * @param event
 */		
-(void)dispatchAutoRefreshEvent:(FLXSEvent*)event;
/**
 * If you set enableRowNumbers=true; the level calls this function to create a FlexDataGridRowNumberColumn
 * Default function returns new FlexDataGridRowNumberColumn();
 * @deprecated. Row numbers are no longer supported.
 */	
-(NSObject*)defaultCreateRowNumberColumn;
/**
 * For the top level, returns grid.getRootFlat().indexOf(cell.rowInfo.data)
 * For other levels, uses level.getChildren(grid.getParent(item)).indexOf(cell.rowInfo.data);
 * @deprecated. Row numbers are no longer supported.
 */	
-(NSString*)defaultGetRowIndex:(UIView<FLXSIFlexDataGridDataCell>*)cell;
/**
 * Last time the auto refresh timer was triggered 
 * @return 
 */		
-(NSDate*)lastAutoRefresh;
/**
 * @private
 */		
-(void)lastAutoRefresh:(NSDate*)value;
/**
 *  If grid.openItems.contains(getItemKey(cell.rowInfo.data)), 
 *  return the value of expandTooltip else collapseTooltip
 */	
-(NSString*)defaultExpandCollapseTooltipFunction:(UIView<FLXSIFlexDataGridCell>*)cell;
/**
 * Adds to toolbar actions, and refreshes the toolbar.
 */	
-(void)setToolbarActions:(NSArray*)actions;
-(FLXSToolbarAction*)extractAction:(NSObject*)item;

/**
 * @private 
 */
- (void)addToolbarAction:(NSObject *)action itemIndex:(int)itemIndex;
/**
 * @private 
 */	
-(void)removeToolbarAction:(NSString*)code;
/**
 * Returns the built in Edit Action 
 * @return 
 */	
-(FLXSToolbarAction*)toolbarActionEdit;
/**
 * Returns the built in Edit Action 
 * @return 
 */	
-(FLXSToolbarAction*)toolbarActionSort;
/**
 * Returns the built in Delete Action 
 * @return 
 */	
-(FLXSToolbarAction*)toolbarActionDelete;
/**
 * Returns the built in Move Action 
 * @return 
 */	
-(FLXSToolbarAction*)toolbarActionMoveTo;
/**
 * Returns the built in moveUp Action 
 * @return 
 */	
-(FLXSToolbarAction*)toolbarActionMoveUp;
/**
 * Returns the built in moveUp Action 
 * @return 
 */	
-(FLXSToolbarAction*)toolbarActionSeparator;
/**
 * Returns the built in moveDown Action 
 * @return 
 */	
-(FLXSToolbarAction*)toolbarActionMoveDown;
/**
 * Returns the built in AddRow Action 
 * @return 
 */	
-(FLXSToolbarAction*)toolbarActionAddRow;
/**
 * Returns the built in Filter Action 
 * @return 
 */	
-(FLXSToolbarAction*)toolbarActionFilter;

/**
 * Runs the given toolbar action. Dispatches the toolbarActionExecuted event. If you call prevent default in this event,
 * the default handling code does not execute.
 */
- (void)runToolbarAction:(FLXSToolbarAction *)action currentTarget:(NSObject *)currentTarget extendedPager:(UIView <FLXSIExtendedPager> *)extendedPager;

+ (int)getNewIndex:(NSMutableArray *)lcw item:(NSObject *)item direction:(NSString *)direction;

/**
 * Creates a Toolbar Action 
 * @param titleLabel			The label to apply to the action
 * @param code			The code to associate with the action
 * @param requiresSelection	Whether or not the action requires an item to be checked within the grid.
 * @param requiresSingleSelection	Whether or not the action requires a single item to be checked within the grid.
 */
- (FLXSToolbarAction *)createBuiltinAction:(NSString *)lbl code:(NSString *)code requiresSelection:(BOOL)requiresSelection requiresSingleSelection:(BOOL)requiresSingleSelection;
/**
 * Given a code, loops through the toolbarActions, and gets the toolbar action with the given code. 
 * @param code
 * @return 
 */	
-(FLXSToolbarAction*)getActionByCode:(NSString*)code;
/**
 * Adds to built in filters and refreshes the toolbar.
 */	
-(void)setPredefinedFilters:(NSArray*)filters;

/**
 * On grids that allow for tracking errors, call this method to highlight the error 
 * using the errorRowStyle, errorContainerRowStyle, and errorMessageStyle.
 * 
 * Pass in the key of the object (that is matched using the selectedKeyField)
 * the dataFieldFLXS of the column that is supposed to show the error, and the
 * error message text.
 * 
 * Please note - starting 2.8, the default cell does not support error highlighting. To 
 * use this function, please set the "enableDataCellOptimization" flag on the column
 * that you need error highlighting on to false.
 */
- (void)setErrorByKey:(id)key fld:(NSString *)fld errorMsg:(NSString *)errorMsg;

/**
 * Similar to setErrorByKey, except takes the actual object that the key represents.
 * @copy com.flexicious.nestedtreedatagrid#setErrorByKey
 */
- (void)setErrorByObject:(NSObject *)item fld:(NSString *)fld errorMsg:(NSString *)errorMsg;

/**
 * Clears the errors for the specified key
 */
- (void)clearErrorByKey:(id)key fld:(NSString *)fld;
/**
 * Clears out all the errors
 */
-(void)clearAllErrors;

/**
 * Similar to clearErrorByKey, except takes the actual object that the key represents.
 */
- (void)clearErrorByObject:(NSObject *)item fld:(NSString *)fld;
/**
 * Returns an object that has the error information for the passed in object.
 */
-(NSObject*)getError:(NSObject*)item;
/**
 * Returns an object that has the error information for the passed in object.
 */
-(NSString*)getAllErrorString;

/**
 * Provided an item, loops through the data provider, and finds
 * the level associated with the provided item. 
 * Let the level and flat be null.
 */
- (FLXSFlexDataGridColumnLevel *)getLevelForItem:(id)itemToFind flat:(NSArray *)flat level:(FLXSFlexDataGridColumnLevel *)level;

/**
 * If variableRowHeight returns the minimum height required to display text of each column without clipping. 
 * Please note, atleast one column needs to have the wordWrap flag set to true. If you use custom item rendereres, these are not accounted for in the height measurement 
 * for performance reasons. In this case, you should override the getRowHeight method and provide your own implementation which is optimized for your situation.
 * 
 * @param item		The item being displayed
 * @param level		The FlexDataGridColumnLevel object that the item belongs to
 * @param rowType	The type of the row, one of the RowPositionInfo.ROW_TYPE_XXXX constants
 * @return 			Height of the row
 * 
 */
- (float)getRowHeight:(NSObject *)item level:(FLXSFlexDataGridColumnLevel *)level rowType:(int)rowType;

/**
 * Given a column and padding values, calculate the height required to fully render the text 
 * @param col			The column to render. The width of this column is used to calculate the height.
 * @param paddingLeft	The left padding to apply while calculating the height
 * @param paddingRight	The right padding to apply while calculating the height
 * @param paddingTop	The top padding to apply while calculating the height
 * @param paddingBottomFLXS	The bottom padding to apply while calculating the height
 * @param itemRenderer	The renderer to use - for data cells uses itemRenderer for header cells uses headerRenderer
 * @param ht			The previously calculated max height. The ht will return this value if the calculated height is less than the passed in ht.
 * @param txt			The text to render.
 * @param item			The item (or row data) object that will be applied to the data property of the renderer
 * @return 				If the calculated height is greater than ht parameter, returns the calculated height. Else returns the value of the ht parameter
 */
- (float)measureCellHeight:(FLXSFlexDataGridColumn *)col paddingLeft:(float)paddingLeft paddingRight:(float)paddingRight paddingTop:(float)paddingTop paddingBottom:(float)paddingBottom itemRenderer:(FLXSClassFactory *)itemRenderer ht:(float)ht text:(NSString *)txt item:(NSObject *)item style:(NSObject *)styl;

/**
 * Shows the given toaster message
 * 
 * @param message			The message to display in the toaster notification 
 * @param toasterRenderer	A classfactory for the actual renderer control. Defaults to DefaultToasterRenderer.
 * @param animationDuration	Number of milli seconds to animate the move or the fade animation for the toaster to appear and disappear. Defaults to 1000
 * @param visibleDuration	Number of milli seconds to keep the toaster visible. Defaults to 5000
 * @param toasterPosition	The position for the toaster. One of the Toaster.POSITION_XXXX constants. Defaults to Toaster.POSITION_BOTTOM_RIGHT
 * @param moveAnimate		Whether to use the move animation. 
 * @param fadeAnimate		Whether to use the fade animation. 
 * 
 * @return The toaster instance used to show the toaster.
 */
- (void)showToaster:(NSString *)message toasterPosition:(NSString *)toasterPosition toasterRenderer:(FLXSClassFactory *)toasterRenderer animationDuration:(float)animationDuration visibleDuration:(float)visibleDuration moveAnimate:(BOOL)moveAnimate fadeAnimate:(BOOL)fadeAnimate;
/**
 * Not supported. Use the filterContainer.rows property instead.
 */	
-(NSArray*)filterRows;
/**
 * Returns an array of RowInfo objects in the footer row.
 */	
-(NSArray*)footerRows;
/**
 * Returns the top level pager
 */	
-(UIView<FLXSIPager>*)pager;
/**
 * Only applicable for flat grids. Selectd Index holds no meaning for hierarchical grids. 
 * This function will run a filter 
 */
-(int)selectedIndex;
/**
 * Returns dataProviderFLXS.indexOf(selectedObjects(0))
 */
-(NSArray*)selectedIndices;
/**
 * Returns (selectedObjects(0)). 
 */
-(NSObject*)selectedItem;
-(void)setSelectedItem:(NSObject*)val;
/**
 * Adds the provided item to the selection of the top (root) level.
 * @param val
 */	
-(void)addSelectedItem:(NSObject*)val;
/**
 * Returns the top level columnCount
 */
-(int)columnCount;
/**
 * Returns the top level column names
 */
-(NSObject*)columnNames;
/**
 * Added for Persistence support  
 * @return 
 */	
-(BOOL)hasGroupedColumns;
/**
 * Added for Persistence support  
 * @return 
 */	
-(void)filterPageSortMode:(NSString*)val;

/**
 *  Opens or closes all the nodes of the navigation tree below the specified item. 
 *  @param item An Object defining the branch node. This Object contains the 
 *  data provider element for the branch node. 
 *
 *  @param open Specify <code>true</code> to open the items, 
 *  and <code>false</code> to close them.
 * 
 *  @param level Level at which the item exists. If null is specified, defaults to the top level
 * */
- (void)expandChildrenOf:(NSObject *)item open:(BOOL)open level:(FLXSFlexDataGridColumnLevel *)level;

/**
 * @private 
 * @param item
 * @param open
 * 
 */
- (void)addRemoveFromOpenItems:(NSObject *)item open:(BOOL)open level:(FLXSFlexDataGridColumnLevel *)level;
/**
 * returns true if any of the levels have a filter function 
 * @return 
 * 
 */
-(BOOL)hasFilterFunction;
/**
 * An array of ChangeInfo objects that contains all the changes made to the data provider using the grid editing mechanism.
 */	
-(NSMutableArray*)changes;

/**
 * Method to track a change, called by track change API to keep track of additions, deletions and modifications to the data provider.  
 * @param changedItem	Item being changed
 * @param changeType	Type of the change
 * @param changeLevel	Nest Level of the level being changed
 * @param changedProperty	The property being changed
 * @param previousValue	The value prior to the change
 * @param newValue	The new value.
 */
- (void)trackChange:(NSObject *)changedItem changeType:(NSString *)changeType changeLevel:(FLXSFlexDataGridColumnLevel *)changeLevel changedProperty:(NSString *)changedProperty previousValue:(id)previousValue changedValue:(id)changedValue;

/**
 * Sets the open items on basis of the selectedField.
 * @param rebuild Flag to rebuild the grid. Set to true if calling from your code, unless rebuild is being called else where.
 */
- (void)setSelectedItemsBasedOnSelectedField:(BOOL)rebuild openItems:(BOOL)openItems;
/**
 * Takes an object that has a rowIndex and a columnIndex property. Finds the cell at that position, 
 * and emulates a click event on that cell. This event, in turn will begin an edit session for editable
 * cells. 
 */	
-(void)editedItemPosition:(NSObject*)value;
/**
 * Gets the column with the specified search field
 */	
-(NSObject*)getFilterColumn:(NSString*)searchField;
/**
 * Displays a message without the spinner label.
 * @param msg
 */	
-(void)showMessage:(NSString*)msg;
-(FLXSSelectionInfo*)selectionInfo;
/**
 * Default handler for the Word Export Button. Calls
 * ExtendedExportController.instance().export(this.grid,ExportOptions.create(ExportOptions.DOC_EXPORT))  
 */
-(void)defaultWordHandlerFunction;
/**
 * Default handler for the Word Export Button. Calls
 * ExtendedExportController.instance().export(this.grid,ExportOptions.create())  
 */
-(void)defaultExcelHandlerFunction;
/**
 * Default handler for the Print Button. Calls
 * var po:PrintOptions=PrintOptions.create();
 * po.printOptionsViewrenderer = new ClassFactory(ExtendedPrintOptionsView);
 * ExtendedPrintController.instance().print(this.grid,po)
 */
-(void)defaultPrintHandlerFunction;
/**
 * Default handler for the Print Button. Calls
 * var po:PrintOptions=PrintOptions.create(true);
 * po.printOptionsViewrenderer = new ClassFactory(ExtendedPrintOptionsView);
 * ExtendedPrintController.instance().print(this.grid,po)
 */
-(void)defaultPdfHandlerFunction;
//-(void)setColumns:(NSArray*)val;
/**
 * @private
 */	
-(NSArray*)getColumns;
/**
 * @private
 */	
-(NSObject*)getDataProvider;
/**
 * Gets the class responsible for handling the PrintUI should be a IPrintDataGrid
 * @return 
 */	
-(FLXSClassFactory*)createPrintComponentFactory;
-(void)enabled:(BOOL)value;
/**
 * Return true if enableStickyControlKeySelection  Or (Control Key is down AND (selectionMode is MultipleRows or MultipleCells))
 */	
-(BOOL)isCtrlKeyDownOrSticky:(FLXSEvent*)event;
//moved from State peristence include
-(FLXSUserSettingsController*)getUserSettingsController;
/**
 * If you modify one or more column groups, calling this method is required so that
 * inter related column groups can update themselves. */
-(void)alignColumnGroups;
/**
 * @private
 */		
-(void)cascadeColumnGroups:(FLXSFlexDataGridColumnGroup*)cg;
/**
 * Given a cell, returns it row span based upon how many children are open
 * Recursively inspects the children to see if any of them are open as well.
 * @param cell
 * @return 
 */	
-(int)getRowSpanBasedOnOpenItemCount:(UIView<FLXSIFlexDataGridCell>*)cell;
/**
 * Given a cell if it is a datarow, and it is associated with a column
 * and the column is at the nest level of the cell, and the column is left locked
 * and the data item bound to the cell is open, then will return the recursive
 * count of all open items under this cell. 
 * @param cell	The cell to check
 * @return 	integer
 */	
-(int)getOpenItemCount:(UIView<FLXSIFlexDataGridCell>*)cell;

/**
 * @private
 */
- (int)getRecursiveOpenItemCount:(NSArray *)children nextLevel:(FLXSFlexDataGridColumnLevel *)nextLevel;
/**
 * Whether to use addElement or addChild;
 */		
-(BOOL)useElements;
/**
 * Shows the spinner with default values defined below:<br/>
 * Label: "Loading please wait"<br/>
 * X Position : center X of the grid <br/>
 * Y Position : center Y of the grid<br/>
 * Grid Alpa when the spinner is active : 0.3<br/>
 * Spinner appearance can be modified using styles <br/>.
 */	
-(void)showSpinner:(NSString*)msg;
/**
 * Removes the spinner and sets the bodyContainer.alpha back to 1 
 */	
-(void)hideSpinner;
/**
* Attaches the spinner behavior to the owner component. 
* When the startspin method of this behavior is called, the 
* behavior will instantiate a new spinner based on the owners
* Spinner Factory, and position it in the middle of the owner
* components display area.
* When the stop spin method is called, the behavior will remove
* the spinner from the owner component and stop the spin.
*/
-(UIView*)spinnerParent;
/**
 * Queues a call to drawFiller in the next validation cycle
 */		
-(void)invalidateFiller;
/**
 * When enableFillerRows=true, wipes out and recreates the filler rows. The grid automatically calls this method 
 * when any column widths change, dataprovider changes, size changes, or when expand/collapse happen.
 */	
-(void)drawFiller;

/**
 * @private
 */
- (float)drawFillerCell:(FLXSGridBackground *)section color:(UIColor *)color pointer:(float)pointer currx:(float)currx colWidth:(float)colWidth verticalGridLines:(BOOL)verticalGridLines verticalGridLineThickness:(int)verticalGridLineThickness verticalGridLineColor:(UIColor *)verticalGridLineColor horizontalGridLines:(BOOL)horizontalGridLines horizontalGridLineThickness:(int)horizontalGridLineThickness horizontalGridLineColor:(UIColor *)horizontalGridLineColor rowHt:(float)rowHt draw:(BOOL)draw colIsInView:(BOOL)colIsInView sectionHorizontalScrollPosition:(float)sectionHorizontalScrollPosition;
/**
 * Is this cell editable? Returns true if: <br/>
 * 1) The cell is an IFlexDataGridCell <br/>
 * 2) The cells column is editable<br/>
 * 3) The cellEditableFunction is null OR cellEditableFunction(fdgCell) returns true.<br/>
 */	
-(BOOL)isCellEditable:(UIView<FLXSIFlexDataGridCell>*)fdgCell;
/**
 * Destroys the current item editor, if there is one. 
 */	
-(void)destroyItemEditor;
-(void)buildFromXML :(NSData*) xmlData;
-(BOOL)isRowSelectionMode;
-(BOOL)isCellSelectionMode;

-(void)validateNow;

//FLXSIEventDispatcher methods
/**
* Attaches the tooltip behavior to any UI component. The behavior does not
* automatically trigger, however, it does wrap all the functionality needed to 
* display a tooltip type control next to the requesting control.
*/
-(void)dispatchEvent:(FLXSEvent *)event;

/**
 * @private
 */
- (void)addEventListenerOfType:(NSString *)type usingTarget:(NSObject *)target withHandler:(SEL)handler;
-(void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler;
//End FLXSIEventDispatcher methods

+ (NSString*)MOVE_TOP;
+ (NSString*)MOVE_UP;
+ (NSString*)MOVE_DOWN;
+ (NSString*)MOVE_BOTTOM;
+ (NSString*)CELL_POSITION_ABOVE;
+ (NSString*)CELL_POSITION_BELOW;
+ (NSString*)CELL_POSITION_BELOW_FIRST;
+ (NSString*)CELL_POSITION_ABOVE_LAST;
+ (NSString*)CELL_POSITION_LEFT;
+ (NSString*)CELL_POSITION_RIGHT;


+ (NSString*)WIDTH_DISTRIBUTION_EQUAL;
+ (NSString*)WIDTH_DISTRIBUTION_LAST_COLUMN;
+ (NSString*)WIDTH_DISTRIBUTION_NONE;
+ (NSString*)SELECTION_MODE_SINGLE_ROW;
+ (NSString*)SELECTION_MODE_MULTIPLE_ROWS;
+ (NSString*)SELECTION_MODE_SINGLE_CELL;
+ (NSString*)SELECTION_MODE_MULTIPLE_CELLS;
+ (NSString*)SELECTION_MODE_NONE;




+ (UITextField*)measurerText ;

@end

