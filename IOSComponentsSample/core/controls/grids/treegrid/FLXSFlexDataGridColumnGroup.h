#import "FLXSVersion.h"
@class FLXSClassFactory;
@class FLXSFlexDataGridColumn;
@class FLXSFlexDataGridColumnLevel;
/**
	 * Class responsible for storing information about grouped columns
	 */

@interface FLXSFlexDataGridColumnGroup : NSObject
{

}

@property (nonatomic, strong) FLXSClassFactory* columnGroupCellRenderer;
@property (nonatomic, weak) FLXSFlexDataGridColumnGroup* parentGroup;
@property (nonatomic, strong) NSMutableArray* columnGroups;
@property (nonatomic, weak) FLXSFlexDataGridColumn* startColumn;
@property (nonatomic, weak) FLXSFlexDataGridColumn* calculatedStart;
@property (nonatomic, weak) FLXSFlexDataGridColumn* calculatedEnd;
@property (nonatomic, strong) NSMutableArray* columns;
@property (nonatomic, weak) FLXSFlexDataGridColumn* endColumn;
/**
		 * The height on basis of the data to be displayed. If there is a column group renderer, or if there is headerWordWrap
		 * we calulate this, otherwise, it is set to what ever the levels.headerHeight is.
		 */
@property (nonatomic, assign) float calculatedHeight;
/**
		 * Whether to word wrap the column group 
		 */
@property (nonatomic, strong) NSString* headerText;
/**
		 * Whether to word wrap the column group 
		 */
@property (nonatomic, assign) BOOL headerWordWrap;

/**
 * @private
 * @param val
 *
 */
@property (nonatomic, assign) NSTextAlignment headerAlign;

@property (nonatomic, weak) FLXSFlexDataGridColumnLevel* level;
/**
		 * The level of nesting for this column group
		 * @return 
		 */
@property (nonatomic, assign) int depth;
/**
		 * The level of nesting for this column group
		 * @return 
		 */
@property (nonatomic, assign) float y;
@property (nonatomic, strong) FLXSClassFactory* columnGroupRenderer;
/**
		 * Flag to control whether or not to show an expand collapse icon for this column group. 
		 * The icon itself can be controlled using the columnGroupOpenIcon and columnGroupClosedIcon
		 * of the grid. The position of the icon can be controlled using the expandCollapsePositionFunction
		 * @default false
		 */
@property (nonatomic, assign) BOOL enableExpandCollapse;
@property (nonatomic, strong) NSString* expandCollapsePositionFunction;
@property (nonatomic, strong) NSString* expandTooltip;
@property (nonatomic, strong) NSString* collapseTooltip;
@property (nonatomic, strong) NSString* expandCollapseTooltipFunction;
@property (nonatomic, strong) NSMutableArray* groupedColumns;
@property (nonatomic, weak) FLXSFlexDataGridColumn* collapseStateColumn;
/**
		 * When this flag is set to true, every time the columns are set, the last column is used 
		 * as the collapseStateColumn
		 */
@property (nonatomic, assign) BOOL useLastColumnAsCollapseStateColumn;

@property (nonatomic, weak) FLXSFlexDataGridColumnGroup* rootGroup;
/**
		 *  Height of the column group row. Defaults to 25.
		 */
	
@property (nonatomic, readonly) float height;
/**
		 * Returns true if all but the collapseStateColumn column in this column group is visible.
		 */		
@property (nonatomic, readonly) BOOL isClosed;
@property (nonatomic, readonly) BOOL isColumnOnly;
@property (nonatomic, readonly) float yPlusHeight;
/**
		 * Iterates through all columns widths
		 */	
@property (nonatomic, readonly) float width;
@property (nonatomic, strong) NSMutableArray* children;
@property (nonatomic, strong) FLXSClassFactory *headerRenderer;

/**
		 * Will recalculate the columns at extremeties in the next round. Will recursively go up the column group hierarchy
		 * invalidating its extremities
		 */	
 -(void)invalidateCalculations;
 /**
		 * Will recalculate the columns at extremeties in the next round. Will recursively go down the column group hierarchy
		 * invalidating child extremities
		 */
-(void)invalidateCalculationsDown;
/**
		 * Sets the visibility of all columns to true
		 */
-(void)openColumns;
/**
		 * Sets the visibility of all but the first column to false 
		 */
-(void)closeColumns;
/**
		 *@private 
		 * 
		 */	
-(void)initializeGroup;

- (void)initializeDepthY:(int)dpIn yIn:(float)yIn;
/**
		 * Returns an array of Width and X for this column group.
		 */	
-(NSArray*)getWX;
/**
		 * Iterates through all child groups and gets columns 
		 * @return 
		 * 
		 */		
-(NSArray*)getAllColumns;
-(NSArray*)getAllColumns:(NSArray*)result;
/**
		 * Gets the left most or right most column
		 */	
-(FLXSFlexDataGridColumn*)getColumnAtExtremity:(BOOL)left;
/**
		 * Clone this Group. Copies over the start and end groups.
		 */	
-(FLXSFlexDataGridColumnGroup*)clone:(FLXSFlexDataGridColumnLevel*)newLevel;

+ (FLXSClassFactory*)static_FLXSFlexDataGridColumnGroupCell;
@end

