#import "FLXSFlexDataGridColumn.h"
#import "FLXSTextInput.h"
#import "FLXSFlexDataGridColumnGroup.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSColumnHeaderOperationBehavior.h"
#import "FLXSIFixedWidth.h"
#import "FLXSFlexDataGridEvent.h"
#import "FLXSLabelData.h"
#import "FLXSFlexDataGridDataCell.h"
#import "FLXSFlexDataGridHeaderCell.h"
#import "FLXSFlexDataGridFooterCell.h"
#import "FLXSFlexDataGridFilterCell.h"
#import "FLXSExtendedUIUtils.h"
#import "FLXSDateUtils.h"
#import "FLXSSelectableTextField.h"
#import "FLXSRowInfo.h"
#import <objc/message.h>
#import <objc/runtime.h>

static NSString* FORMAT_NONE = @"none";
static NSString* FORMAT_DATE = @"date";
static NSString* FORMAT_DATE_TIME = @"datetime";
static NSString* FORMAT_TIME = @"time";
static NSString* FORMAT_CURRENCY = @"currency";
static NSString* FORMAT_NUMBER = @"number";

static FLXSClassFactory* static_UIComponent = nil;
static FLXSClassFactory* static_UILabel = nil;
static FLXSClassFactory* static_UILabelWithWordWrap = nil;


static FLXSClassFactory* static_TextInput = nil;
static FLXSClassFactory* static_selectableLabel = nil;

static FLXSClassFactory* static_FLXSFlexDataGridDataCell = nil;
static FLXSClassFactory* static_FLXSFlexDataGridDataCell2 = nil;
static FLXSClassFactory* static_FLXSFlexDataGridDataCellUIComponent = nil;
static FLXSClassFactory* static_FLXSFlexDataGridHeaderCell = nil;
static FLXSClassFactory* static_FLXSFlexDataGridFooterCell = nil;
static FLXSClassFactory* static_FLXSFlexDataGridFilterCell = nil;
static NSString* LOCK_MODE_LEFT = @"left";
static NSString* LOCK_MODE_RIGHT = @"right";
static NSString* LOCK_MODE_NONE  = @"none";
static float DEFAULT_COLUMN_WIDTH = 150;
static NSString* COLUMN_WIDTH_MODE_NONE = @"none";
static NSString* COLUMN_WIDTH_MODE_FIXED = @"fixed";
static NSString* COLUMN_WIDTH_MODE_FIT_TO_CONTENT = @"fitToContent";
static NSString* COLUMN_WIDTH_MODE_PERCENT = @"percent";

@implementation FLXSFlexDataGridColumn {


}

@synthesize calculatedMeasurements = _calculatedMeasurements;
@synthesize naturalLastColWidth = _naturalLastColWidth;
@synthesize footerLabel = _footerLabel;
@synthesize footerLabelFunction = _footerLabelFunction;
@synthesize footerRenderer = _footerRenderer;
@synthesize footerOperation = _footerOperation;
@synthesize footerFormatter = _footerFormatter;
@synthesize footerOperationPrecision = _footerOperationPrecision;
@synthesize footerAlign = _footerAlign;
@synthesize filterComboBoxDataProvider = _filterComboBoxDataProvider;
@synthesize filterComboBoxLabelField = _filterComboBoxLabelField;
@synthesize filterComboBoxDataField = _filterComboBoxDataField;
@synthesize filterComboBoxBuildFromGrid = _filterComboBoxBuildFromGrid;
@synthesize filterDateRangeOptions = _filterDateRangeOptions;
@synthesize filterRenderer = _filterRenderer;
@synthesize filterControlClass = _filterControlClass;
@synthesize filterOperation = _filterOperation;
@synthesize filterComparisonType = _filterComparisonType;
@synthesize searchField = _searchField;
@synthesize sortField = _sortField;
@synthesize filterTriggerEvent = _filterTriggerEvent;
@synthesize excludeFromPrint = _excludeFromPrint;
@synthesize excludeFromSettings = _excludeFromSettings;
@synthesize excludeFromExport = _excludeFromExport;
@synthesize filterWaterMark = _filterWaterMark;
@synthesize useLabelFunctionForFilterCompare = _useLabelFunctionForFilterCompare;
@synthesize linkText = _linkText;
@synthesize cellText = _cellText;
@synthesize percentWidth = _percentWidth;
@synthesize useUnderLine = _useUnderLine;
@synthesize itemRenderer = _itemRenderer;
@synthesize itemEditor = _itemEditor;
@synthesize itemEditorManagesPersistence = _itemEditorManagesPersistence;
@synthesize itemEditorValidatorFunction = _itemEditorValidatorFunction;
@synthesize editorDataField = _editorDataField;
@synthesize dataCellRenderer = _dataCellRenderer;
@synthesize headerCellRenderer = _headerCellRenderer;
@synthesize headerAlign = _headerAlign;
@synthesize headerWordWrap = _headerWordWrap;
@synthesize footerWordWrap = _footerWordWrap;
@synthesize wordWrap = _wordWrap;
@synthesize footerCellRenderer = _footerCellRenderer;
@synthesize filterCellRenderer = _filterCellRenderer;
@synthesize dataFieldFLXS = _dataFieldFLXS;
@synthesize isEditableFunction = _isEditableFunction;
@synthesize editable = _editable;
@synthesize selectable = _selectable;
@synthesize enableCellClickRowSelect = _enableCellClickRowSelect;
@synthesize enableHierarchicalNestIndent = _enableHierarchicalNestIndent;
@synthesize truncateToFit = _truncateToFit;
@synthesize headerRenderer = _headerRenderer;
@synthesize headerText = _headerText;
@synthesize headerToolTip = _headerToolTip;
@synthesize uniqueIdentifier = _uniqueIdentifier;
@synthesize labelFunction = _labelFunction;
@synthesize labelFunction2 = _labelFunction2;
@synthesize resizable = _resizable;
@synthesize draggable = _draggable;
@synthesize sortable = _sortable;
@synthesize sortCompareFunction = _sortCompareFunction;
@synthesize visible = _visible;
@synthesize lastVisibleWidth = _lastVisibleWidth;
@synthesize x = _x;
@synthesize width = _width;
@synthesize minWidth = _minWidth;
@synthesize footerLabelFunction2 = _footerLabelFunction2;
@synthesize persistenceKey = _persistenceKey;
@synthesize filterComboBoxWidth = _filterComboBoxWidth;
@synthesize useCurrentDataProviderForFilterComboBoxValues = _useCurrentDataProviderForFilterComboBoxValues;
@synthesize cellDisabledFunction = _cellDisabledFunction;
@synthesize cellTextColorFunction = _cellTextColorFunction;
@synthesize cellBorderFunction = _cellBorderFunction;
@synthesize cellBackgroundColorFunction = _cellBackgroundColorFunction;
@synthesize cellCustomDrawFunction = _cellCustomDrawFunction;
@synthesize columnLockMode = _columnLockMode;
@synthesize columnWidthModeFitToContentExcludeHeader = _columnWidthModeFitToContentExcludeHeader;
@synthesize columnWidthOffset = _columnWidthOffset;
@synthesize columnWidthMode = _columnWidthMode;
@synthesize columnGroup = _columnGroup;
@synthesize clearFilterOnIconClick = _clearFilterOnIconClick;
@synthesize showClearIconWhenHasText = _showClearIconWhenHasText;
@synthesize enableFilterAutoComplete = _enableFilterAutoComplete;
@synthesize useFilterDataProviderForItemEditor = _useFilterDataProviderForItemEditor;
@synthesize itemEditorApplyOnValueCommit = _itemEditorApplyOnValueCommit;
@synthesize enableIcon = _enableIcon;
@synthesize iconField = _iconField;
@synthesize iconFunction = _iconFunction;
@synthesize iconMouseOverDelay = _iconMouseOverDelay;
@synthesize iconHandCursor = _iconHandCursor;
@synthesize iconToolTip = _iconToolTip;
 @synthesize iconTooltipRenderer = _iconTooltipRenderer;
@synthesize showIconOnRowHover = _showIconOnRowHover;
@synthesize showIconOnCellHover = _showIconOnCellHover;
@synthesize hideText = _hideText;
@synthesize hideHeaderText = _hideHeaderText;
@synthesize sortCaseInsensitive = _sortCaseInsensitive;
@synthesize sortNumeric = _sortNumeric;
@synthesize enableRecursiveSearch = _enableRecursiveSearch;
@synthesize enableExpandCollapseIcon = _enableExpandCollapseIcon;
@synthesize hasComplexDisplay = _hasComplexDisplay;
@synthesize filterCompareFunction = _filterCompareFunction;
@synthesize filterConverterFunction = _filterConverterFunction;
@synthesize useIconRollOverTimer = _useIconRollOverTimer;
@synthesize enableDataCellOptimization = _enableDataCellOptimization;
@synthesize formatter = _formatter;
@synthesize level = _level;
@synthesize enableLocalStyles = _enableLocalStyles;
@synthesize blankValuesLabel = _blankValuesLabel;
@synthesize headerMenuActions = _headerMenuActions;
@synthesize calculatedHeaderHeight = _calculatedHeaderHeight;

@synthesize backgroundColor = _backgroundColor;
@synthesize color = _color;
@synthesize disabledColor = _disabledColor;
@synthesize textAlign = _textAlign;
@synthesize multiColumnSortNumberWidth = _multiColumnSortNumberWidth;
@synthesize multiColumnSortNumberHeight = _multiColumnSortNumberHeight;
@synthesize multiColumnSortNumberStyleName = _multiColumnSortNumberStyleName;
@synthesize columnGroupStyleName = _columnGroupStyleName;
@synthesize headerStyleName = _headerStyleName;
@synthesize footerStyleName = _footerStyleName;
@synthesize verticalGridLines = _verticalGridLines;
@synthesize horizontalGridLines = _horizontalGridLines;
@synthesize verticalGridLineColor = _verticalGridLineColor;
@synthesize horizontalGridLineColor = _horizontalGridLineColor;
@synthesize horizontalGridLineThickness = _horizontalGridLineThickness;
@synthesize verticalGridLineThickness = _verticalGridLineThickness;
@synthesize headerVerticalGridLines = _headerVerticalGridLines;
@synthesize headerHorizontalGridLines = _headerHorizontalGridLines;
@synthesize headerVerticalGridLineColor = _headerVerticalGridLineColor;
@synthesize headerHorizontalGridLineColor = _headerHorizontalGridLineColor;
@synthesize headerHorizontalGridLineThickness = _headerHorizontalGridLineThickness;
@synthesize headerVerticalGridLineThickness = _headerVerticalGridLineThickness;
@synthesize headerDrawTopBorder = _headerDrawTopBorder;
@synthesize columnGroupVerticalGridLines = _columnGroupVerticalGridLines;
@synthesize columnGroupHorizontalGridLines = _columnGroupHorizontalGridLines;
@synthesize columnGroupVerticalGridLineColor = _columnGroupVerticalGridLineColor;
@synthesize columnGroupHorizontalGridLineColor = _columnGroupHorizontalGridLineColor;
@synthesize columnGroupHorizontalGridLineThickness = _columnGroupHorizontalGridLineThickness;
@synthesize columnGroupVerticalGridLineThickness = _columnGroupVerticalGridLineThickness;
@synthesize columnGroupDrawTopBorder = _columnGroupDrawTopBorder;
@synthesize filterVerticalGridLines = _filterVerticalGridLines;
@synthesize filterHorizontalGridLines = _filterHorizontalGridLines;
@synthesize filterVerticalGridLineColor = _filterVerticalGridLineColor;
@synthesize filterHorizontalGridLineColor = _filterHorizontalGridLineColor;
@synthesize filterHorizontalGridLineThickness = _filterHorizontalGridLineThickness;
@synthesize filterVerticalGridLineThickness = _filterVerticalGridLineThickness;
@synthesize filterDrawTopBorder = _filterDrawTopBorder;
@synthesize footerVerticalGridLines = _footerVerticalGridLines;
@synthesize footerHorizontalGridLines = _footerHorizontalGridLines;
@synthesize footerVerticalGridLineColor = _footerVerticalGridLineColor;
@synthesize footerHorizontalGridLineColor = _footerHorizontalGridLineColor;
@synthesize footerHorizontalGridLineThickness = _footerHorizontalGridLineThickness;
@synthesize footerVerticalGridLineThickness = _footerVerticalGridLineThickness;
@synthesize footerDrawTopBorder = _footerDrawTopBorder;
@synthesize pagerVerticalGridLines = _pagerVerticalGridLines;
@synthesize pagerHorizontalGridLines = _pagerHorizontalGridLines;
@synthesize pagerVerticalGridLineColor = _pagerVerticalGridLineColor;
@synthesize pagerHorizontalGridLineColor = _pagerHorizontalGridLineColor;
@synthesize pagerHorizontalGridLineThickness = _pagerHorizontalGridLineThickness;
@synthesize pagerVerticalGridLineThickness = _pagerVerticalGridLineThickness;
@synthesize pagerDrawTopBorder = _pagerDrawTopBorder;
@synthesize rendererVerticalGridLines = _rendererVerticalGridLines;
@synthesize rendererHorizontalGridLines = _rendererHorizontalGridLines;
@synthesize rendererVerticalGridLineColor = _rendererVerticalGridLineColor;
@synthesize rendererHorizontalGridLineColor = _rendererHorizontalGridLineColor;
@synthesize rendererHorizontalGridLineThickness = _rendererHorizontalGridLineThickness;
@synthesize rendererVerticalGridLineThickness = _rendererVerticalGridLineThickness;
@synthesize rendererDrawTopBorder = _rendererDrawTopBorder;
@synthesize selectionColorFLXS = _selectionColorFLXS;
@synthesize sortArrowSkin = _sortArrowSkin;
@synthesize paddingLeft = _paddingLeft;
@synthesize paddingRight = _paddingRight;
@synthesize paddingTop = _paddingTop;
@synthesize paddingBottomFLXS = _paddingBottomFLXS;
@synthesize headerPaddingLeft = _headerPaddingLeft;
@synthesize headerPaddingRight = _headerPaddingRight;
@synthesize headerPaddingTop = _headerPaddingTop;
@synthesize headerPaddingBottom = _headerPaddingBottom;
@synthesize footerPaddingLeft = _footerPaddingLeft;
@synthesize footerPaddingRight = _footerPaddingRight;
@synthesize footerPaddingTop = _footerPaddingTop;
@synthesize footerPaddingBottom = _footerPaddingBottom;
@synthesize filterPaddingLeft = _filterPaddingLeft;
@synthesize filterPaddingRight = _filterPaddingRight;
@synthesize filterPaddingTop = _filterPaddingTop;
@synthesize filterPaddingBottom = _filterPaddingBottom;
@synthesize pagerPaddingLeft = _pagerPaddingLeft;
@synthesize pagerPaddingRight = _pagerPaddingRight;
@synthesize pagerPaddingTop = _pagerPaddingTop;
@synthesize pagerPaddingBottom = _pagerPaddingBottom;
@synthesize rendererPaddingLeft = _rendererPaddingLeft;
@synthesize rendererPaddingRight = _rendererPaddingRight;
@synthesize rendererPaddingTop = _rendererPaddingTop;
@synthesize rendererPaddingBottom = _rendererPaddingBottom;
@synthesize alternatingItemColors = _alternatingItemColors;
@synthesize alternatingTextColors = _alternatingTextColors;
@synthesize editItemColor = _editItemColor;
@synthesize editTextColor = _editTextColor;
@synthesize selectionDisabledColor = _selectionDisabledColor;
@synthesize disclosureOpenIcon = _disclosureOpenIcon;
@synthesize disclosureClosedIcon = _disclosureClosedIcon;
@synthesize columnGroupOpenIcon = _columnGroupOpenIcon;
@synthesize columnGroupClosedIcon = _columnGroupClosedIcon;
@synthesize rollOverColor = _rollOverColor;
@synthesize activeCellColor = _activeCellColor;
@synthesize footerColors = _footerColors;
@synthesize footerRollOverColors = _footerRollOverColors;
@synthesize filterColors = _filterColors;
@synthesize filterRollOverColors = _filterRollOverColors;
@synthesize headerColors = _headerColors;
@synthesize headerRollOverColors = _headerRollOverColors;
@synthesize columnGroupColors = _columnGroupColors;
@synthesize columnGroupRollOverColors = _columnGroupRollOverColors;
@synthesize rendererColors = _rendererColors;
@synthesize rendererRollOverColors = _rendererRollOverColors;
@synthesize pagerColors = _pagerColors;
@synthesize pagerRollOverColors = _pagerRollOverColors;
@synthesize textSelectedColor = _textSelectedColor;
@synthesize textRollOverColor = _textRollOverColor;
@synthesize textDisabledColor = _textDisabledColor;
@synthesize columnTextColor = _columnTextColor;
@synthesize filterIcon = _filterIcon;
@synthesize filterIconPosition = _filterIconPosition;
@synthesize icon = _icon;
@synthesize overIcon = _overIcon;
@synthesize disabledIcon = _disabledIcon;
@synthesize headerIcon = _headerIcon;
@synthesize iconLeft = _iconLeft;
@synthesize iconWidth = _iconWidth;
@synthesize iconHeight = _iconHeight;
@synthesize iconRight = _iconRight;
@synthesize iconTop = _iconTop;
@synthesize iconBottom = _iconBottom;
@synthesize expandCollapseIconLeft = _expandCollapseIconLeft;
@synthesize expandCollapseIconRight = _expandCollapseIconRight;
@synthesize expandCollapseIconTop = _expandCollapseIconTop;
@synthesize expandCollapseIconBottom = _expandCollapseIconBottom;
@synthesize editorStyleName = _editorStyleName;
@synthesize format = _format;
@synthesize formatterPrecision = _formatterPrecision;
@synthesize formatterCurrencySymbol = _formatterCurrencySymbol;
@synthesize formatterDateFormatString = _formatterDateFormatString;
@synthesize useLabelFunctionForSortCompare = _useLabelFunctionForSortCompare;

-(id)init
{
	self = [super init];
	if (self)
	{
		_naturalLastColWidth = 0;
		_footerOperationPrecision = 2;
		_footerAlign = NSTextAlignmentLeft;
		_filterComboBoxDataProvider = nil;
		_filterComboBoxLabelField = @"label";
		_filterComboBoxDataField = @"data";
		_filterComboBoxBuildFromGrid = NO;
		_filterDateRangeOptions = [[NSMutableArray alloc] init];
		_filterControlClass = @"";
//		_filterOperation = FLXSFilterExpression.FILTER_OPERATION_TYPE_EQUALS;
		_filterComparisonType = @"auto";
		_searchField = @"";
		_sortField = @"";
		_filterTriggerEvent = @"change";
		_excludeFromPrint = NO;
		_excludeFromSettings = NO;
		_excludeFromExport = NO;
		_filterWaterMark = @"";
		_useLabelFunctionForFilterCompare = NO;
		_itemEditor = [FLXSFlexDataGridColumn static_TextInput];
		_itemEditorManagesPersistence = NO;
		_itemEditorValidatorFunction = nil;
		_editorDataField = @"text";
		_headerAlign = NSTextAlignmentLeft;
		_headerWordWrap = NO;
		_footerWordWrap = NO;
		_wordWrap = NO;
		_editable = YES;
		_selectable = NO;
		_enableCellClickRowSelect = YES;
		_enableHierarchicalNestIndent = NO;
		_truncateToFit = NO;
		_headerToolTip = @"";
		_uniqueIdentifier = @"";
		_resizable = YES;
		_draggable = YES;
		self.sortable = YES;
		_visible = YES;
		_lastVisibleWidth = 0;
		_width = DEFAULT_COLUMN_WIDTH;
		_minWidth = 20;
		_persistenceKey = @"";
		_filterComboBoxWidth = 0;
		_columnLockMode = @"none";
		self.calculatedMeasurements = [[NSMutableDictionary alloc]init];
		_columnWidthModeFitToContentExcludeHeader = NO;
		_columnWidthOffset = 30 ;
		_columnWidthMode = COLUMN_WIDTH_MODE_NONE;
		_clearFilterOnIconClick = NO;
		self.showClearIconWhenHasText = NO;
		_enableFilterAutoComplete = NO;
		_useFilterDataProviderForItemEditor = NO;
		_enableIcon = NO;
		_iconField = @"";
		self.iconMouseOverDelay = 500;
		self.iconHandCursor = NO;
		self.iconToolTip = @"";
		//self.iconToolTipFunction =@"defaultIconTooltipFunction:";
        self.iconFunction = @"defaultIconFunction::"  ;
		self.iconTooltipRenderer = nil;
		self.showIconOnRowHover = NO;
		self.showIconOnCellHover = NO;
		self.hideText = NO;
		self.hideHeaderText = NO;
		self.sortCaseInsensitive = NO;
		self.sortNumeric = NO;
		self.enableRecursiveSearch = NO;
		self.enableExpandCollapseIcon = NO;
		self.hasComplexDisplay = NO;
		self.filterCompareFunction = nil;
		self.filterConverterFunction = nil;
		self.useIconRollOverTimer = YES;
		self.enableLocalStyles = YES;
		self.blankValuesLabel = @" [None] ";
		self.headerMenuActions = FLXSColumnHeaderOperationBehavior.DEFAULT_COLUMN_HEADER_OPERATIONS;
		_calculatedHeaderHeight = -1;
        _footerCellRenderer = [FLXSFlexDataGridColumn static_FLXSFlexDataGridFooterCell];
        _filterCellRenderer = [FLXSFlexDataGridColumn static_FLXSFlexDataGridFilterCell];
        _dataCellRenderer = [FLXSFlexDataGridColumn static_FLXSFlexDataGridDataCell2];
        _headerCellRenderer = [FLXSFlexDataGridColumn static_FLXSFlexDataGridHeaderCell];

	}
	return self;
    return nil;
}
+(void)initialize {
    if(![FLXSUIUtils isIPad]){
        DEFAULT_COLUMN_WIDTH = 100;
    }
}
-(NSString*)sortFieldName {
    return self.dataFieldFLXS;
}
-(NSString*)sortField {
    return _sortField.length == 0 ? self.dataFieldFLXS : _sortField;
}
-(NSString*)uniqueIdentifier {
    return _uniqueIdentifier.length>0?_uniqueIdentifier:self.headerText.length>0 ? self.headerText : self.dataFieldFLXS.length>0 ? self.dataFieldFLXS
            : ([@"Column " stringByAppendingString:[[NSNumber numberWithInt:(self.colIndex + 1)] description]]);
}
-(NSString *)persistenceKey{
    return self.uniqueIdentifier;
}

-(NSString*)searchField {
    return _searchField.length == 0 ? self.dataFieldFLXS : _searchField;
}

-(void)setVisible:(BOOL)value
{
    if (_visible != value)
    {
        if((_visible && !value) &&
                self.level&&self.level.grid.forceColumnsToFitVisibleArea && (self.columnWidthMode==[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_NONE])
                && (self.columnLockMode==[FLXSFlexDataGridColumn LOCK_MODE_NONE]))
        {
            _lastVisibleWidth=self.width;
        }
        _visible = value;
        if(self.level)
        {
            for(FLXSFlexDataGridColumn* col in self.level.columns)
            {
                col.calculatedMeasurements =[[NSMutableDictionary alloc] init];
            }
            [self.level invalidateCache];
            self.level.wxInvalid=YES;
            [self.level.grid reDraw];
        }
    }
}

-(float)x {
    if(self.level.wxInvalid){
        [self.level initializeColumnLevel];
    }
    return _x;
}
-(void)setX:(float)value
{
    if(self.x!=value){
        _x = value;

        if(self.level){
            FLXSFlexDataGridEvent* evt= [[FLXSFlexDataGridEvent alloc] initWithType:([FLXSFlexDataGridEvent COLUMN_X_CHANGED]) andGrid:self.level.grid andLevel:self.level andColumn:self andCell:nil andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ];
            [self dispatchEvent:evt];
        }

    }

}

-(void)setIconFunction:(NSString *)iconFunction {
    _iconFunction = [FLXSUIUtils checkSelectorSuffix:iconFunction :@"::"];
}
-(void)setWidth:(float)value
{
    if(_width!=value)
    {
        if(value<_minWidth)return;
        _width = value;
        if(self.level)
        {
            self.level.wxInvalid=YES;
            if(self.isLocked || (self.headerWordWrap&&self.level.grid.variableHeaderHeight))
            {
                self.level.grid.preservePager=YES;
                [self.level.grid reDraw];
            }
            else
            {
                [self.level.grid invalidateCellWidths];
            }
            [self.level.grid invalidateFiller];
        }
        FLXSFlexDataGridEvent* evt= [[FLXSFlexDataGridEvent alloc] initWithType:([FLXSFlexDataGridEvent COLUMN_RESIZED]) andGrid:self.level.grid andLevel:self.level andColumn:self andCell:nil andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ];
        [self dispatchEvent:evt];
    }
}

-(void)setFooterOperation:(NSString*)lbl
{
    _footerOperation=lbl;
    if([lbl isEqualToString:@"count"])
    {
        self.footerOperationPrecision=0;
    }
}
-(void)setColumnLockMode:(NSString*)val
{
    if(([val isEqualToString:LOCK_MODE_LEFT]||[val isEqualToString:LOCK_MODE_RIGHT]
            ||[val isEqualToString:LOCK_MODE_NONE]))
    {
        if(_columnLockMode!=val && self.level )
        {
            [self.level invalidateCache];
            [self.level.grid reDraw];
        }
        _columnLockMode=val;
    }
}

-(FLXSClassFactory*)dataCellRenderer
{
    return (self.truncateToFit||self.selectable||self.useUnderLine||self.wordWrap||self.itemRenderer||self.enableExpandCollapseIcon||self.enableIcon)?
            [FLXSFlexDataGridColumn static_FLXSFlexDataGridDataCell]:_dataCellRenderer;
}
-(void)setHeaderWordWrap:(BOOL)val
{
    _headerWordWrap=val;
    if(val)
        _headerRenderer = [FLXSFlexDataGridColumn static_UILabelWithWordWrap];
}


-(void)setFooterWordWrap:(BOOL)val
{
    _footerWordWrap=val;
    if(val)
        _footerRenderer = [FLXSFlexDataGridColumn static_UILabelWithWordWrap];
}
-(void)setDataFieldFLXS:(NSString*)value
{
	_dataFieldFLXS = value;
	if(value && [value rangeOfString:@"."].location>0)
	{
		//self means we have a complex property
        //next version
		//self.sortCompareFunction=NSComparator(nestedSortCompareFunction:object2:);
		self.hasComplexDisplay = YES;
	}
}
 
-(void)setLabelFunction:(NSString*)value
{
    _labelFunction = [FLXSUIUtils checkSelectorSuffix:value :@"::"];
    self.hasComplexDisplay = YES;
}


-(void)setLabelFunction2:(NSString*)value
{
    _labelFunction2 = [FLXSUIUtils checkSelectorSuffix:value :@":::"];
    self.hasComplexDisplay = YES;
}

-(void)setSortCompareFunction:(NSString *)sortCompareFunction {
    _sortCompareFunction = [FLXSUIUtils checkSelectorSuffix:sortCompareFunction :@"::"];
    self.hasComplexDisplay = YES;
}

-(void)setFooterLabelFunction:(NSString*)value
{
    _footerLabelFunction = [FLXSUIUtils checkSelectorSuffix:value :@":"];
    self.hasComplexDisplay = YES;
}


-(void)setFooterLabelFunction2:(NSString*)value
{
    _footerLabelFunction2 = [FLXSUIUtils checkSelectorSuffix:value :@":"];
    self.hasComplexDisplay = YES;
}
-(void)setCellBackgroundColorFunction:(NSString *)cellBackgroundColorFunction {
    _cellBackgroundColorFunction = [FLXSUIUtils checkSelectorSuffix:cellBackgroundColorFunction :@":"];

}
-(void)setCellDisabledFunction:(NSString *)cellDisabledFunction {
    _cellDisabledFunction = [FLXSUIUtils checkSelectorSuffix:cellDisabledFunction :@":"];
}

-(void)setCellTextColorFunction:(NSString *)cellTextColorFunction {
    _cellTextColorFunction = [FLXSUIUtils checkSelectorSuffix:cellTextColorFunction :@":"];

}

-(NSString*)itemToLabel:(NSObject*)data :(UIView<FLXSIFlexDataGridCell>*)cell
{
	if (!data)
		return @"";
	if(!self.hasComplexDisplay && self.dataFieldFLXS)
	{
		return [self doFormat:[data valueForKey:self.dataFieldFLXS]];
	}
	if(self.linkText)
		return self.linkText;
	if (self.labelFunction != nil){
        SEL selector = NSSelectorFromString(self.labelFunction);
        id target = self.level.grid.delegate;
        FLXSFlexDataGridColumn *arg = self;
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
//                [[target class] instanceMethodSignatureForSelector:selector]];
//        [invocation setSelector:selector];
//        [invocation setTarget:target];
//        [invocation setArgument:&data atIndex:2];
//        [invocation setArgument:&arg atIndex:3];
//        [invocation retainArguments];
//        [invocation invoke];
//
//        CFTypeRef result;
//        [invocation getReturnValue:&result];
//        if (result)
//            CFRetain(result);
//        NSString *returnValue = (__bridge_transfer NSString *)result;
       // NSString * returnValue = objc_msgSend(target, selector, data, arg);

//        Using this information, I changed the below line:
//
//        objc_msgSend(self.handler, self.action, self.value);
//
//        to:
//
//        id (*response)(id, SEL, id) = (id (*)(id, SEL, id)) objc_msgSend;
//        response(self.handler, self.action, output);
         NSString* (*response)(id,SEL,NSObject*, FLXSFlexDataGridColumn *) = (NSString* (*)(id,SEL,NSObject*, FLXSFlexDataGridColumn *) ) objc_msgSend;
        NSString * returnValue = response(target,selector, data, arg);
        return [self doFormat:([FLXSExtendedUIUtils toString:(returnValue)])];

    }
    if (self.labelFunction2 != nil){
        SEL selector = NSSelectorFromString(self.labelFunction2);
        id target = self.level.grid.delegate;
        FLXSFlexDataGridColumn *arg = self;
        NSString * returnValue = ((NSString*(*)(id, SEL, NSObject *, FLXSFlexDataGridColumn *, UIView<FLXSIFlexDataGridCell>*
        ))objc_msgSend)(target, selector, data, arg, cell);
        return [self doFormat:([FLXSExtendedUIUtils toString:(returnValue)])];

    }
	if(self.dataFieldFLXS)
		return [self doFormat:([FLXSExtendedUIUtils toString:([FLXSExtendedUIUtils resolveExpression:data expression:self.dataFieldFLXS valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ])])];
    return @"";
}

-(NSString*)doFormat:(NSString*)retVal
{
    if(retVal==nil)return @"";
    NSFormatter* fmt=(NSFormatter*)self.formatter;
    if(fmt!=nil)
       [fmt stringForObjectValue: retVal];
    if(self.format && ![self.format isEqual:FORMAT_NONE])
    {
        if([self.format isEqual:FORMAT_DATE])
        {
            NSDateFormatter* dfmt=[[NSDateFormatter alloc] init];
            dfmt.dateFormat=self.formatterDateFormatString?self.formatterDateFormatString:[FLXSDateUtils MEDIUM_DATE_MASK];
            fmt=dfmt;
        }
        else if([self.format isEqual:FORMAT_DATE_TIME])
        {
            NSDateFormatter* dfmt1=[[NSDateFormatter alloc] init];
            dfmt1.dateFormat=self.formatterDateFormatString?self.formatterDateFormatString:
                    [FLXSDateUtils RFC_822_MASK];
            fmt=dfmt1;
        }
        else if([self.format isEqual:FORMAT_TIME])
        {
            NSDateFormatter* dfmt2=[[NSDateFormatter alloc] init];
            dfmt2.dateFormat=self.formatterDateFormatString?self.formatterDateFormatString:[FLXSDateUtils LONG_TIME_MASK];
            fmt=dfmt2;
        }
        else if([self.format isEqual:FORMAT_CURRENCY])
        {
            NSNumberFormatter * cf=[[NSNumberFormatter alloc] init];
            cf.maximumFractionDigits=self.formatterPrecision;
            cf.currencySymbol = self.formatterCurrencySymbol;
            cf.numberStyle = NSNumberFormatterCurrencyStyle;
            fmt=cf;
        }
        else if([self.format isEqual:FORMAT_NUMBER])
        {
            NSNumberFormatter* nf=[[NSNumberFormatter alloc] init];
            nf.maximumFractionDigits=self.formatterPrecision;
            fmt=nf;
        }
        return [fmt stringForObjectValue:retVal];
    }
    return retVal;
}
-(NSString*)filterControl{
    return self.filterControlClass;
}
-(void)setFilterControl:(NSString*)value{
    self.filterControlClass=value;
}
-(void)setSelectable:(BOOL)selectable {
    if(selectable){
        self.itemRenderer=[FLXSFlexDataGridColumn static_selectableLabel];
    }
}

-(FLXSClassFactory*)filterRenderer
{
	if (_filterRenderer == nil && [_filterControlClass length] > 0)
	{
        if(![_filterControlClass hasPrefix:@"FLXS"] && NSClassFromString(_filterControlClass)==nil){
                _filterControlClass = [@"FLXS" stringByAppendingString:_filterControlClass];
        }
        Class  myClass = NSClassFromString(_filterControlClass);
        if(myClass==nil){
            _filterRenderer = [FLXSFlexDataGridColumn static_UIComponent];
        }
        else
            _filterRenderer= [[FLXSClassFactory alloc] initWithClass:myClass andProperties:nil];
	}
	return _filterRenderer;
}

-(void)setFilterRenderer:(FLXSClassFactory*)value
{
	_filterRenderer=value;
    [self dispatchEvent:[[FLXSEvent alloc] initWithType:@"filterRendererChanged"]];

}


-(void)columnLockMode:(NSString*)val
{
    if(([val isEqual:LOCK_MODE_LEFT]||[val isEqual:LOCK_MODE_RIGHT]||[val isEqual:LOCK_MODE_NONE]))
    {
        if(!([_columnLockMode isEqual:val]) && self.level )
		{
			[self.level invalidateCache];
			[self.level.grid reDraw];
		}
		_columnLockMode=val;
	}
}

-(void)setLinkText:(NSString*)lbl
{
	_linkText=lbl;
	if (_linkText && [_linkText length] > 0)
	{
		[self setStyle:(@"textDecoration") :(@"underline")];
		self.hasComplexDisplay = YES;
	}
}


-(BOOL)isLocked
{
	return  ![self.columnLockMode isEqual:LOCK_MODE_NONE];
}

-(BOOL)isRightLocked
{
    return [self.columnLockMode isEqual: LOCK_MODE_RIGHT];
}

-(BOOL)isLeftLocked
{
    return [self.columnLockMode isEqual: LOCK_MODE_LEFT];
}

-(BOOL)isElastic
{
	return (!self.isRightLocked&&![self conformsToProtocol:@protocol(FLXSIFixedWidth)]);
}
-(NSString*)headerText
{
    return (_headerText != nil) ? _headerText : self.dataFieldFLXS;
}

-(NSString*)columnLabel
{
    return [FLXSExporter getColumnHeader:self colIndex:self.colIndex];
}
-(BOOL)isLastLeftLocked
{
	if([self.calculatedMeasurements valueForKey:@"isLastLeftLocked"]!=nil)
	{
		return [[self.calculatedMeasurements valueForKey:@"isLastLeftLocked"] boolValue];
	}
	NSArray* arr=self.level.leftLockedColumns;
	if([arr count]==0)return NO;
	BOOL isLast = [arr indexOfObject:self]==[arr count]-1;
	//self.calculatedMeasurements[@"isLastLeftLocked"]=isLeftLocked && isLast;
    [self.calculatedMeasurements setValue:[[NSNumber alloc] initWithBool:self.isLeftLocked && isLast] forKey:@"isLastLeftLocked"];
	return self.isLeftLocked && isLast;
}

-(BOOL)isLastUnLocked
{
	if([self.calculatedMeasurements valueForKey:@"isLastUnLocked"]!=nil)
	{
		return [[self.calculatedMeasurements valueForKey:@"isLastUnLocked"] boolValue];
	}
	NSArray* arr=self.level.unLockedColumns;
	if(arr.count==0)return NO;
	BOOL isLast = [arr indexOfObject:self]==arr.count-1;
	[self.calculatedMeasurements setValue:[NSNumber numberWithBool:isLast] forKey:@"isLastUnLocked"];
	return isLast;
}

-(BOOL)isFirstUnLocked
{
	if([self.calculatedMeasurements valueForKey:@"isFirstUnLocked"]!=nil)
	{
		return [[self.calculatedMeasurements valueForKey:@"isFirstUnLocked"] boolValue];
	}
	NSArray* arr=self.level.unLockedColumns;
	if(arr.count==0)return NO;
	BOOL isLast = [arr indexOfObject:self]==0;
	[self.calculatedMeasurements setValue:[NSNumber numberWithBool:isLast] forKey:@"isFirstUnLocked"];
	return isLast;
}

-(BOOL)isFirstRightLocked
{
	if([self.calculatedMeasurements valueForKey:@"isFirstRightLocked"]!=nil)
	{
		return [[self.calculatedMeasurements valueForKey:@"isFirstRightLocked"] boolValue];
	}
	NSArray* arr=self.level.rightLockedColumns;
	if(arr.count==0)return NO;
	BOOL isFirst = [arr indexOfObject:self]==0;
	[self.calculatedMeasurements setValue:[NSNumber numberWithBool:isFirst] forKey:@"isFirstRightLocked"];
	return isFirst;
}

-(BOOL)isLastRightLocked
{
	if([self.calculatedMeasurements valueForKey:@"isLastRightLocked"]!=nil)
	{
		return [[self.calculatedMeasurements valueForKey:@"isLastRightLocked"] boolValue];
	}
	NSArray* arr=self.level.rightLockedColumns;
	if(arr.count==0)return NO;
	BOOL isLast = [arr indexOfObject:self]==arr.count-1;
    [self.calculatedMeasurements    setValue:[NSNumber numberWithBool:self.isRightLocked && isLast] forKey:@"isLastRightLocked"];
	return self.isRightLocked && isLast;
}
-(BOOL)editable {
    return _editable && self.level.grid.editable;

}
-(FLXSFlexDataGridColumn*)getAdjacentColumn:(int)num
{
	NSArray* cols = [self.level getVisibleColumns:nil];
	int newIndex= self.colIndex+num;
	if(newIndex>0&&newIndex<cols.count)
	{
		return [cols objectAtIndex:newIndex];
	}
	return nil;
}

-(id)getStyleValue:(NSString*)styleProp
{
	id result = [self getStyle:styleProp];
	if(result == nil || ([result respondsToSelector:@selector(integerValue)] &&[result integerValue]==0))
		result = [self.level getStyleValue:styleProp];
	return result;
}

-(int)getIndex
{
	if([self.calculatedMeasurements valueForKey:@"getIndex"]!=nil)
	{
		return (int)[[self.calculatedMeasurements valueForKey:@"getIndex"] integerValue ];
	}
    [self.calculatedMeasurements setValue:[NSNumber numberWithInt:(int)[self.level.columns indexOfObject:self]] forKey:@"getIndex"];
	return (int)[self.level.columns indexOfObject:self];
}

-(int)colIndex
{
	if([self.calculatedMeasurements valueForKey:@"colIndex"]!=nil)
	{
		return (int)[[self.calculatedMeasurements valueForKey:@"colIndex"] integerValue];
	}
    [self.calculatedMeasurements setValue:[NSNumber numberWithInt:(int)[[self.level getVisibleColumns:nil] indexOfObject:self]] forKey:@"colIndex"];
	return (int)[[self.level getVisibleColumns:nil] indexOfObject:self];
}

-(FLXSClassFactory*)deriveRenderer:(int)chromeType
{
	FLXSClassFactory* renderer=(chromeType==[FLXSRowPositionInfo ROW_TYPE_DATA])?self.itemRenderer
:(chromeType==[FLXSRowPositionInfo ROW_TYPE_FILL])?[FLXSFlexDataGridColumn static_UIComponent]
:(chromeType==[FLXSRowPositionInfo ROW_TYPE_HEADER]||chromeType==[FLXSRowPositionInfo ROW_TYPE_COLUMN_GROUP])?self.headerRenderer
:(chromeType==[FLXSRowPositionInfo ROW_TYPE_FOOTER])?self.footerRenderer
:nil;
	return (renderer==nil)?[FLXSFlexDataGridColumn static_UILabel]:renderer;
}
 
//Start FLXSIEventDispatcher methods

- (void)addEventListenerOfType:(NSString *)type usingTarget:(NSObject *)target withHandler:(SEL)handler {
    [FLXSUIUtils addEventListenerOfType:type
                       withTarget:target
                       andHandler:handler
                        andSender:self];
}
-(void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler {
    [FLXSUIUtils removeEventListener:type
                          withTarget:target
                          andHandler:handler
                           andSender:self];
}
-(void)dispatchEvent:(FLXSEvent *)event {
    
	if([event isKindOfClass:[FLXSFlexDataGridEvent class] ]  && self.level)
	{
		[self.level dispatchEvent:event];
	}
    [FLXSUIUtils dispatchEvent:event
                    withSender:self];
}
//End FLXSIEventDispatcher methods


- (NSArray *)getDistinctValues:(NSArray *)dp collection:(NSMutableArray *)collection addedCodes:(NSMutableArray *)addedCodes level:(FLXSFlexDataGridColumnLevel *)lvl {

    addedCodes=addedCodes==nil?[[NSMutableArray alloc] init]:addedCodes;
    collection=collection==nil?[[NSMutableArray alloc] init]:collection;
	lvl=lvl==nil?self.level:lvl;
	for(NSObject* item in dp)
	{
		if(lvl.nextLevel && lvl.nextLevel.reusePreviousLevelColumns)
		{
            [self getDistinctValues:([lvl getChildren:item filter:NO page:NO sort:NO ]) collection:collection addedCodes:addedCodes level:lvl.nextLevel];
		}
		NSObject* collectionItem=nil;
		NSString* label=[self itemToLabel:item:nil];
        
        if (label || ((self.blankValuesLabel && item && [item respondsToSelector:NSSelectorFromString(self.dataFieldFLXS)]))) {
            collectionItem = [[FLXSLabelData alloc] initWithLabel:(!label?self.blankValuesLabel:label) andData:label];
        }

		if(collectionItem!=nil)
		{
            
			if(![addedCodes containsObject:label])
			{
				[collection addObject:collectionItem];
				[addedCodes addObject:label!=nil?label:@""];
			}
		}
	}
	if(lvl.nestDepth==1)
	{
		[collection sortUsingSelector:NSSelectorFromString(@"label")];
	}
	return collection;
    
}

-(NSString*)itemToLabelCommon:(NSObject*)item
{
    return [self    itemToLabel:item :nil];
}

- (int)nestedSortCompareFunction:(NSObject *)obj1 object2:(NSObject *)obj2 {
//	NSObject* left = [ExtendedUIUtils resolveExpression:obj1 :dataFieldFLXS];
//	NSObject* right = [ExtendedUIUtils resolveExpression:obj2 :dataFieldFLXS];
//	NSString* typeLeft = [self typeof:left];
//	NSString* typeRight = [self typeof:right];
//	if ([typeLeft isEqual: @"string"] || [typeRight isEqual: @"string"])
//	{
//		[return ObjectUtil stringCompare:left as NSString :right as NSString];
//	}
//	else if (left is Date || right is Date)
//	{
//		[return ObjectUtil dateCompare:left as Date :right as Date];
//	}
//	else if ([typeLeft isEqual: @"number" ]|| [typeRight isEqual: @"number"]
//|| [typeLeft isEqual: @"boolean"] || [typeRight isEqual: @"boolean"]
//|| [typeLeft isEqual: @"int"] ||[ typeRight == @"int"])
//	{
//		[return ObjectUtil numericCompare:left as float :right as float];
//	}
//	[return ObjectUtil compare:left :right];
    return 0;
}


-(NSObject*)showPopup:(NSObject*)popupData
{
	return nil;
}

-(BOOL)isValidStyleValue:(id)val
{
    return val != nil;
}


-(void)enableFilterAutoComplete:(BOOL)value
{
	_enableFilterAutoComplete = value;
	if(value)
	{
		self.filterTriggerEvent=@"enterKeyUp";
	}
}


- (NSString *)defaultIconFunction:(UIView <FLXSIFlexDataGridCell> *)cell :(NSString *)state {
	if(cell.rowInfo.isHeaderRow)
	{
		return [self getStyle:(@"headerIcon")];
	}
	else if(cell.rowInfo.isDataRow)
	{
		NSString* styleProp=[state isEqual:@"over"]&&[self getStyle:(@"overIcon")]?@"overIcon":[state isEqual:@"disabled"]
&&[self getStyle:(@"disabledIcon")]?@"disabledIcon":@"icon";
		NSString* retVal=[self getStyle:styleProp];
		return retVal?retVal: [FLXSExtendedUIUtils resolveExpression:cell.rowInfo.data expression:self.iconField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];
	}
	return nil;
}

-(NSString*)defaultIconTooltipFunction:(UIView<FLXSIFlexDataGridCell>*)cell
{
	return self.iconToolTip;
}

-(float)nestDepth
{
	return self.level?self.level.nestDepth:1;
}

-(BOOL)isSortable
{
	return self.sortable;
}
//we dont need enableDataCellOptimziation

-(float)calculatedHeaderHeight
{
	return _calculatedHeaderHeight==-1?self.level.headerHeight:_calculatedHeaderHeight;
}

- (id)getStyle:(NSString *)prop {
    if([self respondsToSelector:NSSelectorFromString(prop)])
        return [self valueForKey:prop];
    return nil;
}
- (void)setStyle:(NSString *)prop :(id)value {
    if([self respondsToSelector:NSSelectorFromString(prop)])
        [self setValue:value forKey:prop];
}


+ (FLXSClassFactory*)static_TextInput
{
    if(static_TextInput==nil){
        static_TextInput= [[FLXSClassFactory alloc] initWithClass:[FLXSTextInput class] andProperties:nil ];
    }
    return static_TextInput;
}
+ (FLXSClassFactory*)static_selectableLabel
{
    if(static_selectableLabel==nil){
        static_selectableLabel= [[FLXSClassFactory alloc] initWithClass:[FLXSSelectableTextField class] andProperties:nil];
    }
    return static_selectableLabel;
}
+ (FLXSClassFactory*)static_UIComponent
{
    if(static_UIComponent==nil){
        static_UIComponent= [[FLXSClassFactory alloc] initWithClass:[UIView class] andProperties:nil ];
    }
    return static_UIComponent;
}
+ (FLXSClassFactory*)static_UILabel
{
    if(static_UILabel==nil){
        static_UILabel= [[FLXSClassFactory alloc] initWithClass:[UILabel class]
                                                  andProperties:[[NSMutableDictionary alloc]
                                                          initWithObjects:[[NSArray alloc] initWithObjects:[UIColor clearColor], nil]
                                                                  forKeys:[[NSArray alloc] initWithObjects:@"backgroundColor", nil]]];
    }
    return static_UILabel;
}
+ (FLXSClassFactory*)static_UILabelWithWordWrap
{
    if(static_UILabelWithWordWrap==nil){
        static_UILabelWithWordWrap= [[FLXSClassFactory alloc] initWithClass:[UILabel class]
                                                              andProperties:[[NSMutableDictionary alloc]
                                                                      initWithObjects:[[NSArray alloc] initWithObjects:[UIColor clearColor], nil]
                                                                              forKeys:[[NSArray alloc] initWithObjects:@"backgroundColor", nil]]];
    }
    return static_UILabelWithWordWrap;
}
+ (FLXSClassFactory*)static_FLXSFlexDataGridDataCell
{
    if(static_FLXSFlexDataGridDataCell==nil){
        static_FLXSFlexDataGridDataCell= [[FLXSClassFactory alloc] initWithClass:[FLXSFlexDataGridDataCell class] andProperties:nil ];
    }
    return static_FLXSFlexDataGridDataCell;
}
+ (FLXSClassFactory*)static_FLXSFlexDataGridDataCell2
{
    if(static_FLXSFlexDataGridDataCell2==nil){
        static_FLXSFlexDataGridDataCell2= [[FLXSClassFactory alloc] initWithClass:[FLXSFlexDataGridDataCell class] andProperties:nil ];
    }
    return static_FLXSFlexDataGridDataCell2;
}
+ (FLXSClassFactory*)static_FLXSFlexDataGridDataCellUIComponent
{
    if(static_FLXSFlexDataGridDataCellUIComponent==nil){
        static_FLXSFlexDataGridDataCellUIComponent= [[FLXSClassFactory alloc] initWithClass:[FLXSFlexDataGridDataCell class] andProperties:nil ];
    }
    return static_FLXSFlexDataGridDataCellUIComponent;
}
+ (FLXSClassFactory*)static_FLXSFlexDataGridHeaderCell
{
    if(static_FLXSFlexDataGridHeaderCell==nil){
        static_FLXSFlexDataGridHeaderCell= [[FLXSClassFactory alloc] initWithClass:[FLXSFlexDataGridHeaderCell class] andProperties:nil ];
    }
    return static_FLXSFlexDataGridHeaderCell;
}
+ (FLXSClassFactory*)static_FLXSFlexDataGridFooterCell
{
    if(static_FLXSFlexDataGridFooterCell==nil){
        static_FLXSFlexDataGridFooterCell= [[FLXSClassFactory alloc] initWithClass:[FLXSFlexDataGridFooterCell class] andProperties:nil ];
    }
    return static_FLXSFlexDataGridFooterCell;
}
+ (FLXSClassFactory*)static_FLXSFlexDataGridFilterCell
{
    if(static_FLXSFlexDataGridFilterCell==nil){
        static_FLXSFlexDataGridFilterCell= [[FLXSClassFactory alloc] initWithClass:[FLXSFlexDataGridFilterCell class] andProperties:nil ];
    }
    return static_FLXSFlexDataGridFilterCell;
}
+ (NSString*)LOCK_MODE_LEFT
{
	return LOCK_MODE_LEFT;
}
+ (NSString*)LOCK_MODE_RIGHT
{
	return LOCK_MODE_RIGHT;
}
+ (NSString*)LOCK_MODE_NONE
{
	return LOCK_MODE_NONE;
}
+ (float)DEFAULT_COLUMN_WIDTH
{
	return DEFAULT_COLUMN_WIDTH;
}
+ (NSString*)COLUMN_WIDTH_MODE_NONE
{
	return COLUMN_WIDTH_MODE_NONE;
}
+ (NSString*)COLUMN_WIDTH_MODE_FIXED
{
	return COLUMN_WIDTH_MODE_FIXED;
}
+ (NSString*)COLUMN_WIDTH_MODE_FIT_TO_CONTENT
{
	return COLUMN_WIDTH_MODE_FIT_TO_CONTENT;
}
+ (NSString*)COLUMN_WIDTH_MODE_PERCENT
{
	return COLUMN_WIDTH_MODE_PERCENT;
}

+ (NSString*)FORMAT_NONE
{
    return FORMAT_NONE;
}
+ (NSString*)FORMAT_DATE
{
    return FORMAT_DATE;
}
+ (NSString*)FORMAT_DATE_TIME
{
    return FORMAT_DATE_TIME;
}
+ (NSString*)FORMAT_TIME
{
    return FORMAT_TIME;
}
+ (NSString*)FORMAT_CURRENCY
{
    return FORMAT_CURRENCY;
}
+ (NSString*)FORMAT_NUMBER
{
    return FORMAT_NUMBER;
}
@end

