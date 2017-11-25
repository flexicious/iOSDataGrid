#import "FLXSColumnHeaderOperationBehavior.h"
#import "FLXSToolbarAction.h"
#import "FLXSConstants.h"
#import "FLXSPagerControlAS.h"
#import "FLXSFlexDataGridHeaderCell.h"
#import "FLXSFlexDataGridColumn.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSFlexDataGridBodyContainer.h"
#import "FLXSFilterSort.h"
#import "FLXSFlexDataGridColumnGroup.h"

static UIImage* iconsortDescending;
static UIImage* iconHideColumn;
static UIImage* iconSizeToFit;
static UIImage* iconSizeColToFit;
static UIImage* iconswapsort;
static UIImage* iconaddtosort;
static UIImage* iconremovefromsort;
static UIImage* iconremoveallsorts;
static UIImage* iconsortsettings;
static UIImage* iconunlock;
static UIImage* iconscrollLeft;
static UIImage* iconscrollRight;
static FLXSToolbarAction* COL_HEADER_SORT_ASCENDING_ACTION;
static FLXSToolbarAction* COL_HEADER_SORT_DESCENDING_ACTION ;//
static FLXSToolbarAction* COL_HEADER_ADD_TO_SORT_ACTION; 
static FLXSToolbarAction* COL_HEADER_REMOVE_FROM_SORT_ACTION; 
static FLXSToolbarAction* COL_HEADER_SWAP_SORT_ORDER_ACTION; 
static FLXSToolbarAction* COL_HEADER_REMOVE_SORT_ACTION ;
static FLXSToolbarAction* COL_HEADER_SORT_SETTINGS_ACTION;
static FLXSToolbarAction* COL_HEADER_CLEAR_FILTER_ACTION ;
static FLXSToolbarAction* COL_HEADER_HIDE_COLUMN_ACTION; 
static FLXSToolbarAction* COL_HEADER_SHOW_HIDE_COLUMNS_ACTION; 
static FLXSToolbarAction* COL_HEADER_SIZE_COL_TO_FIT_ACTION; 
static FLXSToolbarAction* COL_HEADER_SIZE_ALL_COLS_TO_FIT_ACTION;
static FLXSToolbarAction* COL_HEADER_LEFT_LOCK_COLUMN_ACTION ;
static FLXSToolbarAction* COL_HEADER_RIGHT_LOCK_COLUMN_ACTION;
static FLXSToolbarAction* COL_HEADER_UNLOCK_COLUMN_ACTION ;
static NSArray* DEFAULT_COLUMN_HEADER_OPERATIONS;

@implementation FLXSColumnHeaderOperationBehavior {
 
}


@synthesize grid = _grid;
@synthesize currentHeaderCell = _currentHeaderCell;
@synthesize hideDisabledOptions = _hideDisabledOptions;
@synthesize dropdownIcon = _dropdownIcon;
@synthesize triggerCell = _triggerCell;
@synthesize menu = _menu;
@synthesize dropDownIconRenderer = _dropDownIconRenderer;
@synthesize enabled = _enabled;

+ (BOOL)isEnabledFunction:(FLXSToolbarAction *)action grid:(FLXSFlexDataGrid *)grid {
	FLXSFlexDataGridColumn* col=grid.columnHeaderOperationBehavior.currentHeaderCell.columnFLXS;
	if([action.code isEqual:[COL_HEADER_SORT_ASCENDING_ACTION code]]
		||[action.code isEqual:[COL_HEADER_SORT_DESCENDING_ACTION code]])
	{
		return col.sortable;
	}
	else if([action.code isEqual: [COL_HEADER_ADD_TO_SORT_ACTION code] ])
	{
		return grid.enableMultiColumnSort && [[FLXSUIUtils extractPropertyValues:col.level.currentSorts propertyToExtract:(@"sortColumn")] indexOfObject:col.sortField]==NSNotFound;
	}
	else if([action.code isEqual:[COL_HEADER_REMOVE_FROM_SORT_ACTION code]]|| [action.code isEqual:[COL_HEADER_SWAP_SORT_ORDER_ACTION code]])
	{
		return grid.enableMultiColumnSort && [[FLXSUIUtils extractPropertyValues:col.level.currentSorts propertyToExtract:(@"sortColumn")] indexOfObject:col.sortField]==0;
	}
	else if([action.code isEqual:[COL_HEADER_REMOVE_SORT_ACTION code]])
	{
		return grid.enableMultiColumnSort && [col.level.currentSorts count] >0;
	}
	else if([action.code isEqual:[COL_HEADER_SORT_SETTINGS_ACTION code]])
	{
		return grid.enableMultiColumnSort;
	}
	else if([action.code isEqual:[COL_HEADER_CLEAR_FILTER_ACTION code]])
	{
		return col.level.nestDepth==1 && grid.enableFilters && [grid getFilterValue:col.searchField]!=nil;
	}
	else if([action.code isEqual:[COL_HEADER_HIDE_COLUMN_ACTION code]])
	{
		return col.level.nestDepth==1 ;
	}
	else if([action.code isEqual:[COL_HEADER_SHOW_HIDE_COLUMNS_ACTION code]])
	{
		return col.level.nestDepth==1 ;
	}
	else if([action.code isEqual:[COL_HEADER_SIZE_COL_TO_FIT_ACTION code]])
	{
		return !col.isLocked;
	}
	else if([action.code isEqual: [COL_HEADER_SIZE_ALL_COLS_TO_FIT_ACTION code]])
	{
		return YES;
	}
	else if([action.code isEqual:[COL_HEADER_LEFT_LOCK_COLUMN_ACTION code]])
	{
		return col.level.nestDepth==1 && !grid.forceColumnsToFitVisibleArea
                && ![col.columnLockMode isEqual:[FLXSFlexDataGridColumn LOCK_MODE_LEFT]] && (col.columnGroup ==nil);
	}
	else if([action.code isEqual:[COL_HEADER_RIGHT_LOCK_COLUMN_ACTION code]])
	{
		return col.level.nestDepth==1 && !grid.forceColumnsToFitVisibleArea
                && ![col.columnLockMode isEqual:[FLXSFlexDataGridColumn LOCK_MODE_RIGHT]] && (col.columnGroup ==nil);
	}
	else if([action.code isEqual:[COL_HEADER_UNLOCK_COLUMN_ACTION code]])
	{
		return col.level.nestDepth==1 && !grid.forceColumnsToFitVisibleArea && ![col.columnLockMode isEqual:[FLXSFlexDataGridColumn LOCK_MODE_NONE]]
                && (col.columnGroup ==nil);
	}
	return YES;
}

+ (BOOL)onToolbarActionExecuted:(FLXSToolbarAction *)action grid:(FLXSFlexDataGrid *)grid {
	FLXSFlexDataGridColumn* col=grid.columnHeaderOperationBehavior.currentHeaderCell.columnFLXS;
	FLXSFlexDataGridHeaderCell* cell = grid.columnHeaderOperationBehavior.currentHeaderCell;
	[grid.columnHeaderOperationBehavior killIcon];
	FLXSFlexDataGridContainerBase* container = cell.level.nestDepth==1?(FLXSFlexDataGridContainerBase*)grid.headerContainer:(FLXSFlexDataGridContainerBase*)grid.bodyContainer;
	if([action.code isEqualToString:[COL_HEADER_SORT_ASCENDING_ACTION code] ] )
	{
		[container onHeaderCellClicked:cell triggerEvent:nil isMsc:NO useMsc:NO direction:(@"ascending")];
	}
	else if ([action.code isEqualToString: [COL_HEADER_SORT_DESCENDING_ACTION code]])
	{
		[container onHeaderCellClicked:cell triggerEvent:nil isMsc:NO useMsc:NO direction:(@"descending")];
	}
	else if([action.code isEqual:[COL_HEADER_ADD_TO_SORT_ACTION code]])
	{
		[container onHeaderCellClicked:cell triggerEvent:nil isMsc:YES useMsc:YES direction:(@"ascending")];
	}
	else if([action.code isEqual:[COL_HEADER_SWAP_SORT_ORDER_ACTION code]])
	{
		FLXSFilterSort* srt = (FLXSFilterSort* ) [col.level getSortIndex:cell.columnFLXS return1:YES returnSortObject:YES ];
		[container onHeaderCellClicked:cell triggerEvent:nil isMsc:YES useMsc:YES direction:(!srt || !srt.isAscending ? @"ascending" : @"descending")];
	}
	else if([action.code isEqual:[COL_HEADER_REMOVE_FROM_SORT_ACTION code]])
	{
		FLXSFilterSort* srt1 = (FLXSFilterSort* ) [col.level getSortIndex:cell.columnFLXS return1:YES returnSortObject:YES ];
		if(srt1)
		{
			[col.level.currentSorts removeObjectAtIndex:([col.level.currentSorts indexOfObject:srt1])];
			[grid rebuildHeader];
			[grid rebuildBody: NO];
		}
	}
	else if([action.code isEqual:[COL_HEADER_REMOVE_SORT_ACTION code]])
	{
		[grid removeAllSorts];
	}
	else if([action.code isEqual:[COL_HEADER_SORT_SETTINGS_ACTION code]])
	{
		[grid multiColumnSortShowPopup];
	}
	else if([action.code isEqual:[COL_HEADER_CLEAR_FILTER_ACTION code]])
	{
		[grid clearFilterByField:col.searchField];
	}
	else if([action.code isEqual:[COL_HEADER_HIDE_COLUMN_ACTION code]])
	{
		col.visible=NO;
	}
	else if([action.code isEqual:[COL_HEADER_SHOW_HIDE_COLUMNS_ACTION code]])
	{
        //next version v1.2
//		NSObject* popup=[grid.popupFactorySettingsPopup generateInstance];
//		[FLXSUIUtils addPopUp:popup as IFlexDisplayObject :grid as DisplayObject :YES :nil :nil :(grid.useModuleFactory?grid.moduleFactory:nil)];
//		popup.grid=grid;
	}
	else if([action.code isEqual:[COL_HEADER_SIZE_COL_TO_FIT_ACTION code]])
	{
		col.columnWidthMode=[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_FIT_TO_CONTENT];
		[grid reDraw];
	}
	else if([action.code isEqual:[COL_HEADER_SIZE_ALL_COLS_TO_FIT_ACTION code]])
	{
		NSArray* leftLockedCols=col.level.leftLockedColumns;
		NSArray* rightLockedCols=col.level.rightLockedColumns;
		NSArray* lockedCols= [col.level getVisibleColumns:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_LEFT],[FLXSFlexDataGridColumn LOCK_MODE_RIGHT],nil]];
		FLXSFlexDataGridColumn* oCol;
		for(oCol in lockedCols)
		{
			oCol.columnLockMode=[FLXSFlexDataGridColumn LOCK_MODE_NONE];
		}
		for(oCol in col.level.unLockedColumns)
		{
			if(!([oCol isKindOfClass:[FLXSFlexDataGridCheckBoxColumn class] ]) && ![oCol.columnWidthMode isEqual:[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_FIXED]])
				oCol.columnWidthMode=[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_FIT_TO_CONTENT];
		}
		[grid reDraw];
		if([lockedCols count] >0)
		{

			for(oCol in leftLockedCols)
			{
				oCol.columnLockMode=[FLXSFlexDataGridColumn LOCK_MODE_LEFT];
			}
			for(oCol in rightLockedCols)
			{
				oCol.columnLockMode=[FLXSFlexDataGridColumn LOCK_MODE_RIGHT];
			}
			[grid reDraw];
			if([rightLockedCols count] >0)
			{
				[grid reDraw];
			}
		}
	}
	else if([action.code isEqual:[COL_HEADER_LEFT_LOCK_COLUMN_ACTION code]])
	{
		col.columnLockMode=[FLXSFlexDataGridColumn LOCK_MODE_LEFT];
		[grid reDraw];
	}
	else if([action.code isEqual:[COL_HEADER_RIGHT_LOCK_COLUMN_ACTION code]])
	{
		col.columnLockMode=[FLXSFlexDataGridColumn LOCK_MODE_RIGHT];
		[grid reDraw];
	}
	else if([action.code isEqual:[COL_HEADER_UNLOCK_COLUMN_ACTION code]])
	{
		col.columnLockMode=[FLXSFlexDataGridColumn LOCK_MODE_NONE];
		[grid reDraw];
	}
	return YES;
}

-(id)initWithGrid:(FLXSFlexDataGrid*)grid
{
	self = [super init];
	if (self)
	{
//        COL_HEADER_SORT_ASCENDING_ACTION;
        if(!COL_HEADER_SORT_DESCENDING_ACTION)
            COL_HEADER_SORT_DESCENDING_ACTION = [[FLXSToolbarAction alloc] initWithName:FLXSConstants.COL_HEADER_SORT_DESCENDING
                                                                               andLevel:-1
                                                                                andCode:FLXSConstants.COL_HEADER_SORT_DESCENDING
                                                                             andToolTip:FLXSConstants.COL_HEADER_SORT_DESCENDING_TOOLTIP
                                                                                andIcon:FLXSColumnHeaderOperationBehavior.iconsortDescending
                                                                     andSeparatorBefore:NO
                                                                      andSeparatorAfter:NO
                                                                          andSubActions:nil
                                                                   andRequiresSelection:NO
                                                             andRequiresSingleSelection:NO
                                                                     andDisabledIconUrl:nil
                                                                     andEnabledFunction:@"isEnabledFunction:"
                                                                    andExecutedFunction:@"onToolbarActionExecuted:"
                                                                            andDelegate:self];


        if(!COL_HEADER_SORT_DESCENDING_ACTION)
            COL_HEADER_ADD_TO_SORT_ACTION = [[FLXSToolbarAction alloc] initWithName:FLXSConstants.COL_HEADER_ADD_TO_SORT
                                                                           andLevel:-1
                                                                            andCode:FLXSConstants.COL_HEADER_ADD_TO_SORT
                                                                         andToolTip:FLXSConstants.COL_HEADER_ADD_TO_SORT_TOOLTIP
                                                                            andIcon:FLXSColumnHeaderOperationBehavior.iconaddtosort
                                                                 andSeparatorBefore:YES
                                                                  andSeparatorAfter:NO
                                                                      andSubActions:nil
                                                               andRequiresSelection:NO
                                                         andRequiresSingleSelection:NO
                                                                 andDisabledIconUrl:nil
                                                                 andEnabledFunction:@"isEnabledFunction:"
                                                                andExecutedFunction:@"onToolbarActionExecuted:"
                                                                        andDelegate:self];
        if(!COL_HEADER_REMOVE_FROM_SORT_ACTION)
            COL_HEADER_REMOVE_FROM_SORT_ACTION = [[FLXSToolbarAction alloc] initWithName:FLXSConstants.COL_HEADER_REMOVE_FROM_SORT
                                                                                andLevel:-1
                                                                                 andCode:FLXSConstants.COL_HEADER_REMOVE_FROM_SORT
                                                                              andToolTip:FLXSConstants.COL_HEADER_REMOVE_FROM_SORT_TOOLTIP
                                                                                 andIcon:FLXSColumnHeaderOperationBehavior.iconremovefromsort
                                                                      andSeparatorBefore:NO
                                                                       andSeparatorAfter:NO
                                                                           andSubActions:nil
                                                                    andRequiresSelection:NO
                                                              andRequiresSingleSelection:NO
                                                                      andDisabledIconUrl:nil
                                                                      andEnabledFunction:@"isEnabledFunction:"
                                                                     andExecutedFunction:@"onToolbarActionExecuted:"
                                                                             andDelegate:self];
        
        if(!COL_HEADER_SWAP_SORT_ORDER_ACTION)
            COL_HEADER_SWAP_SORT_ORDER_ACTION = [[FLXSToolbarAction alloc] initWithName:FLXSConstants.COL_HEADER_SWAP_SORT_ORDER
                                                                               andLevel:-1
                                                                                andCode:FLXSConstants.COL_HEADER_SWAP_SORT_ORDER
                                                                             andToolTip:FLXSConstants.COL_HEADER_SWAP_SORT_ORDER_TOOLTIP
                                                                                andIcon:FLXSColumnHeaderOperationBehavior.iconswapsort
                                                                     andSeparatorBefore:NO
                                                                      andSeparatorAfter:NO
                                                                          andSubActions:nil
                                                                   andRequiresSelection:NO
                                                             andRequiresSingleSelection:NO
                                                                     andDisabledIconUrl:nil
                                                                     andEnabledFunction:@"isEnabledFunction:"
                                                                    andExecutedFunction:@"onToolbarActionExecuted:"
                                                                            andDelegate:self];
        if(!COL_HEADER_REMOVE_SORT_ACTION)
            COL_HEADER_REMOVE_SORT_ACTION = [[FLXSToolbarAction alloc] initWithName:FLXSConstants.COL_HEADER_REMOVE_SORT
                                                                           andLevel:-1
                                                                            andCode:FLXSConstants.COL_HEADER_REMOVE_SORT
                                                                         andToolTip:FLXSConstants.COL_HEADER_REMOVE_SORT_TOOLTIP
                                                                            andIcon:FLXSColumnHeaderOperationBehavior.iconremoveallsorts
                                                                 andSeparatorBefore:NO
                                                                  andSeparatorAfter:NO
                                                                      andSubActions:nil
                                                               andRequiresSelection:NO
                                                         andRequiresSingleSelection:NO
                                                                 andDisabledIconUrl:nil
                                                                 andEnabledFunction:@"isEnabledFunction:"
                                                                andExecutedFunction:@"onToolbarActionExecuted:"
                                                                        andDelegate:self];

        if(!COL_HEADER_SORT_SETTINGS_ACTION)
            COL_HEADER_SORT_SETTINGS_ACTION = [[FLXSToolbarAction alloc] initWithName:FLXSConstants.COL_HEADER_SORT_SETTINGS
                                                                             andLevel:-1
                                                                              andCode:FLXSConstants.COL_HEADER_SORT_SETTINGS
                                                                           andToolTip:FLXSConstants.COL_HEADER_SORT_SETTINGS_TOOLTIP
                                                                              andIcon:FLXSColumnHeaderOperationBehavior.iconsortsettings
                                                                   andSeparatorBefore:NO
                                                                    andSeparatorAfter:NO
                                                                        andSubActions:nil
                                                                 andRequiresSelection:NO
                                                           andRequiresSingleSelection:NO
                                                                   andDisabledIconUrl:nil
                                                                   andEnabledFunction:@"isEnabledFunction:"
                                                                  andExecutedFunction:@"onToolbarActionExecuted:"
                                                                          andDelegate:self];
        if(!COL_HEADER_CLEAR_FILTER_ACTION)
            COL_HEADER_CLEAR_FILTER_ACTION = [[FLXSToolbarAction alloc] initWithName:FLXSConstants.COL_HEADER_CLEAR_FILTER
                                                                            andLevel:-1
                                                                             andCode:FLXSConstants.COL_HEADER_CLEAR_FILTER
                                                                          andToolTip:FLXSConstants.COL_HEADER_CLEAR_FILTER_TOOLTIP
                                                                             andIcon:FLXSPagerControlAS.iconFilterClear
                                                                  andSeparatorBefore:YES
                                                                   andSeparatorAfter:NO
                                                                       andSubActions:nil
                                                                andRequiresSelection:NO
                                                          andRequiresSingleSelection:NO
                                                                  andDisabledIconUrl:nil
                                                                  andEnabledFunction:@"isEnabledFunction:"
                                                                 andExecutedFunction:@"onToolbarActionExecuted:"
                                                                         andDelegate:self];
        if(!COL_HEADER_HIDE_COLUMN_ACTION)
            COL_HEADER_HIDE_COLUMN_ACTION = [[FLXSToolbarAction alloc] initWithName:FLXSConstants.COL_HEADER_HIDE_COLUMN
                                                                           andLevel:-1
                                                                            andCode:FLXSConstants.COL_HEADER_HIDE_COLUMN
                                                                         andToolTip:FLXSConstants.COL_HEADER_HIDE_COLUMN_TOOLTIP
                                                                            andIcon:FLXSColumnHeaderOperationBehavior.iconHideColumn
                                                                 andSeparatorBefore:YES
                                                                  andSeparatorAfter:NO
                                                                      andSubActions:nil
                                                               andRequiresSelection:NO
                                                         andRequiresSingleSelection:NO
                                                                 andDisabledIconUrl:nil
                                                                 andEnabledFunction:@"isEnabledFunction:"
                                                                andExecutedFunction:@"onToolbarActionExecuted:"
                                                                        andDelegate:self];
        
        if(!COL_HEADER_SHOW_HIDE_COLUMNS_ACTION)
            COL_HEADER_SHOW_HIDE_COLUMNS_ACTION = [[FLXSToolbarAction alloc] initWithName:FLXSConstants.COL_HEADER_SHOW_HIDE_COLUMNS
                                                                                 andLevel:-1
                                                                                  andCode:FLXSConstants.COL_HEADER_SHOW_HIDE_COLUMNS
                                                                               andToolTip:FLXSConstants.COL_HEADER_SHOW_HIDE_COLUMNS_TOOLTIP
                                                                                  andIcon:FLXSPagerControlAS.iconSettings
                                                                       andSeparatorBefore:NO
                                                                        andSeparatorAfter:NO
                                                                            andSubActions:nil
                                                                     andRequiresSelection:NO
                                                               andRequiresSingleSelection:NO
                                                                       andDisabledIconUrl:nil
                                                                       andEnabledFunction:@"isEnabledFunction:"
                                                                      andExecutedFunction:@"onToolbarActionExecuted:"
                                                                              andDelegate:self];
       
        if(!COL_HEADER_SIZE_COL_TO_FIT_ACTION)
            COL_HEADER_SIZE_COL_TO_FIT_ACTION = [[FLXSToolbarAction alloc] initWithName:FLXSConstants.COL_HEADER_SIZE_COL_TO_FIT
                                                                               andLevel:-1
                                                                                andCode:FLXSConstants.COL_HEADER_SIZE_COL_TO_FIT
                                                                             andToolTip:FLXSConstants.COL_HEADER_SIZE_COL_TO_FIT_TOOLTIP
                                                                                andIcon:FLXSColumnHeaderOperationBehavior.iconSizeColToFit
                                                                     andSeparatorBefore:YES
                                                                      andSeparatorAfter:NO
                                                                          andSubActions:nil
                                                                   andRequiresSelection:NO
                                                             andRequiresSingleSelection:NO
                                                                     andDisabledIconUrl:nil
                                                                     andEnabledFunction:@"isEnabledFunction:"
                                                                    andExecutedFunction:@"onToolbarActionExecuted:"
                                                                            andDelegate:self];
        
           
        if(!COL_HEADER_SIZE_ALL_COLS_TO_FIT_ACTION)
            COL_HEADER_SIZE_ALL_COLS_TO_FIT_ACTION = [[FLXSToolbarAction alloc] initWithName:FLXSConstants.COL_HEADER_SIZE_ALL_COLS_TO_FIT
                                                                                    andLevel:-1
                                                                                     andCode:FLXSConstants.COL_HEADER_SIZE_ALL_COLS_TO_FIT
                                                                                  andToolTip:FLXSConstants.COL_HEADER_SIZE_ALL_COLS_TO_FIT_TOOLTIP
                                                                                     andIcon:FLXSColumnHeaderOperationBehavior.iconSizeToFit
                                                                          andSeparatorBefore:NO
                                                                           andSeparatorAfter:NO
                                                                               andSubActions:nil
                                                                        andRequiresSelection:NO
                                                                  andRequiresSingleSelection:NO
                                                                          andDisabledIconUrl:nil
                                                                          andEnabledFunction:@"isEnabledFunction:"
                                                                         andExecutedFunction:@"onToolbarActionExecuted:"
                                                                                 andDelegate:self];
            
            
        if(!COL_HEADER_LEFT_LOCK_COLUMN_ACTION)
            COL_HEADER_LEFT_LOCK_COLUMN_ACTION = [[FLXSToolbarAction alloc] initWithName:FLXSConstants.COL_HEADER_LEFT_LOCK_COLUMN
                                                                                andLevel:-1
                                                                                 andCode:FLXSConstants.COL_HEADER_LEFT_LOCK_COLUMN
                                                                              andToolTip:FLXSConstants.COL_HEADER_LEFT_LOCK_COLUMN_TOOLTIP
                                                                                 andIcon:FLXSColumnHeaderOperationBehavior.iconscrollLeft
                                                                      andSeparatorBefore:YES
                                                                       andSeparatorAfter:NO
                                                                           andSubActions:nil
                                                                    andRequiresSelection:NO
                                                              andRequiresSingleSelection:NO
                                                                      andDisabledIconUrl:nil
                                                                      andEnabledFunction:@"isEnabledFunction:"
                                                                     andExecutedFunction:@"onToolbarActionExecuted:"
                                                                             andDelegate:self];
        
           
        if(!COL_HEADER_RIGHT_LOCK_COLUMN_ACTION)
            COL_HEADER_RIGHT_LOCK_COLUMN_ACTION = [[FLXSToolbarAction alloc] initWithName:FLXSConstants.COL_HEADER_RIGHT_LOCK_COLUMN
                                                                                 andLevel:-1
                                                                                  andCode:FLXSConstants.COL_HEADER_RIGHT_LOCK_COLUMN
                                                                               andToolTip:FLXSConstants.COL_HEADER_RIGHT_LOCK_COLUMN_TOOLTIP
                                                                                  andIcon:FLXSColumnHeaderOperationBehavior.iconscrollRight
                                                                       andSeparatorBefore:NO
                                                                        andSeparatorAfter:NO
                                                                            andSubActions:nil
                                                                     andRequiresSelection:NO
                                                               andRequiresSingleSelection:NO
                                                                       andDisabledIconUrl:nil
                                                                       andEnabledFunction:@"isEnabledFunction:"
                                                                      andExecutedFunction:@"onToolbarActionExecuted:"
                                                                              andDelegate:self];
            
           
        if(!COL_HEADER_UNLOCK_COLUMN_ACTION)
            COL_HEADER_UNLOCK_COLUMN_ACTION = [[FLXSToolbarAction alloc] initWithName:FLXSConstants.COL_HEADER_UNLOCK_COLUMN
                                                                             andLevel:-1
                                                                              andCode:FLXSConstants.COL_HEADER_UNLOCK_COLUMN
                                                                           andToolTip:FLXSConstants.COL_HEADER_UNLOCK_COLUMN_TOOLTIP
                                                                              andIcon:FLXSColumnHeaderOperationBehavior.iconunlock
                                                                   andSeparatorBefore:NO
                                                                    andSeparatorAfter:NO
                                                                        andSubActions:nil
                                                                 andRequiresSelection:NO
                                                           andRequiresSingleSelection:NO
                                                                   andDisabledIconUrl:nil
                                                                   andEnabledFunction:@"isEnabledFunction:"
                                                                  andExecutedFunction:@"onToolbarActionExecuted:"
                                                                          andDelegate:self];
        
            


        self.hideDisabledOptions = NO;
		self.enabled = NO;

		self.grid=grid;
	}
	return self;
}


-(void)onGridMouseOut:(FLXSEvent*)event
{
}

-(void)onCellMouseOver:(FLXSFlexDataGridEvent*)event
{
    //next version v1.2
//	if(!self.enabled || !event.cell.column || event.cell.column.excludeFromSettings || self.grid.headerContainer.columnResizingCell
//		|| self.grid.headerContainer.columnDraggingDragCell)return;
//	if(!(event.triggerEvent is MouseEvent))return;
//	if((event.triggerEvent as MouseEvent).localX > (event.cell.width-6))
//	{
//		return;
//		//self could be a resize.
//	}
//	if(self.dropdownIcon&&self.dropdownIcon.parent)
//	{
//		[self killIcon];
//	}
//	if(event.cell is FLXSFlexDataGridHeaderCell)
//	{
//		self.currentHeaderCell=event.cell as FLXSFlexDataGridHeaderCell;
//		if(self.currentHeaderCell.column.headerMenuActions.length==0)
//		{
//			return;
//		}
//		if(!self.dropdownIcon)
//		{
//			self.dropdownIcon = [dropdownIconRenderer generateInstance];
//			[self.dropdownIcon addEventListener:[MouseEvent CLICK] :onCellMouseClick];
//		}
//		[self.grid addChild:self.dropdownIcon as DisplayObject];
//		Point* pt = [[Point alloc] initWithType:(event.cell.width-20) :0];
//		pt=[event.cell localToGlobal:pt];
//		pt=[event.cell.level.grid globalToLocal:pt];
//		[self.dropdownIcon setActualSize:20 :event.cell.height];
//		[self.dropdownIcon move:([Math min:pt.x :(self.grid.width-20)]-grid.headerSeparatorWidth) :pt.y];
//        [self.dropdownIcon move:MIN(pt.x ,self.grid.width-20)-self.grid.headerSeparatorWidth) :pt.y];
    
//	}
}

-(void)onCellMouseClick:(FLXSEvent*)event
{
//	if(self.menu && self.menu.parent)
//	{
//		[FLXSUIUtils removeChild:self.menu.parent :self.menu];
//		return;
//	}
//	if(!menu)
//	{
//		menu= [[Menu alloc] init];
//		menu.variableRowHeight=YES;
//		menu.styleName = [grid getStyle:(@"columnHeaderMenuStyleName")];
//		[menu addEventListener:[MenuEvent ITEM_CLICK] :onMenuItemClick];
//		menu.itemRenderer = [[FLXSClassFactory alloc] init:TooltipMenuItemRenderer];
//		menu.focusManager = self.grid.focusManager;
//	}
//	Point* pt = [[Point alloc] init:0 :0];
//	pt=[self.dropdownIcon localToGlobal:pt];
//	Array* menuDataProvider= [[NSMutableArray alloc] init]
//	Array* actions=self.currentHeaderCell.column.headerMenuActions;
//	for(ToolbarAction* tba in actions)
//	{
//		if(tba.separatorBefore)
//		{
//			[menuDataProvider addObject:({type:@"separator"})];
//		}
//		NSObject* menuItem = [[NSObject alloc] init];
//		menuItem.label = tba.name;
//		menuItem.toolTip = tba.tooltip;
//		menuItem.icon = tba.iconUrl;
//		menuItem.enabled = [grid isToolbarActionValid:tba :nil :nil];
//		menuItem.action = tba;
//		if(!hideDisabledOptions || menuItem.enabled)
//			[menuDataProvider addObject:menuItem];
//		if(tba.separatorAfter)
//		{
//			[menuDataProvider addObject:({type:@"separator"})];
//		}
//	}
//	menu.dataProviderFLXS = menuDataProvider;
//	menu.width = [Math min:([Math max:150 :self.currentHeaderCell.column.width]) :300];
//	[FLXSUIUtils addPopUp:menu :self.grid :NO];
//	//pt=[self.grid globalToLocal:pt];
//	[menu show:([Math max:0 :(pt.x-menu.width+self.dropdownIcon.width)]) :(pt.y+self.dropdownIcon.height)];
}

-(void)onMenuItemClick:(FLXSEvent*)event
{
    //next version    v1.2
	//FLXSToolbarAction* action = event.item.action;
	//[self.grid runToolbarAction:action :nil :nil];
}

-(void)onCellMouseOut:(FLXSFlexDataGridEvent*)event
{
//	if(!self.enabled)return;
//	if([event.cell isEqual: self.triggerCell])
//	{
//		[self killIcon];
//	}
}

-(void)killIcon
{
    //next version  v1.2
//	if(self.dropdownIcon && self.dropdownIcon.parent)
//	{
//		[self.dropdownIcon.parent removeChild:self.dropdownIcon as DisplayObject];
//	}
//	if(self.menu && self.menu.parent)
//	{
//		[FLXSUIUtils removeChild:self.menu.parent :self.menu];
//	}
}

+ (UIImage*)iconsortDescending
{
	return iconsortDescending;
}
+ (UIImage*)iconHideColumn
{
	return iconHideColumn;
}
+ (UIImage*)iconSizeToFit
{
	return iconSizeToFit;
}
+ (UIImage*)iconSizeColToFit
{
	return iconSizeColToFit;
}
+ (UIImage*)iconswapsort
{
	return iconswapsort;
}
+ (UIImage*)iconaddtosort
{
	return iconaddtosort;
}
+ (UIImage*)iconremovefromsort
{
	return iconremovefromsort;
}
+ (UIImage*)iconremoveallsorts
{
	return iconremoveallsorts;
}
+ (UIImage*)iconsortsettings
{
	return iconsortsettings;
}
+ (UIImage*)iconunlock
{
	return iconunlock;
}
+ (UIImage*)iconscrollLeft
{
	return iconscrollLeft;
}
+ (UIImage*)iconscrollRight
{
	return iconscrollRight;
}
+ (FLXSToolbarAction*)COL_HEADER_SORT_ASCENDING_ACTION
{
	return COL_HEADER_SORT_ASCENDING_ACTION;
}
+ (FLXSToolbarAction*)COL_HEADER_SORT_DESCENDING_ACTION
{
	return COL_HEADER_SORT_DESCENDING_ACTION;
}
+ (FLXSToolbarAction*)COL_HEADER_ADD_TO_SORT_ACTION
{
	return COL_HEADER_ADD_TO_SORT_ACTION;
}
+ (FLXSToolbarAction*)COL_HEADER_REMOVE_FROM_SORT_ACTION
{
	return COL_HEADER_REMOVE_FROM_SORT_ACTION;
}
+ (FLXSToolbarAction*)COL_HEADER_SWAP_SORT_ORDER_ACTION
{
	return COL_HEADER_SWAP_SORT_ORDER_ACTION;
}
+ (FLXSToolbarAction*)COL_HEADER_REMOVE_SORT_ACTION
{
	//return COL_HEADER_REMOVE_SORT_ACTION;
    return nil;
}
+ (FLXSToolbarAction*)COL_HEADER_SORT_SETTINGS_ACTION
{
	//return COL_HEADER_SORT_SETTINGS_ACTION;
    return nil;
}
+ (FLXSToolbarAction*)COL_HEADER_CLEAR_FILTER_ACTION
{
	//return COL_HEADER_CLEAR_FILTER_ACTION;
    return nil;
}
+ (FLXSToolbarAction*)COL_HEADER_HIDE_COLUMN_ACTION
{
	//return COL_HEADER_HIDE_COLUMN_ACTION;
    return nil;
}
+ (FLXSToolbarAction*)COL_HEADER_SHOW_HIDE_COLUMNS_ACTION
{
	//return COL_HEADER_SHOW_HIDE_COLUMNS_ACTION;
    return nil;
}
+ (FLXSToolbarAction*)COL_HEADER_SIZE_COL_TO_FIT_ACTION
{
	//return COL_HEADER_SIZE_COL_TO_FIT_ACTION;
    return nil;
}
+ (FLXSToolbarAction*)COL_HEADER_SIZE_ALL_COLS_TO_FIT_ACTION
{
	return COL_HEADER_SIZE_ALL_COLS_TO_FIT_ACTION;
}
+ (FLXSToolbarAction*)COL_HEADER_LEFT_LOCK_COLUMN_ACTION
{
	return COL_HEADER_LEFT_LOCK_COLUMN_ACTION;
}
+ (FLXSToolbarAction*)COL_HEADER_RIGHT_LOCK_COLUMN_ACTION
{
	return COL_HEADER_RIGHT_LOCK_COLUMN_ACTION;
}
+ (FLXSToolbarAction*)COL_HEADER_UNLOCK_COLUMN_ACTION
{
	return COL_HEADER_UNLOCK_COLUMN_ACTION;
}
+ (NSArray*)DEFAULT_COLUMN_HEADER_OPERATIONS
{
	return DEFAULT_COLUMN_HEADER_OPERATIONS;
}
@end

