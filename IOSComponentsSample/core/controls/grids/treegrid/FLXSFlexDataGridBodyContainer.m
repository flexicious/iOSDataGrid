#import <QuartzCore/QuartzCore.h>
#import "FLXSFlexDataGridBodyContainer.h"
#import "FLXSComponentInfo.h"
#import "FLXSRowInfo.h"
#import "FLXSIFlexDataGridCell.h"
#import "FLXSRowPositionInfo.h"
#import "FLXSKeyValuePairCollection.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSFilterPageSortChangeEvent.h"
#import "FLXSInsertionLocationInfo.h"
#import "UIScrollView+UIScrollViewAdditions.h"
#import "FLXSFlexDataGridHeaderCell.h"
#import "FLXSRendererCache.h"
#import "FLXSComponentAdditionResult.h"
#import "FLXSIFlexDataGridDataCell.h"
#import "FLXSIExpandCollapseComponent.h"
#import "FLXSExtendedFilterPageSortChangeEvent.h"
#import "FLXSItemLoadInfo.h"
#import "FLXSItemPositionInfo.h"
#import "FLXSPrintFlexDataGridBodyContainer.h"
#import "FLXSIExtendedPager.h"
#import "FLXSExtendedUIUtils.h"


@implementation FLXSFlexDataGridBodyContainer {
@private
    NSMutableArray *_openItems;
    float _calculatedTotalHeight;
    BOOL _heightCalculated;
    BOOL _processing;
    BOOL _drawDirty;
    BOOL _recreateRows;
    NSMutableDictionary *_rowCache;
    FLXSRowPositionInfo *_currentRowPointer;
    NSMutableArray *_visibleRange;
    NSMutableArray *_visibleRangeH;
    NSMutableArray *_fillerRows;
    BOOL _onDisabledCell;
    float _verticalScrollPending;
    FLXSKeyValuePairCollection *_parentMap;
    FLXSKeyValuePairCollection *_variableRowHeightRenderers;
}


@synthesize openItems = _openItems;
@synthesize backgroundForFillerRows = _backgroundForFillerRows;
@synthesize calculatedTotalHeight = _calculatedTotalHeight;
@synthesize heightCalculated = _heightCalculated;
@synthesize processing = _processing;
@synthesize drawDirty = _drawDirty;
@synthesize recreateRows = _recreateRows;
@synthesize rowCache = _rowCache;
@synthesize currentRowPointer = _currentRowPointer;
@synthesize visibleRange = _visibleRange;
@synthesize visibleRangeH = _visibleRangeH;
@synthesize fillerRows = _fillerRows;
@synthesize onDisabledCell = _onDisabledCell;
@synthesize verticalScrollPending = _verticalScrollPending;
@synthesize parentMap = _parentMap;
@synthesize variableRowHeightRenderers = _variableRowHeightRenderers;
-(id)initWithGrid:(FLXSFlexDataGrid*)grid
{
	self = [super initWithGrid:grid];
	if (self)
	{

 		_openItems = [[NSMutableArray alloc] init];
		self.backgroundForFillerRows = [[FLXSGridBackground alloc] init];
        _heightCalculated = NO;
		_processing = NO;
		_drawDirty = NO;
		_recreateRows = NO;
		_rowCache = [[NSMutableDictionary alloc] init];
		_visibleRange = [[NSMutableArray alloc] init];
		_visibleRangeH = [[NSMutableArray alloc] init];
		self.fillerRows = [[NSMutableArray alloc] init];
        self.onDisabledCell = NO;
		_verticalScrollPending = -1;
        self.parentMap = [[FLXSKeyValuePairCollection alloc]init];


	}
	return self;
}


-(float)calculatedTotalHeight
{
	return _calculatedTotalHeight;
}
-(void)drawRect:(CGRect)rect {

   // 	[self.grid  traceEvent:(@"begin section list" + _drawDirty + @":" + _verticalScrollPending)]
        if(_verticalScrollPending!=-1)
    	{
    		[self gotoVerticalPosition:_verticalScrollPending];
    		_verticalScrollPending=-1;
    	}
    	if(_drawDirty)
    	{
    		_drawDirty=NO;
    		[self drawRows:NO];
    		_recreateRows=NO;
    		[self.grid synchronizeLockedVerticalScroll];
    		[self.grid synchronizeHorizontalScroll];
    	}
    [super drawRect:rect];
}

-(void)scrollChildren
{
    //not needed, since scrollBars are virtual
}
//-(CGSize)contentSize {
//    if( [self calculateTotalHeightNoParam] ==0){
//        return CGSizeMake(200, 2000);
//    }
//    CGSize sz= CGSizeMake([self.grid .columnLevel getSumOfColumnWidths:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE],nil]]-1, [self calculateTotalHeightNoParam]  );
//    return sz;
//}

//-(void)onFilterChange:(FLXSFilterPageSortChangeEvent*)event
//{
//    	[super onFilterChange:event];
//    	UIView<FLXSIFilterControl>* trigger = event.triggerEvent.target;
//    	UIView<FLXSIFlexDataGridCell>* treeCell = trigger.superview;
//    	FLXSRowInfo* rowInfo=treeCell.rowInfo;
//    	if(![self.grid.itemFilters objectForKey:rowInfo.data])
//    	{
//            [self.grid.itemFilters setObject:[[FLXSAdvancedFilter alloc] init] forKey:rowInfo.data];
//        }
//        FLXSAdvancedFilter *filter = (FLXSAdvancedFilter *)[self.grid.itemFilters objectForKey:rowInfo.data];
//        filter.pageIndex=0;
//    	[self expandCollapse:rowInfo.data rowPositionInfo:nil forceScrollBar:YES ];
//    	[self expandCollapse:rowInfo.data rowPositionInfo:nil forceScrollBar:YES ];
//}

-(void)onPageChange:(NSNotification*)ns
{
        FLXSEvent* event = (FLXSEvent*)[ns.userInfo objectForKey:@"event"];
    [super onPageChange:ns];
        UIView<FLXSIExtendedPager>* iPager=(UIView<FLXSIExtendedPager>* )event.target ;

        if(iPager.level.isClientFilterPageSortMode)
    	{
            if(![self.grid.itemFilters objectForKey:iPager.rowInfo.data])
            {
                [self.grid.itemFilters setObject:[[FLXSAdvancedFilter alloc] init] forKey:(id<NSCopying>)iPager.rowInfo.data];
            }
            FLXSAdvancedFilter *filter = (FLXSAdvancedFilter *)[self.grid.itemFilters objectForKey:iPager.rowInfo.data];
            filter.pageIndex=iPager.pageIndex;
    		NSObject* item=iPager.rowInfo.data;
    		[self expandCollapse:item rowPositionInfo:nil forceScrollBar:YES ];
    		[self expandCollapse:item rowPositionInfo:nil forceScrollBar:YES ];
    	}
}


-(BOOL)validNextPage
{
	return self.height>0&&([self calculateTotalHeightNoParam]>self.height) &&(self.verticalScrollPosition<([self calculateTotalHeightNoParam]-self.height));
}

- (FLXSRowPositionInfo *)getFLXSRowPositionInfo:(NSObject *)item level:(FLXSFlexDataGridColumnLevel *)lvl {
    	for(FLXSRowPositionInfo* dataitem in self.itemVerticalPositions)
    	{
    		if(lvl!=nil)
    		{
    			if([lvl areItemsEqual:item itemB:dataitem.rowData])
    			{
    				return dataitem;
    			}
    		}
    		else if([dataitem.rowData isEqual:item])
                return dataitem;
    	}
    	return nil;
}

-(FLXSRowPositionInfo*)getFLXSRowPositionInfoFromRows:(NSObject*)item
{
    	for(FLXSRowInfo* row in self.rows)
    	{
    		if([row.data isEqual:item])
    			return row.rowPositionInfo;
    	}
    	return nil;
}

- (FLXSRowPositionInfo *)binarySearch:(NSArray *)arr verticalPosition:(float)verticalPos low:(int)low high:(int)high {

    	if (high < low)
    		return nil;// not found
        int mid = (low + high)  / 2;
        if([arr count] ==0 )
        return nil;

        FLXSRowPositionInfo * midPos=((FLXSRowPositionInfo *)arr[mid]);

        if([arr count]>0 && ((FLXSRowPositionInfo *)arr[arr.count-1]).verticalPosition<verticalPos)
    		return arr[[arr count]-1];
    	else if (((verticalPos-((FLXSRowPositionInfo *)arr[mid]).verticalPosition)>=0)
                    && ((verticalPos-midPos.verticalPosition)<=midPos.rowHeight))
            return arr[mid];
        else if (midPos.verticalPosition > verticalPos)
            return [self binarySearch:arr verticalPosition:verticalPos low:low high:(mid - 1)];
        else if (midPos.verticalPosition < verticalPos)
            return [self binarySearch:arr verticalPosition:verticalPos low:(mid + 1) high:high];
        else
            return nil;
}

-(NSArray*)getItemVerticalPositions
{
	return [self.itemVerticalPositions mutableCopy];
}

-(FLXSRowPositionInfo*)getItemAtPosition:(float)position
{
    return [self binarySearch:self.itemVerticalPositions verticalPosition:position low:0 high:(int)[self.itemVerticalPositions count]];
}
-(float)calculateTotalHeightNoParam{
    return [self calculateTotalHeight:nil level:nil heightSoFar:0 nestLevel:0 expanding:nil addedRows:nil parentObject:nil isRecursive:NO ];
}
-(void)setVisibleRange
{
    float currrentPosition=self.verticalScrollPosition;
    float upperBound=MAX(currrentPosition-self.grid.columnLevel.rowHeight,0);
    float lowerBound=MIN(currrentPosition+self.height+self.grid.columnLevel.rowHeight,
    [self calculateTotalHeightNoParam]);
    _visibleRange= [[NSMutableArray alloc] initWithObjects:[self getItemAtPosition:upperBound],[self getItemAtPosition:lowerBound],nil];
    _visibleRangeH=[[NSMutableArray alloc] initWithObjects:
            [[NSNumber alloc] initWithFloat: self.horizontalScrollPosition-(self.horizontalMask)>0?self.horizontalScrollPosition-(self.horizontalMask):0],
            [[NSNumber alloc] initWithFloat:self.horizontalScrollPosition+(self.width+self.horizontalMask)]
            ,nil];
}

- (void)createComponents:(FLXSFlexDataGridColumnLevel *)level currentScroll:(int)currentScroll flat:(NSObject *)flat {

    if(!_heightCalculated)
        [self calculateTotalHeightNoParam];
    if(self.verticalScrollPosition>_calculatedTotalHeight)
    {
        self.verticalScrollPosition=0;
    }
    [super createComponents:level currentScroll:currentScroll flat:flat];
    if(self.grid.enableFillerRows)
    {
        [self addSubview:self.backgroundForFillerRows];
        [self sendSubviewToBack:self.backgroundForFillerRows];
    }
    if(self.currentRowPointer && self.currentRowPointer.rowData)
    {
        self.grid.currentPoint.contentY=self.currentRowPointer.verticalPosition;
    }
    _drawDirty=YES;
    _recreateRows=YES;
    [self doInvalidate];

    if(self.grid.enablePullToRefresh){
        if(!self.refreshControl){
            self.refreshControl = [[UIRefreshControl alloc] init];
            UIRefreshControl * refreshControl = (UIRefreshControl *)self.refreshControl;
            [refreshControl addTarget:self
                               action:@selector(onRefresh:)
                     forControlEvents:UIControlEventValueChanged];
            refreshControl.attributedTitle = self.grid.pullToRefreshAttributedTitle;
        }
        [self addSubview:self.refreshControl];
    }

}
-(void)onRefresh:(id)sender{
    [self.grid processRootFilter:nil];
//    if([self.grid.filterPageSortMode isEqualToString:@"client"]){
//        [self hideRefreshControl];
//    }
    [self.grid dispatchAutoRefreshEvent:nil];
}
-(void)hideRefreshControl {
    UIRefreshControl * refreshControl = (UIRefreshControl *)self.refreshControl;
    [refreshControl endRefreshing];
}

- (void)recycleH:(FLXSFlexDataGridColumnLevel *)level scrollRight:(BOOL)scrollRight {
    [self setVisibleRange];
    [self endEdit:nil event:nil ];
    [super recycleH:level scrollRight:scrollRight];
    /*if(self.grid.enableFillerRows)
    {
        [self.grid  invalidateFiller];
        return;
    }
    */

    if([self.fillerRows count] >0)
    {
        [self resizeFillerCells];
        [self.fillerRows setObject:[self processItem:(((FLXSRowInfo *) [self.fillerRows objectAtIndex:0]).rowPositionInfo) scrollDown:YES existingRow:[self.fillerRows objectAtIndex:0] existingComponents:nil ] atIndexedSubscript:0];
    }
}

-(NSArray*)getRowsForRecycling
{
    NSMutableArray* newRows=([self.rows mutableCopy]);
    for(FLXSRowInfo* fillerRow in self.fillerRows)
    {
        [newRows addObject:fillerRow];
    }
    return newRows;
}

- (void)recycle:(FLXSFlexDataGridColumnLevel *)level scrollDown:(BOOL)scrollDown scrollDelta:(float)scrollDelta scrolling:(BOOL)scrolling {
    	if((self.verticalScrollPosition+scrollDelta)>self.maxVerticalScrollPosition)
    	{
            self.verticalScrollPosition=self.maxVerticalScrollPosition;
    	}
    	if((self.verticalScrollPosition+scrollDelta)<0)
    	{
            self.verticalScrollPosition=0;
    	}
    	[self setVisibleRange];
    	FLXSRowInfo* row;
        BOOL offPage=scrollDown?(scrollDelta)>=self.height:(0-scrollDelta)>=self.height;
    	if([self.rows count] ==0&&!self.grid.recalculateSeedOnEachScroll)return;
        NSMutableArray* toRemove= [[NSMutableArray alloc] init];
    	for(row in self.rows)
    	{
    		if(offPage || (( row.y<((FLXSRowPositionInfo *)_visibleRange[0]).verticalPosition)) 
                    || (row.y>((FLXSRowPositionInfo *)_visibleRange[1]).verticalPosition))
    		{
    			if(self.grid.hasRowSpanOrColSpan&&!row.isFillRow)
    			{
    				float maxCellHt=[row getMaxCellHeight:nil];
    				if((maxCellHt>row.height)&&((maxCellHt+row.rowPositionInfo.verticalPosition)>self.verticalScrollPosition))
    				{
    					//self means we'd still be in view
    					scrolling=NO;
    					//cannot use scrolling optimization anymore.
    					continue;
    				}
    			}
    			[toRemove addObject:row];
    		}
    	}
    	for(row in toRemove)
    	{
    		[self.rows removeObjectAtIndex:([self.rows indexOfObject:row])];
    		[self saveRowInCache:row];
    	}
    	FLXSRowPositionInfo* start = ((FLXSRowPositionInfo *)_visibleRange[0]);
    	FLXSRowPositionInfo* end = ((FLXSRowPositionInfo *)_visibleRange[1]);
    	if(scrolling)
    	{
    		if(!scrollDown)
    		{
    			if(start==nil)return;
    			if(!offPage && [self.rows count] >0 && ((FLXSRowInfo *)self.rows[0]).rowPositionInfo.rowIndex>=start.rowIndex)
    			{
    				end=((FLXSRowInfo *)self.rows[0]).rowPositionInfo;
    			}
    			if(self.grid.recalculateSeedOnEachScroll)
    			{
    			}
    			else if(end && (end.rowIndex>0))
                end=self.itemVerticalPositions[end.rowIndex-1];
    		}
    		else
    		{
    			if(end==nil)return;
    			if(!offPage&& self.rows.count>0
                        && ((FLXSRowInfo *)self.rows[self.rows.count-1]).rowPositionInfo.rowIndex<=end.rowIndex)
    			{
    				start=((FLXSRowInfo *)self.rows[self.rows.count-1]).rowPositionInfo;
    			}
    			if(start==nil)return;
    			if([self.itemVerticalPositions count]>(start.rowIndex+1))
    			{
    				if(self.grid.recalculateSeedOnEachScroll && start.rowIndex==end.rowIndex)
    				{
    				}
    				else
                    start=self.itemVerticalPositions[start.rowIndex+1];
    			}
    		}
    	}
    	if(start==nil||end==nil)return;
    	[self drawRowsUsingCache:start end:end scrollDown:scrollDown offPage:offPage];
    	//[self checkInconsistency]
}

- (void)drawRowsUsingCache:(FLXSRowPositionInfo *)start end:(FLXSRowPositionInfo *)end scrollDown:(BOOL)scrollDown offPage:(BOOL)offPage {
    	if(self.grid.hasRowSpanOrColSpan)
    	{
    		if(self.verticalScrollPosition>0 &&!scrollDown)
    		{
    			for(FLXSRowPositionInfo* rowPos in self.itemVerticalPositions)
    			{
    				if(rowPos.rowIndex>start.rowIndex)
    					break;
    				if(rowPos.rowSpan>1)
    				{
    					if((rowPos.rowSpan + rowPos.rowIndex)>=start.rowIndex)
    					{
    						//self is a undrawn row, that is extends because of its row span
    						if(![self rowExists:rowPos])
    						{
    							[self processItemPositionInfoUsingCache:rowPos insertionPoint:0 scrollDown:YES ];
    						}
    					}
    				}
    			}
    		}
    	}
    	for ( int rowIndex = start.rowIndex; rowIndex <= end.rowIndex; rowIndex++ )
    	{
    		FLXSRowPositionInfo* seed = self.itemVerticalPositions[rowIndex];
    		if(!offPage)
    		{
    			BOOL exists=NO;
    			for(FLXSRowInfo* row in self.rows)
    			{
    				if([row.rowPositionInfo isEqual:seed])
    				{
    					exists=YES;
    					break;
    				}
    			}
    			if(exists)
    				continue;
    		}
    		int insertionPoint=(int)self.rows.count;
    		if(!scrollDown)
    			insertionPoint=rowIndex-start.rowIndex;
    		if(seed)
    			[self processItemPositionInfoUsingCache:seed insertionPoint:insertionPoint scrollDown:scrollDown];
    	}
    	if(self.grid.hasRowSpanOrColSpan)
    	{
    		[self snapToColumnWidths];
    	}
}

- (void)processItemPositionInfoUsingCache:(FLXSRowPositionInfo *)seed insertionPoint:(int)insertionPoint scrollDown:(BOOL)scrollDown {
    	FLXSRowInfo* row;
    	BOOL found=NO;
//    	int index=0;
    	NSString* seedKey= [@"" stringByAppendingFormat:@"%d:%d",seed.levelNestDepth,seed.rowType];
    	//if(_rowCache[seedKey]&&_rowCache[seedKey].count>0)
        if([_rowCache objectForKey:seedKey] && ((NSArray *) [_rowCache objectForKey:seedKey]).count>0)
    	{
            NSMutableArray *cachedRows =((NSMutableArray *) [_rowCache objectForKey:seedKey]);
    		row = [cachedRows objectAtIndex:0];
            [cachedRows removeObjectAtIndex:0];
            found=YES;
    	}
    	if(found)
    	{
    		[row showHide:YES];
    		[row setFLXSRowPositionInfo:seed setHt:self.grid.variableRowHeight];
    		[self.rows insertObject:row atIndex:insertionPoint];
    		if(_recreateRows)
    		{
    			NSMutableArray* existing=row.cells;
    			row.cells= [[NSMutableArray alloc] init];
    			[self processRowPositionInfo:seed scrollDown:scrollDown existingRow:row existingComponents:existing];
    			while(existing.count>0)
    			{
    				[self removeComponent:(existing[0])];
    				[existing removeObjectAtIndex:0];
    			}
    		}
    		[self.grid placeComponents:row];
    	}
    	else
    	{
            self.grid.currentPoint.contentY=seed.verticalPosition;
    		[self processRowPositionInfo:seed scrollDown:scrollDown existingRow:nil existingComponents:nil ];
    	}
}

-(void)checkInconsistency
{
    	float diff=((FLXSRowInfo *)self.rows[0]).y;
    	int index=0;
    	for(FLXSRowInfo* row in self.rows)
    	{
    		if((row.y==diff && index>0))
    		{
    			row.y=row.y;
    		}
    		diff=row.y;
    		index++;
    	}
}

-(NSObject*)positionExists:(FLXSRowPositionInfo*)seed
{
    	for(FLXSRowInfo* row in self.rows)
    	{
    		if([row.rowPositionInfo isEqual:seed])return row.rowPositionInfo;
    	}
    	return nil;
}

-(void)setVerticalScrollPosition:(float)val
{
    if(val<0)
    {
        val=0;
    }
    super.verticalScrollPosition=val;
}

-(void)keyDownHandler:(FLXSEvent*)event
{
}

-(void)validateDisplayList
{
    //ios dont need this
}

-(BOOL)rowExists:(FLXSRowPositionInfo*)rowPos
{
    for(FLXSRowInfo* row in self.rows)
    {
        if([row.rowPositionInfo isEqual:rowPos])
            return YES;
    }
    return NO;
}

-(void)removeAllComponents:(BOOL)recycle
{
    if(self.inEdit)[self endEdit:nil event:nil ];
    if(!recycle)
    {
        [super removeAllComponents:recycle];
        if(self.grid.enableFillerRows)
        {
            [self.grid invalidateFiller];
        }
        while(self.fillerRows.count>0)
        {
            FLXSRowInfo* fillerRow = [self.fillerRows objectAtIndex:0];
            [self.fillerRows removeObjectAtIndex:0];
            [self removeComponents:fillerRow];
        }
        _rowCache=[[NSMutableDictionary alloc] init];
    }
    else
    {
        for(FLXSRowInfo* row in self.rows)
        {
            [self saveRowInCache:row];
        }
        [self.rows removeAllObjects];
    }
}

-(void)saveRowInCache:(FLXSRowInfo*)row
{
    [row showHide:NO];
    NSString* key= [@"" stringByAppendingFormat:@"%d:%d",row.rowPositionInfo.levelNestDepth,row.rowPositionInfo.rowType];

    if(![_rowCache objectForKey:key])
    {
        [_rowCache setObject:[[NSMutableArray alloc] init] forKey:key];
    }
    NSMutableArray *cachedRows = [_rowCache objectForKey:key];
    if(![cachedRows containsObject:row])
        [cachedRows addObject:row];
    for(FLXSComponentInfo* comp in row.cells)
    {
        if([comp.component isKindOfClass:[FLXSFlexDataGridHeaderCell class]])
        {
            FLXSFlexDataGridHeaderCell* headerCell= (FLXSFlexDataGridHeaderCell*)comp.component;
            [headerCell destroySortIcon];
        }
    }
}

- (void)shiftColumns:(FLXSFlexDataGridColumn *)columnToInsert insertBefore:(FLXSFlexDataGridColumn *)insertBefore {
    	for(FLXSRowInfo* row in [self getAllRows])
    	{
    		NSMutableArray* cells=[row.cells mutableCopy];
    		NSMutableArray* arrayCollection = [cells mutableCopy];
    		NSObject* cellToInsert = [row getCellForColumn:columnToInsert];
    		NSObject* cellInsertBefore = [row getCellForColumn:insertBefore];
    		if(cellToInsert&&cellInsertBefore)
    		{
    			if([arrayCollection indexOfObject:cellToInsert]!=NSNotFound)
    				[arrayCollection removeObjectAtIndex:([arrayCollection indexOfObject:cellToInsert])];
    			if([arrayCollection indexOfObject:cellInsertBefore]!=NSNotFound)
    				[arrayCollection insertObject:cellToInsert atIndex:([arrayCollection indexOfObject:cellInsertBefore])];
    		}
    		row.cells=arrayCollection;
    	}
}

-(BOOL)drawRows:(BOOL)forceFiller
{
    [self setVisibleRange];
    FLXSRowPositionInfo* start = _visibleRange.count==0?nil:((FLXSRowPositionInfo *)_visibleRange[0]);
    FLXSRowPositionInfo* end =  _visibleRange.count==0?nil:((FLXSRowPositionInfo *)_visibleRange[1]);
    if([_visibleRange count]==0 || ((FLXSRowPositionInfo *)_visibleRange[0])==nil)
        self.grid.currentPoint.contentY =0;
    else
        self.grid.currentPoint.contentY = ((FLXSRowPositionInfo *)_visibleRange[0]).verticalPosition;
    self.grid.currentPoint.contentX=self.grid.currentPoint.leftLockedContentX=self.grid.currentPoint.rightLockedContentX=0;
    if(start!=nil && end !=nil)
    {
        [self drawRowsUsingCache:start end:end scrollDown:YES offPage:YES ];
    }
    if((_calculatedTotalHeight<self.height) || forceFiller)
    {
        [self drawFiller:end];
    }
    return YES;
}

-(void)drawFiller:(FLXSRowPositionInfo*)end
{
    //self means we need to fill...
    if(self.grid.enableFillerRows)
    {
        [self.grid invalidateFiller];
        return;
    }
    FLXSRowPositionInfo* filler=self.fillerRows.count>0?
                ((FLXSRowInfo*)self.fillerRows[0]).rowPositionInfo: [[FLXSRowPositionInfo alloc] initWithRowData:([[NSObject alloc] init]) andRowIndex:(end ? end.rowIndex + 1 : 1) andVerticalPosition:0 andRowHeight:self.height andLevel:self.grid.columnLevel andRowType:[FLXSRowPositionInfo ROW_TYPE_FILL]];
    if(self.fillerRows.count==0)
        [self.fillerRows addObject:[[NSObject alloc]init]];
    self.fillerRows[0]= [self processItem:filler scrollDown:NO
                              existingRow:((FLXSRowInfo *) self.fillerRows[0]) existingComponents:nil ];
}

-(void)adjustFiller:(float)offset
{
    if(self.grid.enableFillerRows)
    {
        [self.grid invalidateFiller];
        return;
    }
    if(self.fillerRows.count>0)
    {
        FLXSRowInfo* fillerRow=self.fillerRows[0];
        for(FLXSComponentInfo* item in fillerRow.cells)
        {
            if(item.component)
                item.component.height+=offset;
        }
    }
}

-(void)setBackgroundFillerSize
{
    float ht=self.height;
    //ht-=(self.horizontalScrollBar?self.horizontalScrollBar.height:0);
    ht-= _calculatedTotalHeight;
    if(ht<0)ht=0;
    self.backgroundForFillerRows.height=(ht);
    self.backgroundForFillerRows.width=self.grid.forceColumnsToFitVisibleArea?self.width: isnan(self.contentSize.width)?self.width:self.contentSize.width;
    if(ht>0)
    {
        [((UIView *) self.backgroundForFillerRows) moveToX:0 y:self.grid.bodyContainer.calculatedTotalHeight];
    }
}

-(void)onWidthChanged:(FLXSEvent*)event
{
    if((_calculatedTotalHeight<self.height) )
    {
        if(self.grid.enableFillerRows)
        {
            [self.grid invalidateFiller];
            return;
        }
    }
}

-(void)onHeightChanged:(FLXSEvent*)event
{
    if(self.grid.enableFillerRows)
    {
        [self.grid invalidateFiller];
        return;
    }
    if((_calculatedTotalHeight<self.height) )
    {
        if(self.fillerRows.count==0)
            [self drawFiller:([_visibleRange count]?((FLXSRowPositionInfo *)_visibleRange[1]):nil)];
    }
    [self resizeFillerCells];
}

-(void)resizeFillerCells
{
    if(self.grid.enableFillerRows)
    {
        [self.grid  invalidateFiller];
        return;
    }
    if(self.fillerRows.count>0)
    {
        FLXSRowInfo* fillerRow=self.fillerRows[0];
        for(FLXSComponentInfo* item in fillerRow.cells)
        {
            if(item.component )
            {
                item.component.height=self.height-self.grid.isHScrollBarVisible;
            }
        }
    }
}

- (void)processRowPositionInfo:(FLXSRowPositionInfo *)rowPositionInfo scrollDown:(BOOL)scrollDown existingRow:(FLXSRowInfo *)existingRow existingComponents:(NSArray *)existingComponents {
    if(rowPositionInfo.rowType == [FLXSRowPositionInfo ROW_TYPE_DATA])
    {
        [self processItem:rowPositionInfo scrollDown:scrollDown existingRow:existingRow existingComponents:existingComponents];
    }
    else
    {
        [super processRowPositionInfo:rowPositionInfo scrollDown:scrollDown existingRow:existingRow existingComponents:existingComponents];
    }
}

-(FLXSComponentInfo*)addEventListeners:(FLXSComponentInfo*)comp
{
    if(!comp || comp.row.isFillRow)return comp;
    FLXSComponentInfo* result=[super addEventListeners:comp];
    UIView<FLXSIFlexDataGridCell>* dataCell=(UIView<FLXSIFlexDataGridCell>*)comp.component;
    if(dataCell)
    {
        //todo v1.2
//        if(self.grid.enableDrag)
//        {
//            [dataCell addEventListener:[DragEvent DRAG_COMPLETE] :onCellDragComplete];
//            [dataCell addEventListener:[MouseEvent MOUSE_MOVE] :onCellDragMouseMove];
//            [dataCell addEventListener:[MouseEvent MOUSE_DOWN] :onCellDragMouseDown];
//        }
//        if(self.grid.enableDrop)
//        {
//            [dataCell addEventListener:[DragEvent DRAG_ENTER] :onDragEnter];
//            [dataCell addEventListener:[DragEvent DRAG_DROP] :onDragDrop];
//        }
    }
    if(dataCell.isExpandCollapseCell)
    {
        [dataCell addEventListenerOfType:[FLXSFlexDataGridExpandCollapseCell EVENT_EXPAND_COLLAPSE] usingTarget:self withHandler:@selector(onExpandCollapse:)];
    }
    return result;
}

-(void)onCellDragComplete:(FLXSEvent*)event
{
}

-(void)onCellDragMouseMove:(FLXSEvent*)event
{
    //todo v1.2
    //	if(!self.grid.allowInteractivity)return;
    //	if(self.grid.headerContainer.columnDraggingDragCell || grid.headerContainer.columnResizingCell)return;
    //	if(onDisabledCell)return;
    //	if(event.buttonDown)
    //	{
    //		if(!self.grid.isScrolling)
    //			[self.grid  dragBegin:event]
    //	}
}

-(void)onCellDragMouseDown:(FLXSEvent*)event
{
    //todo v1.2
//	if(!self.grid.allowInteractivity)return;
    //	if(self.grid.headerContainer.columnDraggingDragCell || grid.headerContainer.columnResizingCell)return;
    //	IFLXSFlexDataGridDataCell* cell = event.currentTarget as
    //IFLXSFlexDataGridDataCell;
    //	onDisabledCell=cell&&!cell.enabled;
}

-(void)onDragEnter:(FLXSEvent*)event
{
}

-(void)onDragDrop:(FLXSEvent*)event
{
}

-(void)onCellDropMouseMove:(FLXSEvent*)event
{
    //todo v1.2
//	if(!self.grid.allowInteractivity)return;
    //	if(self.grid.enableDrop && [DragManager isDragging])
    //	{
    //		UIView<FLXSIFlexDataGridCell>* cell = event.currentTarget as FLXSIFlexDataGridCell;
    //		if([self isOutOfVisibleArea:cell.rowInfo])
    //		{
    //			Point* pt = [self.grid  globalToLocal:([cell localToGlobal:([[Point alloc] init:0 :0])])];
    //			if(pt.y>(self.grid.height/2))
    //				[self.grid  scrollToExistingRow:(verticalScrollPosition+cell.height) :YES];
    //			else
    //[self.grid  scrollToExistingRow:(verticalScrollPosition-cell.height) :NO];
    //		}
    //	}
}

-(void)removeEventListeners:(FLXSComponentInfo*)comp
{
    if(!comp || comp.row.isFillRow)return;
    [super removeEventListeners:comp];
    if(((UIView<FLXSIFlexDataGridCell>*)comp.component).isExpandCollapseCell)
    {
        [comp.component removeEventListenerOfType:[FLXSFlexDataGridExpandCollapseCell EVENT_EXPAND_COLLAPSE] fromTarget:self usingHandler:@selector(onExpandCollapse:)];
    }
    else if([comp.component conformsToProtocol:@protocol(FLXSIFlexDataGridDataCell)])
    {
        //next version v1.2
//        UIView<FLXSIFlexDataGridCell>* dataCell = comp.component as FLXSIFlexDataGridCell;
//        if(self.grid.enableDrag)
//        {
//            [dataCell removeEventListener:[DragEvent DRAG_COMPLETE] :onCellDragComplete];
//            [dataCell removeEventListener:[MouseEvent MOUSE_MOVE] :onCellDragMouseMove];
//            [dataCell removeEventListener:[MouseEvent MOUSE_DOWN] :onCellDragMouseDown];
//        }
//        if(self.grid.enableDrop)
//        {
//            [dataCell removeEventListener:[DragEvent DRAG_ENTER] :onDragEnter];
//            [dataCell removeEventListener:[DragEvent DRAG_DROP] :onDragDrop];
//        }
    }
}

- (void)handleSpaceBar:(UIView <FLXSIFlexDataGridCell> *)cell triggerEvent:(FLXSEvent *)triggerEvent {
   //no keyboard ios
}

- (BOOL)handleArrowKey:(UIView <FLXSIFlexDataGridCell> *)cell keyCode:(int)keyCode triggerEvent:(FLXSEvent *)triggerEvent {
    //no keyboard ios
    return NO;
}

- (FLXSRowInfo *)processItem:(FLXSRowPositionInfo *)rowPositionInfo scrollDown:(BOOL)scrollDown existingRow:(FLXSRowInfo *)existingRow existingComponents:(NSArray *)existingComponents {
    	FLXSFlexDataGridColumnLevel* level=[rowPositionInfo getLevel:self.grid];
//    	float paddingY=[level getStyleValue:(@"horizontalGridLines")]?1:0;
//    	NSObject* item = rowPositionInfo.rowData;
    	FLXSRowInfo* row;
    	float rowHeight=rowPositionInfo.rowHeight;
    	if(!existingRow)
    	{
    		row= [self addRow:rowHeight scrollDown:scrollDown rowPositionInfo:rowPositionInfo];
    	}
    	else
    	{
    		self.grid.currentPoint.contentX=self.grid.currentPoint.leftLockedContentX=self.grid.currentPoint.rightLockedContentX=0;
    		row=existingRow;
    	}
    	if(self.grid.enableDefaultDisclosureIcon)
    	{
    		if((self.grid.lockDisclosureCell|| [self isInVisibleHorizontalRange:self.grid.currentPoint.contentX width:(level.nestIndent * (rowPositionInfo.rowNestLevel - 1))])
    			&& (!existingRow||![row paddingExists]))
                [self addPadding:rowPositionInfo.rowNestLevel row:row paddingHeight:rowHeight level:level forceRightLock:NO scrollPad:NO width:-1];
    		else if(!self.grid.lockDisclosureCell)
                self.grid.currentPoint.contentX+=level.nestIndent*(rowPositionInfo.rowNestLevel-1);
    		if((level.nextLevel||level.nextLevelRenderer))
    		{
    			if((self.grid.lockDisclosureCell|| [self isInVisibleHorizontalRange:self.grid.currentPoint.contentX width:level.nestIndent])
    				&& (!existingRow||![row disclosureExists]))
    			{
    				FLXSFlexDataGridExpandCollapseCell* disclosureCell= (FLXSFlexDataGridExpandCollapseCell*)[self.grid.rendererCache popInstance:level.expandCollapseCellRenderer subFactory:nil ];
    				disclosureCell.level = level;
                    [((UIView <FLXSIFlexDataGridCell> *) disclosureCell) setActualSizeWithWidth:level.maxDisclosureCellWidth andHeight:rowHeight];
    				disclosureCell.rowInfo=row;
    				[self addEventListeners:([self addCell:disclosureCell row:row existingComponent:nil ].componentInfo)];
    				[disclosureCell refreshCell];
    			}
    			else if(!self.grid.lockDisclosureCell)
                    self.grid.currentPoint.contentX+=level.maxDisclosureCellWidth;
    		}
    	}
    	NSArray* cols=[level getVisibleColumns:
                [[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE],[FLXSFlexDataGridColumn LOCK_MODE_LEFT],nil]
                ];
    	for( int colIndex = 0; colIndex < cols.count; colIndex++ )
    	{
    		FLXSFlexDataGridColumn* col= cols[colIndex];
    		if(([self isInVisibleHorizontalRange:self.grid.currentPoint.contentX width:col.width]
    			|| col.isLocked)
    			&& (!existingRow||![row columnCellExists:col]))
    		{
    			[self pushCell:col row:row existingComponents:existingComponents];
    		}
    		else if(!col.isLocked)
                self.grid.currentPoint.contentX+=col.width;
    	}
    	//now that we're done with the left locked and unlocked cols, do the right locked ones..
    	cols=[level getVisibleColumns:
                [[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_RIGHT],nil]
            ];
    	float wSoFar=0;
    	for(int colIndex = 0; colIndex < cols.count; colIndex++)
    	{
    		FLXSFlexDataGridColumn *col = cols[colIndex];
    		self.grid.currentPoint.contentX=self.width-wSoFar-col.width+1;
    		if(!existingRow||![row columnCellExists:col])
    			[self pushCell:col row:row existingComponents:existingComponents];
    		wSoFar+=col.width;
    	}
    	//do we have something right locked? if not, add something so we dont show a hole
    	if(![row rightLockedExists])
            [self addPadding:rowPositionInfo.rowNestLevel row:row paddingHeight:rowHeight level:level forceRightLock:YES scrollPad:NO width:-1];
    	[self.grid  placeComponents:row];
    	return row;
}

- (FLXSComponentAdditionResult *)pushCell:(FLXSFlexDataGridColumn *)column row:(FLXSRowInfo *)row existingComponents:(NSArray *)existingComponents {
    if(!column.width)column.width=75;
    FLXSClassFactory* rendererFactory=[column deriveRenderer:row.rowPositionInfo.rowType];
    BOOL isNewCell=NO;
    UIView<FLXSIFlexDataGridDataCell>* dataCell;
    BOOL found=NO;
    FLXSComponentInfo* existingComponent=nil;
    if(existingComponents)
    {
        existingComponent= [self getExistingCell:(NSMutableArray*)existingComponents rendererFactory:rendererFactory col:column];
        if(existingComponent)
        {
            found=YES;
            isNewCell=NO;
            dataCell=(UIView<FLXSIFlexDataGridDataCell>* )existingComponent.component;
        }
    }
    if(!found)
    {
        dataCell =(UIView<FLXSIFlexDataGridDataCell>* ) [self.grid .rendererCache popInstance:column.dataCellRenderer subFactory:rendererFactory];
        isNewCell=YES;
    }
    dataCell.rendererFactory = rendererFactory;
    dataCell.level= [row.rowPositionInfo getLevel:self.grid];
    dataCell.rowInfo =row;
    dataCell.columnFLXS =column;
    [dataCell setActualSizeWithWidth:column.width andHeight:row.height];
    dataCell.wordWrap=column.wordWrap;
    FLXSComponentAdditionResult* result= [self addCell:dataCell row:row existingComponent:existingComponent];
    if(row.isDataRow && isNewCell)
        [self addEventListeners:result.componentInfo];
    [dataCell refreshCell];
    return result;
}

-(void)gridMouseOut
{
   //no mouseout in ios
}
-(void)onExpandCollapse:(NSNotification*)ns
{
    FLXSEvent *event = (FLXSEvent *)[ns.userInfo objectForKey:@"event"];
    //in client mode, do the expand collapse
	UIView<FLXSIFlexDataGridCell>* disclosureCell=(UIView<FLXSIFlexDataGridCell>* )event.target;
	[self handleExpandCollapse:disclosureCell.iExpandCollapseComponent];
}

-(void)handleExpandCollapse:(UIView<FLXSIExpandCollapseComponent>*)disclosureCell
{
    	NSObject* expandingDataItem=disclosureCell.rowInfo.data;
    	FLXSFlexDataGridColumnLevel* level = disclosureCell.level;
    	if(!disclosureCell.hasChildren)return;
    	FLXSFlexDataGridEvent* evt;
    	BOOL wasOpen=NO;
    	if(![level isItemOpen:expandingDataItem])
    	{
    		wasOpen=NO;
    		evt = [[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent ITEM_OPENING] andGrid:level.grid andLevel:level andColumn:nil andCell:disclosureCell.cellFLXS andItem:expandingDataItem andTriggerEvent:nil andBubbles:NO andCancelable:NO ];
    		[level dispatchEvent:evt];
    	}
    	else
    	{
    		wasOpen=YES;
    		evt = [[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent ITEM_CLOSING] andGrid:level.grid andLevel:level andColumn:nil andCell:disclosureCell.cellFLXS andItem:expandingDataItem andTriggerEvent:nil andBubbles:NO andCancelable:NO ];
    		[level dispatchEvent:evt];
    	}
    	if([evt isDefaultPrevented])
    	{
    		return;
    	}
    	if(!disclosureCell.level.isClientItemLoadMode)
    	{
    		//in server mode, wait for data to come down from the server to load details
    		if(![self isLoading:expandingDataItem level:disclosureCell.level useSelectedKeyField:NO ] && !self.grid.enableVirtualScroll)
    		{
    			FLXSExtendedFilterPageSortChangeEvent* nested=
                        [[FLXSExtendedFilterPageSortChangeEvent alloc] initWithType:[FLXSExtendedFilterPageSortChangeEvent ITEM_LOAD] andFilter:([self createFilter:level.nextLevel parentObject:expandingDataItem]) andBubbles:NO andCancelable:NO ];
    [disclosureCell.level dispatchEvent:nested];
    			FLXSItemLoadInfo* itemLoadInfo= [[FLXSItemLoadInfo alloc] initWithItem:expandingDataItem andLevel:level andHasLoaded:NO ];
    			itemLoadInfo.pageIndex = 0;
    			[self.loadedItems addObject:itemLoadInfo];
    		}
    		else
    		{
    			[self expandCollapse:expandingDataItem rowPositionInfo:disclosureCell.rowInfo.rowPositionInfo forceScrollBar:NO ];
    		}
    	}
    	else
    	{
    		[self expandCollapse:expandingDataItem rowPositionInfo:disclosureCell.rowInfo.rowPositionInfo forceScrollBar:NO ];
    	}
    	if(wasOpen)
    	{
    		[level dispatchEvent:([[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent ITEM_CLOSE] andGrid:level.grid andLevel:level andColumn:nil andCell:disclosureCell.cellFLXS andItem:expandingDataItem andTriggerEvent:nil andBubbles:NO andCancelable:NO ]) ];
    	}
    	else
    	{
    		[level dispatchEvent:([[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent ITEM_OPEN] andGrid:level.grid andLevel:level andColumn:nil andCell:disclosureCell.cellFLXS andItem:expandingDataItem andTriggerEvent:nil andBubbles:NO andCancelable:NO ]) ];
    	}
    	[self.grid  invalidateCells];
    	[self resizeFillerCells];
}

-(BOOL)gotoRow:(int)rowIndex
{
    	if(rowIndex>=0 && rowIndex<[self.itemVerticalPositions count])
    	{
    		rowIndex=rowIndex>0?rowIndex-1:0    ;
            FLXSRowPositionInfo* itemPosition = self.itemVerticalPositions[rowIndex];
    		[self gotoVerticalPosition:itemPosition.verticalPosition];
    		return YES;
    	}
    	return NO;
}

-(void)selectText:(NSString*)txt
{
//    	if(!txt)return;
//    	txt=[txt lowercaseString];
//    	for(FLXSRowInfo* row in self.rows)
//    	{
//    		for(FLXSComponentInfo* cell in row.cells)
//    		{
//    			if(row.isDataRow)
//    			{
//    				UIView<FLXSIFlexDataGridCell>* fCell = cell.component as FLXSIFlexDataGridCell;
//    				if(fCell)
//    				{
//    					IUITextField* txtFld = fCell.renderer as IUITextField;
//    					if(txtFld)
//    					{
//    						if(!txtFld.text)continue;
//    						NSString* txtFldtext=[txtFld.text toLowerCase];
//    						int idx=[txtFldtext indexOf:txt];
//    						if(idx>=0)
//    						{
//    							fCell.currentBackgroundColors=[fCell getStyleValue:(@"selectionColorFLXS")];
//    						}
//    					}
//    				}
//    			}
//    		}
//    	}
}

- (NSArray *)quickFind:(NSString *)whatToFind flat:(NSObject *)flat level:(FLXSFlexDataGridColumnLevel *)level result:(NSArray *)result searchColumns:(NSArray *)searchCols breakAfterFind:(BOOL)breakAfterFind captureColumns:(BOOL)captureCols {
    //
    //	if(!whatToFind)return [];
    //	if(!flat)flat=[self getRootFlat];
    //	if(!level)level=grid.columnLevel;
    //	if(!result)result= [[NSMutableArray alloc] init]
    //	if(!searchCols || searchCols.count==0)searchCols=[level getVisibleColumns];
    //	float itemIndex=0;
    //	for(NSObject* item in flat)
    //	{
    //		for(FLXSFlexDataGridColumn* col in searchCols)
    //		{
    //			NSString* txt=[col itemToLabel:item];
    //			if(txt && [txt toLowerCase[] indexOf:([whatToFind toLowerCase])]>=0)
    //			{
    //				if(captureCols)
    //				{
    //					[result addObject:({@"item":item) :(@"col":col})];
    //				}
    //				else
    //				{
    //					[result addObject:item];
    //				}
    //				if(breakAfterFind)
    //					break;
    //			}
    //		}
    //		if(level.nextLevel)
    //		{
    //			NSObject* nextFlat=[self filterPageSort:([level getChildren:item]) :level :item :YES :NO :YES];
    //			[self quickFind:whatToFind :nextFlat :level.nextLevel :result];
    //		}
    //	}
    //	return result;
    return nil;
}

- (BOOL)gotoItem:(NSObject *)item highlight:(BOOL)highlight useItemKeyForCompare:(BOOL)useItemKeyForCompare level:(FLXSFlexDataGridColumnLevel *)level rebuild:(BOOL)rebuild {
    //	if(self.grid.enableVirtualScroll)throw [[Error alloc] initWithType:(@"This method is not supported when enableVirtualScroll=YES")];
    //	if(!level)level=grid.columnLevel;
    //	for(FLXSRowPositionInfo* rowPositionInfo in self.itemVerticalPositions)
    //	{
    //		FLXSFlexDataGridColumnLevel* rowLevel=[FLXSRowPositionInfo getLevel:self.grid];
    //		if( rowPositionInfo.isDataRow
    //			&&
    //			((rowLevel==level && [rowLevel isItemEqual:item :rowPositionInfo.rowData :useItemKeyForCompare]) ||
    //    			(!useItemKeyForCompare &&([item isEqual:rowPositionInfo.rowData])))
    //			)
    //		{
    //			[self gotoRow:(FLXSRowPositionInfo.rowIndex+1)];
    //			if(highlight)
    //			{
    //				[self validateNow];
    //				for(FLXSRowInfo* row in rows)
    //				{
    //					if(row.rowPositionInfo==rowPositionInfo)
    //					{
    //						for(FLXSComponentInfo* cell in row.cells)
    //						{
    //							UIView<FLXSIFlexDataGridCell>* fdgc=(cell.component as FLXSIFlexDataGridCell)
    //if(fdgc)
    //							{
    //								grid._currentCell=fdgc;
    //								[self.grid  highlightRow:fdgc :row :YES];
    //								return YES;
    //							}
    //						}
    //					}
    //				}
    //			}
    //			return YES;
    //		}
    //	}
    //	if(!rebuild)
    //		return NO;
    //	//self means we have not build the FLXSRowPositionInfo for self yet
    //	Array* stack= [[NSMutableArray alloc] init]
    //	[self getObjectStack:item :stack :useItemKeyForCompare];
    //	for(ItemPositionInfo* itemPositionInfo in stack)
    //	{
    //		if(itemPositionInfo.level.nextLevel && ![itemPositionInfo.level isItemOpen:itemPositionInfo.item])
    //			[self addOpenItem:itemPositionInfo.item];
    //		int pageIndex=itemPositionInfo.pageIndex;
    //		if(pageIndex!=-1)
    //		{
    //			if(!self.grid._itemFilters[itemPositionInfo.item])
    //			{
    //				grid._itemFilters[itemPositionInfo.item]=[[AdvancedFilter alloc] init];
    //			}
    //			grid._itemFilters[itemPositionInfo.item].pageIndex=pageIndex;
    //			if(itemPositionInfo.level.parentLevel==nil)
    //			{
    //				//were at root..
    //				grid.pagerControl.pageIndex=pageIndex;
    //				[self.grid  validateNow];
    //				//make sure we have rows...
    //				[self gotoItem:item :highlight :useItemKeyForCompare :level :NO];
    //				//hopefully now we should have our row position info built.
    //			}
    //		}
    //	}
    //	return YES;
    return  NO;
}

- (BOOL)getObjectStack:(NSArray *)itemToFind stackSoFar:(NSMutableArray *)stackSoFar useItemKeyForCompare:(BOOL)useItemKeyForCompare flat:(NSArray *)flat level:(FLXSFlexDataGridColumnLevel *)level {
    if(!flat)flat=[self getRootFlat];
    if(!level)level=self.grid.columnLevel;
    int itemIndex=0;
    for(NSObject* item in flat)
    {
        if([level isItemEqual:itemToFind rowData:item useItemKeyForCompare:useItemKeyForCompare])
        {
            [stackSoFar addObject:([[FLXSItemPositionInfo alloc] initWithItem:item andLevel:level andPageIndex:(level.enablePaging ? itemIndex / level.pageSize : -1) andItemIndex:itemIndex])];
            return YES;
        }
        else if(level.nextLevel)
        {
            NSArray* nextFlat= [self filterPageSort:([level getChildren:item filter:NO page:NO sort:NO ]) level:level parentObj:item applyFilter:YES applyPaging:NO applySort:YES pages:nil updatePager:NO ];
            if([self getObjectStack:itemToFind stackSoFar:stackSoFar useItemKeyForCompare:useItemKeyForCompare flat:nextFlat level:level.nextLevel])
            {
                [stackSoFar addObject:([[FLXSItemPositionInfo alloc] initWithItem:item andLevel:level andPageIndex:(level.enablePaging ?
                        itemIndex % level.pageSize : -1)             andItemIndex:itemIndex])];
                return YES;
            }
        }
        itemIndex++;
    }
    return NO;
}

- (void)scrollToExistingRow:(float)vsp scrollDown:(BOOL)scrollDown {
    if((self.verticalScrollPosition!=vsp) && (vsp<=(self.maxVerticalScrollPosition+self.grid.columnLevel.rowHeight)))
    {
        self.verticalScrollPosition=vsp;
        self.grid.traceValue=[NSString stringWithFormat:@"%f",vsp];
        [self recycle:self.grid.columnLevel scrollDown:scrollDown scrollDelta:0 scrolling:NO ];
        [self.grid  synchronizeLockedVerticalScroll];
    }
}

-(BOOL)isOutOfVisibleArea:(FLXSRowInfo*)row
{
    return NO;
}

- (BOOL)isYOutOfVisibleArea:(float)numY numH:(float)numH {
    return NO;
}

-(void)gotoVerticalPosition:(float)vsp
{
    	if(self.grid.dataProviderFLXS ==nil)
    	{
    		_verticalScrollPending=vsp;
    		[self doInvalidate];
    		return;
    	}
    	if(vsp<0)vsp=0;
    	if((vsp+self.height)>[self calculateTotalHeightNoParam])
//                && !([self isKindOfClass:[FLXSPrintFlexDataGridBodyContainer class]] ))
    	{
    		vsp=MAX(0 ,([self calculateTotalHeightNoParam]-self.height+self.grid.columnLevel.rowHeight));
    	}
    	if(self.verticalScrollPosition!=vsp)
    	{
            self.verticalScrollPosition=vsp;
    		_drawDirty=YES;
    		_recreateRows=NO;
    		[self doInvalidate];
    	}
}

- (BOOL)isLoading:(NSObject *)item level:(FLXSFlexDataGridColumnLevel *)level useSelectedKeyField:(BOOL)useSelectedKeyField {
//    return (findLoadingInfo(item, level, useSelectedKeyField) !=null)
    return [self findLoadingInfo:item level:level useSelectedKeyField:useSelectedKeyField] !=nil;

}

- (void)setChildData:(NSObject *)item children:(NSArray *)children level:(FLXSFlexDataGridColumnLevel *)level totalRecords:(int)totalRecords useSelectedKeyField:(BOOL)useSelectedKeyField {
    	[self.grid  clearFlattenedCache];
    	for(FLXSItemLoadInfo* loadingItem in self.loadedItems)
    	{
    		if([loadingItem isEqual:item levelToCompare:level useSelectedKeyField:useSelectedKeyField])
    		{
    			//found our guy...
    			BOOL addToSelection=NO;
    			if(!self.grid.enableSelectionExclusion && self.grid.enableSelectionCascade)
    			{
    				if([loadingItem.level isItemSelected:loadingItem.item useExclusion:YES ])
    				{
    					addToSelection=YES;
    					;
    				}
    			}
    			loadingItem.totalRecords = (totalRecords==-1)? [self.grid getLength:children]:totalRecords;
    			if(loadingItem.level.childrenCountField)
    			{
    				if([loadingItem.item respondsToSelector:NSSelectorFromString(loadingItem.level.childrenCountField)])
    				{
    					[loadingItem.item setValue:[NSNumber numberWithInt:loadingItem.totalRecords] forKey:loadingItem.level.childrenCountField];
                        UIView<FLXSIFlexDataGridCell>* iexpCell= [self getCellForRowColumn:loadingItem.item column:nil includeExp:YES ];
    					if(iexpCell)
    					{
    						[iexpCell refreshCell];
    					}
    				}
    			}
    			NSMutableArray* destColl = [[loadingItem.level getChildren:loadingItem.item filter:NO page:NO sort:NO ] mutableCopy];
                [destColl removeAllObjects];
    			for(NSObject* child in children)
    			{
                    [destColl addObject:child];
                    if(addToSelection&&loadingItem.level.nextLevel)
    				{
    					[loadingItem.level.nextLevel addSelectedItem:child];
    				}
    			}
                [loadingItem.item setValue:destColl forKey:loadingItem.level.childrenField];
                if(!loadingItem.hasLoaded)
    			{
    				loadingItem.hasLoaded=YES;
    				if(loadingItem.totalRecords>0)
    					[self expandCollapse:item rowPositionInfo:nil forceScrollBar:NO ];
    			}
    			else
    			{
    				[self expandCollapse:item rowPositionInfo:nil forceScrollBar:NO ];
    				[self expandCollapse:item rowPositionInfo:nil forceScrollBar:NO ];
    			}
    			break;
    		}
    	}
    	if(self.grid.enableDynamicLevels)
    	{
    		[self.grid ensureLevelsCreated:nil level:nil ];
    	}
}

- (void)expandCollapse:(NSObject *)expandingDataItem rowPositionInfo:(FLXSRowPositionInfo *)rowPositionInfo forceScrollBar:(BOOL)forceScrollBar {
    	//BOOL pushUp=NO;
    	FLXSRowPositionInfo* expanding;
    	if(rowPositionInfo==nil)
    	{
    		for(FLXSRowPositionInfo* vrowPositionInfo in self.itemVerticalPositions)
    		{
    			if([vrowPositionInfo.rowData isEqual: expandingDataItem] &&
    				(vrowPositionInfo.rowType==[FLXSRowPositionInfo ROW_TYPE_DATA]))
    			{
    				rowPositionInfo=vrowPositionInfo;
    				break;
    			}
    		}
    	}
    	FLXSFlexDataGridColumnLevel* rowPosLevel=[rowPositionInfo getLevel:self.grid];
    	if([rowPosLevel isItemOpen:expandingDataItem])
    	{
    		[self removeOpenItem:expandingDataItem rowPositionInfo:rowPositionInfo];
            if(self.grid.enableVirtualScroll)return;
    		expanding=rowPositionInfo;
            NSMutableArray* dataItemsRemoved= [[NSMutableArray alloc] init]  ;
    		[dataItemsRemoved addObject:expandingDataItem];
    		int howManyToRemove=0;
    		float heightRemoved=0;
    		//we've hit... so start removing from here
    		FLXSRowPositionInfo* nextRow = [self.itemVerticalPositions count]-1>rowPositionInfo.rowIndex?self.itemVerticalPositions[rowPositionInfo.rowIndex+1]:nil;
            NSMutableArray* rowPositionsToRemove= [[NSMutableArray alloc] init];
    		while(nextRow && (nextRow.rowNestLevel>rowPositionInfo.rowNestLevel))
    		{
    			//remove
    			howManyToRemove++;
    			if([rowPositionsToRemove indexOfObject:nextRow]==NSNotFound)
    			{
    				[rowPositionsToRemove addObject:nextRow];
    				[dataItemsRemoved addObject:nextRow.rowData];

    					if(nextRow.isDataRow&&
                                [[nextRow getLevel:self.grid ] isItemOpen:nextRow.rowData])
    					{
    						[self removeOpenItem:nextRow.rowData rowPositionInfo:nextRow];
    					}


    			}
                nextRow = [self.itemVerticalPositions count]>rowPositionInfo.rowIndex+howManyToRemove
                        ?self.itemVerticalPositions[rowPositionInfo.rowIndex+howManyToRemove]:nil;
            }
    			howManyToRemove--;
    			if(howManyToRemove>0)
    			{
    				NSArray* removed=[self.itemVerticalPositions subarrayWithRange:NSMakeRange(rowPositionInfo.rowIndex+1,howManyToRemove)];
                    [self.itemVerticalPositions removeObjectsInArray:removed];
                    nextRow= [self.itemVerticalPositions count]-1>rowPositionInfo.rowIndex?self.itemVerticalPositions[rowPositionInfo.rowIndex+1]:nil;
                    NSMutableArray* rowsToRemove= [[NSMutableArray alloc] init];
    				for(FLXSRowInfo* row in self.rows)
    				{
    					if(row.isChromeRow && ([dataItemsRemoved indexOfObject:row.data]!=NSNotFound))
    					{
    						[rowsToRemove addObject:row];
    					}
    					else if(row.isRendererRow && ([dataItemsRemoved indexOfObject:row.data]!=NSNotFound))
    					{
    						[rowsToRemove addObject:row];
    					}
    					else
    					{
    						for(FLXSRowPositionInfo* toRemove in rowPositionsToRemove)
    						{
    							if([row.rowPositionInfo isEqual:toRemove])
    							{
    								[rowsToRemove addObject:row];
    								break;
    							}
    						}
    					}
    				}
    				if(nextRow)
    					heightRemoved = nextRow.verticalPosition-rowPositionInfo.verticalPosition-rowPositionInfo.rowHeight;
    				else if(removed.count>0)
                        heightRemoved = ((((FLXSRowPositionInfo *)removed[removed.count-1]).verticalPosition
                                +((FLXSRowPositionInfo *)removed[removed.count-1]).rowHeight)-(expanding.verticalPosition+expanding.rowHeight));
    				for(FLXSRowInfo* row in rowsToRemove)
    				{
    					[self.rows removeObjectAtIndex:([self.rows indexOfObject:row])];
    					[self saveRowInCache:row];
    				}
                    [self adjustRowPositions:rowPositionInfo howManyToRemove:(0 - howManyToRemove) heightRemoved:(0 - heightRemoved)];
    				//if we have removed enough rows that there is nothing below us, need to draw more rows...
    				[self setVisibleRange];
    				FLXSRowPositionInfo* visibleRangeEnd=((FLXSRowPositionInfo *)_visibleRange[1]);
                    [_visibleRange setObject:[self getItemAtPosition:(visibleRangeEnd.verticalPosition+heightRemoved)] atIndexedSubscript:1];

    				if(!_visibleRange[1])
                        [_visibleRange setObject:visibleRangeEnd atIndexedSubscript:1];

    				if(![visibleRangeEnd isEqual:((FLXSRowPositionInfo *)_visibleRange[1])])
    				{
    					self.grid.currentPoint.contentY=((FLXSRowInfo *)self.rows[self.rows.count-1]).y+
                        ((FLXSRowInfo *)self.rows[self.rows.count-1]).height;
    				}
    				else
    				{
//    					pushUp=YES;
    				}
    			}
    		}

    		else
    		    {
    			[self addOpenItem:expandingDataItem rowPositionInfo:rowPositionInfo];
    			if(self.grid.enableVirtualScroll)return;
    			expanding=rowPositionInfo;
//    			int howManyToAdd=0;
//    			float heightAdded=0;
                NSMutableArray* addedRows= [[NSMutableArray alloc] init];
    			NSArray* flat = rowPosLevel.nextLevelRenderer? [[NSArray alloc] initWithObjects:rowPositionInfo.rowData,nil]:
                        [rowPosLevel getChildren:rowPositionInfo.rowData filter:NO page:NO sort:NO ];
    			float htAdded= [self calculateTotalHeight:flat level:(rowPosLevel.nextLevelRenderer ? rowPosLevel : rowPosLevel.nextLevel) heightSoFar:(rowPositionInfo.verticalPosition + expanding.rowHeight) nestLevel:(rowPositionInfo.rowNestLevel + 1) expanding:rowPositionInfo addedRows:addedRows parentObject:expandingDataItem isRecursive:NO ];
                    [self adjustRowPositions:rowPositionInfo howManyToRemove:(int)addedRows.count heightRemoved:htAdded];
                NSArray * reverseAddedRows = [[addedRows reverseObjectEnumerator] allObjects];
    			for(FLXSRowPositionInfo* newPos in reverseAddedRows)
    			{
    				[self.itemVerticalPositions insertObject:newPos atIndex:rowPositionInfo.rowIndex+1];
    			}
    			self.grid.currentPoint.contentY= expanding.verticalPosition+ expanding.rowHeight;
    		}
    		if(self.grid.showSpinnerOnFilterPageSort)
    		{
    			[self.grid  hideSpinner];
    		}
    		if(forceScrollBar)
    		{
    			if(self.height<_calculatedTotalHeight)
    			{
    				if((self.verticalScrollPosition+self.height)>_calculatedTotalHeight)
    				{
                        self.verticalScrollPosition=_calculatedTotalHeight-self.height;
    				}
    				[self resizeFillerCells];
    				[self.grid  synchronizeLockedVerticalScroll];
    			}
    		}
    		[self removeAllComponents:YES];
    		if(forceScrollBar)
    		{
    			//should not be required for IOS

    		}
    		[self.grid  synchronizeLockedVerticalScroll];
    		[self drawRows :NO];
            [self recycleH:self.grid.columnLevel scrollRight:YES ];
    		self.grid.currentCell = [self getCellForRowColumn:expanding.rowData column:nil includeExp:YES ];
    		if(self.grid.currentCell&&self.grid.currentCell.userInteractionEnabled)
    			[self.grid highlightRow:self.grid.currentCell row:self.grid.currentCell.rowInfo highLight:YES highLightColor:0];
}

- (void)adjustRowPositions:(FLXSRowPositionInfo *)rowPositionInfo howManyToRemove:(int)howManyToRemove heightRemoved:(int)heightRemoved {
        FLXSRowPositionInfo* nextRow;
        for (int pointer=rowPositionInfo.rowIndex+1;pointer<[self.itemVerticalPositions count];pointer++)
        {
            nextRow = self.itemVerticalPositions[pointer];
            nextRow.rowIndex += howManyToRemove;
            nextRow.verticalPosition += heightRemoved;
        }
        _calculatedTotalHeight+=heightRemoved;
        CGSize sz= CGSizeMake([self.grid .columnLevel getSumOfColumnWidths:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE],nil]]-1, [self calculateTotalHeightNoParam]  );
        [self setContentSize:sz];

        [self checkAutoAdjust];
        for(FLXSRowInfo* row in self.rows)
        {
            row.y=row.rowPositionInfo.verticalPosition;
        }
        //[self setNeedsDisplay];
}

-(void)invalidateCalculatedHeight
{
    _heightCalculated=NO;
}
-(void)setContentSize:(CGSize)contentSize {
    [super setContentSize:contentSize];
}
-(BOOL)setCurrentRowAtScrollPosition:(float)vsp
{
    NSObject* item = self.currentRowPointer?self.currentRowPointer.rowData:nil;
    int currentRowType = self.currentRowPointer?self.currentRowPointer.rowType:-1;
    self.currentRowPointer=[self getItemAtPosition:vsp];
    return (self.currentRowPointer!=nil && ((![item isEqual: self.currentRowPointer.rowData]) ||
            (currentRowType!=self.currentRowPointer.rowType)||self.grid.recalculateSeedOnEachScroll));

}

- (NSArray *)getFilteredPagedSortedData:(FLXSKeyValuePairCollection *)dictionary applyFilter:(BOOL)applyFilter applyPaging:(BOOL)applyPaging applySort:(BOOL)applySort pages:(NSArray *)pages flatten:(BOOL)flatten {
    NSMutableArray* result=[[NSMutableArray alloc] init];
    [self gatherFilteredPagedSortedData:dictionary result:result flat:([self getRootFlat]) level:self.grid.columnLevel parentObject:nil applyFilter:applyFilter applyPaging:applyPaging applySort:applySort pages:pages flatten:flatten];
    return result;
}

- (void)gatherFilteredPagedSortedData:(FLXSKeyValuePairCollection *)dictionary result:(NSMutableArray *)result flat:(NSArray *)flat level:(FLXSFlexDataGridColumnLevel *)level parentObject:(NSObject *)parentObject applyFilter:(BOOL)applyFilter applyPaging:(BOOL)applyPaging applySort:(BOOL)applySort pages:(NSArray *)pages flatten:(BOOL)flatten {
    flat= [self filterPageSort:flat level:level parentObj:parentObject applyFilter:applyFilter applyPaging:applyPaging applySort:applySort pages:pages updatePager:NO ];
    for(NSObject* item in flat)
    {
        [dictionary addItem:item value:level];
        [result addObject:item];
        if(level.nextLevel && flatten)
            [self gatherFilteredPagedSortedData:dictionary result:result flat:([level getChildren:item filter:NO page:NO sort:NO ]) level:level.nextLevel parentObject:item applyFilter:applyFilter applyPaging:applyPaging applySort:applySort pages:pages flatten:flatten];
    }
}

-(NSArray*)getRootFlat
{
    return self.grid.dataProviderFLXS;
}

- (float)calculateTotalHeight:(NSArray *)flat level:(FLXSFlexDataGridColumnLevel *)level heightSoFar:(float)heightSoFar nestLevel:(int)nestLevel expanding:(FLXSRowPositionInfo *)expanding addedRows:(NSArray *)addedRows parentObject:(NSObject *)parentObject isRecursive:(BOOL)isRecursive {
    if(_heightCalculated && (expanding==nil) ) //if we are not calculating the seed.
        return _calculatedTotalHeight;
    if(self.grid.variableRowHeight && [FLXSFlexDataGrid measurerText].superview==nil)
        [self.grid  addChild:[FLXSFlexDataGrid measurerText]];
    if(self.grid.variableRowHeightUseRendererForCalculation && self.variableRowHeightRenderers==nil && !isRecursive)//self is not a recursive call to ourselves.
        self.variableRowHeightRenderers=[[FLXSKeyValuePairCollection alloc] init];
    int totalHeight=0;
    if(!flat)
    {
        if(!expanding)
        {
            self.itemVerticalPositions = [[NSMutableArray alloc] init];
        }
        flat = [self getRootFlat];
    }
    if(!level)
    {
        level=self.grid.columnLevel;
    }
    if(level.isClientFilterPageSortMode)
    {
        flat= [self filterPageSort:flat level:level parentObj:parentObject applyFilter:YES applyPaging:YES applySort:YES pages:nil updatePager:((expanding == nil&& level.nestDepth == 1))];
    }
    float heightAdded=0;
    float htAdded=0;
    FLXSFlexDataGridColumnLevel* expandingLevel=expanding?[expanding getLevel:self.grid]:nil ;
    NSArray* sections;
    NSString* section;
    if(expanding && !expandingLevel.nextLevelRenderer)
    {
        sections = [expandingLevel.nextLevel.displayOrder componentsSeparatedByString:(@",")];
        for(section in sections)
        {
            htAdded= [self processSection:addedRows rowIndex:expanding.rowIndex parentObject:parentObject heightSoFar:heightSoFar level:level parentObject5:parentObject chromeType:([self getChromeType:section]) expanding:expanding expandingLevel:expandingLevel];
            totalHeight += htAdded;
            heightSoFar+= htAdded;
            if([section isEqual:@"body"])
                break;
        }
    }
    int itemIndex=0;
    int maxRows=[self.grid  getLength:flat];
    for (int rowPointer=0;rowPointer<maxRows;rowPointer++)
    {
        NSObject* item=flat[rowPointer];
        [self.parentMap addItem:item value:parentObject];
        if(item)
        {
            itemIndex++;
            if(!expanding)
            {
                heightAdded= [self addToVerticalPositions:item heightSoFar:heightSoFar level:level parent:parentObject rowType:[FLXSRowPositionInfo ROW_TYPE_DATA]];
            }
            else if(!expandingLevel.nextLevelRenderer)
            {
                heightAdded= [self addToExpandingPositions:addedRows parentRowIndex:expanding.rowIndex item:item heightSoFar:heightSoFar level:level parent:parentObject rowType:[FLXSRowPositionInfo ROW_TYPE_DATA]];
            }
            totalHeight+=heightAdded;
            heightSoFar+=heightAdded;
            BOOL open=( level.nextLevel||level.nextLevelRenderer) && [level isItemOpen:item];
            if(!open && level.nextLevel==nil)
            {
                if(self.grid.enableDynamicLevels && self.grid.dynamicLevelHasChildrenFunction(item))
                {
                    level.nextLevel = [self.grid .columnLevel clone:NO];
                    level.nextLevel.reusePreviousLevelColumns =YES;
                    [self.grid dispatchEvent:[[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent DYNAMIC_LEVEL_CREATED] andGrid:self.grid andLevel:level.nextLevel andColumn:nil andCell:nil andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ]];
                    [self.grid .columnLevel initializeLevel:self.grid];
                    [self.grid  reDraw];
                }
            }
            if(open)
            {
                if(level.nextLevelRenderer)
                {
                    if(!level.levelRendererHeight)
                    {
                        UIView* renderer = [level.nextLevelRenderer generateInstance];
                        level.levelRendererHeight=renderer.height;
                    }
                    if(!expanding)
                    {
                        heightAdded= [self addToVerticalPositions:item heightSoFar:heightSoFar level:level parent:parentObject rowType:[FLXSRowPositionInfo ROW_TYPE_RENDERER]];
                    }
                    else
                    {
                        heightAdded= [self addToExpandingPositions:addedRows parentRowIndex:expanding.rowIndex item:item heightSoFar:heightSoFar level:level parent:parentObject rowType:[FLXSRowPositionInfo ROW_TYPE_RENDERER]];
                    }
                    totalHeight+=heightAdded;
                    heightSoFar+=heightAdded;
                }
                else
                {
                    nestLevel++;
                    float nextLevel = 0;
                    NSArray* result= [level getChildren:item filter:NO page:NO sort:NO ];
                    if([self.grid  getLength:result]>0)
                    {
                        sections = [level.nextLevel.displayOrder componentsSeparatedByString:(@",")];
                        for(section in sections)
                        {
                            htAdded= [self processSection:addedRows rowIndex:(expanding ? expanding.rowIndex : -1) parentObject:item heightSoFar:heightSoFar level:level.nextLevel parentObject5:item chromeType:([self getChromeType:section]) expanding:expanding expandingLevel:expandingLevel];
                            totalHeight += htAdded;
                            heightSoFar+= htAdded;
                            if([section isEqual:@"body"])
                                break;
                        }
                        nextLevel= [self calculateTotalHeight:result level:level.nextLevel heightSoFar:heightSoFar nestLevel:nestLevel expanding:expanding addedRows:addedRows parentObject:item isRecursive:YES];
                        totalHeight += nextLevel;
                        heightSoFar+= nextLevel;
                        BOOL hit1=NO;
                        sections = [level.nextLevel.displayOrder componentsSeparatedByString:(@",")];
                        for(section in sections)
                        {
                            if(hit1)
                            {
                                htAdded= [self processSection:addedRows rowIndex:(expanding ? expanding.rowIndex : -1) parentObject:item heightSoFar:heightSoFar level:level.nextLevel parentObject5:item chromeType:([self getChromeType:section]) expanding:expanding expandingLevel:expandingLevel];
                                totalHeight += htAdded;
                                heightSoFar += htAdded;
                            }
                            if([section isEqual:@"body"])
                                hit1=YES;
                        }
                    }
                    nestLevel--;
                }
            }
        }
    }
    if(expanding && !expandingLevel.nextLevelRenderer)
    {
        BOOL hit=NO;
        sections = [expandingLevel.nextLevel.displayOrder componentsSeparatedByString:(@",")];
        for(NSString * section in sections)
        {
            if(hit)
            {
                htAdded= [self processSection:addedRows rowIndex:expanding.rowIndex parentObject:parentObject heightSoFar:heightSoFar level:level parentObject5:parentObject chromeType:([self getChromeType:section]) expanding:expanding expandingLevel:expandingLevel];
                totalHeight += htAdded;
                heightSoFar+= htAdded;
            }
            if([section isEqual:@"body"])
                hit=YES;
        }
    }
    if(!expanding)
    {
        if(nestLevel==0)
        {
            _heightCalculated=YES;
            _calculatedTotalHeight=totalHeight;
            self.verticalSpill=(_calculatedTotalHeight>self.height);
            [self checkAutoAdjust];
            CGSize sz= CGSizeMake([self.grid .columnLevel getSumOfColumnWidths:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE],nil]]-1, [self calculateTotalHeightNoParam]  );
            [self setContentSize:sz];
        }
    }
    if(self.grid.variableRowHeight&& [FLXSFlexDataGrid measurerText].superview!=nil)
        [[FLXSFlexDataGrid measurerText] removeFromSuperview];
    if(self.grid.variableRowHeightUseRendererForCalculation && self.variableRowHeightRenderers!=nil && !isRecursive)
    {
        [self clearVariableRowHeightRenderers];
    }
    return totalHeight;
}

-(void)clearVariableRowHeightRenderers
{
    //self is not a recursive call to ourselves, and we are done.
    for(NSObject* col in self.variableRowHeightRenderers.keys)
    {
        [((UIView *)[self.variableRowHeightRenderers getValue:col]) removeFromSuperview];
    }
    [self.variableRowHeightRenderers clear];
    self.variableRowHeightRenderers=nil;
}

- (float)processSection:(NSArray *)addedRows rowIndex:(int)rowIndex parentObject:(NSObject *)parentObject heightSoFar:(float)heightSoFar level:(FLXSFlexDataGridColumnLevel *)level parentObject5:(NSObject *)parentObject5 chromeType:(int)chromeType expanding:(FLXSRowPositionInfo *)expanding expandingLevel:(FLXSFlexDataGridColumnLevel *)expandingLevel {
//    float totalHeight=0;
    float heightAdded=0;
    if(chromeType==[FLXSRowPositionInfo ROW_TYPE_PAGER])
    {
        if(level.enablePaging)
        {
            if(!expanding)
            {
                heightAdded= [self addToVerticalPositions:parentObject heightSoFar:heightSoFar level:level parent:parentObject rowType:[FLXSRowPositionInfo ROW_TYPE_PAGER]];
            }
            else
                heightAdded= [self addToExpandingPositions:(NSMutableArray*)addedRows parentRowIndex:expanding.rowIndex item:parentObject heightSoFar:heightSoFar level:level parent:parentObject rowType:[FLXSRowPositionInfo ROW_TYPE_PAGER]];
        }
    }
    if(!level.reusePreviousLevelColumns)
    {
        if(chromeType==[FLXSRowPositionInfo ROW_TYPE_FILTER])
        {
            if(level.enableFilters)
            {
                if(!expanding)
                {
                    heightAdded= [self addToVerticalPositions:parentObject heightSoFar:heightSoFar level:level parent:parentObject rowType:[FLXSRowPositionInfo ROW_TYPE_FILTER]];
                }
                else
                    heightAdded= [self addToExpandingPositions:(NSMutableArray*)addedRows parentRowIndex:expanding.rowIndex item:parentObject heightSoFar:heightSoFar level:level parent:parentObject rowType:[FLXSRowPositionInfo ROW_TYPE_FILTER]];
            }
        }
        if(chromeType==[FLXSRowPositionInfo ROW_TYPE_HEADER])
        {
            if(!expanding)
            {
                heightAdded= [self addToVerticalPositions:parentObject heightSoFar:heightSoFar level:level parent:parentObject rowType:[FLXSRowPositionInfo ROW_TYPE_HEADER]];
            }
            else
                heightAdded= [self addToExpandingPositions:addedRows parentRowIndex:expanding.rowIndex item:parentObject heightSoFar:heightSoFar level:level parent:parentObject rowType:[FLXSRowPositionInfo ROW_TYPE_HEADER]];
        }
    }
    if(chromeType==[FLXSRowPositionInfo ROW_TYPE_FOOTER])
    {
        if(level.enableFooters)
        {
            if(!expanding)
            {
                heightAdded= [self addToVerticalPositions:parentObject heightSoFar:heightSoFar level:level parent:parentObject rowType:[FLXSRowPositionInfo ROW_TYPE_FOOTER]];
            }
            else
                heightAdded= [self addToExpandingPositions:addedRows parentRowIndex:expanding.rowIndex item:parentObject heightSoFar:heightSoFar level:level parent:parentObject rowType:[FLXSRowPositionInfo ROW_TYPE_FOOTER]];
        }
    }
    return heightAdded;
}

-(int)getChromeType:(NSString*)name
{
    if ([name isEqual: @"header"])
    {
        return [FLXSRowPositionInfo ROW_TYPE_HEADER];
    }
    else if ([name isEqual: @"footer"])
    {
        return [FLXSRowPositionInfo ROW_TYPE_FOOTER];
    }
    else if ([name isEqual: @"pager"])
    {
        return [FLXSRowPositionInfo ROW_TYPE_PAGER];
    }
    else if ([name isEqual: @"filter"])
    {
        return [FLXSRowPositionInfo ROW_TYPE_FILTER];
    }
    else if ([name isEqual: @"body"])
    {
        return [FLXSRowPositionInfo ROW_TYPE_DATA];
    }
       return [FLXSRowPositionInfo ROW_TYPE_DATA];
//    else
//        throw [[Error alloc] initWithType:(@"Invalid section specified for the displayOrder property " + name)];
    
}

-(void)checkAutoAdjust
{
    [self ensureAutoAdjustHeight];
}

-(void)ensureAutoAdjustHeight
{
    if(self.grid.enableHeightAutoAdjust)
    {
        float borderThickness= [[self.grid  getStyle:(@"borderThickness")] floatValue];
        float paddingBottom=[self.grid  hasBorderSide:(@"bottom")]?borderThickness:0;
        float requiredHt=MIN(_calculatedTotalHeight+self.grid.headerSectionHeight+(_calculatedTotalHeight==0?self.grid.columnLevel.rowHeight:0)+
                                    self.grid.footerRowHeight+paddingBottom + (0)
                                    + ((self.grid.noDataMessage&&(_calculatedTotalHeight==0))?
                        (self.grid.spinner&&self.grid.spinner.height?self.grid.spinner.height:2*self.grid.columnLevel.rowHeight):0)
                ,self.grid.maxAutoAdjustHeight);
        if(!isnan(requiredHt) && requiredHt!=self.grid.height)
        {
            self.grid.height = requiredHt;
            [self.grid setNeedsDisplay];
        }
    }
}

- (float)addToVerticalPositions:(NSObject *)item heightSoFar:(float)heightSoFar level:(FLXSFlexDataGridColumnLevel *)level parent:(NSObject *)parent rowType:(int)rowType {
    float heightAdded = [self.grid getRowHeight:item level:level rowType:rowType];
    float depth = 1;
    if(rowType==[FLXSRowPositionInfo ROW_TYPE_HEADER])
    {
        depth = [level getMaxColumnGroupDepth];
        //heightAdded/=depth;
        for(int i=1;i<depth;i++)
        {
            [self.itemVerticalPositions addObject:([[FLXSRowPositionInfo alloc] initWithRowData:item andRowIndex:(int)[self.itemVerticalPositions count] andVerticalPosition:heightSoFar andRowHeight:heightAdded andLevel:level andRowType:[FLXSRowPositionInfo ROW_TYPE_COLUMN_GROUP]])];
            heightSoFar+= heightAdded;
        }
    }
    [self.itemVerticalPositions addObject:([[FLXSRowPositionInfo alloc] initWithRowData:item andRowIndex:(int)[self.itemVerticalPositions count] andVerticalPosition:heightSoFar andRowHeight:heightAdded andLevel:level andRowType:rowType])];
    return heightAdded*depth;
}

- (float)addToExpandingPositions:(NSArray *)array parentRowIndex:(int)parentRowIndex item:(NSObject *)item heightSoFar:(float)heightSoFar level:(FLXSFlexDataGridColumnLevel *)level parent:(NSObject *)parent rowType:(int)rowType {
    float heightAdded = [self.grid getRowHeight:item level:level rowType:rowType];
    float depth = 1;
    if(rowType==[FLXSRowPositionInfo ROW_TYPE_HEADER])
    {
        depth = [level getMaxColumnGroupDepth];
        //heightAdded/=depth;
        for(int i=1;i<depth;i++)
        {
            [((NSMutableArray*)array) addObject:([[FLXSRowPositionInfo alloc] initWithRowData:item andRowIndex:(int)(parentRowIndex + array.count + 1) andVerticalPosition:heightSoFar andRowHeight:heightAdded andLevel:level andRowType:[FLXSRowPositionInfo ROW_TYPE_COLUMN_GROUP]])];
            heightSoFar+= heightAdded;
        }
    }
    [((NSMutableArray*)array) addObject:([[FLXSRowPositionInfo alloc] initWithRowData:item andRowIndex:(int)(parentRowIndex + array.count + 1) andVerticalPosition:heightSoFar andRowHeight:heightAdded andLevel:level andRowType:rowType])];
    return heightAdded*depth;
}

- (FLXSComponentAdditionResult *)addCell:(UIView *)component row:(FLXSRowInfo *)row existingComponent:(FLXSComponentInfo *)existingComponent {
    if(component.hidden)
        component.hidden=NO;
    FLXSComponentAdditionResult* result= [super addCell:component row:row existingComponent:existingComponent];
    if(self.currentRowPointer)
    {
        result.verticalSpill = (self.grid.currentPoint.contentY > (self.currentRowPointer.verticalPosition + self.height+1));
    }
    result.horizontalSpill=self.grid.currentPoint.contentX>([_visibleRangeH[1] floatValue]);
    if(row.rowPositionInfo.rowType == [FLXSRowPositionInfo ROW_TYPE_FILL])
    {
        [component.superview sendSubviewToBack:component];
        component.height = self.height-self.grid.isHScrollBarVisible ;
    }
    return result;
}

- (void)onHeaderCellClicked:(FLXSFlexDataGridHeaderCell *)headerCell triggerEvent:(FLXSEvent *)triggerEvent isMsc:(BOOL)isMsc useMsc:(BOOL)useMsc direction:(NSString *)direction {
    [super onHeaderCellClicked:headerCell triggerEvent:triggerEvent isMsc:isMsc useMsc:useMsc direction:direction];
    if(![headerCell.level isEqual:self.grid.columnLevel])
    {
        [self onChildHeaderClicked:headerCell];
    }
}

-(void)onChildHeaderClicked:(FLXSFlexDataGridHeaderCell*)headerCell
{
    if(headerCell.columnFLXS &&headerCell.columnFLXS.sortable)
    {
        /*NSObject* data=headerCell.rowInfo.data;
         [self expandCollapse:data :nil :NO];
         [self expandCollapse:data];
         */
        [self.grid  rebuildBody:NO];
    }
}

-(void)onSelectAllChanged:(FLXSEvent*)event
{
    [super onSelectAllChanged:event];
    [self.grid  invalidateSelection];
}

- (FLXSRowInfo *)addRow:(float)ht scrollDown:(BOOL)scrollDown rowPositionInfo:(FLXSRowPositionInfo *)rowPositionInfo {
    FLXSRowInfo* result= [super addRow:ht scrollDown:scrollDown rowPositionInfo:rowPositionInfo];
    self.verticalSpill=self.grid.currentPoint.contentY>self.height;
    return result;
}

-(NSMutableArray*)getAllRows
{
    NSMutableArray* newRows=[self.rows mutableCopy];
    for(FLXSRowInfo* fillerRow in self.fillerRows)
    {
        [newRows addObject:fillerRow];
    }
    for (NSString* key in _rowCache)
    {
        for(FLXSRowInfo* row in _rowCache[key])
            [newRows addObject:row];
    }
    return newRows;
}

-(void)nextPage
{
    [self gotoVerticalPosition:(self.verticalScrollPosition+self.height)];
}

-(NSArray*)onScreenRows
{
    if(_drawDirty)
    {
        [[self layer] display];
    }
    NSMutableArray* osRows= [[NSMutableArray alloc] init];
    for(FLXSRowInfo* row in self.rows)
    {
        if(row.y >=self.verticalScrollPosition && (row.y<(self.verticalScrollPosition+self.height)))
            [osRows addObject:row];
    }
    return osRows;
}

-(int)getColumnGroupDepth:(FLXSRowInfo*)row
{
    int index = (int)[self.itemVerticalPositions indexOfObject:row.rowPositionInfo];
    int MAX_COL_GROUP_DEPTH=5;
    int depth=1;
    for(int i=index;i<MAX_COL_GROUP_DEPTH;i++)
    {
        if(i+index>[self.itemVerticalPositions count])
        {
            return depth;
        }
        if(((FLXSRowPositionInfo *)self.itemVerticalPositions[i+index]).isHeaderRow)
        {
            return depth;
        }
        depth++;
    }
    return depth;
}

-(int)numTotalRows
{
    return (int)[self.itemVerticalPositions count];
}

-(void)clearAllCollections
{
    if(self.grid.clearOpenItemsOnDataProviderChange)
        [self clearOpenItems];
}

-(void)clearOpenItems
{
    [self.openItems removeAllObjects];
    self.loadedItems=[[NSMutableArray alloc] init];
}

- (void)addOpenItem:(NSObject *)item rowPositionInfo:(FLXSRowPositionInfo *)rowPositionInfo {
    if(rowPositionInfo && [rowPositionInfo getLevel:self.grid].selectedKeyField)
    {
        FLXSFlexDataGridColumnLevel* lvl=[rowPositionInfo getLevel:self.grid];
        for(NSObject* openItem in self.grid.openItems)
        {
            if([[FLXSExtendedUIUtils resolveExpression:item expression:lvl.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ]
                    isEqual:[FLXSExtendedUIUtils resolveExpression:openItem expression:lvl.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ]])
            {
                return;
                //we already have an open item with self id.
            }
        }
        if(![self.openItems containsObject:item])
            [self.openItems addObject:item];
    }
    else if(![self.openItems containsObject:item])
        [self.openItems addObject:item];
}

- (void)removeOpenItem:(NSObject *)item rowPositionInfo:(FLXSRowPositionInfo *)rowPositionInfo {
    if(rowPositionInfo && [rowPositionInfo getLevel:self.grid].selectedKeyField)
    {
        FLXSFlexDataGridColumnLevel* lvl=[rowPositionInfo getLevel:self.grid];
        for(NSObject* openItem in self.grid.openItems)
        {
            if([[FLXSExtendedUIUtils resolveExpression:item expression:lvl.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ]
                    isEqual:[FLXSExtendedUIUtils resolveExpression:openItem expression:lvl.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ]])
            {
                [self.openItems removeObjectAtIndex:([self.openItems indexOfObject:openItem])] ;
                return;
            }
        }
    }
    else if([self.openItems containsObject:item])
        [self.openItems removeObjectAtIndex:([self.openItems indexOfObject:item])];
}
-(void)dealloc{
    self.backgroundForFillerRows=nil;
    self.refreshControl=nil;
}
@end

