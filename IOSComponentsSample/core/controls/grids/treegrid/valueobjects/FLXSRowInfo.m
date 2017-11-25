#import "FLXSRowInfo.h"
#import "FLXSRowPositionInfo.h"
#import "FLXSComponentInfo.h"
#import "FLXSIFlexDataGridCell.h"
#import "FLXSIExpandCollapseComponent.h"
#import "FLXSExpandCollapseIcon.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSFlexDataGridBodyContainer.h"
#import "FLXSFilterContainerImpl.h"
#import "FLXSFlexDataGridPaddingCell.h"

@implementation FLXSRowInfo

@synthesize height;
@synthesize y=_y;
@synthesize dataGrid;
@synthesize cells;
@synthesize rowPositionInfo;
@synthesize hasScrollBarPad;
@synthesize hasNestPad;
@synthesize hasRightLockPad;
@synthesize hasDisclosure;

- (id)initWithHeight:(float)heightIn andY:(float)yIn andGrid:(FLXSFlexDataGrid *)grid {
	self = [super init];
	if (self)
	{
		self.cells = [[NSMutableArray alloc] init];
		self.hasScrollBarPad = NO;
        self.hasNestPad = NO;
        self.hasRightLockPad = NO;
        self.hasDisclosure = NO;

		self.height=heightIn;
		self.y=yIn;
		self.dataGrid=grid;
	}
	return self;
}


-(NSObject*)data
{
	return self.rowPositionInfo?self.rowPositionInfo.rowData:nil;
}

-(BOOL)isHeaderRow
{
	return self.rowPositionInfo.rowType==[FLXSRowPositionInfo ROW_TYPE_HEADER];
}

-(BOOL)isColumnGroupRow
{
	return self.rowPositionInfo.rowType==[FLXSRowPositionInfo ROW_TYPE_COLUMN_GROUP];
}

-(BOOL)isFooterRow
{
	return self.rowPositionInfo.rowType==[FLXSRowPositionInfo ROW_TYPE_FOOTER];
}

-(BOOL)isPagerRow
{
	return self.rowPositionInfo.rowType==[FLXSRowPositionInfo ROW_TYPE_PAGER];
}

-(BOOL)isFilterRow
{
	return self.rowPositionInfo.rowType==[FLXSRowPositionInfo ROW_TYPE_FILTER];
}

-(BOOL)isRendererRow
{
	return self.rowPositionInfo?self.rowPositionInfo.isRendererRow:NO;
}

-(BOOL)isFillRow
{
	return self.rowPositionInfo.rowType==[FLXSRowPositionInfo ROW_TYPE_FILL];
}

-(BOOL)isDataRow
{
	return !self.isChromeRow;
}

-(BOOL)isChromeRow
{
	int rt=self.rowPositionInfo.rowType;
	//return isHeaderRow || isFooterRow  || isPagerRow || isRendererRow || isFilterRow || isColumnGroupRow;
	//1 2 3 4 7 8
    return (rt!= FLXSRowPositionInfo.ROW_TYPE_DATA && rt!=FLXSRowPositionInfo.ROW_TYPE_FILL);

}

-(BOOL)isColumnBased
{
	int rt=self.rowPositionInfo.rowType;
	//return isHeaderRow || isFooterRow  || isDataRow || isColumnGroupRow|| isFilterRow;
    return rt!= FLXSRowPositionInfo.ROW_TYPE_PAGER && rt!=FLXSRowPositionInfo.ROW_TYPE_RENDERER;

}

-(NSString*)name
{
	return self.data && [self.data respondsToSelector:NSSelectorFromString(@"name")] ? [self.data valueForKey:@"name"] :@"";
}

-(BOOL)isSimilarTo:(FLXSRowInfo*)other
{
	NSMutableArray* similarRowTypes = [[NSMutableArray alloc] initWithObjects:
    [NSNumber numberWithInt:[FLXSRowPositionInfo ROW_TYPE_DATA]],
                    [NSNumber numberWithInt:[FLXSRowPositionInfo ROW_TYPE_FOOTER]],
                    [NSNumber numberWithInt:[FLXSRowPositionInfo ROW_TYPE_HEADER]],
                    [NSNumber numberWithInt:[FLXSRowPositionInfo ROW_TYPE_FILTER]],
                    [NSNumber numberWithInt:[FLXSRowPositionInfo ROW_TYPE_FILL]],nil];
	if(self.rowPositionInfo.levelNestDepth!=other.rowPositionInfo.levelNestDepth)
		return NO;
	else if(([similarRowTypes containsObject:[NSNumber numberWithInteger:self.rowPositionInfo.rowType] ] &&
            [similarRowTypes containsObject:[NSNumber numberWithInteger:other.rowPositionInfo.rowType] ] )
            &&self.rowPositionInfo.levelNestDepth==other.rowPositionInfo.levelNestDepth)
    return YES;
    return NO;
}

-(BOOL)paddingExists
{
	return self.hasNestPad;
}

-(BOOL)scrollBarPadExists
{
	return self.hasScrollBarPad;
}

-(NSArray*)getInnerCells
{
	NSMutableArray * result= [[NSMutableArray alloc] init];
	for(FLXSComponentInfo* cell in cells)
	{
		[result addObject:cell.component];
	}
	return result;
}

-(BOOL)disclosureExists
{
	return self.hasDisclosure;
}

-(BOOL)rightLockedExists
{
	if(self.hasRightLockPad)return YES;
	for(FLXSComponentInfo* cell in cells)
	{
		UIView<FLXSIFlexDataGridCell>* comp=cell.component;
		if(comp && comp.isRightLocked)
		{
			return YES;
		}
	}
	return NO;
}

-(BOOL)columnCellExists:(FLXSFlexDataGridColumn*)col
{
	return [self getCellForColumn:col]!=nil;
}

-(BOOL)columnGroupCellExists:(FLXSFlexDataGridColumnGroup*)col
{
	return [self getCellForColumnGroup:col]!=nil;
}

-(FLXSComponentInfo*)getCellForColumnGroup:(FLXSFlexDataGridColumnGroup*)col
{
	for(FLXSComponentInfo* cell in cells)
	{
		if([cell.component isKindOfClass:[FLXSFlexDataGridColumnGroupCell class]])
		{
			if(((FLXSFlexDataGridColumnGroupCell*)cell.component).columnGroup==col)
			{
				return cell;
			}
		}
	}
	return nil;
}

-(void)setY:(float)y {
    _y=y;

}
-(UIView<FLXSIExpandCollapseComponent>*)getExpandCollapseCell
{
    for(FLXSComponentInfo* cell in cells)
	{
        UIView<FLXSIFlexDataGridCell>* ifdc= (UIView<FLXSIFlexDataGridCell>*)cell.component;
		if(ifdc&&ifdc.isExpandCollapseCell)
		{
			return ifdc.iExpandCollapseComponent;
		}
	}
	return nil;
}

-(FLXSComponentInfo*)getCellForColumn:(FLXSFlexDataGridColumn*)col
{
	for(FLXSComponentInfo* cell in cells)
	{
        if([cell.component conformsToProtocol:@protocol(FLXSIFlexDataGridCell)])
		{
			if([((UIView<FLXSIFlexDataGridCell>*) cell.component).columnFLXS isEqual:col])
			{
				return cell;
			}
		}
	}
	return nil;
}

-(NSArray*)getLockedCells
{
	NSMutableArray * lockedCells= [[NSMutableArray alloc] init];
	for(FLXSComponentInfo* cell in cells)
	{
		if([cell.component conformsToProtocol:@protocol(FLXSIFlexDataGridCell)])
		{
			if(((UIView<FLXSIFlexDataGridCell>*)cell.component).isLocked)
			{
				[lockedCells addObject:cell.component];
			}
		}
	}
	return lockedCells;
}

-(FLXSComponentInfo*)addCell:(UIView*)component :(float)x
{
	if([component isKindOfClass:[FLXSFlexDataGridPaddingCell class]])
	{
        FLXSFlexDataGridPaddingCell* pad = (FLXSFlexDataGridPaddingCell*)component;

        if(pad.scrollBarPad)
		{
			self.hasScrollBarPad=YES;
		}
		else if(pad.forceRightLock)
		{
			self.hasRightLockPad=YES;
		}
		else
            self.hasNestPad=YES;
	}
	else if([component isKindOfClass:[FLXSFlexDataGridExpandCollapseCell class]])
        self.hasDisclosure = YES;
	FLXSComponentInfo* comp= [[FLXSComponentInfo alloc] initWithCell:component andX:x andRowInfo:self];
	[cells addObject:comp];
	return comp;
}

-(void)removeCell:(FLXSComponentInfo*)comp
{
	if([comp.component isKindOfClass:[FLXSFlexDataGridPaddingCell class]])
	{
        FLXSFlexDataGridPaddingCell* pad = (FLXSFlexDataGridPaddingCell*)comp.component;

        if(pad.scrollBarPad)
		{
            self.hasScrollBarPad=NO;
		}
		else if(pad.forceRightLock)
		{
            self.hasRightLockPad=NO;
		}
		else
            self.hasNestPad=NO;
	}
	else if([comp.component isKindOfClass:[FLXSFlexDataGridExpandCollapseCell class]])
        self.hasDisclosure = NO;
	if([self.cells indexOfObject:comp]!=NSNotFound)
		[self.cells removeObjectAtIndex:[comp.row.cells indexOfObject:comp]];
}

- (void)setFLXSRowPositionInfo:(FLXSRowPositionInfo *)rowPos setHt:(BOOL)setHt {
	self.rowPositionInfo=rowPos;
	self.height=rowPos.rowHeight;
	self.y=rowPos.verticalPosition;
	for(FLXSComponentInfo* cell in cells)
	{
		UIView<FLXSIFlexDataGridCell>* comp=(UIView<FLXSIFlexDataGridCell>* )cell.component;
		if(comp)
		{
			[comp refreshCell];
			if(setHt)
			{
                [comp setActualSizeWithWidth:comp.width andHeight:rowPos.rowHeight];
			}
		}
	}
}

-(void)showHide:(BOOL)showHide
{
	for(FLXSComponentInfo* cell in cells)
	{
		cell.component.hidden=!showHide;
	}
}

-(void)invalidateCells
{
	for(FLXSComponentInfo* cell in cells)
	{
		UIView<FLXSIFlexDataGridCell>* cellComp=(UIView<FLXSIFlexDataGridCell>*)cell.component;
		if(cellComp)
			[cellComp invalidateBackground];
	}
}

-(void)refreshCells
{
	for(FLXSComponentInfo* cell in cells)
	{
		UIView<FLXSIFlexDataGridCell>* cellComp=(UIView<FLXSIFlexDataGridCell>*)cell.component;
		if(cellComp)
			[cellComp refreshCell];
	}
}

-(int)getColumnGroupDepth:(FLXSFlexDataGrid*)grid
{
	if(self.rowPositionInfo.levelNestDepth==1)
	{
		return rowPositionInfo.rowIndex+1;
	}
	else
	{
		//- not supported for now. Column groups are only supported at the top level.
		return [grid.bodyContainer getColumnGroupDepth:self];
	}
}

-(float)getMaxCellHeight:(FLXSFlexDataGridColumn*)col
{
	if(!self.isDataRow)return height;
	if(self.isFillRow)return height;
	float ht=height;
	for(FLXSComponentInfo* cell in cells)
	{
		UIView<FLXSIFlexDataGridCell>* cellComp=cell.component;
		if(col!=nil && (cellComp.columnFLXS !=col))continue;
		if(cellComp&&(cellComp.height>ht))
			ht=cellComp.height;
	}
	return ht;
 }
- (id)copyWithZone:(NSZone *)zone
{
    FLXSRowInfo* copy = [[[self class] alloc] init];
    
    if (copy) {
        copy.cells = [[self cells]mutableCopy];
		copy.hasScrollBarPad = self.hasScrollBarPad;
        copy.hasNestPad = self.hasNestPad;
        copy.hasRightLockPad = self.hasRightLockPad;
        copy.hasDisclosure = self.hasDisclosure;
        
		copy.height=self.height;
		copy.y=self.y;
		copy.dataGrid=self.dataGrid;
    }
    
    return copy;
}


-(void)registerIFilterControl:(UIView<FLXSIFilterControl>*)iFilterControl
{
    [self.filterContainerInterface registerIFilterControl:iFilterControl];
}

-(void)unRegisterIFilterControl:(UIView<FLXSIFilterControl>*)iFilterControl
{
    [self.filterContainerInterface unRegisterIFilterControl:iFilterControl];
}

-(NSArray*)getFilterArguments
{
    return [self.filterContainerInterface getFilterArguments];
}

-(NSArray*)getFilterControls
{
    return [self.filterContainerInterface getFilterControls];
}

-(void)processFilter
{
    [self.filterContainerInterface processFilter];
}

-(void)clearFilter:(NSString*)col
{
    [self.filterContainerInterface clearFilter:col];
}

- (void)setFilterValue:(NSString *)column value:(NSObject *)value {
    [self.filterContainerInterface setFilterValue:column value:value];
}

-(BOOL)setFilterFocus:(NSString*)fld
{
    return [self.filterContainerInterface setFilterFocus:fld];
}

-(NSObject*)getFilterValue:(NSString*)column
{
    return [self.filterContainerInterface getFilterValue:column];
}

-(BOOL)hasField:(NSString*)column
{
    return [self.filterContainerInterface hasField:column];
}


-(FLXSFilterContainerImpl*)filterContainerInterface
{
    if(_filterContainerInterface==nil)
        _filterContainerInterface= [[FLXSFilterContainerImpl alloc] initWithIEventDispatcher:self];
    return _filterContainerInterface;
}

//Start FLXSIEventDispatcher methods

- (void)addEventListener:(NSString *)type target:(NSObject *)target handler:(SEL)handler {
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
    [FLXSUIUtils dispatchEvent:event
                    withSender:self];
}
//End FLXSIEventDispatcher methods
@end

