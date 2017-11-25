#import "FLXSVersion.h"
#import "FLXSExportOptions.h"
#import "FLXSExporter.h"
#import "FLXSPrintExportOptions.h"
#import "FLXSFilter.h"
@protocol FLXSIPager;
@protocol FLXSIFilterControl;

/**
	 * This is the main class that extends from DataGrid, and
	 * adds Filtering, Paging, and Filtering capabilities to it.
	 */
@protocol FLXSIExtendedDataGrid
-(NSString*)horizontalScrollPolicy;
-(void)horizontalScrollPolicy:(NSString*)val;
-(float)horizontalScrollPosition;
-(void)horizontalScrollPosition:(float)val;
-(float)verticalScrollPosition;
-(void)verticalScrollPosition:(float)val;
-(NSArray*)getColumns;
-(void)setColumns:(NSArray*)val;
-(NSArray*)visibleColumns;
-(NSArray*)exportableColumns;
-(NSArray*)settingsColumns;
-(NSObject*)printExportParameters;
-(FLXSClassFactory *)itemRenderer;
-(float)rowHeight;
-(int)rowCount;
-(NSObject*)getDataProvider;
-(NSObject*)dataProviderNoFilters;
-(NSObject*)dataProviderNoPaging;
-(NSObject*)printExportData;
-(NSString*)filterPageSortMode;
-(FLXSFilter *)createFilter;
-(void)clearFilter;
-(void)processFilter;
-(void)processSort:(NSMutableArray*)sorts;
-(void)validateNow;
-(void)refreshLayout;
-(NSObject*)getFilterColumn:(NSString*)searchField;
/**
		 * Used to get the current value of the filter.
		 * @param column		The dataFieldFLXS of the column to get the filter value for
		 */
-(id)getFilterValue:(NSString*)searchField;
/**
* Used to set the initial value of the filter at the top level for the specified field.
* @param column		The column to set filter for
* @param value			The value to set
* @param triggerEvent	Whether or not to fire the filterPageSortChange event. Defaults to true.
*/
- (void)setFilterValue:(NSString *)searchField value:(NSObject *)val runFilter:(BOOL)runFilter;
-(BOOL)filterVisible;
-(BOOL)footerVisible;
-(BOOL)pagerVisible;
-(void)filterVisible:(BOOL)val;
-(void)footerVisible:(BOOL)val;
-(void)pagerVisible:(BOOL)val;
-(float)filterRowHeight;
-(float)footerRowHeight;
-(void)footerRowHeight:(float)val;
-(BOOL)enableFilters;
-(void)enableFilters:(BOOL)enabled;
-(BOOL)enablePaging;
-(void)enablePaging:(BOOL)enabled;
-(BOOL)enableFooters;
-(void)enableFooters:(BOOL)enabled;
-(BOOL)enableExport;
-(void)enableExport:(BOOL)enabled;
-(int)pageSize;
-(void)pageSize:(int)val;
-(int)pageIndex;
-(int)totalRecords;
-(int)lockedColumnCount;
-(float)lockedColumnWidth;
-(int)verticalScrollBarOffset;
-(NSString*)selectAllState;
-(void)selectAllState:(NSString*)val;
-(NSString*)selectedKeyField;
-(NSMutableArray*)selectedKeys;
-(NSMutableArray*)selectedObjects;
-(NSString*)toolTip;
-(void)toolTip:(NSString*)val;
-(NSMutableArray*)getFilterArguments;
-(BOOL)enableKeyboardNavigation;
-(float)getFilterX:(UIView <FLXSIFilterControl>*)child;
-(void)pauseKeyboardListeners:(NSObject*)filterRenderer;
-(void)keyUpOrDown:(int)keyCode;
-(void)drawFocus:(BOOL)focus;
-(NSObject <FLXSIPager>*)pager;
-(NSArray*)footerRows;
-(NSArray*)filterRows;
-(BOOL)hasGroupedColumns;
-(NSArray*)groupedColumns;
-(void)groupedColumns:(NSArray*)val;
-(NSArray*)getExportableColumns:(FLXSExportOptions*)options;
//-(NSArray*)getPrintableColumns:(FLXSPrintOptions*)options;
-(FLXSExporter*)nativeExcelExporter;

- (void)addEventListener:(NSString *)type type:(NSObject *)target handler:(SEL)handler;
-(void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler;
-(void)dispatchEvent:(FLXSEvent *)event;
@end

