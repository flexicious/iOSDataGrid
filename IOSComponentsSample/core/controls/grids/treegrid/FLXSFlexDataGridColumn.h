//#import "FLxsv"
#import "FLXSEvent.h"
#import "FLXSIDataGridFilterColumn.h"
#import "FLXSIEventDispatcher.h"
#import "FLXSVersion.h"
#import "FLXSFontInfo.h"

@protocol FLXSIFlexDataGridCell;
@class FLXSClassFactory;
@class FLXSFlexDataGridColumnGroup;
@class FLXSFlexDataGridColumnLevel;
/**
	 * The FlexDataGridColumn class describes a column in a FlexDataGrid Column control.
	 *
	 * This class extends a CSSStyleDeclaration, and defines properties that affect the appearance
	 * of the header, footer, filter, and data cells in belonging to the column.
	 */

@interface FLXSFlexDataGridColumn : NSObject <FLXSIDataGridFilterColumn,FLXSIEventDispatcher>
{
}
@property (nonatomic, strong) NSMutableDictionary*calculatedMeasurements;
@property (nonatomic, assign) float naturalLastColWidth;
@property (nonatomic, strong) NSString* footerLabel;
@property (nonatomic, strong) NSString* footerLabelFunction;
@property (nonatomic, strong) FLXSClassFactory* footerRenderer;
@property (nonatomic, strong) NSString* footerOperation;
@property (nonatomic, strong) NSFormatter* footerFormatter;
/**
			 * Precision for the footer label 
			 * @return 
			 * 
			 */	
@property (nonatomic, assign) int footerOperationPrecision;
/**
			 * The alignment of the footer label
			 */		
@property (nonatomic, assign) NSTextAlignment footerAlign;
/**
			 * @private 
			 * @param val
			 * 
			 */		
@property (nonatomic, strong) NSArray* filterComboBoxDataProvider;
/**
			 * Used in conjunction with the @filterComboBoxDataProvider field, used to
			 * set the value of the label field for the associated ISelectFilterControl  
			 */		
@property (nonatomic, strong) NSString* filterComboBoxLabelField;
@property (nonatomic, readonly) NSString* sortFieldName;
/**
			 * @private 
			 * @param val
			 * 
			 */	
@property (nonatomic, strong) NSString* filterComboBoxDataField;
/**
			 * @private
			 */		
@property (nonatomic, assign) BOOL filterComboBoxBuildFromGrid;
/**
			 * Applicable only when the filtercontrol is a 
			 * @see com.flexicious.controls.interfaces.filters.IDateComboBox
			 * 
			 * See the @com.flexicious.utils.DateRange class for details 
			 */	
@property (nonatomic, strong) NSArray* filterDateRangeOptions;
/**
			 * The actual control 
			 * to render inside the header column. This control must implement
			 * the com.flexicious.controls.interfaces.filters.IFilterControl interface.   
			 * @return 
			 */	
@property (nonatomic, strong) FLXSClassFactory* filterRenderer;
@property (nonatomic, strong) NSString* filterControlClass;
/**
			 * @private 
			 * @param val
			 * 
			 */		
@property (nonatomic, strong) NSString* filterOperation;
@property (nonatomic, strong) NSString* filterComparisonType;
/**
			 * @private 
			 * @param val
			 * 
			 */	
@property (nonatomic, strong) NSString* searchField;
/**
			 * @private 
			 * @param val
			 * 
			 */	
@property (nonatomic, strong) NSString* sortField;
/**
			 * The event that the filter triggers on. Defaults to "change", or if the 
			 * filterRenderer supports com.flexicious.controls.interfaces.IDelayedChange, then
			 * the delayedChange event.
			 * @see com.flexicious.controls.interfaces.IDelayedChange
			 */	
@property (nonatomic, strong) NSString* filterTriggerEvent;
/**
			 * @private 
			 * @param val
			 * 
			 */		
@property (nonatomic, assign) BOOL excludeFromPrint;
/**
			 * @private 
			 * @param val
			 * 
			 */	
@property (nonatomic, assign) BOOL excludeFromSettings;
/**
			 * @private 
			 * @param val
			 * 
			 */	
@property (nonatomic, assign) BOOL excludeFromExport;
/**
			 * @private 
			 * @param val
			 * 
			 */	
@property (nonatomic, strong) NSString* filterWaterMark;
/**
			 * @private 
			 * @param val
			 * 
			 */	
@property (nonatomic, assign) BOOL useLabelFunctionForFilterCompare;
/**
			 * @private
			 */		
@property (nonatomic, strong) NSString* linkText;
/**
			 * A function that can be used to control the Text color of each cell in this column. 
			 * If this function is null or returns null, the cell Text will
			 * use the alternatingTextColors style property. This function should take a IFlexDataGridDataCell 
			 * object, which has a pointer to the row data (data) as well as other related information
			 * found in the documentation of the FlexDataGridDataCell class. This function
			 * should return  a single color hex code (uint).
			 * 
			 * @deprecated. Use the grid.cellTextColorFunction instead.
			 */
@property (nonatomic, strong) NSString* cellText;
/**
			 * @private 
			 * @param val
			 * 
			 */	
@property (nonatomic, assign) float percentWidth;
/**
			 * @private 
			 * @param val
			 * 
			 */	
@property (nonatomic, assign) BOOL useUnderLine;
/**
			 * Each Cell in the grid is contains an instance of this class.  
			 * @return 
			 */	
@property (nonatomic, strong) FLXSClassFactory* itemRenderer;
/**
			 * A class factory for the instances of the item editor to use for the 
			 * column, when it is editable.
			 * @default new ClassFactory(mx.controls.TextInput)
			 */	
@property (nonatomic, strong) FLXSClassFactory* itemEditor;
/**
			 * Indicates that the item editors manage their own persitence and populating the dataprovider
			 * back with their changes, so the editorDataField is ignored and the DataGrid does not write
			 * back the value from the editor into the data provider. 
			 * When you set itemEditorManagesPersistence, the itemEditorValidatorFunction or itemEditorApplyValueOnCommit are ignored, 
			 * since we completely handover the responsibility of validating and persisting the data from the editor back into the dataprovider to the editor
			 */
@property (nonatomic, assign) BOOL itemEditorManagesPersistence;
/**
			  * Function to call before committing the value of the item editor
			  * to the data provider. Should take a UIComponent with is the 
			  * item editor, and return a true or a false. If false, value is not committed
			  * If true, value is committed.
			  */
@property (nonatomic, strong) NSString* itemEditorValidatorFunction;
/**
			 *  The name of the property of the item editor that contains the new
    		 *  data for the list item.
			 */	
@property (nonatomic, strong) NSString* editorDataField;
/**
			 * Container for the item renderer. Needs to implement IFlexDataGridDataCell.
			 * Defaults to FlexDataGridDataCell  
			 * @return 
			 */	
@property (nonatomic, strong) FLXSClassFactory* dataCellRenderer;
/**
			 * Container for the header renderer. Needs to inherit from FlexDataGridHeaderCell.  
			 * Defaults to FlexDataGridHeaderCell
			 * @return 
			 */	
@property (nonatomic, strong) FLXSClassFactory* headerCellRenderer;
/**
			 * @private 
			 * @param val
			 * 
			 */	
@property (nonatomic, assign) NSTextAlignment headerAlign;
/**
			 * @private 
			 * @param val
			 * 
			 */		
@property (nonatomic, assign) BOOL headerWordWrap;
/**
			 * @private 
			 * @param val
			 * 
			 */	
@property (nonatomic, assign) BOOL footerWordWrap;
/**
			 * @private 
			 * @param val
			 * 
			 */	
@property (nonatomic, assign) BOOL wordWrap;
/**
			 * Container for the footer renderer. Needs to inherit from FlexDataGridFooterCell.  
			 * Defaults to FlexDataGridFooterCell
			 * @return 
			 */	
@property (nonatomic, strong) FLXSClassFactory* footerCellRenderer;
/**
			 * Container for the footer renderer. Needs to inherit from FlexDataGridFooterCell.  
			 * Defaults to FlexDataGridFooterCell
			 * @return 
			 */		
@property (nonatomic, strong) FLXSClassFactory* filterCellRenderer;
/**
			 * The property to display in this column. 
			 * 
			 * If you specify a complex property ,the grid takes over the sortCompareFunction, and the sortField 
			 * property is ignored.
			 */	
@property (nonatomic, strong) NSString* dataFieldFLXS;
/**
			 *  A function that takes a IFlexDataGridCell, and returns true if this cell is editable.
			 * Use this in scenarios where some cells out of a column are not editable.
			 * @deprecated Use grid.cellEditableFunction
			 */
@property (nonatomic, strong) NSString * isEditableFunction;
/**
			 *  Flag that indicates whether the items in the column are editable.
			 */
@property (nonatomic, assign) BOOL editable;
/**
			 *  Flag that indicates whether the items in the column are selectable.
			 */
@property (nonatomic, assign) BOOL selectable;
/**
			 * Flag to enable selection of a row when a cell within that row is clicked. 
			 * You may choose to set this to false when you set selectable =true.
			 * When the user clicks on a cell, the row is automatically checked when the
			 * selection mode is either single row or multiple rows. When you have cells 
			 * that are selectable, the user may wish to select the text in the cell as opposed
			 * to selecting the row. Setting this flag to false will disable the row selection
			 * when any cell within this column is clicked.
			 * @default true
			 */	
@property (nonatomic, assign) BOOL enableCellClickRowSelect;
/**
			 * For grouped datagrids, when a single column represents entities from various nest levels, its nice 
			 * to visually indent them. Set this parameter to true for such columns
			 * If you wish to programatically control the padding, you could do so via the rendererInitialized event on the grid.
			 * @default true
			 */	
@property (nonatomic, assign) BOOL enableHierarchicalNestIndent;
/**
			 * If this propery is true, the text that does not fit in the available size
			 * is truncated with "...".
			 */
@property (nonatomic, assign) BOOL truncateToFit;
/**
			 *  The class factory for item renderer instances that display the 
			 *  column header for the column.
			 */
@property (nonatomic, strong) FLXSClassFactory* headerRenderer;
/**
			 *  Text for the header of this column. By default, the DataGrid
			 *  control uses the value of the <code>dataFieldFLXS</code> property
			 *  as the header text.
			 *  
			 */
@property (nonatomic, strong) NSString* headerText;
/**
			 * Tooltip to apply to the header. Setting this at runtime has no effect, need to set it before init.
			 * If you set it after, call rebuild.
			 */
@property (nonatomic, strong) NSString* headerToolTip;
/**
			 * A key used to uniquely identify a column. Defaults to the header text			 
			 * Used in print and preference persistence to identify columns. 
			 * @return 
			 */
@property (nonatomic, strong) NSString* uniqueIdentifier;
/**
			 *  A function that determines the text to display in this column. 
			 */
@property (nonatomic, strong) NSString* labelFunction;
/**
			 * A specialized function that determines the text to display in this column, and takes the actual cell being evaluated as a parameter. 
			 * 
			 * As opposed to the regular label function, this actually takes a FlexDataGridCell object as a parameter, 
			 * which contains the level information if you need to perform additonal logic. Please note, the cell parameter will be null in certain cases,
			 * like from the quickFind() method, where the cell is not currently drawn.
			 * 
			 * Example:
			 * labelFunction="myLabelFunc"
			 * 
			 * private function myLabelFunc(item:Object,col:FlexDataGridColumn, cell:FlexDataGridCell=null):String{
			 * } 
			 */
@property (nonatomic, strong) NSString* labelFunction2;
/**
			 * For support in pickers 
			 * @return 
			 * 
			 */	
@property (nonatomic, readonly  )NSString* label;
/**
			 *  Flag that indicates whether the user is allowed to resize
			 *  the width of the column. Please note, left and right locked columns are not resizable
			 *  @default true
			 */
@property (nonatomic, assign) BOOL resizable;
/**
			 *  Flag that indicates whether the user is allowed to resize
			 *  the width of the column. Please note, left and right locked columns are not resizable
			 *  @default true
			 */
@property (nonatomic, assign) BOOL draggable;
/**
			 *  Flag that indicates whether the user can click on the
			 *  header of this column to sort the data provider.
			 *  @default true
			 */
@property (nonatomic, assign) BOOL sortable;
/**
			 *
			 *  A callback function that gets called when sorting the data in
			 *  the column.
			 */
@property (nonatomic, strong) NSString* sortCompareFunction;
/**
			 *  Flag that indicates whether the column is visible.
			 *  If <code>true</code>, the column is visible.
			 *  @default true
			 */
@property (nonatomic, assign) BOOL visible;
@property (nonatomic, assign) float lastVisibleWidth;
/**
			 * Current X position of this column relative to the container for its cells. 
			 */
@property (nonatomic, assign) float x;
/**
			 *  The width of the column, in pixels. 
			 *  @default 100
			 *  
			 */
@property (nonatomic, assign) float width;
/**
			 * The mininum width that a column can receive.
			 * 
			 * After all calculations are made, it could result in some columns being squished beyond a certain value, where they're hardly visible.
			 * Setting a value for this property ensure this does not happen.
			 */	
@property (nonatomic, assign) float minWidth;

			/**
			 * @private 
			 * @param func
			 */	
@property (nonatomic, strong) NSString*  footerLabelFunction2;
/**
			 * For datagrids where there are multiple columns with the same header text,
			 * this field may be specified so that the persistence mechanism does not
			 * overwrite it.
			 *
			 * @deprecated - now defaults to the uniqueIdentifier.
			 */
@property (nonatomic, strong) NSString* persistenceKey;
/**
			 * @private 
			 * @param val
			 * 
			 */	
@property (nonatomic, assign) float filterComboBoxWidth;
/**
			 * Not supported
			 */	
@property (nonatomic, assign) BOOL useCurrentDataProviderForFilterComboBoxValues;
/**
			 * A function that can be used to control the enabled flag of each cell in this column. 
			 * If this function is null or returns null, the cell will be enabled, selectable, and rollovers
			 * will work. If this function returns false, the cell will not be selectable, the item renderers will
			 * be disabled and it will have no rollovers.
			 * This function should take a IFlexDataGridDataCell 
			 * object, which has a pointer to the row data (data) as well as other related information
			 * found in the documentation of the FlexDataGridDataCell class. This function
			 * should true or false.
			 */
@property (nonatomic, strong) NSString*  cellDisabledFunction;
/**
			 * A function that can be used to control the Text color of each cell in this column. 
			 * If this function is null or returns null, the cell Text will
			 * use the alternatingTextColors style property. This function should take a IFlexDataGridDataCell 
			 * object, which has a pointer to the row data (data) as well as other related information
			 * found in the documentation of the FlexDataGridDataCell class. This function
			 * should return  a single color hex code (uint).
			 * 
			 * @deprecated. Use the grid.cellTextColorFunction instead.
			 */
@property (nonatomic, strong) NSString*  cellTextColorFunction;
/**
			 * A function that lets you control the border drawing mechanism for each cell.
			 * By default, each cell will draw a 1px wide line to its right (if XXXXVerticalGridLines=true) 
			 * and bottom (if XXXXhorizontalGridLines=true) ends. 
			 * 
			 * This function offers you the opportunity to hook into this mechanism, and draw 
			 * your own border using the graphics property of the FlexDataGridCell object,
			 * that is passed in as a parameter to this function. If this function returns false,
			 * the default border is not drawn.
			 */
@property (nonatomic, strong) NSString*  cellBorderFunction;
/**
			 * A function that can be used to control the background color of each cell in this column. 
			 * If this function is null or returns null, the cell  will
			 * use the alternatingItemColors style property. This function should take a IFlexDataGridDataCell 
			 * object, which has a pointer to the row data (data) as well as other related information
			 * found in the documentation of the FlexDataGridDataCell class. This function
			 * should return an array of colors for a gradient fill, or a single color 
			 * hex code (uint) for a single color fill.
			 * 
			 * @deprecated Use the grid.cellBackgroundColorFunction instead.
			 */
@property (nonatomic, strong) NSString*  cellBackgroundColorFunction;
/**
			 * A function that lets you control the background drawing mechanism for each cell.
			 * By default, each cell will draw a background on basis of the XXXXColors style property
			 * and XXXXRollOverColors style property, where XXXX= header,filter,pager,footer,renderer or blank.
			 * 
			 * This function offers you the opportunity to hook into this mechanism, and draw 
			 * your own background using the graphics property of the FlexDataGridCell object,
			 * that is passed in as a parameter to this function. If this function returns false,
			 * the default background is not drawn.
			 */
@property (nonatomic, strong) NSString*  cellCustomDrawFunction;
/**
			 * @private 
			 * @param val
			 * 
			 */	
@property (nonatomic, strong) NSString* columnLockMode;
/**
			 * Whether or not to include the header text in the calculation of the column width.
			 * @default false
			 */	
@property (nonatomic, assign) BOOL columnWidthModeFitToContentExcludeHeader;
/**
			 * @private 
			 * @param val
			 */	
@property (nonatomic, assign) float columnWidthOffset;
/**
			 * The columnWidthMode property on the column specifies how the column widths are applied. This property defaults to "none". 
			 * 
			 * Flexicious Ultimate provides a rich mechanism to control column widths. Column widths are a complicated
			 * topic because there are a number of scenarios and rules that we need to account for 
			 * 
			 * <ul>
			 * <li>When there is a horizontal scroll (horizontalScrollPolicy=on or auto):
			 * In this case, the columns are free to take as much width as they need. Below is how the column widths should 
			 * handle in this case:
			 * <ul>
			 * <li>When columnWidthMode=none or fixed: The column will basically take the width specified by the width property</li>
			 * <li>When columnWidthMode=fitToContent The column will take the width calculated by its contents. The grid identifies the longest 
			 * string to be displayed in this column, and sets the width of the column to this value.</li>
			 * <li>When columnWidthMode=percent. This is not a valid setting when horizontalScrollPolicy is on or auto. 
			 * The setting will be ignored and the column will take the width specified by the width property.
			 * When horizontalScrollPolicy is set to auto or on,
			 * columnWidthMode=percent holds no meaning, since there are no fixed bounds to squish the columns within.</li>
			 * </ul>
			 * </li>
			 * <li>When there is no horizontal scroll (horizontalScrollPolicy=off - this is the default):
			 * <ul>
			 * <li>When columnWidthMode=none: The column will take the width specified by the width property, and adjust for width (see sum of Column Widths exceeds Grid Width below).</li>
			 * <li>When columnWidthMode=fixed: The column will  take the width specified by the width property, and not adjust for width.</li>
			 * <li>When columnWidthMode=fitToContent: The column will take the width calculated by its contents, and adjust for width (see sum of Column Widths exceeds Grid Width below).</li>
			 * <li>When columnWidthMode=percent: For these columns, the grid divides the remaining width after allocating
			 * all fixed and fitToContent columns, on a percentage basis among all columns that have 
			 * columnWidthMode set to percent. PLEASE NOTE : If you set columnWidthMode='percent', also
			 * set percentWidth. Also, ensure that the percentWidth of the columns adds up to a 100.</li>
			 * </ul>
			 * </li>
			 * </ul>
			 * 
			 * Finally, there are the below calculations once the column widths are allocated:
			 * 
			 * <ul>
			 * <li>Grid Width exceeds Sum of Column Widths:
			 * The situation where the calcualted column widths do not add upto the grid with is also handled on basis of 
			 * the horizontalScrollPolicy.
			 * <ul>
			 * <li>When there is a horizontal scroll (horizontalScrollPolicy=on or auto): The last column extends to fill up all the remaining space. If you do not want your last column to resize, add a dummy column that has the following property (order is important) minWidth="1" width="1" paddingLeft="0" paddingRight="0"</li>
			 * <li>When there is no horizontal scroll (horizontalScrollPolicy=off - this is the default): The extra width is divided proportionally between all the columns where columnWidthMode does not equal fixed.</li>
			 * </ul>
			 * </li>
			 * </ul>
			 * 
			 * <ul>
			 * <li>Sum of Column Widths exceeds Grid Width: 
			 * Similarly, The situation where the allocated column widths exceed the width of the grid with is also handled on basis of 
			 * the horizontalScrollPolicy.
			 * <ul>
			 * <li>When there is a horizontal scroll (horizontalScrollPolicy=on or auto): We simply show a scroll bar, and no column widths are changed.</li>
			 * <li>When there is no horizontal scroll (horizontalScrollPolicy=off - this is the default): This excess width
			 * is reduced proportionally between columns where columnWidthMode does not equal fixed.</li>
			 * </ul>
			 * </li>
			 * </ul>
			 * Left and right locked columns do not support column width mode, it is ignored for these. 
			 * <br/>
			 * Finally, with multi level grids, if the hierarchy's columns width in the top level is smaller than the next level's width 
			 * (and the horizontal scroll policy of the grid is "on"/"auto"), the horizontal scroller will be calculated only by the top 
			 * level's width, making some columns in the next level unreachable. The recommendation is to give a large column width to the last top level column, 
			 * which is large enough so that sum of column widths at top level is larger than the sum of column widths at the bottom level.
			 * <br/>
			 * Values : none,fixed,percent,fitToContent
			 * @default auto
			 */	
@property (nonatomic, strong) NSString* columnWidthMode;
/**
			 * The group, if any that this column belongs to.
			 */	
@property (nonatomic, weak) FLXSFlexDataGridColumnGroup* columnGroup;
/**
			 * For filterControl=textInput, if you specify an Filter Icon Style, setting this variable to 
			 * true will clear the text on icon click.
			 * Used for a "clear" icon.
			 */
@property (nonatomic, assign) BOOL clearFilterOnIconClick;
/**
			 * For filterControl=textInput, if you specify an Filter Icon Style, setting this variable to 
			 * true will clear show the icon only when there is text in the box.
			 */
@property (nonatomic, assign) BOOL showClearIconWhenHasText;
/**
			 * @private
			 */
@property (nonatomic, assign) BOOL enableFilterAutoComplete;
/**
			 * For list based item editors, setting this flag will use the dataprovider from the 
			 * filter mechanism for the item editor.
			 */
@property (nonatomic, assign) BOOL useFilterDataProviderForItemEditor;
/**
			 * In Edit mode, we only apply the new value to the model object when the user
			 * either hits the enter key or the tab key after typing input. This works fine
			 * for most cases, but for ItemEditors like date fields or Select Boxes, you may wish to
			 * apply the value on Change. In this case, set this flag to true.
			 */
@property (nonatomic, assign) BOOL itemEditorApplyOnValueCommit;
/**
			 * Flag to enable/disable icons within this cell.<br/>
			 * For columns that have icons (with or without text), you can <br>
			 * <ul>
			 * <li>Set enableIcons=true.</li>
			 * <li>If it will be the same icon for each cell, just set the "icon" style property on the column.</li>
			 * <li>If it will be different icons based on some logic, you can either provide that via the iconField property, or specify an iconFunction.</li>
			 * <li>If the cell will contain just an icon and no text, then set hideText/hideHeaderText to true.</li>
			 * <li>If the header also needs an icon, use the headerIconUrl property.</li>
			 * <li>Specify (iconLeft or iconRight) and (iconTop or iconBottom). If not specified, icon will be placed to the right middle of the cell.</li>
			 * <li>If needed, Wire up the iconClick or iconMouseOver (delay)/iconMouseOut, and specify iconMouseOverDelay (default 250 msec).</li>
			 * <li>Set enableIconHandCursor if needed.</li>
			 * <li>Set the iconTooltip, iconTooltipFunction, iconTooltipRenderer (for custom interactive popovers) as needed.</li>
			 * <li>Set the showIconOnRowHover and showIconOnCellHover as needed (If you only wish to show the icon when the user hovers over the cell or the row.</li>
			 * </ul>
			 */
@property (nonatomic, assign) BOOL enableIcon;
/**
			 * The property on the model object that returns the url to the icon, 
			 * if you wish to show different icons for each cell. 
			 * 
			 * Defaults to data field. If there are scenarios where you wish to  
			 * show both the icon as well as the text, you can specify the iconField
			 * and the dataFieldFLXS. Otherwise, where you show just the icon, you can leave the
			 * iconField blank and have the data field specify the value of the icon
			 * url.
			 */
@property (nonatomic, strong) NSString* iconField;
/**
			 * If enableIcon=true, icon function for the icon. 
			 * Default implementation has the following logic:<br/>
			 * 1) If this is a header cell, returns the value of the headerIcon style property<br/>
			 * 2) Else if this is a data cell, and the value of either the icon,overIcon or disabledIcon style property on basis of the passed in state is available, returns it.<br/>
			 * 3) Else if this is a data cell, and the iconField is not empty, returns the value of the iconField for the row data<br/>
			 * Should take an IFlexDataGridCell object.<br/>
			 */
@property (nonatomic, strong) NSString*  iconFunction;
/**
			 * The delay to wait until dispatching the iconMouseOver event when the user mouse the mouse over the icon. 
			 * Defaults to 500
			 */
@property (nonatomic, assign) float iconMouseOverDelay;
/**
			 * If enableIcon=true, enables hand cursor on the icon 
			 */
@property (nonatomic, assign) BOOL iconHandCursor;
/**
			 * If enableIcon=true, tooltip for the icon
			 */
@property (nonatomic, strong) NSString* iconToolTip;
/**
			 * The renderer factory for the icon tooltip. Defaults to null. 
			 * If null, we simply show a string tooltip, else we call the showtooltip function on the grid passing in an instance of the class factory specified here. 
			 */	
 @property (nonatomic, strong) FLXSClassFactory* iconTooltipRenderer;
/**
 Not applicable to touch oriented devices
 */
@property (nonatomic, assign) BOOL showIconOnRowHover;
/**
 Not applicable to touch oriented devices
 */
@property (nonatomic, assign) BOOL showIconOnCellHover;
/**
			 * In scenarios where you only want to display the icon, set enableIcon=true, and hideText=true; 
			 */	
@property (nonatomic, assign) BOOL hideText;
/**
			 * The header text is used in the column picker, export, etc. However, if you do not wish for it to be displayed in the view, set this to true. Used for IconColumns.
			 */
@property (nonatomic, assign) BOOL hideHeaderText;
/**
			 * To sort this column insensitive of case. Only set this to true for string data, if you set this to true for numeric or date data, the sort results will be incorrect.
			 */
@property (nonatomic, assign) BOOL sortCaseInsensitive;
	
			 /**
			 * To sort this column numerically.
			 */	
@property (nonatomic, assign) BOOL sortNumeric;
/**
			 * For Grouped datagrids, searching on this column will cause match current item, as well as any of its children. If any children match, this item matches as well.
			 */	
@property (nonatomic, assign) BOOL enableRecursiveSearch;
/**
			 * For hierarchical datagrids, instead of having a separate column for icons,
 			 * this flag will be used to embed an icon based on disclosureOpenIcon and disclosureClosedIcon
			 * within this column that will control the expand collapse of the row.
			 * */
@property (nonatomic, assign) BOOL enableExpandCollapseIcon;
/**
			 *  Performance optimization, is set to true if there is a complex fieldname or a labelFunction or labelFunction2
			 */		
@property (nonatomic, assign) BOOL hasComplexDisplay;
/**
			 * A function that takes an item, and a filterExpression, and returns true or false on basis of whether the provided
			 * item matches the filterExpression. Please note, the filterExpression has a pointer to the iFilterControl that it was created from. 
			 */	
@property (nonatomic, strong) NSString* filterCompareFunction;
/**
			 * A function that takes an item, and returns a processed value for comparison. For example, if your backend sends down strings that represents a date, 
			 * wire this function up and return a date object for comparison purposes.
			 */
@property (nonatomic, strong) NSString* filterConverterFunction;
/**
			 * Prior to dispatching the icon roll over, we use a timer so accidental roll over does not cause popups.  But sometimes you need this behavior, for example for custom cursors overicons. set this to false in that case
			 */	
@property (nonatomic, assign) BOOL useIconRollOverTimer;
@property (nonatomic, assign) BOOL enableDataCellOptimization;
/**
			 * Used by the doFormat method.
			 * Formatter to use when format not equals none. On basis of format, a new formatter 
			 * is initialized. If you wish to override the format of the default formatter,
			 * you can provide your own formatter here.
			 */
@property (nonatomic, strong) NSObject* formatter;
@property (nonatomic, weak) FLXSFlexDataGridColumnLevel* level;
/**
			 * Added to avoid flicker 
			 */
@property (nonatomic, assign) BOOL enableLocalStyles;
/**
			 * Value for the blank item in multi select combobox filter control
			 * Please note, there is a space in the front of this string so it shows up 
			 * right below the "All" option.
			 */		
@property (nonatomic, strong) NSString* blankValuesLabel;
/**
			 * A list of ToolbarActions to show when the user hovers their mouse over the header cell of this column. 
			 * Defaults to ColumnHeaderOperationBehavior.DEFAULT_COLUMN_HEADER_OPERATIONS.
			 */	
@property (nonatomic, strong) NSArray* headerMenuActions;
/**
			 * The height on basis of the data to be displayed. If there is a header  renderer, or if there is headerWordWrap
			 * we calulate this, otherwise, it is set to what ever the levels.rowHeight is.
			 */
@property (nonatomic, assign) float calculatedHeaderHeight;
/**
			 * Unused, for legacy purposes only 
			 */		
@property (nonatomic, strong) NSString*clickBehavior;
			/**
			 *  @copy mx.core.IVisualElement#owner
			 *  
			 *  @langversion 3.0
			 *  @playerversion Flash 10
			 *  @playerversion AIR 1.1
			 *  @productversion Flex 4
			 */
@property (nonatomic, readonly  ) UIView    *owner;
@property (nonatomic, strong)NSMutableArray* columns;

/**
         *  Background color, the color of the fill area.
         * [Style(name="backgroundColor",  type="Array", arrayType="uint", format="Color", inherit="no")]
         */

@property (nonatomic, strong) NSArray* backgroundColor;
/**
 *  Color of text in the component, including the component label.
 *
 *  The default value for the Halo theme is <code>0x0B333C</code>.
 *  The default value for the Spark theme is <code>0x000000</code>.
 *
 * [Style(name="color", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* color;
/**
 *  Color of text in the component if it is disabled.
 *
 *  @default 0xAAB3B3
 * [Style(name="disabledColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* disabledColor;
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
 */

@property (nonatomic, strong) NSString* textAlign;
@property (nonatomic, assign)float multiColumnSortNumberWidth;
/**
 *  The height of  the numeric value representing the order of the column sort.
 *  @default 15
 *
 * [Style(name="multiColumnSortNumberHeight", type="Number", inherit="no")]
 */

@property (nonatomic, assign) float multiColumnSortNumberHeight;
/**
 *  The name of a CSS style declaration for controlling other aspects of
 *  the appearance of the numeric value representing the order of the column sort.
 *  @default "multiColumnSortNumberStyle"
 *
 * [Style(name="multiColumnSortNumberStyleName", type="String", inherit="no")]
 */

@property (nonatomic, strong) NSString* multiColumnSortNumberStyleName;
/**
 *  The name of a CSS style declaration for controlling other aspects of
 *  the appearance of the column groups.
 *  @default "columnGroupStyle"
 *
 * [Style(name="columnGroupStyleName", type="String", inherit="no")]
 */

@property (nonatomic, strong) FLXSFontInfo* columnGroupStyleName;
/**
 *  The name of a CSS style declaration for controlling other aspects of
 *  the appearance of the column headers.
 *  @default "dataGridStyles"
 *
 * [Style(name="headerStyleName", type="String", inherit="no")]
 */

@property (nonatomic, strong) FLXSFontInfo* headerStyleName;
/**
 *  The name of a CSS style declaration for controlling other aspects of
 *  the appearance of the column headers.
 *  @default "dataGridStyles"
 * [Style(name="footerStyleName", type="String", inherit="no")]
 */

@property (nonatomic, strong) FLXSFontInfo* footerStyleName;
/**
 *  Flag that indicates whether to show vertical grid lines between
 *  the columns.
 *  If <code>true</code>, shows vertical grid lines.
 *  If <code>false</code>, hides vertical grid lines.
 *  @default true
 * [Style(name="verticalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL verticalGridLines;
/**
 *  Flag that indicates whether to show horizontal grid lines between
 *  the rows.
 *  If <code>true</code>, shows horizontal grid lines.
 *  If <code>false</code>, hides horizontal grid lines.
 *  @default false
 * [Style(name="horizontalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL horizontalGridLines;
/**
 *  The color of the vertical grid lines.
 *  @default 0x666666
 * [Style(name="verticalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* verticalGridLineColor;
/**
 *  The color of the horizontal grid lines.
 * [Style(name="horizontalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* horizontalGridLineColor;
/**
 *  Thickness of the horizontal grid lines.
 *  @default 1
 * [Style(name="horizontalGridLineThickness", type="Number", format="Length", inherit="yes")]
 */

@property (nonatomic, assign) float horizontalGridLineThickness;
/**
 *  Thickness of the vertical grid lines.
 *  @default 1
 * [Style(name="verticalGridLineThickness", type="Number", format="Length", inherit="yes")]
 */

@property (nonatomic, assign) float verticalGridLineThickness;
/**
 *  Flag that indicates whether to show vertical grid lines between
 *  the columns.
 *  If <code>true</code>, shows vertical grid lines.
 *  If <code>false</code>, hides vertical grid lines.
 *  @default true
 * [Style(name="headerVerticalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL headerVerticalGridLines;
/**
 *  Flag that indicates whether to show horizontal grid lines between
 *  the rows.
 *  If <code>true</code>, shows horizontal grid lines.
 *  If <code>false</code>, hides horizontal grid lines.
 *  @default false
 * [Style(name="headerHorizontalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL headerHorizontalGridLines;
/**
 *  The color of the vertical grid lines.
 *  @default 0x666666
 * [Style(name="headerVerticalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* headerVerticalGridLineColor;
/**
 *  The color of the horizontal grid lines.
 * [Style(name="headerHorizontalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic,strong) UIColor* headerHorizontalGridLineColor;
/**
 *  Thickness of the header horizontal grid lines.
 *  @default 1
 * [Style(name="headerHorizontalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float headerHorizontalGridLineThickness;
/**
 *  Thickness of the header vertical grid lines.
 *  @default 1
 * [Style(name="headerVerticalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float headerVerticalGridLineThickness;
/**
 *  Flag that indicates whether to force the top border
 *  @default false
 * [Style(name="headerDrawTopBorder", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL headerDrawTopBorder;
/**
 *  Flag that indicates whether to show vertical grid lines between
 *  the columns.
 *  If <code>true</code>, shows vertical grid lines.
 *  If <code>false</code>, hides vertical grid lines.
 *  @default true
 * [Style(name="columnGroupVerticalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL columnGroupVerticalGridLines;
/**
 *  Flag that indicates whether to show horizontal grid lines between
 *  the rows.
 *  If <code>true</code>, shows horizontal grid lines.
 *  If <code>false</code>, hides horizontal grid lines.
 *  @default false
 * [Style(name="columnGroupHorizontalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL columnGroupHorizontalGridLines;
/**
 *  The color of the vertical grid lines.
 *  @default 0x666666
 * [Style(name="columnGroupVerticalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic,strong) UIColor* columnGroupVerticalGridLineColor;
/**
 *  The color of the horizontal grid lines.
 * [Style(name="columnGroupHorizontalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* columnGroupHorizontalGridLineColor;
/**
 *  Thickness of the header horizontal grid lines.
 *  @default 1
 * [Style(name="columnGroupHorizontalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float columnGroupHorizontalGridLineThickness;
/**
 *  Thickness of the header vertical grid lines.
 *  @default 1
 * [Style(name="columnGroupVerticalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float columnGroupVerticalGridLineThickness;
/**
 *  Flag that indicates whether to force the top border
 *  @default false
 * [Style(name="columnGroupDrawTopBorder", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL columnGroupDrawTopBorder;
/**
 *  Flag that indicates whether to show vertical grid lines between
 *  the columns.
 *  If <code>true</code>, shows vertical grid lines.
 *  If <code>false</code>, hides vertical grid lines.
 *  @default true
 * [Style(name="filterVerticalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL filterVerticalGridLines;
/**
 *  Flag that indicates whether to show horizontal grid lines between
 *  the rows.
 *  If <code>true</code>, shows horizontal grid lines.
 *  If <code>false</code>, hides horizontal grid lines.
 *  @default false
 * [Style(name="filterHorizontalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL filterHorizontalGridLines;
/**
 *  The color of the vertical grid lines.
 *  @default 0x666666
 * [Style(name="filterVerticalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* filterVerticalGridLineColor;
/**
 *  The color of the horizontal grid lines.
 * [Style(name="filterHorizontalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* filterHorizontalGridLineColor;
/**
 *  Thickness of the filter horizontal grid lines.
 *  @default 1
 * [Style(name="filterHorizontalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float filterHorizontalGridLineThickness;
/**
 *  Thickness of the filter vertical grid lines.
 *  @default 1
 * [Style(name="filterVerticalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float filterVerticalGridLineThickness;
/**
 *  Flag that indicates whether to force the top border, when horizontal gridlines are not drawn
 *  @default false
 * [Style(name="filterDrawTopBorder", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL filterDrawTopBorder;
/**
 *  Flag that indicates whether to show vertical grid lines between
 *  the columns.
 *  If <code>true</code>, shows vertical grid lines.
 *  If <code>false</code>, hides vertical grid lines.
 *  @default true
 * [Style(name="footerVerticalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL footerVerticalGridLines;
/**
 *  Flag that indicates whether to show horizontal grid lines between
 *  the rows.
 *  If <code>true</code>, shows horizontal grid lines.
 *  If <code>false</code>, hides horizontal grid lines.
 *  @default false
 * [Style(name="footerHorizontalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL footerHorizontalGridLines;
/**
 *  The color of the vertical grid lines.
 *  @default 0x666666
 * [Style(name="footerVerticalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* footerVerticalGridLineColor;
/**
 *  The color of the horizontal grid lines.
 * [Style(name="footerHorizontalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* footerHorizontalGridLineColor;
/**
 *  Thickness of the footer horizontal grid lines.
 *  @default 1
 * [Style(name="footerHorizontalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float footerHorizontalGridLineThickness;
/**
 *  Thickness of the footer vertical grid lines.
 *  @default 1
 * [Style(name="footerVerticalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float footerVerticalGridLineThickness;
/**
 *  Flag that indicates whether to force the top border, when horizontal gridlines are not drawn
 *  @default false
 * [Style(name="footerDrawTopBorder", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL footerDrawTopBorder;
/**
 *  Flag that indicates whether to show vertical grid lines between
 *  the columns.
 *  If <code>true</code>, shows vertical grid lines.
 *  If <code>false</code>, hides vertical grid lines.
 *  @default true
 * [Style(name="pagerVerticalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL pagerVerticalGridLines;
/**
 *  Flag that indicates whether to show horizontal grid lines between
 *  the rows.
 *  If <code>true</code>, shows horizontal grid lines.
 *  If <code>false</code>, hides horizontal grid lines.
 *  @default false
 * [Style(name="pagerHorizontalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL pagerHorizontalGridLines;
/**
 *  The color of the vertical grid lines.
 *  @default 0x666666
 * [Style(name="pagerVerticalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* pagerVerticalGridLineColor;
/**
 *  The color of the horizontal grid lines.
 * [Style(name="pagerHorizontalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* pagerHorizontalGridLineColor;
/**
 *  Thickness of the pager horizontal grid lines.
 *  @default 1
 * [Style(name="pagerHorizontalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float pagerHorizontalGridLineThickness;
/**
 *  Thickness of the pager vertical grid lines.
 *  @default 1
 * [Style(name="pagerVerticalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float pagerVerticalGridLineThickness;
/**
 *  Flag that indicates whether to force the top border, when horizontal gridlines are not drawn
 *  @default false
 * [Style(name="pagerDrawTopBorder", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL pagerDrawTopBorder;
/**
 *  Flag that indicates whether to show vertical grid lines between
 *  the columns.
 *  If <code>true</code>, shows vertical grid lines.
 *  If <code>false</code>, hides vertical grid lines.
 *  @default true
 * [Style(name="rendererVerticalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL rendererVerticalGridLines;
/**
 *  Flag that indicates whether to show horizontal grid lines between
 *  the rows.
 *  If <code>true</code>, shows horizontal grid lines.
 *  If <code>false</code>, hides horizontal grid lines.
 *  @default false
 * [Style(name="rendererHorizontalGridLines", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL rendererHorizontalGridLines;
/**
 *  The color of the vertical grid lines.
 *  @default 0x666666
 * [Style(name="rendererVerticalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* rendererVerticalGridLineColor;
/**
 *  The color of the horizontal grid lines.
 * [Style(name="rendererHorizontalGridLineColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* rendererHorizontalGridLineColor;
/**
 *  Thickness of the renderer horizontal grid lines.
 *  @default 1
 * [Style(name="rendererHorizontalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float rendererHorizontalGridLineThickness;
/**
 *  Thickness of the renderer vertical grid lines.
 *  @default 1
 * [Style(name="rendererVerticalGridLineThickness", type="Number", format="Length")]
 */

@property (nonatomic, assign) float rendererVerticalGridLineThickness;
/**
 *  Flag that indicates whether to force the top border, when horizontal gridlines are not drawn
 *  @default false
 * [Style(name="rendererDrawTopBorder", type="Boolean", inherit="no")]
 */

@property (nonatomic, assign) BOOL rendererDrawTopBorder;
/*
 *  The color of the background for the row when the user selects
 *  an item renderer in the row.
 *
 *  The default value for the Halo theme is <code>0x7FCEFF</code>.
 *  The default value for the Spark theme is <code>0xA8C6EE</code>.
 * [Style(name="selectionColorFLXS", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor*selectionColorFLXS;

/**
 *  The class to use as the skin for the arrow that indicates the column sort
 *  direction.
 *  The default value for the Halo theme is <code>mx.skins.halo.DataGridSortArrow</code>.
 *  The default value for the Spark theme is <code>mx.skins.spark.DataGridSortArrow</code>.
 * [Style(name="sortArrowSkin", type="Class", inherit="no")]
 */

@property (nonatomic, assign)Class* sortArrowSkin;
/**
 *  Number of pixels between the controls left border
 *  and the left edge of its content area.
 *
 *  @default 1
 * [Style(name="paddingLeft", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float paddingLeft;
/**
 *  Number of pixels between the controls right border
 *  and the right edge of its content area.
 *
 *  @default 0
 * [Style(name="paddingRight", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float paddingRight;
/**
 *  Number of pixels between the controls left border
 *  and the left edge of its content area.
 *
 *  @default 2
 * [Style(name="paddingTop", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float paddingTop;
/**
 *  Number of pixels between the controls right border
 *  and the right edge of its content area.
 *
 *  @default 2
 * [Style(name="paddingBottomFLXS", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float paddingBottomFLXS;
/**
 *  Number of pixels between the controls left border
 *  and the left edge of its content area.
 *
 *  @default 1
 * [Style(name="headerPaddingLeft", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float headerPaddingLeft;
/**
 *  Number of pixels between the controls right border
 *  and the right edge of its content area.
 *
 *  @default 0
 * [Style(name="headerPaddingRight", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float headerPaddingRight;
/**
 *  Number of pixels between the controls left border
 *  and the left edge of its content area.
 *
 *  @default 2
 * [Style(name="headerPaddingTop", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float headerPaddingTop;
/**
 *  Number of pixels between the controls right border
 *  and the right edge of its content area.
 *
 *  @default 2
 * [Style(name="headerPaddingBottom", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float headerPaddingBottom;
/**
 *  Number of pixels between the controls left border
 *  and the left edge of its content area.
 *
 *  @default 1
 * [Style(name="footerPaddingLeft", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float footerPaddingLeft;
/**
 *  Number of pixels between the controls right border
 *  and the right edge of its content area.
 *
 *  @default 0
 * [Style(name="footerPaddingRight", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic,  assign) float footerPaddingRight;
/**
 *  Number of pixels between the controls left border
 *  and the left edge of its content area.
 *
 *  @default 2
 * [Style(name="footerPaddingTop", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float footerPaddingTop;
/**
 *  Number of pixels between the controls right border
 *  and the right edge of its content area.
 *
 *  @default 2
 * [Style(name="footerPaddingBottom", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float footerPaddingBottom;
/**
 *  Number of pixels between the controls left border
 *  and the left edge of its content area.
 *
 *  @default 1
 * [Style(name="filterPaddingLeft", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float filterPaddingLeft;
/**
 *  Number of pixels between the controls right border
 *  and the right edge of its content area.
 *
 *  @default 0
 * [Style(name="filterPaddingRight", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float filterPaddingRight;
/**
 *  Number of pixels between the controls left border
 *  and the left edge of its content area.
 *
 *  @default 2
 * [Style(name="filterPaddingTop", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign)float filterPaddingTop;
/**
 *  Number of pixels between the controls right border
 *  and the right edge of its content area.
 *
 *  @default 2
 * [Style(name="filterPaddingBottom", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float filterPaddingBottom;
/**
 *  Number of pixels between the controls left border
 *  and the left edge of its content area.
 *
 *  @default 1
 * [Style(name="pagerPaddingLeft", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic,  assign) float pagerPaddingLeft;
/**
 *  Number of pixels between the controls right border
 *  and the right edge of its content area.
 *
 *  @default 0
 * [Style(name="pagerPaddingRight", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float pagerPaddingRight;
/**
 *  Number of pixels between the controls left border
 *  and the left edge of its content area.
 *
 *  @default 2
 * [Style(name="pagerPaddingTop", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float pagerPaddingTop;
/**
 *  Number of pixels between the controls right border
 *  and the right edge of its content area.
 *
 *  @default 2
 * [Style(name="pagerPaddingBottom", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float pagerPaddingBottom;
/**
 *  Number of pixels between the controls left border
 *  and the left edge of its content area.
 *
 *  @default 1
 * [Style(name="rendererPaddingLeft", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float rendererPaddingLeft;
/**
 *  Number of pixels between the controls right border
 *  and the right edge of its content area.
 *
 *  @default 0
 * [Style(name="rendererPaddingRight", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float rendererPaddingRight;
/**
 *  Number of pixels between the controls left border
 *  and the left edge of its content area.
 *
 *  @default 2
 * [Style(name="rendererPaddingTop", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float rendererPaddingTop;
/**
 *  Number of pixels between the controls right border
 *  and the right edge of its content area.
 *
 *  @default 2
 * [Style(name="rendererPaddingBottom", type="Number", format="Length", inherit="no")]
 */

@property (nonatomic, assign) float rendererPaddingBottom;
/**
 *  The colors to use for the backgrounds of the items in the grid.
 *  The value is an array of two or more colors.
 *  The backgrounds of the list items alternate among the colors in the array.
 *  @default undefined
 * [Style(name="alternatingItemColors", type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray* alternatingItemColors;
/**
 *  The colors to use for the text of the items in the grid.
 *  The value is an array of two colors.
 *  The text color of the list items alternate among the colors in the array.
 *  @default [ #000000, #000000]
 * [Style(name="alternatingTextColors", type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray* alternatingTextColors;
/**
 *  The colors to use for the backgrounds of the items in the grid in the editable mode.
 *  The value is an array two colors.
 *  @default undefined
 * [Style(name="editItemColor", type="Array", arrayType="uint", format="Color")]
 */

@property (nonatomic, strong) NSArray* editItemColor;
/**
 *  The colors to use for the text of the items in the editable grid.
 * [Style(name="editTextColor", format="Color")]
 */

@property (nonatomic, strong) UIColor* editTextColor;

/**
 *  The color of the background of a renderer when the component is disabled.
 *  @default null
 * [Style(name="selectionDisabledColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* selectionDisabledColor;
/**
 *  The icon that is displayed next to an open branch node of the navigation tree.
 *  The default value is <code>TreeDisclosureOpen</code> in the assets.swf file.
 * [Style(name="disclosureOpenIcon", type="Class", format="EmbeddedFile", inherit="no")]
 */

@property (nonatomic, assign) Class* disclosureOpenIcon;
/**
 *  The icon that is displayed next to a closed branch node of the navigation tree.
 *
 *  The default value is <code>TreeDisclosureClosed</code> in the assets.swf file.
 * [Style(name="disclosureClosedIcon", type="Class", format="EmbeddedFile", inherit="no")]
 */

@property (nonatomic, assign) Class* disclosureClosedIcon;
/**
 *  The icon that is displayed next to an open column group.
 *
 *  The default value is <code>TreeDisclosureOpen</code> in the assets.swf file.
 * [Style(name="columnGroupOpenIcon", type="Class", format="EmbeddedFile", inherit="no")]
 */

@property (nonatomic, assign) Class* columnGroupOpenIcon;
/**
 *  The icon that is displayed next to a closed column group.
 *
 *  The default value is <code>TreeDisclosureClosed</code> in the assets.swf file.
 * [Style(name="columnGroupClosedIcon", type="Class", format="EmbeddedFile", inherit="no")]
 */

@property (nonatomic, assign) Class* columnGroupClosedIcon;
/**
 *  The color of the row background when the user rolls over the row.
 *
 *  The default value for the Halo theme is <code>0xB2E1FF</code>.
 *  The default value for the Spark theme is <code>0xCEDBEF</code>.
 * [Style(name="rollOverColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic,strong) UIColor* rollOverColor;
/**
 *  The color of the cell directly under the mouse or if using keyboard navigation, current keyboard seed.
 * @default #000000
 * [Style(name="activeCellColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* activeCellColor;
/**
 *  An array of two colors used to draw the footer background gradient.
 *  The first color is the top color.
 *  The second color is the bottom color.
 *  @default [0xCFCFCF, 0xCCCCCC]
 * [Style(name="footerColors", type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray* footerColors;
/**
 *  The color of the row background when the user rolls over the footer.
 *  The default value is [0xCCCCCC,0xCFCFCF]
 * [Style(name="footerRollOverColors",  type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray* footerRollOverColors;
/**
 *  The color of the row background for the filter.
 *  The default value is [0xCFCFCF,0xCFCFCF]
 * [Style(name="filterColors",  type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray* filterColors;
/**
 *  The color of the row background when the user rolls over the filter.
 *  The default value is [0xCFCFCF,0xCFCFCF]
 * [Style(name="filterRollOverColors",  type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray* filterRollOverColors;
/**
 *  An array of two colors used to draw the header background gradient.
 *  The first color is the top color.
 *  The second color is the bottom color.
 *  @default [0xFFFFFF, 0xE6E6E6]
 * [Style(name="headerColors", type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray* headerColors;
/**
 *  The color of the row background when the user rolls over the header.
 *
 *  The default value is [0xE6E6E6,0xFFFFFF]
 * [Style(name="headerRollOverColors",  type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray* headerRollOverColors;
/**
 *  An array of two colors used to draw the Column Groups background gradient.
 *  The first color is the top color.
 *  The second color is the bottom color.
 *  @default [0xFFFFFF, 0xE6E6E6]
 * [Style(name="columnGroupColors", type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray* columnGroupColors;
/**
 *  The color of the row background when the user rolls over the Column Groups.
 *
 *  The default value is [0xE6E6E6,0xFFFFFF]
 * [Style(name="columnGroupRollOverColors",  type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray* columnGroupRollOverColors;
/**
 *  An array of two colors used to draw the renderer background gradient.
 *  The first color is the top color.
 *  The second color is the bottom color.
 *  @default [0xFFFFFF, 0xFFFFFF]
 * [Style(name="rendererColors", type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray* rendererColors;
/**
 *  The color of the row background when the user rolls over a level renderer.
 *  The default value is [0xFFFFFF,0xFFFFFF]
 * * [Style(name="rendererRollOverColors", type="Array", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray* rendererRollOverColors;
/**
 *  An array of two colors used to draw the pager background gradient.
 *  The first color is the top color.
 *  The second color is the bottom color.
 *  @default [0xCCCCCC, 0xCCCCCC]
 * [Style(name="pagerColors", type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray* pagerColors;
/**
 *  The color of the row background when the user rolls over the pager.
 *  The default value is [0xE6E6E6,0xFFFFFF]
 * [Style(name="pagerRollOverColors",type="Array", arrayType="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) NSArray* pagerRollOverColors;
/**
 *  Color of the text when the user selects a row.
 *  @default 0x000000
 * [Style(name="textSelectedColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* textSelectedColor;
/**
 *  Color of the text when the user rolls over a row.
 *
 *  @default 0x000000
 * [Style(name="textRollOverColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* textRollOverColor;
/**
 *  The color of the text of a renderer when the component is disabled.
 *  @default 0xDDDDDD
 * [Style(name="textDisabledColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor*textDisabledColor;
/**
 *  The color of the cell text of each cell in this column.
 *  Usually these colors are controlled via the alternatingTextColors
 *  style property of the level or the grid. In case you wish to have this
 *  column have a specific text color, you may use this property.
 *  The default value is null
 * [Style(name="columnTextColor", type="uint", format="Color", inherit="yes")]
 */

@property (nonatomic, strong) UIColor* columnTextColor;
/**
 *  When filterControl=textInput, the icon that is displayed inside the textbox, based on the insideIconPosition property.
 * [Style(name="filterIcon")]
 */

@property (nonatomic, strong) NSString* filterIcon;
/**
 *  When filterControl=textInput, the position of the icon that is displayed inside the textbox.
 *  Default 'right'
 * [Style(name="filterIconPosition", type="String", enumeration="left,right")]
 */

@property (nonatomic, strong) NSString* filterIconPosition;
/**
 * When enableIcon=true, this property specifies the icon to display.
 * If the icon is dynamic, use the dataFieldFLXS to specify the url instead.
 * * [Style(name="icon")]
 */

@property (nonatomic, strong) NSString* icon;
/**
 * When enableIcon=true, this property specifies the icon to display.
 * If the icon is dynamic, use the dataFieldFLXS to specify the url instead.
 * * [Style(name="overIcon")]
 */

@property (nonatomic, strong) NSString* overIcon;
/**
 * When enableIcon=true, this property specifies the icon to display when enabled=false.
 * If the icon is dynamic, use the dataFieldFLXS to specify the url instead.
 * * [Style(name="disabledIcon")]
 */

@property (nonatomic, strong) NSString* disabledIcon;
/**
 * When enableIcon=true, this property specifies the icon to display.
 * If the icon is dynamic, use the dataFieldFLXS to specify the url instead.
 * * [Style(name="headerIcon")]
 */

@property (nonatomic, strong) NSString* headerIcon;
/**
 * When enableIcon=true, To position the icon correctly, you can set either iconLeft or iconRight,
 * and iconTop or iconBottom
 * [Style(name="iconLeft", type="Number")]
 */

@property (nonatomic, assign) float iconLeft;
/**
 * When enableIcon=true, To position the icon correctly, we need to know the height and width of the icon
 * Since the icon is not yet drawn, sometimes we do not know how big the icon will be. This property
 * lets you specify that.
 * [Style(name="iconWidth", type="Number")]
 */

@property (nonatomic, assign) float iconWidth;
/**
 * When enableIcon=true, To position the icon correctly, we need to know the height and width of the icon
 * Since the icon is not yet drawn, sometimes we do not know how big the icon will be. This property
 * lets you specify that.
 * [Style(name="iconHeight", type="Number")]
 */

@property (nonatomic, assign) float iconHeight;
/**
 * When enableIcon=true, To position the icon correctly, you can set either iconLeft or iconRight,
 * and iconTop or iconBottom
 * [Style(name="iconRight", type="Number")]
 */

@property (nonatomic, assign) float iconRight;
/**
 * When enableIcon=true, To position the icon correctly, you can set either iconLeft or iconRight,
 * and iconTop or iconBottom
 * [Style(name="iconTop", type="Number")]
 */

@property (nonatomic, assign) float iconTop;
/**
 * When enableIcon=true, To position the icon correctly, you can set either iconLeft or iconRight,
 * and iconTop or iconBottom
 * [Style(name="iconBottom", type="Number")]
 */

@property (nonatomic, assign) float iconBottom;
/**
 * When enableExpandCollapseIcon=true, To position the icon correctly, you can set either expandCollapseIconLeft or expandCollapseIconRight,
 * and expandCollapseIconTop or expandCollapseIconBottom
 * [Style(name="expandCollapseIconLeft", type="Number")]
 */

@property (nonatomic, assign) float expandCollapseIconLeft;
/**
 * When enableExpandCollapseIcon=true, To position the icon correctly, you can set either expandCollapseIconLeft or expandCollapseIconRight,
 * and expandCollapseIconTop or expandCollapseIconBottom
 * [Style(name="expandCollapseIconRight", type="Number")]
 */

@property (nonatomic, assign) float expandCollapseIconRight;
/**
 * When enableExpandCollapseIcon=true, To position the icon correctly, you can set either expandCollapseIconLeft or expandCollapseIconRight,
 * and expandCollapseIconTop or expandCollapseIconBottom
 * [Style(name="expandCollapseIconTop", type="Number")]
 */

@property (nonatomic, assign) float expandCollapseIconTop;
/**
 * When enableExpandCollapseIcon=true, To position the icon correctly, you can set either expandCollapseIconLeft or expandCollapseIconRight,
 * and expandCollapseIconTop or expandCollapseIconBottom
 * [Style(name="expandCollapseIconBottom", type="Number")]
 */

@property (nonatomic, assign) float expandCollapseIconBottom;
/**
 * Style to apply to the item editor.
 * [Style(name="editorStyleName", type="String")]
 */

@property (nonatomic, strong) NSString* editorStyleName;

/**
 * Used by the doFormat method.
 */
@property (nonatomic, strong) NSString* format;
/**
 * For number and currency formatters, the default number of digits after the decimal point. Defaults to 2
 */			
@property (nonatomic, assign) float formatterPrecision;
/**
 * For currency formatter, the currency symbol. Defaults to blank value.
 */			
@property (nonatomic, strong) NSString* formatterCurrencySymbol;
/**
 * For date formatters, the date format. Defaults to blank value. Initialized on basis of date format. 
 * If you wish to override the default format, you can use this string.
 */
@property (nonatomic, strong) NSString* formatterDateFormatString;
/**
 * When you set to true, a custom sortCompareFunction is applied that uses the labelFunction instead
 * of the dataFieldFLXS.
 */@property (nonatomic, assign) BOOL useLabelFunctionForSortCompare;
/**
 * The doFormat method returns formatted value on basis of the format properties (See description below)<br/> 
 * If the input is null, returns null. 
 * If there is a formatter specified, uses the formatter's format method to return a formatted value.
 * If the format property is specified and no formatter is specified, the column will instantiate 
 * a formatter on basis of the value of the format property. The property can be one of 5 constants.
 * <ul>
 * <li>date (FORMAT_DATE) - Uses the DateUtils.MEDIUM_DATE_MASK format MMM D, YYYY - Can be customized using formatterDateString Property</li>
 * <li>datetime (FORMAT_DATE_TIME) - Uses the DateUtils.LONG_DATE_MASK+ " " + DateUtils.MEDIUM_TIME_MASK format MMM D, YYYY L:NN:SS A - Can be customized using formatterDateString Property</li>
 * <li>time (FORMAT_TIME) - Uses the DateUtils.LONG_TIME_MASK format. L:NN:SS A TZD - Can be customized using formatterDateString Property</li>
 * <li>currency (FORMAT_CURRENCY) - Uses formatterCurrencySymbol and formatterPrecision properties for the currency formatter. </li>
 * <li>number (FORMAT_NUMBER) - Uses formatterPrecision properties for the number formatter.</li>
 * </ul>
 * Based on the formatter created above, the value will be returned.
 *  
 * @param retVal	String to format
 * @return 			Formatted string.
 */
-(NSString*)doFormat:(NSString*)retVal;

 -(NSString*)itemToLabel:(NSObject*)data :(UIView<FLXSIFlexDataGridCell>*)cell;
-(BOOL)isLocked;
-(BOOL)isRightLocked;
-(BOOL)isLeftLocked;
-(BOOL)isElastic;
-(BOOL)isLastLeftLocked;
-(BOOL)isLastUnLocked;
-(BOOL)isFirstUnLocked;
-(BOOL)isFirstRightLocked;
-(BOOL)isLastRightLocked;
-(FLXSFlexDataGridColumn*)getAdjacentColumn:(int)num;
-(id)getStyleValue:(NSString*)styleProp;
-(int)getIndex;
-(int)colIndex;
-(FLXSClassFactory*)deriveRenderer:(int)chromeType;

- (NSArray *)getDistinctValues:(NSArray *)dp collection:(NSMutableArray *)collection addedCodes:(NSMutableArray *)addedCodes level:(FLXSFlexDataGridColumnLevel *)lvl;
-(NSString*)itemToLabelCommon:(NSObject*)item;

- (int)nestedSortCompareFunction:(NSObject *)obj1 object2:(NSObject *)obj2;
-(NSObject*)showPopup:(NSObject*)popupData;
-(BOOL)isValidStyleValue:(id)val;

- (NSString *)defaultIconFunction:(UIView <FLXSIFlexDataGridCell> *)cell :(NSString *)state;


-(NSString*)defaultIconTooltipFunction:(UIView <FLXSIFlexDataGridCell>*)cell;
-(float)nestDepth;
-(BOOL)isSortable;


//FLXSIEventDispatcher methods
-(void)dispatchEvent:(FLXSEvent *)event;

- (void)addEventListenerOfType:(NSString *)type usingTarget:(NSObject *)target withHandler:(SEL)handler;
-(void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler;

//End FLXSIEventDispatcher methods

- (id)getStyle:(NSString *)prop;
- (void)setStyle:(NSString *)prop :(id)value;
+ (FLXSClassFactory*)static_TextInput;
+ (FLXSClassFactory*)static_selectableLabel;
+ (FLXSClassFactory*)static_UIComponent;
+ (FLXSClassFactory*)static_UILabel;
+ (FLXSClassFactory*)static_FLXSFlexDataGridDataCellUIComponent;
+ (FLXSClassFactory*)static_FLXSFlexDataGridHeaderCell;
+ (FLXSClassFactory*)static_FLXSFlexDataGridFooterCell;
+ (FLXSClassFactory*)static_FLXSFlexDataGridFilterCell;
+ (NSString*)LOCK_MODE_LEFT;
+ (NSString*)LOCK_MODE_RIGHT;
+ (NSString*)LOCK_MODE_NONE;
+ (float)DEFAULT_COLUMN_WIDTH;
+ (NSString*)COLUMN_WIDTH_MODE_NONE;
+ (NSString*)COLUMN_WIDTH_MODE_FIXED;
+ (NSString*)COLUMN_WIDTH_MODE_FIT_TO_CONTENT;
+ (NSString*)COLUMN_WIDTH_MODE_PERCENT;
@end

