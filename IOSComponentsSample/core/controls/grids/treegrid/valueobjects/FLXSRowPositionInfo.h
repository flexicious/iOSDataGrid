#import "FLXSVersion.h"
#import "FLXSVirtualScrollLoadInfo.h"
@class FLXSFlexDataGridColumnLevel;
@class FLXSFlexDataGrid;

/**
	 * Internal class used to keep track of the overall grid rows. (Not just the visible ones).
	 */
@interface FLXSRowPositionInfo : NSObject
{
}

@property (nonatomic, weak) NSObject* rowData;
@property (nonatomic, strong) NSString* string;
@property (nonatomic, weak) FLXSVirtualScrollLoadInfo* virtualScrollLoadInfo;
@property (nonatomic, assign) int rowIndex;
@property (nonatomic, assign) float verticalPosition;
@property (nonatomic, assign) float rowHeight;
@property (nonatomic, assign) int rowType;
@property (nonatomic, assign) int levelNestDepth;
@property (nonatomic, assign) int rowSpan;

@property (nonatomic, readonly) int verticalPositionPlusHeight;
@property (nonatomic, readonly) int rowNestLevel;
@property (nonatomic, readonly) BOOL isRendererRow;
@property (nonatomic, readonly) BOOL isDataRow;
@property (nonatomic, readonly) BOOL isHeaderRow;


- (id)initWithRowData:(NSObject *)rowData andRowIndex:(int)rowIndex andVerticalPosition:(float)verticalPosition andRowHeight:(float)rowHeight andLevel:(FLXSFlexDataGridColumnLevel *)level andRowType:(int)rowType;
-(FLXSFlexDataGridColumnLevel*)getLevel:(FLXSFlexDataGrid*)grid;

/**
  *  ROW_TYPE_HEADER:int=1
  */
+ (int)ROW_TYPE_HEADER;
/**
		 *  ROW_TYPE_FOOTER:int=2
		 */
+ (int)ROW_TYPE_FOOTER;
/**
		 *  ROW_TYPE_PAGER:int=3
		 */
+ (int)ROW_TYPE_PAGER;
/**
		 *  ROW_TYPE_FILTER:int=4
		 */
+ (int)ROW_TYPE_FILTER;
/**
		 *  ROW_TYPE_DATA:int=5
		 */
+ (int)ROW_TYPE_DATA;
/**
		 *  ROW_TYPE_FILL:int=6
		 */
+ (int)ROW_TYPE_FILL;
/**
		 *  ROW_TYPE_FILL:int=7
		 */
+ (int)ROW_TYPE_RENDERER;
/**
		 *  ROW_TYPE_COLUMN_GROUP:int=8
		 */
+ (int)ROW_TYPE_COLUMN_GROUP;
@end

