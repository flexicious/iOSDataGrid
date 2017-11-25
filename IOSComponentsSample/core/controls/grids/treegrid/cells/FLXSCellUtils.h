#import "FLXSVersion.h"
@protocol FLXSIFlexDataGridCell;
@class FLXSFlexDataGridColumnLevel;
/**
	 * A set of utility functions that are shared by FlexDataGridDataCell, FlexDataGridDataCell2 and FlexDataGridDataCell3
	 */

@interface FLXSCellUtils : NSObject
/**
		 * Draws the background as well as calls drawBorder on the given cell
		 *
		 * Each cell in Ultimate will draw its own background
		 * and border. This method will use the evaluated results of a number of properties on the cell
		 * object to calculate the color, width, and visibility of the background associated with this cell.
		 * <ul>
		 * <li>First, this method will check to see if you have defined a cellCustomBackgroundDrawFunction for the
		 * associated column or level. If so, it will call this method, with the cell as a parameter. You can draw
		 * a custom background in this function. If you return false, from this function, this method will not
		 * execute any other code, and simply call the drawBorders method</li>
		 * <li>First, this method will check to see if you have defined a cellCustomBackgroundDrawFunction for the
		 * associated column or level. If so, it will call this method, with the cell as a parameter. You can draw
		 * a custom background in this function. If you return false, from this function, this method will not
		 * execute any other code, and simply call the drawBorders method</li>
		 * </ul>
		 */
+(void)drawBackground:(UIView<FLXSIFlexDataGridCell>*)cell;
/**
* If this is a fillRow, returns the value of the color property.
* Else, returns the value of the "prop" property which is the value of one of the following style properties:
* <ul>
* <li>rollOverColors</li>
* <li>headerRollOverColors</li>
* <li>footerRollOverColors</li>
* <li>filterRollOverColors</li>
* <li>pagerRollOverColors</li>
* <li>columnGroupRollOverColors</li>
* </ul>
*/
+ (id)getRolloverColor:(UIView <FLXSIFlexDataGridCell> *)cell prop:(NSString *)prop;
/**
		 * The getTextColors method is responsible for evaluating the text color of the cell.
		 * <ul>
		 * <li>First, it checks to see if the cell is disabled. If so, it will return the value of the textDisabledColor style property</li>
		 * <li>Next, it checks to see if there is a value for the currentTextColors property (based upon rollover) and if so returns that. </li>
		 * <li>Next, it checks to see if there is a custom cellTextColorFunction on the column and if so, it returns the result of this function</li>
		 * <li>Next, it checks to see if there is a custom rowTextColorFunction on the level and if so, it returns the result of this function</li>
		 * <li>Next, it checks to see if there enableEditRowHighlight is true amd this row is in edit mode, then it returns the value of the editTextColor style property.</li>
		 * <li>Next, it checks to see if the row is selected (row selection mode) or cell is selected (cell selection mode) and if so, returns textSelectedColor property.</li>
		 * <li>Next, it checks to see if a columnTextColor property is specified on the associated column and if so, returns the value of this property.</li>
		 * <li>Finally, it uses the alternatingTextColors array and return its 0th or 1st index based upton the rowInfo.rowPositionInfo.rowIndex.</li>
		 * </ul>
		 */
+(id)getTextColors:(UIView<FLXSIFlexDataGridCell>*)cell;
/**
		 * If a value is defined for grid.cellBackgroundColorFunction, returns the result of that function
		 * else returns null.
		 */
+(id)getBackgroundColorFromGrid:(UIView<FLXSIFlexDataGridCell>*)cell;
/**
		 * If a value is defined for grid.cellTextColorFunction, returns the result of that function
		 * else returns null.
		 */
+(id)getTextColorFromGrid:(UIView<FLXSIFlexDataGridCell>*)cell;
/**
		 * The getBackgroundColors method is responsible for evaluating the background color of the cell.
		 * <ul>
		 * <li>First, it checks to see if this is a filler row. If so, it will use the alternatingItemColors array and return its 0th or 1st index based upton the rowInfo.rowPositionInfo.rowIndex. </li>
		 * <li>Next, it checks to see if the cell is disabled. If so, it will return the value of the selectionDisabledColor style property</li>
		 * <li>Next, it checks to see if there is a custom cellBackgroundColorFunction on the column and if so, it returns the result of this function</li>
		 * <li>Next, it checks to see if there is a custom rowBackgroundColorFunction on the level and if so, it returns the result of this function</li>
		 * <li>Next, it checks to see if there rowInfo's data object is in the errors collection of the grid, and if so, it return the value of the errorBackgroundColor property.</li>
		 * <li>Next, it checks to see if there enableEditRowHighlight is true amd this row is in edit mode, then it returns the value of the editItemColors style property.</li>
		 * <li>Next, it checks to see if there is a value for the currentBackgroundColors property (based upon rollover) and if so returns that.
		 * The currentBackgroundColors property is a result of the grid.highlightRow method.
		 * <ul>
		 * <li>If enableActiveCellHighlight=true uses the value of the activeCellColor style.</li>
		 * <li>Else, uses the value of the rollOverColor style property.</li>
		 * </ul>
		 * </li>
		 * <li>Next, it checks to see if the row is selected (row selection mode) or cell is selected (cell selection mode) and if so, returns selectionColorFLXS property.</li>
		 * <li>Next, it checks to see if a backgroundColor property is specified on the associated column and if so, returns the value of this property.</li>
		 * <li>Finally, it uses the alternatingItemColors array and return its 0th or 1st index based upton the rowInfo.rowPositionInfo.rowIndex.</li>
		 * </ul>
		 */
+(id)getBackgroundColors:(UIView<FLXSIFlexDataGridCell>*)cell;
/**
		 * Draws the borders of the given cell. Each cell in Ultimate will draw its own background
		 * and border. This method will use the evaluated results of a number of properties on the cell
		 * object to calculate the color, width, and visibility of the border associated with this cell.
		 * <ul>
		 * <li>First, it checks to see if the grid.hasErrors evaluates to true. If it does, the nit checks to
		 * see if the cell.rowInfo.data object associated with this cell is within the error collection.
		 * If so, it will use the result of the errorBorderColor style property to figure out the color
		 * of the border for this cell. </li>
		 * <li>Next, it checks to see if there is a cellBorderFunction defined. If there is one, it will just
		 * pass the cell to the given cellBorderFunction and if this function returns false, this method
		 * performs no additional processing and returns.</li>
		 * <li>Next, if the cell's hasHorizontalGridLines evaulates to true, this method then uses the results
		 * of horizontalGridLineThickness, horizontalGridLineColor property to draw a bottomn border</li>
		 * <li>Next, if the cell's drawTopBorder evaulates to true, this method then uses the results
		 * of horizontalGridLineThickness, horizontalGridLineColor property to draw a top border.</li>
		 * <li>Finally, it calls the drawRightBorder method on the cell.</li>
		 * </ul>
		 */
+(void)drawBorders:(UIView<FLXSIFlexDataGridCell>*)cell;
/**
		 * Returns the value of the given style property based on the following logic:
		 * <ul>
		 * <li> If there is a column associated with this cell, and there is a property in the styleOverrides  collection of the column with styleProp
		 * name, returns the value of that property from styleOverrides</li>
		 * <li> If there is a column, calls the getStyleValue method on that column (which checkes to see if a there is a value for this style property
		 * in the column, return that, else if in the level, return that, else if in the grid, return that). The idea being that
		 * you can define a property at the highest possible container (the grid) or one below (at the level) or one below (at the column)</li>
		 * </ul>
		 */
+ (id)getStyleValue:(UIView <FLXSIFlexDataGridCell> *)cell styleProp:(NSString *)styleProp;
/**
		 * Draws the right border for this cell.
		 * There are a few rules on basis of which a right (or a left) border is drawn on a cell.
		 * <ul>
		 * <li>First, if the cell is a Pager cell, no right border is drawn, since the pager shares its left and right border with the grid.</li>
		 * <li>Second, if the cell has no vertical gridlines, no border is drawn.</li>
		 * <li>Else, if the cell has a column and its right locked, then a left border is drawn.</li>
		 * </ul>
		 */
+(void)drawRightBorder:(UIView<FLXSIFlexDataGridCell>*)cell;
/**
		 * @copy com.flexicious.nestedtreedatagrid.interfaces.IFlexDataGridCell#refreshCell
		 */
+(void)refreshCell:(UIView<FLXSIFlexDataGridCell>*)cell;
/**
		 * Given a renderer, sets the size on basis of whether or not there are vertical and horizotnal gridlines .
		 * If there are vertical gridlines, sets the width to width minus verticalGridLineThickness
		 * If there are vertical gridlines, sets the height to width minus horizontalGridLineThickness
		 */
+ (void)setRendererSize:(UIView *)cellRenderer width:(float)w height:(float)h;
/**
		 * If there is a value for the prefix parameter, capitalizes the first word of the val parameter and returns it
		 */
+ (NSString *)capitalizeFirstLetterIfPrefix:(NSString *)prefix val:(NSString *)val;
/**
		 * Capitalizes the first character of the passed in string.
		 */
+(NSString*)doCap:(NSString*)val;
/**
		 * This method is responsible for initializing the checkbox renderer for both the header and data cells.
		 * It performns the following tasks
		 * <ul>
		 * <li>First, it will set the radio button mode of the associated TriStateCheckBox to true if col.radioButtonMode or level.enableSingleSelect is set to true </li>
		 * <li>Next, if the grid.enableSelectionExclusion flag is set to true, it will set the selected state of the associated TriStateCheckBox to the result of the getCheckBoxStateBasedOnExclusion method of the level</li>
		 * <li>Next, if the grid.enableSelectionExclusion flag is set to false (default),
		 * it will set the selected state of the associated TriStateCheckBox based upon the following logic (if enableTriStateCheckBox=true):
		 * <ul>
		 * 	<li>If the associated rowData object is in the selected objects collection of the level, sets it to checked</li>
		 * 	<li>If any of the children the associated rowData object are selected, sets it to middle</li>
		 * 	<li>Else sets it to unchecked</li>
		 * </ul>
		 * </li>
		 * <li>Finally, if the enableLabelAndCheckBox flag is set to true on the column, this method will apply the result of the columns itemToLabel function
		 * to the label property of the checkbox</li>
		 * </ul>
		 */
+ (void)initializeCheckBoxRenderer:(UIView <FLXSIFlexDataGridCell> *)cell level:(FLXSFlexDataGridColumnLevel *)level;
 @end

