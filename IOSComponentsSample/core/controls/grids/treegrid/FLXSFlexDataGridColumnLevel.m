#import <objc/message.h>
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSRowInfo.h"
#import "FLXSComboBox.h"
#import "FLXSFlexDataGridEvent.h"
#import "FLXSFlexDataGridExpandCollapseCell.h"
#import "FLXSFlexDataGridExpandCollapseHeaderCell.h"
#import "FLXSFlexDataGridPaddingCell.h"
#import "FLXSFlexDataGridPagerCell.h"
#import "FLXSPagerControlAS.h"
#import "FLXSFlexDataGridColumn.h"
#import "FLXSFilterSort.h"
#import "FLXSCellInfo.h"
#import "FLXSIFlexDataGridCell.h"
#import "FLXSFlexDataGridColumnGroup.h"
#import "FLXSInsertionLocationInfo.h"
#import "FLXSAdvancedFilter.h"
#import "FLXSFilterExpression.h"
#import "FLXSFlexDataGridFooterCell.h"
#import "FLXSFlexDataGridBodyContainer.h"
#import "FLXSExtendedUIUtils.h"
#import "FLXSExtendedFilterPageSortChangeEvent.h"
#import "FLXSItemLoadInfo.h"
#import "FLXSKeyValuePairCollection.h"
#import "FLXSLabelData.h"
#import "FLXSCellUtils.h"


static FLXSClassFactory* static_FLXSFlexDataGridExpandCollapseCell;
static FLXSClassFactory* static_FLXSFlexDataGridExpandCollapseHeaderCell;
static FLXSClassFactory* static_FLXSFlexDataGridPaddingCell;
static FLXSClassFactory* static_FLXSFlexDataGridPagerCell;
static FLXSClassFactory* static_FLXSFlexDataGridPager;
static FLXSClassFactory* static_FLXSFlexDataGridPagerAS;
static NSArray* static_columnProps;
static int static_IPAD_ROW_HEIGHT=50;
static int static_IPHONE_ROW_HEIGHT=36;

@implementation FLXSFlexDataGridColumnLevel {

@private
    NSString *_rowBackgroundColorFunction;
}

@synthesize reusePreviousLevelColumns = _reusePreviousLevelColumns;
@synthesize rowHeight = _rowHeight;
@synthesize headerHeight = _headerHeight;
@synthesize selectedObjects = _selectedObjects;
@synthesize selectedKeyField = _selectedKeyField;
@synthesize selectableField = _selectableField;
@synthesize disabledField = _disabledField;
@synthesize childrenCountField = _childrenCountField;
@synthesize childrenField = _childrenField;
@synthesize parentField = _parentField;
@synthesize levelName = _levelName;
@synthesize headerSeparatorWidth = _headerSeparatorWidth;
@synthesize nestIndent = _nestIndent;
@synthesize currentSorts = _currentSorts;
@synthesize nestDepth = _nestDepth;
@synthesize filterArgs = _filterArgs;
@synthesize calculatedSelectedKeys = _calculatedSelectedKeys;
@synthesize parentLevel = _parentLevel;
@synthesize columnGroups = _columnGroups;
@synthesize groupedColumns = _groupedColumns;
@synthesize hasGroupedColumns = _hasGroupedColumns;
@synthesize columns = _columns;
@synthesize columnWidthModeFitToContentSampleSize = _columnWidthModeFitToContentSampleSize;
@synthesize nextLevel = _nextLevel;
@synthesize initialSortField = _initialSortField;
@synthesize initialSortAscending = _initialSortAscending;
 @synthesize forcePagerRow = _forcePagerRow;
@synthesize pagerRenderer = _pagerRenderer;
@synthesize pageSize = _pageSize;
@synthesize pageIndex = _pageIndex;
@synthesize pagerPosition = _pagerPosition;
@synthesize enableFooters = _enableFooters;
@synthesize footerVisible = _footerVisible;
@synthesize pagerVisible = _pagerVisible;
@synthesize footerRowHeight = _footerRowHeight;
@synthesize pagerRowHeight = _pagerRowHeight;
@synthesize filterRowHeight = _filterRowHeight;
@synthesize enableFilters = _enableFilters;
@synthesize filterVisible = _filterVisible;
@synthesize headerVisible = _headerVisible;
@synthesize filterPageSortMode = _filterPageSortMode;
@synthesize itemLoadMode = _itemLoadMode;
@synthesize nextLevelRenderer = _nextLevelRenderer;
@synthesize levelRendererHeight = _levelRendererHeight;
@synthesize expandCollapseCellRenderer = _expandCollapseCellRenderer;
@synthesize expandCollapseHeaderCellRenderer = _expandCollapseHeaderCellRenderer;
@synthesize nestIndentPaddingCellRenderer = _nestIndentPaddingCellRenderer;
@synthesize nestIndentPaddingRenderer = _nestIndentPaddingRenderer;
@synthesize scrollbarPadRenderer = _scrollbarPadRenderer;
@synthesize rowDisabledFunction = _rowDisabledFunction;
@synthesize rowSelectableFunction = _rowSelectableFunction;
@synthesize rowBackgroundFunction = _rowBackgroundFunction;
@synthesize rowTextColorFunction = _rowTextColorFunction;
@synthesize cellBorderFunction = _cellBorderFunction;
@synthesize cellCustomDrawFunction = _cellCustomDrawFunction;
@synthesize pagerCellRenderer = _pagerCellRenderer;
@synthesize additionalFilterArgumentsFunction = _additionalFilterArgumentsFunction;
@synthesize displayOrder = _displayOrder;
@synthesize cachedVisibleColumns = _cachedVisibleColumns;
@synthesize lockCache = _lockCache;
@synthesize flowColumns = _flowColumns;
@synthesize flowHeaderColumns = _flowHeaderColumns;
@synthesize flowHeaderColumnGroups = _flowHeaderColumnGroups;
@synthesize wxInvalid = _wxInvalid;
@synthesize enableRowNumbers = _enableRowNumbers;
@synthesize filterFunction = _filterFunction;
@synthesize selectedField = _selectedField;
@synthesize defaultSelectionField = _defaultSelectionField;
@synthesize enableSingleSelect = _enableSingleSelect;
@synthesize unSelectedObjects = _unSelectedObjects;
@synthesize pendingStyles = _pendingStyles;
@synthesize grid = _grid;
@synthesize calculatedSumHeaderAndColumnGroupHeights = _calculatedSumHeaderAndColumnGroupHeights;
@synthesize userDefinedHeaderHeight = _userDefinedHeaderHeight;
@synthesize minHeaderHeight = _minHeaderHeight;

@synthesize rowBackgroundColorFunction = _rowBackgroundColorFunction;

-(id)init
{
	self = [super init];
	if (self)
	{
        if(!static_FLXSFlexDataGridExpandCollapseCell)
            static_FLXSFlexDataGridExpandCollapseCell= [[FLXSClassFactory alloc] initWithClass:[FLXSFlexDataGridExpandCollapseCell class] andProperties:nil];
        if(!static_FLXSFlexDataGridExpandCollapseHeaderCell)
            static_FLXSFlexDataGridExpandCollapseHeaderCell = [[FLXSClassFactory alloc] initWithClass:[FLXSFlexDataGridExpandCollapseHeaderCell class] andProperties:nil];
        if(!static_FLXSFlexDataGridPaddingCell)
            static_FLXSFlexDataGridPaddingCell = [[FLXSClassFactory alloc] initWithClass:[FLXSFlexDataGridPaddingCell class] andProperties:nil];
        if(!static_FLXSFlexDataGridPagerCell)
            static_FLXSFlexDataGridPagerCell = [[FLXSClassFactory alloc] initWithClass:[FLXSFlexDataGridPagerCell class] andProperties:nil];
        if(!static_FLXSFlexDataGridPager)
            static_FLXSFlexDataGridPager = [[FLXSClassFactory alloc] initWithClass:[FLXSPagerControlAS class] andProperties:nil];
        if(!static_FLXSFlexDataGridPagerAS)
            static_FLXSFlexDataGridPagerAS = [[FLXSClassFactory alloc] initWithClass:[FLXSPagerControlAS class] andProperties:nil];
        if(!static_columnProps)
            static_columnProps = [[NSMutableArray alloc] init];


		_reusePreviousLevelColumns = NO;
		_rowHeight = static_IPAD_ROW_HEIGHT;
		_headerHeight = static_IPAD_ROW_HEIGHT;
		_selectedObjects = [[NSMutableArray alloc] init];
		_selectedKeyField = @"";
		_selectableField = @"";
		_disabledField = @"";
		_childrenCountField = @"";
		_childrenField = @"";
		_parentField = @"";
		_levelName = @"";
		_headerSeparatorWidth = 4;
		_nestIndent = 33;
		_currentSorts = [[NSMutableArray alloc] init];
		_filterArgs = [[NSMutableArray alloc] init];
		_calculatedSelectedKeys = nil;
		_columnGroups = [[NSMutableArray alloc] init];
		_groupedColumns = [[NSMutableArray alloc] init];
		self.hasGroupedColumns = NO;
		_columns = [[NSMutableArray alloc] init];
		_columnWidthModeFitToContentSampleSize = 100;
		_initialSortAscending = YES;
		_enablePaging = NO;
		_forcePagerRow = NO;
		_pageSize = 5;
		_pageIndex = 0;
		_enableFooters = NO;
		_footerVisible = YES;
		_pagerVisible = YES;
		_footerRowHeight = static_IPAD_ROW_HEIGHT;
		_pagerRowHeight = static_IPAD_ROW_HEIGHT;
		_filterRowHeight = static_IPAD_ROW_HEIGHT;
		_enableFilters = NO;
		_filterVisible = YES;
		_headerVisible = YES;
		_filterPageSortMode = @"client";
		_itemLoadMode = @"client";
		_nextLevelRenderer = nil;
		_levelRendererHeight = 0;
        _nestIndentPaddingRenderer = nil;
		_scrollbarPadRenderer = nil;
		_displayOrder = @"pager,header,filter,body,footer";
		_cachedVisibleColumns = [[NSMutableDictionary alloc] init];
		_lockCache = [[NSMutableDictionary alloc] init];
		_flowColumns = nil;
		_flowHeaderColumns = nil;
		_flowHeaderColumnGroups = nil;
		_wxInvalid = YES;
		_defaultSelectionField = @"";
        _enableSingleSelect = NO;
		_unSelectedObjects = [[NSMutableArray alloc] init];
		_pendingStyles = [[NSMutableArray alloc] init];
		_calculatedSumHeaderAndColumnGroupHeights = 0;
		_userDefinedHeaderHeight = -1;
		_minHeaderHeight = 20;
        _pagerCellRenderer =[FLXSFlexDataGridColumnLevel static_FLXSFlexDataGridPagerCell];
        _expandCollapseCellRenderer =  [FLXSFlexDataGridColumnLevel static_FLXSFlexDataGridExpandCollapseCell];
        _expandCollapseHeaderCellRenderer = [FLXSFlexDataGridColumnLevel static_FLXSFlexDataGridExpandCollapseHeaderCell];
        _nestIndentPaddingCellRenderer = [FLXSFlexDataGridColumnLevel static_FLXSFlexDataGridPaddingCell];
        if(![FLXSUIUtils isIPad]){
            _rowHeight=static_IPHONE_ROW_HEIGHT;
            _headerHeight=static_IPHONE_ROW_HEIGHT;
            _footerRowHeight = static_IPHONE_ROW_HEIGHT;
            _filterRowHeight = static_IPHONE_ROW_HEIGHT;
            _pagerRowHeight= static_IPHONE_ROW_HEIGHT+8;
            //_nestIndent =   static_IPHONE_ROW_HEIGHT/2;
        }else{

        }

        //[_selectedObjects addEventListener:[CollectionEvent COLLECTION_CHANGE] :onSelectedKeysChange];
	}
	return self;
}

-(FLXSFlexDataGridColumnLevel*)columnOwnerLevel
{
	if(self.reusePreviousLevelColumns && self.parentLevel)return self.parentLevel.columnOwnerLevel;
	return self;
}



-(void)setRowHeight:(float)o
{
	if(_rowHeight != o )
	{
		[self invalidateList];
	}
	_rowHeight = o;
}

-(float)headerHeight
{
	return (self.headerVisible) ? _headerHeight != 0 ? (_headerHeight) : (self.rowHeight) : 0;
}

-(float)getMaxColumnGroupDepthOrHeight:(float)soFar :(NSArray*)children :(NSString*)what
{
	if(children==nil)
	{
		children=self.columnGroups;
	}
	if([what isEqualToString: @"depth"])
	{
		soFar+=1;
	}
	float thisLevel=soFar;
	for(FLXSFlexDataGridColumnGroup* colG in children)
	{
		if([what isEqualToString: @"height"])
		{
			soFar+=colG.height;
		}
		float result=[self getMaxColumnGroupDepthOrHeight:thisLevel :colG.columnGroups :what];
		if(result>soFar)
		{
			soFar=result;
		}
		if([what isEqualToString: @"height"])
		{
			soFar-=colG.height;
		}
	}
	return soFar;
}

-(float)getMaxColumnGroupDepth
{
	return [self getMaxColumnGroupDepthOrHeight:0 :nil :@"depth"];
}

-(void)setHeaderHeight:(float)o
{
	if(_headerHeight != o )
	{
		[self invalidateList];
	}
	_headerHeight = o;
}

-(NSMutableArray*)selectedCells
{
	return self.grid?self.grid.selectedCells:[[NSMutableArray alloc] init];
}




-(NSMutableArray*)selectedKeys
{
	if(_calculatedSelectedKeys)
		return _calculatedSelectedKeys;
	NSMutableArray* sKeys=[[NSMutableArray alloc] init];
	for(NSObject* item in self.selectedObjects)
	{
		[sKeys addObject:([self getItemKey:item saveLevel:NO ])];
	}
    if([_calculatedSelectedKeys count]>0){
        if([_calculatedSelectedKeys[0] isKindOfClass:[NSNumber class]]){
                [sKeys sortUsingSelector:@selector(compare:)];

        }   else{
                [sKeys sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        }
    }
    _calculatedSelectedKeys = sKeys;
	return _calculatedSelectedKeys;
}

-(void)setDisabledField:(NSString*)value
{
	_disabledField = value;

}

-(BOOL)checkRowDisabled:(UIView<FLXSIFlexDataGridCell>*)cell :(NSObject*)item
{
    return item && [[FLXSExtendedUIUtils resolveExpression:item expression:self.disabledField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO] boolValue];
}


-(NSString*)childrenField
{
	return _childrenField?_childrenField:self.grid?self.grid.childrenField:@"";
}
-(int)deepNestIndent
{
	FLXSFlexDataGridColumnLevel* lvl=self.grid.columnLevel;
	int nd=0;
	while(lvl!=nil)
	{
		nd += lvl.nestDepth==1?0:lvl.nestIndent;
		if(!lvl.nextLevel && lvl.nextLevelRenderer)
		{
			nd +=lvl.nestIndent;
		}
		lvl=lvl.nextLevel;
	}
	return nd;
}

-(float)maxDisclosureCellWidth
{
	return self.deepNestIndent-(self.maxPaddingCellWidth);
}

-(float)maxPaddingCellWidth
{
	FLXSFlexDataGridColumnLevel* lvl=self;
	int nd=0;
	while(lvl!=nil)
	{
		nd += lvl.nestDepth==1?0:lvl.nestIndent;
		lvl=lvl.parentLevel;
	}
    return nd;
}

- (NSObject *)getSortIndex:(FLXSFlexDataGridColumn *)fld return1:(BOOL)return1 returnSortObject:(BOOL)returnSortObject {
	if(_reusePreviousLevelColumns && self.parentLevel)
		return [self.parentLevel getSortIndex:fld return1:return1 returnSortObject:returnSortObject];
	int index=0;
	for(FLXSFilterSort* srt in _currentSorts)
	{
		index++;
        if([fld.sortFieldName isEqual:srt.sortColumn])
		{
			if(returnSortObject)
				return srt;
			return [[NSNumber alloc] initWithInt:index];
		}
	}
	return returnSortObject?nil:return1?[[NSNumber alloc] initWithInt:1]:[[NSNumber alloc] initWithInt:-1];
}

-(FLXSFilterSort*)hasSort:(FLXSFlexDataGridColumn*)fld
{
	if(_reusePreviousLevelColumns && _parentLevel)
		return [_parentLevel hasSort:fld];
	for(FLXSFilterSort* srt in _currentSorts)
	{
		if([fld.sortFieldName isEqual:srt.sortColumn])
		{
			return srt;
		}
	}
    return nil;
}

-(void)addSort:(FLXSFilterSort*)sort
{
	FLXSFlexDataGridColumn* col = [self getColumnByDataField:sort.sortColumn by:@"sortField"];
	FLXSFilterSort* fs = [[FLXSFilterSort alloc] init];
	if(col)
	{
		FLXSFilterSort* srt = (FLXSFilterSort*) [self getSortIndex:col return1:NO returnSortObject:YES ];
		if(srt)
		{
			fs = srt;
		}
		fs.sortNumeric = sort.sortNumeric;
		fs.sortCaseInsensitive = sort.sortCaseInsensitive;
		fs.sortColumn = sort.sortColumn;
		fs.sortCompareFunction = sort.sortCompareFunction!=nil?sort.sortCompareFunction:col.sortCompareFunction!=nil?col.sortCompareFunction:nil;
		fs.isAscending = sort.isAscending;
		if(!srt)
			[_currentSorts addObject:fs];
	}
	else
	{
		[_currentSorts addObject:sort];
	}
}

-(void)removeAllSorts
{
	[_currentSorts removeAllObjects];
	if(self.nextLevel)
		[self.nextLevel removeAllSorts];
}

- (void)setCurrentSort:(FLXSFlexDataGridColumn *)fld asc:(BOOL)asc {
	if(_reusePreviousLevelColumns && self.parentLevel)
		[self.parentLevel setCurrentSort:fld asc:asc];
	[_currentSorts removeAllObjects];
	FLXSFilterSort* fs = [[FLXSFilterSort alloc] init];
	fs.sortCaseInsensitive=fld.sortCaseInsensitive;
	fs.sortNumeric=fld.sortNumeric;
	fs.sortColumn=fld.sortFieldName;
	fs.sortCompareFunction=fld.sortCompareFunction;
	fs.isAscending = asc;
	[_currentSorts addObject:fs];
}


-(UIView*)createAscendingSortIcon
{
	return [self createSortArrow:YES];
}

-(UIView*)createDescendingSortIcon
{
	return [self createSortArrow:NO];
}

-(UIView*)createSortArrow:(BOOL)d
{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:!d?@"FLXSAPPLE_sortArrowDesc.png":@"FLXSAPPLE_sortArrow.png"]];
}

-(void)onSelectedKeysChange:(FLXSEvent*)ev
{
    //next version
//	CollectionEvent* ce = ev as CollectionEvent;
//	if(ce)
//	{
//		if(ce.kind==[CollectionEventKind ADD]||ce.kind==[CollectionEventKind REMOVE]||ce.kind==[CollectionEventKind UPDATE]
//			||ce.kind==[CollectionEventKind RESET])
//		{
//			[grid invalidateSelection];
//			_calculatedSelectedKeys=nil;
//		}
//	}
}

-(NSArray*)groupedColumns
{
	return [_groupedColumns count]==0?self.columns:_groupedColumns;
    return nil;
}

-(void)setGroupedColumns:(NSArray*)value
{
	_groupedColumns=[value mutableCopy];
	self.hasGroupedColumns=[_groupedColumns count]>=1;
	[self invalidateCache];
	NSMutableArray * cols= [[NSMutableArray alloc] init];
    NSMutableArray* colgs= [[NSMutableArray alloc] init];
	for(NSObject* val in value)
	{
		FLXSFlexDataGridColumnGroup* grp = [val isKindOfClass:[FLXSFlexDataGridColumnGroup class]]?(FLXSFlexDataGridColumnGroup*)val:nil;
		if(grp)
		{
			for(FLXSFlexDataGridColumn* col in [grp getAllColumns])
				[cols addObject:col];
			[colgs addObject:grp];
		}
		else
		{
			[cols addObject:val];
		}
	}
	self.columns=cols;
	_columnGroups=colgs;
}

-(NSArray*)columns
{
	return (self.reusePreviousLevelColumns&&self.parentLevel)?self.parentLevel.columns:_columns?[_columns mutableCopy]: [[NSArray alloc] init];
}

-(void)setColumns:(NSArray*)value
{
	_columns = [value mutableCopy];
	[self ensureRowNumberColumn];
[self invalidateCache];
	for(FLXSFlexDataGridColumn* col in _columns)
	{
		col.level=self;
		col.calculatedMeasurements =[[NSMutableDictionary alloc]init];
	}
}


-(float)filterRowHeight
{
	return (self.enableFilters && self.filterVisible) ? _filterRowHeight != 0 ? _filterRowHeight : self.rowHeight : 0;
}

-(void)setFilterRowHeight:(float)val
{
	if(_filterRowHeight!=val)
	{
		[self invalidateList];
	}
	_filterRowHeight=val;
}

-(BOOL)enableMultiColumnSort
{
	return  self.grid.enableMultiColumnSort;
}

-(void)enableFilters:(BOOL)value
{
	_enableFilters=value;
	[self invalidateList];
	[self dispatchEvent:([[FLXSEvent alloc] initWithType:(@"enableFiltersChanged")])];
}


-(void)setFilterVisible:(BOOL)val
{
	_filterVisible=val;
	[self invalidateList];
}

-(void)setHeaderVisible:(BOOL)val
{
	_headerVisible=val;
	[self invalidateList];
}

-(float)footerRowHeight
{
	return (self.enableFooters && self.footerVisible) ? _footerRowHeight != 0 ? _footerRowHeight : self.rowHeight : 0;
}

-(void)setFooterRowHeight:(float)val
{
	if(_footerRowHeight!=val)
	{
		[self invalidateList];
	}
	_footerRowHeight=val;
}

-(float)pagerRowHeight
{
	return ((self.enablePaging&&self.pagerVisible) || self.forcePagerRow) ? _pagerRowHeight != 0 ? _pagerRowHeight : self.rowHeight : 0;
    return 0;
}

-(void)setPagerRowHeight:(float)val
{
	if(_pagerRowHeight!=val)
		[self invalidateList];
	_pagerRowHeight=val;
}

-(void)setEnableFooters:(BOOL)value
{
	_enableFooters=value;
	[self invalidateList];
	[self dispatchEvent:([[FLXSEvent alloc] initWithType:(@"enableFootersChanged")])];
}


-(void)setEnablePaging:(BOOL)val
{
	_enablePaging=val;
	[self invalidateList];
	[self dispatchEvent:([[FLXSEvent alloc] initWithType:(@"enablePagingChanged")])];
}

-(void)setForcePagerRow:(BOOL)val
{
	_forcePagerRow=val;
	[self invalidateList];
}


-(void)setPagerVisible:(BOOL)val
{
	_pagerVisible=val;
	[self invalidateList];
}

-(void)setFooterVisible:(BOOL)val
{
	_footerVisible=val;
	[self invalidateList];
}

-(FLXSClassFactory*)pagerRenderer
{
	if (_pagerRenderer == nil)
	{
		_pagerRenderer= _grid&&_grid.enableDataCellOptmization? static_FLXSFlexDataGridPagerAS:static_FLXSFlexDataGridPager;
	}
	return _pagerRenderer;
}

-(void)setPageSize:(int)val
{
	_pageSize=val;
	[self dispatchEvent:([[FLXSEvent alloc] initWithType:(@"pageSizeChanged")])];
}

-(void)setRowSelectableFunction:(NSString *)rowSelectableFunction {
    _rowSelectableFunction = [FLXSUIUtils checkSelectorSuffix:rowSelectableFunction: @"::"];
}
-(void)setRowTextColorFunction:(NSString *)rowTextColorFunction {
    _rowTextColorFunction = [FLXSUIUtils checkSelectorSuffix:rowTextColorFunction :@":"];
}
-(void)setFilterFunction:(NSString *)filterFunction {
    _filterFunction = [FLXSUIUtils checkSelectorSuffix:filterFunction :@":"];
}
-(void)setAdditionalFilterArgumentsFunction:(NSString *)additionalFilterArgumentsFunction {
    _additionalFilterArgumentsFunction = [FLXSUIUtils checkSelectorSuffix:additionalFilterArgumentsFunction :@":"];
}
-(void)setRowDisabledFunction:(NSString *)rowDisabledFunction {
    _rowDisabledFunction = [FLXSUIUtils checkSelectorSuffix:rowDisabledFunction :@"::"];
}
-(void)setRowBackgroundColorFunction:(NSString *)rowBackgroundColorFunction {
    _rowBackgroundColorFunction = [FLXSUIUtils checkSelectorSuffix:rowBackgroundColorFunction :@":"];
}
-(void)setCellBorderFunction:(NSString *)cellBorderFunction {
    _cellBorderFunction = [FLXSUIUtils checkSelectorSuffix:cellBorderFunction :@":"];
}
-(void)setCellCustomDrawFunction:(NSString *)cellCustomDrawFunction {
    _cellCustomDrawFunction = [FLXSUIUtils checkSelectorSuffix:cellCustomDrawFunction :@":"];
}
-(void)setCellCustomBackgroundDrawFunction:(NSString *)cellCustomBackgroundDrawFunction {
    _cellCustomBackgroundDrawFunction = [FLXSUIUtils checkSelectorSuffix:cellCustomBackgroundDrawFunction :@":"];
}

-(BOOL)isClientFilterPageSortMode
{
	return [self.filterPageSortMode isEqualToString:@"client"];
}

-(BOOL)isClientItemLoadMode
{
	return [_itemLoadMode isEqual:@"client"];
}

- (BOOL)checkRowSelectable:(UIView <FLXSIFlexDataGridCell> *)cell object:(NSObject *)obj {
 	if(self.rowSelectableFunction!=nil)
	{
		//return [self rowSelectableFunction:cell :obj];
        SEL selector = NSSelectorFromString(self.rowSelectableFunction);
        id target = self.grid.delegate;
        return [((NSNumber*(*)(id, SEL, UIView <FLXSIFlexDataGridCell> *,NSObject *))objc_msgSend)(target, selector,cell,obj) boolValue];
	}
//	if(self.rowDisabledFunction!=nil)
//	{
//		//return ![self rowDisabledFunction:cell :obj];
//        SEL selector = NSSelectorFromString(self.rowDisabledFunction);
//        id target = self.grid.delegate;
//        return !objc_msgSend(target, selector,cell,obj);
//
//    }


    if(![FLXSUIUtils nullOrEmpty:self.disabledField]){
        return [self checkRowDisabled:cell :obj];
    }
	if(self.selectableField && [obj respondsToSelector:NSSelectorFromString(self.selectableField)])
	{
        return [obj valueForKey:self.selectableField]?YES:NO;
        //return obj[self.selectableField];
	}
	return YES;
}

-(float)calculateChromeTopHeight
{
	return self.headerHeight*[self getMaxColumnGroupDepth];
}

-(float)calculateChromeBottomHeight
{
	float result=0;
	result+=self.enableFooters?self.footerRowHeight:0;
	result+=self.enablePaging?self.pagerRowHeight:0;
	return result;
}

-(void)initializeDepth:(int)nestLevel
{
	self.nestDepth=nestLevel;
	if(self.nextLevel)
	{
		nestLevel++;
		[self.nextLevel initializeDepth:nestLevel];
	}
	if(self.nestDepth>1 && [self.displayOrder rangeOfString:(@"pager")].location==0)
	{
		self.displayOrder = @"header,filter,body,footer,pager";
	}
}

-(void)initializeParentLevel
{
	if(self.nextLevel)
	{
		self.nextLevel.parentLevel=self;
		[self.nextLevel initializeParentLevel];
	}
}

-(void)initializeGrid:(FLXSFlexDataGrid*)grid
{
	_grid=grid;
	if(self.nextLevel)
	{
		[self.nextLevel initializeGrid:grid];
	}
}

-(void)invalidateCache
{
	_cachedVisibleColumns = [[NSMutableDictionary alloc] init];
	_lockCache= [[NSMutableDictionary alloc] init];
	_flowColumns=nil;
	_flowHeaderColumnGroups=nil;
	_flowHeaderColumns=nil;
	self.userDefinedHeaderHeight=-1;
	self.calculatedSumHeaderAndColumnGroupHeights=0;
	for(FLXSFlexDataGridColumn* col in self.columns)
	{
		col.calculatedMeasurements =[[NSMutableDictionary alloc] init];
	}
}

-(void)initializeColumnLevel
{
	_wxInvalid=NO;
	[self invalidateCache];
	if(!self.reusePreviousLevelColumns || !self.parentLevel)
	{
		[self invalidateCalculationsDown];
		FLXSInsertionLocationInfo* loc = [[FLXSInsertionLocationInfo alloc] init];
		for(FLXSFlexDataGridColumn* col in [self getVisibleColumns :nil])
		{
			if(col.isLeftLocked)
			{
				col.x=loc.leftLockedContentX;
				loc.leftLockedContentX+=col.width;
			}
			else if(col.isRightLocked)
			{
				col.x=loc.rightLockedContentX;
				loc.rightLockedContentX+=col.width;
			}
			else
			{
				col.x=loc.contentX;
				loc.contentX+=col.width;
			}
			col.level=self;
		}
		for(FLXSFlexDataGridColumnGroup* colG in self.columnGroups)
		{
			colG.level=self;
			[colG initializeGroup];
            [colG initializeDepthY:1 yIn:0];
			//self also initializes the first time.
		}
	}
	if(self.nextLevel)
	{
		[self.nextLevel initializeColumnLevel];
	}
}

-(void)invalidateCalculationsDown
{
	for(FLXSFlexDataGridColumnGroup* cg in self.columnGroups)
	{
		[cg invalidateCalculationsDown];
	}
}

-(void)clearSelection:(BOOL)dispatch
{
	if([self.selectedCells count]>0)
		[self.selectedCells removeAllObjects];
	if([self.selectedObjects count]>0 || [self.unSelectedObjects count]>0)
	{
		[self.selectedObjects removeAllObjects];
		[self.unSelectedObjects removeAllObjects];
        [self.selectedKeys removeAllObjects];
	}
	else
dispatch=NO;
	if(self.nextLevel)
	{
		[self.nextLevel clearSelection:NO];
	}
	if(dispatch)
	{
		//FLXSEvent* evt= [[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent CHANGE] :self.grid :self :nil];
        FLXSEvent* evt = [[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent CHANGE] andGrid:self.grid andLevel:self andColumn:nil andCell:nil andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ];
		[self dispatchEvent:evt];
	}
}

-(void)initializeLevel:(FLXSFlexDataGrid*)grid
{
	[self initializeDepth :1];
	[self initializeGrid:grid];
	[self initializeParentLevel];
	[self initializeColumnLevel];
	[self ensureRowNumberColumn];
}

- (void)cascadeProperty:(NSString *)prp value:(id)value {
	[self setValue:value forKey:prp];//[prp]=value;
	if(self.nextLevel)
	{
		[self.nextLevel cascadeProperty:prp value:value];
	}
}

- (void)transferProps:(FLXSFlexDataGridColumnLevel *)from to:(FLXSFlexDataGridColumnLevel *)to checkForChanges:(BOOL)checkForChanges {
	FLXSFlexDataGridColumnLevel* template = [[FLXSFlexDataGridColumnLevel alloc] init];
	template.grid=from.grid;
    NSArray* props = [FLXSUIUtils getClassInfo:[from class]];
    if (props)
    {
        for (FLXSLabelData* prop in  props)
        {

            if(![prop.data isEqualToString:@"T:"]){
             if([FLXSUIUtils isPrimitive:([from valueForKey:prop.label])]
                    || [[from valueForKey:prop.label] isKindOfClass:[FLXSClassFactory class]]
                     ){
                if(![[to valueForKey:prop.label] isEqual: [from valueForKey:prop.label]]){
                    if(!checkForChanges || ![[from valueForKey:prop.label] isEqual:[template valueForKey:prop.label]]){

                        NSString * setter = [[@"set" stringByAppendingString:[FLXSCellUtils doCap:prop.label]] stringByAppendingString:@":"];

                        if([to respondsToSelector:NSSelectorFromString(setter)])
                        [to setValue:[from valueForKey:prop.label] forKey:prop.label];
                    }
                }

            }
            }
        }

    }

}


-(FLXSFlexDataGridColumnLevel*)clone:(BOOL)transferCols
{
	FLXSFlexDataGridColumnLevel* treeDataGridColumnLevel=[[FLXSFlexDataGridColumnLevel alloc] init];
	NSMutableArray* cols=[NSMutableArray new];
	[self transferProps:self to:treeDataGridColumnLevel checkForChanges:NO ];
    if(transferCols)
	{
		BOOL hasColumnGroups=NO;
		for(NSObject* col in self.groupedColumns)
		{
			if([col isKindOfClass:[FLXSFlexDataGridColumnGroup class]])
			{
				hasColumnGroups=YES;
			}
		}
        id col;
		for(col in self.groupedColumns)
		{
			[cols addObject:([self cloneColumn:col])];
		}
		if(hasColumnGroups)
			treeDataGridColumnLevel.groupedColumns=[cols mutableCopy];
		else
            treeDataGridColumnLevel.columns=[cols mutableCopy];
		//columns to print
		treeDataGridColumnLevel.currentSorts = [[NSMutableArray alloc] initWithArray:self.currentSorts];
		if(self.nextLevel)
		{
			treeDataGridColumnLevel.nextLevel=[self.nextLevel clone:transferCols];
		}
	}
	return treeDataGridColumnLevel;
}

-(NSObject*)cloneColumn:(NSObject*)col
{
	id newCol;
	if([col isKindOfClass:[FLXSClassFactory class]])
	{
		//scenario when the concrete class is a derivative of EDGC or EADGC and potentially in a different swc.
		newCol = [(FLXSClassFactory*)col generateInstance];
	}
	else if ([col isKindOfClass:[FLXSFlexDataGridColumnGroup class]])
	{
		newCol=[[FLXSFlexDataGridColumnGroup alloc] init];
	}
	else
	{
		newCol=[[FLXSFlexDataGridColumn alloc] init];
	}

    NSArray* props = [FLXSUIUtils getClassInfo:[col class]];
    if (props)
    {
        for (FLXSLabelData* prop in  props)
        {
             if([FLXSUIUtils isPrimitive:([col valueForKey:prop.label])]
                    || [[col valueForKey:prop.label] isKindOfClass:[FLXSClassFactory class]]
                    ){
                [newCol setValue:[col valueForKey:prop.label] forKey:prop.label];

            }
        }
    }
	if([col respondsToSelector:NSSelectorFromString(@"children")])
	{
		NSMutableArray* cgCols = [[NSMutableArray alloc] init];
		NSMutableArray* cgGroups = [[NSMutableArray alloc] init];
        FLXSFlexDataGridColumnGroup* grp = (FLXSFlexDataGridColumnGroup*)col;
		NSMutableArray* children= [grp.columnGroups count]>0?grp.columnGroups:grp.children;
        for(NSObject* child in children)
		{
			NSObject* newChild=[self cloneColumn:child];
			if([newChild isKindOfClass:[FLXSFlexDataGridColumnGroup class]])
			{
				[cgGroups addObject:newChild];
			}
			else
			{
				[cgCols addObject:newChild];
			}
		}
		if([cgCols count]>0)
			((FLXSFlexDataGridColumnGroup*)newCol).columns=cgCols;
		else if([cgGroups count]>0)
            ((FLXSFlexDataGridColumnGroup*)newCol).columnGroups=cgGroups;
	}
	return newCol;
}

-(float)getRowHeight:(int)chromeLevel
{
	return chromeLevel==[FLXSRowPositionInfo ROW_TYPE_HEADER]||chromeLevel==[FLXSRowPositionInfo ROW_TYPE_COLUMN_GROUP]
?self.headerHeight:chromeLevel==[FLXSRowPositionInfo ROW_TYPE_FOOTER]?self.footerRowHeight:chromeLevel==[FLXSRowPositionInfo ROW_TYPE_PAGER]?self.pagerRowHeight:chromeLevel==[FLXSRowPositionInfo ROW_TYPE_RENDERER]?self.levelRendererHeight:chromeLevel==[FLXSRowPositionInfo ROW_TYPE_FILTER]?self.filterRowHeight:self.rowHeight;
}

-(float)getSumOfColumnWidths:(NSArray*)modes
{
	if(!modes)
        modes=[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE],[FLXSFlexDataGridColumn LOCK_MODE_LEFT],[FLXSFlexDataGridColumn LOCK_MODE_RIGHT], nil];
	NSArray* arr=modes;
	float myWidth = 0;
	id cols =[self getVisibleColumns:arr];
	for(NSObject* col in cols)
	{
        FLXSFlexDataGridColumnGroup* grp = (FLXSFlexDataGridColumnGroup*)col;
		myWidth+=grp.width;
	}
	return myWidth;
}

-(NSArray*)getVisibleColumns:(NSArray*)lockModes
{
	NSString* key=lockModes?[lockModes componentsJoinedByString:(@"_")]:@"";
	if(_cachedVisibleColumns[key])return _cachedVisibleColumns[key];
	NSMutableArray* cols= [NSMutableArray new];
for(FLXSFlexDataGridColumn *col in self.columns)
	{
		if(col.visible
			&& (!lockModes||
			[lockModes indexOfObject:col.columnLockMode]!=NSNotFound))
			[cols addObject:col];
	}
	_cachedVisibleColumns[key]=cols;
	return cols;
}

- (NSArray *)getExportableColumns:(NSArray *)lockModes deep:(BOOL)deep options:(FLXSExportOptions *)options {
	NSMutableArray* cols= [NSMutableArray new];
for(FLXSFlexDataGridColumn *col in self.columns)
	{
		if(!col.excludeFromExport&& ([cols indexOfObject:col]==NSNotFound))
			[cols addObject:col];
	}
	if(deep && self.nextLevel)
	{
		id nextLevelCols = [self.nextLevel getExportableColumns:lockModes deep:deep options:options];
for(FLXSFlexDataGridColumn* subCol in nextLevelCols)
		{
			if([cols indexOfObject:subCol]==NSNotFound)
				[cols addObject:subCol];
		}
	}
	NSMutableArray* result=[NSMutableArray new];
	if(options)
	{
		for(FLXSFlexDataGridColumn* fdg in cols)
		{
			if(!options.excludeHiddenColumns || fdg.visible)
				[result addObject:fdg];
		}
	}
	else
return cols;
	return result;
}

-(NSArray*)getSortableColumns
{
	NSMutableArray* cols=[NSMutableArray new];
for(FLXSFlexDataGridColumn* col in self.columns)
	{
		if(col.sortable && ([cols indexOfObject:col]==NSNotFound))
			[cols addObject:col];
	}
	return cols;
}



-(void)clearFilter:(BOOL)recursive
{
	[self.filterArgs removeAllObjects];
	if(recursive)
	{
		[self.nextLevel clearFilter:YES];
	}
}

- (NSArray *)getShowableColumns:(NSArray *)lockModes deep:(BOOL)deep {
	NSMutableArray* cols=[NSMutableArray new];
for(FLXSFlexDataGridColumn *col in self.columns)
	{
		if(!col.excludeFromSettings&& ([cols indexOfObject:col]==NSNotFound))
			[cols addObject:col];
	}
	if(deep && self.nextLevel)
	{
		id nextLevelCols = [self.nextLevel getShowableColumns:lockModes deep:deep];
for(FLXSFlexDataGridColumn* subCol in nextLevelCols)
		{
			if([cols indexOfObject:subCol]==NSNotFound)
				[cols addObject:subCol];
		}
	}
	return cols;
}

- (NSArray *)getPrintableColumns:(NSArray *)lockModes deep:(BOOL)deep {
	NSMutableArray* cols=[NSMutableArray new];
for(FLXSFlexDataGridColumn *col in self.columns)
	{
		if(!col.excludeFromPrint && ([cols indexOfObject:col]==NSNotFound))
			[cols addObject:col];
	}
	if(deep && self.nextLevel)
	{
		id nextLevelCols = [self.nextLevel getPrintableColumns:lockModes deep:deep];
for(FLXSFlexDataGridColumn* subCol in nextLevelCols)
		{
			if([cols indexOfObject:subCol]==NSNotFound)
				[cols addObject:subCol];
		}
	}
	return cols;
}

- (FLXSAdvancedFilter *)createFilter:(NSObject *)parentObject inFilter:(FLXSFilter *)inFilter {
	FLXSAdvancedFilter* filter = [[FLXSAdvancedFilter alloc] init];
    
	filter.sorts = [self.currentSorts mutableCopy];
	if(inFilter)
	{
		for(FLXSFilterExpression* filterArg in inFilter.arguments)
		{
			[filter.arguments addObject:filterArg];
		}
	}
	if(self.additionalFilterArgumentsFunction != nil )
	{
        SEL selector = NSSelectorFromString(self.additionalFilterArgumentsFunction);
        id target = self.grid.delegate;
        NSArray * result= ((NSArray*(*)(id, SEL, FLXSFlexDataGridColumnLevel *))objc_msgSend)(target, selector,self);

		for(FLXSFilterExpression* filterArg in result)
		{
			[filter.arguments addObject:filterArg];
		}
	}
	if(self.enablePaging && filter.pageIndex==-1)
	{
		filter.pageIndex=inFilter?inFilter.pageIndex:0;
	}
	filter.pageSize = self.pageSize;
	filter.parentObject = parentObject;
	filter.level= self;
	return filter;
}

-(float)getWidestRightLockedWidth:(float)widestRightLockedWidth
{
	float myWidth = self.rightLockedWidth;
	if(widestRightLockedWidth<myWidth)
		widestRightLockedWidth=myWidth;
	float nextLevelWidth = self.nextLevel?[self.nextLevel getWidestRightLockedWidth:widestRightLockedWidth]:0;
if(widestRightLockedWidth<nextLevelWidth)
widestRightLockedWidth=nextLevelWidth;
	return widestRightLockedWidth;}

-(float)rightLockedWidth
{
	float colwidth=0;
	for(FLXSFlexDataGridColumn* col in self.rightLockedColumns)
	{
		colwidth+=col.width;
	}
	return colwidth;
}

-(float)getWidestLeftLockedWidth:(float)widestLeftLockedWidth
{
	float myWidth = self.leftLockedWidth;
	if(widestLeftLockedWidth<myWidth)
		widestLeftLockedWidth=myWidth;
	float nextLevelWidth = self.nextLevel?[self.nextLevel getWidestLeftLockedWidth:widestLeftLockedWidth]:0;
if(widestLeftLockedWidth<nextLevelWidth)
widestLeftLockedWidth=nextLevelWidth;
	return widestLeftLockedWidth;
}


-(NSArray*)flowColumns
{
	if(_flowColumns)return _flowColumns;
	_flowColumns=[[NSMutableArray alloc]init];
	for(FLXSFlexDataGridColumn* col in [self getVisibleColumns:nil])
	{
		if(col.wordWrap)
		{
			[_flowColumns addObject:col];
		}
		else if(self.grid.variableRowHeightUseRendererForCalculation && col.itemRenderer)
		{
			[_flowColumns addObject:col];
		}
	}
	return _flowColumns;
}

-(NSArray*)flowHeaderColumns
{
	if(_flowHeaderColumns)return _flowHeaderColumns;
	_flowHeaderColumns=[[NSMutableArray alloc]init];;
	for(FLXSFlexDataGridColumn* col in [self getVisibleColumns:nil])
	{
		if(col.headerWordWrap)
		{
			[_flowHeaderColumns addObject:col];
		}
		else if(self.grid.variableRowHeightUseRendererForCalculation && col.headerRenderer)
		{
			[_flowHeaderColumns addObject:col];
		}
	}
	return _flowHeaderColumns;
}

-(NSArray*)flowHeaderColumnGroups
{
	if(_flowHeaderColumnGroups)return _flowHeaderColumnGroups;
	_flowHeaderColumnGroups=[[NSMutableArray alloc]init];
	NSArray* allColumnGroups = [self getColumnGroupsAtLevel:(-1) grps:nil result:nil start:0 all:YES ];
	//get all column groups
	for(FLXSFlexDataGridColumnGroup* col in allColumnGroups)
	{
		if(col.headerWordWrap)
		{
			[_flowHeaderColumnGroups addObject:col];
		}
		else if(self.grid.variableRowHeightUseRendererForCalculation && col.headerRenderer)
		{
			[_flowHeaderColumnGroups addObject:col];
		}
	}
	return _flowHeaderColumnGroups;
}

-(NSArray*)getColumns:(NSArray*)types
{
	if(_lockCache[types])return _lockCache[types];
	NSMutableArray* result=[[NSMutableArray alloc] init];
	for(FLXSFlexDataGridColumn* col in [self getVisibleColumns:types])
	{
		[result addObject:col];
	}
	_lockCache[types]=result;
	return result;
}

-(float)leftLockedWidth
{
	float colwidth=0;
	for(FLXSFlexDataGridColumn* col in self.leftLockedColumns)
	{
		colwidth+=col.width;
	}
	if(self.grid.lockDisclosureCell && (self.nextLevel||self.nextLevelRenderer||([self.itemLoadMode isEqual:@"server"])) && self.grid.enableDefaultDisclosureIcon)
	{
		colwidth += (self.nestDepth*self.nestIndent);
	}
	return colwidth;
}

-(float)unLockedWidth
{
	float colwidth=0;
	for(FLXSFlexDataGridColumn* col in self.unLockedColumns)
	{
		colwidth+=col.width;
	}
	return colwidth;
}

- (float)getWidestWidth:(float)widestWidth deep:(BOOL)deep {
	float myWidth = self.grid.lockDisclosureCell?0:self.nestDepth*self.nestIndent;
	myWidth+=[self getSumOfColumnWidths:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE], nil]];
	if(widestWidth<myWidth)
		widestWidth=myWidth;
	float nextLevelWidth = (self.nextLevel&&deep)? [self.nextLevel getWidestWidth:widestWidth deep:YES ] :0;
if(widestWidth<nextLevelWidth)
widestWidth=nextLevelWidth;
	return widestWidth;
}

-(NSArray*)getColumnsByWidthMode:(NSArray*)modes
{
	NSMutableArray* result=[[NSMutableArray alloc] init];
	NSMutableArray* cols=[[self getVisibleColumns:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE], nil]] mutableCopy];
	for(FLXSFlexDataGridColumn* col in cols)
	{
		if([modes indexOfObject:col.columnWidthMode]!=NSNotFound)
		{
			[result addObject:col];
		}
	}
	return result;
}

-(void)setColumnWidthsUsingWidthMode:(BOOL)equally
{
	float widthsAdded=0;
	NSMutableArray* cols=[[self getVisibleColumns:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE], nil]] mutableCopy];
	NSArray* provider;
	FLXSFlexDataGridColumn* col;
	FLXSFlexDataGridColumn* lstCol;
	if(!self.grid.forceColumnsToFitVisibleArea)
	{
		for(lstCol in self.columns)
		{
			if(lstCol.naturalLastColWidth)
			{
				lstCol.width=lstCol.naturalLastColWidth;
				lstCol.naturalLastColWidth=0;
			}
		}
		if([cols count]>0)
		{
			lstCol=cols[[cols count]-1];
		}
	}
	float av=[self getAvailableWidth];
	if(equally)
	{
		for(col in cols)
		{
			col.width=av/[cols count];
		}
		return;
	}
	BOOL hasFitToContent=[[self getColumnsByWidthMode:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_FIT_TO_CONTENT], nil]] count]>0;
	if(hasFitToContent)
	{
		provider = [self.grid flatten:self.nestDepth inclusive:NO filter:YES page:YES sort:YES max:self.columnWidthModeFitToContentSampleSize];
	}
	for(col in cols)
	{
		if((!self.grid.forceColumnsToFitVisibleArea) &&!col.isLocked&&col.isLastUnLocked)
		{
			continue;
		}
		if(col.lastVisibleWidth)
		{
			col.columnWidthMode=[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_FIXED];
			col.width=col.lastVisibleWidth;
			widthsAdded+=col.width;
		}
		else if([col.columnWidthMode isEqual:[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_FIXED]] || [col.columnWidthMode isEqual:[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_NONE]])
		{
			//do nothing, we just use the width property user provided.
			//col.width=col.width;
			widthsAdded+=col.width;
		}
		else if([col.columnWidthMode isEqual:[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_FIT_TO_CONTENT]])
		{
			[self applyColumnWidthFromContent:col provider:provider];
			widthsAdded+=col.width;
		}
	}
	if(!self.grid.forceColumnsToFitVisibleArea)
	{
		//handle scenario where added column widths are less than the available,
		if(widthsAdded<av)
		{
			if(lstCol)
			{
				if(!lstCol.naturalLastColWidth)
					lstCol.naturalLastColWidth=lstCol.width;
				lstCol.width=av-widthsAdded ;
			}
		}
		if(self.nextLevel)
			[self.nextLevel setColumnWidthsUsingWidthMode :equally];
		return;
	}
	//now that we have allocated space to fixed Width and fitToContent columns, distribute the remaining space
	//based on percentages.
	float remaining= av-widthsAdded;
	if(remaining>0)
	{
		for(col in [self getColumnsByWidthMode:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_PERCENT], nil]])
		{
			int percent=col.percentWidth;
			if(percent)
			{
				col.width=(percent*remaining)/100;
				widthsAdded+=col.width;
			}
		}
	}
	remaining = av-widthsAdded;
	//now that the columns are all allocated for, if we are required to fit within the visible area, then we need
	//to squish columns that are none width OR percent width.
	//if(remaining>1)
	{
		cols=[[self getColumnsByWidthMode:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_NONE],[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_PERCENT],nil]] mutableCopy];
		for(col in cols)
		{
			col.width+=(remaining/([cols count]));
			if(col.width<col.minWidth)
				col.width=col.minWidth;
		}
	}
	remaining = av-[self getSumOfColumnWidths:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE], nil]];
	//self means we went over, because of some columns. we now HAVE to squish every non fixed on.
	cols=[[self getColumnsByWidthMode:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_NONE],[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_PERCENT],[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_FIT_TO_CONTENT], nil]] mutableCopy];
	float availableToTakeOff=0;
	for(col in cols)
	{
		if(col.width>col.minWidth)
		{
			availableToTakeOff+=col.width;
		}
	}
	if(availableToTakeOff>0)
	{
		for(col in cols)
		{
			if(col.width>col.minWidth)
			{
				col.width+= (remaining * col.width)/availableToTakeOff;
			}
		}
	}
	else
	{
		//cannot do anything - user asked to display too many columns in an area that is not enough!
	}
	cols=[[self getVisibleColumns:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE], nil]] mutableCopy];
	float round= [self getSumOfColumnWidths:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE], nil]] - av;
	
    if([cols count]>0){
		((FLXSFlexDataGridColumn*)cols[[cols count]-1]).width -=round ;
    }
	cols=[[self getVisibleColumns: [[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_RIGHT], nil]] mutableCopy];
	if([cols count]>0)
	{
		round= [self getWidestRightLockedWidth:0] - self.grid.rightLockedContent.frame.size.width;
		((FLXSFlexDataGridColumn*)cols[[cols count]-1]).width -=round ;
	}
	cols=[[self getVisibleColumns: [[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_LEFT], nil]] mutableCopy];
	if([cols count]>0)
	{
		round= [self getWidestLeftLockedWidth:0] - self.grid.leftLockedContent.frame.size.width;
		((FLXSFlexDataGridColumn*)cols[[cols count]-1]).width -=round ;
	}
	cols=[[self getVisibleColumns:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE], nil]] mutableCopy];
	for(col in cols)
	{
		if(col.lastVisibleWidth)
		{
			col.lastVisibleWidth=0;
			col.columnWidthMode=[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_NONE];
		}
	}
	if(self.nextLevel)
		[self.nextLevel setColumnWidthsUsingWidthMode :equally];
    [self dispatchEvent:[[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent COLUMNS_RESIZED] andGrid:self.grid andLevel:self andColumn:nil andCell:nil andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ]];
}

- (void)applyColumnWidthFromContent:(FLXSFlexDataGridColumn *)col provider:(NSArray *)provider {
	float offset = col.columnWidthOffset;
	NSString* longestString=@"";
	for(NSObject* obj in provider)
	{
		if(obj==nil)continue;
		NSString* str = [col itemToLabel:obj:nil];
		if(str && (longestString.length<str.length))
		{
			longestString=str;
		}
	}
	if(col.headerText && longestString.length<col.headerText.length
		&& !col.columnWidthModeFitToContentExcludeHeader)
		longestString=col.headerText;
	if(col.nestDepth==1 && self.enableFooters
		&& !col.columnWidthModeFitToContentExcludeHeader)
	{
		NSString* footerText= [FLXSFlexDataGridFooterCell defaultLabelFunction:col dataProvider:provider];
		if(longestString.length<footerText.length)
		{
			longestString=footerText;
		}
	}
	if(longestString.length>0/* && provider.length>0*/)
	{
        col.width= [longestString sizeWithFont:[UIFont fontWithName: self.grid.fontName size: self.grid.fontSize]  ].width + offset + [[col getStyleValue:(@"paddingLeft")] floatValue] +
    [[col getStyleValue:(@"paddingRight")] floatValue] ;
		//need to account for default padding
	}
	if(col.width<col.minWidth)
		col.width=col.minWidth;
}

-(float)getAvailableWidth
{
	float availableWidth;
	if(self.grid.forceColumnsToFitVisibleArea)
		availableWidth = (((FLXSFlexDataGridColumn*)(self.grid.bodyContainer)).width-self.grid.isVScrollBarVisible);
	else
        availableWidth = MAX([self.grid.columnLevel getWidestWidth:(-1) deep:NO],self.grid.bodyContainer.frame.size.width-self.grid.isVScrollBarVisible);
	return availableWidth;
}

- (void)adjustColumnWidths:(float)widestWidth equally:(BOOL)equally {
	[self setColumnWidthsUsingWidthMode:equally];
}

-(id)getStyleValue:(NSString*)styleProp
{
	id result = [self getStyle:styleProp];
	if(result == nil || [result integerValue] == 0)
		result = [self.grid getStyle:styleProp];
	return result;
}

-(void)invalidateList
{
	if(self.grid)
		[self.grid reDraw];
}

- (BOOL)areAllSelected:(NSArray *)items checkLength:(BOOL)checkLength {
	//if(checkLength && (items.length != selectedKeys.length)) return NO;
	for(NSObject* item in items)
	{
		if(![self existsInCursor:((item))])
		{
			if([self checkRowSelectable:nil object:item])
				return NO;
		}
		if(self.nextLevel && self.nextLevel.reusePreviousLevelColumns)
		{
			if(![self.nextLevel areAllSelected:([self getChildren:item filter:NO page:NO sort:NO ]) checkLength:NO ])
			{
				return NO;
			}
		}
	}
	return YES;
}

- (NSObject *)getItemKey:(NSObject *)item saveLevel:(BOOL)saveLevel {
	if(saveLevel && self.selectedKeyField){
        return [[[NSArray alloc] initWithObjects:
                [self getValue:[[FLXSExtendedUIUtils resolveExpression:item expression:self.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ] description]],@"|" ,[NSNumber numberWithInt:self.nestDepth],nil]
                componentsJoinedByString:@""];
    }
	else
        return (![FLXSUIUtils nullOrEmpty:self.selectedKeyField])?[self getValue:([FLXSExtendedUIUtils resolveExpression:item expression:self.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ])]:item;
}

-(NSObject*)getValue:(NSObject*)val
{
	return val;
}

- (BOOL)isItemEqual:(NSObject *)itemOrKeyToCompare rowData:(NSObject *)rowData useItemKeyForCompare:(BOOL)useItemKeyForCompare {
	return (!useItemKeyForCompare && ([rowData isEqual:itemOrKeyToCompare] ))
||(useItemKeyForCompare && ([[self getItemKey:rowData saveLevel:NO ] isEqual:itemOrKeyToCompare]));
}

- (BOOL)areItemsEqual:(NSObject *)itemA itemB:(NSObject *)itemB {
	if(self.selectedKeyField)
	{
		return ([([FLXSExtendedUIUtils resolveExpression:itemA expression:self.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ])
                isEqual:([FLXSExtendedUIUtils resolveExpression:itemB expression:self.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ])]);
	}
	else
	{
		return [itemA isEqual:itemB];
	}
}

- (NSObject *)getItemFromKey:(id)itemKey flat:(NSArray *)flat {
	if(!flat)flat=[self.grid getRootFlat];
	for(NSObject* item  in flat)
	{
		if([[self getItemKey:item saveLevel:NO ] isEqual:itemKey])
		{
			return item;
		}
		if(self.nextLevel)
		{
			NSObject* result= [self.nextLevel getItemFromKey:itemKey flat:([self getChildren:item filter:NO page:NO sort:NO ])];
			if(result)
			{
				return result;
			}
		}
	}
    return nil;
}

- (BOOL)isItemSelected:(NSObject *)item useExclusion:(BOOL)useExclusion {
	if(useExclusion && self.grid.enableSelectionExclusion)
	{
		return ([[self getCheckBoxStateBasedOnExclusion:item useBubble:YES checkDisabled:YES ] isEqual:[FLXSTriStateCheckBox STATE_CHECKED]]);
	}
	BOOL selected=NO;
	if(self.selectedKeyField.length>0)
	{
		id itemKey = [FLXSExtendedUIUtils resolveExpression:item expression:self.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];
		NSMutableArray* v=self.selectedKeys;
		//just to ensure the cursor is read.
		selected= ([v indexOfObject:itemKey]!=NSNotFound);
	}
	else
        selected =([self.selectedObjects indexOfObject:item]!=NSNotFound);
	/*if(!checked && grid.enableSelectionCascade && parentLevel)
	{
		NSObject* parent = [grid getParent:item :self];
		if(parent)
		{
			checked = [parentLevel isItemSelected:parent];
		}
	}
	*/
    return selected;
}

-(BOOL)isItemOpen:(NSObject*)item
{
	if(self.selectedKeyField)
	{
		NSObject * itemKey= [FLXSExtendedUIUtils resolveExpression:item expression:self.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];
		for(NSObject* child in self.grid.openItems)
		{
			if([itemKey isEqual:[FLXSExtendedUIUtils resolveExpression:child expression:self.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ]])
				return YES;
		}
		return NO;
	}
	return [self.grid.openItems containsObject:((item))];
}

- (FLXSCellInfo *)isCellSelected:(NSObject *)item column:(FLXSFlexDataGridColumn *)col {
	for(FLXSCellInfo* cell in self.selectedCells)
	{
		if([cell.rowData isEqual:item] && [cell.columnFLXS isEqual:col])
			return cell;
	}
	return nil;
}

- (void)selectCell:(UIView <FLXSIFlexDataGridCell> *)cell selected:(BOOL)selected {
    [self selectCellByRowPositionInfo:cell.rowInfo.rowPositionInfo column:cell.columnFLXS selected:selected];
}

- (void)selectCellByRowPositionInfo:(FLXSRowPositionInfo *)rowInfo column:(FLXSFlexDataGridColumn *)col selected:(BOOL)selected {
	FLXSCellInfo* cellInfo = [self isCellSelected:rowInfo.rowData column:col];
	if(!col)
		return;
	if(selected)
	{
		if(!cellInfo)
		{
			if([col.level.grid.selectionMode isEqual:[FLXSFlexDataGrid SELECTION_MODE_SINGLE_CELL]])
				[self.selectedCells removeAllObjects];
			[self.selectedCells addObject:([[FLXSCellInfo alloc] initWithRowData:rowInfo.rowData andColumn:col])];
		}
	}
	else if(!selected)
	{
		if(cellInfo)
		{
			[self.selectedCells removeObjectAtIndex:([self.selectedCells indexOfObject:cellInfo])];
		}
	}
	FLXSEvent* evt= [[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent CHANGE] andGrid:self.grid andLevel:self andColumn:nil andCell:nil andItem:nil andTriggerEvent:nil andBubbles:false andCancelable:false ];
    [self dispatchEvent:evt];
}

- (void)shiftColumns:(FLXSFlexDataGridColumn *)columnToInsert insertBefore:(FLXSFlexDataGridColumn *)insertBefore movingCg:(BOOL)movingCg {
	NSArray* cols=[self.columns mutableCopy];
	NSMutableArray* arrayCollection = [[NSMutableArray alloc] initWithArray:cols];
	[arrayCollection removeObjectAtIndex:([arrayCollection indexOfObject:columnToInsert])];
	[arrayCollection insertObject:columnToInsert atIndex:([arrayCollection indexOfObject:insertBefore])];
	self.columns=arrayCollection;
	if(columnToInsert.columnGroup && !movingCg)
	{
		for(NSObject* cg1 in columnToInsert.level.groupedColumns)
		{
			if([cg1 isKindOfClass:  [FLXSFlexDataGridColumnGroup class]] )
			{
				[self swapColumns:((FLXSFlexDataGridColumnGroup *) cg1) columnToInsert:columnToInsert insertBefore:insertBefore];
			}
		}
	}
	[self initializeColumnLevel];
    [self dispatchEvent:[[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent COLUMNS_SHIFT] andGrid:self.grid andLevel:self andColumn:nil andCell:nil andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ]];
	[self.grid reDraw];
}

- (void)swapColumns:(FLXSFlexDataGridColumnGroup *)cg columnToInsert:(FLXSFlexDataGridColumn *)columnToInsert insertBefore:(FLXSFlexDataGridColumn *)insertBefore {
	NSMutableArray* arrayCollection = [[NSMutableArray alloc] initWithArray:(cg.columns)];
	if([arrayCollection containsObject:columnToInsert] && [arrayCollection containsObject:insertBefore] )
	{
		[arrayCollection removeObjectAtIndex:([arrayCollection indexOfObject:columnToInsert])];
        [arrayCollection insertObject:columnToInsert atIndex:[arrayCollection indexOfObject:insertBefore]];
		//[arrayCollection addItemAt:columnToInsert :([arrayCollection indexOfObject:insertBefore])];
		cg.columns=arrayCollection;
	}
	for(NSObject* cg1 in cg.columnGroups)
	{
		if([cg1 isKindOfClass:[FLXSFlexDataGridColumnGroup class]])
		{
            [self swapColumns:((FLXSFlexDataGridColumnGroup *) cg1) columnToInsert:columnToInsert insertBefore:insertBefore];
		}
	}
}

- (BOOL)selectAll:(BOOL)select dispatch:(BOOL)dispatch provider:(NSArray *)provider subset:(NSArray *)subset useKeys:(BOOL)useKeys openItems:(BOOL)openItems {
	if(self.nestDepth==1)
	{
		self.grid.useSelectedSelectAllState=select?[FLXSTriStateCheckBox STATE_CHECKED]:[FLXSTriStateCheckBox STATE_UNCHECKED];
		//clear out everhitng before we start
		if(self.grid.enableSelectionExclusion)
		{
			self.grid.selectAllState=select?[FLXSTriStateCheckBox STATE_CHECKED]:[FLXSTriStateCheckBox STATE_UNCHECKED];
			return NO;
		}
		else
[self clearSelection:NO];
	}
	BOOL retval=NO;
	if(select)
	{
		if(!provider)
		{
			provider = [self.grid getRootFlat];
			if(self.nestDepth==1 && self.grid.isClientFilterPageSortMode)
				provider = [FLXSExtendedUIUtils filterArray:provider filter:([self.grid getRootFilter]) grid:self.grid level:self hideIfNoChildren:NO ];
		}
		for(id item in provider)
		{
			if(self.enableSingleSelect && select)
			{
				if(self.defaultSelectionField)
				{
					if(![FLXSExtendedUIUtils resolveExpression:item expression:self.defaultSelectionField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ])
					{
						continue;
					}
				}
			}
			BOOL check=YES;
			if(self.rowDisabledFunction !=nil)
			{
                SEL selector = NSSelectorFromString(self.rowDisabledFunction);
                id target = self.grid.delegate;
                check= [((NSNumber *(*)(id, SEL, FLXSFlexDataGridColumnLevel *,NSObject*))objc_msgSend)(target, selector,nil,item) boolValue];
			}
			if(check)
			{
				check= [self checkRowSelectable:nil object:item];
			}
			if(subset && check)
			{
                id toCheck = [self getItemKey:item saveLevel:NO ];
				check=[subset indexOfObject:(useKeys?toCheck:item)]!=NSNotFound;
			}
			if(check)
			{
				[self addSelectedItem:item];
				retval=YES;
			}
			if(self.nextLevel && (self.grid.enableSelectionCascade||subset))
			{
				BOOL nextVal= [self.nextLevel selectAll:select dispatch:NO provider:([self getChildren:item filter:NO page:NO sort:NO ]) subset:subset useKeys:useKeys openItems:openItems];
				if(nextVal && openItems)
				{
					[self.grid.bodyContainer addOpenItem:item rowPositionInfo:nil ];
					retval=YES;
				}
			}
			if(self.enableSingleSelect&&check)
			{
				if(!self.defaultSelectionField)
				{
					break;
				}
			}
		}
	}
	if(dispatch)
	{
        FLXSFlexDataGridEvent* evt= [[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent CHANGE] andGrid:self.grid andLevel:nil andColumn:nil andCell:nil andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ];
		[self dispatchEvent:evt];
	}
	if(retval && self.nestDepth==1)
	{
		[self.grid rebuildBody:NO];
	}
	return retval;
     return  NO;
}

- (void)selectRow:(NSObject *)item selected:(BOOL)selected dispatch:(BOOL)dispatch recurse:(BOOL)recurse bubble:(BOOL)bubble parent:(NSObject *)parent {
	if(self.grid.enableSelectionExclusion)
	{
		[self selectRowExclusion:item selected:selected];
	}
	else
	{
		if(recurse)
		{
			if(self.nextLevel&&(self.grid.enableSelectionCascade) )
			{
				if(self.nextLevel.enableSingleSelect)
				{
					//Check on parent, atleast 1 child row should be checked. Allow apps to provide which row will be default checked. Need data hooks/APIs for the same.
					for(NSObject* child1 in [self getChildren:item filter:NO page:NO sort:NO ])
					{
						if(self.nextLevel.defaultSelectionField)
						{
							if([FLXSExtendedUIUtils resolveExpression:child1 expression:self.nextLevel.defaultSelectionField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ])
							{
								[self.nextLevel selectRow:child1 selected:selected dispatch:NO recurse:YES bubble:NO parent:item];
								break;
							}
						}
						else
						{
							//select the first child
							[self.nextLevel selectRow:child1 selected:selected dispatch:NO recurse:YES bubble:NO parent:item];
							break;
						}
					}
				}
				else
				{
					for(NSObject* child in [self getChildren:item filter:NO page:NO sort:NO ])
					{
						[self.nextLevel selectRow:child selected:selected dispatch:NO recurse:YES bubble:NO parent:item];
					}
				}
			}
		}
        //next version NSInvocation or method block

//		if(self.rowDisabledFunction !=nil)
//		{
//			BOOL disable=[self rowDisabledFunction:nil :item];
//			if(disable)return;
//		}
		BOOL selectable= [self checkRowSelectable:nil object:item];
		if(!selectable)return;
		if(selected && self.enableSingleSelect && self.nestDepth>1)
		{
			//need to un select all my siblings
			if(!parent)
				parent= [self.grid getParent:item level:self];
			for(NSObject* sibling in [self.grid getChildren:parent level:self.parentLevel filter:NO page:NO sort:NO ])
			{
				if(![[self getItemKey:sibling saveLevel:NO ] isEqual:[self getItemKey:item saveLevel:NO ]])
				{
					if([self isItemSelected:sibling useExclusion:YES ])
					{
                        [self selectRow:sibling selected:NO dispatch:NO recurse:NO bubble:NO parent:parent];
					}
				}
			}
		}
		if([self.grid.selectionMode isEqual:[FLXSFlexDataGrid SELECTION_MODE_SINGLE_ROW]])
			[self.grid clearSelection];
		if(selected)
		{
			//if(![self existsInCursor:item])
			{
				[self addSelectedItem:item];
			}
		}
		else if(!selected)
		{
			//if([self existsInCursor:item])
			{
				[self removeSelectedItem:item];
			}
		}
		if(recurse&&self.grid.enableSelectionBubble && bubble)
		{
			if(self.enableSingleSelect && selected)
			{
				//just add parent to selection as well
				if(self.parentLevel)
				{
					NSObject* parent1 = [self.grid getParent:item level:self];
					[self.parentLevel selectRow:parent1 selected:YES dispatch:NO recurse:NO bubble:NO parent:nil ];
				}
			}
			else
[self bubbleSelection:item];
		}
	}
	if(dispatch)
	{
        FLXSFlexDataGridEvent* evt= [[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent CHANGE] andGrid:self.grid andLevel:nil andColumn:nil andCell:nil andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ];
	
		[self dispatchEvent:evt];
	}
}

-(void)bubbleSelection:(id)item
{
	if(self.parentLevel)
	{
		NSObject* parent = [self.grid getParent:item level:self];
		if(parent)
		{
			id allChildren = [self.grid getChildren:parent level:self.parentLevel filter:NO page:NO sort:NO ];
            if([self areAllSelected:allChildren checkLength:YES ])
			{
				[self.parentLevel selectRow:parent selected:YES dispatch:NO recurse:NO bubble:NO parent:nil ];
			}
			else if([self.parentLevel isItemSelected:parent useExclusion:NO ])
			{
				[self.parentLevel selectRow:parent selected:NO dispatch:NO recurse:NO bubble:NO parent:nil ];
			}
			[self.parentLevel bubbleSelection:parent];
		}
	}
}

-(BOOL)existsInCursor:(NSObject*)item
{
	return [self isItemSelected:item useExclusion:YES ];
}

-(void)addSelectedItem:(NSObject*)item
{
	/*if(selectedKeyField && _calculatedSelectedKeysCursor)
	{
		if([_calculatedSelectedKeysCursor findAny:([FLXSExtendedUIUtils resolveExpression:item :selectedKeyField])])
								return;
	}
	*/
if([self.selectedObjects indexOfObject:item]==NSNotFound)
	{
		[self.selectedObjects addObject:item];
		[self storeChain:item];
        _calculatedSelectedKeys=nil;
	}
}

-(void)storeChain:(NSObject*)item
{
	if(self.grid.enableSelectionExclusion)
	{
		//when an item is added to the [self selection:or exclusion], we will need to track its ascendants, because we need
		//to mark them as middle state.
		if(![self.grid.selectionChain valueForKey: [[self getItemKey:item saveLevel:NO ] description]])
		{
            [self.grid.selectionChain setValue:[[NSMutableArray alloc]init]forKey:[[self getItemKey:item saveLevel:NO ] description]];
		}
        NSMutableArray * arr =    (NSMutableArray *)[self.grid.selectionChain valueForKey: [[self getItemKey:item saveLevel:NO ] description]];
        [self pushIntoChain:arr item:item];
        NSArray* reversedArray = [[arr reverseObjectEnumerator] allObjects];
        [self.grid.selectionChain setValue:reversedArray forKey:[[self getItemKey:item saveLevel:NO ] description]];

    }
}

- (void)pushIntoChain:(NSMutableArray *)chain item:(NSObject *)item {
	[chain addObject:item];
	if(self.parentLevel)
	{
		NSObject* parent= [self.grid getParent:item level:self];
        if(parent)
		{
			[self.parentLevel pushIntoChain:chain item:parent];
		}
	}
}

-(void)removeSelectedItem:(NSObject*)item
{
	if(self.selectedKeyField.length>0 && [self.selectedObjects indexOfObject:item]==NSNotFound)
	{
		id itemKey = [FLXSExtendedUIUtils resolveExpression:item expression:self.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];
		for(NSObject* selectedItem in self.selectedObjects)
		{
			if([itemKey isEqual:[FLXSExtendedUIUtils resolveExpression:item expression:self.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ]])
			{
				item=selectedItem;
				break;
			}
		}
	}
	float itemIdex=[self.selectedObjects indexOfObject:item];
	if(itemIdex!=NSNotFound){
		[self.selectedObjects removeObjectAtIndex:itemIdex];
        _calculatedSelectedKeys=nil;
    }
}

-(void)setSelectedKeysState:(NSString*)val
{
	[self clearSelection:NO];
	if([val isEqual:[FLXSTriStateCheckBox STATE_CHECKED]])
	{
		for(NSObject* item in self.grid.dataProviderFLXS)
		{
			[self addSelectedItem:((item))];
		}
	}
    FLXSFlexDataGridEvent* evt= [[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent CHANGE] andGrid:self.grid andLevel:nil andColumn:nil andCell:nil andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ];
	[self dispatchEvent:evt];
}

- (void)setSelectedObjects:(NSArray *)objects openItems:(BOOL)openItems {
	[self selectAll:YES dispatch:YES provider:nil subset:objects useKeys:NO openItems:openItems];
}

- (void)setSelectedKeys:(NSArray *)objects openItems:(BOOL)openItems {
	[self selectAll:YES dispatch:YES provider:nil subset:objects useKeys:YES openItems:openItems];
}

- (void)getSelectedObjects:(NSMutableArray *)soFar getKey:(BOOL)getKey unSelected:(BOOL)unSelected {
	for(NSObject* item in unSelected?self.unSelectedObjects:self.selectedObjects)
	{
		[soFar addObject:(getKey? [self getItemKey:item saveLevel:NO ] :item)];
	}
	if(self.nextLevel)
	{
		[self.nextLevel getSelectedObjects:soFar getKey:getKey unSelected:unSelected];
	}
}

-(NSString*)getSelectedKeysState:(NSArray*)allItems
{
	if([self.grid getLength:allItems]==0)
	{
		return [FLXSTriStateCheckBox STATE_UNCHECKED];
	}
	else if([self areAllSelected:allItems checkLength:YES ])
	{
		return [FLXSTriStateCheckBox STATE_CHECKED];
	}
	else if(![self areAnySelected:allItems recursive:NO ])
	{
		return [FLXSTriStateCheckBox STATE_UNCHECKED];
	}
	else
	{
		return [FLXSTriStateCheckBox STATE_MIDDLE];

	}
}

- (BOOL)areAnySelected:(NSArray *)itemsToCheck recursive:(BOOL)recursive {
	for(NSObject* item in itemsToCheck)
	{
		for(id key in self.selectedObjects)
		{
			if([item isEqual: key])
			{
				return YES;
			}
		}
		if(recursive)
		{
			if(self.nextLevel && [self.nextLevel areAnySelected:([self getChildren:item filter:NO page:NO sort:NO ]) recursive:NO ])
			{
				return YES;
			}
		}
	}
	return NO;
}

- (NSArray *)getChildren:(NSObject *)object filter:(BOOL)filter page:(BOOL)page sort:(BOOL)sort {
    //return grid getChildren(object,this,filter,page,sort)
    return [self.grid getChildren:object level:self filter:filter page:page sort:sort];

}

- (int)getChildrenLength:(NSObject *)object filter:(BOOL)filter page:(BOOL)page sort:(BOOL)sort {
    //			return grid.getChildrenLength(object,this,filter,page,sort)
    return [self.grid getChildrenLength:object level:self filter:filter page:page sort:sort];
}


-(void)showColumns:(NSArray*)colsToShow
{
	for(FLXSFlexDataGridColumn* col in self.columns)
	{
		col.visible = [FLXSUIUtils doesArrayContainObjectValue:colsToShow valueField:(@"name") compareVal:col.uniqueIdentifier] != nil;
	}
	if(self.nextLevel)[self.nextLevel showColumns:colsToShow];
}

-(void)showPrintableColumns
{
	for(FLXSFlexDataGridColumn* col in self.columns)
	{
		col.visible = !col.excludeFromPrint;
	}
	if(self.nextLevel)[self.nextLevel showPrintableColumns];
}

- (FLXSFlexDataGridColumn *)getColumnByDataField:(NSString *)fld by:(NSString *)by {
	for(FLXSFlexDataGridColumn* col in self.columns)
	{
		if([[col valueForKey:by] isEqual:fld]) //if(col [by] == fld)
		{
			return col;
		}
	}
	return nil;
     return  nil;
}

-(FLXSFlexDataGridColumn*)getColumnByUniqueIdentifier:(NSString*)fld
{
	for(FLXSFlexDataGridColumn* col in self.columns)
	{
		if([col.uniqueIdentifier isEqualToString:fld] )
		{
			return col;
		}
	}
	return nil;
}

-(void)clearColumns:(BOOL)rebuild
{
	[_columns removeAllObjects];
}

-(void)addColumn:(FLXSFlexDataGridColumn*)col
{
	[_columns addObject:col];
	col.level=self;
    [self.grid rebuild];
	[self adjustColumnWidths:-1 equally:NO ];
}

-(void)removeColumn:(FLXSFlexDataGridColumn*)col
{
	NSUInteger colIndex=  col?[col getIndex]:NSNotFound;
	if(colIndex!=NSNotFound && colIndex > -1)
	{
		//[_columns splice:colIndex :1];
        [_columns removeObjectAtIndex:colIndex];
        [self.grid rebuild];

	}
}

-(void)distributeColumnWidthsEqually
{
	[self adjustColumnWidths:(-1) equally:YES ];
}

- (NSArray *)getColumnGroupsAtLevel:(int)cgLevel grps:(NSArray *)grps result:(NSMutableArray *)result start:(float)start all:(BOOL)all {
	start++;
	if(result==nil)
		result=[[NSMutableArray alloc] init];
	if(grps==nil)
		grps=self.columnGroups;
	for(FLXSFlexDataGridColumnGroup* grp in grps)
	{
		if(all)
		{
			[result addObject:grp];
            [self getColumnGroupsAtLevel:cgLevel grps:grp.columnGroups result:result start:start all:all];
		}
		else if(start==cgLevel)
		{
			[result addObject:grp];
		}
		else
		{
            [self getColumnGroupsAtLevel:cgLevel grps:grp.columnGroups result:result start:start all:all];
		}
	}
	return result;
}

-(NSString*)traceCols
{
	NSString* str=@"";
	for(FLXSFlexDataGridColumn* col in self.columns)
	{
        str = [str stringByAppendingFormat:@"%@:%f\n",col.headerText, col.width];
		//str +=col.headerText+ @":" + col.width;
		//str +=@"\n";
        
		//str +=row.y + @":" + (row.data.name?row.data.name:row.data.id) + @":" + row.rowPositionInfo.rowType+ @"\n";
	}
	return str;
}


-(void)setEnableRowNumbers:(BOOL)value
{
	if((_enableRowNumbers != value) && (self.grid))
		[self.grid reDraw];
	_enableRowNumbers = value;
	[self ensureRowNumberColumn];
}

-(void)ensureRowNumberColumn
{
	if(!self.grid)return;
    //next version v1.2
//	if( (self.enableRowNumbers && ([self.columns count]==0 ))|| !(self.columns[0] isKindOfClass:[FLXSFlexDataGridRowNumberColumn Class]))
//	{
//		FLXSFlexDataGridRowNumberColumn* col =[grid createRowNumberColumnFunction];
//		if(leftLockedColumns.length>0)
//								col.columnLockMode = [FLXSFlexDataGridColumn LOCK_MODE_LEFT];
//		Array* newCols = [columns slice];
//		[newCols splice:0 :0 :col];
//		columns=newCols;
//	}
}
-(NSArray*)getFilterArguments{
    return _filterArgs;
}

-(NSArray*)leftLockedColumns
{
    return [self getColumns:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_LEFT],nil] ];
}

-(NSArray*)rightLockedColumns
{
    return [self getColumns:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_RIGHT],nil] ];
}

-(NSArray*)unLockedColumns
{
    return [self getColumns:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE],nil] ];
}

- (void)getOpenKeys:(NSMutableArray *)keys provider:(NSArray *)provider {
	if(!provider)
	{
		provider = [self.grid getRootFlat];
	}
	for(NSObject* item in provider)
	{
		if([self isItemOpen:item])
			[keys addObject:([self getItemKey:item saveLevel:NO ])];
		if(self.nextLevel)
		{
			[self.nextLevel getOpenKeys:keys provider:([self getChildren:item filter:NO page:NO sort:NO ])];
		}
	}
}

- (void)setOpenKeys:(NSArray *)keys provider:(NSArray *)provider {
	if(!provider)
	{
		provider = [self.grid getRootFlat];
	}
	for(NSObject* item in provider)
	{
		if([keys indexOfObject:([self getItemKey:item saveLevel:NO ])]!=NSNotFound)
			[self.grid.bodyContainer addOpenItem:item rowPositionInfo:nil ];
		if(self.nextLevel)
		{
			[self.nextLevel setOpenKeys:keys provider:([self getChildren:item filter:NO page:NO sort:NO ])];
		}
	}
}

-(BOOL)hasFilterFunction
{
    return ![FLXSUIUtils nullOrEmpty:self.filterFunction]  ||(self.nextLevel && self.nextLevel.hasFilterFunction);
}

- (BOOL)setSelectedItemsBasedOnSelectedField:(NSArray *)items parent:(NSObject *)parent openItems:(BOOL)openItems {
	BOOL result=NO;
for(NSObject *item in items)
	{
		if([item respondsToSelector:NSSelectorFromString(self.selectedField)] && ([item valueForKey:self.selectedField ]))// item[self.selectedField])
		{
			if(parent)
			{
				if(openItems)
				{
					if(![self.grid.openItems containsObject:parent])
					{
						[self.grid.openItems addObject:parent];
					}
				}
			}
			if(![self isItemSelected:item useExclusion:NO ])
			{
				[self addSelectedItem:item];
				result=YES;
			}
		}
		if(self.nextLevel)
		{
			BOOL nlResult= [self.nextLevel setSelectedItemsBasedOnSelectedField:([self getChildren:item filter:NO page:NO sort:NO ]) parent:item openItems:openItems];
			result=nlResult||result;
		}
	}
	return result;
}

-(void)addUnSelectedItem:(NSObject*)item
{
	[self.unSelectedObjects addObject:item];
	[self storeChain:item];
}

-(void)removeUnSelectedItem:(NSObject*)item
{
	if(self.selectedKeyField.length>0 && [self.unSelectedObjects indexOfObject:item]==NSNotFound)
	{
		id itemKey = [FLXSExtendedUIUtils resolveExpression:item expression:self.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];
		for(NSObject* selectedItem in self.unSelectedObjects)
		{
			if([itemKey isEqual:[FLXSExtendedUIUtils resolveExpression:item expression:self.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ]])
			{
				item=selectedItem;
				break;
			}
		}
	}
	float itemIdex=[self.unSelectedObjects indexOfObject:item];
	if(itemIdex!=NSNotFound)
		[self.unSelectedObjects removeObjectAtIndex:itemIdex];
}

- (void)selectRowExclusion:(NSObject *)item selected:(BOOL)selected {
	if(![self checkRowSelectable:nil object:item])return;
	if(!selected)
	{
		//user unchecked an item
		if([self isItemSelected:item useExclusion:NO ])
		{
			//if it was explicitly checked previously
			[self removeSelectedItem:item]; //remove it from the explicit selection
		}
		else if(![self isItemUnSelected:item])
		{
			//if it was not explicitly unselected previously
			[self addUnSelectedItem:item];
			//add it to explicit unselection
		}
	}
	else if(selected)
	{
		//user checked an item
		if([self isItemUnSelected:item])
		{
			//if it was explicitly unselected before
			[self removeUnSelectedItem:item];//remove from explicit unselection
		}
		else if(![self isItemSelected:item useExclusion:NO ])
		{
			//if it was not explicitly checked before
			[self addSelectedItem:item];
			//add it to explicit selection.
			if(_enableSingleSelect && self.nestDepth>1)
			{
				NSMutableArray* myChain = self.grid.selectionChain[[self getItemKey:item saveLevel:NO ]];
				for(NSObject* sibling in self.selectedObjects)
				{
					NSMutableArray* siblingChain=self.grid.selectionChain[[self getItemKey:sibling saveLevel:NO ]];
					if(myChain && siblingChain && [siblingChain count]>1 && [myChain count]>1  && ![self areItemsEqual:sibling itemB:item])
					{
						//self means that the
						if([self.parentLevel areItemsEqual:(siblingChain[self.nestDepth - 2]) itemB:(myChain[self.nestDepth - 2])])
						{
							//self means the parents are same
							[self removeSelectedItem:sibling];
						}
					}
				}
			}
		}
	}
	if(self.grid.enableSelectionCascade && self.nextLevel)
	{
		[self.nextLevel getItemsInSelectionHierarchy:item recurse:YES inNestDepth:self.nestDepth retVal:nil clear:YES getUnSelected:NO ];

	}
}

- (NSString *)getCheckBoxStateBasedOnExclusion:(NSObject *)item useBubble:(BOOL)useBubble checkDisabled:(BOOL)checkDisabled {
	//if explicitly checked, return checked
	//if explicitly unselected, return unchecked
	//if enableSelectionCascade, and is parent Selected, return parent.state
	//if enableSelectionBubble
	NSString* state=self.grid.selectAllState;
    //next version NSInvocation or method block

//	if(checkDisabled&&self.rowDisabledFunction!=nil && [self rowDisabledFunction:nil :item])
//	{
//		return [FLXSTriStateCheckBox STATE_UNCHECKED];
//	}
//	if(checkDisabled&&self.rowSelectableFunction!=nil && ![self rowSelectableFunction:nil :item])
//	{
//		return [FLXSTriStateCheckBox STATE_UNCHECKED];
//	}
	if([self isItemSelected:item useExclusion:NO ])
	{
		state=[FLXSTriStateCheckBox STATE_CHECKED];
	}
	else if([self isItemUnSelected:item])
	{
		state=[FLXSTriStateCheckBox STATE_UNCHECKED];
	}
	else if(self.grid.enableSelectionCascade&&self.parentLevel)
	{
		NSObject* parent= [self.grid getParent:item level:self];
		if(parent)
		{
			state = [self.parentLevel getCheckBoxStateBasedOnExclusion:parent useBubble:NO checkDisabled:NO ];
		}
	}
	if(self.grid.enableSelectionBubble && self.nextLevel && useBubble)
	{
		{
			//get next level children state
			float childrenCount=[self getNumChildren:item];
			if(childrenCount==0)
			{
				//whatever we inherited.
			}
			else
			{
				float checkCount=0;
				float unCheckCount=0;
//				float middleCount=0;
				checkCount=[[self.nextLevel getItemsInSelectionHierarchy:item recurse:NO inNestDepth:self.nestDepth retVal:nil clear:NO getUnSelected:NO ] count];
				//explicit check count
				unCheckCount=[[self.nextLevel getItemsInSelectionHierarchy:item recurse:NO inNestDepth:self.nestDepth retVal:nil clear:NO getUnSelected:YES ] count];
				//explicit  uncheck count
				if(self.nextLevel.enableSingleSelect)
				{
					if(checkCount>0)
						state = [FLXSTriStateCheckBox STATE_CHECKED];
					else
state = [FLXSTriStateCheckBox STATE_UNCHECKED];
				}
				else if(unCheckCount==childrenCount)
				{
					state = [FLXSTriStateCheckBox STATE_UNCHECKED];
				}
				else if(checkCount==childrenCount)
				{
					state = [FLXSTriStateCheckBox STATE_CHECKED];
				}
				else if(checkCount==0 && unCheckCount==0)
				{
					//inherited
				}
				else if(self.grid.enableTriStateCheckbox && (checkCount || unCheckCount))
				{
					state = [FLXSTriStateCheckBox STATE_MIDDLE];
				}
			}
		}
	}
	return state;
     return  nil;
}

-(BOOL)isItemUnSelected:(NSObject*)item
{
	if(self.selectedKeyField)
	{
        id itemKey = [FLXSExtendedUIUtils resolveExpression:item expression:self.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];
		for(NSObject* unselectedItem in self.unSelectedObjects)
		{
			NSObject* unselectedKey= [FLXSExtendedUIUtils resolveExpression:unselectedItem expression:self.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];
			if([unselectedKey isEqual: itemKey])
			{
				return YES;
			}
		}
		return NO;
	}
	else
return [self.selectedObjects containsObject:item];
     return  NO;
}

-(int)getNumChildren:(NSObject*)item
{
//	float numChildren=0;
	if((![FLXSUIUtils nullOrEmpty: self.childrenCountField]))
	{
        //[return FLXSExtendedUIUtils resolveExpression:item :childrenCountField] as float;

       		return (int)[((NSNumber*) [FLXSExtendedUIUtils resolveExpression:item expression:self.childrenCountField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ]) integerValue];
	}
	for(FLXSItemLoadInfo* loadingItem in self.grid.bodyContainer.loadedItems)
	{
		if([loadingItem isEqual:item levelToCompare:self useSelectedKeyField:(self.selectedKeyField.length > 0)])
		{
			return loadingItem.totalRecords;
		}
	}
     return  0;
}


- (NSArray *)getItemsInSelectionHierarchy:(NSObject *)parent recurse:(BOOL)recurse inNestDepth:(float)inNestDepth retVal:(NSMutableArray *)retVal clear:(BOOL)clear getUnSelected:(BOOL)getUnSelected {
	if(!retVal)
	{
		retVal=[[ NSMutableArray alloc] init];
	}
    NSMutableArray* toClearSobj=[[NSMutableArray alloc] init];
//var toClearUSobj:Array= [[NSMutableArray alloc] init]
    NSMutableArray *toClearUSobj = [[NSMutableArray alloc]init];
	FLXSFlexDataGridColumnLevel* lvl;
	for(NSObject* item in getUnSelected?self.unSelectedObjects:self.selectedObjects)
	{
		NSMutableArray* chain=self.grid.selectionChain[[self getItemKey:item saveLevel:NO ]];
		if(chain==nil)return retVal;
		NSObject* itemAtMyLevel= [chain objectAtIndex:inNestDepth-1];
		lvl=[self.grid getLevel:inNestDepth];
		if([lvl areItemsEqual:itemAtMyLevel itemB:parent])
		{
			[retVal addObject:item];
			[toClearSobj addObject:item];
		}
	}
	if(clear)
	{
		for(id item in self.unSelectedObjects)
		{
		NSMutableArray*	chain=self.grid.selectionChain[[self getItemKey:item saveLevel:NO ]];
		NSObject* itemAtMyLevel= [chain objectAtIndex:inNestDepth-1];
			lvl=[self.grid getLevel:inNestDepth];
			if([lvl areItemsEqual:itemAtMyLevel itemB:parent])
			{
				[toClearUSobj addObject:item];
			}
		}
		for(id item in toClearSobj)
		{
			[self.selectedObjects removeObjectAtIndex:([self.selectedObjects indexOfObject:item])];
		}
		for(id item in toClearUSobj)
		{
			[self.unSelectedObjects removeObjectAtIndex:([self.unSelectedObjects indexOfObject:item])];
		}
	}
	if(recurse && self.nextLevel)
	{
		[self.nextLevel getItemsInSelectionHierarchy:parent recurse:recurse inNestDepth:inNestDepth retVal:retVal clear:clear getUnSelected:getUnSelected];

    }
	return retVal;
}

-(NSObject*)selectedItem
{
	return [self.selectedObjects count]>0?[self.selectedObjects objectAtIndex:0]:self.nextLevel?self.nextLevel.selectedItem:nil;
} 
-(void)grid:(FLXSFlexDataGrid*)value
{
	self.grid = value;
 
}

-(void)calculateHeaderHeights
{
	self.calculatedSumHeaderAndColumnGroupHeights=0;
	if(self.userDefinedHeaderHeight==-1)
	{
		self.userDefinedHeaderHeight = self.headerHeight;
	}
	if(self.headerVisible)
	{
		for(FLXSFlexDataGridColumn* col in [self getVisibleColumns:nil])
		{
			col.calculatedHeaderHeight=-1;
		}
		if([FLXSFlexDataGrid measurerText].superview==nil)
			[self.grid addChild:[FLXSFlexDataGrid measurerText]];
		self.grid.bodyContainer.variableRowHeightRenderers= [[FLXSKeyValuePairCollection alloc] init];
		float ht=self.minHeaderHeight;
		for(FLXSFlexDataGridColumn * col in self.flowHeaderColumns)
		{
			float paddingLeft =[[col getStyleValue:(@"headerPaddingLeft")] floatValue];
			float paddingTop = [[col getStyleValue:(@"headerPaddingTop")] floatValue];
			float paddingRight = [[col getStyleValue:(@"headerPaddingRight")] floatValue];
			float paddingBottom = [[col getStyleValue:(@"headerPaddingBottom")] floatValue];
			//paddingLeft+=col.enableHierarchicalNestIndent?level.maxPaddingCellWidth:0;
			float colHt= [self.grid measureCellHeight:col paddingLeft:paddingLeft paddingRight:paddingRight paddingTop:paddingTop paddingBottom:paddingBottom itemRenderer:col.headerRenderer ht:0 text:col.headerText item:nil style:([self getStyleValue:(@"headerStyleName")])];
			col.calculatedHeaderHeight=colHt;
			ht=MAX(ht,colHt);
		}
//		for(FLXSFlexDataGridColumnGroup* colg in self.flowHeaderColumnGroups)
//		{
//			float cgpaddingLeft = [[colg.startColumn getStyleValue:(@"columnGroupPaddingLeft")] floatValue];
//			float cgpaddingTop = [[colg.startColumn getStyleValue:(@"columnGroupPaddingTop")] floatValue];
//			float cgpaddingRight = [[colg.startColumn getStyleValue:(@"columnGroupPaddingRight")] floatValue];
//			float cgpaddingBottom = [[colg.startColumn getStyleValue:(@"columnGroupPaddingBottom")] floatValue];
//			float cgHeight = 25;
//            [self.grid measureCellHeight:colg paddingLeft:cgpaddingLeft paddingRight:cgpaddingRight paddingTop:cgpaddingTop paddingBottomFLXS:cgpaddingBottom itemRenderer:colg.headerRenderer ht:0 text:colg.headerText item:nil style:([self getStyleValue:(@"columnGroupStyleName")])];
//			colg.calculatedHeight=cgHeight;
//		}
		[self.grid.bodyContainer clearVariableRowHeightRenderers];
		if([FLXSFlexDataGrid measurerText].superview!=nil){
            [[FLXSFlexDataGrid measurerText] removeFromSuperview];
        }
	}
}

-(float)sumHeaderAndColumnGroupHeights
{
	if(!self.headerVisible)return 0;
	if(self.userDefinedHeaderHeight==-1)
	{
		[self calculateHeaderHeights];
	}
	if(self.calculatedSumHeaderAndColumnGroupHeights)
		return self.calculatedSumHeaderAndColumnGroupHeights;
	float maxHt=0;
	float baseHeaderHeight= MAX(self.userDefinedHeaderHeight,self.minHeaderHeight);
	for(FLXSFlexDataGridColumn* col in [self getVisibleColumns:nil])
	{
		float ht=MAX(col.calculatedHeaderHeight,baseHeaderHeight);
		FLXSFlexDataGridColumnGroup* cg = col.columnGroup;
		while(cg)
		{
			ht += cg.calculatedHeight;
			cg=cg.parentGroup;
		}
		maxHt = MAX(ht ,maxHt);
	}
    self.calculatedSumHeaderAndColumnGroupHeights=maxHt;
	return maxHt;
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
-(void)dispatchEvent:(FLXSEvent*)event
{
    if([event isKindOfClass:[FLXSFlexDataGridEvent class]]|| [event isKindOfClass:[FLXSExtendedFilterPageSortChangeEvent class]])
    {
        [self.grid dispatchEvent:event];
    }

    [FLXSUIUtils dispatchEvent:event
                           withSender:self];
}

//End FLXSIEventDispatcher methods
- (id)getStyle:(NSString *)prop {
    if([self respondsToSelector:NSSelectorFromString(prop)])
        return [self valueForKey:prop];
    return nil;
}

- (void)setStyle:(NSString *)prop value:(id)value {
    if([self respondsToSelector:NSSelectorFromString(prop)])
        [self setValue:value forKey:prop];
}

+ (FLXSClassFactory*)static_FLXSFlexDataGridExpandCollapseCell
{
    if(static_FLXSFlexDataGridExpandCollapseCell==nil){
        static_FLXSFlexDataGridExpandCollapseCell= [[FLXSClassFactory alloc] initWithClass:[FLXSFlexDataGridExpandCollapseCell class] andProperties:nil ];
    }
    return static_FLXSFlexDataGridExpandCollapseCell;
}
+ (FLXSClassFactory*)static_FLXSFlexDataGridExpandCollapseHeaderCell
{
    if(static_FLXSFlexDataGridExpandCollapseHeaderCell==nil){
        static_FLXSFlexDataGridExpandCollapseHeaderCell= [[FLXSClassFactory alloc] initWithClass:[FLXSFlexDataGridExpandCollapseHeaderCell class] andProperties:nil ];
    }
    return static_FLXSFlexDataGridExpandCollapseHeaderCell;

}
+ (FLXSClassFactory*)static_FLXSFlexDataGridPaddingCell
{
    if(static_FLXSFlexDataGridPaddingCell==nil){
        static_FLXSFlexDataGridPaddingCell= [[FLXSClassFactory alloc] initWithClass:[FLXSFlexDataGridPaddingCell class] andProperties:nil ];
    }
    return static_FLXSFlexDataGridPaddingCell;
}
+ (FLXSClassFactory*)static_FLXSFlexDataGridPagerCell
{
    if(static_FLXSFlexDataGridPagerCell==nil){
        static_FLXSFlexDataGridPagerCell= [[FLXSClassFactory alloc] initWithClass:[FLXSFlexDataGridPagerCell class] andProperties:nil ];
    }
    return static_FLXSFlexDataGridPagerCell;
}
+ (FLXSClassFactory*)static_FLXSFlexDataGridPager
{
    if(static_FLXSFlexDataGridPagerCell==nil){
        static_FLXSFlexDataGridPagerCell= [[FLXSClassFactory alloc] initWithClass:[FLXSPagerControlAS class] andProperties:nil ];
    }
    return static_FLXSFlexDataGridPagerCell;
}
+ (FLXSClassFactory*)static_FLXSFlexDataGridPagerAS
{
    if(static_FLXSFlexDataGridPagerAS==nil){
        static_FLXSFlexDataGridPagerAS= [[FLXSClassFactory alloc] initWithClass:[FLXSPagerControlAS class] andProperties:nil ];
    }
    return static_FLXSFlexDataGridPagerAS;
}
+ (NSArray*)static_columnProps
{
	return static_columnProps;
}
@end

