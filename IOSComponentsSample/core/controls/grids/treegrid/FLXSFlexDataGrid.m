


#import <QuartzCore/QuartzCore.h>
#import "FLXSRendererCache.h"

#import "FLXSFlexDataGrid.h"
#import "FLXSTriStateCheckBox.h"
#import "FLXSFlexDataGridBodyContainer.h"
#import "FLXSRowEditBehavior.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSFlexDataGridHeaderContainer.h"
#import "FLXSLockedContent.h"
#import "FLXSInsertionLocationInfo.h"
#import "FLXSTooltipBehavior.h"
#import "FLXSSpinnerBehavior.h"
#import "FLXSColumnHeaderOperationBehavior.h"
#import "FLXSRowInfo.h"
#import "FLXSFlexDataGridColumnGroup.h"
#import "FLXSUserSettingsController.h"
#import "FLXSPrintOptions.h"
#import "FLXSToolbarAction.h"
#import "FLXSCellUtils.h"
#import "FLXSIFlexDataGridCell.h"
#import "FLXSTextInput.h"
#import "FLXSLabelData.h"
#import "FLXSExtendedFilterPageSortChangeEvent.h"
#import "FLXSExtendedExportController.h"
#import "FLXSFilterPageSortChangeEvent.h"
#import "FLXSIExtendedPager.h"
#import "FLXSPrintFlexDataGrid.h"
#import "FLXSScrollEventDetail.h"
#import "FLXSScrollEvent.h"
#import "FLXSComponentInfo.h"
#import "FLXSGridPreferencesInfo.h"
#import "FLXSUserSettingsOptions.h"
#import "FLXSConstants.h"
#import "FLXSExtendedUIUtils.h"
#import "FLXSFilterSort.h"
#import "FLXSFlexDataGridVirtualBodyContainer.h"
#import "FLXSKeyValuePairCollection.h"
#import "FLXSChangeInfo.h"
#import "FLXSSelectionInfo.h"
#import "FLXSLevelSelectionInfo.h"
#import "UIScrollView+UIScrollViewAdditions.h"
#import "FLXSStyleManager.h"
#import "FLXSMultiColumnSortViewController.h"
#import "NSMutableArray+QueueAdditions.h"
#import "FLXSDateRange.h"
#import "FLXSWrapperEvent.h"
#import "FLXSSettingsViewController.h"
#import "FLXSSavePreferenceViewController.h"
#import "FLXSTouchEvent.h"
#import "FLXSFontInfo.h"
#import <objc/message.h>

 @protocol FLXSIFlexDataGridCell;


static FLXSClassFactory* static_FLXSFlexDataGridMultiSortRenderer;
static NSDictionary *flxsFlexDataGridProps;

static NSDictionary *flxsFlexDataGridColumnLevelProps;
static NSDictionary *flxsFlexDataGridColumnProps;
static NSDictionary *flxsFlexDataGridColumnGroupProps;
static NSArray *allEvents;
static UITextField* measurerText;

@implementation FLXSFlexDataGrid {
@private
    NSMutableDictionary * _flattenedLevels;
    NSMutableArray *_changes;
    FLXSPrintOptions *_printOptions;
    FLXSPrintOptions *_pdfOptions;
    FLXSExportOptions *_excelOptions;
    FLXSExportOptions *_wordOptions;
    
    NSString *_preferencesToPersist;
    BOOL _enablePreferencePersistence;
    NSString *_preferencePersistenceMode;
    NSString *_preferencePersistenceKey;
    NSString *_preferences;
    NSString *_lastPrintOptionsString;
    NSString *_persistedPrintOptionsString;
    NSArray * _printExportData;
    BOOL _preferencesSet;
    BOOL _userPersistedColumnWidths;
    BOOL _useCompactPreferences;
    BOOL _preferencesLoaded;
    NSString* _userSettingsOptionsFunction;
    BOOL _enableMultiplePreferences;
    FLXSGridPreferencesInfo *_gridPreferencesInfo;
    FLXSPreferenceInfo *_currentPreference;
    BOOL _autoLoadPreferences;
    FLXSClassFactory *_popupFactorySaveSettingsPopup;
    FLXSClassFactory *_popupFactoryOpenSettingsPopup;
    FLXSClassFactory *_popupFactorySettingsPopup;
    FLXSClassFactory *_popupFactoryPrintOptions;
    FLXSClassFactory *_popupFactoryExportOptions;
    NSArray *_spinnerColors;
    int _spinnerRadius;
    int _spinnerThickness;
    float _spinnerGridAlpha;
    UIColor *_backgroundColor;
    NSString *_textAlign;
    float _multiColumnSortNumberWidth;
    float _multiColumnSortNumberHeight;
    NSString *_multiColumnSortNumberStyleName;
    FLXSFontInfo *_columnGroupStyleName;
    FLXSFontInfo *_headerStyleName;
    FLXSFontInfo *_pagerStyleName;
    FLXSFontInfo *_footerStyleName;
    BOOL _verticalGridLines;
    BOOL _horizontalGridLines;
    UIColor* _verticalGridLineColor;
    UIColor* _horizontalGridLineColor;
    int _horizontalGridLineThickness;
    int _verticalGridLineThickness;
    BOOL _headerVerticalGridLines;
    BOOL _headerHorizontalGridLines;
    UIColor* _headerVerticalGridLineColor;
    UIColor* _headerHorizontalGridLineColor;
    float _headerHorizontalGridLineThickness;
    float _headerVerticalGridLineThickness;
    BOOL _headerDrawTopBorder;
    BOOL _columnGroupVerticalGridLines;
    BOOL _columnGroupHorizontalGridLines;
    UIColor* _columnGroupVerticalGridLineColor;
    UIColor* _columnGroupHorizontalGridLineColor;
    float _columnGroupHorizontalGridLineThickness;
    float _columnGroupVerticalGridLineThickness;
    BOOL _columnGroupDrawTopBorder;
    BOOL _filterVerticalGridLines;
    BOOL _filterHorizontalGridLines;
    UIColor* _filterVerticalGridLineColor;
    UIColor* _filterHorizontalGridLineColor;
    float _filterHorizontalGridLineThickness;
    float _filterVerticalGridLineThickness;
    BOOL _filterDrawTopBorder;
    BOOL _footerVerticalGridLines;
    BOOL _footerHorizontalGridLines;
    UIColor* _footerVerticalGridLineColor;
    UIColor* _footerHorizontalGridLineColor;
    float _footerHorizontalGridLineThickness;
    float _footerVerticalGridLineThickness;
    BOOL _footerDrawTopBorder;
    BOOL _pagerVerticalGridLines;
    BOOL _pagerHorizontalGridLines;
    UIColor* _pagerVerticalGridLineColor;
    UIColor* _pagerHorizontalGridLineColor;
    float _pagerHorizontalGridLineThickness;
    float _pagerVerticalGridLineThickness;
    BOOL _pagerDrawTopBorder;
    BOOL _rendererVerticalGridLines;
    BOOL _rendererHorizontalGridLines;
    UIColor * _rendererVerticalGridLineColor;
    UIColor * _rendererHorizontalGridLineColor;
    float _rendererHorizontalGridLineThickness;
    float _rendererVerticalGridLineThickness;
    BOOL _rendererDrawTopBorder;
    NSArray*_selectionColorFLXS;
    NSString * _sortArrowSkin;
    float _paddingLeft;
    float _paddingRight;
    float _paddingTop;
    float _paddingBottomFLXS;
    float _headerPaddingLeft;
    float _headerPaddingRight;
    float _headerPaddingTop;
    float _headerPaddingBottom;
    float _columnGroupPaddingLeft;
    float _columnGroupPaddingRight;
    float _columnGroupPaddingTop;
    float _columnGroupPaddingBottom;
    float _footerPaddingLeft;
    float _footerPaddingRight;
    float _footerPaddingTop;
    float _footerPaddingBottom;
    float _filterPaddingLeft;
    float _filterPaddingRight;
    float _filterPaddingTop;
    float _filterPaddingBottom;
    float _pagerPaddingLeft;
    float _pagerPaddingRight;
    float _pagerPaddingTop;
    float _pagerPaddingBottom;
    float _rendererPaddingLeft;
    float _rendererPaddingRight;
    float _rendererPaddingTop;
    float _rendererPaddingBottom;
    NSArray *_alternatingItemColors;
    NSArray *_alternatingTextColors;
    NSArray *_editItemColor;
    UIColor *_editTextColor;
    UIColor * _selectionDisabledColor;
    NSString *_disclosureOpenIcon;
    NSString *_disclosureClosedIcon;
    NSString *_columnGroupOpenIcon;
    NSString *_columnGroupClosedIcon;
    UIColor * _rollOverColor;
    UIColor * _activeCellColor;
    NSArray *_footerColors;
    NSArray *_footerRollOverColors;
    NSArray *_filterColors;
    NSArray *_filterRollOverColors;
    NSArray *_headerColors;
    NSArray *_headerRollOverColors;
    NSArray *_columnGroupColors;
    NSArray *_columnGroupRollOverColors;
    NSArray *_rendererColors;
    NSArray* _rendererRollOverColors;
    NSArray *_pagerColors;
    NSArray *_pagerRollOverColors;
    UIColor * _textSelectedColor;
    UIColor *  _textRollOverColor;
    UIColor * _textDisabledColor;
    float _lockedSeparatorThickness;
    UIColor *_lockedSeparatorColor;
    UIColor * _errorBackgroundColor;
    UIColor * _errorBorderColor;
    float _dragAlpha;
    NSString *_dragRowBorderStyle;
    NSArray *_fixedColumnFillColors;
    UIColor *_columnMoveResizeSeparatorColor;
    UIColor *_headerSortSeparatorColor;
    int _headerSortSeparatorRight;
    float _columnMoveAlpha;
    NSString *_fontName;
    float _fontSize;
    FLXSFlexDataGridColumnLevel *_columnLevel;
    
    NSMutableArray *parserQueue;
    FLXSFlexDataGridColumnLevel *parserLevel;
    
    NSString *_filterFunction;
    BOOL _showSpinnerOnCreationComplete;
    UIColor *_spinnerLabelBackgroundColor;
    BOOL _spinnerLabelShowBackground;
    UIColor *_spinnerLabelColor;
    BOOL _enablePullToRefresh;
    NSAttributedString *_pullToRefreshAttributedTitle;
}

@synthesize printExportData=_printExportData;
@synthesize displayOrder;
@synthesize rendererCache = _rendererCache;
@synthesize treeDataGridContainer = _treeDataGridContainer;
@synthesize doubleClickEnabled=_doubleClickEnabled;
@synthesize treeDataGridHeader = _treeDataGridHeader;
@synthesize treeDataGridFilter = _treeDataGridFilter;
@synthesize treeDataGridFooter = _treeDataGridFooter;
@synthesize treeDataGridPager = _treeDataGridPager;
@synthesize currentCell = _currentCell;
@synthesize leftLockedHeader = _leftLockedHeader;
@synthesize leftLockedContent = _leftLockedContent;
@synthesize leftLockedFooter = _leftLockedFooter;
@synthesize rightLockedHeader = _rightLockedHeader;
@synthesize rightLockedContent = _rightLockedContent;
@synthesize rightLockedFooter = _rightLockedFooter;
@synthesize currentPoint = _currentPoint;
@synthesize isHScrollBarVisible = _isHScrollBarVisible;
@synthesize isVScrollBarVisible = _isVScrollBarVisible;
@synthesize useRollOver = _useRollOver;
@synthesize dataProviderFLXS = _dataProvider;
@synthesize dataProviderSet = _dataProviderSet;
@synthesize preservePager = _preservePager;
@synthesize bottomBarLeft = _bottomBarLeft;
@synthesize bottomBarRight = _bottomBarRight;
@synthesize contextMenuShown = _contextMenuShown;
@synthesize hasFilter = _hasFilter;
@synthesize multiSortRenderer = _multiSortRenderer;
@synthesize isScrolling = _isScrolling;
@synthesize needHorizontalRecycle = _needHorizontalRecycle;
@synthesize childrenField = _childrenField;
@synthesize dragColumn = _dragColumn;
@synthesize enableExport = _enableExport;
@synthesize enableDoubleClickEdit = _enableDoubleClickEdit;
@synthesize enableMultiColumnSort = _enableMultiColumnSort;

@synthesize enableDrawAsYouScroll = _enableDrawAsYouScroll;
@synthesize enableDynamicLevels = _enableDynamicLevels;
@synthesize dynamicLevelHasChildrenFunction = _dynamicLevelHasChildrenFunction;
@synthesize enableTriStateCheckbox = _enableTriStateCheckbox;
@synthesize enableSelectionBubble = _enableSelectionBubble;
@synthesize enableSelectionCascade = _enableSelectionCascade;
@synthesize enableHeightAutoAdjust = _enableHeightAutoAdjust;
@synthesize maxAutoAdjustHeight = _maxAutoAdjustHeight;
@synthesize enableHideIfNoChildren = _enableHideIfNoChildren;
@synthesize enableHideBuiltInContextMenuItems = _enableHideBuiltInContextMenuItems;
@synthesize enableCopy = _enableCopy;
@synthesize enablePrint = _enablePrint;
@synthesize useSelectedSelectAllState = _useSelectedSelectAllState;
@synthesize selectAllState = _selectAllState;
@synthesize editor = _editor;
@synthesize editCell = _editCell;
@synthesize triggerEvent = _triggerEvent;
@synthesize filterDirty = _filterDirty;
@synthesize currentExpandLevel = _currentExpandLevel;
@synthesize updateTotalRecords = _updateTotalRecords;
@synthesize totalRecords = _totalRecords;
@synthesize inRebuildBody = _inRebuildBody;
@synthesize tooltipBehavior = _tooltipBehavior;
@synthesize currentExportLevel = _currentExportLevel;
@synthesize lastAutoRefresh = _lastAutoRefresh;
@synthesize enableAutoRefresh = _enableAutoRefresh;
@synthesize autoRefreshInterval = _autoRefreshInterval;
@synthesize autoRefreshTimer = _autoRefreshTimer;
@synthesize expandTooltip = _expandTooltip;
@synthesize collapseTooltip = _collapseTooltip;
@synthesize builtInActions = _builtInActions;
@synthesize errorMap = _errorMap;
@synthesize hasErrors = _hasErrors;
@synthesize allowMultipleRowDrag = _allowMultipleRowDrag;
@synthesize variableRowHeight = _variableRowHeight;
@synthesize variableRowHeightUseRendererForCalculation = _variableRowHeightUseRendererForCalculation;
@synthesize variableRowHeightOffset = _variableRowHeightOffset;
@synthesize rebuildGridOnDataProviderChange = _rebuildGridOnDataProviderChange;
@synthesize clearSelectionOnDataProviderChange = _clearSelectionOnDataProviderChange;
@synthesize clearOpenItemsOnDataProviderChange = _clearOpenItemsOnDataProviderChange;
@synthesize clearErrorsOnDataProviderChange = _clearErrorsOnDataProviderChange;
@synthesize clearChangesOnDataProviderChange = _clearChangesOnDataProviderChange;
@synthesize clearSelectionOnFilter = _clearSelectionOnFilter;
@synthesize generateColumns = _generateColumns;
@synthesize enableVirtualScroll = _enableVirtualScroll;
@synthesize cellBackgroundColorFunction = _cellBackgroundColorFunction;
@synthesize cellTextColorFunction = _cellTextColorFunction;
@synthesize enableDefaultDisclosureIcon = _enableDefaultDisclosureIcon;
@synthesize changes = _changes;
@synthesize enableTrackChanges = _enableTrackChanges;
@synthesize enableSelectionBasedOnSelectedField = _enableSelectionBasedOnSelectedField;
@synthesize dispatchCellRenderered = _dispatchCellRenderered;
@synthesize dispatchRendererInitialized = _dispatchRendererInitialized;
@synthesize dispatchCellCreated = _dispatchCellCreated;
@synthesize enableActiveCellHighlight = _enableActiveCellHighlight;
@synthesize enableEditRowHighlight = _enableEditRowHighlight;
@synthesize multiColumnSortNumberFields = _multiColumnSortNumberFields;
@synthesize filterExcludeObjectsWithoutMatchField = _filterExcludeObjectsWithoutMatchField;
@synthesize globalFilterMatchFunction = _globalFilterMatchFunction;
@synthesize noDataMessage = _noDataMessage;
@synthesize enableSplitHeader = _enableSplitHeader;
@synthesize enableSelectionExclusion = _enableSelectionExclusion;
@synthesize selectionChain = _selectionChain;
@synthesize hasRowSpanOrColSpan = _hasRowSpanOrColSpan;
@synthesize rowSpanFunction = _rowSpanFunction;
@synthesize colSpanFunction = _colSpanFunction;
@synthesize enableEagerDraw = _enableEagerDraw;
@synthesize getRowHeightFunction = _getRowHeightFunction;
@synthesize printComponentFactory = _printComponentFactory;
@synthesize enableStickyControlKeySelection = _enableStickyControlKeySelection;
@synthesize enableFillerRows = _enableFillerRows;
@synthesize enableDataCellOptmization = _enableDataCellOptmization;
@synthesize recalculateSeedOnEachScroll = _recalculateSeedOnEachScroll;
@synthesize getChildrenFunction = _getChildrenFunction;
@synthesize spinner = _spinner;
@synthesize spinnerBehavior = _spinnerBehavior;
@synthesize enableLocalStyles = _enableLocalStyles;
@synthesize enableDelayChange = _enableDelayChange;
@synthesize enableColumnWidthUserOverride = _enableColumnWidthUserOverride;
@synthesize inUpdate = _inUpdate;
@synthesize changePending = _changePending;
@synthesize rebuildBodyPending = _rebuildBodyPending;
@synthesize variableHeaderHeight = _variableHeaderHeight;
@synthesize fillerInvalidated = _fillerInvalidated;
@synthesize cellEditableFunction = _cellEditableFunction;
@synthesize columnHeaderOperationBehavior = _columnHeaderOperationBehavior;
@synthesize enableColumnHeaderOperation = _enableColumnHeaderOperation;
@synthesize rowEditBehavior = _rowEditBehavior;
@synthesize enableDoubleClickTimer = _enableDoubleClickTimer;
@synthesize nativeExcelExporter = _nativeExcelExporter;

@synthesize printOptions = _printOptions;
@synthesize pdfOptions = _pdfOptions;
@synthesize excelOptions = _excelOptions;
@synthesize wordOptions = _wordOptions;


@synthesize preferencesToPersist = _preferencesToPersist;
@synthesize enablePreferencePersistence = _enablePreferencePersistence;
@synthesize preferencePersistenceMode = _preferencePersistenceMode;
@synthesize preferencePersistenceKey = _preferencePersistenceKey;
@synthesize preferences = _preferences;
@synthesize lastPrintOptionsString = _lastPrintOptionsString;
@synthesize persistedPrintOptionsString = _persistedPrintOptionsString;
@synthesize preferencesSet = _preferencesSet;
@synthesize userPersistedColumnWidths = _userPersistedColumnWidths;
@synthesize useCompactPreferences = _useCompactPreferences;
@synthesize preferencesLoaded = _preferencesLoaded;
@synthesize userSettingsOptionsFunction = _userSettingsOptionsFunction;
@synthesize enableMultiplePreferences = _enableMultiplePreferences;
@synthesize gridPreferencesInfo = _gridPreferencesInfo;
@synthesize currentPreference = _currentPreference;
@synthesize autoLoadPreferences = _autoLoadPreferences;
@synthesize popupFactorySaveSettingsPopup = _popupFactorySaveSettingsPopup;
@synthesize popupFactoryOpenSettingsPopup = _popupFactoryOpenSettingsPopup;
@synthesize popupFactorySettingsPopup = _popupFactorySettingsPopup;
@synthesize popupFactoryPrintOptions = _popupFactoryPrintOptions;
@synthesize popupFactoryExportOptions = _popupFactoryExportOptions;

@synthesize spinnerRadius = _spinnerRadius;
@synthesize spinnerGridAlpha = _spinnerGridAlpha;
@synthesize textAlign = _textAlign;
@synthesize multiColumnSortNumberWidth = _multiColumnSortNumberWidth;
@synthesize multiColumnSortNumberHeight = _multiColumnSortNumberHeight;
@synthesize multiColumnSortNumberStyleName = _multiColumnSortNumberStyleName;
@synthesize columnGroupStyleName = _columnGroupStyleName;
@synthesize headerStyleName = _headerStyleName;
@synthesize pagerStyleName = _pagerStyleName;
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
@synthesize columnGroupPaddingLeft = _columnGroupPaddingLeft;
@synthesize columnGroupPaddingRight = _columnGroupPaddingRight;
@synthesize columnGroupPaddingTop = _columnGroupPaddingTop;
@synthesize columnGroupPaddingBottom = _columnGroupPaddingBottom;
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
@synthesize editItemColors = _editItemColor;
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
@synthesize lockedSeparatorThickness = _lockedSeparatorThickness;
@synthesize lockedSeparatorColor = _lockedSeparatorColor;
@synthesize errorBackgroundColor = _errorBackgroundColor;
@synthesize errorBorderColor = _errorBorderColor;
@synthesize dragAlpha = _dragAlpha;
@synthesize dragRowBorderStyle = _dragRowBorderStyle;
@synthesize fixedColumnFillColors = _fixedColumnFillColors;
@synthesize columnMoveResizeSeparatorColor = _columnMoveResizeSeparatorColor;
@synthesize headerSortSeparatorColor = _headerSortSeparatorColor;
@synthesize headerSortSeparatorRight = _headerSortSeparatorRight;
@synthesize columnMoveAlpha = _columnMoveAlpha;

@synthesize fontName = _fontName;
@synthesize fontSize = _fontSize;

@synthesize filterFunction = _filterFunction;

@synthesize showSpinnerOnCreationComplete = _showSpinnerOnCreationComplete;

@synthesize spinnerLabelBackgroundColor = _spinnerLabelBackgroundColor;
@synthesize spinnerLabelShowBackground = _spinnerLabelShowBackground;
@synthesize spinnerLabelColor = _spinnerLabelColor;

@synthesize enablePullToRefresh = _enablePullToRefresh;
@synthesize pullToRefreshAttributedTitle = _pullToRefreshAttributedTitle;

@synthesize exportTypeList = _exportTypeList;

-(FLXSFlexDataGridBodyContainer*)bodyContainer
{
	return _treeDataGridContainer;
}

-(FLXSFlexDataGridVirtualBodyContainer*)virtualBodyContainer
{
	return (FLXSFlexDataGridVirtualBodyContainer*)self.bodyContainer;
}

-(FLXSFlexDataGridHeaderContainer*)headerContainer
{
	return _treeDataGridHeader;
}

-(FLXSFlexDataGridHeaderContainer*)filterContainer
{
	return _treeDataGridFilter;
}

-(FLXSFlexDataGridHeaderContainer*)footerContainer
{
	return _treeDataGridFooter;
}

-(FLXSFlexDataGridHeaderContainer*)pagerContainer
{
	return _treeDataGridPager;
}

-(BOOL)verticalSpill
{
	return self.bodyContainer.verticalSpill;
}

-(FLXSFlexDataGridBodyContainer*)createBodyContainer
{
 	return [[FLXSFlexDataGridBodyContainer alloc] initWithGrid:self];
}

-(FLXSFlexDataGridHeaderContainer*)createChromeContainer
{
	return [[FLXSFlexDataGridHeaderContainer alloc] initWithGrid:self];
}

-(FLXSLockedContent*)createLockedContent
{
	return [[FLXSLockedContent alloc] initWithGrid:self];
}

-(FLXSElasticContainer*)createElasticContainer
{
	return [[FLXSElasticContainer alloc] initWithGrid:self];
}

-(id)initWithFrame:(CGRect)frame {
    self =     [super initWithFrame:frame];
    if (self)
    {
        [self initCommon];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder {
    self =     [super initWithCoder:aDecoder];
    if (self)
    {
        [self initCommon];
    }
    return self;
}
-(id)init
{
    self = [super init];
	if (self)
	{
        [self initCommon];
    }
	return self;
    
}

- (void)initCommon {
    
//    self.printOptions = [FLXSPrintOptions create:NO];
//    self.pdfOptions = [FLXSPrintOptions create:YES];
    self.excelOptions = [FLXSExportOptions create:[FLXSExportOptions CSV_EXPORT]];
    self.wordOptions = [FLXSExportOptions create:[FLXSExportOptions DOC_EXPORT]];
    self.enableDoubleClickEdit = YES;
    self.autoLoadPreferences = YES;
    self.useCompactPreferences=YES;
    self.preferencePersistenceMode = @"client";
    self.selectedCells = [[NSMutableArray alloc]init];
    self.enableLockedSectionSeparators=YES;
    self.spinnerColor = [UIColor blackColor] ;
    self.spinnerLabelColor= [UIColor blackColor];
    self.spinnerLabelBackgroundColor = [UIColor clearColor];
    self.spinnerLabelShowBackground=YES;
    self.spinnerLabel = @"Loading, Please wait...";
    self.pullToRefreshAttributedTitle = [[NSAttributedString alloc] initWithString:@"Pull To Refresh"];
    _currentPoint = [[FLXSInsertionLocationInfo alloc] init];
    self.allowInteractivity=YES;
    self.lockDisclosureCell=YES;
    self.spinnerGridAlpha = 0.4;
    self.enableEagerDraw=YES;
    self.persistedPrintOptionsString=@"";
    self.lockedSeparatorThickness=3;

    _isHScrollBarVisible = 0;
    _isVScrollBarVisible = 0;
    _useRollOver = YES;
    _dataProviderSet = NO;
    _preservePager = NO;
    _bottomBarLeft = [[UIView alloc] init];
    _bottomBarRight = [[UIView alloc] init];
    _contextMenuShown = NO;
    _hasFilter = NO;
    _isScrolling = NO;
    _needHorizontalRecycle = NO;
    _childrenField = @"";
    _enableDrawAsYouScroll = NO;
    _enableDynamicLevels = NO;
    __typeof(self) __weak weakSelf = self;
    _dynamicLevelHasChildrenFunction =  ^(NSObject* item) {
        if([weakSelf getLength:([weakSelf getChildren:item level:weakSelf.columnLevel filter:NO page:NO sort:NO ])]>0)
            return YES;
        else
            return NO;
    };;
    _enableTriStateCheckbox = YES;
    _enableSelectionBubble = YES;
    _enableSelectionCascade = YES;
    _maxAutoAdjustHeight = 500;
    _enableHideBuiltInContextMenuItems = YES;
    _useSelectedSelectAllState = FLXSTriStateCheckBox.STATE_UNCHECKED;
    _selectAllState = FLXSTriStateCheckBox.STATE_UNCHECKED;
    _triggerEvent = YES;
    _filterDirty = NO;
    _currentExpandLevel = 0;
    _updateTotalRecords = YES;
    _inRebuildBody = NO;
    _lastAutoRefresh = [[NSDate alloc] init];
    _autoRefreshInterval = 30000;
    _expandTooltip = @"Expand";
    _collapseTooltip = @"Collapse";
    _builtInActions = @"edit,delete,moveTo,moveUp,moveDown,separator,addRow,filter";
    _errorMap = [[FLXSKeyValuePairCollection alloc] init];
    _hasErrors = NO;
    _allowMultipleRowDrag = NO;
    _variableRowHeight = NO;
    _variableRowHeightUseRendererForCalculation = NO;
    _variableRowHeightOffset = 0;
    _rebuildGridOnDataProviderChange = YES;
    _clearSelectionOnDataProviderChange = YES;
    _clearOpenItemsOnDataProviderChange = YES;
    _clearErrorsOnDataProviderChange = YES;
    _clearChangesOnDataProviderChange = YES;
    _clearSelectionOnFilter = NO;
    _generateColumns = YES;
    _enableMultiColumnSort=NO;
    _enableDefaultDisclosureIcon = YES;
    _changes = [[NSMutableArray alloc] init];
    _enableTrackChanges = NO;
    _dispatchCellRenderered = NO;
    _dispatchRendererInitialized = NO;
    _dispatchCellCreated = NO;
    _enableActiveCellHighlight = YES;
    _enableEditRowHighlight = YES;
    _multiColumnSortNumberFields = 4;
    _filterExcludeObjectsWithoutMatchField = NO;
    _globalFilterMatchFunction = nil;
    _noDataMessage = @"No Records Found";
    _enableSplitHeader = YES;
    _enableSelectionExclusion = NO;
    _selectionChain = [[NSMutableDictionary alloc] init];
    _hasRowSpanOrColSpan = NO;
    _enableEagerDraw = NO;
    _getRowHeightFunction = nil;
    [[FLXSStyleManager instance] applyStylesToGrid:self];

//    _printComponentFactory = [[FLXSClassFactory alloc] initWithClass:[FLXSPrintFlexDataGrid class] andProperties:nil];
    self.popupFactorySaveSettingsPopup = [[FLXSClassFactory alloc] initWithNibName:@"FLXSSavePreferenceViewController"
                                                                andControllerClass:[FLXSSavePreferenceViewController class]
                                                                    withProperties:nil];
    self.popupFactorySettingsPopup = [[FLXSClassFactory alloc] initWithNibName:@"FLXSSettingsViewController"
                                                            andControllerClass:[FLXSSettingsViewController class]
                                                                withProperties:nil];

    if(![FLXSUIUtils isIPad]){

        self.popupFactorySaveSettingsPopup = [[FLXSClassFactory alloc] initWithNibName:@"FLXSiPhoneSavePreferenceViewController"
                                                                    andControllerClass:[FLXSSavePreferenceViewController class]
                                                                        withProperties:nil];
        self.popupFactorySettingsPopup = [[FLXSClassFactory alloc] initWithNibName:@"FLXSiPhoneSettingsViewController"
                                                                andControllerClass:[FLXSSettingsViewController class]
                                                                    withProperties:nil];

    }

    _enableStickyControlKeySelection = YES;
    _enableFillerRows = YES;
    _enableDataCellOptmization = YES;
    _recalculateSeedOnEachScroll = NO;
    _getChildrenFunction = nil;
    _enableLocalStyles = YES;
    _enableDelayChange = YES;
    _enableColumnWidthUserOverride = YES;
    _inUpdate = NO;
    _changePending = NO;
    _rebuildBodyPending = NO;
    _variableHeaderHeight = NO;
    _fillerInvalidated = NO;
    _enableDoubleClickTimer = YES;
    _fontSize = 0;
    _fontName = [UIFont systemFontOfSize:_fontSize].fontName;
    self.displayOrder= @"pager,header,filter,body,footer";
    
    self.selectionMode = [FLXSFlexDataGrid SELECTION_MODE_MULTIPLE_ROWS];

    _rendererCache =[[FLXSRendererCache alloc] initWithGrid:self];
    _treeDataGridContainer =[self createBodyContainer];
    _treeDataGridHeader =[self createChromeContainer];
    _treeDataGridFooter =[self createChromeContainer];
    _treeDataGridPager =[self createChromeContainer];
    _treeDataGridFilter =[self createChromeContainer];
    self.leftLockedVerticalSeparator = [[FLXSBaseUIControl alloc]init];
    self.rightLockedVerticalSeparator = [[FLXSBaseUIControl alloc] init];
    self.filterContainer.chromeType=[FLXSRowPositionInfo ROW_TYPE_FILTER];
    self.pagerContainer.chromeType=[FLXSRowPositionInfo ROW_TYPE_PAGER];
    self.footerContainer.chromeType=[FLXSRowPositionInfo ROW_TYPE_FOOTER];
    _leftLockedHeader = [self createLockedContent];
    _leftLockedFooter = [self createLockedContent];
    _leftLockedContent = [self createElasticContainer];
    _leftLockedContent.boundContainer= self.bodyContainer;
    _rightLockedHeader = [self createLockedContent];
    _rightLockedFooter = [self createLockedContent]   ;
    _rightLockedContent = [self createElasticContainer];
    _rightLockedContent.boundContainer= self.bodyContainer;
    self.horizontalScrollPolicy = @"off";
    
    self.itemFilters = [[NSMutableDictionary alloc]init];
    self.tooltipBehavior =[[FLXSTooltipBehavior alloc] initWithGrid:self];
    self.spinnerBehavior =[[FLXSSpinnerBehavior alloc] initWithGrid:self];
    self.columnHeaderOperationBehavior =[[FLXSColumnHeaderOperationBehavior alloc] initWithGrid:self];
    self.rowEditBehavior = [[FLXSRowEditBehavior alloc] initWithGrid:self];
//    self.pdfOptions.asynch=YES;
//    self.printOptions.asynch=YES;
    self.borderSides = [[NSArray alloc] initWithObjects:@"left",@"right",@"bottom",@"top",nil];
    self.opaque=NO;
    self.backgroundColor = [UIColor clearColor];





    [self.filterContainer addEventListenerOfType:[FLXSExtendedFilterPageSortChangeEvent FILTER_CHANGE] usingTarget:self withHandler:@selector(onRootFilterChange:)];
    [self.headerContainer addEventListenerOfType:[FLXSFlexDataGridEvent SELECT_ALL_CHECKBOX_CHANGED] usingTarget:self withHandler:@selector(onSelectAllChanged:)];
    [self.headerContainer addEventListenerOfType:[FLXSFlexDataGridEvent COLUMNS_RESIZED] usingTarget:self withHandler:@selector(onColumnResized:)];
    [self.bodyContainer addEventListenerOfType:[FLXSFlexDataGridEvent SCROLL] usingTarget:self withHandler:@selector(onContainerScroll:)];
    [self.bodyContainer addEventListenerOfType:[FLXSFlexDataGridEvent COLUMNS_RESIZED] usingTarget:self withHandler:@selector(onColumnResized:)];
    [self.pagerContainer addEventListenerOfType:[FLXSExtendedFilterPageSortChangeEvent PAGE_CHANGE] usingTarget:self withHandler:@selector(onRootPageChange:)];

}
-(void)didMoveToSuperview {
    [super didMoveToSuperview];
}

-(void)setNeedsDisplay{
    [super setNeedsDisplay];
}

-(void)setBounds:(CGRect)b {
    super.bounds = b;
    FLXSEvent* evt1 = [[FLXSEvent alloc] init];
    evt1.target = self;
    evt1.type = [FLXSEvent RESIZE];
    [self dispatchEvent:evt1];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint locationPoint = [[touches anyObject] locationInView:self];
    FLXSTouchEvent* evt = [[FLXSTouchEvent alloc] init];
    evt.target = self;
    evt.type = touches.count==2?[FLXSTouchEvent DOUBLE_TAP]:[FLXSTouchEvent TAP];
    evt.localX = locationPoint.x;
    evt.localY = locationPoint.y;
    
    [self dispatchEvent:evt];
    FLXSTouchEvent* evt1 = [[FLXSTouchEvent alloc] init];
    evt1.target = self;
    evt1.type = [FLXSTouchEvent TOUCH_DOWN];
    evt1.localX = locationPoint.x;
    evt1.localY = locationPoint.y;
    [self dispatchEvent:evt1];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint locationPoint = [[touches anyObject] locationInView:self];
    FLXSTouchEvent* evt1 = [[FLXSTouchEvent alloc] init];
    evt1.target = self;
    evt1.type = [FLXSTouchEvent TOUCH_MOVE];
    evt1.localX = locationPoint.x;
    evt1.localY = locationPoint.y;
    [self dispatchEvent:evt1];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint locationPoint = [[touches anyObject] locationInView:self];
    FLXSTouchEvent* evt1 = [[FLXSTouchEvent alloc] init];
    evt1.target = self;
    evt1.type = [FLXSTouchEvent TOUCH_UP];
    evt1.localX = locationPoint.x;
    evt1.localY = locationPoint.y;
    [self dispatchEvent:evt1];
}

-(void)drawRect:(CGRect)rect
{
    self.inUpdate=YES;
    [self traceEvent:(@"update display list")];
	if(self.enableDynamicLevels && self.columnLevel.nextLevel==nil)
	{
		[self ensureLevelsCreated:nil level:nil ];
        [self dispatchEvent:[[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent DYNAMIC_ALL_LEVELS_CREATED] andGrid:self andLevel:self.columnLevel andColumn:nil andCell:nil andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ]];
	}
	[super drawRect :rect];
	if(_filterDirty && self.height>0)
	{
		[self processFilter];
		_filterDirty=NO;
	}
//	BOOL placed=NO;
	if(self.structureDirty && self.height>0 && self.superview!=nil)
	{
		if(!self.forceColumnsToFitVisibleArea)
            self.horizontalScrollPosition=self.verticalScrollPosition=0;
		if(self.enableSelectionBasedOnSelectedField)
		{
			[self setSelectedItemsBasedOnSelectedField:NO openItems:YES ];
		}
		[self.bodyContainer invalidateCalculatedHeight];
 		[self createComponents :0];
		if(!self.forceColumnsToFitVisibleArea )
		{
			[self recycleH:YES];
		}
		self.structureDirty=NO;
		self.placementDirty=NO;
        self.snapDirty=NO;
	}
    
	if(self.placementDirty && self.height>0 && self.componentsCreated)
	{
 		[self createComponents :0];
		if(!self.forceColumnsToFitVisibleArea)
		{
			[self recycleH:YES];
		}
        self.placementDirty=NO;
        self.snapDirty=NO;
	}
	if(self.selectionInvalid)
	{
		[self invalidateCells];
		[self refreshCheckBoxes];
        self.selectionInvalid=NO;
	}
	if(self.heightIncreased || self.widthIncreased)
	{
		if(self.variableRowHeight)
		{
			[self placeSections];
			[self rebuildBody:NO];
		}
		else
		{
			[self placeSections];
			[self.bodyContainer recycle:self.columnLevel scrollDown:YES scrollDelta:0 scrolling:YES ];
			if(!self.forceColumnsToFitVisibleArea)
				[self recycleH:YES];
		}
        if([self pager]){
            [[self pager] reBuild];
        }
        self.heightIncreased=NO;
        self.widthIncreased=NO;
	}
	if(self.snapDirty)
	{
        self.snapDirty=NO;
		[self snapToColumnWidths];

	}
	if(_needHorizontalRecycle)
	{
		_needHorizontalRecycle=NO;
		[self recycleH:YES];
	}
	if(_changePending)
	{
		_changePending=NO;
        FLXSEvent* evt= [[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent CHANGE] andGrid:self andLevel:nil andColumn:nil andCell:nil andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ];
		[self dispatchEvent:evt];
	}
	if(_rebuildBodyPending)
	{
		_rebuildBodyPending=NO;
		[self rebuildBody:NO];
	}
	if(_fillerInvalidated)
	{
		_fillerInvalidated=NO;
		[self drawFiller];
	}
	[self placeBottomBar];
	[self traceEvent:(@"end display list")];
	self.inUpdate=NO;
}

-(void)invalidateHorizontalScroll
{
	_needHorizontalRecycle=YES;
	[self setNeedsDisplay];
}

-(void)placeBottomBar
{
    //no bottom bars needed in ios
}

- (void)ensureLevelsCreated:(NSArray *)item level:(FLXSFlexDataGridColumnLevel *)level {
	if(item==nil)item=[self getRootFlat];
	if(level==nil)level=self.columnLevel;
	for(NSObject* child in item)
	{
		NSArray* children= [self getChildren:child level:level filter:NO page:NO sort:NO ];
		int childLength=[self getLength:children];
		if(level.childrenCountField && [child respondsToSelector:NSSelectorFromString(level.childrenCountField)])
		{
			childLength= [(NSNumber*) [FLXSExtendedUIUtils resolveExpression:child expression:level.childrenCountField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ] intValue];
		}
		if(level.nextLevel==nil && childLength>0)
		{
			level.nextLevel = [self.columnLevel clone:NO];
            [self dispatchEvent:[[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent DYNAMIC_LEVEL_CREATED] andGrid:self andLevel:level.nextLevel andColumn:nil andCell:nil andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ]];
			level.nextLevel.reusePreviousLevelColumns =YES;
			[self.columnLevel initializeLevel:self];
			[self reDraw];
		}
        [self ensureLevelsCreated:children level:level.nextLevel];
	}
}

-(NSString*)preferencePersistenceKey
{
    return [_preferencePersistenceKey length]>0?_preferencePersistenceKey:@"grid";
}
-(FLXSUserSettingsOptions *) getUserSettingsOptions{
    if(self.userSettingsOptionsFunction!=nil){
        SEL selector = NSSelectorFromString(self.userSettingsOptionsFunction);
        id target = self.delegate;
        return ((FLXSUserSettingsOptions *(*)(id, SEL))objc_msgSend)(target, selector);
    }else{
        return [self defaultUseSettingsOptionsFunction];
    }
    
}
-(NSString*)preferences
{
    return [[self getUserSettingsController] getPreferencesString:[self getUserSettingsOptions]];
}

-(void)preferences:(NSString*)val
{
    FLXSUserSettingsOptions* uso=[self getUserSettingsOptions];
    NSMutableArray * result= [[self getUserSettingsController] parsePreferences:uso value:val];
    [self applyPreferences: result];
}

-(NSString*)getPeristenceKey
{
    return self.preferencePersistenceKey;
}
-(void)clearPreferences
{
    FLXSUserSettingsOptions* uso=[self getUserSettingsOptions];
    _preferencesSet=NO;
    [[self getUserSettingsController] clearPreferences:uso];
}

- (void)persistPreferences:(NSString *)name isDefault:(BOOL)isDefault {
    FLXSUserSettingsOptions* uso=[self getUserSettingsOptions];
    [[self getUserSettingsController] persistPreferences:uso name:name isDefault:isDefault];
}

-(void)loadPreferences
{
    FLXSUserSettingsOptions* uso=[self getUserSettingsOptions];
    _preferencesLoaded=YES;
    [[self getUserSettingsController] loadPreferences:uso];
}

-(void)applyPreferences:(NSMutableArray*)arrayCollection
{
    FLXSUserSettingsOptions* uso=[self getUserSettingsOptions];
    _preferencesSet=YES;
    _triggerEvent=NO;
    BOOL filterPersisted=NO;
    [[self getUserSettingsController] applyPreferences:uso nsMutableArray:arrayCollection];
    if(uso.grid!=nil)
    {
        for(NSDictionary* item in arrayCollection)
        {
            if([[item objectForKey:@"key" ] isEqual:[FLXSConstants PERSIST_COLUMN_WIDTH]])
            {
                _userPersistedColumnWidths=YES;
                //self means the user explicitly previously set column widths, so dont change with them
            }
            else if([[item objectForKey:@"key" ] isEqual:[FLXSConstants PERSIST_FILTER]])
            {
                filterPersisted=YES;
            }
        }
    }
    _triggerEvent=YES;
    if(filterPersisted)
    {
        _filterDirty=YES;
        [self doInvalidate];
    }
}

-(void)setPreferences:(NSString *)preferences {
    FLXSUserSettingsOptions* uso=[self getUserSettingsOptions];
    _preferences = preferences;
    [self applyPreferences:[[self getUserSettingsController] parsePreferences:uso value:_preferences]];
    //setPreferences(getUserSettingsController().parsePreferences(userSettingsOptionsFunction(),val));

}

-(FLXSUserSettingsOptions*)defaultUseSettingsOptionsFunction
{
    return [FLXSUserSettingsOptions create:self];
}


-(void)onKeyFocusChange:(FLXSEvent*)event
{
    //no focus change events in IOS
}

-(void)keyDownHandler:(FLXSEvent*)event
{
    //no keyboard interaction in IOS
}

-(void)keyUpOrDown:(int)keyCode
{
    //no keyboard interaction in IOS
}

-(void)onGridMouseOut:(FLXSEvent*)event
{
    //no mouse interaction in IOS
    
}

-(FLXSFlexDataGridColumnLevel*)columnLevel
{
	if(!_columnLevel)
	{
		self.columnLevel=[[FLXSFlexDataGridColumnLevel alloc] init];
	}
	return _columnLevel;
}

-(void)setColumnLevel:(FLXSFlexDataGridColumnLevel*)value
{
    
	if(_columnLevel&&(![_columnLevel isEqual: value]))
	{
		//self means we got initialized by some boolean flags that were set before the level was initialized
		[value transferProps:_columnLevel to:value checkForChanges:YES ];
        value.grid=self;
	}
	_columnLevel = value;
	[value initializeLevel:self];
	if(self.enableEagerDraw)
		[self rebuild];
}

-(BOOL)isClientFilterPageSortMode
{
	return [self.columnLevel.filterPageSortMode isEqualToString:@"client"];
}

-(void)setDataProviderFLXS:(NSArray*)value
{
    
	if([value isKindOfClass:[NSArray class]])
	{
		//value = [[NSMutableArray alloc] initWithArray:value];
	}
    
	else
	{
		NSMutableArray *arr= [[NSMutableArray alloc] init];
		if(value!=nil)
		{
			[arr addObject:value];
		}
		value = [[NSMutableArray alloc] initWithArray:arr];
	}
	if(![_dataProvider isEqual: value])
	{
		_dataProvider=value;
        if(self.rebuildGridOnDataProviderChange||!_dataProviderSet)
            [self rebuild];
        else
            [self rebuildBody:NO];
        [self clearAllCollections];
	}
	if(([self.filterPageSortMode isEqualToString: @"server"]))
	{
		//we are in server mode
		if([_useSelectedSelectAllState isEqual:[FLXSTriStateCheckBox STATE_CHECKED]])
		{
			//user has checked all....
			for(NSObject* item in self.dataProviderFLXS)
			{
				if(![self.columnLevel isItemSelected:item useExclusion:YES ])
					[self.columnLevel selectRow:item selected:YES dispatch:YES recurse:YES bubble:YES parent:nil ];
			}
		}
	}
	if(self.showSpinnerOnFilterPageSort)
	{
		[self hideSpinner];
	}
    if(self.enablePullToRefresh){
        [self.bodyContainer hideRefreshControl];
    }
	[self checkNoDataMessage :NO];
    [self dispatchEvent:[[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent DATA_PROVIDER_CHANGE] andGrid:self andLevel:nil andColumn:nil andCell:nil andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ]];
	if(self.hasRowSpanOrColSpan && (self.verticalScrollPosition>0) && _dataProviderSet)
	{
		//self means the data provider changed
		float vsp = self.verticalScrollPosition;
		[self gotoVerticalPosition:0];
		[[self layer] display];
		//if you want to maintain vsp
		while(self.verticalScrollPosition<vsp)
		{
			[self gotoVerticalPosition:(self.verticalScrollPosition+self.bodyContainer.height)];
			[[self layer] display];
		}
	}
	_dataProviderSet=YES;
    _flattenedLevels= nil;
}


-(void)checkNoDataMessage:(BOOL)force
{
	if(self.noDataMessage && _dataProviderSet)
	{
		if([self getLength:self.dataProviderFLXS]==0 || force)
		{
			[self showMessage:self.noDataMessage];
		}
		else
		{
			[self hideSpinner];
		}
	}
}

-(void)clearAllCollections
{
	if(self.clearSelectionOnDataProviderChange)
		[self clearSelection];
    if(self.clearErrorsOnDataProviderChange)
		[self clearAllErrors];
	self.flattenedLevels=[[NSMutableDictionary alloc] init];
	self.hasErrors=NO;
	[self.bodyContainer clearAllCollections];
	if(self.clearChangesOnDataProviderChange)
		[self clearChanges];
}

-(void)clearChanges
{
	_changes=[[NSMutableArray alloc] init];
}

-(void)onCollectionChange:(FLXSEvent*)event
{
	[self dispatchEvent:([[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent DATA_PROVIDER_CHANGE] andGrid:self andLevel:nil andColumn:nil andCell:nil andItem:nil andTriggerEvent:event andBubbles:NO andCancelable:NO ])];
}

-(void)placeSections
{
	if(!self.columnLevel)return;
    [self dispatchEvent:[[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent PLACING_SECTIONS] andGrid:self andLevel:nil andColumn:nil andCell:nil andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ]];
	float borderThickness= [(NSNumber *)[self getStyle:(@"borderThickness")] floatValue];
	float paddingX= [self hasBorderSide:(@"left")]?borderThickness:0;
	float paddingRight=[self hasBorderSide:(@"right")]?borderThickness:0;
	float paddingY=[self hasBorderSide:(@"top")]?borderThickness:0;
	float paddingBottom=[self hasBorderSide:(@"bottom")]?borderThickness:0;
	float widestLeftLockedWidth=[self.columnLevel getWidestLeftLockedWidth :0];
	float widestRightLockedWidth=[self.columnLevel getWidestRightLockedWidth:0];
	float bodyWidth=self.frame.size.width-widestLeftLockedWidth-widestRightLockedWidth-(paddingX)-paddingRight-self.isVScrollBarVisible;
	self.leftLockedContent.horizontalScrollPolicy=self.leftLockedContent.verticalScrollPolicy=self.rightLockedContent.horizontalScrollPolicy=self.rightLockedContent.verticalScrollPolicy=@"off";
	self.filterContainer.width=self.headerContainer.width=self.footerContainer.width=bodyWidth+self.isVScrollBarVisible;
	self.bodyContainer.width=bodyWidth;
    self.pagerContainer.width=self.width-(2*self.borderThickness)/*-verticalScrollBarOffset*/;
    self.pager.superview.width = self.width-(2*self.borderThickness);



    self.leftLockedHeader.width=self.leftLockedFooter.width=self.leftLockedContent.width=widestLeftLockedWidth;
	self.rightLockedHeader.width=self.rightLockedFooter.width=self.rightLockedContent.width=widestRightLockedWidth;
	self.bodyContainer.width+=self.verticalScrollBarOffset;
	//now that the widths are set, we can calculate columns
	[self.columnLevel adjustColumnWidths:-1 equally:NO ];
	[self snapToColumnWidths];
	if(self.variableHeaderHeight)
	{
		[self.columnLevel calculateHeaderHeights];
	}
	float bodyHeight=self.height-self.headerSectionHeight-self.footerRowHeight-paddingBottom-1;
	bodyHeight=MAX(self.columnLevel.rowHeight, bodyHeight);
	//fix for print issue.
	self.bodyContainer.height=self.leftLockedContent.height=self.rightLockedContent.height=bodyHeight;
	self.filterContainer.height= self.columnLevel.filterRowHeight;
	self.headerContainer.height= [self.columnLevel sumHeaderAndColumnGroupHeights];
	//self.columnLevel.headerHeight*[self.columnLevel getMaxColumnGroupDepth];
	self.footerContainer.height= self.columnLevel.footerRowHeight;
	self.pagerContainer.height= self.columnLevel.pagerRowHeight;
	self.leftLockedHeader.height=self.rightLockedHeader.height=self.headerContainer.height+self.filterContainer.height;
	self.leftLockedFooter.height=self.rightLockedFooter.height=self.columnLevel.footerRowHeight;
	self.leftLockedHeader.x=self.leftLockedFooter.x=self.leftLockedContent.x=self.pagerContainer.x=paddingX;
	self.rightLockedHeader.x=self.rightLockedFooter.x=self.rightLockedContent.x=self.width-self.rightLockedContent.width-self.verticalScrollBarOffset-1;
	self.filterContainer.x=self.footerContainer.x=self.bodyContainer.x=self.headerContainer.x=widestLeftLockedWidth+paddingX;




    self.rightLockedContent.hidden=self.rightLockedFooter.hidden=self.rightLockedHeader.hidden= !(widestRightLockedWidth>0);
    
    NSArray* sections = [displayOrder componentsSeparatedByString:(@",")];
	float thisY=paddingY;
	for(NSString* section in sections)
	{
		thisY+= [self placeSectionByName:section thisY:(thisY - (([displayOrder rangeOfString:section].location > [displayOrder rangeOfString:(@"body")].location) ? self.isHScrollBarVisible : 0))];
	}


}

-(float)getFilterX:(UIView <FLXSIFilterControl>*)renderer
{
	return ((FLXSFlexDataGridFilterCell*)renderer.superview).perceivedX;
}

-(void)pauseKeyboardListeners:(NSObject*)filterRenderer
{
    //ios no keyboard
}

-(FLXSFlexDataGridContainerBase*)getContainerForCell:(UIView<FLXSIFlexDataGridCell>*)cell
{
	if([cell.level isEqual:self.columnLevel])
	{
		if(cell.rowInfo.isHeaderRow || cell.rowInfo.isColumnGroupRow)
			return self.headerContainer;
		else if(cell.rowInfo.isFooterRow)
            return self.footerContainer;
        else if (cell.rowInfo.isFilterRow)
            return self.filterContainer;
        else if (cell.rowInfo.isPagerRow)
            return self.pagerContainer;
        else
            return self.bodyContainer;
    }
    else
        return self.bodyContainer;
}

- (FLXSFlexDataGridContainerBase *)getContainerInDirection:(NSString *)container up:(BOOL)up {
	FLXSFlexDataGridContainerBase* prevSec=nil;
	FLXSFlexDataGridContainerBase* nextSec=nil;
	NSArray* sections = [displayOrder componentsSeparatedByString:(@",")];
	BOOL hit=NO;
    for(NSString* section in sections)
	{
		if([section isEqualToString: container])
			hit=YES;
		if([self getNamedContainer:section] && ![section isEqual: container] && !hit)
			prevSec=[self getNamedContainer:section];
		if([self getNamedContainer:section] && ![section isEqual:container] && hit && nextSec==nil)
			nextSec=[self getNamedContainer:section];
	}
	return up?prevSec:nextSec;
}

-(NSString*)getContainerName:(FLXSFlexDataGridContainerBase*)container
{
	if ([container isEqual: self.headerContainer])
	{
		return @"header" ;
	}
	else if ([container  isEqual: self.footerContainer])
	{
		return @"footer" ;
	}
	else if ([container  isEqual: self.pagerContainer])
	{
		return @"pager";
	}
	else if ([container isEqual: self.filterContainer])
	{
		return @"filter" ;
	}
	return @"body";
}

-(FLXSFlexDataGridContainerBase*)getNamedContainer:(NSString*)name
{
	if ([name isEqualToString: @"header"])
	{
		return self.headerContainer;
	}
	else if ([name isEqual: @"footer"] && self.footerRowHeight>0)
	{
		return self.footerContainer;
	}
	else if ([name isEqual: @"pager"] && self.pagerRowHeight>0)
	{
		return self.pagerContainer;
	}
	else if ([name isEqual: @"filter"] && self.filterRowHeight>0)
	{
		return self.filterContainer;
	}
	else if ([name isEqual: @"body"])
	{
		return self.bodyContainer;
	}
	return nil;
}

- (float)placeSectionByName:(NSString *)name thisY:(float)thisY {
	BOOL filterAboveHeader = [displayOrder rangeOfString:(@"filter")].location<[displayOrder rangeOfString:(@"header")].location;
	if ([name isEqual: @"header"])
	{
		if(self.headerVisible )
		{
			self.headerContainer.y = thisY;
			if(!filterAboveHeader)
			{
                self.leftLockedHeader.y=self.rightLockedHeader.y = thisY;
			}
			return self.headerContainer.height;
		}
		else
		{
			return 0;
		}
	}
	else if ([name isEqual: @"footer"])
	{
		if(self.footerVisible && self.enableFooters)
		{
            self.leftLockedFooter.y=self.rightLockedFooter.y=self.footerContainer.y = thisY;
			return self.footerContainer.height;
		}
		else
		{
			return 0;
		}
	}
	else if ([name isEqual: @"pager"])
	{
		if((self.pagerVisible && self.enablePaging ) || self.forcePagerRow)
		{
            self.pagerContainer.y = thisY;
			return self.pagerContainer.height;
		}
		else
		{
			return 0;
		}
	}
	else if ([name isEqual: @"filter"])
	{
		if((self.filterVisible && self.enableFilters ) )
		{
            self.filterContainer.y = thisY;
			if(filterAboveHeader)
			{
                self.leftLockedHeader.y=self.rightLockedHeader.y = thisY;
			}
			return self.filterContainer.height;
		}
		else
		{
			return 0;
		}
	}
	else if ([name isEqual: @"body"])
	{
        self.leftLockedContent.y=self.rightLockedContent.y=self.bodyContainer.y = thisY;
		return self.bodyContainer.height;
	}
    //	else
    //throw [[Error alloc] initWithType:(@"Invalid section specified for the displayOrder property " + name)];
    return 0;
}

-(void)snapToColumnWidths
{
    if(self.placementDirty || self.structureDirty || self.snapDirty)return;
	for(FLXSFlexDataGridContainerBase* section in
        [[NSArray alloc] initWithObjects:self.bodyContainer,self.filterContainer,self.headerContainer,self.footerContainer,nil])
		[section snapToColumnWidths];
}

+ (UIView *)findFirstResponder: (UIView*)currentView
{
    if (currentView.isFirstResponder) {
        return currentView;
    }
    
    for (UIView *subView in currentView.subviews) {
        UIView *firstResponder = [FLXSFlexDataGrid findFirstResponder:subView];
        
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    
    return nil;
}
-(void)createComponents:(int)currentScroll
{
	if(self.enableHeightAutoAdjust)
	{
		[self.bodyContainer ensureAutoAdjustHeight];
	}
    //next version v1.2
    //	if(!contextMenu)
    //	{
    //		contextMenu=[[ContextMenu alloc] init];
    //	}
    //	if(contextMenu)
    //	{
    //		[contextMenu addEventListener:[ContextMenuEvent MENU_SELECT] :onContextMenuSelect];
    //		if(enableHideBuiltInContextMenuItems)
    //			[contextMenu hideBuiltInItems];
    //	}
//	BOOL spinnerVisible=self.spinner!=nil;
	UIView* currentFocus = [FLXSFlexDataGrid findFirstResponder:self];
	NSString* currentDataFld=@"";
	if(([currentFocus conformsToProtocol:@protocol(FLXSIFilterControl)]  )&&
       ([currentFocus isKindOfClass:[FLXSTextInput class]])
       )
	{
		FLXSFlexDataGridFilterCell* fc = [currentFocus.superview isKindOfClass:[FLXSFlexDataGridFilterCell class]]?
        (FLXSFlexDataGridFilterCell* )currentFocus.superview:nil;
		if(fc)
			currentDataFld=fc.columnFLXS.dataFieldFLXS;
	}
    //	if (enableCopy && contextMenu && contextMenu.customItems)
    //	{
    //		if(!_copyCellContextMenuItem)
    //		{
    //			_copyCellContextMenuItem=[[ContextMenuItem alloc] init:copyCellMenuText];
    //			[_copyCellContextMenuItem addEventListener:[ContextMenuEvent MENU_ITEM_SELECT] :copyCurrentCellToClipboard];
    //			[contextMenu.customItems addObject:_copyCellContextMenuItem];
    //		}
    //		if(!_copyRowContextMenuItem)
    //		{
    //			_copyRowContextMenuItem=[[ContextMenuItem alloc] init:copySelectedRowMenuText];
    //			[_copyRowContextMenuItem addEventListener:[ContextMenuEvent MENU_ITEM_SELECT] :copyRowToClipboard];
    //			[contextMenu.customItems addObject:_copyRowContextMenuItem];
    //		}
    //		if(!_copyTableContextMenuItem)
    //		{
    //			_copyTableContextMenuItem=[[ContextMenuItem alloc] init:copyAllRowsMenuText];
    //			[_copyTableContextMenuItem addEventListener:[ContextMenuEvent MENU_ITEM_SELECT] :copyTableToClipBoard];
    //			[contextMenu.customItems addObject:_copyTableContextMenuItem];
    //		}
    //		if(!_copyRowSelectedRowsMenuItem)
    //		{
    //			_copyRowSelectedRowsMenuItem=[[ContextMenuItem alloc] init:copySelectedRowsMenuText];
    //			[_copyRowSelectedRowsMenuItem addEventListener:[ContextMenuEvent MENU_ITEM_SELECT] :copySelectedRowsToClipboard];
    //			[contextMenu.customItems addObject:_copyRowSelectedRowsMenuItem];
    //		}
    //	}
    NSArray* flat=[self getRootFlat];
	if(self.columnLevel.isClientFilterPageSortMode)
        flat= [self.bodyContainer filterPageSort:flat level:self.columnLevel parentObj:nil applyFilter:YES applyPaging:NO applySort:YES pages:nil updatePager:NO ];
	if(self.columns.count==0 && [self getLength:self.dataProviderFLXS]>0 && self.generateColumns)
	{
		//there are no columns, so introspect
		NSArray* flt=flat;
		NSMutableArray* newCols= [[NSMutableArray alloc] init];
		NSObject * itmObj=flt[0];
        if([itmObj isKindOfClass:[NSDictionary class]]){
            for (NSString* key in  ((NSDictionary *)itmObj).allKeys)
            {
                FLXSFlexDataGridColumn* col1 = [[FLXSFlexDataGridColumn alloc] init];
                col1.dataFieldFLXS = key;
                [newCols addObject:col1];
            }
        }
        else{
            NSArray* info = [FLXSUIUtils getClassInfo:[itmObj class]];
            if (info)
            {
                for (FLXSLabelData* prop in  info)
                {
                    FLXSFlexDataGridColumn* col1 = [[FLXSFlexDataGridColumn alloc] init];
                    col1.dataFieldFLXS = prop.label;
                    [newCols addObject:col1];
                }
            }
            
        }
		self.columns=newCols;
	}
	BOOL pp=self.preservePager && self.subviews.count>0;
	[self traceEvent:(@"create comp start")];
    [self.columnLevel initializeLevel:self];

    NSArray * subviews = self.subviews;
    for (UIView * subView in subviews){
        if(pp){
            if(![subView isEqual:self.pagerContainer]){
                [subView removeFromSuperview];
            }
        }else{
            [subView removeFromSuperview];
        }
    }

	[self.currentPoint reset];
	for(FLXSFlexDataGridContainerBase* section in
        [[NSArray alloc] initWithObjects:self.bodyContainer,self.filterContainer,self.headerContainer,self.footerContainer,nil])
	{
		[section removeAllComponents:NO];
	}
    self.heightIncreased =NO;
    self.widthIncreased =NO;
	[self placeSections];
    [self addEventListenerOfType:[FLXSEvent RESIZE] usingTarget:self withHandler:@selector(onGridResized:)];
    ;
    [self addComponent:self.filterContainer];
	[self addComponent:self.headerContainer];
	[self.bodyContainer setStyle:(@"verticalScrollBarStyleName") value:([self getStyle:(@"verticalScrollBarStyleName")])];
	[self.bodyContainer setStyle:(@"horizontalScrollBarStyleName") value:([self getStyle:(@"horizontalScrollBarStyleName")])];
	[self addComponent:self.bodyContainer];
	[self addComponent:self.footerContainer];
	[self addComponent:self.leftLockedContent];
	[self addComponent:self.rightLockedContent];
	[self addComponent:self.leftLockedHeader];
	[self addComponent:self.rightLockedHeader];
	[self addComponent:self.leftLockedFooter];
	[self addComponent:self.rightLockedFooter];
	if(!pp)
		[self addComponent:self.pagerContainer];
    else{
        [[self.pagerContainer getPagerCell].component setActualSizeWithWidth:[self.pagerContainer getPagerWidth] andHeight:self.columnLevel.pagerRowHeight];
    }
	[self addComponent:self.leftLockedVerticalSeparator];
	[self addComponent:self.rightLockedVerticalSeparator];
	[self addComponent:self.bottomBarLeft];
	[self addComponent:self.bottomBarRight];
	self.dropIndicator.hidden=YES;
    self.bodyContainer.verticalSpill=NO;
	[self traceEvent:(@"begin calc")];
    [self.bodyContainer calculateTotalHeight:nil level:nil heightSoFar:0 nestLevel:0 expanding:nil addedRows:nil parentObject:nil isRecursive:NO ];
	[self traceEvent:(@"end calc")]   ;
    [self.columnLevel adjustColumnWidths:-1 equally:NO ];
    CGSize sz= CGSizeMake([self.columnLevel getSumOfColumnWidths:[[NSArray alloc]
            initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE],nil]]-1, [self.bodyContainer calculateTotalHeightNoParam]  );
    [self.bodyContainer setContentSize:sz];
	if(self.columnLevel.enableFilters)
	{
		[self traceEvent:(@"begin filter")];
        [self.filterContainer createComponents:self.columnLevel currentScroll:0 flat:flat];
		if(currentDataFld)
		{
			FLXSFlexDataGridColumn* filterCol= [self.columnLevel getColumnByDataField:currentDataFld by:@"dataFieldFLXS"];
			if(filterCol && (self.filterContainer.rows.count>0))
			{
				[self setFilterFocus:filterCol.searchField];
				_currentCell= [self.filterContainer getCellForRowColumn:(((FLXSRowInfo *) self.filterContainer.rows[0]).data) column:filterCol includeExp:NO ];
			}
		}
		[self traceEvent:(@"end filter")];                                                                                                   ;
        [self.currentPoint nextChromeRow:self.filterContainer];
	}
	[self.bodyContainer setVisibleRange];
	[self traceEvent:(@"begin header")];
    [self.headerContainer createComponents:self.columnLevel currentScroll:0 flat:flat];
	[self traceEvent:(@"end header")];
    [self.currentPoint nextChromeRow:self.headerContainer];
	if(self.columnLevel.enableFooters)
	{
		[self traceEvent:(@"begin footer")];
        [self.footerContainer createComponents:self.columnLevel currentScroll:0 flat:flat];
		[self traceEvent:(@"end footer")];
        [self.currentPoint nextChromeRow:self.footerContainer];
	}
	if(!pp)
	{
		if(self.columnLevel.enablePaging || self.columnLevel.forcePagerRow)
		{
			[self traceEvent:(@"begin pager")];
            [self.pagerContainer createComponents:self.columnLevel currentScroll:0 flat:flat];
			[self traceEvent:(@"end pager")];
            [self.currentPoint nextChromeRow:self.pagerContainer];
		}
	}
	[self.bodyContainer createComponents:self.columnLevel currentScroll:currentScroll flat:flat];

	//[self setChildIndex:self.bodyContainer :(self.numChildren-1)];
	[self addComponent:self.dropIndicator];
	[self setNeedsDisplay];
	[self traceEvent:(@"create comp complete")]       ;
    self.componentsCreated =YES;
    [self dispatchEvent:[[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent COMPONENTS_CREATED] andGrid:self andLevel:nil andColumn:nil andCell:nil andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ]];
	self.preservePager=NO;
	[self.rightLockedFooter placeSection];
	[self.rightLockedHeader placeSection];
	[self.leftLockedFooter placeSection];
	[self.leftLockedHeader placeSection];
	[self checkNoDataMessage :NO];
    [self drawDefaultSeparators];
    if((self.showSpinnerOnFilterPageSort || self.showSpinnerOnCreationComplete) && !_dataProviderSet)
    {
        [self showSpinner:@""];
    }
    
}

-(void)copyTableToClipBoard:(FLXSEvent*)event
{
    FLXSExportOptions* options= [FLXSExportOptions create:[FLXSExportOptions TXT_EXPORT]];
	options.showColumnPicker=NO;
	options.copyToClipboard=YES;
	[[FLXSExtendedExportController instance] export:self exportOptions:options];
}

-(void)copySelectedRowsToClipboard:(FLXSEvent*)event
{
    FLXSExportOptions* options= [FLXSExportOptions create:[FLXSExportOptions TXT_EXPORT]];
	options.printExportOption = [FLXSPrintExportOptions PRINT_EXPORT_SELECTED_RECORDS];
	options.showColumnPicker=NO;
	options.copyToClipboard=YES;
	[[FLXSExtendedExportController instance] export:self exportOptions:options];
}

-(void)copyCurrentCellToClipboard:(FLXSEvent*)event
{
    //    if(!_currentCell && event)
    //	{
    //		if(event.mouseTarget conformsToProtocol:@protocol(FLXSIFlexDataGridDataCell))
    //			_currentCell=event.mouseTarget as IFLXSFlexDataGridDataCell;
    //	}
	if(!([_currentCell conformsToProtocol:@protocol(FLXSIFlexDataGridDataCell)]))
	{
		[FLXSUIUtils showError:@"Invalid Cell Selected." errorTitle:@""];
		return;
	}
	if(_currentCell && [_currentCell columnFLXS])
	{
		NSString* text=[[_currentCell columnFLXS] itemToLabel:[_currentCell rowInfo].data :_currentCell];
		if(text)
			[FLXSUIUtils pasteToClipBoard:text];
	}
}

-(void)copyRowToClipboard:(FLXSEvent*)event
{
    //	if(!_currentCell)
    //	{
    //		if(event.mouseTarget conformsToProtocol:@protocol(FLXSIFlexDataGridDataCell))
    //			_currentCell=event.mouseTarget as IFLXSFlexDataGridDataCell;
    //	}
	if(!([_currentCell conformsToProtocol:@protocol(FLXSIFlexDataGridDataCell)]))
	{
		[FLXSUIUtils showError:(@"Invalid Cell Selected.") errorTitle:@""];
		return;
	}
	if(_currentCell && [_currentCell columnFLXS])
	{
		[FLXSUIUtils pasteToClipBoard:([self getRowText:[_currentCell rowInfo].data columns:([[_currentCell columnFLXS].level getVisibleColumns:nil])])];
	}
}

- (NSString *)getRowText:(NSObject *)item columns:(NSArray *)cols {
    NSString* text=@"";
	for(FLXSFlexDataGridColumn* column in cols)
	{
		if (column.visible)
		{
			text= [[[NSArray alloc] initWithObjects:text,[column itemToLabel:item:nil], @"\t",nil] componentsJoinedByString:@""];
		}
	}
    text= [text stringByAppendingString:@"\n"];
    return text;
}

-(void)onRootFilterChange:(NSNotification*)ns
{
    FLXSFilterPageSortChangeEvent* event = (FLXSFilterPageSortChangeEvent*)[ns.userInfo objectForKey:@"event"];
	if(self.clearSelectionOnFilter)
	{
		[self clearSelection];
	}
	if(!_triggerEvent)return;
	FLXSFilterPageSortChangeEvent* filterPageSortChangeEvent=(FLXSFilterPageSortChangeEvent*)event.triggerEvent;
	[self processRootFilter:filterPageSortChangeEvent];
    //next version v1.2
    //	if(filterPageSortChangeEvent && filterPageSortChangeEvent.triggerEvent )
    //	{
    //		FLXSMultiSelectComboBoxEx* mscb = filterPageSortChangeEvent.triggerEvent.currentTarget as MultiSelectComboBoxEx;
    //		if(mscb)
    //		{
    //			FLXSFlexDataGridFilterCell* mscbFilterCell = mscb.parent as FLXSFlexDataGridFilterCell;
    //			if(!mscbFilterCell)return;
    //			NSObject* flat=nil;
    //			NSObject* filtered=nil;
    //			BOOL hasuseCurrentDataProviderForFilterComboBoxValues=NO;
    //			for(FLXSFlexDataGridColumn* col in mscbFilterCell.column.level.columns)
    //			{
    //				if(col!=mscbFilterCell.column)
    //				{
    //					if(col.useCurrentDataProviderForFilterComboBoxValues)
    //					{
    //						if(!flat)
    //						{
    //							flat=[self getRootFlat];
    //						}
    //						if(!filtered)
    //						{
    //							filtered=[self.bodyContainer filterPageSort:([self getRootFlat]) :self.columnLevel :nil :YES :NO :YES];
    //						}
    //						hasuseCurrentDataProviderForFilterComboBoxValues=YES;
    //						col.filterComboBoxBuildFromGrid = NO;
    //						col.filterComboBoxDataProvider = [[NSMutableArray alloc] initWithType:([col getDistinctValues:filtered])];
    //					}
    //				}
    //			}
    //			if(!hasuseCurrentDataProviderForFilterComboBoxValues)return;
    //			[self validateNow];
    //			for(FLXSRowInfo* row in self.filterContainer.rows)
    //			{
    //				for(FLXSComponentInfo* comp in row.cells)
    //				{
    //					FLXSFlexDataGridFilterCell* fcell = comp.component as FLXSFlexDataGridFilterCell;
    //					if(fcell)
    //					{
    //						MultiSelectComboBoxEx* othermscb = fcell.renderer as MultiSelectComboBoxEx;
    //						if(othermscb && (![othermscb isEqual:mscb]) && fcell.column.useCurrentDataProviderForFilterComboBoxValues)
    //						{
    //							NSMutableArray* otherValues=(othermscb.selectedValues?othermscb.selectedValues:[[NSMutableArray alloc] init]);
    //							othermscb.dataProviderFLXS.source = fcell.column.filterComboBoxDataProvider.source;
    //							Array* itemsToRemove= [[NSMutableArray alloc] init]
    //							for(NSObject* item in othermscb.selectedItems)
    //							{
    //								if(![FLXSUIUtils doesArrayContainObjectValue:othermscb.dataProviderFLXS :othermscb.dataFieldFLXS :(item[othermscb.dataFieldFLXS])])
    //								{
    //									[itemsToRemove addObject:(item[othermscb.dataFieldFLXS])];
    //								}
    //							}
    //							othermscb.selectedValues=[[NSMutableArray alloc] initWithType:([otherValues.source filter:([self function:(item:*) :(index:int) :(array:Array)]:BOOL{[return itemsToRemove indexOf:item]==-1})])];
    //						}
    //					}
    //				}
    //			}
    //		}
    //	}
}

-(void)processFilter
{
    [self processRootFilter:nil];

}

-(void)processRootFilter:(FLXSFilterPageSortChangeEvent*)triggerEvent
{
	if(![self.itemFilters objectForKey:@"ROOT_FILTER"])
	{
        [self.itemFilters setObject:[[FLXSAdvancedFilter alloc] init] forKey:@"ROOT_FILTER"];
        ((FLXSFilter*)[self.itemFilters objectForKey:@"ROOT_FILTER"]).pageIndex = 0;
	}
    FLXSFilter* rootFilter = ((FLXSFilter*)[self.itemFilters objectForKey:@"ROOT_FILTER"]);
    rootFilter.pageIndex = 0;
	if(triggerEvent)
        rootFilter.arguments = triggerEvent.filter.arguments;
	else
        rootFilter.arguments = [self getFilterArguments];
	if(self.columnLevel.additionalFilterArgumentsFunction != nil )
	{
        SEL selector = NSSelectorFromString(self.columnLevel.additionalFilterArgumentsFunction);
        id target = self.delegate;
        NSArray * result= ((NSArray *(*)(id, SEL,FLXSFlexDataGridColumnLevel *))objc_msgSend)(target, selector,self.columnLevel);
        
		for(NSObject* arg in result)
            [rootFilter.arguments addObject:arg];
	}
    self.hasFilter=(rootFilter.arguments.count>0);
    if(self.columnLevel.isClientFilterPageSortMode)
	{
		/*[self rebuild];
         [self validateNow];
         */
        [self gotoVerticalPosition:0];
		[self rebuildBody:YES];
		[self.headerContainer refreshCells];
		[self.footerContainer refreshCells];
		if(!_filterDirty)
			[self checkNoDataMessage:(self.bodyContainer.itemVerticalPositions.count==0)];
	}
	//else
	{
		FLXSAdvancedFilter* filter = (FLXSAdvancedFilter*)rootFilter;
		filter.level=self.columnLevel;
		filter.sorts=self.columnLevel.currentSorts;
		FLXSExtendedFilterPageSortChangeEvent* nested =
                [[FLXSExtendedFilterPageSortChangeEvent alloc] initWithType:[FLXSExtendedFilterPageSortChangeEvent FILTER_PAGE_SORT_CHANGE] andFilter:(filter ? filter : [self.bodyContainer createFilter:self.columnLevel parentObject:nil ]) andBubbles:NO andCancelable:NO ];
		nested.triggerEvent=triggerEvent;
		nested.cause = [FLXSExtendedFilterPageSortChangeEvent FILTER_CHANGE];
		[self.columnLevel dispatchEvent:nested];
	}
}

-(void)onRootPageChange:(NSNotification*)ns
{
    FLXSExtendedFilterPageSortChangeEvent* event = ( FLXSExtendedFilterPageSortChangeEvent*)[ns.userInfo objectForKey:@"event"];
    self.verticalScrollPosition=0;
	UIView<FLXSIExtendedPager>* iPager =(UIView<FLXSIExtendedPager>*) event.triggerEvent.target;
	if([self.itemFilters objectForKey:@"ROOT_FILTER"]==nil)
	{
		[self.itemFilters setObject:[[FLXSAdvancedFilter alloc] init] forKey:@"ROOT_FILTER"];
		((FLXSFilter*)[self.itemFilters objectForKey:@"ROOT_FILTER"]).pageIndex = 0;
	}
	FLXSFilter* filter = ((FLXSFilter*)[self.itemFilters objectForKey:@"ROOT_FILTER"]);
	filter.pageIndex = iPager.pageIndex;
	if(self.columnLevel.isClientFilterPageSortMode)
	{
		[self rebuildBody:NO];
	}
	else
	{
		[self.bodyContainer dispatchPageChange:event.triggerEvent];
	}
}

- (void)showHideVScroll:(BOOL)show scrollBarWidth:(int)scrollBarWidth {
    //IOS does not show hide scroll bar
}

- (void)showHideHScroll:(BOOL)show scrollBarHeight:(int)scrollBarHeight {
    //IOS does not show hide scroll bar
    
}

-(FLXSClassFactory*)multiSortRenderer
{
	if (_multiSortRenderer == nil)
	{
		_multiSortRenderer= [FLXSFlexDataGrid static_FLXSFlexDataGridMultiSortRenderer];
	}
	return _multiSortRenderer;
}

-(NSString*)multiColumnSortGetTooltip:(FLXSFlexDataGridHeaderCell*)cell
{
	NSString* result=@"";
	if(!self.enableSplitHeader)
		result=@"Click to open multiple column sort.";
	return result;
}

-(void)multiColumnSortShowPopup
{
	NSObject* pop=[self.multiSortRenderer generateInstance] ;
    
	[FLXSUIUtils addPopUpController:(UIViewController *)pop parent:self modal:YES ];
    if([pop respondsToSelector:NSSelectorFromString(@"grid")])
        [pop setValue:self forKey:@"grid"];
}

-(float)headerSectionHeight
{
	return (self.enablePaging||self.forcePagerRow?self.columnLevel.pagerRowHeight:0)
    +(self.enableFilters?self.columnLevel.filterRowHeight:0)
    +/*(self.columnLevel.headerHeight*[self.columnLevel getMaxColumnGroupDepth])*/ [self.columnLevel sumHeaderAndColumnGroupHeights];
    return 0;
}

-(void)refreshCheckBoxes
{
	[self.headerContainer refreshCheckBoxes];
	[self.bodyContainer refreshCheckBoxes];
}

-(void)refreshCells
{
    [self.bodyContainer refreshCells];
	if(self.enableFooters)
		[self.footerContainer refreshCells];
}

-(void)onColumnResized:(FLXSEvent*)event
{
	[self snapToColumnWidths];
	[[self layer] display];
	if(!self.forceColumnsToFitVisibleArea)
	{
		[self recycleH:YES];
		[self.bodyContainer validateDisplayList];
	}
    
}

-(void)onSelectAllChanged:(FLXSFlexDataGridEvent*)event
{
	self.selectionInvalid =YES;
	[self doInvalidate];
}

-(void)onSelectChanged:(FLXSFlexDataGridEvent*)event
{
    self.selectionInvalid=YES;
	[self doInvalidate];
}

-(void)onContainerScroll:(NSNotification*)ns
{
    FLXSScrollEvent * event = [ns.userInfo objectForKey:@"event"];
    [self dispatchEvent:event];
	if([event.detail isEqual:[FLXSScrollEventDetail THUMB_TRACK]])
	{
		_isScrolling=YES;
	}
	else if([event.detail isEqual:[FLXSScrollEventDetail THUMB_POSITION]])
	{
		_isScrolling=NO;
		[self.bodyContainer gridMouseOut];
	}
	if([event.direction isEqual:[FLXSScrollEventDetail VERTICAL]] && !self.forceColumnsToFitVisibleArea)
	{
		[self invalidateHorizontalScroll];
	}
	if([event.direction isEqual:[FLXSScrollEventDetail HORIZONTAL]] )
	{
		[self recycleH:((event.delta>=0))]   ;
        [self synchronizeHorizontalScroll];
	}
	else if([event.direction isEqual:[FLXSScrollEventDetail VERTICAL]])
	{
		int seedHeight=self.bodyContainer.verticalScrollPosition;
		if(seedHeight>=0&&[self.bodyContainer setCurrentRowAtScrollPosition:seedHeight])
			[self.bodyContainer recycle:self.columnLevel scrollDown:(event.delta > 0) scrollDelta:event.delta scrolling:NO ];
		//only recycle if our seed actually changed..
		[self synchronizeLockedVerticalScroll];
	}
    // self.bodyContainer.traceRows;
}

-(void)recycleH:(BOOL)right
{
	[self.bodyContainer recycleH:self.columnLevel scrollRight:right];
    [self.headerContainer recycleH:self.columnLevel scrollRight:right];
    if(self.enableFooters)
        [self.footerContainer recycleH:self.columnLevel scrollRight:right];
    if(self.enableFilters)
        [self.filterContainer recycleH:self.columnLevel scrollRight:right];
    [self synchronizeHorizontalScroll];
    if(self.enableFillerRows)
    {
        [self invalidateFiller];
    }
}

- (void)setChildData:(NSObject *)item children:(NSArray *)children level:(FLXSFlexDataGridColumnLevel *)level totalRecords:(int)totalRecords useSelectedKeyField:(BOOL)useSelectedKeyField {
	if(self.showSpinnerOnFilterPageSort)
		[self hideSpinner];
	[self.bodyContainer setChildData:item children:children level:level totalRecords:totalRecords useSelectedKeyField:useSelectedKeyField];
}

-(void)invalidateCells
{
	for(FLXSFlexDataGridContainerBase* section in
        [[NSArray alloc] initWithObjects:self.bodyContainer,self.filterContainer,self.headerContainer,self.footerContainer,nil])
		[section invalidateCells];
}

-(void)invalidateList
{
	[self rebuild];
}

-(void)clearSelection
{
    if(self.selectedCells.count>0)
		[self.selectedCells removeAllObjects];
	[self.columnLevel clearSelection : NO];
	[self invalidateSelection];
    self.selectionChain=[[NSMutableDictionary alloc] init];
	if(self.enableSelectionExclusion)
	{
		_selectAllState=[FLXSTriStateCheckBox STATE_UNCHECKED];
	}
}

- (UIView <FLXSIFlexDataGridCell> *)getCellInDirection:(UIView <FLXSIFlexDataGridCell> *)cell direction:(NSString *)direction {
	return [self.bodyContainer getCellInDirection:cell direction:direction dataOnly:NO editableOnly:NO scrollIfNecessary:YES hoverableOnly:NO ];
}

-(NSArray*)getRootFlat
{
	return [self.bodyContainer getRootFlat];
}

- (NSArray *)flatten:(int)depthRequested inclusive:(BOOL)inclusive filter:(BOOL)filter page:(BOOL)page sort:(BOOL)sort max:(float)max {
	NSString* key = [[[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d", depthRequested] , @":" ,
                      inclusive?@"Y":@"N" , @":" , filter?@"Y":@"N" , @":" , page?@"Y":@"N" , @":" , sort?@"Y":@"N" ,@":" ,
                      [NSString stringWithFormat:@"%f", max],nil] componentsJoinedByString:@""];
    if(!_flattenedLevels){
        _flattenedLevels = [[NSMutableDictionary alloc] init];
    }
    
    if([_flattenedLevels valueForKey:key])return (NSArray *)[_flattenedLevels valueForKey:key];
	NSMutableArray * result= [[NSMutableArray alloc] init];
	for(NSObject* item in [self getRootFlat])
	{
		[FLXSFlexDataGrid flattenRecursive:depthRequested result:result parent:item level:self.columnLevel inclusive:inclusive filter:filter page:page sort:sort];
		if(max!=-1&&result.count>max)break;
	}
    [_flattenedLevels setValue:result forKey:key];
    return result;
}

-(void)clearFlattenedCache
{
	_flattenedLevels=[[NSMutableDictionary alloc]init];
}

+ (void)flattenRecursive:(int)depthRequested result:(NSMutableArray *)result parent:(NSObject *)parent level:(FLXSFlexDataGridColumnLevel *)level inclusive:(BOOL)inclusive filter:(BOOL)filter page:(BOOL)page sort:(BOOL)sort {
    if(level==nil || (inclusive && (level.nestDepth<=depthRequested))
       || level.nestDepth==depthRequested || depthRequested==-1)
	{
		[result addObject:parent];
	}
	if(level.nextLevel && (level.nextLevel.nestDepth<=depthRequested || depthRequested==-1))
	{
		for(NSObject* child in [level getChildren:parent filter:filter page:page sort:sort])
		{
            [self flattenRecursive:depthRequested result:result parent:child level:level.nextLevel inclusive:inclusive filter:filter page:page sort:sort];
		}
	}
}

- (void)highlightRow:(UIView <FLXSIFlexDataGridCell> *)cell row:(FLXSRowInfo *)row highLight:(BOOL)highLight highLightColor:(id)highLightColor {
    //no mouse over, no highlight needed.
    
    //	NSArray* cells = self.isRowSelectionMode&& !row.isChromeRow
    //        ?row.cells: [[NSMutableArray alloc] initWithObjects:[[FLXSComponentInfo alloc] init:cell :0 :nil],nil];
    //	int rollOverColor;
    //    int rollOverTextColor;
    //
    //    if(cell)
    //	{
    //		rollOverColor=[cell getRolloverColor];
    //		rollOverTextColor=[cell getRolloverTextColor];
    //	}
    //	for(FLXSComponentInfo* comp in cells)
    //	{
    //		UIView<FLXSIFlexDataGridCell>* rowCell = (UIView<FLXSIFlexDataGridCell>* )comp.component;
    //		if(rowCell)
    //		{
    //			if(rollOverColor==nil && rowCell==nil)
    //				rollOverColor=[rowCell getRolloverColor];
    //			if(!highLight)
    //			{
    //				if(rowCell.currentBackgroundColors)
    //				{
    //					rowCell.currentBackgroundColors = nil;
    //					rowCell.currentTextColors=nil;
    //					[rowCell invalidateDisplayList];
    //				}
    //			}
    //			else
    //			{
    //				if(rollOverColor && (self.useRollOver/*|| !(rowCell.rowInfo.isDataRow)*/))
    //				{
    //					rowCell.currentBackgroundColors = highLightColor!=0? [NSNumber numberWithInt:highLightColor]
    //                            :(([rowCell isEqual:self.currentCell])&&rowCell.rowInfo.isDataRow&&self.enableActiveCellHighlight)
    //                                    ?[cell getStyleValue:(@"activeCellColor")]:[NSNumber numberWithInt:rollOverColor];
    //					rowCell.currentTextColors = [NSNumber numberWithInt:rollOverTextColor];
    //					[rowCell invalidateDisplayList];
    //				}
    //			}
    //		}
    //	}
}

-(void)dragComplete:(UIView<FLXSIFlexDataGridCell>*)cell
{
    self.dropIndicator.hidden=YES;
}

-(void)dragBegin:(FLXSEvent*)event
{
    //next version   v1.2
    //	if(event.buttonDown && ![DragManager isDragging])
    //	{
    //		Point* pt = [[Point alloc] init:0 :0];
    //		IFLXSFlexDataGridDataCell* cell = event.currentTarget as
    //IFLXSFlexDataGridDataCell;
    //		if(!cell.enabled)return;
    //		if(cell)
    //		{
    //			if(dragAvailableFunction!=nil)
    //			{
    //				if(![self dragAvailableFunction:cell])
    //					return;
    //			}
    //			_dragColumn=cell.column;
    //			_dragRowData=cell.rowInfo.data;
    //			pt = [cell localToGlobal:pt];
    //			pt = [self globalToLocal:pt];
    //			Image* imageProxy =[self generateImageForDrag:cell];
    //			if(imageProxy!=nil)
    //			{
    //				DragSource* ds = [[DragSource alloc] init];
    //				[ds addData:imageProxy :DRAG_FORMAT_KEY];
    //				[DragManager doDrag:cell as IUIComponent :ds :event :imageProxy :(pt.x-15) :cell.height :([self getStyle:(@"dragAlpha")])];
    //			}
    //		}
    //	}
}

-(void)dragEnterInternal:(FLXSEvent*)event
{
	[self dragEnter:event];
}

-(void)dragDropInternal:(FLXSEvent*)event
{
	[self dragDrop:event];
}

-(void)dragEnter:(FLXSEvent*)event
{
    //next version   v1.2
    //	if ([event.dragSource hasFormat:DRAG_FORMAT_KEY])
    //	{
    //		UIView<FLXSIFlexDataGridCell>* cell = event.target as FLXSIFlexDataGridCell;
    //		[self dragAcceptReject:cell];
    //	}
    //	else
    //	{
    //		dropIndicator.visible=NO;
    //	}
}

-(void)dragAcceptReject:(UIView<FLXSIFlexDataGridCell>*)cell
{
    //next version   v1.2
    //	if(!enableDrop)return;
    //	if(dropAcceptRejectFunction!=nil)
    //	{
    //		if(![self dropAcceptRejectFunction:cell])
    //		{
    //			dropIndicator.visible=NO;
    //			return;
    //		}
    //	}
    //	[DragManager acceptDragDrop:(cell?cell as IUIComponent:self.bodyContainer)];
    //	[self showDropIndicator:cell];
}

- (void)scrollToExistingRow:(float)vsp scrollDown:(BOOL)scrollDown {
    [self.bodyContainer scrollToExistingRow:vsp scrollDown:scrollDown];
    //	if([DragManager isDragging])
    //	{
    //		dropIndicator.visible=NO;
    //	}
}

- (UIView <FLXSIFlexDataGridDataCell> *)getCellForRowColumn:(NSObject *)data column:(FLXSFlexDataGridColumn *)column {
    return (UIView<FLXSIFlexDataGridDataCell>*) [self.bodyContainer getCellForRowColumn:data column:column includeExp:NO ];
}

-(void)showDropIndicator:(UIView<FLXSIFlexDataGridCell>*)cell
{
    //next version v1.2
    //	self.dropIndicator.hidden=NO;
    //    self.dropIndicator.x=1;
    //	if(cell)
    //        self.dropIndicator.y=[self globalToLocal:([cell localToGlobal:([[Point alloc] init:0 :cell.height])])].y;
    //	else
    //dropIndicator.y=bodyContainer.y+(self.bodyContainer.calculatedTotalHeight);
    //	dropIndicator.width=(width-isVScrollBarVisible);
    //	dropIndicator.height=[self getStyle:(@"dropIndicatorThickness")];
    //	[dropIndicator.graphics clear];
    //	[dropIndicator.graphics lineStyle:([self getStyle:(@"dropIndicatorThickness")]) :([self getStyle:(@"dropIndicatorColor")])];
    //	[dropIndicator.graphics moveTo:0 :0];
    //	[dropIndicator.graphics lineTo:(width-isVScrollBarVisible) :0];
}

-(void)dragDrop:(FLXSEvent*)event
{
    //next version    v1.2
    //	if ([event.dragSource hasFormat:DRAG_FORMAT_KEY])
    //	{
    //		if(dragDropCompleteFunction!=nil)
    //		{
    //			[self dragDropCompleteFunction:event.target as IFLXSFlexDataGridDataCell];
    //		}
    //	}
    //	dropIndicator.visible=NO;
}

-(UIImage*)generateImageForDrag:(UIView<FLXSIFlexDataGridCell>*)cell
{
    //next version   v1.2
    //	Image* imageProxy =nil;
    //	VBox* vBox = [[VBox alloc] init];
    //	vBox.strong) NSString* verticalScrollPolicy = [ScrollPolicy OFF];
    //	vBox.horizontalScrollPolicy = [ScrollPolicy OFF];
    //	[vBox setStyle:(@"verticalGap") :0];
    //	[vBox setStyle:(@"borderStyle") :(@"none")];
    //	[self addChild:vBox];
    //	FLXSFlexDataGridColumnLevel* lvl = [cell.rowInfo.rowPositionInfo getLevel:self];
    //	if(allowMultipleRowDrag)
    //	{
    //		if(![lvl isItemSelected:cell.rowInfo.data])
    //		{
    //			[lvl selectRow:cell.rowInfo.data :YES :YES :NO];
    //		}
    //	}
    //	Array* rows=allowMultipleRowDrag?bodyContainer.rows.source:[cell.rowInfo];
    //	for(FLXSRowInfo* row in rows)
    //	{
    //		if(!row.isDataRow)continue;
    //		lvl=[row.rowPositionInfo getLevel:self];
    //		if([lvl isItemSelected:row.data]||!allowMultipleRowDrag)
    //		{
    //			HBox* hBox = [[HBox alloc] init];
    //			hBox.horizontalScrollPolicy = [ScrollPolicy OFF];
    //			[hBox setStyle:(@"horizontalGap") :0];
    //			[hBox setStyle:(@"borderStyle") :([self getStyle:(@"dragRowBorderStyle")])];
    //			[vBox addChild:hBox];
    //			for(FLXSComponentInfo* ocell in row.cells)
    //			{
    //				if(ocell.component.width>0 && ocell.component.height>0
    //					&& (ocell.component conformsToProtocol:@protocol(FLXSIFlexDataGridDataCell))
    //					&&(ocell.component as IFLXSFlexDataGridDataCell).renderer is UIComponent)
    //				{
    //					UIView* imgCopy=[self getUIComponentBitmapData:((ocell.component as IUIComponent))];
    //					[hBox addChild:imgCopy];
    //					[imgCopy move:hBox.width :0];
    //					hBox.width+=ocell.component.width;
    //					hBox.height=ocell.component.height;
    //				}
    //			}
    //			vBox.height+=hBox.height;
    //			if(vBox.width==0)
    //				vBox.width=hBox.width;
    //		}
    //	}
    //	if(vBox.width>0 && vBox.height>0)
    //	{
    //		[vBox validateNow];
    //		imageProxy=[self getUIComponentBitmapData:vBox]
    //	}
    //	[self removeChild:vBox];
    //	return imageProxy;
    return  nil;
}

-(void)invalidateSelection
{
    self.selectionInvalid=YES;
	[self doInvalidate];
}

-(void)placeComponents:(FLXSRowInfo*)row
{
	[self placeChildComponents:row.cells];
}

-(void)placeChildComponents:(NSArray*)components
{
	for(FLXSComponentInfo* comp in components)
	{
		[self placeComponent:comp];
	}
}

-(float)getCornerY:(FLXSComponentInfo*)comp
{
	BOOL filterAboveHeader = [displayOrder rangeOfString:(@"filter")].location<[displayOrder rangeOfString:(@"header")].location;
	if(comp.row.isFilterRow)
	{
		return  MAX(0,filterAboveHeader?0:([self.columnLevel sumHeaderAndColumnGroupHeights]/*self.columnLevel.headerHeight*[self.columnLevel getMaxColumnGroupDepth]*/));
	}
	else if(comp.row.isHeaderRow || comp.row.isColumnGroupRow)
	{
		float filterOffset = filterAboveHeader?self.filterRowHeight:0;
		if([comp.component isKindOfClass:[FLXSFlexDataGridColumnGroupCell class]])
		{
			//cg cell
            return MAX(0,filterOffset + ((((FLXSFlexDataGridColumnGroupCell*)comp.component).columnGroup.depth * self.columnLevel.headerHeight)
                                         - self.columnLevel.headerHeight));
		}
        return MAX(0,filterOffset + ([self.columnLevel sumHeaderAndColumnGroupHeights]/*[self.columnLevel getMaxColumnGroupDepth]* self.columnLevel.headerHeight*/)
                   -self.columnLevel.headerHeight- (comp.component.height-comp.row.height));
	}
	return MAX(0,comp.component.y);
}

-(void)placeComponent:(FLXSComponentInfo*)comp
{
	float v=comp.useComponentPosition?comp.component.y:(comp.row&&!comp.inCornerAreas? comp.row.y :[self getCornerY:comp]);
	float compx=([comp.component isKindOfClass:[FLXSFlexDataGridColumnGroupCell class]])?comp.component.x:comp.x;
	/*if(comp.row && comp.row.isHeaderRow)
     {
     v += ((comp.row.rowDepth-1)*comp.component.height);
     }
     */
    [comp.component moveToX:compx y:v];
    
}

-(void)addComponent:(UIView*)component
{
    [self addSubview:component];
}

-(void)drawDefaultSeparators
{
 	self.leftLockedVerticalSeparator.hidden=self.rightLockedVerticalSeparator.hidden=YES;
	if(self.columnLevel.leftLockedColumns.count>0)
	{
        self.leftLockedVerticalSeparator.x=self.leftLockedContent.width;
        self.leftLockedVerticalSeparator.y=self.headerContainer.y;
        self.leftLockedVerticalSeparator.height=(self.headerContainer.height+self.filterContainer.height+self.bodyContainer.height+self.footerContainer.height)-
        self.isHScrollBarVisible;
        self.leftLockedVerticalSeparator.width = [(NSNumber *)[self getStyle:(@"lockedSeparatorThickness")] floatValue];
        self.leftLockedVerticalSeparator.backgroundColor = self.lockedSeparatorColor;
        self.leftLockedVerticalSeparator.hidden=NO;
	}
	if(self.columnLevel.rightLockedColumns.count>0)
	{
		self.rightLockedVerticalSeparator.x=self.rightLockedContent.x;
        self.rightLockedVerticalSeparator.y=self.headerContainer.y;
        self.rightLockedVerticalSeparator.height=(self.headerContainer.height+self.filterContainer.height+self.bodyContainer.height+self.footerContainer.height)-self.isHScrollBarVisible;
        self.rightLockedVerticalSeparator.width = [(NSNumber *)[self getStyle:(@"lockedSeparatorThickness")]floatValue];
        self.rightLockedVerticalSeparator.backgroundColor = self.lockedSeparatorColor;
        self.rightLockedVerticalSeparator.hidden=NO;
	}
}

-(void)setTotalRecords:(int)val
{
    _totalRecords=val;
	if(self.enablePaging)
	{
		UIView<FLXSIPager>* pager=[self.pagerContainer getPager];
		if(pager)
		{
			if(pager.totalRecords!= _totalRecords)
				pager.totalRecords= _totalRecords;
		}
	}
}
-(NSString*)horizontalScrollPolicy
{
	return self.bodyContainer.horizontalScrollPolicy;
}

-(void)setHorizontalScrollPolicy:(NSString*)value
{
	self.bodyContainer.horizontalScrollPolicy=value;
}

-(UIView*)verticalScrollBar
{
	return nil;
}

-(UIView*)horizontalScrollBar
{
	return nil;
}

-(int)verticalScrollBarOffset
{
    return 0;
}

-(float)verticalScrollPosition
{
    return self.bodyContainer.verticalScrollPosition;
}

-(void)setVerticalScrollPosition:(float)val
{
	[self.bodyContainer gotoVerticalPosition:val];
}

-(float)horizontalScrollPosition
{
    return self.bodyContainer.horizontalScrollPosition;
}

-(float)maxHorizontalScrollPosition
{
    return self.bodyContainer.maxHorizontalScrollPosition;
}

-(void)gotoHorizontalPosition:(float)vsp
{
    [self.bodyContainer gotoHorizontalPosition:vsp];
	[self recycleH:YES];
}

-(void)gotoVerticalPosition:(float)vsp
{
    [self.bodyContainer gotoVerticalPosition:vsp];
	[self synchronizeLockedVerticalScroll];
}

-(void)horizontalScrollPosition:(float)val
{
    [self.bodyContainer gotoHorizontalPosition:val];
}

-(void) verticalScrollPolicy:(NSString*)value
{
    self.bodyContainer.verticalScrollPolicy=value;
}

-(NSArray*)columns
{
	return self.columnLevel.columns;
}

-(void)setColumns:(NSMutableArray*)val
{
    
	self.columnLevel.columns=val;
	if(self.enableEagerDraw)
		[self rebuild];
	[self dispatchEvent:([[FLXSEvent alloc] initWithType:(@"columnsChanged")])];
}

-(NSArray*)groupedColumns
{
    return [self.columnLevel.groupedColumns count]==0?self.columns:self.columnLevel.groupedColumns;
}

-(void)setGroupedColumns:(NSArray*)val
{
	self.columnLevel.groupedColumns=val;
	if(self.enableEagerDraw)
		[self rebuild];
	[self dispatchEvent:([[FLXSEvent alloc] initWithType:(@"columnsChanged")])];
}

-(NSArray*)columnGroups
{
	return self.columnLevel.columnGroups;
}

-(NSArray*)visibleColumns
{
	return [self.columnLevel getVisibleColumns:nil];
}

-(NSArray*)exportableColumns
{
    return self.currentExportLevel? [self.currentExportLevel getExportableColumns:nil deep:NO options:nil ] :
            [self.columnLevel getExportableColumns:nil deep:NO options:nil ];
}

-(NSArray*)getExportableColumns:(FLXSExportOptions*)exportOptions
{
    return [self.columnLevel getExportableColumns:nil deep:YES options:exportOptions];
}

-(NSArray*)sortableColumns
{
    return [self.columnLevel getSortableColumns];
}

-(NSMutableArray*)currentSorts
{
	return self.columnLevel.currentSorts;
}

-(void)removeAllSorts
{
    
    
	[self.columnLevel removeAllSorts];
	if(!self.columnLevel.isClientFilterPageSortMode)
	{
		//fpsmode=server
		[self processFilter];
	}
	else
	{
		[self rebuild];
	}
}

-(NSArray*)settingsColumns
{
	return [self.columnLevel getShowableColumns:nil deep:NO ];
}

-(NSArray*)getPrintableColumns:(FLXSPrintOptions*)options
{
	NSMutableArray* result= [[NSMutableArray alloc]init];
//	for(FLXSFlexDataGridColumn* fdg in self.printableColumns)
//	{
//		if(!options.excludeHiddenColumns || fdg.visible)
//			[result addObject:fdg];
//	}
	return result;
}

-(NSArray*)printableColumns
{
    return [self.columnLevel getPrintableColumns:nil deep:YES ];
}

-(float)rowHeight
{
	return self.columnLevel.rowHeight;
}

-(void)setRowHeight:(float)val
{
	self.columnLevel.rowHeight=val;
}

-(int)rowCount
{
	return (int)self.bodyContainer.onScreenRows.count;
}


-(void)setPrintExportData:(NSArray*)value
{
	_printExportData=value;
    //	//once we have the data from the server, we continue as usuual...
	[self dispatchEvent:([[FLXSEvent alloc] initWithType:(@"printExportDataReceived")])];
}

-(NSObject*)dataProviderNoFilters
{
	return  [self getRootFlat];
}

-(NSObject*)dataProviderNoPaging
{
    return [FLXSExtendedUIUtils filterArray:([self getRootFlat]) filter:([self getRootFilter]) grid:self level:self.columnLevel hideIfNoChildren:NO ];
}

-(NSString*)filterPageSortMode
{
	return self.columnLevel.filterPageSortMode;
}

-(FLXSFilter*)createFilter
{
	return [self.filterContainer createFilter:self.columnLevel parentObject:nil ];
}

-(void)clearAllFilters
{
	self.itemFilters=[[NSMutableDictionary alloc] init];
	for(FLXSFlexDataGridColumn* fCol in self.columnLevel.columns)
	{
		if(fCol.useCurrentDataProviderForFilterComboBoxValues)
		{
			fCol.filterComboBoxBuildFromGrid=YES;
			fCol.filterComboBoxDataProvider=nil;
		}
	}
	[self rebuild];
}

-(void)clearFilter
{
	[self clearFilterByField:nil];
}

-(void)clearFilterByField:(NSString*)col
{
	if(col)
	{
		FLXSFilter* f = [self getRootFilter];
		FLXSFilterExpression* farg = (FLXSFilterExpression*) [FLXSUIUtils doesArrayContainObjectValue:f.arguments valueField:(@"columnName") compareVal:col];
		if(farg)
		{
			[f.arguments removeObjectAtIndex:([f.arguments indexOfObject:farg])];
		}
	}
	else
	{
        [self.itemFilters removeObjectForKey:@"ROOT_FILTER"];
	}
	for(FLXSFlexDataGridColumn* fCol in self.columnLevel.columns)
	{
		if(([fCol.searchField isEqual:col]||col==nil) && fCol.useCurrentDataProviderForFilterComboBoxValues)
		{
			fCol.filterComboBoxBuildFromGrid=YES;
			fCol.filterComboBoxDataProvider=nil;
		}
	}
	if(self.filterContainer.rows.count>0)
	{
		_triggerEvent=NO;
        [(FLXSRowInfo *)[self.filterContainer.rows objectAtIndex:0] clearFilter:col];
		_triggerEvent=YES;
        [(FLXSRowInfo *)[self.filterContainer.rows objectAtIndex:0]  processFilter];
	}
}

- (void)shiftColumns:(FLXSFlexDataGridColumn *)columnToInsert insertBefore:(FLXSFlexDataGridColumn *)insertBefore level:(FLXSFlexDataGridColumnLevel *)level movingCg:(BOOL)movingCg {
	[level shiftColumns:columnToInsert insertBefore:insertBefore movingCg:movingCg];
	[self.bodyContainer shiftColumns:columnToInsert insertBefore:insertBefore];
	[self reDraw];
}

-(BOOL)filterVisible
{
	return self.columnLevel.filterVisible;
}

-(BOOL)headerVisible
{
	return self.columnLevel.headerVisible;
}

-(BOOL)footerVisible
{
	return self.columnLevel.footerVisible;
}

-(BOOL)pagerVisible
{
	return self.columnLevel.pagerVisible;
}

-(float)pagerRowHeight
{
	return self.columnLevel.pagerRowHeight;
}

-(void)setPagerRowHeight:(float)val
{
	self.columnLevel.pagerRowHeight=val;
}

-(UIView<FLXSIExtendedPager>*)pagerControl
{
	return [self.pagerContainer getPager];
}

-(void)setFilterVisible:(BOOL)val
{
	if(val!=self.columnLevel.filterVisible)
	{
	}
	self.columnLevel.filterVisible=val;
}

-(void)setHeaderVisible:(BOOL)val
{
	self.columnLevel.headerVisible=val;
}

-(void)setFooterVisible:(BOOL)val
{
	self.columnLevel.footerVisible=val;
}

-(void)setPagerVisible:(BOOL)val
{
	self.columnLevel.pagerVisible=val;
}

-(float)filterRowHeight
{
	return self.columnLevel.filterRowHeight;
}

-(void)setFilterRowHeight:(float)val
{
	self.columnLevel.filterRowHeight=val;
}


-(float)footerRowHeight
{
	return self.columnLevel.footerRowHeight;
}

-(void)setFooterRowHeight:(float)val
{
	self.columnLevel.footerRowHeight=val;
}




-(BOOL)enableFilters
{
	return self.columnLevel.enableFilters;
}

-(void)setEnableFilters:(BOOL)enabled
{
	self.columnLevel.enableFilters=enabled;
}

-(FLXSFlexDataGridColumn*)dragColumn
{
	return _dragColumn;
}

-(BOOL)enablePaging
{
	return self.columnLevel.enablePaging;
}

-(void)setEnablePaging:(BOOL)enabled
{
	self.columnLevel.enablePaging=enabled;
}

-(BOOL)editable
{
    return self.rowEditBehavior.enabled;
}

-(void)setEditable:(BOOL)val
{
    self.rowEditBehavior.enabled  =val;
}

- (BOOL)isToolbarActionValid:(FLXSToolbarAction *)action currentTarget:(NSObject *)currentTarget extendedPager:(UIView <FLXSIExtendedPager> *)extendedPager {
    
	if(action.isEnabledFunction != nil)
	{
		//return [action isEnabledFunction:action :self];
	}
	else if(self.toolbarActionValidFunction!=nil)
	{
		//return self.toolbarActionValidFunction (action ,currentTarget ,extendedPager);
        //SEL selector = NSSelectorFromString(self.toolbarActionValidFunction);
        //id target = self.delegate;
        return YES;
        //return [(NSNumber *)((NSNumber(*)(id, SEL, FLXSToolbarAction *, NSObject *, UIView<FLXSIExtendedPager>*))objc_msgSend)(target, selector, action ,currentTarget ,extendedPager) boolValue];
	}
	else if(action.requiresSingleSelection)
	{
		if([self getSelectedKeys].count==1)
		{
			float appliesToLevel=action.level;
			FLXSFlexDataGridColumnLevel* itemLvl=
                    [self getLevelForItem:[[self getSelectedObjects:NO:NO] objectAtIndex:0] flat:nil level:nil ];
			if(appliesToLevel==-1 || (itemLvl&&(itemLvl.nestDepth==appliesToLevel)))
				return YES;
			else
                return NO;
		}
		return NO;
	}
	else if(action.requiresSelection)
	{
		return [self getSelectedKeys].count>0;
	}
	return YES;
}

- (void)enableDisableToolbarAction:(NSString *)code enable:(BOOL)enable {
	FLXSToolbarAction* existingAction = [self getActionByCode:code];
	if(existingAction)
		existingAction.enabled=enable;
}

-(UIView*)getToolbarActionButton:(NSString*)code
{
    FLXSToolbarAction* existingAction = [self getActionByCode:code];
	if(existingAction)
		return (UIView *)existingAction.trigger;
	return nil;
}

- (void)setToolbarActionButtonProperty:(NSString *)toolbarActionCode property:(NSString *)property value:(id)value {
	UIView* button = [self getToolbarActionButton:toolbarActionCode];
	if(button)
	{
		if([button respondsToSelector:@selector(property)])
		{
            [button setValue:value forKey:property];
		}
	}
}

-(BOOL)forcePagerRow
{
	return self.columnLevel.forcePagerRow;
}

-(void)setForcePagerRow:(BOOL)val
{
	self.columnLevel.forcePagerRow=val;
}

-(BOOL)enableFooters
{
	return self.columnLevel.enableFooters;
}

-(void)setEnableFooters:(BOOL)enabled
{
	self.columnLevel.enableFooters=enabled;
}



-(int)pageSize
{
	return self.columnLevel.pageSize;
}

-(void)setPageSize:(int)val
{
	if(self.columnLevel.pageSize!=val)
	{
		[self dispatchEvent:([[FLXSEvent alloc] initWithType:(@"pageSizeChanged")])];
		if(!self.isClientFilterPageSortMode)
		{
			self.columnLevel.pageSize=val;
			if([self.itemFilters objectForKey:@"ROOT_FILTER"])
			{
                ((FLXSFilter *)[self.itemFilters objectForKey:@"ROOT_FILTER"]).pageSize=val;
			}
			[self processRootFilter:nil];
		}
	}
	self.columnLevel.pageSize=val;
	if(self.enablePreferencePersistence && _preferencesLoaded)
	{
		[self rebuild];
	}
}

-(int)pageIndex
{
	return [self.pagerContainer getPager]?[self.pagerContainer getPager].pageIndex:-1;
}

-(void)setPageIndex:(int)val
{
	if([self.pagerContainer getPager])
	{
		[self.pagerContainer getPager].pageIndex=val;
	}
}

-(void)setPagerRenderer:(FLXSClassFactory*)val
{
	self.columnLevel.pagerRenderer=val;
}

-(FLXSClassFactory*)pagerRenderer
{
	return self.columnLevel.pagerRenderer;
}

-(int)lockedColumnCount
{
	return -1;
}

-(float)lockedColumnWidth
{
	return -1;
}

-(float)rightLockedWidth
{
	return [self.columnLevel getWidestRightLockedWidth:0];
}


-(NSString*)initialSortField
{
	return self.columnLevel.initialSortField;
}

-(void)setInitialSortField:(NSString*)value
{
	self.columnLevel.initialSortField = value;
}

-(BOOL)initialSortAscending
{
	return self.columnLevel.initialSortAscending;
}

-(void)setInitialSortAscending:(BOOL)value
{
	self.columnLevel.initialSortAscending = value;
}

-(NSString*)selectedKeyField
{
	return self.columnLevel.selectedKeyField;
}

-(void)setSelectedKeyField:(NSString*)val
{
	self.columnLevel.selectedKeyField=val;
}

-(NSString*)selectableField
{
	return self.columnLevel.selectableField;
}

-(void)setSelectableField:(NSString*)val
{
	self.columnLevel.selectableField=val;
}

-(NSString*)disabledField
{
	return self.columnLevel.disabledField;
}

-(void)setDisabledField:(NSString*)val
{
	self.columnLevel.disabledField=val;
}

-(NSMutableArray*)selectedKeys
{
	return self.columnLevel.selectedKeys;
}

-(NSMutableArray*)selectedObjects
{
	return self.columnLevel.selectedObjects;
}

-(NSArray*)getSelectedObjects:(BOOL)getKey :(BOOL)unSelected
{
    NSMutableArray* sObjects= [[NSMutableArray alloc] init] ;
	for(NSObject* item in unSelected?self.columnLevel.unSelectedObjects:self.selectedObjects)
	{
		[sObjects addObject:(getKey? [self.columnLevel getItemKey:item saveLevel:NO ] :item)];
	}
	if(self.columnLevel.nextLevel)
	{
		[self.columnLevel.nextLevel getSelectedObjects:sObjects getKey:getKey unSelected:unSelected];
	}
	return sObjects;
}

-(NSMutableArray*)getOpenObjects
{
       return [self.openItems mutableCopy] ;
}

-(NSArray*)getOpenKeys
{
    NSMutableArray* keys= [[NSMutableArray alloc] init];
	[self.columnLevel getOpenKeys:keys provider:nil ];
	return keys;
}

-(void)setOpenKeys:(NSArray*)keys
{
	[self.bodyContainer clearOpenItems];
	[self.columnLevel setOpenKeys:keys provider:nil ];
	[self rebuild];
}

- (void)setSelectedObjects:(NSArray *)objects openItems:(BOOL)openItems {
	[self.columnLevel setSelectedObjects:objects openItems:openItems];
}

- (void)setSelectedKeys:(NSArray *)objects openItems:(BOOL)openItems {
	[self.columnLevel setSelectedKeys:objects openItems:openItems];
}

-(NSArray*)getSelectedKeys
{
    return [self getSelectedObjects:YES :NO];
}

-(NSArray*)getUnSelectedKeys
{
	return [self getSelectedObjects:YES :YES];
}

-(NSMutableArray*)openItems
{
	return self.bodyContainer.openItems;
}

-(void)setOpenItems:(NSMutableArray*)val
{
	self.bodyContainer.openItems=[[NSMutableArray alloc] initWithArray:val];
}

-(NSString*)traceRows
{
	NSString* str=@"";
	for(FLXSFlexDataGridColumn* col in self.columnLevel.columns)
	{
		str= [[[NSNumber numberWithFloat:col.width] description] stringByAppendingString: @":"];
	}
	return str;
}


-(void)gotoRow:(int)rowIndex
{
	[self.bodyContainer gotoRow:rowIndex];
	[self synchronizeLockedVerticalScroll];
}

-(void)selectText:(NSString*)txt
{
	[self.bodyContainer selectText:txt];
}

- (void)gotoItem:(NSObject *)item highlight:(BOOL)highlight level:(FLXSFlexDataGridColumnLevel *)level {
	[self.bodyContainer gotoItem:item highlight:highlight useItemKeyForCompare:NO level:level rebuild:YES ];
	[self synchronizeLockedVerticalScroll];
}

- (void)gotoKey:(NSObject *)key highlight:(BOOL)highlight level:(FLXSFlexDataGridColumnLevel *)level {
	[self.bodyContainer gotoItem:key highlight:highlight useItemKeyForCompare:YES level:level rebuild:YES ];
	[self synchronizeLockedVerticalScroll];
}

- (NSArray *)quickFind:(NSString *)whatToFind searchCols:(NSArray *)searchCols breakAfterFind:(BOOL)breakAfterFind captureCols:(BOOL)captureCols {
	return [self.bodyContainer quickFind:whatToFind flat:nil level:nil result:nil searchColumns:searchCols breakAfterFind:breakAfterFind captureColumns:captureCols];
}

-(UIView<FLXSIFlexDataGridCell>*)getCurrentEditingCell
{
	return (UIView<FLXSIFlexDataGridCell>*)_editCell;
}

-(UIView*)getCurrentEditor
{
	return _editor;
}

-(void)synchronizeLockedVerticalScroll
{
    self.leftLockedContent.verticalScrollPosition=self.rightLockedContent.verticalScrollPosition=self.bodyContainer.verticalScrollPosition;
}

-(void)synchronizeHorizontalScroll
{
	self.headerContainer.horizontalScrollPosition =self.footerContainer.horizontalScrollPosition =self.filterContainer.horizontalScrollPosition =self.bodyContainer.horizontalScrollPosition;
}

- (NSArray *)getFilteredPagedSortedData:(FLXSKeyValuePairCollection *)dictionary applyFilter:(BOOL)applyFilter applyPaging:(BOOL)applyPaging applySort:(BOOL)applySort pages:(NSArray *)pages {
    return [self.bodyContainer getFilteredPagedSortedData:dictionary applyFilter:applyFilter applyPaging:applyPaging applySort:applySort pages:pages flatten:NO ];
}

-(FLXSRowPositionInfo*)getItemAtPosition:(float)position
{
	return [self.bodyContainer getItemAtPosition:position];
}

-(FLXSFlexDataGridContainerBase*)getParentContainer:(UIView<FLXSIFlexDataGridCell>*)cell
{
	if([cell.superview isEqual:self.bodyContainer ]|| [cell.superview isEqual:self.leftLockedContent] || [cell.superview isEqual:self.rightLockedContent])
		return self.bodyContainer;
	if(cell.rowInfo.isFilterRow && [cell.level isEqual:self.columnLevel])
		return self.filterContainer;
	if(cell.rowInfo.isHeaderRow && [cell.level isEqual:self.columnLevel])
		return self.headerContainer;
	if(cell.rowInfo.isFooterRow && [cell.level isEqual:self.columnLevel])
		return self.footerContainer;
	return self.bodyContainer;
}

- (int)getChildrenLength:(NSObject *)object level:(FLXSFlexDataGridColumnLevel *)level filter:(BOOL)filter page:(BOOL)page sort:(BOOL)sort {
	NSObject* children= [self getChildren:object level:level filter:filter page:page sort:sort];
	return [self getLength:children];
}

-(int)getLength:(NSArray*)arr
{
	return (int)[arr count];
}

- (NSArray *)getChildren:(NSObject *)object level:(FLXSFlexDataGridColumnLevel *)level filter:(BOOL)filter page:(BOOL)page sort:(BOOL)sort {
	NSArray* result;
	if(self.getChildrenFunction!=nil)
	{
		//result=self.getChildrenFunction(object,level);
        
        SEL selector = NSSelectorFromString(self.getChildrenFunction);
        id target = self.delegate;
        result= ((NSArray*(*)(id, SEL, NSObject*,FLXSFlexDataGridColumnLevel *))objc_msgSend)(target, selector, object,level);
        
    }
    
	else
	{
		if(level.childrenField==nil || [level.childrenField isEqual:@""])return [[NSMutableArray alloc] init];
		result= [FLXSExtendedUIUtils resolveExpression:object expression:level.childrenField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];
	}
	if(result==nil)return [[NSMutableArray alloc] init];
	if(filter||page||sort)
	{
		return [self.bodyContainer filterPageSort:result level:(level.nextLevel ? level.nextLevel : level) parentObj:object applyFilter:filter applyPaging:page applySort:sort pages:nil updatePager:NO ];
	}
	else
	{
		return result;
	}
    return nil;
}

- (NSObject *)getParent:(NSObject *)object level:(FLXSFlexDataGridColumnLevel *)level {
    //	if(self.enableVirtualScroll)
    //	{
    //		return [self.virtualBodyContainer getParentOpenItemFromObject:object];
    //	}
	NSObject* result;
    
	{
		if(level.parentField==nil || [level.parentField isEqual:@""])
		{
			result = [self.bodyContainer.parentMap getValue:object];
		}
		else
            result= [object valueForKey:level.parentField];
	}
	return result;
}

-(NSArray*)getDataForPrintExport:(FLXSPrintExportOptions*)printOptions
{
	if([printOptions.printExportOption isEqual:[FLXSPrintExportOptions PRINT_EXPORT_CURRENT_PAGE]])
	{
		if(self.isClientFilterPageSortMode)
			return [self getFilteredPagedSortedData:([[FLXSKeyValuePairCollection alloc] init]) applyFilter:YES applyPaging:YES applySort:YES pages:nil ];
		else
            return self.dataProviderFLXS;
		//just use same dp as main grid in server mode.
	}
	else if([printOptions.printExportOption isEqual:[FLXSPrintExportOptions PRINT_EXPORT_SELECTED_RECORDS]])
	{
		return self.selectedObjects;
	}
	else
	{
		//all or checked pages, in server mode, dispatch event. in client mode, do page math.
		if(self.isClientFilterPageSortMode)
		{
			if([printOptions.printExportOption isEqual:[FLXSPrintExportOptions PRINT_EXPORT_SELECTED_PAGES]])
				return [self getFilteredPagedSortedData:([[FLXSKeyValuePairCollection alloc] init]) applyFilter:YES applyPaging:YES applySort:YES pages:[[NSArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:self.excelOptions.pageFrom],
                                                                                                                                                                                         [[NSNumber alloc] initWithInt:self.excelOptions.pageTo], nil]];
			else
                return [self getFilteredPagedSortedData:([[FLXSKeyValuePairCollection alloc] init]) applyFilter:YES applyPaging:NO applySort:YES pages:nil ];
			// all pages
		}
		else
		{
			return self.printExportData;
		}
	}
}

-(void)showColumns:(NSMutableArray*)colsToShow
{
	[self.columnLevel showColumns:colsToShow];
}

-(void)showPrintableColumns
{
	[self.columnLevel showPrintableColumns];
}

-(NSMutableArray*)getFilterArguments
{
	return [self.filterContainer getFilterArguments];
}

-(FLXSFilter*)getRootFilter
{
	if(![self.itemFilters objectForKey:@"ROOT_FILTER"])
	{
        [self.itemFilters setObject:[[FLXSAdvancedFilter alloc] init] forKey:@"ROOT_FILTER"];
        ((FLXSFilter *)[self.itemFilters objectForKey:@"ROOT_FILTER"]).pageIndex = 0;
	}
	return ((FLXSFilter*)[self.itemFilters objectForKey:@"ROOT_FILTER"]);
}

- (void)setFilterValue:(NSString *)col value:(NSObject *)val triggerEvent:(BOOL)triggerEvent {
	FLXSFlexDataGridColumn* gridCol = [self.columnLevel getColumnByDataField:col by:@"searchField"];
	FLXSFilter* rootFilter= [self getRootFilter];
	[rootFilter addOperatorCriteria:gridCol.searchField operation:gridCol.filterOperation compareValue:val wasContains:NO ];
	if([self.filterContainer.rows count] ==0)
	{
		[self rebuildFilter];
	}
	[self.filterContainer setFilterValue:col val:val];
	if(triggerEvent)
		[self processFilter];
}

-(BOOL)setFilterFocus:(NSString*)fld
{
	return [self.filterContainer setFilterFocus:fld];
}

-(id)getFilterValue:(NSString*)col
{
	FLXSFilter* rootFilter= [self getRootFilter];
	return [rootFilter getFilterValue:col];
}

-(void)processSort:(NSMutableArray*)sorts
{
	[self.columnLevel removeAllSorts];
	for(FLXSFilterSort* sort in sorts)
		[self.columnLevel addSort:sort];
	[self rebuildBody:NO];
	[self rebuildHeader];
}

-(void)clearColumns:(BOOL)rebuild
{
	[self.columnLevel clearColumns: rebuild];
}

-(void)addColumn:(FLXSFlexDataGridColumn*)col
{
	[self.columnLevel addColumn:col];
}

-(void)removeColumn:(FLXSFlexDataGridColumn*)col
{
	[self.columnLevel removeColumn:col];
}

-(FLXSFlexDataGridColumn*)getColumnByDataField:(NSString*)fld
{
	return [self.columnLevel getColumnByDataField:fld by:@"dataFieldFLXS"];
}

-(FLXSFlexDataGridColumn*)getColumnByUniqueIdentifier:(NSString*)fld
{
	return [self.columnLevel getColumnByUniqueIdentifier:fld];
}

-(void)distributeColumnWidthsEqually
{
	[self.columnLevel distributeColumnWidthsEqually];
}

-(int)maxDepth
{
    
	FLXSFlexDataGridColumnLevel* level=self.columnLevel;
	while(level.nextLevel!=nil)
	{
		level=level.nextLevel;
	}
	return level.nestDepth + (level.nextLevelRenderer?1:0);
}

-(BOOL)canExpandUp
{
	return self.maxDepth>1 && _currentExpandLevel>0;
}

-(BOOL)canExpandDown
{
	return self.maxDepth>1 && _currentExpandLevel<self.maxDepth-1;
}

-(FLXSFlexDataGridColumnLevel*)getLevel:(int)levelDepth
{
	FLXSFlexDataGridColumnLevel* level=self.columnLevel;
	while(level!=nil)
	{
		if(level.nestDepth==levelDepth)
			return level;
		level=level.nextLevel;
	}
	return nil;
}

-(void)expandToLevel:(int)level
{
	if(self.enableVirtualScroll){
        //throw [[Error alloc] initWithType:(@"This method is not supported when enableVirtualScroll=YES")];
    }
	if(level<self.maxDepth && level>=0)
	{
		_currentExpandLevel=level;
		[self.bodyContainer clearOpenItems];
		if(_currentExpandLevel>0)
		{
			NSArray* items= [self flatten:_currentExpandLevel inclusive:YES filter:YES page:NO sort:YES max:(-1)];
			for(NSObject* item in items)
			{
				[self.bodyContainer addOpenItem:item rowPositionInfo:nil ];
			}
		}
		[self dispatchEvent:([[FLXSEvent alloc] initWithType:(@"expandChanged")])];
		[self rebuildBody:NO];
	}
}

-(void)rebuildBody:(BOOL)vupdateTotalRecords
{
	if(self.inRebuildBody)return;
	//what we call could end up calling us depending on what event handlers are wired up in the client code.
    self.inRebuildBody=YES;
    self.updateTotalRecords=vupdateTotalRecords;
	[self.bodyContainer invalidateCalculatedHeight];
	[self.currentPoint reset];
	[self.bodyContainer createComponents:self.columnLevel currentScroll:0 flat:nil ];
    self.updateTotalRecords=YES;
    self.inRebuildBody=NO;
}

-(void)rebuildBodyDeferred
{
	_rebuildBodyPending=YES;
	[self setNeedsDisplay];
}

-(void)rebuildHeader
{
	[self.currentPoint reset];
	[self.headerContainer createComponents:self.columnLevel currentScroll:0 flat:nil ];
}

-(void)rebuildPager
{
	[self.currentPoint reset];
	[self.pagerContainer createComponents:self.columnLevel currentScroll:0 flat:nil ];
}

-(void)rebuildFooter
{
	[self.currentPoint reset];
	[self.footerContainer createComponents:self.columnLevel currentScroll:0 flat:nil ];
}

-(void)rebuildFilter
{
	[self.currentPoint reset];
	[self.filterContainer createComponents:self.columnLevel currentScroll:0 flat:nil ];
}

-(void)redrawBody
{
	[self.currentPoint reset];
	[self.bodyContainer createComponents:self.columnLevel currentScroll:0 flat:nil ];
}

-(void)expandUp
{
	[self expandToLevel:(_currentExpandLevel-1)];
}

-(void)expandDown
{
	[self expandToLevel:(_currentExpandLevel+1)];
}

-(void)expandAllColumnGroups:(int)lvl
{
	for(FLXSFlexDataGridColumnGroup* cg in [self.columnLevel getColumnGroupsAtLevel:lvl grps:nil result:nil start:0 all:NO ])
	{
		[cg openColumns];
	}
}

-(void)collapseAllColumnGroups:(int)lvl
{
    for(FLXSFlexDataGridColumnGroup* cg in [self.columnLevel getColumnGroupsAtLevel:lvl grps:nil result:nil start:0 all:NO ])
	{
		[cg closeColumns];
	}
}

-(void)expandAll
{
	[self expandToLevel:(self.maxDepth-1)];
}

-(void)collapseAll
{
	[self expandToLevel:0];
}

-(UIView*)currentTooltip
{
	return self.tooltipBehavior.currentTooltip;
}

-(UIView*)currentTooltipTrigger
{
	return self.tooltipBehavior.currentTooltipTrigger;
}

- (void)showTooltip:(UIView *)relativeTo tooltip:(UIView *)tooltip dataContext:(NSObject *)dataContext point:(Point *)point leftOffset:(float)leftOffset topOffset:(float)topOffset offScreenMath:(BOOL)offScreenMath where:(NSString *)where container:(NSObject *)container {
	[self.tooltipBehavior showTooltip:relativeTo tooltip:tooltip dataContext:dataContext point:point leftOffset:leftOffset topOffset:topOffset offScreenMath:offScreenMath where:where container:container];;
}

-(void)hideTooltip
{
	[self.tooltipBehavior hideTooltip];
}


- (FLXSFilter *)getItemFilter:(FLXSFlexDataGridColumnLevel *)level item:(NSObject *)item {
    return [self.itemFilters objectForKey:(level.nestDepth==1?@"ROOT_FILTER":item)];
}


-(void)enableAutoRefresh:(BOOL)value
{

    //	_enableAutoRefresh = value;
    //	if(_enableAutoRefresh && !self.autoRefreshTimer)
    //	{
    //		if (self.autoRefreshTimer == nil)
    //		{
    //            self.autoRefreshTimer = [[NSTimer alloc] init:autoRefreshInterval];
    //			[self.autoRefreshTimer addEventListener:[TimerEvent TIMER] :dispatchAutoRefreshEvent :NO :0 :YES];
    //		}
    //		autoRefreshTimer.repeatCount = 0;
    //		// starts the timer ticking
    //		[autoRefreshTimer start];
    //	}
    //	else if(!_enableAutoRefresh && autoRefreshTimer)
    //	{
    //		[autoRefreshTimer stop];
    //		[autoRefreshTimer removeEventListener:[TimerEvent TIMER] :dispatchAutoRefreshEvent :NO];
    //		autoRefreshTimer=nil;
    //	}
}

-(void)dispatchAutoRefreshEvent:(FLXSEvent*)event
{
    //todo v1.2
    	self.lastAutoRefresh = [[NSDate alloc] init];
    //	if(enableAutoRefresh && autoRefreshTimer)
    //	{
    //		[autoRefreshTimer stop];
    //		[autoRefreshTimer start];
    //	}
	[self dispatchEvent:([[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent AUTO_REFRESH] andGrid:self andLevel:nil andColumn:nil andCell:nil andItem:nil andTriggerEvent:event andBubbles:NO andCancelable:NO ])];
}


-(void)autoRefreshInterval:(float)value
{
    //todo v1.2
    //	_autoRefreshInterval = value;
    //	//to force the timer.
    //	if(autoRefreshTimer)
    //	{
    //		autoRefreshTimer.delay=value;
    //	}
}

-(NSObject*)defaultCreateRowNumberColumn
{
	return nil;
}

-(NSString*)defaultGetRowIndex:(UIView<FLXSIFlexDataGridDataCell>*)cell
{
    //todo v1.2
    //	NSObject* provider;
    //	if(cell.level.nestDepth==1)
    //	{
    //		provider= [self getRootFlat];
    //	}
    //	else
    //	{
    //		NSObject* parent=[self getParent:cell.rowInfo.data :cell.level];
    //		if(parent)
    //		{
    //			provider = [self getChildren:parent :cell.level.parentLevel];
    //		}
    //	}
    //	if(provider && [provider hasOwnProperty:(@"indexOfObject")])
    //	{
    //		return [([provider indexOfObject:cell.rowInfo.data]+1) toString];
    //	}
    //	else if(provider is Array)
    //	{
    //		return [([provider indexOf:cell.rowInfo.data]+1) toString];
    //	}
    //	return @"1";
    return nil;
}


-(void)lastAutoRefresh:(NSDate*)value
{
	_lastAutoRefresh = value;
	[self dispatchEvent:([[FLXSEvent alloc] initWithType:(@"autoRefreshUpdate")])];
}

-(NSString*)defaultExpandCollapseTooltipFunction:(UIView<FLXSIFlexDataGridCell>*)cell
{
	if(!self.allowInteractivity)return @"";
	if ([cell.level isItemOpen:cell.rowInfo.data])
	{
		return self.collapseTooltip;
	}
	else
	{
		return self.expandTooltip;
	}
    return nil;
}

-(void)setToolbarActions:(NSArray*)actions
{
	[self.toolbarActions removeAllObjects];
	for(NSObject* item in actions)
	{
		FLXSToolbarAction* tba = [self extractAction:item];
		[self.toolbarActions addObject:tba];
	}
}

-(FLXSToolbarAction*)extractAction:(FLXSToolbarAction*)item
{
	FLXSToolbarAction* tba = item  ;
	if(!tba)
	{
		tba = [[FLXSToolbarAction alloc] init];
        NSArray* info = [FLXSUIUtils getClassInfo:[item class]];
        
        for(FLXSLabelData *lblData in info)
		{
			if([FLXSUIUtils isPrimitive:lblData.data] )
			{
                [tba setValue:[item valueForKey:lblData.label] forKey:lblData.label];
			}
		}
	}
	return tba;
}

- (void)addToolbarAction:(NSObject *)action itemIndex:(int)itemIndex {
	FLXSToolbarAction* tba = [self extractAction:action];
	if(itemIndex>=0)
		[self.toolbarActions insertObject:tba atIndex:itemIndex];
	else
        [self.toolbarActions addObject:tba];
}

-(void)removeToolbarAction:(NSString*)code
{
	FLXSToolbarAction* tba ;
	for(FLXSToolbarAction* item in self.toolbarActions)
	{
		if([item.code isEqual:code])
		{
			tba=item;
			break;
		}
	}
	if(tba)
	{
		[self.toolbarActions removeObjectAtIndex:([self.toolbarActions indexOfObject:tba])];
	}
}

-(FLXSToolbarAction*)toolbarActionEdit
{
	return [self createBuiltinAction:(@"Edit") code:@"edit" requiresSelection:YES requiresSingleSelection:YES ];
}

-(FLXSToolbarAction*)toolbarActionSort
{
	return [self createBuiltinAction:(@"Sort") code:@"sort" requiresSelection:NO requiresSingleSelection:NO ];
}

-(FLXSToolbarAction*)toolbarActionDelete
{
	return [self createBuiltinAction:(@"Delete") code:@"delete" requiresSelection:YES requiresSingleSelection:YES ];
}

-(FLXSToolbarAction*)toolbarActionMoveTo
{
	FLXSToolbarAction* act= [self createBuiltinAction:(@"Move to") code:@"moveTo" requiresSelection:YES requiresSingleSelection:YES ];
	act.requiresSingleSelection=YES;
	return act;
}

-(FLXSToolbarAction*)toolbarActionMoveUp
{
	FLXSToolbarAction* act= [self createBuiltinAction:(@"") code:[FLXSFlexDataGrid MOVE_UP] requiresSelection:YES requiresSingleSelection:YES ];
	act.requiresSingleSelection=YES;
	return act;
}

-(FLXSToolbarAction*)toolbarActionSeparator
{
	return [self createBuiltinAction:(@"separator") code:(@"separator") requiresSelection:NO requiresSingleSelection:NO ];
}

-(FLXSToolbarAction*)toolbarActionMoveDown
{
	FLXSToolbarAction* act= [self createBuiltinAction:(@"") code:[FLXSFlexDataGrid MOVE_DOWN] requiresSelection:YES requiresSingleSelection:YES ];
	act.requiresSingleSelection=YES;
	return act;
}

-(FLXSToolbarAction*)toolbarActionAddRow
{
	return [self createBuiltinAction:(@"Add Row") code:(@"addRow") requiresSelection:NO requiresSingleSelection:NO ];
}

-(FLXSToolbarAction*)toolbarActionFilter
{
	return [self createBuiltinAction:(@"Filter") code:(@"filter") requiresSelection:NO requiresSingleSelection:NO ];
}

- (void)runToolbarAction:(FLXSToolbarAction *)action currentTarget:(NSObject *)currentTarget extendedPager:(UIView <FLXSIExtendedPager> *)extendedPager {
	if(self.toolbarActionExecutedFunction!=nil)
	{
		//SEL selector = NSSelectorFromString(self.toolbarActionExecutedFunction);
        //id target = self.delegate;
        //objc_msgSend(target, selector, currentTarget,extendedPager) ;
        
    }
	else if(action.executedFunction != nil)
	{
        //SEL selector = NSSelectorFromString(self.toolbarActionExecutedFunction);
       // id target = self.delegate;
        //objc_msgSend(target, selector, action,self) ;
	}
	FLXSWrapperEvent* w= [[FLXSWrapperEvent alloc] initWithType:(@"toolbarActionExecuted") andData:action andBubbles:NO andCancelable:NO ];
    [self dispatchEvent:w];
	if([w isDefaultPrevented])return;
    NSMutableArray* list;
	if(action)
	{
		if([action.code isEqual:@"filter"])
		{
			self.preservePager=YES;
            self.enableFilters=!self.enableFilters;
		}
		else if([action.code isEqual:@"sort"])
		{
			//assumption is that the multi column sort is enabled
			[self multiColumnSortShowPopup];
		}
		else if([action.code isEqual:@"addRow"])
		{
            list =(NSMutableArray*)[self getRootFlat];
            NSObject *obj = [[[[list objectAtIndex:0] class] alloc] init];
            [list addObject:obj];
			[self trackChange:obj changeType:[FLXSChangeInfo CHANGE_TYPE_INSERT] changeLevel:nil changedProperty:nil previousValue:nil changedValue:nil ];
            [self rebuild];
		}
		else if([action.code isEqual:@"delete"])
		{
			NSObject* todelete = self.selectedItem;
			if(todelete)
			{
				list = [[self getRootFlat] mutableCopy];
				FLXSFlexDataGridColumnLevel* lvl = [self getLevelForItem:todelete flat:nil level:nil ];
				if(lvl && lvl.nestDepth>1)
				{
					NSObject* parent= [self getParent:todelete level:lvl];
					if(parent)
						list=(NSMutableArray*) [self getChildren:parent level:lvl filter:NO page:NO sort:NO ];
				}
                
                [list removeObjectAtIndex:([list indexOfObject:todelete])];
				[self clearSelection];
				[self trackChange:todelete changeType:[FLXSChangeInfo CHANGE_TYPE_DELETE] changeLevel:nil changedProperty:nil previousValue:nil changedValue:nil ];
				[self rebuild];
			}
		}
		else if(action.code==[FLXSFlexDataGrid MOVE_UP] ||
                action.code==[FLXSFlexDataGrid MOVE_DOWN] ||
                action.code==[FLXSFlexDataGrid MOVE_TOP]||
                action.code==[FLXSFlexDataGrid MOVE_BOTTOM])
		{
			NSObject* selectedObj = [[self getSelectedObjects :NO :NO] objectAtIndex:0];
			FLXSRowInfo* selectedRowInfo;
			for(FLXSRowInfo* rowInfo in self.bodyContainer.rows)
			{
				if(rowInfo.data==selectedObj)
				{
					selectedRowInfo=rowInfo;
					break;
				}
			}
			if(selectedRowInfo)
			{
				FLXSFlexDataGridColumnLevel* level=[selectedRowInfo.rowPositionInfo getLevel:self];
				NSMutableArray* flat;
				if(level.nestDepth==1)
				{
					flat=(NSMutableArray*)[self getRootFlat];
				}
				else
				{
					NSObject* parent1 = [self getParent:selectedObj level:level];
					flat=(NSMutableArray*) [self getChildren:parent1 level:level.parentLevel filter:NO page:NO sort:NO ];
				}
                
                int itemIndex=(int)[flat indexOfObject:selectedObj];
                int newIndex= [FLXSFlexDataGrid getNewIndex:flat item:selectedObj direction:action.code];
                
                [flat removeObjectAtIndex: itemIndex ];
                [flat insertObject:selectedObj atIndex:newIndex];
                self.preservePager=YES;
                [self rebuild];
			}
		}
	}
}

+ (int)getNewIndex:(NSMutableArray *)lcw item:(NSObject *)item direction:(NSString *)direction {
	int index = (int)[lcw indexOfObject: item ];
	if ([direction isEqual: [FLXSFlexDataGrid MOVE_UP]])
	{
		if (index == 0)
		{
			return 0;
		}
		else
		{
			return --index;
		}
	}
	else
	{
		if (index == [lcw count] - 1)
		{
			return (int)[lcw count] - 1;
		}
		else
		{
			return ++index;
		}
	}
}


- (FLXSToolbarAction *)createBuiltinAction:(NSString *)lbl code:(NSString *)code requiresSelection:(BOOL)requiresSelection requiresSingleSelection:(BOOL)requiresSingleSelection {
	FLXSToolbarAction* tb = [[FLXSToolbarAction alloc] init];
	tb.code=code?code:lbl;
    tb.name=lbl;
	FLXSToolbarAction* existingAction = [self getActionByCode:tb.code];
	if(existingAction)return existingAction;
	tb.iconUrl=[self getStyle:[[[NSArray alloc] initWithObjects:@"toolbarAction",[FLXSCellUtils doCap:tb.code],@"IconUrl",nil] componentsJoinedByString:@""]];
	tb.disabledIconUrl=[self getStyle:[[[NSArray alloc] initWithObjects:@"toolbarAction",[FLXSCellUtils doCap:tb.code],@"DisabledIconUrl",nil] componentsJoinedByString:@""]];
	tb.requiresSelection = requiresSelection;
	tb.requiresSingleSelection= requiresSingleSelection;
	tb.tooltip = lbl;
	return tb;
}

-(FLXSToolbarAction*)getActionByCode:(NSString*)code
{
	for(FLXSToolbarAction* tba in self.toolbarActions)
	{
		if([tba.code isEqual:code])
			return tba;
	}
	return nil;
}

-(void)setPredefinedFilters:(NSArray*)filters
{
	[self.predefinedFilters removeAllObjects];
	for(NSObject* item in filters)
	{
		FLXSFilter* f=[[FLXSFilter alloc] init];
		[f copyFrom:item];
        [self.predefinedFilters addObject:f];
	}
}

- (void)setErrorByKey:(id)key fld:(NSString *)fld errorMsg:(NSString *)errorMsg {
	NSObject* obj = [self.columnLevel getItemFromKey:key flat:nil ];
	if(obj)
	{
		[self setErrorByObject:obj fld:fld errorMsg:errorMsg];
	}
	else
	{
		//throw [[Error alloc] initWithType:(@"Item with key " + key + @" not found.")];
	}
}

- (void)setErrorByObject:(NSObject *)item fld:(NSString *)fld errorMsg:(NSString *)errorMsg {
	if(![self.errorMap hasHey:item])
        [self.errorMap addItem:item value:[[NSMutableDictionary alloc] init]];
    [(NSMutableDictionary *)[self.errorMap getValue:item] setObject:errorMsg forKey:fld];
    self.hasErrors=YES;
	UIView<FLXSIFlexDataGridCell>* cell = [self.bodyContainer getCellForRowColumn:item column:nil includeExp:NO ];
	//next version v1.2
	//if(_editor)[_editor errorString]=errorMsg;
    
	if(cell)
		[cell.rowInfo invalidateCells];
}

- (void)clearErrorByKey:(id)key fld:(NSString *)fld {
	NSObject* obj = [self.columnLevel getItemFromKey:key flat:nil ];
	if(obj)
	{
		[self clearErrorByObject:obj fld:fld];
	}
	else
	{
		//throw [[Error alloc] initWithType:(@"Item with key " + key + @" not found.")];
	}
	self.hasErrors= [[self getAllErrorString] length] >0;
}

-(void)clearAllErrors
{
    [self.errorMap clear];
	[self.bodyContainer invalidateCells];
}

- (void)clearErrorByObject:(NSObject *)item fld:(NSString *)fld {
	if(fld && [self.errorMap hasHey:item    ])
	{
        NSMutableDictionary * dic =(NSMutableDictionary*)[self.errorMap getValue:item ];
        [dic removeObjectForKey:fld];
		BOOL hasErrors=NO;
        
//        for (NSString *prop in dic.keyEnumerator){
//            hasErrors = YES;
//        }
        if(dic.count>0)
        {
            hasErrors = YES;
        }
        if(!hasErrors){
            [self.errorMap removeItem:item];
        }
	}
    else if ([self.errorMap hasHey:item])
        [self.errorMap removeItem:item];
	UIView<FLXSIFlexDataGridCell>* cell = [self.bodyContainer getCellForRowColumn:item column:nil includeExp:NO ];
	if(cell)
		[cell.rowInfo invalidateCells];
}

-(NSObject*)getError:(NSObject*)item
{
	return [self.errorMap getValue:item    ];
}

-(NSString*)getAllErrorString
{
	NSString* result=@"";
	for (NSObject* item in self.errorMap.keys)
	{
		FLXSFlexDataGridColumnLevel* lvl = [self getLevelForItem:item flat:nil level:nil ];
		if(lvl)
		{
			id key= [lvl getItemKey:item saveLevel:NO ];
			result = [[[NSArray alloc] initWithObjects:
                       result, @"Item with ID " , [key description] , @" has the following errors:\n",nil] componentsJoinedByString:@""];
            NSDictionary * errors = (NSDictionary * )[self.errorMap getValue:item];
            for (id prop in errors)
			{
				result = [[[NSArray alloc] initWithObjects: result,  prop ,@":" , [[errors objectForKey:prop] description] , @"\n",nil]
                          componentsJoinedByString:@""];
			}
		}
	}
	return result;
}

- (FLXSFlexDataGridColumnLevel *)getLevelForItem:(id)itemToFind flat:(NSArray *)flat level:(FLXSFlexDataGridColumnLevel *)level {
	if(!flat)flat=[self getRootFlat];
	if(!level)level=self.columnLevel;
	for(NSObject* item in flat)
	{
		if([level areItemsEqual:item itemB:itemToFind])
		{
			return level;
		}
		if(level.nextLevel)
		{
			FLXSFlexDataGridColumnLevel* result= [self getLevelForItem:itemToFind flat:([level getChildren:item filter:NO page:NO sort:NO ]) level:level.nextLevel];
			if(result)
			{
				return result;
			}
		}
	}
	return nil;
}


- (float)getRowHeight:(NSObject *)item level:(FLXSFlexDataGridColumnLevel *)level rowType:(int)rowType {
	float ht=[level getRowHeight:rowType];
	if(!self.variableRowHeight || (rowType!=[FLXSRowPositionInfo ROW_TYPE_DATA]) )return ht;
    
	//if(self.getRowHeightFunction!=nil)return [self getRowHeightFunction:item :level :rowType];
    if(self.getRowHeightFunction!=nil){
        SEL selector = NSSelectorFromString(self.getRowHeightFunction);
        id target = self.delegate;
        return [((NSNumber*(*)(id, SEL, NSObject *, FLXSFlexDataGridColumnLevel *,int))objc_msgSend)(target, selector, item,level,rowType) floatValue];
    }
	for(FLXSFlexDataGridColumn* col in level.flowColumns)
	{
		float paddingLeft = [[col getStyleValue:(@"paddingLeft")] floatValue];
		float paddingTop = [[col getStyleValue:(@"paddingTop")] floatValue];
		float paddingRight = [[col getStyleValue:(@"paddingRight")] floatValue];
		float paddingBottom = [[col getStyleValue:(@"paddingBottomFLXS")] floatValue];
		paddingLeft+=col.enableHierarchicalNestIndent?level.maxPaddingCellWidth:0;
		ht = [self measureCellHeight:col paddingLeft:paddingLeft paddingRight:paddingRight paddingTop:paddingTop paddingBottom:paddingBottom itemRenderer:col.itemRenderer ht:ht text:([col itemToLabel:item :nil]) item:item style:col];
	}
	return ht;
}

- (float)measureCellHeight:(FLXSFlexDataGridColumn *)col
               paddingLeft:(float)paddingLeft
              paddingRight:(float)paddingRight
                paddingTop:(float)paddingTop
             paddingBottom:(float)paddingBottom
              itemRenderer:(FLXSClassFactory *)itemRenderer
                        ht:(float)ht
                      text:(NSString *)txt
                      item:(NSObject *)item
                     style:(NSObject *)styl {
	if(self.variableRowHeightUseRendererForCalculation && itemRenderer)
	{
		FLXSBaseUIControl* renderer=nil;
		if([self.bodyContainer.variableRowHeightRenderers getValue:col])
		{
			renderer=(FLXSBaseUIControl*)[self.bodyContainer.variableRowHeightRenderers getValue:col];
		}
		if(!renderer)
		{
			renderer = [itemRenderer generateInstance];
			[self.bodyContainer.variableRowHeightRenderers addItem:col value:renderer];
			[self addChild:renderer];
		}
		renderer.width = col.width;
        if([renderer respondsToSelector:NSSelectorFromString(@"column")])
            [renderer setValue:col forKey:@"column"];
        if([renderer respondsToSelector:NSSelectorFromString(@"columnFLXS")])
            [renderer setValue:col forKey:@"columnFLXS"];
		if([renderer respondsToSelector:NSSelectorFromString(@"text")])
            [renderer setValue:txt forKey:@"text"];
        if([renderer respondsToSelector:NSSelectorFromString(@"data")])
            [renderer setValue:item forKey:@"data"];
		float componentHeight=renderer.height+  paddingTop + paddingBottom+2;
		ht=componentHeight>ht?componentHeight:ht;
	}
	else
	{
        UIFont *cellFont = [FLXSFlexDataGrid measurerText].font;
        CGSize constraintSize = CGSizeMake(col.width - paddingLeft - paddingRight-4, MAXFLOAT);
        
        
        CGSize labelSize = [txt sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
        
		float displayHt=labelSize.height +  paddingTop + paddingBottom+2+self.variableRowHeightOffset;
		ht=MAX(ht,displayHt);
	}
	return ht;
}

- (void)showToaster:(NSString *)message toasterPosition:(NSString *)toasterPosition toasterRenderer:(FLXSClassFactory *)toasterRenderer animationDuration:(float)animationDuration visibleDuration:(float)visibleDuration moveAnimate:(BOOL)moveAnimate fadeAnimate:(BOOL)fadeAnimate {
	//[Toaster showToaster:message :toasterPosition :toasterRenderer :animationDuration :visibleDuration :moveAnimate :fadeAnimate];
}

-(NSArray*)filterRows
{
	return [self.filterContainer.rows mutableCopy];
}

-(NSArray*)footerRows
{
	return [self.footerContainer.rows mutableCopy];
}

-(UIView<FLXSIPager> *)pager
{
	return [self.pagerContainer getPager];
}

-(int)selectedIndex
{
    //	if(selectedObjects.count>0)
    //	{
    //		int i=0;
    //		NSObject* firstSelect=selectedObjects[0];
    //		for(FLXSRowPositionInfo* item in bodyContainer.itemVerticalPositions)
    //		{
    //			if(item.rowData==firstSelect)
    //			{
    //				return i;
    //			}
    //			i++;
    //		}
    //	}
    //	return -1;
    return 0;
}

-(NSArray*)selectedIndices
{
    //	NSMutableArray* results=[[NSMutableArray alloc] init];
    //	for (NSObject* item in selectedObjects)
    //	{
    //		[results addObject:([dataProviderFLXS indexOfObject:item])]
    //	}
    //	return results;
    return nil;
}

-(void)setSelectedIndex:(int)val
{
	[self clearSelection];
	NSObject* itemToSelect = [self.dataProviderFLXS objectAtIndex:val];
	if(itemToSelect)
		[self addSelectedItem:itemToSelect];
}

-(NSObject*)selectedItem
{
	return self.columnLevel.selectedItem;
}

-(void)setSelectedItem:(NSObject*)val
{
	[self clearSelection];
	[self addSelectedItem:val];
}

-(void)addSelectedItem:(NSObject*)val
{
	[self.columnLevel addSelectedItem:val];
}


-(int)columnCount
{
	return (int)self.visibleColumns.count;
}
-(NSString*)columnNames
{
	return [[FLXSUIUtils extractPropertyValues:self.visibleColumns propertyToExtract:(@"headerText")] componentsJoinedByString:@"|"];
}

-(BOOL)hasGroupedColumns
{
	return self.columnLevel.hasGroupedColumns;
}

-(void)filterPageSortMode:(NSString*)val
{
	self.columnLevel.filterPageSortMode=val;
}

- (void)expandChildrenOf:(NSObject *)item open:(BOOL)open level:(FLXSFlexDataGridColumnLevel *)level {
	if(!level)level=self.columnLevel;
	[self addRemoveFromOpenItems:item open:open level:level];
	[self rebuildBody:NO];
	[[self layer] display];
	self.currentCell = [self.bodyContainer getCellForRowColumn:item column:nil includeExp:YES ];
	if(self.currentCell)
		[self highlightRow:self.currentCell row:self.currentCell.rowInfo highLight:YES highLightColor:0];
    
}

- (void)addRemoveFromOpenItems:(NSObject *)item open:(BOOL)open level:(FLXSFlexDataGridColumnLevel *)level {
	if(!level.nextLevel&&!level.nextLevelRenderer)return;
	NSArray* children = [self getChildren:item level:level filter:NO page:NO sort:NO ];
	if([self getLength:children]>0)
	{
		if(open && ![level isItemOpen:item])
			[self.bodyContainer addOpenItem:item rowPositionInfo:nil ];
		else if(!open && [level isItemOpen:item])
            [self.bodyContainer removeOpenItem:item rowPositionInfo:nil ];
		if(level.nextLevel)
		{
			for(NSObject* child in children)
			{
                [self addRemoveFromOpenItems:child open:open level:level.nextLevel];
			}
		}
	}
}

//-(int)virtualScrollDelay
//{
//	return self.virtualBodyContainer.virtualScrollDelay;
//}
//
//-(void)setVirtualScrollDelay:(int)value
//{
//    self.virtualBodyContainer.virtualScrollDelay = value;
//
//}

-(BOOL)hasFilterFunction
{
	return self.columnLevel.hasFilterFunction;
}

- (void)trackChange:(NSObject *)changedItem changeType:(NSString *)changeType changeLevel:(FLXSFlexDataGridColumnLevel *)changeLevel changedProperty:(NSString *)changedProperty previousValue:(id)previousValue changedValue:(id)changedValue {
	if(!self.enableTrackChanges)return;
	else if([previousValue isEqual:changedValue])
	{
		//dont do anything
		return;
	}
	for(FLXSChangeInfo* ci in self.changes)
	{
		if([ci.changedItem isEqual:changedItem] && ([ci.changeType isEqualToString: changeType]) && ([ci.changedProperty isEqualToString: changedProperty]))
		{
			if([ci.origValue isEqual:changedValue])
			{
                [((NSMutableArray *)self.changes) removeObjectAtIndex:([self.changes indexOfObject:ci])];
				//we went back to original value.
			}
			ci.changedValue= changedValue;
			[self dispatchEvent:([[FLXSEvent alloc] initWithType:(@"rowChanged")])];
            return;
			//we already have self change.
		}
	}
	FLXSFlexDataGridColumnLevel* lvl=changeLevel?changeLevel: [self getLevelForItem:changedItem flat:nil level:nil ];
    [self.changes addObject:[[FLXSChangeInfo alloc] initWithChangedItem:changedItem changeLevelNestDepth:lvl ? lvl.nestDepth : 1 changedProperty:changedProperty previousValue:previousValue changedValue:changedValue changeType:changeType]];
    [self dispatchEvent:[[FLXSEvent alloc] initWithType:[FLXSFlexDataGrid FLXS_DG_EVENT_ROW_CHANGED] andCancelable:NO andBubbles:NO]];
}


- (void)setSelectedItemsBasedOnSelectedField:(BOOL)rebuild openItems:(BOOL)openItems {
	BOOL result= [self.columnLevel setSelectedItemsBasedOnSelectedField:([self getRootFlat]) parent:nil openItems:openItems];
	if(rebuild)
	{
		[self rebuildBody :NO];
	}
	if(result)
	{
        FLXSEvent* evt = [[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent CHANGE] andGrid:self andLevel:self.columnLevel andColumn:nil andCell:nil andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ];
		[self dispatchEvent:evt];
	}
}

-(void)editedItemPosition:(FLXSPoint*)value
{
	[[self layer] display];
	int rowIndex= value.x;
	int columnIndex= value.y;
	if(rowIndex>=self.bodyContainer.itemVerticalPositions.count)
	{
		//throw [[Error alloc] initWithType:(@"Invalid Row index :"+rowIndex+@". Max row index :"+(self.bodyContainer.itemVerticalPositions.count-1))];
		return;
	}
	FLXSRowPositionInfo* rowPos=self.bodyContainer.itemVerticalPositions[rowIndex] ;
	FLXSFlexDataGridColumnLevel* level=[rowPos getLevel:self];
    NSMutableArray * cols=(NSMutableArray*)[level getVisibleColumns:nil];
	if(columnIndex>=cols.count)
	{
		//throw [[Error alloc] initWithType:(@"Invalid Column index :"+columnIndex+@". Max col index :"+(cols.count-1))];
		return;
	}
	UIView<FLXSIFlexDataGridCell>* cell= [self.bodyContainer getCellForRowColumn:rowPos.rowData column:(cols[columnIndex]) includeExp:NO ];
	if(!cell)
	{
		//throw [[Error alloc] initWithType:(@"Cell at Column index :"+columnIndex+@", RowIndex: "+rowIndex + @" not found")];
		return;
	}
	[self.bodyContainer emulateClick:cell];
}

- (void)addEventListenerOfType:(NSString *)type usingTarget:(NSObject *)target withHandler:(SEL)handler {
    [FLXSUIUtils addEventListenerOfType:type
                       withTarget:target
                       andHandler:handler
                        andSender:self];
	if([type isEqual:[FLXSFlexDataGridEvent CELL_RENDERED]])
	{
		self.dispatchCellRenderered=YES;
	}
	else if([type isEqual:[FLXSFlexDataGridEvent RENDERER_INITIALIZED]])
	{
        self.dispatchRendererInitialized=YES;
	}
	else if([type isEqual:[FLXSFlexDataGridEvent CELL_CREATED]])
	{
        self.dispatchCellCreated=YES;
	}
}

-(void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler
{
    [FLXSUIUtils removeEventListener:type
                          withTarget:target
                          andHandler:handler
                           andSender:self];
}
-(void)dispatchEvent:(FLXSEvent *)event {
    
	if(([event isKindOfClass:[FLXSExtendedFilterPageSortChangeEvent class]]))
	{
		if(self.showSpinnerOnFilterPageSort && [self.filterPageSortMode isEqual:@"server" ])
		{
			[self showSpinner:@""];
		}
	}
	if([event.type isEqual:[FLXSFlexDataGridEvent CHANGE]] && self.enableDelayChange && !self.inUpdate)
	{
		_changePending=YES;
		[self setNeedsDisplay];
	}
    
    [FLXSUIUtils dispatchEvent:event
                    withSender:self];
}
-(NSObject*)getFilterColumn:(NSString*)searchField
{
	for(FLXSFlexDataGridColumn* col in self.columns)
	{
		if([col.searchField isEqual:searchField])
			return col;
	}
    return nil;
}
NSTimer* _spinnerTimer;
NSString* _spinnerMsg;

-(void)showMessage:(NSString*)msg
{
    _spinnerMsg= msg;
	[self onSpinnerTimer:nil];
	//[self.spinner validateNow];
    self.spinner.spinner.hidden=YES;
	//[self.spinner stopSpin];
    self.spinner.label = msg;
    self.alpha=1;
}

-(FLXSSelectionInfo *)selectionInfo
{
	FLXSSelectionInfo* selectionInfo=[[FLXSSelectionInfo alloc] init];
	selectionInfo.isSelectAll= [self.selectAllState isEqualToString:[FLXSTriStateCheckBox STATE_CHECKED]];
    FLXSFlexDataGridColumnLevel* lvl=self.columnLevel;
	while(lvl)
	{
		FLXSLevelSelectionInfo* lvlSelectionInfo=[[FLXSLevelSelectionInfo alloc] init];
		lvlSelectionInfo.levelNestDepth=lvl.nestDepth;
		lvlSelectionInfo.selectedObjects= [lvl.selectedObjects mutableCopy];
		lvlSelectionInfo.excludedObjects= [lvl.unSelectedObjects mutableCopy];
		[selectionInfo.levelSelections addObject:lvlSelectionInfo];
		lvl=lvl.nextLevel;
	}
	return selectionInfo;
    return nil;
}


-(void)setRowSpanFunction:(NSString*)value
{
    _rowSpanFunction = [FLXSUIUtils checkSelectorSuffix:value :@":"];
	_hasRowSpanOrColSpan = _colSpanFunction!=nil || _rowSpanFunction!=nil;
}


-(void)setColSpanFunction:(NSString*)value
{
    _colSpanFunction = [FLXSUIUtils checkSelectorSuffix:value :@":"];
    _hasRowSpanOrColSpan = _colSpanFunction!=nil || _rowSpanFunction!=nil;
}
-(void)setCellBackgroundColorFunction:(NSString *)cellBackgroundColorFunction {
    _cellBackgroundColorFunction = [FLXSUIUtils checkSelectorSuffix:cellBackgroundColorFunction :@":"];
    
}
-(void)setCellTextColorFunction:(NSString *)cellTextColorFunction {
    _cellTextColorFunction = [FLXSUIUtils checkSelectorSuffix:cellTextColorFunction :@":"];
    
}

-(void)enableEagerDraw:(BOOL)value
{
	_enableEagerDraw = value;
	if(value)
	{
		[self rebuild];
	}
}

-(void)onGridResized:(FLXSEvent*)event
{
    [self invalidateWidth];
    [self invalidateHeight];
    if(self.noDataMessage && self.spinner && !self.spinner.hidden)
	{
		[self checkNoDataMessage:YES];
	}

}

-(void)defaultWordHandlerFunction
{
	FLXSExportOptions* eo=self.wordOptions;
    if(self.popupFactoryExportOptions)
    eo.exportOptionsRenderer=self.popupFactoryExportOptions;
    [[FLXSExtendedExportController instance] export:self exportOptions:eo];
}

-(void)defaultExcelHandlerFunction
{
    FLXSExportOptions* eo=self.excelOptions;
    if(self.popupFactoryExportOptions)
	eo.exportOptionsRenderer=self.popupFactoryExportOptions;
    [[FLXSExtendedExportController instance] export:self exportOptions:eo];

    
}

-(void)defaultPrintHandlerFunction
{
    //next version v1.2
    //FLXSPrintOptions* po=printOptions;
	//po.printOptionsViewrenderer = popupFactoryPrintOptions;
}

-(void)defaultPdfHandlerFunction
{
//    FLXSPrintOptions* po=self.pdfOptions;
//	po.asynch=YES;
    //next version v1.2
	//po.printOptionsViewrenderer = self.popupFactoryPrintOptions;
//	po.showWarningMessage=NO;
}

-(void)childrenCountField:(NSString*)value
{
	self.columnLevel.childrenCountField = value;
}


-(NSString*)childrenField
{
	return self.columnLevel.childrenField;
}


-(void)setAdditionalFilterArgumentsFunction:(NSString*)value
{
	self.columnLevel.additionalFilterArgumentsFunction = value;
}

-(NSString*)additionalFilterArgumentsFunction
{
	return self.columnLevel.additionalFilterArgumentsFunction;
}

-(void)setCellBorderFunction:(NSString *)value
{
	self.columnLevel.cellBorderFunction = value;
}

-(NSString *)cellBorderFunction
{
	return self.columnLevel.cellBorderFunction;
}


-(float)headerRowHeight
{
	return self.columnLevel.headerHeight;
}

-(void)setHeaderRowHeight:(float)val
{
	self.columnLevel.headerHeight=val;
}

-(float)headerSeparatorWidth
{
	return self.columnLevel.headerSeparatorWidth;
}

-(void)setHeaderSeparatorWidth:(float)val
{
	self.columnLevel.headerSeparatorWidth=val;
}

-(float)levelRendererHeight
{
	return self.columnLevel.levelRendererHeight;
}

-(void)setLevelRendererHeight:(float)val
{
	self.columnLevel.levelRendererHeight=val;
}

-(float)nestIndent
{
	return self.columnLevel.nestIndent;
}

-(void)setNestIndent:(float)val
{
	self.columnLevel.nestIndent=val;
}


-(FLXSClassFactory*)expandCollapseCellRenderer
{
	return self.columnLevel.expandCollapseCellRenderer;
}

-(void)setExpandCollapseCellRenderer:(FLXSClassFactory*)val
{
	self.columnLevel.expandCollapseCellRenderer=val;
}

-(FLXSClassFactory*)expandCollapseHeaderCellRenderer
{
	return self.columnLevel.expandCollapseHeaderCellRenderer;
}

-(void)setExpandCollapseHeaderCellRenderer:(FLXSClassFactory*)val
{
	self.columnLevel.expandCollapseHeaderCellRenderer=val;
}

-(FLXSClassFactory*)nestIndentPaddingCellRenderer
{
	return self.columnLevel.nestIndentPaddingCellRenderer;
}

-(void)setNestIndentPaddingCellRenderer:(FLXSClassFactory*)val
{
	self.columnLevel.nestIndentPaddingCellRenderer=val;
}

-(FLXSClassFactory*)nextLevelRenderer
{
	return self.columnLevel.nextLevelRenderer;
}

-(void)setNextLevelRenderer:(FLXSClassFactory*)val
{
	self.columnLevel.nextLevelRenderer=val;
}

-(FLXSClassFactory*)pagerCellRenderer
{
	return self.columnLevel.pagerCellRenderer;
}

-(void)setPagerCellRenderer:(FLXSClassFactory*)val
{
	self.columnLevel.pagerCellRenderer=val;
}


-(NSArray*)getColumns
{
	return self.columns;
}

-(NSObject*)getDataProvider
{
	return self.dataProviderFLXS;
}


-(FLXSClassFactory*)createPrintComponentFactory
{
	//return printComponentFactory;
    return nil;
}

-(void)enabled:(BOOL)value
{
	super.enabled=value;
	if(self.bodyContainer)
        self.bodyContainer.userInteractionEnabled=value;
	if(self.footerContainer)
        self.footerContainer.userInteractionEnabled=value;
	if(self.filterContainer)
        self.filterContainer.userInteractionEnabled=value;
	if(self.footerContainer)
        self.footerContainer.userInteractionEnabled=value;
	if(self.pagerContainer)
        self.pagerContainer.userInteractionEnabled=value;
	if(self.headerContainer)
        self.headerContainer.userInteractionEnabled=value;
	if(self.leftLockedContent)
        self.leftLockedContent.userInteractionEnabled=value;
	if(self.rightLockedContent)
        self.rightLockedContent.userInteractionEnabled=value;
	if(self.leftLockedHeader)
        self.leftLockedHeader.userInteractionEnabled=value;
	if(self.leftLockedFooter)
        self.leftLockedFooter.userInteractionEnabled=value;
	if(self.rightLockedHeader)
        self.rightLockedHeader.userInteractionEnabled=value;
	if(self.rightLockedFooter)
        self.rightLockedFooter.userInteractionEnabled=value;
}

-(BOOL)isCtrlKeyDownOrSticky:(FLXSEvent*)event
{
    //	KeyboardEvent* ke = event as KeyboardEvent;
    //	MouseEvent* me = event as MouseEvent;
    //	BOOL ctrlKey = ke?ke.ctrlKey:me?me.ctrlKey:NO;
    //	return (ctrlKey && ([self.selectionMode isEqual:[NdgBase SELECTION_MODE_MULTIPLE_ROWS]]||[self.selectionMode isEqual:[NdgBase SELECTION_MODE_MULTIPLE_CELLS]]));
    //|| self.enableStickyControlKeySelection;
    return YES;
}

-(FLXSUserSettingsController*)getUserSettingsController
{
	return [FLXSUserSettingsController instance];
}

-(void)alignColumnGroups
{
	for(FLXSFlexDataGridColumnGroup* cg in self.columnLevel.columnGroups)
	{
		[self cascadeColumnGroups:cg];
	}
	self.columnLevel.groupedColumns=self.columnLevel.groupedColumns;
}

-(void)cascadeColumnGroups:(FLXSFlexDataGridColumnGroup*)cg
{
	cg.groupedColumns=cg.groupedColumns;
	for(FLXSFlexDataGridColumnGroup* ccg in cg.columnGroups)
	{
		[self cascadeColumnGroups:ccg];
	}
}

-(int)getRowSpanBasedOnOpenItemCount:(UIView<FLXSIFlexDataGridCell>*)cell
{
	return [self getOpenItemCount:cell];
}

-(int)getOpenItemCount:(UIView<FLXSIFlexDataGridCell>*)cell
{
	if( cell.rowInfo.isDataRow //its the data row, not the header or the footer row
       && !cell.rowInfo.isFillRow//since the filler is also considered a data row
       && cell.columnFLXS
       && (cell.columnFLXS.colIndex==cell.level.nestDepth-1)
       && cell.columnFLXS.isLeftLocked
       && [cell.level isItemOpen:cell.rowInfo.data]//item is open
       )
	{
		NSArray* children= [self getChildren:cell.rowInfo.data level:cell.level filter:NO page:NO sort:NO ];
		int childrenCount=[self getLength:children]+1;
		if(cell.level.nextLevel)
		{
			childrenCount+= [self getRecursiveOpenItemCount:children nextLevel:cell.level.nextLevel];
		}
		return childrenCount;
	}
	else
	{
		return 1;
	}
}

- (int)getRecursiveOpenItemCount:(NSArray *)children nextLevel:(FLXSFlexDataGridColumnLevel *)nextLevel {
	int count=0;
	for(NSObject* item in children)
	{
		if([nextLevel isItemOpen:item])
		{
			NSArray* nextLevelChildren = [self getChildren:item level:nextLevel filter:NO page:NO sort:NO ];
			count+= [self getLength:nextLevelChildren];
			if(nextLevel.nextLevel)
			{
				count+= [self getRecursiveOpenItemCount:nextLevelChildren nextLevel:nextLevel.nextLevel];
			}
		}
	}
	return count;
}

-(BOOL)useElements
{
	return NO;
}
-(void)showSpinner:(NSString*)msg
{

    if(_spinnerTimer==nil){
        _spinnerTimer = [NSTimer scheduledTimerWithTimeInterval:1/100 target:self selector:@selector(onSpinnerTimer:)
                                                      userInfo:nil repeats:NO];
        _spinnerMsg=msg;
    }

}
-(void)onSpinnerTimer:(id)timer{
    [self.spinnerBehavior showSpinner:_spinnerMsg];
    [_spinnerTimer invalidate];
    _spinnerTimer=nil;
    _spinnerMsg = nil;
}
-(void)hideSpinner
{
    if(_spinnerTimer){
        [_spinnerTimer invalidate];
        _spinnerTimer=nil;
        _spinnerMsg = nil;
    }
	[self.spinnerBehavior hideSpinner];
}

-(UIView*)spinnerParent
{
	return self;
}

-(NSArray*)elementsToBlur
{
	return [[NSArray alloc] initWithObjects:self.leftLockedContent,self.rightLockedContent, self.bodyContainer,nil ];
}

-(UIView*)elementToCenter
{
	return self;
}
-(void)validateNow
{
    [self.layer display];
}

-(void)invalidateFiller
{
	if(!self.enableFillerRows)return;
	_fillerInvalidated=YES;
	[self doInvalidate];
}

-(void)drawFiller
{
	NSArray* aic=[self getStyle:(@"alternatingItemColors")];
	[self.bodyContainer setBackgroundFillerSize];
	[self.leftLockedContent setBackgroundFillerSize];
	[self.rightLockedContent setBackgroundFillerSize];
    
    
    for(UIView* section in [[NSArray alloc] initWithObjects:self.leftLockedContent,self.rightLockedContent,self.bodyContainer,nil])
	{
		NSArray* cols=(section==self.leftLockedContent)?self.columnLevel.leftLockedColumns:(section==self.rightLockedContent)?self.columnLevel.rightLockedColumns:self.columnLevel.unLockedColumns;
		FLXSGridBackground* sectionToDraw  = [section valueForKey:@"backgroundForFillerRows"];
 		//[sectionToDraw.graphics clear];
		float pointer=0;
		NSUInteger index= [self.bodyContainer.itemVerticalPositions count];
		;
		float rowHt=self.columnLevel.rowHeight;
		NSMutableDictionary* colColors=[[NSMutableDictionary alloc]init];
		NSMutableDictionary* colisLastLocked=[[NSMutableDictionary alloc]init];
		NSMutableDictionary* colisInView=[[NSMutableDictionary alloc]init];
		float sectionHorizontalScrollPosition=0;//
		//if(cols.count==0)continue;
		while(pointer<(sectionToDraw.frame.size.height))
		{
			BOOL done=NO;
			if((pointer+rowHt)>sectionToDraw.frame.size.height)
			{
				rowHt = sectionToDraw.frame.size.height-pointer;
				done=YES;
			}
			float currx=0;
			BOOL odd=(index%2==0);
			if(self.enableDefaultDisclosureIcon && (self.columnLevel.nextLevel||self.columnLevel.nextLevelRenderer)
               && ((section==self.leftLockedContent&&self.lockDisclosureCell)||(section==self.bodyContainer&&
                                                                                !self.lockDisclosureCell) ))
			{
				currx= [self drawFillerCell:sectionToDraw color:(aic[odd ? 0 : 1]) pointer:pointer currx:currx colWidth:(([cols count] == 0 ? sectionToDraw.frame.size.width : self.columnLevel.deepNestIndent)) verticalGridLines:self.verticalGridLines verticalGridLineThickness:self.verticalGridLineThickness verticalGridLineColor:self.verticalGridLineColor horizontalGridLines:self.horizontalGridLines horizontalGridLineThickness:self.horizontalGridLineThickness horizontalGridLineColor:self.horizontalGridLineColor rowHt:rowHt draw:YES colIsInView:YES sectionHorizontalScrollPosition:0];
			}
			for(FLXSFlexDataGridColumn* col in cols)
			{
				//BOOL isColInView=colisInView[col.uniqueIdentifier]!= nil ?colisInView[col.uniqueIdentifier]:
                BOOL isColInView= [colisInView  objectForKey:col.uniqueIdentifier]!=nil ? [[colisInView  objectForKey:col.uniqueIdentifier] boolValue]:
                ([self.bodyContainer isInVisibleHorizontalRange:currx width:col.width] || col.isLocked);
                [colisInView setObject:[NSNumber numberWithBool:isColInView] forKey:col.uniqueIdentifier];
                BOOL lastIsLocked= [colisLastLocked valueForKey:col.uniqueIdentifier]!=nil?[[colisLastLocked valueForKey:col.uniqueIdentifier] boolValue]:
                (((section==self.leftLockedContent)&&col.isLastLeftLocked)
                 || ((section==self.rightLockedContent)&&col.isLastRightLocked)
                 || ((section==self.bodyContainer)&&col.isLastUnLocked)
                 );
				[colisLastLocked setObject:[NSNumber numberWithBool:lastIsLocked] forKey:col.uniqueIdentifier];
                UIColor * color =  aic[odd?0:1];
				if([colColors objectForKey:col.uniqueIdentifier]==nil)
				{
					UIColor* cb=(UIColor*)[col getStyle:(@"backgroundColor")];
					if(cb!=nil)
					{
						colColors[col.uniqueIdentifier]=cb;
                        [colColors setObject:cb forKey:col.uniqueIdentifier];
                    }
                    
				}
				if([colColors objectForKey:col.uniqueIdentifier]!=nil)
				{
					color=[colColors objectForKey:col.uniqueIdentifier];
				}
                
                
                currx = [self drawFillerCell:sectionToDraw color:color pointer:pointer currx:currx colWidth:col.width verticalGridLines:(self.verticalGridLines && !lastIsLocked) verticalGridLineThickness:self.verticalGridLineThickness verticalGridLineColor:self.verticalGridLineColor horizontalGridLines:self.horizontalGridLines horizontalGridLineThickness:self.horizontalGridLineThickness horizontalGridLineColor:self.horizontalGridLineColor rowHt:rowHt draw:NO colIsInView:isColInView sectionHorizontalScrollPosition:sectionHorizontalScrollPosition];
			}
			if(self.horizontalGridLines && !done)
			{
                //				[sectionToDraw.graphics lineStyle:horizontalGridLineThickness :horizontalGridLineColor]
                //[sectionToDraw.graphics moveTo:0 :(pointer+rowHt-1)];
                //				[sectionToDraw.graphics lineTo:sectionToDraw.width :(pointer+rowHt-1)];
                //				[sectionToDraw.graphics lineStyle];
                [sectionToDraw addLineWithX1:0 andY1:pointer+rowHt-1 andX2:sectionToDraw.width andY2:pointer+rowHt-1 andColor:self.horizontalGridLineColor andThickness:self.horizontalGridLineThickness];
                
			}
			pointer += rowHt;
			index++;
			if(done)
			{
				break;
			}
		}
	}
}

- (float)drawFillerCell:(FLXSGridBackground *)section color:(UIColor *)color pointer:(float)pointer currx:(float)currx colWidth:(float)colWidth verticalGridLines:(BOOL)verticalGridLines verticalGridLineThickness:(int)verticalGridLineThickness verticalGridLineColor:(UIColor *)verticalGridLineColor horizontalGridLines:(BOOL)horizontalGridLines horizontalGridLineThickness:(int)horizontalGridLineThickness horizontalGridLineColor:(UIColor *)horizontalGridLineColor rowHt:(float)rowHt draw:(BOOL)draw colIsInView:(BOOL)colIsInView sectionHorizontalScrollPosition:(float)sectionHorizontalScrollPosition {
    //leave this
    //next version
    //	// if(colIsInView)
    //	{
    //		//float xCord=[Math ceil:(currx+colWidth-verticalGridLineThickness- sectionHorizontalScrollPosition)];
    //		//[section.graphics moveTo:currx :pointer];
    //		//[section.graphics beginFill:color :1];
    //		//[section.graphics drawRect:(currx- sectionHorizontalScrollPosition) :pointer :colWidth :rowHt];
    //		//[section.graphics endFill];
    //		//if(verticalGridLines)
    //		{
    //			//[section.graphics lineStyle:verticalGridLineThickness :verticalGridLineColor]
    //			//[section.graphics moveTo:xCord :pointer];
    //			//[section.graphics lineTo:xCord :(pointer+rowHt)];
    //			//[section.graphics lineStyle];
    //			//
    //		}
    //		//
    //	}
    //	//currx+=colWidth;
    //	//return currx;
    
    
    //	[section.graphics moveTo:currx :pointer];
    //	[section.graphics beginFill:color :1];
    //	[section.graphics drawRect:currx :pointer :colWidth :rowHt];
    //	[section.graphics endFill];
    
    [section addRectWithX:currx andY:pointer andWidth:colWidth andHeight:rowHt andColor:color andThickness:1];
    if(verticalGridLines)
	{
        //		[section.graphics lineStyle:verticalGridLineThickness :verticalGridLineColor]
        //        [section.graphics moveTo:(currx+colWidth-verticalGridLineThickness) :pointer];
        //		[section.graphics lineTo:(currx+colWidth-verticalGridLineThickness) :(pointer+rowHt)];
        //		[section.graphics lineStyle];
        //
        [section addLineWithX1:currx+colWidth-verticalGridLineThickness andY1:pointer andX2:currx+colWidth-verticalGridLineThickness
                         andY2:pointer+rowHt andColor:verticalGridLineColor andThickness:verticalGridLineThickness];
    }
	currx+=colWidth;
	return currx;
}

-(BOOL)isRowSelectionMode
{
    return [self.selectionMode isEqualToString:[FLXSFlexDataGrid SELECTION_MODE_SINGLE_ROW]]
    || [self.selectionMode isEqualToString:[FLXSFlexDataGrid SELECTION_MODE_MULTIPLE_ROWS]];
}

-(BOOL)isCellSelectionMode
{
    return [self.selectionMode isEqualToString: [FLXSFlexDataGrid SELECTION_MODE_SINGLE_CELL]] ||
    [self.selectionMode isEqualToString:[FLXSFlexDataGrid SELECTION_MODE_MULTIPLE_CELLS]];
    
}

-(BOOL)isCellEditable:(UIView<FLXSIFlexDataGridCell>*)fdgCell
{
    
    return (([fdgCell conformsToProtocol:@protocol(FLXSIFlexDataGridCell)])
            &&(fdgCell.columnFLXS &&fdgCell.columnFLXS.editable)) && ((self.cellEditableFunction==nil)
        ||([ ((NSNumber*(*)(id, SEL, UIView<FLXSIFlexDataGridCell>*))objc_msgSend)(self.delegate, NSSelectorFromString(self.cellEditableFunction),
                                                                               fdgCell) boolValue]));
    
    
}

-(void)destroyItemEditor
{
//	if(self.bodyContainer.inEdit)
//	{
//		[self.bodyContainer endEdit:([self.bodyContainer getCurrentEditor]) event:nil ];
//	}
}

-(void)buildFromXML :(NSData*) xmlData{
    //NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"MyFile" ofType:@"xml"];
    //NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
    parserQueue = [[NSMutableArray alloc]init];
    parserLevel=nil;
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:YES];
    [parser parse];
    [self.columnLevel initializeLevel:self];
    
    
    FLXSFlexDataGridEvent* evt1 = [[FLXSFlexDataGridEvent alloc] init];
    evt1.target = self;
    evt1.type = [FLXSFlexDataGridEvent CREATION_COMPLETE];
    [self dispatchEvent:evt1];

    [self onCreationComplete:nil];
    
}

-(void)onCreationComplete:(FLXSEvent*)event
{

    if(self.enablePreferencePersistence && !self.preferencesLoaded && self.autoLoadPreferences)
    {
        self.preferencesLoaded=YES;
        [self loadPreferences];
    }
    if((self.showSpinnerOnFilterPageSort || self.showSpinnerOnCreationComplete) && !_dataProviderSet)
    {
        if(self.enableEagerDraw)
        {
            [[self layer] display];
        }
        [self showSpinner:self.spinnerLabel];
    }
    if(self.enableHeightAutoAdjust)
    {
        [self.bodyContainer ensureAutoAdjustHeight];
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if([elementName isEqualToString:@"grid"]
       ||[elementName isEqualToString:@"level"]
       ||[elementName isEqualToString:@"columnGroup"]
       ){
        NSArray *currentElement = (NSArray *)[parserQueue pop];
        
        NSObject * currentColOwner = [currentElement objectAtIndex:0];
        NSMutableArray *currentColList = (NSMutableArray *) [currentElement objectAtIndex:1];
        BOOL currentColListHasGroups = NO;
        for(NSObject *col in currentColList){
            if([col isKindOfClass:[FLXSFlexDataGridColumnGroup class]]){
                currentColListHasGroups=YES;
            }
        }
        
        
        if(currentColList.count>0){
            if([currentColOwner isEqual:self]){
                if(currentColListHasGroups)
                    self.groupedColumns = currentColList;
                else
                    self.columns = currentColList;
            }else if([currentColOwner isKindOfClass:[FLXSFlexDataGridColumnLevel class]]){
                FLXSFlexDataGridColumnLevel * currentLevel = ((FLXSFlexDataGridColumnLevel *) currentColOwner);
                if(currentColListHasGroups)
                    currentLevel.groupedColumns= currentColList;
                else
                    currentLevel.columns= [currentColList mutableCopy];
            }else if([currentColOwner isKindOfClass:[FLXSFlexDataGridColumnGroup class]]){
                FLXSFlexDataGridColumnGroup * currentGroup = ((FLXSFlexDataGridColumnGroup *) currentColOwner);
                if(currentColListHasGroups)
                    currentGroup.groupedColumns= [currentColList mutableCopy];
                else
                    currentGroup.columns= [currentColList mutableCopy];
            }
        }
    }
    
    
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    
    if([elementName isEqualToString:@"grid"]){
        for (NSString* key in attributeDict){
            [self applyProperty:attributeDict key:key target:self props:[FLXSFlexDataGrid flxsFlexDataGridProps] ];
        }
        [parserQueue push:[[NSArray alloc] initWithObjects:self,[[NSMutableArray alloc] init],nil]];
        
    }
    else if([elementName isEqualToString:@"columnGroup"]){
        FLXSFlexDataGridColumnGroup * col= [[FLXSFlexDataGridColumnGroup alloc] init];
        for (NSString* key in attributeDict){
            [self applyProperty:attributeDict key:key target:col props:[FLXSFlexDataGrid flxsFlexDataGridColumnGroupProps] ];
        }
        NSArray *currentElement = (NSArray *)[parserQueue objectAtIndex:0];
//        NSObject * currentColOwner = [currentElement objectAtIndex:0];
        NSMutableArray *currentColList = (NSMutableArray *) [currentElement objectAtIndex:1];
        [currentColList addObject:col];
        [parserQueue push:[[NSArray alloc] initWithObjects:col,[[NSMutableArray alloc] init],nil]];
        
        
    }else if([elementName isEqualToString:@"column"]){
        FLXSFlexDataGridColumn * col= [[FLXSFlexDataGridColumn alloc] init];
        if([[[attributeDict objectForKey:@"type"] lowercaseString] isEqual:@"checkbox"]){
            col = [[FLXSFlexDataGridCheckBoxColumn alloc]init];
        }
        for (NSString* key in attributeDict){
            [self applyProperty:attributeDict key:key target:col props:[FLXSFlexDataGrid flxsFlexDataGridColumnProps] ];
        }
        NSArray *currentElement = (NSArray *)[parserQueue objectAtIndex:0];
//        NSObject * currentColOwner = [currentElement objectAtIndex:0];
        NSMutableArray *currentColList = (NSMutableArray *) [currentElement objectAtIndex:1];
        [currentColList addObject:col];
    }
    else if([elementName isEqualToString:@"level"]){
        
        FLXSFlexDataGridColumnLevel * lvl = [[FLXSFlexDataGridColumnLevel alloc] init];
        lvl.grid=self;
        for (NSString* key in attributeDict){
            [self applyProperty:attributeDict key:key target:lvl props:[FLXSFlexDataGrid flxsFlexDataGridColumnLevelProps] ];
        }
        if(parserLevel==nil){
            self.columnLevel=lvl;
        }else{
            parserLevel.nextLevel=lvl;
        }
        parserLevel=lvl;
        [parserQueue push:[[NSArray alloc] initWithObjects:lvl,[[NSMutableArray alloc] init],nil]];
        
    }
}
- (void)applyProperty:(NSDictionary *)attributeDict key:(NSString *)key target:(NSObject *)target props:(NSDictionary *)props {
    //if([target respondsToSelector:NSSelectorFromString(key)])
    {
        NSArray *allEvents = [FLXSFlexDataGrid allEvents];
        NSString* value = [attributeDict objectForKey:key];
        NSObject * targetValue = value;
        if([value hasPrefix:@"performSelectorOnGridDelegate__"]){
            value = [value substringFromIndex:@"performSelectorOnGridDelegate__".length];
            SEL selector = NSSelectorFromString(value);
            targetValue= ((NSObject*(*)(id, SEL))objc_msgSend)(self.delegate, selector);
        }
        
        if([[value lowercaseString] isEqual:@"true"] || [[value lowercaseString] isEqual:@"yes"]){
            targetValue = [[NSNumber alloc] initWithBool:YES];
        }else if([[value lowercaseString] isEqual:@"false"] || [[value lowercaseString] isEqual:@"no"]){
            targetValue = [[NSNumber alloc] initWithBool:NO];
        }else if([((FLXSLabelData *) [props objectForKey:key]).data isEqualToString:@"Tf"]){
            //this is a number
            targetValue = [NSNumber numberWithFloat:[value floatValue]];
        }else if([((FLXSLabelData *) [props objectForKey:key]).data isEqualToString:@"Ti"]){
            //this is a number
            targetValue = [NSNumber numberWithFloat:[value floatValue]];
        }else if([key hasSuffix:@"Renderer"] || [key isEqual:@"itemEditor"]){
            if(![targetValue isKindOfClass:[FLXSClassFactory class]])
                targetValue = [[FLXSClassFactory alloc] initWithClass:NSClassFromString(value) andProperties:nil];
        }else if([key hasSuffix:@"DateRangeOptions"]){
            NSMutableArray * arr = [[NSMutableArray alloc] init];
            for (NSString* dateRangeStr in [value componentsSeparatedByString:@","]){
                [arr addObject:[[FLXSDateRange class] valueForKey:dateRangeStr]];
            }
            targetValue =arr;
        }else if([key hasSuffix:@"Align"]){
            if([value isEqualToString:@"left"]){
                targetValue = [NSNumber numberWithInt:NSTextAlignmentLeft];
            }else if([value isEqualToString:@"right"]){
                targetValue = [NSNumber numberWithInt:NSTextAlignmentRight];
            }else if([value isEqualToString:@"center"]){
                targetValue = [NSNumber numberWithInt:NSTextAlignmentCenter];
            }
        }else if([key hasSuffix:@"Formatter"]){
            SEL selector = NSSelectorFromString(value);
            targetValue= ((NSObject*(*)(id, SEL))objc_msgSend)(self.delegate, selector);
        }else if([key hasSuffix:@"Colors"]){
            NSString * colorString = [[value stringByReplacingOccurrencesOfString:@"[" withString:@""] stringByReplacingOccurrencesOfString:@"]" withString:@""];
            NSArray* colorStringArray = [colorString componentsSeparatedByString:@","];
            NSMutableArray *colorArray = [[NSMutableArray alloc] init];
            for (NSString* strColor in colorStringArray){
                unsigned result = 0;
                NSScanner *scanner = [NSScanner scannerWithString:strColor];
                [scanner scanHexInt:&result];
                [colorArray addObject:[[FLXSStyleManager instance] getUIColorObjectFromHexString:result]];
            }
            targetValue=colorArray;
        }else if([key hasSuffix:@"Color"]){
            NSString * colorString = [[value stringByReplacingOccurrencesOfString:@"[" withString:@""] stringByReplacingOccurrencesOfString:@"]" withString:@""];
                unsigned result = 0;
                NSScanner *scanner = [NSScanner scannerWithString:colorString];
                [scanner scanHexInt:&result];
            targetValue=[[FLXSStyleManager instance] getUIColorObjectFromHexString:result];
        }else if([allEvents containsObject:key]){
            //this is an event
            if([target conformsToProtocol:@protocol(FLXSIEventDispatcher)]){
                NSObject <FLXSIEventDispatcher> * evd = (NSObject <FLXSIEventDispatcher>*) target;
                if(![value hasSuffix:@":"]){
                    value = [value stringByReplacingOccurrencesOfString:@":" withString:@""];
                    value = [value stringByAppendingString:@":"];
                }
                [evd addEventListenerOfType:key usingTarget:self.delegate withHandler:NSSelectorFromString(value)];
            }
        }
        if([target respondsToSelector:NSSelectorFromString(key)])
            [target setValue:targetValue forKey:key];
        else if([target respondsToSelector:NSSelectorFromString([key stringByAppendingString:@"FLXS"])])
            [target setValue:targetValue forKey:[key stringByAppendingString:@"FLXS"]];
    }
}
-(void)setEnableDoubleClickEdit:(BOOL)enableDoubleClickEdit {
    _enableDoubleClickEdit=enableDoubleClickEdit;

}
-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver: self];
}
+ (NSString*)MOVE_TOP
{
	return @"moveTop";
}
+ (NSString*)MOVE_UP
{
	return @"moveUp";
}
+ (NSString*)MOVE_DOWN
{
	return @"moveDown";
}
+ (NSString*)MOVE_BOTTOM
{
	return @"moveBottom";
}
+ (NSString*)CELL_POSITION_ABOVE
{
	return @"above";
}
+ (NSString*)CELL_POSITION_BELOW
{
	return @"below";
}
+ (NSString*)CELL_POSITION_BELOW_FIRST
{
	return  @"belowFirst";
}
+ (NSString*)CELL_POSITION_ABOVE_LAST
{
	return @"aboveFirst";
}
+ (NSString*)CELL_POSITION_LEFT
{
	return @"left";
}
+ (NSString*)CELL_POSITION_RIGHT
{
	return  @"right";
}

+ (NSString*)WIDTH_DISTRIBUTION_EQUAL
{
    return @"Equal";
}
+ (NSString*)WIDTH_DISTRIBUTION_LAST_COLUMN
{
    return @"LastColumn";
}
+ (NSString*)WIDTH_DISTRIBUTION_NONE
{
    return @"None";
}
+ (NSString*)SELECTION_MODE_SINGLE_ROW
{
    return @"singleRow";
}
+ (NSString*)SELECTION_MODE_MULTIPLE_ROWS
{
    return @"multipleRows";
}
+ (NSString*)SELECTION_MODE_SINGLE_CELL
{
    return @"singleCell";
}
+ (NSString*)SELECTION_MODE_MULTIPLE_CELLS
{
    return @"multipleCells";
}
+ (NSString*)SELECTION_MODE_NONE
{
    return  @"none";
}

+ (NSDictionary*) flxsFlexDataGridProps{
    if(!flxsFlexDataGridProps){
        flxsFlexDataGridProps = [FLXSUIUtils getClassInfoDictionary:[FLXSFlexDataGrid class]];
        
    }
    return flxsFlexDataGridProps;
}
+ (NSDictionary*) flxsFlexDataGridColumnLevelProps{
    if(!flxsFlexDataGridColumnLevelProps){
        flxsFlexDataGridColumnLevelProps = [FLXSUIUtils getClassInfoDictionary:[FLXSFlexDataGridColumnLevel class]];
        
    }
    return flxsFlexDataGridColumnLevelProps;
}
+ (NSDictionary*) flxsFlexDataGridColumnProps{
    if(!flxsFlexDataGridColumnProps){
        flxsFlexDataGridColumnProps = [FLXSUIUtils getClassInfoDictionary:[FLXSFlexDataGridColumn class]];
        
    }
    return flxsFlexDataGridColumnProps;
}
+ (NSDictionary*) flxsFlexDataGridColumnGroupProps{
    if(!flxsFlexDataGridColumnGroupProps){
        flxsFlexDataGridColumnGroupProps = [FLXSUIUtils getClassInfoDictionary:[FLXSFlexDataGridColumnGroup class]];
        
    }
    return flxsFlexDataGridColumnGroupProps;
}
+ (NSArray*) allEvents{
    if(!allEvents){
        allEvents = [[NSMutableArray alloc] initWithObjects:
                     [FLXSFlexDataGrid FLXS_DG_EVENT_AFTER_EXPORT],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_AUTO_REFRESH],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_BEFORE_EXPORT],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_BEFORE_PRINT],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_BEFORE_PRINT_PROVIDERSET],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_CELL_RENDERED],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_CHANGE],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_CLEAR_PREFERENCES],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_COLUMNS_RESIZED],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_COLUMNS_SHIFT],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_COMPONENTS_CREATED],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_DATAPROVIDER_CHANGE],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_DYNAMIC_ALL_LEVELS_CREATED],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_DYNAMIC_LEVEL_CREATED],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_FILTERPAGE_SORTCHANGE],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_HEADER_CLICKED],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_ICON_CLICK],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_ICON_MOUSEOUT],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_ICON_MOUSEOVER],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_ITEM_CLICK],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_ITEM_CLOSE],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_ITEM_CLOSING],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_ITEM_DOUBLE_CLICK],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_ITEM_EDIT_BEGIN],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_ITEM_EDIT_BEGINNING],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_ITEM_EDIT_CANCEL],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_ITEM_EDIT_END],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_ITEM_EDIT_VALUE_COMMIT],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_ITEM_FOCUS_IN],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_ITEM_LOAD],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_ITEM_OPEN],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_ITEM_OPENING],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_ITEM_ROLLOUT],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_ITEM_ROLLOVER],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_LOADPREFERENCES],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_PAGESIZE_CHANGED],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_PDF_BYTES_READY],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_PERSIST_PREFERENCES],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_PREBUILT_FILTER_RUN],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_PREFERENCES_LOADING],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_PRINT_COMPLETE],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_PRINT_EXPORT_DATA_REQUEST],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_RENDERER_INITIALIZED],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_ROW_CHANGED],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_SCROLL],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_SELECT_ALL_CHECKBOX_CHANGED],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_TOOLBAR_ACTION_EXECUTED],
                     [FLXSFlexDataGrid FLXS_DG_EVENT_VIRTUAL_SCROLL],
                     nil
                     ];
        
        allEvents = [[NSMutableArray alloc] initWithObjects:
                     [FLXSFlexDataGridEvent CREATION_COMPLETE],
                     [FLXSFlexDataGridEvent CHANGE],
                     [FLXSFlexDataGridEvent AUTO_REFRESH],
                     [FLXSFlexDataGridEvent DATA_PROVIDER_CHANGE],
                     [FLXSFlexDataGridEvent COLUMNS_RESIZED],
                     [FLXSFlexDataGridEvent COLUMNS_SHIFT],
                     [FLXSFlexDataGridEvent COMPONENTS_CREATED],
                     [FLXSFlexDataGridEvent COLUMN_RESIZED],
                     [FLXSFlexDataGridEvent COLUMN_X_CHANGED],
                     [FLXSFlexDataGridEvent HEADER_CLICKED],
                     [FLXSFlexDataGridEvent SELECT_ALL_CHECKBOX_CHANGED],
                     [FLXSFlexDataGridEvent ITEM_OPEN],
                     [FLXSFlexDataGridEvent ITEM_OPENING],
                     [FLXSFlexDataGridEvent ITEM_CLOSE],
                     [FLXSFlexDataGridEvent ITEM_CLOSING],
                     [FLXSFlexDataGridEvent ITEM_EDIT_CANCEL],
                     [FLXSFlexDataGridEvent ITEM_EDIT_VALUE_COMMIT],
                     [FLXSFlexDataGridEvent ITEM_EDIT_END],
                     [FLXSFlexDataGridEvent ITEM_EDIT_BEGINNING],
                     [FLXSFlexDataGridEvent ITEM_EDIT_BEGIN],
                     [FLXSFlexDataGridEvent ITEM_EDITOR_CREATED],
                     [FLXSFlexDataGridEvent ITEM_FOCUS_IN],
                     [FLXSFlexDataGridEvent ITEM_ROLL_OVER],
                     [FLXSFlexDataGridEvent ITEM_ROLL_OUT],
                     [FLXSFlexDataGridEvent ITEM_CLICK],
                     [FLXSFlexDataGridEvent ITEM_RIGHT_CLICK],
                     [FLXSFlexDataGridEvent ITEM_DOUBLE_CLICK],
                     [FLXSFlexDataGridEvent DYNAMIC_LEVEL_CREATED],
                     [FLXSFlexDataGridEvent DYNAMIC_ALL_LEVELS_CREATED],
                     [FLXSFlexDataGridEvent ICON_MOUSE_OVER],
                     [FLXSFlexDataGridEvent ICON_CLICK],
                     [FLXSFlexDataGridEvent ICON_MOUSE_OUT],
                     [FLXSFlexDataGridEvent PREBUILT_FILTER_RUN],
                     [FLXSFlexDataGridEvent RENDERER_INITIALIZED],
                     [FLXSFlexDataGridEvent CELL_RENDERED],
                     [FLXSFlexDataGridEvent CELL_CREATED],
                     [FLXSFlexDataGridEvent PLACING_SECTIONS],
                     [FLXSExtendedFilterPageSortChangeEvent ITEM_LOAD],
                     [FLXSFlexDataGridEvent SCROLL],
                     [FLXSFlexDataGridEvent COLUMN_STRETCH],
                     
                     [FLXSFilterPageSortChangeEvent FILTER_PAGE_SORT_CHANGE],
                     
                     nil];
        
    }
    return allEvents;
}
+ (FLXSClassFactory*)static_FLXSFlexDataGridMultiSortRenderer
{
    if(!static_FLXSFlexDataGridMultiSortRenderer){
        if([FLXSUIUtils isIPad]){
            static_FLXSFlexDataGridMultiSortRenderer= [[FLXSClassFactory alloc] initWithNibName:@"FLXSMultiColumnSortViewController"
                                                                             andControllerClass:[FLXSMultiColumnSortViewController class]
                                                                                 withProperties:nil];

        }
        else{
            static_FLXSFlexDataGridMultiSortRenderer= [[FLXSClassFactory alloc] initWithNibName:@"FLXSiPhoneMultiColumnSortViewController"
                                                                             andControllerClass:[FLXSMultiColumnSortViewController class]
                                                                                 withProperties:nil];

        }
    }
    return static_FLXSFlexDataGridMultiSortRenderer;
}

+ (UITextField*)measurerText
{
    if(!measurerText){
        measurerText = [[UITextField alloc]init];
    }
    return measurerText;
}


/**
 * Dispatched when all the cells snap to the calculated column widths.
 **/
//[Event(name="componentsCreated", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+ (NSString*) FLXS_DG_EVENT_COMPONENTS_CREATED
{
    return  @"componentsCreated";
}

/**
 * Dispatched only in server mode, when the grid needs to print or export more data than is currently
 * loaded in memory.
 */
//[Event(name="printExportDataRequest", type="com.flexicious.grids.events.PrintExportDataRequestEvent")]
+ (NSString*) FLXS_DG_EVENT_PRINT_EXPORT_DATA_REQUEST
{
    return  @"printExportDataRequest";
}
/**
 * Fired In preferencePersistenceMode=server , when the grid needs to load its preferences.
 * Fired In preferencePersistenceMode=client , when the grid has successfully loaded preferences.
 */
//[Event(name="loadPreferences", type="com.flexicious.grids.events.PreferencePersistenceEvent")]
+ (NSString*) FLXS_DG_EVENT_LOADPREFERENCES
{
    return @"loadPreferences";
}
/**
 * Fired right before preferences are being loaded and applied.
 */
//[Event(name="preferencesLoading", type="com.flexicious.grids.events.PreferencePersistenceEvent")]
+ (NSString*) FLXS_DG_EVENT_PREFERENCES_LOADING
{
    return @"preferencesLoading";
}

///**
// * Fired when the grid needs to persist its preferences.
// */
//[Event(name="persistPreferences", type="com.flexicious.grids.events.PreferencePersistenceEvent")]
+ (NSString*) FLXS_DG_EVENT_PERSIST_PREFERENCES
{
    return @"persistPreferences";
}
/**
 * Fired when the grid needs to clear its preferences.
 */
//[Event(name="clearPreferences", type="com.flexicious.grids.events.PreferencePersistenceEvent")]
+(NSString*)FLXS_DG_EVENT_CLEAR_PREFERENCES{
    return @"clearPreferences";
}
/**
 * Dispatched when the use clicks on the disclosure icon to collapse a previously opened item.
 */
//[Event(name="itemClose", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_ITEM_CLOSE{
    return @"itemClose";
}
/**
 * Dispatched when the user clicks on the disclosure icon to expand a previously collapsed item.
 */
//[Event(name="itemOpen", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_ITEM_OPEN
{
    return @"itemOpen";
}
/**
 * Dispatched when an item is about to open. If you call preventDefault() on the event, the item will not open
 */
//[Event(name="itemOpening", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_ITEM_OPENING
{
    return @"itemOpening";
}
/**
 * Dispatched when an item is about to close. If you call preventDefault() on the event, the item will not close
 */
//[Event(name="itemClosing", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_ITEM_CLOSING
{
    return @"itemClosing";
}
/**
 * Dispatched only in server mode, when an item opens for the first time.
 * Used to wire up an event handler to load the next level of data in lazy loaded grids.
 *
 */
//[Event(name="itemLoad", type="com.flexicious.nestedtreedatagrid.events.ExtendedFilterPageSortChangeEvent")]
+(NSString*)FLXS_DG_EVENT_ITEM_LOAD
{
    return @"itemLoad";
}
/**
 * Dispatched when the grid's page, sort or filter state changes. Also Dispatched when
 * an item, that was not previously opened is opened. Used in lazy loaded (filterPageSortMode=server)
 * grids, to load a specific page of data from the backend.
 */
//[Event(name="filterPageSortChange", type="com.flexicious.nestedtreedatagrid.events.ExtendedFilterPageSortChangeEvent")]
+(NSString*)FLXS_DG_EVENT_FILTERPAGE_SORTCHANGE
{
    return @"filterPageSortChange";
}
/**
 * Dispatched when any header cell is clicked
 */
//[Event(name="headerClicked", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_HEADER_CLICKED
{
    return @"headerClicked";
}
/**
 * Dispatched when columns are dragged and dropped to change their position
 */
//[Event(name="columnsShift", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_COLUMNS_SHIFT
{
    return @"columnsShift";
}
/**
 * Dispatched when the columns at this level are resized
 */
//[Event(name="columnsResized", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_COLUMNS_RESIZED
{
    return @"columnsResized";
}
/**
 *  Dispatched when the user attempts to edit an item. If you call preventDefault on this event, the edit session will not begin.
 */
//[Event(name="itemEditBeginning", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridItemEditEvent")]
+(NSString*)FLXS_DG_EVENT_ITEM_EDIT_BEGINNING
{
    return @"itemEditBeginning";
}
/**
 *  Dispatched when the editor is instantiated.
 */
//[Event(name="itemEditBegin", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridItemEditEvent")]
+(NSString*)FLXS_DG_EVENT_ITEM_EDIT_BEGIN
{
    return @"itemEditBegin";
}
/**
 *  Dispatched when the edit session ends.
 */
//[Event(name="itemEditEnd", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridItemEditEvent")]
+(NSString*)FLXS_DG_EVENT_ITEM_EDIT_END
{
    return @"itemEditEnd";
}
/**
 *  Dispatched when the item editor receives focus.
 */
//[Event(name="itemFocusIn", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridItemEditEvent")]
+(NSString*)FLXS_DG_EVENT_ITEM_FOCUS_IN
{
    return @"itemFocusIn";
}
/**
 *  Dispatched when the edit session is cancelled.
 */
//[Event(name="itemEditCancel", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridItemEditEvent")]
+(NSString*)FLXS_DG_EVENT_ITEM_EDIT_CANCEL
{
    return @"itemEditCancel";
}
/**
 * Dispatched just before committing the value of the editorDataField property of the editor
 * to the property specified by the datafield property of the column of the item being edited.
 * If you call preventDefault on the event, the value will not be committed.
 */
//[Event(name="itemEditValueCommit", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridItemEditEvent")]
+(NSString*)FLXS_DG_EVENT_ITEM_EDIT_VALUE_COMMIT
{
    return @"itemEditValueCommit";
}
/**
 *  Dispatched when row selection or cell selection changes.
 */
//[Event(name="change", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_CHANGE
{
    return @"change";
}

/**
 *  Dispatched when user rolls over a row in row selection mode or cell in cell selection mode (only if rollover on a different item)
 */
//[Event(name="itemRollOver", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_ITEM_ROLLOVER
{
    return @"itemRollOver";
}

/**
 *  Dispatched when user rolls out of a row in row selection mode or cell in cell selection mode (only if rollover on a different item)
 */
//[Event(name="itemRollOut", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_ITEM_ROLLOUT
{
    return @"itemRollOut";
}

/**
 *  Dispatched when user clicks on a row in row selection mode or cell in cell selection mode
 */
//[Event(name="itemClick", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_ITEM_CLICK
{
    return @"itemClick";
}
//grid specific events..
/**
 *  Dispatched when user double clicks on a row in row selection mode or cell in cell selection mode
 */
//[Event(name="itemDoubleClick", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_ITEM_DOUBLE_CLICK{
    return @"itemDoubleClick";
}

/**
 * Dispatched when the renderer is initialized.
 *
 * Please note, any changes you made to the renderer stay in place when the renderer
 * is recycled. So if you make any changes, please ensure that the changes are
 * rolled back in the event handler first. For example, if you set the text to
 * bold if a condition is met, then you should first set it to normal, check for the
 * condition, and then set it to bold. This will ensure that if the renderer was
 * previously used to display something that match the condition, and the current item
 * does not, then we do not display bold text.
 */
//[Event(name="rendererInitialized", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_RENDERER_INITIALIZED
{
    return @"rendererInitialize";
}
/**
 * Dispatched when the cell is rendered completely. That is, the background and borders are drawn, the renderers are placed
 * Use this event to perform post processing of the cell after the grid has applied all its formatting and positioning
 */
//[Event(name="cellRendered", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_CELL_RENDERED
{
    return @"cellRendered";
}
/**
 *  When enableDynamicLevels=true, this event is dispatched whenever a new level is created.
 *  This event can be used to initialize the newly created level.
 */
//[Event(name="dynamicLevelCreated", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_DYNAMIC_LEVEL_CREATED
{
    return @"dynamicLevelCreated";
}
/**
 *  When enableDynamicLevels=true, this event is dispatched whenever all the dynamic levels are created.
 */
//[Event(name="dynamicAllLevelsCreated", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_DYNAMIC_ALL_LEVELS_CREATED
{
    return @"dynamicAllLevelsCreated";
}

/**
 *  Dispatched when the content is scrolled.
 */
//[Event(name="scroll", type="mx.events.ScrollEvent")]
+(NSString*)FLXS_DG_EVENT_SCROLL
{
    return @"scroll";
}
/**
 * Dispatched when the grid is about to be exported
 */
//[Event(name="beforeExport", type="com.flexicious.export.ExportEvent")]
+(NSString*)FLXS_DG_EVENT_BEFORE_EXPORT
{
    return @"beforeExport";
}
/**
 * Dispatched when the grid is finished exporting. At this point, the
 * textWritten variable of the dispatched event is available to you, to
 * customize the generated text if you need to.
 */
//[Event(name="afterExport", type="com.flexicious.export.ExportEvent")]
+(NSString*)FLXS_DG_EVENT_AFTER_EXPORT
{
    return @"afterExport";
}


/**
 * Dispatched when the grid is about to be generated for the print, or the preview.
 * The event has a handle to the grid that is being printed, as well as the PrintDataGrid instance.
 * This lets you perform custom logic on the PrintDataGrid before the print occurs.
 */
//[Event(name="beforePrint", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridPrintEvent")]
+(NSString*)FLXS_DG_EVENT_BEFORE_PRINT
{
    return @"beforePrint";
}
/**
 * Dispatched before the beforePrint event, right prior to the data provider being set.
 */
//[Event(name="beforePrintProviderSet", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridPrintEvent")]
+(NSString*)FLXS_DG_EVENT_BEFORE_PRINT_PROVIDERSET
{
    return @"beforePrintProviderSet";
}

/**
 * Dispatched when the grid is sent to the printer.
 */
//[Event(name="printComplete", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridPrintEvent")]
+(NSString*)FLXS_DG_EVENT_PRINT_COMPLETE
{
    return @"printComplete";
}
/**
 * Dispatched when the autorefresh interval is hit.
 */
//[Event(name="autoRefresh", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_AUTO_REFRESH
{
    return @"autoRefresh";
}
/**
 * Dispatched when any toolbarAction is executed. Wrapper events' data contains the action being executed.
 * If you call prevent default in this event, the default handling code does not execute
 **/
//[Event(name="toolbarActionExecuted", type="com.flexicious.grids.events.WrapperEvent")]
+(NSString*)FLXS_DG_EVENT_TOOLBAR_ACTION_EXECUTED
{
    return @"toolbarActionExecuted";
}

/**
 * Dispatched when the top level select checkbox is changed
 **/
//[Event(name="selectAllCheckBoxChanged", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_SELECT_ALL_CHECKBOX_CHANGED
{
    return @"selectAllCheckBoxChanged";
}

/**
 * Dispatched when the user clicks the 'Generate PDF' button on the Print Preview.
 * In response to this user action, the grid simply prints it output to a byte array of
 * page images. This byte array can then be sent to any pdf generation library either
 * on the client or the server, for example Alive PDF. We provide integration code for
 * AlivePDF out of the box.
 */
//[Event(name="pdfBytesReady", type="com.flexicious.print.PrintPreviewEvent")]
+(NSString*)FLXS_DG_EVENT_PDF_BYTES_READY
{
    return @"pdfBytesReady";
}

/**
 *  Dispatched by the grid when a prebuilt filter is run.
 */
//[Event(name="prebuiltFilterRun", type="com.flexicious.grids.events.WrapperEvent")]
+(NSString*)FLXS_DG_EVENT_PREBUILT_FILTER_RUN
{
    return @"prebuiltFilterRun";
}


/**
 *  When enablevirtualScroll=true, this event is dispatched whenever the user scrolls.
 *  @copy com.flexicious.nestedtreedatagrid.valueobjects.VirtualScrollLoadInfo
 */
//[Event(name="virtualScroll", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridVirtualScrollEvent")]
+(NSString*)FLXS_DG_EVENT_VIRTUAL_SCROLL
{
    return @"virtualScroll";
}

/**
 *  Dispatched when user clicks on an icon enabled via the enableIcon flag on a column
 */
//[Event(name="iconClick", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_ICON_CLICK
{
    return @"iconClick";
}
/**
 *  Dispatched when user mouseovers on an icon enabled via the enableIcon flag on a column
 */
//[Event(name="iconMouseOver", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_ICON_MOUSEOVER
{
    return @"iconMouseOver";
}
/**
 *  Dispatched when user mouse outs on an icon enabled via the enableIcon flag on a column
 */
//[Event(name="iconMouseOut", type="com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent")]
+(NSString*)FLXS_DG_EVENT_ICON_MOUSEOUT
{
    return @"iconMouseOut";
}

/**
 * When enableTrackChanges is set to true, this event is dispatched when any change (add,delete or update)
 * is made to the grid. Only the updates made via the grid editors are tracked.
 */
//[Event(name="rowChanged", type="flash.events.Event")]
+(NSString*)FLXS_DG_EVENT_ROW_CHANGED
{
    return @"rowChanged";
}
/**
 * Dispatched when the dataprovider dispatches a collection change event.
 */
//[Event(name="dataProviderChange", type="flash.events.Event")]
+(NSString*)FLXS_DG_EVENT_DATAPROVIDER_CHANGE
{
    return @"dataProviderChange";
}

/**
 * Dispatched whenever the page size is changed.
 */
//[Event(name="pageSizeChanged", type="flash.events.Event")]
+(NSString*)FLXS_DG_EVENT_PAGESIZE_CHANGED
{
    return @"pageSizeChanged";
}



@end

