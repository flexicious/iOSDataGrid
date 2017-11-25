#import "FLXSVersion.h"
#import "FLXSPoint.h"
#import "UIView+UIViewAdditions.h"
#import "FLXSIFlexDataGridCell.h"
@class FLXSFlexDataGridColumnLevel;
@class FLXSFlexDataGridColumn;
@class FLXSRowInfo;
@class FLXSComponentInfo;
@class FLXSClassFactory;
@class FLXSExpandCollapseIcon;
@class FLXSEvent;
@protocol FLXSIExpandCollapseComponent;

/**
	 * FlexDataGridCell is the container component for each of the DataGrid's cells. This is a psuedo abstract class, the cells
	 * that you see in the grid are actually one of the following subclasses of this class:
	 * <ul>
	 * <li> FlexDataGridHeaderCell</li>
	 * <li> FlexDataGridFilterCell</li>
	 * <li> FlexDataGridFooterCell</li>
	 * <li> FlexDataGridPagerCell</li>
	 * <li> FlexDataGridLevelRendererCell</li>
	 * <li> FlexDataGridExpandCollapseHeaderCell</li>
	 * <li> FlexDataGridExpandCollapseCell</li>
	 * <li> FlexDataGridPaddingCell </li>
	 * <li> FlexDataGridDataCell</li>
	 * </ul>
	 *
	 * There are two other cells types, FlexDataGridDataCell2 and FlexDataGridDataCell3 (if you set enableDataCellOptimization=true)
	 * that do not inherit from this
	 * class, but are used in lieu of FlexDataGridDataCell in Flex 4 based grids to improve performance, since they
	 * are lighter than FlexDataGridDataCell
	 *
	 * The FlexDataGridCell is responsible for sizing, positioning (based on padding), drawing the background,
	 * and drawing the borders.
	 * This class has a renderer property, which is the actual component that is displayed on the UI.
	 * In case of the Header,Data or Footer cells the default renderer is a UITextField or UIFTETextField.
	 * For Filter, it is an instance of the IFilterControl.
	 * For the Pager, it is an IPager control. For the LevelRenderer it is an instance of the Class Factory that
	 * you specify in the nextLevelRenderer of the associated column Level.
	 * For the ExpandCollapse cells, it will draw an instance of the expand collapse icon on basis of the disclosureIcon style property
	 * All the drawing happens in the drawCell method. It seperately calls the drawBackground and drawBorder methods. Usually
	 * specifying the style properties, or the cellBackgroud/rowBackground/cellBorder/rowBorder functions is sufficient, but in
	 * case its needed, these methods can be overridden in a custom implementation, and this custom implementation can then
	 * be hooked in via the dataCellRenderer, headerCellRenderer, footerCellRenderer, pagerCellRenderer, filterCellRender,
	 * expandCollapseHeaderCellRenderer,nestIndentPaddingCellRenderer, and expandCollapseCellRenderer of the column or the level.
	 *
	 * Please note, that this class is recycled, so for example, as you scroll, a FlexDataGridCell object that was
	 * displaying some other item in the data provider previously could be reused to display the current one.
	 *
	 */
@interface FLXSFlexDataGridCell : UIView<FLXSIFlexDataGridCell>
{
}

@property (nonatomic, weak) FLXSFlexDataGridColumn*columnFLXS;
@property (nonatomic, weak) FLXSFlexDataGridColumnLevel* level;
@property (nonatomic, weak) FLXSRowInfo* rowInfo;
@property (nonatomic, strong) NSObject * currentBackgroundColors;
@property (nonatomic, strong) NSObject * currentTextColors;
@property (nonatomic, weak) FLXSComponentInfo* componentInfo;
@property (nonatomic, weak) FLXSClassFactory* rendererFactory;
@property (nonatomic, weak) UIView* renderer;
@property (nonatomic, weak) UIViewController* rendererController;
@property (nonatomic, assign) BOOL destroyed;
@property (nonatomic, assign) BOOL isNewlyCreated;
@property (nonatomic, assign) BOOL moving;
@property (nonatomic, strong) UIImageView* colIcon;
@property (nonatomic, assign) BOOL backgroundDirty;
@property (nonatomic, strong) NSTimer* iconTimer;
@property (nonatomic, weak) FLXSExpandCollapseIcon* expandCollapseIcon;
@property (nonatomic, strong) NSString* text;
@property (nonatomic, assign) BOOL wordWrap;
@property (nonatomic, assign) BOOL truncateToFit;
@property (nonatomic, assign) BOOL selectable;


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

@property (nonatomic, readonly) UIColor*  verticalGridLineColor ;
/**
 *  The color of the horizontal grid lines.
 * [Style(name="horizontalGridLineColor", type="uint", format="Color", inherit="yes")]
 * @type {null}
 * @property horizontalGridLineColor
 * @default null
 */

@property (nonatomic, readonly) UIColor* horizontalGridLineColor ;
/**
 *  Thickness of the horizontal grid lines.
 *  @default 1
 * [Style(name="horizontalGridLineThickness", type="Number", format="Length", inherit="yes")]
 * @type {null}
 * @property horizontalGridLineThickness
 * @default null
 */

@property (nonatomic, readonly) float horizontalGridLineThickness;
/**
 *  Thickness of the vertical grid lines.
 *  @default 1
 * [Style(name="verticalGridLineThickness", type="Number", format="Length", inherit="yes")]
 * @type {null}
 * @property verticalGridLineThickness
 * @default null
 */

@property (nonatomic, readonly) float  verticalGridLineThickness ;
@property (nonatomic, readonly) NSString* prefix;



- (void)initCommon;

-(BOOL)isNewlyCreated;
-(void)destroy;

-(void)refreshCell;
/**
		 * @private
		 */
-(void)onIconMouseOver:(FLXSEvent*)evnt;
/**
		 * @private
		 */
-(void)onIconMouseClick:(FLXSEvent*)evt;
/**
		 * @private
		 */
-(void)onTimerComplete:(NSTimer*)evt;
/**
		 * @private
		 */
-(void)onIconMouseOut:(FLXSEvent*)evnt;
/**
		 * @private
		 */
-(id)getIconUrl:(BOOL)over;
/**
		 * @copy com.flexicious.nestedtreedatagrid.cells.CellUtils#setRendererSize
		 */
- (void)setRendererSize:(UIView *)cellRenderer width:(float)w height:(float)h;
/**
		 * @private
		 */
-(float)getLeftPadding;
/**
		 * @private
		 */
-(void)placeIcon;
/**
		 * @private
		 */
-(void)placeExpandCollapseIcon;
/**
		 * @copy com.flexicious.nestedtreedatagrid.cells.CellUtils#drawBackground
		 */
- (void)drawCell:(float)unscaledWidth unscaledHeight:(float)unscaledHeight;
/**
		 * @copy com.flexicious.nestedtreedatagrid.cells.IFlexDataGridCell#placeComponent
		 */
- (CGPoint)placeComponent:(UIView *)cellRenderer unscaledWidth:(float)unscaledWidth unscaledHeight:(float)unscaledHeight usePadding:(BOOL)usePadding;
/**
		 * @copy com.flexicious.nestedtreedatagrid.cells.CelUtils#capitalizeFirstLetterIfPrefix
		 */
-(NSString*)capitalizeFirstLetterIfPrefix:(NSString*)val;
/**
		 * @copy com.flexicious.nestedtreedatagrid.cells.IFlexDataGridCell#hasVerticalGridLines
		 */
-(BOOL)hasVerticalGridLines;
/**
		 * @copy com.flexicious.nestedtreedatagrid.cells.IFlexDataGridCell#hasHorizontalGridLines
		 */
-(BOOL)hasHorizontalGridLines;
/**
* @copy com.flexicious.nestedtreedatagrid.cells.IFlexDataGridCell#drawTopBorder
*/
-(BOOL)drawTopBorder;
/**
		 * @copy com.flexicious.nestedtreedatagrid.cells.CellUtils#drawBackground()
		 */
- (void)drawBackground:(float)unscaledWidth unscaledHeight:(float)unscaledHeight;
/**
		 * @copy com.flexicious.nestedtreedatagrid.cells.CellUtils#getRolloverColor()
		 */
-(id)getRolloverColor;
/**
		 * @copy com.flexicious.nestedtreedatagrid.cells.CellUtils#getRolloverColor()
		 */
-(id)getRolloverTextColor;
/**
		 * @copy com.flexicious.nestedtreedatagrid.cells.CellUtils#getTextColors()
		 */
-(id)getTextColors;
/**
		 * @copy com.flexicious.nestedtreedatagrid.cells.CellUtils#getBackgroundColors()
		 */
-(id)getBackgroundColors;

/**
		 * @copy com.flexicious.nestedtreedatagrid.cells.CellUtils#drawRightBorder
		 */
- (void)drawRightBorder:(float)unscaledWidth unscaledHeight:(float)unscaledHeight;
/**
		 * @copy com.flexicious.nestedtreedatagrid.interfaces#rendererFactory
		 */
-(FLXSClassFactory*)rendererFactory;
/**
		 * @copy com.flexicious.nestedtreedatagrid.interfaces#renderer
		 */
 -(UIView*)renderer;
/**
		 * @private
		 */
-(void)initializeCheckBoxRenderer:(UIView*)renderer;
/**
		 * @private
		 */
-(void)onCheckChange:(NSNotification*)event;
/**
		 * @copy com.flexicious.nestedtreedatagrid.interfaces#isLocked
		 */
-(BOOL)isLocked;
/**
		 * @copy com.flexicious.nestedtreedatagrid.interfaces#isRightLocked
		 */
-(BOOL)isRightLocked;
/**
		 * @copy com.flexicious.nestedtreedatagrid.interfaces#isLeftLocked
		 */
-(BOOL)isLeftLocked;
/**
		 * @copy com.flexicious.nestedtreedatagrid.interfaces.IFlexDataGridCell#isContentArea
		 */
-(BOOL)isContentArea;
/**
		 * @copy com.flexicious.nestedtreedatagrid.cells.CellUtils#getStyleValue
		 */
-(id)getStyleValue:(NSString*)styleProp;
/**
		 * @copy com.flexicious.nestedtreedatagrid.interfaces.IFlexDataGridCell#isElastic
		 */
-(BOOL)isElastic;
/**
		 * @copy com.flexicious.nestedtreedatagrid.interfaces.IFlexDataGridCell#isDataCell
		 */
-(BOOL)isDataCell;
/**
		 * @copy com.flexicious.nestedtreedatagrid.interfaces.IFlexDataGridCell#isChromeCell
		 */
-(BOOL)isChromeCell;
/**
		 * @copy com.flexicious.nestedtreedatagrid.interfaces.IFlexDataGridCell#nestDepth
		 */
-(float)nestDepth;
/**
		 * @copy com.flexicious.nestedtreedatagrid.interfaces.IFlexDataGridCell#perceivedX
		 */
-(float)perceivedX;
/**
		 * @copy com.flexicious.nestedtreedatagrid.interfaces.IFlexDataGridCell#invalidateBackground()
		 */
-(void)invalidateBackground;
/**
		 * @copy com.flexicious.nestedtreedatagrid.interfaces.IFlexDataGridCell#isExpandCollapseCell
		 */
-(BOOL)isExpandCollapseCell;
/**
		 * @copy com.flexicious.nestedtreedatagrid.interfaces.IFlexDataGridCell#iExpandCollapseComponent
		 */
-(UIView<FLXSIExpandCollapseComponent>*)iExpandCollapseComponent;
/**
		 * If column is a checkbox column, returns the current state of the checkbox renderer
		 */
-(NSString*)checkBoxState;


- (void)invalidateDisplayList;

//FLXSIEventDispatcher methods
-(void)dispatchEvent:(FLXSEvent *)event;

- (void)addEventListenerOfType:(NSString *)type usingTarget:(NSObject *)target withHandler:(SEL)handler;

- (void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler;
//End FLXSIEventDispatcher methods

@end

