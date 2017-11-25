#import "FLXSVersion.h"
#import "FLXSFlexDataGridContainerBase.h"
@class FLXSFlexDataGrid;
@class FLXSEvent;
@class FLXSFlexDataGridColumnLevel;
@class FLXSFilterPageSortChangeEvent;
@class FLXSComponentInfo;
@class FLXSComponentAdditionResult;
@protocol FLXSIExtendedPager;
@class FLXSRowInfo;
/**
	 * The container for header, footer, filter and pager sections of the top level. These
	 * rows are locked so they stay in place, i.e, they do not scroll when the user scrolls vertically.
	 *
	 * When the user scrolls horizontally, these rows will scroll.
	 *
	 *
	 */
@interface FLXSFlexDataGridHeaderContainer : FLXSFlexDataGridContainerBase
{
}
/**
      * The type of this container.
      * Can be one of:
      * <ul>
      * <li>ROW_TYPE_HEADER</li>
      * <li>ROW_TYPE_FOOTER</li>
      * <li>ROW_TYPE_PAGER</li>
      * <li>ROW_TYPE_FILTER</li>
      * <li>ROW_TYPE_DATA</li>
      * <li>ROW_TYPE_FILL</li>
      * <li>ROW_TYPE_RENDERER</li>
      * <li>ROW_TYPE_COLUMN_GROUP</li>
      * </ul>
      */
@property (nonatomic, assign) int chromeType;
-(void)onWidthChanged:(FLXSEvent*)event;

-(id)initWithGrid:(FLXSFlexDataGrid*)grid;
/**
* @private
*/
- (void)createComponents:(FLXSFlexDataGridColumnLevel *)level currentScroll:(int)currentScroll flat:(NSObject *)flat;
-(void)rootPageChange:(NSNotification*)event;
-(void)onFilterChange:(NSNotification*)event;
-(NSArray*)getRowsForRecycling;
-(float)maxHorizontalScrollPosition;
-(FLXSComponentInfo*)getPagerCell;
-(UIView<FLXSIExtendedPager>*)getPager;

- (FLXSComponentAdditionResult *)addCell:(UIView *)component row:(FLXSRowInfo *)row existingComponent:(FLXSComponentInfo *)existingComponent;

/**
		 * Sets the filter value at the top level for the specified field
		 */
- (void)setFilterValue:(NSString *)col val:(NSObject *)val;
/**
		 *Returns the filter at the top level.
		 */
-(NSMutableArray*)getFilterArguments;
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



@end

