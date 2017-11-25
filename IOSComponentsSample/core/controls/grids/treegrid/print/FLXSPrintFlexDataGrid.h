//#import "FLXSVersion.h"
//#import "FLXSElasticContainer.h"
//#import "FLXSFlexDataGrid.h"
//
//@class FLXSPrintWindow;
//@class FLXSFlexDataGridBodyContainer;
//@class FLXSRowInfo;
//
///**
//	 * Specialized extension of the FlexDataGrid that is used for printing. Hides the
//	 * vertical scrollbar, and shows only what can be displayed on the page given the
//	 * height constraints of the page being printed to.
//	 */
//@interface FLXSPrintFlexDataGrid : FLXSFlexDataGrid
//{
//}
//
//@property (nonatomic, weak) FLXSPrintWindow* printWindow;
//@property (nonatomic, assign) float totalPagesHeight;
//
///**
//   * We create a specialized body container
//   * @return
//   *
//   */
//-(FLXSFlexDataGridBodyContainer*)createBodyContainer;
///**
//		 * Not applicable for Nested Tree DataGrid, used to conform to interface
//		 */
//-(NSArray*)printListItems;
///**
//		 * Not applicable for Nested Tree DataGrid, used to conform to interface
//		 */
//-(void)setResizableColumns:(BOOL)val;
///**
//		 * Returns true if there is another page of data after this one
//		 */
//-(BOOL)validNextPage;
///**
//		 * Goes to the next page of data.
//		 */
//-(void)nextPage;
///**
//		 * @private
//		 * @param row
//		 *
//		 */
//-(void)placeComponents:(FLXSRowInfo*)row;
///**
//		 * Given an array of ItemPositionInfo objects, draws them in the visible area.
//		 * @param positions
//		 *
//		 */
//-(void)showPositions:(NSArray*)positions;
//-(float)headerHeight;
//-(BOOL)enableHeightAutoAdjust;
//
//@end
//
