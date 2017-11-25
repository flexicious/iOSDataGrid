#import <QuartzCore/QuartzCore.h>
#import "FLXSFlexDataGridContainerBase.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSFlexDataGridHeaderCell.h"
#import "FLXSFlexDataGridHeaderSeperator.h"
#import "FLXSIFilterControl.h"
#import "FLXSFlexDataGridColumnGroup.h"
#import "FLXSIFlexDataGridCell.h"
#import "FLXSRowInfo.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSComponentInfo.h"
#import "FLXSFlexDataGridDataCell.h"
#import "FLXSScrollEvent.h"
#import "FLXSScrollEventDetail.h"
#import "FLXSKeyValuePairCollection.h"
#import "FLXSInsertionLocationInfo.h"
#import "FLXSFlexDataGridBodyContainer.h"
#import "FLXSRendererCache.h"
#import "FLXSFilterPageSortChangeEvent.h"
#import "FLXSComponentAdditionResult.h"
#import "FLXSLockedContent.h"
#import "FLXSItemLoadInfo.h"
#import "FLXSFlexDataGridHeaderContainer.h"
#import "FLXSIExtendedPager.h"
#import "FLXSExtendedFilterPageSortChangeEvent.h"
#import "FLXSTextInput.h"
#import "FLXSMultiSelectComboBox.h"
#import "FLXSFilterExpression.h"
#import "FLXSITriStateCheckBoxFilterControl.h"
#import "FLXSIDateComboBox.h"
#import "UIScrollView+UIScrollViewAdditions.h"
#import "FLXSExtendedUIUtils.h"
#import "FLXSFlexDataGridPaddingCell.h"
#import "FLXSSortInfo.h"
#import "FLXSTouchEvent.h"
#import "FLXSFilterSort.h"
#import "FLXSIExpandCollapseComponent.h"
#import "FLXSCellUtils.h"
#import "FLXSCellInfo.h"
#import "FLXSChangeInfo.h"
#import "FLXSFontInfo.h"
#import <objc/message.h>

@implementation FLXSFlexDataGridContainerBase {
 
}
static FLXSClassFactory* _levelRendererFactory;
static FLXSClassFactory* _labelFieldFactory;

@synthesize grid = _grid;
@synthesize verticalSpill = _verticalSpill;
@synthesize rows = _rows;
@synthesize sortInfo = _sortInfo;
@synthesize itemVerticalPositions = _itemVerticalPositions;
@synthesize verticalMask = _verticalMask;
@synthesize horizontalMask = _horizontalMask;
@synthesize horizontalScrollPending = _horizontalScrollPending;
@synthesize enableHorizontalRecycling = _enableHorizontalRecycling;
@synthesize columnDraggingToRight = _columnDraggingToRight;
@synthesize keyboardhandled = _keyboardhandled;
@synthesize lastMouseOutCell = _lastMouseOutCell;
@synthesize lastSelectedRowIndex = _lastSelectedRowIndex;
@synthesize itemClickTimer = _itemClickTimer;
@synthesize itemClickTimerDuration = _itemClickTimerDuration;
@synthesize inEdit = _inEdit;
@synthesize prevDefaultButtonEnabled = _prevDefaultButtonEnabled;
@synthesize validationFailed = _validationFailed;
@synthesize resizeCursorID = _resizeCursorID;
@synthesize columnResizingCell = _columnResizingCell;
@synthesize columnDraggingDragCell = _columnDraggingDragCell;
@synthesize columnDraggingDropTargetCell = _columnDraggingDropTargetCell;
@synthesize columnResizingGlyph = _columnResizingGlyph;
@synthesize columnDraggingGlyph = _columnDraggingGlyph;
@synthesize startX = _startX;
@synthesize cellsWithColSpanOrRowSpan = _cellsWithColSpanOrRowSpan;
@synthesize horizontalScrollPolicy=_horizontalScrollPolicy;
@synthesize verticalScrollPolicy=_verticalScrollPolicy;


@synthesize lastContentOffsetX = _lastContentOffsetX;
@synthesize lastContentOffsetY = _lastContentOffsetY;

-(id)initWithGrid:(FLXSFlexDataGrid*)grid
{
	self = [super init];
	if (self)
	{
		self.verticalSpill = NO;
		self.rows = [[NSMutableArray alloc] init];
		_sortInfo = [[FLXSKeyValuePairCollection alloc] init];
		_loadedItems = [[NSMutableArray alloc] init];
		_itemVerticalPositions = [[NSMutableArray alloc] init];
		_verticalMask = 50;
		_horizontalMask = 100;
		_horizontalScrollPending = -1;
		self.enableHorizontalRecycling = YES;
		self.columnDraggingToRight = NO;
		_keyboardhandled = NO;
		self.lastSelectedRowIndex = -1;
		self.itemClickTimerDuration = .250;
		_inEdit = NO;
		self.validationFailed = NO;
		self.resizeCursorID = -1;

		self.grid=grid;
        self.delegate = self;
        self.opaque=NO;
        self.backgroundColor = self.grid.backgroundColor;


    }
	return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    ScrollDirection scrollDirection=ScrollDirectionNone;
    if (self.lastContentOffsetX > self.contentOffset.x){
        scrollDirection = ScrollDirectionRight;
        [self dispatchScroll:scrollDirection];
    }
    else if (self.lastContentOffsetX < self.contentOffset.x){
        scrollDirection = ScrollDirectionLeft;
        [self dispatchScroll:scrollDirection];
    }


    if (self.lastContentOffsetY > self.contentOffset.y){
        scrollDirection = ScrollDirectionDown;
        [self dispatchScroll:scrollDirection];
    }
    else if (self.lastContentOffsetY < self.contentOffset.y){
        scrollDirection = ScrollDirectionUp;
        [self dispatchScroll:scrollDirection];
    }



    self.lastContentOffsetY = self.contentOffset.y;
    self.lastContentOffsetX = self.contentOffset.x;

}

- (void)dispatchScroll:(ScrollDirection)scrollDirection {
    FLXSScrollEvent* evt = [[FLXSScrollEvent alloc] initWithType:[FLXSScrollEvent SCROLL]
                                                   andCancelable:NO
                                                      andBubbles:NO];
    evt.direction = (scrollDirection == ScrollDirectionLeft ||
            scrollDirection == ScrollDirectionRight)   ? [FLXSScrollEventDetail HORIZONTAL] : [FLXSScrollEventDetail VERTICAL];

    evt.detail = [FLXSScrollEventDetail THUMB_TRACK] ;
    evt.delta = (scrollDirection == ScrollDirectionLeft ||
            scrollDirection == ScrollDirectionRight) ?(self.lastContentOffsetX - self.contentOffset.x):
            (self.lastContentOffsetY - self.contentOffset.y);
    [self dispatchEvent:evt];
}

-(void)onGridMouseMove:(FLXSEvent*)event
{
}

-(UIView<FLXSIFlexDataGridCell>*)getCellFromMouseEventTarget:(UIView*)target
{
	if(!target)
	{
		return nil;
	}
	else if([target conformsToProtocol:@protocol( FLXSIFlexDataGridCell) ])
	{
		return (UIView<FLXSIFlexDataGridCell>*)target;
	}
	else if(target.superview)
	{
		return [self getCellFromMouseEventTarget:target.superview];
	}
	else
        return nil;
}

-(void)removeAllComponents:(BOOL)recycle
{
	if(self.inEdit)[self endEdit:self.editor event:nil ];
	while(self.rows.count>0)
	{
        [self removeComponents:(FLXSRowInfo *)[self.rows objectAtIndex:0]];
	}
    NSArray *viewsToRemove = [self subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
}

- (void)createComponents:(FLXSFlexDataGridColumnLevel *)level currentScroll:(int)currentScroll flat:(NSArray *)flat {
	self.lastSelectedRowIndex=-1;
	[self removeAllComponents:NO];
    self.sortInfo = [[FLXSKeyValuePairCollection alloc] init];
	self.grid.currentPoint.contentX=self.grid.currentPoint.leftLockedContentX=self.grid.currentPoint.rightLockedContentX=0;
    self.grid.currentPoint.contentY=0;
}

- (BOOL)isInVisibleHorizontalRange:(float)x width:(float)wwidth {
	if(self.grid.forceColumnsToFitVisibleArea)return YES;
	if(!self.enableHorizontalRecycling)return YES;
    NSArray* range=self.grid.bodyContainer.visibleRangeH;
    if([range count] ==0 ){
        [self.grid.bodyContainer setVisibleRange];
    }
    range=self.grid.bodyContainer.visibleRangeH;
	float controlXBegin=x;
	float controlXEnd=x+wwidth;
    float rangeStart = [(NSNumber *)range[0] floatValue];
    float rangeEnd = [(NSNumber *)range[1] floatValue];
	return ([range count] ==0 ||(

    (!(controlXEnd<rangeStart) && !(controlXBegin>rangeEnd) )

));
}

-(void)removeComponent:(FLXSComponentInfo*)comp
{
	[self removeEventListeners:comp];
    if([self.grid.currentCell isEqual:comp.component])
        self.grid.currentCell=nil;
	[comp.row removeCell:comp];
	if(comp.component==nil||comp.component.superview==nil)return;
    [comp.component removeFromSuperview] ;
	UIView<FLXSIFlexDataGridCell>* cell= (UIView<FLXSIFlexDataGridCell>* )comp.component;
	if(cell)
	{
		[cell destroy];
	}
	[self.grid.rendererCache pushInstance:comp.component];
}

-(void)reDraw
{
	[self removeAllComponents:YES];
	[self createComponents:self.grid.columnLevel currentScroll:0 flat:nil ];
	[[self layer] display];
	[self snapToColumnWidths];
}

- (void)recycleH:(FLXSFlexDataGridColumnLevel *)level scrollRight:(BOOL)scrollRight {
	FLXSKeyValuePairCollection* dictionary=[[FLXSKeyValuePairCollection alloc] init];
	for(FLXSRowInfo* row in [self getRowsForRecycling])
	{
        [dictionary addItem:row value:[[NSMutableArray alloc] init]];
        if(!row.isColumnBased)continue;
		for(FLXSComponentInfo* cell in row.cells)
		{
			UIView<FLXSIFlexDataGridCell>* tCell= [cell.component conformsToProtocol:@protocol(FLXSIFlexDataGridCell)]?(UIView<FLXSIFlexDataGridCell>* )cell.component:nil;
			if(tCell&&![self isInVisibleHorizontalRange:cell.x width:cell.component.frame.size.width] &&!tCell.isLocked)
			{
                UIView<FLXSIFlexDataGridDataCell>*  dCell = [tCell conformsToProtocol:@protocol(FLXSIFlexDataGridDataCell)]?(UIView<FLXSIFlexDataGridDataCell>*)tCell:nil;
				if(dCell && dCell.colSpan>1)
				{
					//self means self is a cell that has a colspan, we should not take it out
				}
				else{
                    //                    dictionary[row[] addObject:cell];
                    [(NSMutableArray*)[dictionary getValue:row] addObject:cell];
                }
			}
		}
	}

	for(FLXSRowInfo*  row in [self getRowsForRecycling])
	{
		if(!row.isColumnBased)continue;
		NSMutableArray* recyclable=(NSMutableArray*)[dictionary getValue:row];
        [self processRowPositionInfo:row.rowPositionInfo scrollDown:NO existingRow:row existingComponents:recyclable];
		while([recyclable count]>0)
		{
			[self removeComponent:(recyclable[[recyclable count]-1])];
			[recyclable removeObjectAtIndex:[recyclable count]-1];
		}
	}
	if(self.grid.hasRowSpanOrColSpan)
	{
		[self snapToColumnWidths];
	}
	//[self placeComponents];
}
-(NSArray*)getRowsForRecycling
{
    return self.rows;
}

- (void)processRowPositionInfo:(FLXSRowPositionInfo *)rowPositionInfo scrollDown:(BOOL)scrollDown existingRow:(FLXSRowInfo *)existingRow existingComponents:(NSArray *)existingComponents {
	if(rowPositionInfo.rowType == [FLXSRowPositionInfo ROW_TYPE_HEADER])
	{
		[self processHeaderLevel:([rowPositionInfo getLevel:self.grid]) rowPositionInfo:rowPositionInfo scrollDown:scrollDown item:rowPositionInfo.rowData chromeLevel:[FLXSRowPositionInfo ROW_TYPE_HEADER] existingRow:existingRow existingComponents:existingComponents];
	}
	else if(rowPositionInfo.rowType == [FLXSRowPositionInfo ROW_TYPE_COLUMN_GROUP])
	{
		[self processHeaderLevel:([rowPositionInfo getLevel:self.grid]) rowPositionInfo:rowPositionInfo scrollDown:scrollDown item:rowPositionInfo.rowData chromeLevel:[FLXSRowPositionInfo ROW_TYPE_COLUMN_GROUP] existingRow:existingRow existingComponents:existingComponents];
	}
	else if(rowPositionInfo.rowType == [FLXSRowPositionInfo ROW_TYPE_FILTER])
	{
		[self processHeaderLevel:([rowPositionInfo getLevel:self.grid]) rowPositionInfo:rowPositionInfo scrollDown:scrollDown item:rowPositionInfo.rowData chromeLevel:[FLXSRowPositionInfo ROW_TYPE_FILTER] existingRow:existingRow existingComponents:existingComponents];
	}
	else if(rowPositionInfo.rowType == [FLXSRowPositionInfo ROW_TYPE_PAGER])
	{
		[self processHeaderLevel:([rowPositionInfo getLevel:self.grid]) rowPositionInfo:rowPositionInfo scrollDown:scrollDown item:rowPositionInfo.rowData chromeLevel:[FLXSRowPositionInfo ROW_TYPE_PAGER] existingRow:existingRow existingComponents:existingComponents];
	}
	else if(rowPositionInfo.rowType == [FLXSRowPositionInfo ROW_TYPE_FOOTER])
	{
		[self processHeaderLevel:([rowPositionInfo getLevel:self.grid]) rowPositionInfo:rowPositionInfo scrollDown:scrollDown item:rowPositionInfo.rowData chromeLevel:[FLXSRowPositionInfo ROW_TYPE_FOOTER] existingRow:existingRow existingComponents:existingComponents];
	}
	else if(rowPositionInfo.rowType == [FLXSRowPositionInfo ROW_TYPE_RENDERER])
	{
		[self processRendererLevel:rowPositionInfo scrollDown:scrollDown];
	}
}

-(void)removeComponents:(FLXSRowInfo*)row
{
	while(row.cells.count>0)
	{
		[self removeComponent:(FLXSComponentInfo *)row.cells[0]];
	}
	if(!row.isFillRow)
		[self.rows removeObjectAtIndex:([self.rows indexOfObject:row])];
	if(row.isFilterRow)
	{
		[row removeEventListenerOfType:[FLXSFilterPageSortChangeEvent FILTER_CHANGE] fromTarget:self usingHandler:@selector(onFilterChange:)];
    }
}

-(void)setCurrentCellToFirst
{
	UIView<FLXSIFlexDataGridCell>* cell= [self getFirstAvailableCell:nil up:NO ];
	if(cell)
		self.grid.currentCell=cell;
}

- (UIView <FLXSIFlexDataGridCell> *)getFirstAvailableCell:(UIView <FLXSIFlexDataGridCell> *)cell up:(BOOL)up {
	if(self.rows.count>0)
	{
		FLXSRowInfo* row = self.rows[up?[self.rows count]-1:0];
		if(cell && row.isColumnBased&&cell.rowInfo.isColumnBased && cell.columnFLXS && [row getCellForColumn:cell.columnFLXS])
		{
            return (UIView<FLXSIFlexDataGridCell>*) [row getCellForColumn:cell.columnFLXS].component;
		}
		return (UIView<FLXSIFlexDataGridCell>*) [self getFirstHoverableCell:row dataOnly:NO editableOnly:NO ];
	}
	return nil;
}

- (UIView <FLXSIFlexDataGridCell> *)getFirstHoverableCell:(FLXSRowInfo *)row dataOnly:(BOOL)dataOnly editableOnly:(BOOL)editableOnly {
	if(row.cells.count>0)
	{
		for(FLXSComponentInfo* cell in row.cells)
		{
			UIView<FLXSIFlexDataGridCell>* fdgCell=(UIView<FLXSIFlexDataGridCell>*)cell.component;
			if(dataOnly&&!([fdgCell conformsToProtocol: @protocol(FLXSIFlexDataGridDataCell) ]))continue;
			if(editableOnly&&([self.grid isCellEditable:fdgCell]))continue;
			if([self isHoverableCell:fdgCell])
				return fdgCell;
		}
	}
	return nil;
}

-(BOOL)isHoverableCell:(UIView<FLXSIFlexDataGridCell>*)cell
{
	return ([cell conformsToProtocol:@protocol(FLXSIFlexDataGridDataCell)]
|| [cell isKindOfClass:[FLXSFlexDataGridHeaderCell class]]
|| [cell isKindOfClass:[FLXSFlexDataGridFooterCell class]]
|| [cell isKindOfClass: [FLXSFlexDataGridFilterCell class]]
|| [cell isKindOfClass: [FLXSFlexDataGridPagerCell class]]
|| [cell isKindOfClass:[FLXSFlexDataGridLevelRendererCell class]]
|| [cell isKindOfClass:[FLXSFlexDataGridExpandCollapseCell class]]
|| [cell isKindOfClass:[FLXSFlexDataGridColumnGroupCell class]]) &&
    cell.userInteractionEnabled && !([cell isKindOfClass:[FLXSFlexDataGridExpandCollapseHeaderCell class]]);
    return NO;
}

-(FLXSComponentInfo*)addEventListeners:(FLXSComponentInfo*)comp
{
	UIView<FLXSIFlexDataGridCell>* cell= [comp.component conformsToProtocol:@protocol(FLXSIFlexDataGridCell)]?(UIView<FLXSIFlexDataGridCell>*)comp.component :nil;
	if(cell)
	{
		//[cell addEventListener:[MouseEvent MOUSE_OVER] :onCellMouseOver];  no mouseover in ios
		//[cell addEventListener:[KeyboardEvent KEY_UP] :onCellKeyUp :NO :(-99)];
		[cell addEventListenerOfType:[FLXSTouchEvent TAP] usingTarget:self withHandler:@selector(onCellMouseClick:)];
		[cell addEventListenerOfType:[FLXSTouchEvent DOUBLE_TAP] usingTarget:self withHandler:@selector(onCellDoubleClick:)];
		//[cell addEventListener:[MouseEvent MOUSE_OUT] :onCellMouseOut];
	}
	if ([cell isKindOfClass:[FLXSFlexDataGridHeaderCell class]])
	{
		//[cell addEventListener:[FLXSTouchEvent TOUCH_MOVE] :self : @selector(onHeaderCellMouseMove:)];
		//[cell addEventListener:[MouseEvent MOUSE_OUT] :onHeaderCellMouseOut];
		[cell addEventListenerOfType:[FLXSTouchEvent TOUCH_DOWN] usingTarget:self withHandler:@selector(onHeaderCellMouseDown:)];
		FLXSFlexDataGridColumn* col = cell.columnFLXS;
		if([col isKindOfClass:[FLXSFlexDataGridCheckBoxColumn class]])
			[cell addEventListenerOfType:[FLXSFlexDataGridEvent SELECT_ALL_CHECKBOX_CHANGED] usingTarget:self withHandler:@selector(selectAllChangedHandler:)];
 		[cell addEventListenerOfType:[FLXSEvent RESIZE] usingTarget:self withHandler:@selector(placeSortIcon:)];

        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onHeaderCellPanRecognizer:)];
        [panRecognizer setMinimumNumberOfTouches:1];
        [panRecognizer setMaximumNumberOfTouches:1];
        [cell addGestureRecognizer:panRecognizer];
	}
	else if ([cell isKindOfClass:[FLXSFlexDataGridColumnGroupCell class]])
	{
		//[cell addEventListener:[FLXSTouchEvent TOUCH_MOVE] :self : @selector(onHeaderCellMouseMove:)];
		//[cell addEventListener:[MouseEvent MOUSE_OUT] :onHeaderCellMouseOut];
		[cell addEventListenerOfType:[FLXSTouchEvent TOUCH_DOWN] usingTarget:self withHandler:@selector(onHeaderCellMouseDown:)];
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onHeaderCellPanRecognizer:)];
        [panRecognizer setMinimumNumberOfTouches:1];
        [panRecognizer setMaximumNumberOfTouches:1];
        [cell addGestureRecognizer:panRecognizer];
	}
//	if(self.grid.enableDrop && cell)
//	{
//		[cell addEventListener:[FLXSTouchEvent TOUCH_MOVE]  :self : @selector(onCellDropMouseMove:)];
//	}
	return comp;
}

-(void)onCellMouseOver:(FLXSEvent*)event
{
//	//[self calculateColumnDraggingDropTargetCell:event];
//	//self has been moved to mousemove

}

-(void)calculateColumnDraggingDropTargetCell:(FLXSTouchEvent*)event
{
	if(self.grid.contextMenuShown)return;
	UIView<FLXSIFlexDataGridCell>* cell =[self getCellFromMouseEventTarget:event.target];
	FLXSFlexDataGridHeaderCell* headerCell = [cell isKindOfClass:[FLXSFlexDataGridHeaderCell class]]?(FLXSFlexDataGridHeaderCell*)cell:nil;
	FLXSFlexDataGridHeaderCell* movingHCell = [self.columnDraggingDragCell isKindOfClass:[FLXSFlexDataGridHeaderCell class]]?(FLXSFlexDataGridHeaderCell*)self.columnDraggingDragCell :nil;
	CGPoint pt = CGPointMake(0, 0);
	FLXSFlexDataGridColumnGroupCell* cgCell = [cell isKindOfClass:[FLXSFlexDataGridColumnGroupCell class]]?(FLXSFlexDataGridColumnGroupCell*)cell:nil;
	FLXSFlexDataGridColumnGroupCell* movingCgCell = [self.columnDraggingDragCell isKindOfClass:[FLXSFlexDataGridColumnGroupCell class]]?(FLXSFlexDataGridColumnGroupCell*)self.columnDraggingDragCell:nil;
	self.columnDraggingToRight=(event.localX>(cell.width/2));
	BOOL isRtl=NO;//([[self.grid getStyle:(@"layoutDirection")] isEqual:'rtl']);
	if(isRtl)self.columnDraggingToRight=!self.columnDraggingToRight;
	if(headerCell && movingHCell)
	{
        if(self.columnResizingGlyph){
            if(self.columnDraggingDragCell &&  ([self.columnDraggingDragCell.level isEqual:headerCell.level] /*&& !headerCell.isLocked*/)
                    && ([self.columnDraggingDragCell.columnFLXS.columnGroup isEqual:headerCell.columnFLXS.columnGroup] || (headerCell.columnFLXS.columnGroup ==nil && self.columnDraggingDragCell.columnFLXS.columnGroup==nil)))
            {
                pt=[self.grid globalToLocal:([headerCell localToGlobal:pt])];
                if(self.columnDraggingToRight)pt.x+=headerCell.width;
                [self.columnResizingGlyph moveToX:pt.x y:pt.y];
                [self.columnDraggingGlyph moveToX:pt.x y:pt.y];
                self.columnDraggingDropTargetCell=headerCell;
            }
        }

	}
	else if(cgCell && movingCgCell)
	{
		if(movingCgCell && self.columnResizingGlyph && (movingCgCell.columnGroup.parentGroup==cgCell.columnGroup.parentGroup)&& (movingCgCell.columnFLXS.columnLockMode==cgCell.columnFLXS.columnLockMode))
		{
			pt=[self.grid globalToLocal:([cgCell localToGlobal:pt])] ;
            if(self.columnDraggingToRight)pt.x+=cgCell.width;
            [self.columnResizingGlyph moveToX:pt.x y:pt.y];
            [self.columnDraggingGlyph moveToX:pt.x y:pt.y];
            self.columnDraggingDropTargetCell=cgCell;
		}
	}

}
-(void)onCellDropMouseMove:(FLXSEvent*)event
{
}

- (void)handleMouseOver:(UIView <FLXSIFlexDataGridCell> *)cell triggerEvent:(FLXSEvent *)triggerEvent {
// no mouse over in ios
}

-(void)onCellMouseOut:(FLXSEvent*)event
{
//no mouse out in ios
}

- (void)handleMouseOut:(UIView <FLXSIFlexDataGridCell> *)cell triggerEvent:(FLXSEvent *)triggerEvent {
//no mouse out in ios
}

-(void)onCellMouseClick:(NSNotification*)ns
{
    FLXSTouchEvent *event = [ns.userInfo objectForKey:@"event"];
	UIView<FLXSIFlexDataGridCell>* cell = (UIView<FLXSIFlexDataGridCell>*)event.target;
    if(self.columnResizingCell){
        //need to kill resize
        [self killResize];
        [FLXSUIUtils removeChild:self.grid child:(((UIView *) (self.columnResizingGlyph)))];
        self.columnResizingCell.resizing=NO;
        self.columnResizingCell=nil;
        self.columnResizingGlyph = nil;
        self.resizeCursorID=-1;
    }
	if([cell isKindOfClass:[FLXSFlexDataGridHeaderCell class]])
	{
		BOOL onRightEdge=((cell.width-4-event.localX)<=self.grid.columnLevel.headerSeparatorWidth );
		BOOL onLeftEdge=(event.localX<=self.grid.columnLevel.headerSeparatorWidth);
		if(onRightEdge||onLeftEdge)
			return;
	}
	if(_inEdit)
		[self endEdit:self.editor event:event];
	[self handleMouseClick:cell triggerEvent:event checkTimer:YES ];
}

-(void)onCellDoubleClick:(NSNotification*)ns
{
    FLXSTouchEvent *event = [ns.userInfo objectForKey:@"event"];
    UIView<FLXSIFlexDataGridCell>* cell = (UIView<FLXSIFlexDataGridCell>*) event.target;
	[self handleDoubleClick:cell triggerEvent:event];
}

- (void)handleDoubleClick:(UIView <FLXSIFlexDataGridCell> *)cell triggerEvent:(FLXSEvent *)triggerEvent {
	if(!self.grid.allowInteractivity|| !cell.userInteractionEnabled)return;
	if(([cell conformsToProtocol:@protocol(FLXSIFlexDataGridDataCell)])&& cell.columnFLXS)
	{
		if([self.grid isCellEditable:cell] && self.grid.enableDoubleClickEdit)
			[self beginEdit:(UIView<FLXSIFlexDataGridDataCell>*)cell];
        else{
            FLXSFlexDataGridEvent* evt= [[FLXSFlexDataGridEvent alloc] initWithType:([FLXSFlexDataGridEvent ITEM_DOUBLE_CLICK]) andGrid:self.grid
                                                                           andLevel:cell.level andColumn:cell.columnFLXS andCell:cell andItem:cell.rowInfo.data andTriggerEvent:triggerEvent andBubbles:NO andCancelable:NO ];
            [cell.level dispatchEvent:evt];

        }
	}
}

-(void)emulateClick:(UIView<FLXSIFlexDataGridCell>*)cell
{
	FLXSTouchEvent* evt = [[FLXSTouchEvent alloc] init];
    evt.type = [FLXSTouchEvent TAP];
	[self handleMouseClick:cell triggerEvent:evt checkTimer:YES ];
}

- (void)handleMouseClick:(UIView <FLXSIFlexDataGridCell> *)cell triggerEvent:(FLXSEvent *)triggerEvent checkTimer:(BOOL)checkTimer {
	if(!self.grid.allowInteractivity)return;
	if(checkTimer && self.grid.enableDoubleClickTimer)
	{
		if(!self.itemClickTimer||!self.itemClickTimer.isValid)
		{
            self.itemClickTimer=[NSTimer scheduledTimerWithTimeInterval:self.itemClickTimerDuration target:self selector:@selector(onItemClickTimer:) userInfo:nil repeats:NO];

		}
		else
		{
			return;
		}
	}
	if(!cell.userInteractionEnabled&&cell.columnFLXS &&cell.columnFLXS.enableExpandCollapseIcon&&cell.rowInfo&&cell.rowInfo.isDataRow)
	{
		[cell.iExpandCollapseComponent doClick];
		return;
	}
	int selectionStart=0;
	int selectionEnd=0;
// 	FLXSTouchEvent* mouseEvent = (FLXSTouchEvent* )triggerEvent;
	BOOL shiftKey  = NO; // cannot shift select in ios
	BOOL dispatchItemClick=NO;
	self.grid.currentCell=cell;
	FLXSFlexDataGridHeaderCell* headerCell = [cell isKindOfClass:[FLXSFlexDataGridHeaderCell class] ]?(FLXSFlexDataGridHeaderCell*)cell:nil;
	FLXSFlexDataGridColumnGroupCell* cgCell= [cell isKindOfClass:[FLXSFlexDataGridColumnGroupCell class]]?(FLXSFlexDataGridColumnGroupCell*)cell:nil;
    if(headerCell )
	{
		[self onHeaderCellClicked:headerCell triggerEvent:triggerEvent isMsc:NO useMsc:YES direction:nil ];
	}
	else if(([cell isKindOfClass:[FLXSFlexDataGridExpandCollapseCell class]]) || ([triggerEvent.target conformsToProtocol:@protocol(FLXSIExpandCollapseComponent)]))
	{
		[cell.iExpandCollapseComponent doClick];
	}
	else if(cgCell && cgCell.columnGroup.enableExpandCollapse)
	{
		if([cgCell.columnGroup isClosed])
		{
			[cgCell.columnGroup openColumns];
		}
		else
		{
			[cgCell.columnGroup closeColumns];
		}
		[cgCell invalidateDisplayList];
	}
	else if(self.grid.isRowSelectionMode && cell.columnFLXS)
	{
		if(cell.columnFLXS.enableCellClickRowSelect)
		{
			if([cell conformsToProtocol:@protocol(FLXSIFlexDataGridDataCell)] && cell.columnFLXS
				&& (![self.grid isCellEditable:cell]  || self.grid.enableDoubleClickEdit)
				/*&& !(cell.column is FLXSFlexDataGridCheckBoxColumn) */
				&& ([cell.level checkRowSelectable:cell object:cell.rowInfo.data]))
			{
				BOOL select=![cell.level isItemSelected:cell.rowInfo.data useExclusion:YES ];
				if([self.grid isCtrlKeyDownOrSticky:triggerEvent])
					[cell.level selectRow:cell.rowInfo.data selected:select dispatch:YES recurse:YES bubble:YES parent:nil ];
				else
				{
					select=YES;
					[self.grid clearSelection];
					[cell.level selectRow:cell.rowInfo.data selected:select dispatch:YES recurse:YES bubble:YES parent:nil ];
				}
				[self highlightRow:cell row:cell.rowInfo highLight:YES highLightColor:(select ? [cell getStyleValue:(@"selectionColorFLXS")] : [cell getRolloverColor])];
				if(shiftKey && (self.lastSelectedRowIndex>-1))
				{
					//selecting multiple rows.
					if(self.lastSelectedRowIndex>cell.rowInfo.rowPositionInfo.rowIndex)
					{
						//shift up.
						selectionStart=cell.rowInfo.rowPositionInfo.rowIndex;
						selectionEnd=self.lastSelectedRowIndex;
					}
					else
					{
						//shift down
						selectionStart=self.lastSelectedRowIndex;
						selectionEnd=cell.rowInfo.rowPositionInfo.rowIndex;
					}
					for (int i=selectionStart;i<=selectionEnd;i++)
					{
						FLXSRowPositionInfo* pos = _itemVerticalPositions[i];
						[[pos getLevel:self.grid] selectRow:pos.rowData selected:YES dispatch:NO recurse:YES bubble:YES parent:nil ];
					}
				}
				else if (!shiftKey)
                self.lastSelectedRowIndex=cell.rowInfo.rowPositionInfo.rowIndex;
			}
			[self.grid invalidateSelection];
		}
		dispatchItemClick=YES;
	}
	else if([cell conformsToProtocol:@protocol(FLXSIFlexDataGridDataCell)] && cell.columnFLXS && (![self.grid isCellEditable:cell]||self.grid.enableDoubleClickEdit)
&& !([cell.columnFLXS isKindOfClass:[FLXSFlexDataGridCheckBoxColumn class]]) && self.grid.isCellSelectionMode)
	{
		BOOL selectCell=![cell.level isCellSelected:cell.rowInfo.data column:cell.columnFLXS];

if([self.grid isCtrlKeyDownOrSticky:triggerEvent])
[cell.level selectCell:cell selected:selectCell];
		else
		{
			selectCell=YES;
			[self.grid clearSelection];
			[cell.level selectCell:cell selected:selectCell];
		}
		[self highlightRow:cell row:nil highLight:YES highLightColor:(selectCell ? [cell getStyleValue:(@"selectionColorFLXS")] : [cell getRolloverColor])];
		if(shiftKey && (self.lastSelectedRowIndex>-1))
		{
			//selecting multiple rows.
			if(self.lastSelectedRowIndex>cell.rowInfo.rowPositionInfo.rowIndex)
			{
				//shift up.
				selectionStart=cell.rowInfo.rowPositionInfo.rowIndex;
				selectionEnd=self.lastSelectedRowIndex;
			}
			else
			{
				//shift down
				selectionStart=self.lastSelectedRowIndex;
				selectionEnd=cell.rowInfo.rowPositionInfo.rowIndex;
			}
			for (int i1=selectionStart;i1<=selectionEnd;i1++)
			{
				FLXSRowPositionInfo* pos1 = _itemVerticalPositions[i1];
                [cell.level selectCellByRowPositionInfo:pos1 column:cell.columnFLXS selected:YES ];
			}
		}
		else if (!shiftKey)
            self.lastSelectedRowIndex=cell.rowInfo.rowPositionInfo.rowIndex;
		[self.grid invalidateSelection];
		dispatchItemClick=YES;
	}
	if(dispatchItemClick && cell.rowInfo && cell.rowInfo.isDataRow && !cell.rowInfo.isFillRow)
	{
		FLXSFlexDataGridEvent* evt= [[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent ITEM_CLICK] andGrid:self.grid andLevel:cell.level andColumn:cell.columnFLXS andCell:cell andItem:cell.rowInfo.data andTriggerEvent:triggerEvent andBubbles:NO andCancelable:NO ];
		evt.isItemSelected=([cell.level isItemSelected:cell.rowInfo.data useExclusion:YES ]) ;
        [cell.level dispatchEvent:evt];
	}
	if([cell conformsToProtocol:@protocol(FLXSIFlexDataGridDataCell)]&& cell.columnFLXS
		&& [self.grid isCellEditable:cell] && (!self.grid.enableDoubleClickEdit )

             )
	{
		[self beginEdit:(UIView<FLXSIFlexDataGridDataCell>*)cell];
		[triggerEvent preventDefault];
	}
}

-(void)onItemClickTimer:(FLXSEvent*)event
{
    [self.itemClickTimer invalidate];
    self.itemClickTimer =nil;
}

-(void)onCellKeyUp:(FLXSEvent*)event
{
    //ios has no keyboard navigation.

}

- (BOOL)handleArrowKey:(UIView <FLXSIFlexDataGridCell> *)cell keyCode:(int)keyCode triggerEvent:(FLXSEvent *)triggerEvent {
    //ios has no keyboard navigation.
    return NO;
}

- (void)handleCellKeyUp:(UIView <FLXSIFlexDataGridCell> *)cell keyCode:(int)keyCode triggerEvent:(FLXSEvent *)triggerEvent {
    //ios has no keyboard navigation.

}

- (void)handleSpaceBar:(UIView <FLXSIFlexDataGridCell> *)cell triggerEvent:(FLXSEvent *)triggerEvent {
//	[self handleMouseClick:cell :triggerEvent];
}

-(void)beginEdit:(UIView<FLXSIFlexDataGridDataCell>*)cell
{
	if(![self.grid isCellEditable:cell])return;
	FLXSFlexDataGridItemEditEvent* evt= [[FLXSFlexDataGridItemEditEvent alloc] initWithType:[FLXSFlexDataGridEvent ITEM_EDIT_BEGINNING] andGrid:self.grid andLevel:cell.level andColumn:cell.columnFLXS andCell:cell andItem:cell.rowInfo.data andTriggerEvent:nil andBubbles:NO andCancelable:NO ];
	[cell.columnFLXS dispatchEvent:evt];
	if([evt isDefaultPrevented])return;
	if(_inEdit)
		[self endEdit:self.editor event:evt];
	UIView<FLXSIFlexDataGridDataCell>* prevEdit=self.editCell;
    self.editCell=cell;
	if(prevEdit)
		[prevEdit.rowInfo invalidateCells];
	[self.editCell.rowInfo invalidateCells];
	_inEdit=YES;
    self.editor = [self.editCell.columnFLXS.itemEditor generateInstance];
	//editor.styleName = editCell.column;
	UIView* pare=cell.isLeftLocked?self.grid.leftLockedContent
        :cell.isLocked?self.grid.rightLockedContent:self;
	[self initializeEditor:self.editCell editor:self.editor pare:pare];
	if(self.editCell.renderer==self.editCell)
	{
		//self means we are FLXSFlexDataGridDataCell2
        self.editCell.text=@"";
	}
	else
	{
        self.editCell.renderer.hidden=YES;
	}
//	CGPoint pt=[self.editCell placeComponent:self.editor :self.editCell.width :self.editCell.height :NO];
//    CGPoint myPt = [pare globalToContent:([self.editCell localToGlobal:pt])];
//	[self.editor move:myPt.x :myPt.y];
//	[self.editor addEventListener:[FlexEvent VALUE_COMMIT] :onEditorValueCommit];
//	[self.editor addEventListener:[KeyboardEvent KEY_DOWN] :onEditorKeyDown];
//	UIView* sbRoot = [systemManager getSandboxRoot];
//	[sbRoot addEventListener:[MouseEvent MOUSE_UP] :cancelEdit :YES];
//	[sbRoot addEventListener:[SandboxMouseEvent MOUSE_UP_SOMEWHERE] :cancelEdit];
//	[systemManager addEventListener:[Event RESIZE] :onStageResize :YES :0 :YES];
//	IFocusManager* fm = focusManager;
//	if (editor is IFocusManagerComponent)
//	{
//		[self callLater:fm.setFocus :([editor])];
//	}
//	_prevDefaultButtonEnabled=fm.defaultButtonEnabled;
//	fm.defaultButtonEnabled = NO;
    //we are just going to do full row edit.

	evt= [[FLXSFlexDataGridItemEditEvent alloc] initWithType:[FLXSFlexDataGridEvent ITEM_EDIT_BEGIN] andGrid:self.grid andLevel:cell.level andColumn:cell.columnFLXS andCell:cell andItem:cell.rowInfo.data andTriggerEvent:nil andBubbles:NO andCancelable:NO ];
	evt.itemEditor=self.editor;
	[cell.columnFLXS dispatchEvent:evt];
	evt= [[FLXSFlexDataGridItemEditEvent alloc] initWithType:[FLXSFlexDataGridEvent ITEM_FOCUS_IN] andGrid:self.grid andLevel:cell.level andColumn:cell.columnFLXS andCell:cell andItem:cell.rowInfo.data andTriggerEvent:nil andBubbles:NO andCancelable:NO ];
	evt.itemEditor=self.editor;
	[self.grid dispatchEvent:evt];
}

//
- (void)initializeEditor:(UIView <FLXSIFlexDataGridDataCell> *)editCell editor:(UIView *)editor pare:(UIView *)pare {
    self.editor=editor;
	if([self.editor respondsToSelector:NSSelectorFromString(@"dataProviderFLXS")])
	{
		UIView<FLXSISelectFilterControl>* iselectEditor=(UIView<FLXSISelectFilterControl>*)self.editor;

if(editCell.columnFLXS.useFilterDataProviderForItemEditor)
		{
			FLXSFlexDataGridColumn* filterColumn=editCell.columnFLXS;
			if (filterColumn.filterComboBoxBuildFromGrid) {
                [self.editor setValue:[filterColumn getDistinctValues:[self.grid getRootFlat] collection:nil addedCodes:nil level:editCell.columnFLXS.level]
                                forKey:@"dataProviderFLXS"];
            }
			else if(filterColumn.filterComboBoxDataProvider){
                [self.editor setValue:filterColumn.filterComboBoxDataProvider
                               forKey:@"dataProviderFLXS"];

            }
			iselectEditor.labelField=filterColumn.filterComboBoxLabelField;
			iselectEditor.dataFieldFLXS = filterColumn.filterComboBoxDataField;
		}
	}
	if([editCell.columnFLXS getStyle:(@"editorStyleName")])
	{
		[editor setStyle:(@"styleName") value:([editCell.columnFLXS getStyle:(@"editorStyleName")])];
	}
	[FLXSUIUtils addChild:pare child:editor];
	//editor.owner=self.grid;
	//editor.automationName = grid.automationName + @"_" + editCell.column.uniqueIdentifier+@"_editor";
	if(!editCell.columnFLXS.itemEditorManagesPersistence)
	{
        if([editor isKindOfClass:[UITextField class]]){
            [editor setValue:[[FLXSExtendedUIUtils resolveExpression:editCell.rowInfo.data expression:editCell.columnFLXS.dataFieldFLXS valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ] description]
                      forKey:editCell.columnFLXS.editorDataField];

        }else{
            [editor setValue:[FLXSExtendedUIUtils resolveExpression:editCell.rowInfo.data expression:editCell.columnFLXS.dataFieldFLXS valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ]
                      forKey:editCell.columnFLXS.editorDataField];

        }

		[editor validateNow];
	}
//	if([editor hasOwnProperty:(@"selectRange")] && [editor hasOwnProperty:(@"text")])
//	{
//		NSString* txt=editor[@"text"];
//		if(txt.length>0)
//			editor[@"selectRange"](txt.length,txt.length);
//	}
    if([editor isKindOfClass:[UITextField class]]){
        UITextField * textviewEditor = (UITextField*)editor;
        NSString* txt  = textviewEditor.text;
        if(txt.length>0){
            [textviewEditor selectAll:self];

        }
    }
}

-(void)refreshCells
{
	for(FLXSRowInfo* row in self.rows)
	{
		for (FLXSComponentInfo* cell in row.cells)
		{
			UIView<FLXSIFlexDataGridCell>* tdgc = [cell.component conformsToProtocol:@protocol(FLXSIFlexDataGridCell)]?(UIView<FLXSIFlexDataGridCell>*)cell.component:nil;
			if(tdgc)
				[tdgc refreshCell];
		}
	}
}

-(void)onStageResize:(FLXSEvent*)event
{
  //no stage resize
}

-(void)onEditorKeyDown:(FLXSEvent*)event
{
//	if(event.keyCode == [Keyboard ESCAPE])
//	{
//		[self cancelEdit:event];
//	}
//	else if(event.keyCode == [Keyboard ENTER] || event.keyCode == [Keyboard TAB])
//	{
//		UIView<FLXSIFlexDataGridCell>* cell = editCell;
//		NSObject* lhs=[ExtendedUIUtils resolveExpression:cell.rowInfo.data :cell.column.dataFieldFLXS];
//		NSObject* rhs=[editor hasOwnProperty:cell.column.editorDataField]? editor[cell.column.editorDataField]:nil;
//		if(cell.column.itemEditorManagesPersistence)
//		{
//			if([self populateValue:event])
//			{
//				if(event.keyCode==[Keyboard ENTER])
//					[self endEdit:editor :event];
//			}
//			else
//			{
//				return;
//			}
//		}
//		else if(lhs==nil && [rhs isEqual:@""])
//		{
//			//self commonly happens if the pojo has a nil and the text input returns a blank [self string:when the user does not make any change]
//			if(event.keyCode==[Keyboard ENTER])
//				[self endEdit:editor :event];
//		}
//		else if(lhs!=rhs)
//		{
//			if([self populateValue:event])
//			{
//				if(event.keyCode==[Keyboard ENTER])
//					[self endEdit:editor :event];
//			}
//			else
//			{
//				return;
//			}
//		}
//		else if(event.keyCode==[Keyboard ENTER])
//		{
//			[self endEdit:editor :event];
//		}
//		[self.grid refreshCells];
//		if(event.keyCode==[Keyboard ENTER])
//			[self handleEditorKeyEvent:event :cell];
//		//tab is handled by grid.
//	}
}

-(void)handleEditorKeyEvent:(FLXSEvent*)event :(UIView<FLXSIFlexDataGridCell>*)cell
{
//	UIView<FLXSIFlexDataGridCell>* nextCell;
//	if(event.keyCode == [Keyboard ENTER])
//	{
//		nextCell = [self getCellInDirection:cell :[FLXSFlexDataGrid CELL_POSITION_BELOW] :YES :YES];
//	}
//	if(event.keyCode == [Keyboard TAB])
//	{
//		RowInfo* ri = cell.rowInfo;
//		FLXSFlexDataGridColumn* rcol = cell.column;
//		nextCell = [self getCellInDirection:cell :(event.shiftKey?[FLXSFlexDataGrid CELL_POSITION_LEFT]:[FLXSFlexDataGrid CELL_POSITION_RIGHT]) :YES :YES];
//		if(!nextCell || (nextCell==cell))
//		{
//			//we're at the end...
//			//cell could have gotten recycled
//			cell=[self getCellForRowColumn:ri.data :rcol];
//			if(!cell)
//			{
//				cell = [self getCellForRowColumn:ri.data :nil :YES];
//			}
//			//nextCell = [self getCellInDirection:cell :(event.shiftKey?[FLXSFlexDataGrid CELL_POSITION_ABOVE_LAST]:[FLXSFlexDataGrid CELL_POSITION_BELOW_FIRST]) :YES :YES];
//			CellInfo* anchorCellData = [[CellInfo alloc] init:ri.data :rcol];
//			while(!nextCell)
//			{
//				cell=[self getCellForRowColumn:anchorCellData.rowData :anchorCellData.column];
//				if(!cell)
//				{
//					cell = [self getCellForRowColumn:anchorCellData.rowData :nil :YES];
//				}
//				if(!cell)
//				{
//					break;
//					;
//				}
//				UIView<FLXSIFlexDataGridCell>* nextRegularCell = [self getCellInDirection:cell :(event.shiftKey?[FLXSFlexDataGrid CELL_POSITION_ABOVE_LAST]:[FLXSFlexDataGrid CELL_POSITION_BELOW_FIRST]) :NO :NO];
//				if(!nextRegularCell || !nextRegularCell.rowInfo)
//				{
//					break;
//					//were at end or top, nothing can be done
//				}
//				anchorCellData = [[CellInfo alloc] init:nextRegularCell.rowInfo.data :nextRegularCell.column];
//				int nextRegularCellRowIndex=nextRegularCell.rowInfo.rowPositionInfo.rowIndex;
//				if(nextRegularCell && [self.grid isCellEditable:nextRegularCell])
//				{
//					nextCell = nextRegularCell;
//					break;
//				}
//				nextCell = [self getCellInDirection:nextRegularCell :(event.shiftKey?[FLXSFlexDataGrid CELL_POSITION_LEFT]:[FLXSFlexDataGrid CELL_POSITION_RIGHT]) :YES :YES];
//				if(event.shiftKey && nextRegularCellRowIndex==0)
//				{
//					break;
//				}
//				if(!event.shiftKey && nextRegularCellRowIndex==(self.grid.bodyContainer.itemVerticalPositions.length-1))
//				{
//					break;
//				}
//			}
//		}
//	}
//	if(nextCell)
//	{
//		CellInfo* cellData = [[CellInfo alloc] init:nextCell.rowInfo.data :nextCell.column];
//		if(nextCell)
//		{
//			if(!nextCell.isLocked && !grid.forceColumnsToFitVisibleArea)
//			{
//				Point* pt=[[Point alloc] init:0 :0];
//				pt=[nextCell localToGlobal:pt];
//				pt= [self globalToContent:pt];
//				float newHorizontal=0;
//				newHorizontal=pt.x;
//				if((newHorizontal> (horizontalScrollPosition+width))||(newHorizontal< (horizontalScrollPosition)))
//				{
//					[self.grid gotoHorizontalPosition:([Math min:newHorizontal :self.grid.bodyContainer.maxHorizontalScrollPosition])];
//				}
//			}
//		}
//		nextCell=[self getCellForRowColumn:cellData.rowData :cellData.column];
//		if(self.grid.enableDoubleClickEdit)
//		{
//			if([self.grid isCellEditable:nextCell])
//			{
//				[self beginEdit:nextCell as IFLXSFlexDataGridDataCell];
//			}
//		}
//		else
//[self handleMouseClick:nextCell :event :NO];
//	}
}

-(void)doInvalidate
{
    [self setNeedsDisplay];
}

-(void)invalidateDisplayList
{
    [super setNeedsDisplay];
}

-(void)gotoHorizontalPosition:(float)hsp
{
	if(self .grid.dataProviderFLXS ==nil)
	{
		_horizontalScrollPending=hsp;
		[self doInvalidate];
		return;
	}
	if(self.horizontalScrollPosition!=hsp)
	{
		BOOL scrollRight=(self.horizontalScrollPosition<hsp);
		self.horizontalScrollPosition=hsp;
		[self recycleH:self.grid.columnLevel scrollRight:scrollRight];
		[self.grid synchronizeHorizontalScroll];
	}
}

- (void)scrollToExistingRow:(float)vsp scrollDown:(BOOL)scrollDown {
}

-(BOOL)isOutOfVisibleArea:(FLXSRowInfo*)row
{
	return NO;
}

- (void)endEdit:(UIView *)editor event:(FLXSEvent *)event {
//	if(!_inEdit)return;
//	_inEdit=NO;
//	FLXSFlexDataGridItemEditEvent* evt= [[FLXSFlexDataGridItemEditEvent alloc] initWithType:[FLXSFlexDataGridEvent ITEM_EDIT_END] :self.grid :editCell.level :editCell.column :editCell :editCell.rowInfo.data :event];
//	evt.itemEditor = editor as UIComponent;
//	FLXSFlexDataGridColumn* col=editCell.column;
//	if(editCell.renderer==editCell)
//	{
//		//self means we are FLXSFlexDataGridDataCell2
//		[editCell refreshCell];
//	}
//	else
//	{
//		editCell.renderer.hidden=NO;
//	}
//	[self.grid highlightRow:editCell :editCell.rowInfo :NO];
//	[self.grid invalidateCells];
//	grid.currentCell=nil;
//	editCell=nil;
//	validationFailed=NO;
//	UIView* sbRoot = [systemManager getSandboxRoot];
//	[sbRoot removeEventListener:[MouseEvent MOUSE_UP] :cancelEdit :YES];
//	[sbRoot removeEventListener:[SandboxMouseEvent MOUSE_UP_SOMEWHERE] :cancelEdit];
//	[editor removeEventListener:[FlexEvent VALUE_COMMIT] :onEditorValueCommit];
//	[editor removeEventListener:[KeyboardEvent KEY_DOWN] :onEditorKeyDown];
//	[editor drawFocus:NO];
//	if(focusManager&&( focusManager.defaultButtonEnabled != _prevDefaultButtonEnabled))
//	{
//		focusManager.defaultButtonEnabled = _prevDefaultButtonEnabled;
//	}
//	[self callLater:[FLXSUIUtils removeChild] :([editor.superview,editor])];
//	[col dispatchEvent:evt];
}

-(void)cancelEdit:(FLXSEvent*)event
{
//	if (event is MouseEvent && ([self owns:(((UIView*)(event.target)))] || (editor&&editor.[self owns:(((UIView*)(event.target)))]) ) )
//	{
//		if(((event.target is FLXSIFlexDataGridCell) &&
//			(event.target as FLXSIFlexDataGridCell).rowInfo.isFillRow)
//			||
//			(event.target [isEqualself.grid.bodyContainer.backgroundForFillerRows ])
//			||
//			([event.target isEqual:self.grid.leftLockedContent.backgroundForFillerRows])
//			||
//			([event.target isEqual:self.grid.rightLockedContent.backgroundForFillerRows])
//			)
//		{
//			//end edit
//		}
//		else
//return;
//	}
//	if(event is SandboxMouseEvent )
//	{
//		SandboxMouseEvent* se = event as SandboxMouseEvent;
//		if(se && !se.buttonDown)
//			return;
//	}
//	FLXSFlexDataGridItemEditEvent* evt= [[FLXSFlexDataGridItemEditEvent alloc] initWithType:[FLXSFlexDataGridEvent ITEM_EDIT_CANCEL] :self.grid :editCell.level :editCell.column :editCell :editCell.rowInfo.data :event];
//	evt.itemEditor=event.currentTarget as UIComponent;
//	[editCell.column dispatchEvent:evt];
//	if(![evt isDefaultPrevented])
//		[self endEdit:editor :evt];
}

-(void)onEditorValueCommit:(FLXSEvent*)event
{
//	if(editCell.column.itemEditorApplyOnValueCommit)
//	{
//		[self populateValue:event];
//	}
}

- (BOOL)populateValue:(FLXSEvent *)event itemEditor:(UIView *)itemEditor {
	UIView<FLXSIFlexDataGridDataCell>* cell=self.editCell;
    self.validationFailed=NO;
	if(cell.columnFLXS.itemEditorManagesPersistence)return YES;
	//[self endEdit:event.currentTarget];
	FLXSFlexDataGridItemEditEvent* evt= [[FLXSFlexDataGridItemEditEvent alloc] initWithType:[FLXSFlexDataGridEvent ITEM_EDIT_VALUE_COMMIT] andGrid:self.grid andLevel:cell.level andColumn:cell.columnFLXS andCell:cell andItem:cell.rowInfo.data andTriggerEvent:event andBubbles:NO andCancelable:NO ];
	evt.itemEditor=itemEditor!=nil?itemEditor:(UIView* )event.target ;
	evt.item=self.editCell.rowInfo.data;
	evt.changedValue= [self.editor valueForKey:cell.columnFLXS.editorDataField];
	[cell.columnFLXS dispatchEvent:evt];
	if(![evt isDefaultPrevented])
	{
        id target = self.grid.delegate;

		if(cell.columnFLXS.itemEditorValidatorFunction==nil ||
                [ ((NSNumber*(*) (id, SEL,UIView*))objc_msgSend)(target, NSSelectorFromString(cell.columnFLXS.itemEditorValidatorFunction),
                self.editor) boolValue])
		{
			if(self.grid.enableTrackChanges)
			{
                [self.grid trackChange:cell.rowInfo.data changeType:[FLXSChangeInfo CHANGE_TYPE_UPDATE] changeLevel:cell.level changedProperty:cell.columnFLXS.dataFieldFLXS previousValue:([FLXSExtendedUIUtils resolveExpression:cell.rowInfo.data expression:cell.columnFLXS.dataFieldFLXS valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ]) changedValue:evt.changedValue];
			}
            [FLXSExtendedUIUtils resolveExpression:cell.rowInfo.data expression:cell.columnFLXS.dataFieldFLXS valueToApply:([itemEditor valueForKey:cell.columnFLXS.editorDataField]) returnUndefinedIfPropertyNotFound:NO applyNullValues:YES ];
			if(cell.level)
				[cell refreshCell];
			return YES;
		}
		else if(cell.columnFLXS.itemEditorValidatorFunction!=nil)
		{
			self.validationFailed=YES;
			return NO;
		}
	}
        return NO;
}

-(void)invalidateCells
{
	for(FLXSRowInfo* row1 in [self getAllRows])
	{
		for(FLXSComponentInfo* cell1 in row1.cells)
		{
			if([cell1.component conformsToProtocol:@protocol(FLXSIFlexDataGridCell) ])
			{
				[(UIView<FLXSIFlexDataGridCell>*)cell1.component invalidateBackground];
			}
		}
	}
}


- (void)highlightRow:(UIView <FLXSIFlexDataGridCell> *)cell row:(FLXSRowInfo *)row highLight:(BOOL)highLight highLightColor:(id)highLightColor {
    [self.grid highlightRow:cell row:row highLight:highLight highLightColor:highLightColor];
}

- (UIView <FLXSIFlexDataGridCell> *)getCellInDirection:(UIView <FLXSIFlexDataGridCell> *)thisCell direction:(NSString *)direction dataOnly:(BOOL)dataOnly editableOnly:(BOOL)editableOnly scrollIfNecessary:(BOOL)scrollIfNecessary hoverableOnly:(BOOL)hoverableOnly {
    FLXSRowInfo* adjacentRow;
    FLXSRowInfo* thisRow=thisCell.rowInfo;
//	FLXSFlexDataGridColumn* thisCol=thisCell.column;
	NSArray* thiCells=[thisRow getInnerCells];
    [thiCells sortedArrayUsingSelector:NSSelectorFromString(@"perceivedX")];
//	int thisIndex=[thiCells indexOfObject:thisCell];
	BOOL above = [direction isEqual:[FLXSFlexDataGrid CELL_POSITION_ABOVE]]|| [direction isEqual: [FLXSFlexDataGrid CELL_POSITION_ABOVE_LAST]];
	BOOL toleft = direction == [FLXSFlexDataGrid CELL_POSITION_LEFT];
	BOOL vertical = direction == [FLXSFlexDataGrid CELL_POSITION_ABOVE]||
direction == [FLXSFlexDataGrid CELL_POSITION_BELOW] || [direction isEqual: [FLXSFlexDataGrid CELL_POSITION_BELOW_FIRST]]
|| direction == [FLXSFlexDataGrid CELL_POSITION_ABOVE_LAST];
	UIView<FLXSIFlexDataGridCell>* adjacentCell;
	if([direction  isEqual: [FLXSFlexDataGrid CELL_POSITION_LEFT]] || [direction isEqual: [FLXSFlexDataGrid CELL_POSITION_RIGHT] ])
		adjacentRow=thisCell.rowInfo;
	else
	{
		for(FLXSRowInfo* row in self.rows)
		{
			if(!adjacentRow)
				adjacentRow=above?row:self.rows[self.rows.count-1];
			if(above && (![row isEqual:thisRow])&&(row.y>adjacentRow.y) &&(row.y<thisRow.y) && (!dataOnly || row.isDataRow))
			{
				adjacentRow=row;
			}
			else if(!above && (![row isEqual:thisRow])&&(row.y<adjacentRow.y) &&(row.y>thisRow.y)&& (!dataOnly || row.isDataRow))
			{
				adjacentRow=row;
			}
		}
	}
	if([direction isEqual: [FLXSFlexDataGrid CELL_POSITION_ABOVE_LAST]] && !self.grid.forceColumnsToFitVisibleArea &&
		scrollIfNecessary)
	{
		//we will need to scroll
		[self.grid gotoHorizontalPosition:self.grid.bodyContainer.maxHorizontalScrollPosition];
	}
	else if([direction isEqual: [FLXSFlexDataGrid CELL_POSITION_BELOW_FIRST]] &&
!self.grid.forceColumnsToFitVisibleArea && scrollIfNecessary)
	{
		//we will need to scroll
		[self.grid gotoHorizontalPosition:0];
	}
	if(scrollIfNecessary && vertical && [self isOutOfVisibleArea:adjacentRow])
	{
		if(!above)
		{
			//scroll down
			[self scrollToExistingRow:MIN(self.maxVerticalScrollPosition, (self.verticalScrollPosition + adjacentRow.height)) scrollDown:YES ];
		}
		else
		{
			//scroll up
			[self scrollToExistingRow:MAX(0, (self.verticalScrollPosition - adjacentRow.height)) scrollDown:NO ];
		}
	}

	NSArray* cells=[adjacentRow.cells mutableCopy];
    [cells sortedArrayUsingSelector:NSSelectorFromString(@"perceivedX")];

	if([direction isEqual: [FLXSFlexDataGrid CELL_POSITION_ABOVE_LAST]]||[direction isEqual: [FLXSFlexDataGrid CELL_POSITION_RIGHT]])
        cells=[[cells reverseObjectEnumerator] allObjects];
	if([direction isEqual: [FLXSFlexDataGrid CELL_POSITION_ABOVE]]||
		[direction isEqual: [FLXSFlexDataGrid CELL_POSITION_BELOW]])
	{
//		UIView<FLXSIFlexDataGridCell>* retCell;
		if(thisRow.isColumnBased&&adjacentRow.isColumnBased && thisCell.columnFLXS && [adjacentRow getCellForColumn:thisCell.columnFLXS])
		{
			return [self checkRowSpanColSpan:(((UIView <FLXSIFlexDataGridCell> *) ([adjacentRow getCellForColumn:thisCell.columnFLXS].component))) thisCell:thisCell direction:direction dataOnly:dataOnly editableOnly:editableOnly scrollIfNecessary:scrollIfNecessary hoverableOnly:hoverableOnly];
		}
		else
		{
			return [self checkRowSpanColSpan:([self getFirstHoverableCell:adjacentRow dataOnly:dataOnly editableOnly:editableOnly]) thisCell:thisCell direction:direction dataOnly:dataOnly editableOnly:editableOnly scrollIfNecessary:scrollIfNecessary hoverableOnly:hoverableOnly];
		}
	}
	for(FLXSComponentInfo* adjCellComp in cells)
	{
		UIView<FLXSIFlexDataGridCell>* adjCell = [adjCellComp.component conformsToProtocol:@protocol(FLXSIFlexDataGridCell)]?adjCellComp.component:nil;
		if(hoverableOnly&&![self isHoverableCell:adjCell])continue;
		if(dataOnly&&!([adjCell conformsToProtocol:@protocol(FLXSIFlexDataGridDataCell)]))continue;
		if(editableOnly&& ![self.grid isCellEditable:adjCell])continue;
		{
			if([direction isEqual: [FLXSFlexDataGrid CELL_POSITION_BELOW_FIRST]]||[direction isEqual: [FLXSFlexDataGrid CELL_POSITION_ABOVE_LAST]])
				return [self checkRowSpanColSpan:adjCell thisCell:thisCell direction:direction dataOnly:dataOnly editableOnly:editableOnly scrollIfNecessary:scrollIfNecessary hoverableOnly:hoverableOnly];
			else if([direction isEqual: [FLXSFlexDataGrid CELL_POSITION_LEFT]] || [direction isEqual: [FLXSFlexDataGrid CELL_POSITION_RIGHT]])
			{
				if([direction isEqual:[FLXSFlexDataGrid CELL_POSITION_LEFT]])
				{
					if(adjCell.perceivedX<thisCell.perceivedX)
						adjacentCell=adjCell;
				}
				else
				{
					if(adjCell.perceivedX>thisCell.perceivedX)
						adjacentCell=adjCell;
				}
			}
			else
			{
                return nil;
				//throw [[Error alloc] initWithType:(@"Invalid cell direction" + direction)];
			}
		}
	}
	FLXSCellInfo* cellData = [[FLXSCellInfo alloc] initWithRowData:thisCell.rowInfo.data andColumn:thisCell.columnFLXS];
	UIView<FLXSIFlexDataGridCell>* diffParentAdjacentCell=nil;
	if(scrollIfNecessary && !self.grid.forceColumnsToFitVisibleArea &&

		(
		(!toleft&&self.grid.horizontalScrollPosition<self.grid.bodyContainer.maxHorizontalScrollPosition) ||
		(toleft&&self.grid.horizontalScrollPosition>0)
		)

		)
	{
		if(adjacentCell)
		{
			if(thisCell.isLeftLocked && !adjacentCell.isLocked && !toleft)
				return [self checkRowSpanColSpan:adjacentCell thisCell:thisCell direction:direction dataOnly:dataOnly editableOnly:editableOnly scrollIfNecessary:scrollIfNecessary hoverableOnly:hoverableOnly];
			else if(thisCell.isRightLocked && !adjacentCell.isLocked && toleft)
return [self checkRowSpanColSpan:adjacentCell thisCell:thisCell direction:direction dataOnly:dataOnly editableOnly:editableOnly scrollIfNecessary:scrollIfNecessary hoverableOnly:hoverableOnly];
			else if(thisCell.superview==adjacentCell.superview)
			{
				if(adjacentCell.superview==self.grid.bodyContainer)
				{
					//left and right scroll over the columns that are just outside the viewport causes them to half appear. so we set hsp
					NSObject* halfVisibleRowdata=adjacentCell.rowInfo.data;
					FLXSFlexDataGridColumn* halfVisibleColumn=adjacentCell.columnFLXS;
					if(halfVisibleRowdata && halfVisibleColumn)
					{
						if(!self.grid.forceColumnsToFitVisibleArea)
						{
							if(((adjacentCell.x+adjacentCell.width)>=self.horizontalScrollPosition) &&
								(adjacentCell.x<self.horizontalScrollPosition))
							{
								[self.grid gotoHorizontalPosition:adjacentCell.x];
								return [self checkRowSpanColSpan:([self getCellForRowColumn:halfVisibleRowdata column:halfVisibleColumn includeExp:NO ]) thisCell:thisCell direction:direction dataOnly:dataOnly editableOnly:editableOnly scrollIfNecessary:scrollIfNecessary hoverableOnly:hoverableOnly];
								;
							}
							else if(((adjacentCell.x+adjacentCell.width)>(self.horizontalScrollPosition+self.width)) &&
                                (adjacentCell.x<(self.horizontalScrollPosition+self.width)))
							{
								[self.grid gotoHorizontalPosition:MIN(self.horizontalScrollPosition + adjacentCell.width,self.grid.bodyContainer.maxHorizontalScrollPosition)];
								return [self checkRowSpanColSpan:([self getCellForRowColumn:halfVisibleRowdata column:halfVisibleColumn includeExp:NO ]) thisCell:thisCell direction:direction dataOnly:dataOnly editableOnly:editableOnly scrollIfNecessary:scrollIfNecessary hoverableOnly:hoverableOnly];
								;
							}
						}
					}
				}
				return [self checkRowSpanColSpan:adjacentCell thisCell:thisCell direction:direction dataOnly:dataOnly editableOnly:editableOnly scrollIfNecessary:scrollIfNecessary hoverableOnly:hoverableOnly];
			}
			else
diffParentAdjacentCell=adjacentCell;
		}
        float newPos=(!toleft?((self.grid.horizontalScrollPosition+thisCell.width)< self.grid.bodyContainer.maxHorizontalScrollPosition)?
                (self.grid.horizontalScrollPosition+thisCell.width):self.grid.bodyContainer.maxHorizontalScrollPosition
                :(self.grid.horizontalScrollPosition-thisCell.width)>0?self.grid.horizontalScrollPosition-thisCell.width:0 );
		[self.grid gotoHorizontalPosition:newPos];
		FLXSFlexDataGridColumn* adjCol=cellData.columnFLXS ?
[cellData.columnFLXS getAdjacentColumn:(toleft ? -1 : 1)]:nil;
		if(!adjCol)
			return [self checkRowSpanColSpan:diffParentAdjacentCell thisCell:thisCell direction:direction dataOnly:dataOnly editableOnly:editableOnly scrollIfNecessary:scrollIfNecessary hoverableOnly:hoverableOnly];
		thisCell= [self getCellForRowColumn:cellData.rowData column:adjCol includeExp:NO ];
		if(thisCell==nil||thisCell.rowInfo==nil)
		{
			//self means our anchor column actually scrolled out of view, so we move on to the next visible.
			NSArray* cols=[adjCol.level getVisibleColumns:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE],nil]];
            if(toleft)cols=[[cols reverseObjectEnumerator] allObjects];
			for(FLXSFlexDataGridColumn* col in cols)
			{
				if(((col.colIndex<adjCol.colIndex)&&toleft)
					||((col.colIndex>adjCol.colIndex)&&!toleft))
				{
					UIView<FLXSIFlexDataGridCell>* oCell = [self getCellForRowColumn:cellData.rowData column:col includeExp:NO ];
					if(oCell)
					{
						thisCell=oCell;
						break;
					}
				}
			}
		}
//		//if(vertical && above)
//		{
//			//if(thisCell.rowInfo.rowPositionInfo.rowIndex==0)
//			{
//				//return editableOnly?nil:thisCell;
//				//cannot do anytying
//				//
//			}
//			//
//		}
//		else if(vertical && !above)
//		{
//			//if(thisCell.rowInfo.rowPositionInfo.rowIndex==(self.grid.bodyContainer.itemVerticalPositions.length-1))
//			{
//				//return editableOnly?nil:thisCell;
//				//cannot do anytying
//				//
//			}
//			//
//		}
		UIView<FLXSIFlexDataGridCell>* result= [self getCellInDirection:thisCell direction:direction dataOnly:dataOnly editableOnly:editableOnly scrollIfNecessary:scrollIfNecessary hoverableOnly:hoverableOnly];
		if(editableOnly && [self.grid isCellEditable:thisCell])
		{
			adjacentCell=thisCell;
		}
		else if(result)
		{
			adjacentCell=result;
		}
		else
            adjacentCell=diffParentAdjacentCell;
	}
	return [self checkRowSpanColSpan:adjacentCell thisCell:thisCell direction:direction dataOnly:dataOnly editableOnly:editableOnly scrollIfNecessary:scrollIfNecessary hoverableOnly:hoverableOnly];
}

- (UIView <FLXSIFlexDataGridCell> *)checkRowSpanColSpan:(UIView <FLXSIFlexDataGridCell> *)retCell thisCell:(UIView <FLXSIFlexDataGridCell> *)thisCell direction:(NSString *)direction dataOnly:(BOOL)dataOnly editableOnly:(BOOL)editableOnly scrollIfNecessary:(BOOL)scrollIfNecessary hoverableOnly:(BOOL)hoverableOnly {
	if(!self.grid.hasRowSpanOrColSpan)
	{
		return retCell;
	}
	else if([retCell isEqual:thisCell])
	{
		return retCell;
	}
	else if(retCell&&[self isCoveredByRowSpanOrColspan:retCell])
	{
		return [self getCellInDirection:retCell direction:direction dataOnly:dataOnly editableOnly:editableOnly scrollIfNecessary:scrollIfNecessary hoverableOnly:hoverableOnly];
	}
	else
return retCell;
    return nil;
}

-(BOOL)isCoveredByRowSpanOrColspan:(UIView<FLXSIFlexDataGridCell>*)cell
{
    return [self isCoveredByRowSpan:cell] || [self isCoveredByColSpan:cell];
}

-(BOOL)isCoveredByRowSpan:(UIView<FLXSIFlexDataGridCell>*)cell
{
	if(!self.grid.hasRowSpanOrColSpan)return NO;
	for(FLXSRowInfo* row in self.rows)
	{
		if(row.rowPositionInfo.verticalPosition<cell.rowInfo.rowPositionInfo.verticalPosition)
		{
			//self row is above us.
			float maxCellHt= [row getMaxCellHeight:cell.columnFLXS];
			if((maxCellHt>row.height)&&((maxCellHt+row.rowPositionInfo.verticalPosition)>cell.rowInfo.rowPositionInfo.verticalPosition))
			{
				return YES;
			}
		}
		else
return NO;
	}
	return NO;
    return NO;
}

-(BOOL)isCoveredByColSpan:(UIView<FLXSIFlexDataGridCell>*)cell
{
	if(!self.grid.hasRowSpanOrColSpan)return NO;
	for(FLXSComponentInfo* comp in cell.rowInfo.cells)
	{
		UIView<FLXSIFlexDataGridCell>* cellComp=(UIView<FLXSIFlexDataGridCell>*)comp.component;
		if(cellComp.perceivedX>cell.perceivedX)return NO;
		//we're ahead of cell.
		if(cellComp&&cellComp.columnFLXS &&(cellComp.width>cellComp.columnFLXS.width))
		{
			if((cellComp.perceivedX+cellComp.width)>cell.perceivedX)
				return YES;
		}
	}
	return NO;
    return NO;
}

- (UIView <FLXSIFlexDataGridCell> *)getCellForRowColumn:(NSObject *)dataObject column:(FLXSFlexDataGridColumn *)col includeExp:(BOOL)includeExp {
	for(FLXSRowInfo* row in self.rows)
	{
		if([row.rowPositionInfo.rowData isEqual:dataObject])
		{
			for(FLXSComponentInfo* cell in row.cells)
			{
				UIView<FLXSIFlexDataGridCell>* fCell = (UIView<FLXSIFlexDataGridCell>*)cell.component;
				if(includeExp &&(fCell.isExpandCollapseCell))
				{
					return fCell;
				}
				else if(fCell && [fCell.columnFLXS isEqual:col] && col!=nil)
				{
					return fCell;
				}
				else if(col==nil && !fCell.isLocked && ([fCell conformsToProtocol:@protocol(FLXSIFlexDataGridDataCell) ]))
				{
					return fCell;
				}
			}
		}
	}
	return nil;
    return nil;
}

-(void)removeEventListeners:(FLXSComponentInfo*)comp
{
	UIView<FLXSIFlexDataGridCell>* cell=(UIView<FLXSIFlexDataGridCell>*)comp.component;
	if([cell isKindOfClass:[FLXSFlexDataGridPagerCell class]])
	{
		UIView<FLXSIExtendedPager>* iPager=(UIView<FLXSIExtendedPager>* )cell.renderer;
		if(iPager.level.nestDepth==1)
			[iPager removeEventListenerOfType:[FLXSExtendedFilterPageSortChangeEvent PAGE_CHANGE] fromTarget:self usingHandler:@selector(rootPageChange:)];
		else
            [iPager removeEventListenerOfType:[FLXSExtendedFilterPageSortChangeEvent PAGE_CHANGE] fromTarget:self usingHandler:@selector(onPageChange:)];
	}
	if ([cell isKindOfClass:[FLXSFlexDataGridHeaderCell class]])
	{
		//[cell removeEventListener:[FLXSTouchEvent TOUCH_MOVE] :self :@selector(onHeaderCellMouseMove:)];
		//[cell removeEventListener:[FLXSTouchEvent MOUSE_OUT] :self :@selector(onHeaderCellMouseOut:)];
		[cell removeEventListenerOfType:[FLXSTouchEvent TOUCH_DOWN] fromTarget:self usingHandler:@selector(onHeaderCellMouseDown:)];
		if([cell.columnFLXS isKindOfClass:[FLXSFlexDataGridCheckBoxColumn class]])
			[cell removeEventListenerOfType:[FLXSFlexDataGridEvent SELECT_ALL_CHECKBOX_CHANGED] fromTarget:self usingHandler:@selector(selectAllChangedHandler:)];
		//[cell removeEventListener:[FLXSTouchEvent MOVE] :self :@selector(placeSortIcon:)];
		[cell removeEventListenerOfType:[FLXSTouchEvent RESIZE] fromTarget:self usingHandler:@selector(placeSortIcon:)];
	}
	if ([cell isKindOfClass:[FLXSFlexDataGridColumnGroupCell class]])
	{
		//[cell removeEventListener:[FLXSTouchEvent TOUCH_MOVE] :self :@selector(onHeaderCellMouseMove:)];
		//[cell removeEventListener:[FLXSTouchEvent MOUSE_OUT] :self :@selector(onHeaderCellMouseOut:)];
		[cell removeEventListenerOfType:[FLXSTouchEvent TOUCH_DOWN] fromTarget:self usingHandler:@selector(onHeaderCellMouseDown:)];
	}
	if ([cell isKindOfClass:[FLXSFlexDataGridFilterCell class]] && [cell.renderer conformsToProtocol:@protocol(FLXSIFilterControl)])
	{
		[cell.rowInfo unRegisterIFilterControl:(UIView<FLXSIFilterControl>*)cell.renderer];
	}
//	if(self.grid.enableDrop && cell)
//	{
//		//[cell removeEventListener:[FLXSTouchEvent TOUCH_MOVE] :self :@selector(onCellDropMouseMove:)];
//	}
	[cell removeEventListenerOfType:[FLXSTouchEvent TOUCH_MOVE] fromTarget:self usingHandler:@selector(onCellMouseOver:)];
	//[cell removeEventListener:[FLXSTouchEvent KEY_UP] :self :@selector(onCellKeyUp:)];
	[cell removeEventListenerOfType:[FLXSTouchEvent TAP] fromTarget:self usingHandler:@selector(onCellMouseClick:)];
	[cell removeEventListenerOfType:[FLXSTouchEvent DOUBLE_TAP] fromTarget:self usingHandler:@selector(onCellDoubleClick:)];
	//[cell removeEventListener:[FLXSTouchEvent MOUSE_OUT] :self :@selector(onCellMouseOut:)];
}

- (FLXSRowInfo *)addRow:(float)ht scrollDown:(BOOL)scrollDown rowPositionInfo:(FLXSRowPositionInfo *)rowPositionInfo {
	FLXSRowInfo* rowInfo= [[FLXSRowInfo alloc]                           initWithHeight:ht andY:([self isKindOfClass:[FLXSFlexDataGridBodyContainer class]] ?
            rowPositionInfo.verticalPosition : self.grid.currentPoint.contentY) andGrid:self.grid];
	rowInfo.rowPositionInfo=rowPositionInfo;

    self.grid.currentPoint.contentY+=ht;
    self.grid.currentPoint.contentX=self.grid.currentPoint.leftLockedContentX=self.grid.currentPoint.rightLockedContentX=0;
	if(!rowInfo.isFillRow)
	{
		if(scrollDown)
			[self.rows addObject:rowInfo];
		else
		{
			//scrolling up...
			int insertionPoint=0;
			while(insertionPoint<self.rows.count && rowInfo.y>((FLXSRowInfo*)self.rows[insertionPoint]).y )
			{
				insertionPoint++;
			}
			[self.rows insertObject:rowInfo atIndex:insertionPoint];
		}
		if(rowInfo.isFilterRow)
		{
			[rowInfo addEventListener:[FLXSFilterPageSortChangeEvent FILTER_CHANGE] target:self handler:@selector(onFilterChange:)];
		}
	}
	return rowInfo;
}

- (FLXSComponentAdditionResult *)addCell:(UIView *)component row:(FLXSRowInfo *)row existingComponent:(FLXSComponentInfo *)existingComponent {
	FLXSComponentAdditionResult* result=[[FLXSComponentAdditionResult alloc] init];
    FLXSComponentInfo* comp=existingComponent;
    float remaining=0;

    if([component conformsToProtocol:@protocol(FLXSIFlexDataGridCell)])
	{
		UIView<FLXSIFlexDataGridCell>* cell=(UIView<FLXSIFlexDataGridCell>*)component;
		if(cell.isLeftLocked )
		{
			if(cell.isContentArea)
			{
				comp= [self addToSection:cell row:row lockDir:(@"left") existingComponent:existingComponent];
			}
			else if(cell.rowInfo.isFooterRow || cell.rowInfo.isPagerRow)
			{
				if(!existingComponent)
				{
					[self.grid.leftLockedFooter addSubview :component];
					comp=[row addCell:component :self.grid.currentPoint.leftLockedFooterX];
				}
				comp.x=self.grid.currentPoint.leftLockedFooterX;
				if((cell.columnFLXS &&cell.columnFLXS.isLastLeftLocked) || (cell.level.nestDepth==1 && [cell.level.leftLockedColumns count] ==0))
				{
					remaining=self.grid.leftLockedContent.width-self.grid.currentPoint.leftLockedFooterX;
                    [cell setActualSizeWithWidth:remaining andHeight:cell.height];
				}
				self.grid.currentPoint.leftLockedFooterX+=component.width;
				component.y=self.grid.currentPoint.leftLockedFooterY;
				comp.inCornerAreas=YES;
			}
			else if(cell.rowInfo.isHeaderRow || cell.rowInfo.isFilterRow || cell.rowInfo.isColumnGroupRow)
			{
				if(!existingComponent)
				{
					[self.grid.leftLockedHeader addSubview:component];
					comp=[row addCell:component :self.grid.currentPoint.leftLockedHeaderX];
				}
				comp.x=self.grid.currentPoint.leftLockedHeaderX;
				if((cell.columnFLXS &&cell.columnFLXS.isLastLeftLocked) || (cell.level.nestDepth==1 && [cell.level.leftLockedColumns count] ==0))
				{
					remaining=self.grid.leftLockedContent.width-self.grid.currentPoint.leftLockedHeaderX;
                    [cell setActualSizeWithWidth:remaining andHeight:cell.height];
				}
				self.grid.currentPoint.leftLockedHeaderX+=component.width;
				component.y=self.grid.currentPoint.leftLockedHeaderY;
				comp.inCornerAreas=YES;
			}
		}
		else if(cell.isRightLocked)
		{
			if(cell.isContentArea)
			{
				comp= [self addToSection:cell row:row lockDir:(@"right") existingComponent:nil ];
			}
			else if(cell.rowInfo.isFooterRow|| cell.rowInfo.isPagerRow)
			{
				if(!existingComponent)
				{
					[FLXSUIUtils addChild:self.grid.rightLockedFooter child:component];
					comp=[row addCell:component :self.grid.currentPoint.rightLockedFooterX];
				}
				comp.x=self.grid.currentPoint.rightLockedFooterX;
				if(cell.columnFLXS &&cell.columnFLXS.isLastRightLocked)
				{
					remaining=self.grid.rightLockedContent.width-self.grid.currentPoint.rightLockedFooterX;
                    [cell setActualSizeWithWidth:remaining andHeight:cell.height];
				}
                self.grid.currentPoint.rightLockedFooterX+=component.width;
				component.y=self.grid.currentPoint.rightLockedFooterY;
				comp.inCornerAreas=YES;
			}
			else if(cell.rowInfo.isHeaderRow || cell.rowInfo.isFilterRow|| cell.rowInfo.isColumnGroupRow)
			{
				if(!existingComponent)
				{
					[FLXSUIUtils addChild:self.grid.rightLockedHeader child:component];
					comp=[row addCell:component :self.grid.currentPoint.rightLockedHeaderX];
				}
				comp.x=self.grid.currentPoint.rightLockedHeaderX;
				if(cell.columnFLXS &&cell.columnFLXS.isLastRightLocked)
				{
					remaining=self.grid.rightLockedContent.width-self.grid.currentPoint.rightLockedHeaderX;
                    [cell setActualSizeWithWidth:remaining andHeight:cell.height];
				}
                self.grid.currentPoint.rightLockedHeaderX+=component.width;
				component.y=self.grid.currentPoint.rightLockedHeaderY;
				comp.inCornerAreas=YES;
			}
		}
		else
		{
			if(!existingComponent)
			{
				[FLXSUIUtils addChild:self child:component];
				comp=[row addCell:component :self.grid.currentPoint.contentX];
			}
			comp.x=self.grid.currentPoint.contentX;
            self.grid.currentPoint.contentX+=component.width;
		}
	}
	else
	{
		if(!existingComponent)
		{
			[FLXSUIUtils addChild:self child:component];
			comp=[row addCell:component :self.grid.currentPoint.contentX];
		}
		comp.x=self.grid.currentPoint.contentX;
        self.grid.currentPoint.contentX+=component.width;
	}
	result.componentInfo=comp;
	if([comp.component conformsToProtocol:@protocol(FLXSIFlexDataGridCell)])
	{
		((UIView <FLXSIFlexDataGridCell>*)comp.component).componentInfo=comp;
	}
	result.horizontalSpill = (self.grid.currentPoint.contentX > self.width);
	result.verticalSpill = (self.grid.currentPoint.contentY > self.height+1);
	return result;
}

- (FLXSComponentInfo *)addToSection:(UIView <FLXSIFlexDataGridCell> *)cell row:(FLXSRowInfo *)row lockDir:(NSString *)lockDir existingComponent:(FLXSComponentInfo *)existingComponent {
	float remaining=0;
	float lockedCount = [[cell.level valueForKey:[lockDir stringByAppendingString:@"LockedColumns"]] count];
	if(!existingComponent)
		[FLXSUIUtils addChild:([self.grid valueForKey:[lockDir stringByAppendingString:@"LockedContent"]]) child:cell];
	//if self level has a renderer, the first lockDir locked cell is also the last
	//if self level does not have a renderer and there are no lockDir locked columns,
	//the disclosure cell, which is the second cell added is going to be the last
	//else if the level does have lockDir locked columns, then we ask the column if
	//it is the last lockDir locked column.
	BOOL isLast = (cell.rowInfo.isRendererRow||cell.rowInfo.isPagerRow)
    || (([cell.rowInfo.cells count] >0 || cell.level.nestDepth==1) && lockedCount==0)
    || (cell.columnFLXS &&[[cell.columnFLXS valueForKey:[[[NSArray alloc] initWithObjects:@"isLast", [FLXSCellUtils doCap:lockDir], @"Locked", nil] componentsJoinedByString:@""]] boolValue]);

    float currentPosition=[[self.grid.currentPoint valueForKey:[lockDir stringByAppendingString:@"LockedContentX"]] floatValue];
	FLXSComponentInfo* comp=existingComponent?existingComponent:[row addCell:cell:currentPosition ];
	comp.x=currentPosition;
    NSString *propName=[lockDir stringByAppendingString:@"LockedContentX"];
	if(isLast )
	{
        currentPosition=[[self.grid.currentPoint valueForKey:propName] floatValue];
        UIView * lockedView = [self.grid valueForKey:[lockDir stringByAppendingString:@"LockedContent"]];
		remaining=lockedView.width-currentPosition;
        [cell setActualSizeWithWidth:remaining andHeight:cell.height];
	}
    currentPosition=[[self.grid.currentPoint valueForKey:propName] floatValue];
    [self.grid.currentPoint setValue:([NSNumber numberWithFloat:currentPosition+cell.width]) forKey:propName];
	return comp;
}

- (FLXSItemLoadInfo *)findLoadingInfo:(NSObject *)item level:(FLXSFlexDataGridColumnLevel *)level useSelectedKeyField:(BOOL)useSelectedKeyField {
	for(FLXSItemLoadInfo* loadingItem in self.loadedItems)
	{

		if([loadingItem isEqual:item levelToCompare:level useSelectedKeyField:useSelectedKeyField])
		{
			return loadingItem;
		}
	}
	return nil;
}

- (BOOL)processRendererLevel:(FLXSRowPositionInfo *)rowPositionInfo scrollDown:(BOOL)scrollDown {
    FLXSFlexDataGridColumnLevel* level=[rowPositionInfo getLevel:self.grid];
	float paddingY=[level getStyleValue:(@"horizontalGridLines")]?1:0;
	FLXSRowInfo* row = [self addRow:level.levelRendererHeight scrollDown:scrollDown rowPositionInfo:rowPositionInfo];
	if(![row paddingExists])
        [self addPadding:level.nestDepth row:row paddingHeight:(level.levelRendererHeight - paddingY) level:level forceRightLock:NO scrollPad:NO width:-1];

    UIView<FLXSIFlexDataGridCell>* dataCell = (UIView<FLXSIFlexDataGridCell>*)[self.grid.rendererCache popInstance:[FLXSFlexDataGridContainerBase levelRendererFactory] subFactory:nil ];
	dataCell.rendererFactory = level.nextLevelRenderer;
	dataCell.level= level;
	dataCell.rowInfo =row;
	[self addEventListeners:[self addCell:dataCell row:row existingComponent:nil ].componentInfo];
	[dataCell refreshCell];

    [dataCell setActualSizeWithWidth:[[rowPositionInfo getLevel:self.grid] getSumOfColumnWidths:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE], nil]] andHeight:level.levelRendererHeight];
	[self.grid placeComponents:row];
	return YES;
}

-(void)placeComponents
{
	for(FLXSRowInfo* row in self.rows)
	{
		[self.grid placeComponents:row];
	}
}

- (BOOL)processHeaderLevel:(FLXSFlexDataGridColumnLevel *)level rowPositionInfo:(FLXSRowPositionInfo *)rowPositionInfo scrollDown:(BOOL)scrollDown item:(NSObject *)item chromeLevel:(int)chromeLevel existingRow:(FLXSRowInfo *)existingRow existingComponents:(NSArray *)existingComponents {
//	float paddingY=[level getStyleValue:(@"horizontalGridLines")]?1:0;
	float rowHeight = (chromeLevel==[FLXSRowPositionInfo ROW_TYPE_COLUMN_GROUP]||chromeLevel==[FLXSRowPositionInfo ROW_TYPE_HEADER])?rowPositionInfo.rowHeight:[level getRowHeight:chromeLevel];
	FLXSRowInfo* row;
	if(!existingRow)
	{
		row= [self addRow:rowHeight scrollDown:scrollDown rowPositionInfo:rowPositionInfo];
	}
	else
	{
		self.grid.currentPoint.contentX=self.grid.currentPoint.rightLockedContentX=self.grid.currentPoint.leftLockedContentX=0;
		row=existingRow;
	}
	int nestLevel=rowPositionInfo?rowPositionInfo.rowNestLevel:0;
	if(self.grid.enableDefaultDisclosureIcon)
	{
		if(([self isInVisibleHorizontalRange:self.grid.currentPoint.contentX width:level.nestIndent * (nestLevel - 1)]
			  || self.grid.lockDisclosureCell)
			&& (!existingRow||![row paddingExists]))
            [self addPadding:rowPositionInfo.rowNestLevel row:row paddingHeight:rowHeight level:level forceRightLock:NO scrollPad:NO width:-1];
		else if(!self.grid.lockDisclosureCell)
            self.grid.currentPoint.contentX+=level.nestIndent*(nestLevel-1);
		if(!row.isPagerRow)
		{
			if((level.nextLevel||level.nextLevelRenderer))
			{
				if(([self isInVisibleHorizontalRange:self.grid.currentPoint.contentX width:level.nestIndent] || self.grid.lockDisclosureCell)
					&& (!existingRow||![row disclosureExists]))
				{
					if(!row.isColumnGroupRow)
					{
						FLXSFlexDataGridExpandCollapseHeaderCell* disclosureCell= (FLXSFlexDataGridExpandCollapseHeaderCell*) [self.grid.rendererCache popInstance:level.expandCollapseHeaderCellRenderer subFactory:nil ];
						disclosureCell.rowInfo=row;
						disclosureCell.level =level;
                        [disclosureCell setActualSizeWithWidth:level.maxDisclosureCellWidth andHeight:(chromeLevel == [FLXSRowPositionInfo ROW_TYPE_HEADER] && level.nestDepth == 1 ?
                                self.grid.headerContainer.height : rowHeight)];
						[self addEventListeners:([self addCell:disclosureCell row:row existingComponent:nil ].componentInfo)];
					}
				}
				else if(!self.grid.lockDisclosureCell)
                    self.grid.currentPoint.contentX+=level.maxDisclosureCellWidth;
			}
		}
	}
	if(chromeLevel==[FLXSRowPositionInfo ROW_TYPE_PAGER])
	{
		FLXSFlexDataGridPagerCell* pagerCell = (FLXSFlexDataGridPagerCell*)[self.grid.rendererCache popInstance:level.pagerCellRenderer subFactory:level.pagerRenderer];
		pagerCell.rendererFactory=level.pagerRenderer;
		pagerCell.level = level;
		pagerCell.rowInfo = row;
		UIView<FLXSIExtendedPager>* iPager = (UIView<FLXSIExtendedPager>* )pagerCell.renderer;
		iPager.grid=nil;
        iPager.grid=self.grid;
		float pagerWidth;
		if(level.nestDepth==1)
		{
			pagerWidth=[self getPagerWidth];
		}
		else
		{
			pagerWidth=[level getSumOfColumnWidths:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE],nil]];
		}

        [pagerCell setActualSizeWithWidth:pagerWidth andHeight:rowHeight];
		[pagerCell invalidateDisplayList];
		if(level.nestDepth==1)
		{
			pagerCell.hidden=self.grid.pagerRowHeight==0;
		}
		[self addEventListeners:([self addCell:pagerCell row:row existingComponent:nil ].componentInfo)];
		iPager.rowInfo=row;
		iPager.level=level;
		[pagerCell refreshCell];
		if(level.nestDepth==1)
		{
			[iPager addEventListenerOfType:[FLXSExtendedFilterPageSortChangeEvent PAGE_CHANGE] usingTarget:self withHandler:@selector(rootPageChange:)];
		}
		else
            [iPager addEventListenerOfType:[FLXSExtendedFilterPageSortChangeEvent PAGE_CHANGE] usingTarget:self withHandler:@selector(onPageChange:)];
	}
	else
	{

		NSArray* cols=[level getVisibleColumns:
                [[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE],[FLXSFlexDataGridColumn LOCK_MODE_LEFT],nil]];
		NSArray* flatDp;
		if(chromeLevel==[FLXSRowPositionInfo ROW_TYPE_FILTER])
		{
			if(level.nestDepth==1)
			{
				flatDp=[self.grid getRootFlat];
			}
			else
			{
				flatDp= [level getChildren:item filter:NO page:NO sort:NO ];
			}
		}
		if(chromeLevel==[FLXSRowPositionInfo ROW_TYPE_COLUMN_GROUP])
		{
			FLXSFlexDataGridColumnGroupCell* currentCGCell;
			int cgLevel=[row getColumnGroupDepth:self.grid];
			NSArray* cgs = [level getColumnGroupsAtLevel:cgLevel grps:nil result:nil start:0 all:NO ];
			/*NSString* str=@"";
			for(FLXSFlexDataGridColumnGroup* cg1 in cgs)
			{
				Array* cgWx1 = [cg1 getWX]
					str+=cg1.headerText + @":" + cgWx1[0] + @":" + cgWx1[1]+@"\n";
			}
			str+=@";"*/
for(FLXSFlexDataGridColumnGroup* cg in cgs)
			{
				NSArray* cgWx = [cg getWX];
                if(cg.startColumn&&([self isInVisibleHorizontalRange:[cgWx[1] floatValue] width:[cgWx[0] floatValue]] || cg.startColumn.isLocked)
                && (!existingRow||![row columnGroupCellExists:cg]))
				{
					currentCGCell= [self processColumnGroupCell:level rendererFactory:cg.columnGroupCellRenderer row:row item:item rowHeight:rowHeight columnGroup:cg existingComponents:existingComponents];
					currentCGCell.text=cg.headerText;
					[currentCGCell refreshCell];
				}
			}
		}
		else
		{
			self.grid.currentPoint.headerX=0;
			for( float colIndex = 0; colIndex < [cols count]; colIndex++ )
			{
				FLXSFlexDataGridColumn* col = [cols objectAtIndex:colIndex];
				if(!col.width)col.width=100;
				if(([self isInVisibleHorizontalRange:self.grid.currentPoint.headerX width:col.width]
					|| col.isLocked)
					&& (!existingRow||![row columnCellExists:col]))
				{
					if(chromeLevel==[FLXSRowPositionInfo ROW_TYPE_HEADER])
					{
						[self processHeaderCell:level columns:cols colIndex:colIndex row:row item:item rowHeight:rowHeight existingComponents:existingComponents];
					}
					else if(chromeLevel==[FLXSRowPositionInfo ROW_TYPE_FILTER])
					{
						[self processFilterCell:level columns:cols colIndex:colIndex row:row item:item flatDp:flatDp existingComponents:existingComponents];
					}
					else
					{
						[self processFooterCell:level columns:cols colIndex:colIndex row:row item:item existingComponents:existingComponents];
					}
				}
				else
				{
					if(!col.isLocked)
						self.grid.currentPoint.contentX+=col.width;
				}
				if(!col.isLocked)
                    self.grid.currentPoint.headerX+=col.width;
			}
			if(level.nestDepth==1)
			{
                //no need for scrollbar pad in ios
//				if((self.grid.forceColumnsToFitVisibleArea
//					|| (self.width>=[level getSumOfColumnWidths:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE],nil]])
//					|| (self.maxHorizontalScrollPosition>0&&
//					(self.maxHorizontalScrollPosition-self.horizontalScrollPosition<20)))
//					&&![row scrollBarPadExists])
//					[self addPadding:2 :row :self.height :level :NO :YES :16];
			}
			//now that we're done with the left locked and unlocked cols, do the right locked ones..
            cols=[level getVisibleColumns:[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_RIGHT],nil]];
			float wSoFar=0;
			for( int colIndex = 0; colIndex < [cols count]; colIndex++ )
			{
				FLXSFlexDataGridColumn *col = cols[colIndex];
				self.grid.currentPoint.contentX=self.width-wSoFar-col.width+1;
				if((!existingRow||![row columnCellExists:col]))
				{
					if(chromeLevel==[FLXSRowPositionInfo ROW_TYPE_HEADER])
					{
						[self processHeaderCell:level columns:cols colIndex:colIndex row:row item:item rowHeight:rowHeight existingComponents:existingComponents];
					}
					else if(chromeLevel==[FLXSRowPositionInfo ROW_TYPE_FILTER])
					{
						[self processFilterCell:level columns:cols colIndex:colIndex row:row item:item flatDp:flatDp existingComponents:existingComponents];
					}
					else
					{
						[self processFooterCell:level columns:cols colIndex:colIndex row:row item:item existingComponents:existingComponents];
					}
				}
				wSoFar+=col.width;
			}
		}
	}
	//do we have something right locked? if not, add something so we dont show a hole
	if(![row rightLockedExists] && level.nestDepth>1)
        [self addPadding:rowPositionInfo.rowNestLevel row:row paddingHeight:rowHeight level:level forceRightLock:YES scrollPad:NO width:-1];
	[self.grid placeComponents:row];
	return YES;
}

-(NSString*)traceRows
{
	NSString* str=@"";
	for(FLXSRowInfo* row in self.rows)
	{
        str=[str stringByAppendingString: [[[NSArray alloc] initWithObjects:
                [NSNumber numberWithInteger: row.rowPositionInfo.rowIndex ], @":",
                                            [NSNumber numberWithFloat: row.y]
                                            , @":",
                        [NSNumber numberWithFloat: row.rowPositionInfo.verticalPosition] ,
                        @":", [NSNumber numberWithInteger: row.rowPositionInfo.rowType],
                        @":", [NSNumber numberWithInteger: row.cells.count ], @":",nil ] componentsJoinedByString:@""]];
		for(FLXSComponentInfo* cell in row.cells)
		{
			UIView<FLXSIFlexDataGridCell>* comp = cell.component;
			FLXSFlexDataGridColumn* col = comp?comp.columnFLXS :nil;
            str= [str stringByAppendingFormat:@"%s|%f|%@" , [comp.text UTF8String],cell.x, (col?col.headerText:@" ")];
		}
        str= [str stringByAppendingString: @"\n"];
	}
	return str;
}

-(NSString*)traceCells
{
//	NSString* str=@"";
//	for(NSObject* obj in [self getChildren])
//	{
//		str+=(obj.x +@":" + obj.y + @":" + obj.width + @":" + obj.text +@"\n")
//	}
//	return str;
    return nil;
}

-(float)getPagerWidth
{
	float borderThickness= [(NSNumber *)[self.grid getStyle:(@"borderThickness")] floatValue];
	return self.grid.width-([self.grid hasBorderSide:(@"left")]?borderThickness:0)
-([self.grid hasBorderSide:(@"right")]?borderThickness:0)
-self.grid.isVScrollBarVisible;

}

- (void)processFilterCell:(FLXSFlexDataGridColumnLevel *)level columns:(NSArray *)cols colIndex:(int)colIndex row:(FLXSRowInfo *)row item:(NSObject *)item flatDp:(NSArray *)flatDp existingComponents:(NSArray *)existingComponents {
//	float paddingY=[level getStyleValue:(@"horizontalGridLines")]?1:0;
	FLXSFlexDataGridColumn* col = cols[colIndex];
	float rowHeight=level.filterRowHeight;
	FLXSFlexDataGridFilterCell* filtercell = (FLXSFlexDataGridFilterCell*)([self.grid.rendererCache popInstance:col.filterCellRenderer subFactory:col.filterRenderer]);
	filtercell.rendererFactory=col.filterRenderer;
	filtercell.rowInfo =row;
	filtercell.level = level;
	filtercell.columnFLXS =col;
    [filtercell setActualSizeWithWidth:col.width andHeight:rowHeight];
	[self addEventListeners:([self addCell:filtercell row:row existingComponent:nil ].componentInfo)];
    [filtercell setActualSizeWithWidth:col.width andHeight:rowHeight];
	if(level.nestDepth==1)
	{
		filtercell.hidden=level.filterRowHeight==0;
	}

	UIView<FLXSIFilterControl>* filterRenderer = [filtercell.renderer conformsToProtocol:@protocol(FLXSIFilterControl)]?
            (UIView<FLXSIFilterControl>*)filtercell.renderer:nil;
	FLXSFlexDataGridColumn* filterColumn =col;
	if(filterRenderer)
	{
		[FLXSFlexDataGridContainerBase initializeRendererFromColumn:filterRenderer filterColumn:filterColumn];
		[self initializeFilterRenderer:filterRenderer filterColumn:filterColumn item:item flatDp:flatDp level:level];
		[row registerIFilterControl:filterRenderer];
	}
}

+ (void)initializeRendererFromColumn:(UIView <FLXSIFilterControl> *)filterRenderer filterColumn:(FLXSFlexDataGridColumn *)filterColumn {
    if ([filterRenderer conformsToProtocol:@protocol(FLXSIFilterControl)])
    {
        FLXSTextInput* txt = [filterRenderer isKindOfClass:[FLXSTextInput class]]?(FLXSTextInput*)filterRenderer:nil;
        if (txt)
        {
            txt.placeholder=filterColumn.filterWaterMark;
            txt.clearTextOnIconClick = filterColumn.clearFilterOnIconClick;
            if(filterColumn.enableFilterAutoComplete)
            {
                txt.enableAutoComplete=YES;
            }
            txt.showIconWhenHasText = filterColumn.showClearIconWhenHasText;
        }
        FLXSMultiSelectComboBox* mscb = [filterRenderer isKindOfClass:[FLXSTextInput class]]?(FLXSMultiSelectComboBox*)filterRenderer:nil;
        if (mscb)
        {
            //mscb.placeHolder=filterColumn.filterWaterMark;
        }
        filterRenderer.grid = (NSObject <FLXSIExtendedDataGrid>*)filterColumn.level.grid;
        filterRenderer.searchField=filterColumn.searchField;
        filterRenderer.filterOperation=filterColumn.filterOperation;
        filterRenderer.filterTriggerEvent=filterColumn.filterTriggerEvent;
        if (![filterColumn.filterComparisonType isEqual: [FLXSFilterExpression FILTER_COMPARISON_TYPE_AUTO]])
            filterRenderer.filterComparisonType=filterColumn.filterComparisonType;
        filterRenderer.gridColumn=filterColumn;
    }
    //here we need to do the following
    //1) If filterRenderer is ISelectFilterControl, set its dataProviderFLXS, dataFieldFLXS
    UIView<FLXSISelectFilterControl>* iSelectFilterControl=
            ([filterRenderer conformsToProtocol:@protocol(FLXSISelectFilterControl)]?(UIView<FLXSISelectFilterControl>*)filterRenderer:nil);
    if (iSelectFilterControl != nil)
    {
        if (filterColumn.filterComboBoxDataProvider != nil)
            iSelectFilterControl.dataProviderFLXS =filterColumn.filterComboBoxDataProvider;
        if (![filterColumn.filterComboBoxDataField isEqual: @"data"])
                //the user overrode it
            iSelectFilterControl.dataFieldFLXS =filterColumn.filterComboBoxDataField;
        if (![filterColumn.filterComboBoxLabelField isEqual: @"label"])
                //the user overrode it
            iSelectFilterControl.labelField=filterColumn.filterComboBoxLabelField;
        iSelectFilterControl.addAllItem=YES;
        if (filterColumn.filterComboBoxWidth)
            iSelectFilterControl.dropDownWidth=filterColumn.filterComboBoxWidth;
    }
    UIView<FLXSITriStateCheckBoxFilterControl>* iTriStateCheckBoxFilterControl=
            ([filterRenderer conformsToProtocol:@protocol(FLXSITriStateCheckBoxFilterControl)]?(UIView<FLXSITriStateCheckBoxFilterControl>*)filterRenderer:nil);
    if (iTriStateCheckBoxFilterControl != nil)
    {
        iTriStateCheckBoxFilterControl.allowUserToSelectMiddle=YES;
        iTriStateCheckBoxFilterControl.selectedState=@"middle";
    }
    UIView<FLXSIDateComboBox>* iDateFilterControl=
            ([filterRenderer conformsToProtocol:@protocol(FLXSIDateComboBox)]?(UIView<FLXSIDateComboBox>*)filterRenderer:nil);
    if (iDateFilterControl && [filterColumn.filterDateRangeOptions count] > 0)
        iDateFilterControl.dateRangeOptions=filterColumn.filterDateRangeOptions;
}


- (void)initializeFilterRenderer:(UIView <FLXSIFilterControl> *)filterRenderer filterColumn:(FLXSFlexDataGridColumn *)filterColumn item:(NSObject *)item flatDp:(NSArray *)flatDp level:(FLXSFlexDataGridColumnLevel *)level {
    FLXSFilter* filter= [self.grid.itemFilters objectForKey:level.nestDepth==1?@"ROOT_FILTER":item];
    UIView<FLXSISelectFilterControl>* iSelectFilterControl=
            ([filterRenderer conformsToProtocol:@protocol(FLXSISelectFilterControl)]?(UIView<FLXSISelectFilterControl>*)filterRenderer:nil);
    if (iSelectFilterControl != nil)
	{
		if (filterColumn.filterComboBoxBuildFromGrid)
			[self buildFilter:iSelectFilterControl column:filterColumn parentObject:(level.nestDepth == 1 ? nil : item) flatValues:flatDp];
		else if(filterColumn.filterComboBoxDataProvider)
		{
			iSelectFilterControl.dataProviderFLXS = filterColumn.filterComboBoxDataProvider;
			if(filter)
			{
				for(FLXSFilterExpression* fexp in filter.arguments)
				{
					if([fexp.columnName isEqual: filterColumn.searchField])
					{
						[iSelectFilterControl setValue:fexp.expression];
					}
				}
			}
		}
	}
	if(filterColumn.enableFilterAutoComplete)
	{
		[self buildFilter:iSelectFilterControl column:filterColumn parentObject:(level.nestDepth == 1 ? nil : item) flatValues:flatDp];
	}
	if(filter && filterColumn.searchField)
	{
		NSObject* filterValue = [filter getFilterValue:filterColumn.searchField];
		if([filterRenderer conformsToProtocol:@protocol(FLXSIFilterControl)])
		{
            UIView<FLXSIFilterControl>* filterControl = (UIView<FLXSIFilterControl>*)filterRenderer;
            [filterControl clear];
			if(filterValue)
				[filterControl setValue:filterValue];
		}
	}
}

- (void)buildFilter:(UIView<FLXSISelectFilterControl> *)iSelectFilterControl column:(FLXSFlexDataGridColumn *)column parentObject:(NSObject *)parentObject flatValues:(NSArray *)flatValues {
	NSArray* collection= [column                                                             getDistinctValues:column.useCurrentDataProviderForFilterComboBoxValues ?
            [self filterPageSort:flatValues level:column.level parentObj:nil applyFilter:YES applyPaging:NO applySort:YES pages:nil updatePager:NO ] : flatValues collection:nil addedCodes:nil level:nil ];
	iSelectFilterControl.dataProviderFLXS = [collection mutableCopy];
	FLXSFilter* filter= [self.grid.itemFilters objectForKey:parentObject];
	if(filter)
	{
		for(FLXSFilterExpression* fexp in filter.arguments)
		{
			if([fexp.columnName isEqual: column.searchField])
			{
				[iSelectFilterControl setValue:fexp.expression];
			}
		}
	}
}

- (void)processFooterCell:(FLXSFlexDataGridColumnLevel *)level columns:(NSArray *)cols colIndex:(int)colIndex row:(FLXSRowInfo *)row item:(NSObject *)item existingComponents:(NSArray *)existingComponents {
//	float paddingY=[level getStyleValue:(@"horizontalGridLines")]?1:0;
	FLXSFlexDataGridColumn* col = cols[colIndex];
	float rowHeight=level.footerRowHeight;
	FLXSClassFactory* rendererFactory=[col deriveRenderer:[FLXSRowPositionInfo ROW_TYPE_FOOTER]];
	FLXSComponentInfo* existingComponent = [self getExistingCell:existingComponents rendererFactory:rendererFactory col:col];
	FLXSFlexDataGridFooterCell* footercell = (FLXSFlexDataGridFooterCell* )(existingComponent?existingComponent.component
            : [self.grid.rendererCache popInstance:col.footerCellRenderer subFactory:rendererFactory]);
	footercell.rendererFactory=rendererFactory;
	footercell.rowInfo =row;
	footercell.level = level;
	footercell.columnFLXS =col;
    [(UIView <FLXSIFlexDataGridCell> *) footercell setActualSizeWithWidth:col.width andHeight:rowHeight];
	footercell.wordWrap = col.footerWordWrap;
	if(existingComponent)
		[self addCell:footercell row:row existingComponent:existingComponent];
		else
		[self addEventListeners:([self addCell:footercell row:row existingComponent:existingComponent].componentInfo)];
	//[footercell setActualSize:col.width :rowHeight];
	if([footercell.renderer respondsToSelector:NSSelectorFromString(@"textAlignment")]){
        [footercell.renderer setValue:[NSNumber numberWithInt:(col.footerAlign>0?col.footerAlign: [[col getStyleValue:(@"textAlign")] intValue])] forKey:@"textAlignment"];
    }
//
	if([col getStyleValue:(@"footerStyleName")] && [footercell.renderer isKindOfClass:[UILabel class] ])
	{
        [((FLXSFontInfo *)[col getStyleValue:(@"footerStyleName")]) applyFont:(UILabel *)footercell.renderer];
	}
	if(item!=nil)
	{
		[footercell refreshCell];
	}
	if(level.nestDepth==1)
	{
		footercell.hidden=level.footerRowHeight==0;
	}
	[footercell invalidateDisplayList];
}

- (FLXSFlexDataGridColumnGroupCell *)processColumnGroupCell:(FLXSFlexDataGridColumnLevel *)level rendererFactory:(FLXSClassFactory *)rendererFactory row:(FLXSRowInfo *)row item:(NSObject *)item rowHeight:(float)rowHeight columnGroup:(FLXSFlexDataGridColumnGroup *)columnGroup existingComponents:(NSArray *)existingComponents {
//	float paddingY=[level getStyleValue:(@"horizontalGridLines")]?1:0;
	FLXSClassFactory* cgRenderer=columnGroup.columnGroupRenderer;
	if(!cgRenderer)cgRenderer=[FLXSFlexDataGridContainerBase labelFieldFactory];
	FLXSComponentInfo* existingComponent = [self getExistingCell:existingComponents rendererFactory:rendererFactory col:columnGroup.startColumn];
	FLXSFlexDataGridColumnGroupCell* columnGroupCell = (FLXSFlexDataGridColumnGroupCell* )(existingComponent?existingComponent.component
            : [self.grid.rendererCache popInstance:rendererFactory subFactory:cgRenderer]);
	columnGroupCell.rendererFactory=cgRenderer;
	columnGroupCell.rowInfo =row;
	columnGroupCell.level = level;
	columnGroupCell.columnGroup=columnGroup;
    columnGroupCell.wordWrap = columnGroup.headerWordWrap;
    
    
    if([columnGroupCell.renderer respondsToSelector:NSSelectorFromString(@"textAlignment")]){
        NSTextAlignment al= columnGroup.headerAlign?columnGroup.headerAlign: NSTextAlignmentLeft;
        [columnGroupCell.renderer setValue:[NSNumber numberWithInt:al] forKey:@"textAlignment"];
        
    }
    
    
    if(existingComponent)
		[self addCell:columnGroupCell row:row existingComponent:existingComponent];
		else
		existingComponent=[self addEventListeners:([self addCell:columnGroupCell row:row existingComponent:existingComponent].componentInfo)];

    [(UIView <FLXSIFlexDataGridCell> *) columnGroupCell setActualSizeWithWidth:([[[columnGroup getWX] objectAtIndex:0] floatValue]) andHeight:rowHeight];
	if(columnGroup.parentGroup!=nil)
	{
		columnGroupCell.y=columnGroup.parentGroup.yPlusHeight;
		existingComponent.useComponentPosition=YES;
	}
//	if([level getStyleValue:(@"columnGroupStyleName")])
//	{
//		columnGroupCell.styleName=[level getStyleValue:(@"columnGroupStyleName")];
//	}
    if([level getStyleValue:(@"columnGroupStyleName")] && [columnGroupCell.renderer isKindOfClass:[UILabel class] ])
    {
        [((FLXSFontInfo *)[level getStyleValue:(@"columnGroupStyleName")]) applyFont:(UILabel *)columnGroupCell.renderer];
    }

    return columnGroupCell;
}

- (void)processHeaderCell:(FLXSFlexDataGridColumnLevel *)level columns:(NSArray *)cols colIndex:(int)colIndex row:(FLXSRowInfo *)row item:(NSObject *)item rowHeight:(float)rowHeight existingComponents:(NSArray *)existingComponents {
//	float paddingY=[level getStyleValue:(@"horizontalGridLines")]?1:0;
	FLXSFlexDataGridColumn* col = cols[colIndex];
	FLXSClassFactory* rendererFactory=[col deriveRenderer:[FLXSRowPositionInfo ROW_TYPE_HEADER]];
	FLXSComponentInfo* existingComponent = [self getExistingCell:existingComponents rendererFactory:rendererFactory col:col];
	FLXSFlexDataGridHeaderCell* headerLabel =(FLXSFlexDataGridHeaderCell*)(existingComponent?existingComponent.component:
            [self.grid.rendererCache popInstance:col.headerCellRenderer subFactory:rendererFactory]);
	BOOL useComponentPosition=NO;
	headerLabel.rendererFactory=rendererFactory;
	headerLabel.rowInfo =row;
	headerLabel.level = level;
	headerLabel.columnFLXS = col;
	headerLabel.text=col.headerText;
//    UILabel * lbl = headerLabel.renderer;

    if([headerLabel.renderer respondsToSelector:NSSelectorFromString(@"textAlignment")]){
        NSTextAlignment al= col.headerAlign?col.headerAlign:[[col getStyleValue:(@"textAlign")] intValue];
        [headerLabel.renderer setValue:[NSNumber numberWithInt:al] forKey:@"textAlignment"];

    }

    headerLabel.wordWrap = col.headerWordWrap;
	if([level getMaxColumnGroupDepth]>1)
	{
		useComponentPosition=YES;
		if(col.columnGroup==nil)
		{
			//we need to be as tall as the entire header.
            [(UIView <FLXSIFlexDataGridCell> *) headerLabel setActualSizeWithWidth:col.width andHeight:self.grid.headerContainer.height];
			headerLabel.y=0;
		}
		else
		{
            [(UIView <FLXSIFlexDataGridCell> *) headerLabel setActualSizeWithWidth:col.width andHeight:rowHeight];
			headerLabel.y=col.columnGroup.yPlusHeight;
		}
	}
	else
        [(UIView <FLXSIFlexDataGridCell> *) headerLabel setActualSizeWithWidth:col.width andHeight:(level.nestDepth == 1 ? self.grid.headerContainer.height : rowHeight)];
	if( level.nestDepth==1)
	{
		if(headerLabel.y+headerLabel.height<self.grid.headerContainer.height)
		{
			headerLabel.height=self.grid.headerContainer.height-headerLabel.y;
		}
		else if(headerLabel.y+headerLabel.height>self.grid.headerContainer.height)
		{
			headerLabel.height=self.grid.headerContainer.height-headerLabel.y;
		}
	}
	if(existingComponent)
		existingComponent= [self addCell:headerLabel row:row existingComponent:existingComponent].componentInfo;
	else
        existingComponent=[self addEventListeners:([self addCell:headerLabel row:row existingComponent:existingComponent].componentInfo)];
//	if([col getStyleValue:(@"headerStyleName")])
//	{
//		headerLabel.styleName=[col getStyleValue:(@"headerStyleName")];
//	}
    if([col getStyleValue:(@"headerStyleName")] && [headerLabel.renderer isKindOfClass:[UILabel class] ])
    {
        [((FLXSFontInfo *)[col getStyleValue:(@"headerStyleName")]) applyFont:(UILabel *)headerLabel.renderer];
    }

    if([level getMaxColumnGroupDepth]>1)
	{
		useComponentPosition=YES;
		if(col.columnGroup==nil)
		{
			headerLabel.y=0;
		}
		else
		{
			headerLabel.y=col.columnGroup.yPlusHeight;
		}
	}
	existingComponent.useComponentPosition=useComponentPosition;
	if([level.currentSorts count] ==0 && level.initialSortField&& ([level.initialSortField isEqual:col.dataFieldFLXS]))
	{
		headerLabel.sortAscending = level.initialSortAscending;
		[self sortByCell:headerLabel];
	}
	//if(item!=nil)
	{
		[headerLabel refreshCell];
        
	}

}

- (FLXSComponentInfo *)getExistingCell:(NSMutableArray *)existingComponents rendererFactory:(FLXSClassFactory *)rendererFactory col:(FLXSFlexDataGridColumn *)col {

	for(FLXSComponentInfo* comp in existingComponents)
	{
        if([comp.component.renderer isKindOfClass:rendererFactory.generator]){
			[existingComponents removeObjectAtIndex:([existingComponents indexOfObject:comp])];
			comp.x=col.x;
			comp.component.x = col.x;
			return comp;
		}
	}
    return nil;
}

-(void)onFilterChange:(NSNotification*)ns
{
    FLXSFilterPageSortChangeEvent* event =(FLXSFilterPageSortChangeEvent*) [ns.userInfo objectForKey:@"event"];
    FLXSRowInfo* rowInfo;
	if(event.triggerEvent)
	{
		UIView<FLXSIFilterControl>* trigger = (UIView<FLXSIFilterControl>* )event.triggerEvent.target;
		UIView<FLXSIFlexDataGridCell>* treeCell = (UIView<FLXSIFlexDataGridCell>*)trigger.superview;
		rowInfo=treeCell.rowInfo;
	}
	FLXSFilter* filter = event.filter;
	filter.pageIndex=0;
	FLXSFlexDataGridColumnLevel* level=rowInfo?[rowInfo.rowPositionInfo getLevel:self.grid]:self.grid.columnLevel;
	filter.pageSize=level.pageSize;
    NSObject *key = level.nestDepth == 1? @"ROOT_FILTER":rowInfo.data;
    if(key!=nil){
        [self.grid.itemFilters setObject:[FLXSAdvancedFilter from:filter] forKey:(id<NSCopying>)key];        
    }
    FLXSExtendedFilterPageSortChangeEvent* nested =
            [[FLXSExtendedFilterPageSortChangeEvent alloc] initWithType:[FLXSExtendedFilterPageSortChangeEvent FILTER_PAGE_SORT_CHANGE] andFilter:([self createFilter:level parentObject:(level.nestDepth == 1 ? nil : rowInfo.data)]) andBubbles:NO andCancelable:NO ];
	nested.filter.pageIndex=filter.pageIndex;
	nested.filter.sorts=level.currentSorts;
	nested.triggerEvent=event;
	nested.cause = [FLXSExtendedFilterPageSortChangeEvent FILTER_CHANGE];
	if(level.nestDepth!=1)//the grid takes care of self scenario
		[level dispatchEvent:nested];
}

-(void)onPageChange:(NSNotification*)ns
{
	[self dispatchPageChange:[ns.userInfo objectForKey:@"event"]];
}

-(void)rootPageChange:(NSNotification*)ns
{
	[self dispatchPageChange:[ns.userInfo objectForKey:@"event"]];
}

-(void)dispatchPageChange:(FLXSEvent*)event
{
	UIView<FLXSIExtendedPager>* iPager = (UIView<FLXSIExtendedPager>* )event.target;
	if(iPager && !iPager.level.isClientFilterPageSortMode && iPager.level.nestDepth>1)
	{
		FLXSItemLoadInfo* loadInfo = [self findLoadingInfo:iPager.rowInfo.data level:iPager.level.parentLevel useSelectedKeyField:(iPager.level.childrenField.length > 0)];
		if(loadInfo)
		{
			loadInfo.totalRecords= iPager.totalRecords;
			loadInfo.pageIndex = iPager.pageIndex;
		}
	}
	FLXSFilter* filter = [self.grid.itemFilters objectForKey: iPager.level.nestDepth==1?@"ROOT_FILTER":iPager.rowInfo.data];
	if(filter)
		filter.pageIndex= iPager.pageIndex;
	FLXSExtendedFilterPageSortChangeEvent* nested =
            [[FLXSExtendedFilterPageSortChangeEvent alloc] initWithType:[FLXSExtendedFilterPageSortChangeEvent FILTER_PAGE_SORT_CHANGE] andFilter:([self createFilter:iPager.level parentObject:(iPager.level.nestDepth == 1 ? nil : iPager.rowInfo.data)]) andBubbles:NO andCancelable:NO ];
	nested.filter.pageIndex=iPager.pageIndex;
	nested.triggerEvent=event;
	nested.cause = [FLXSExtendedFilterPageSortChangeEvent PAGE_CHANGE];
	[iPager.level dispatchEvent:nested];
}

- (FLXSAdvancedFilter *)createFilter:(FLXSFlexDataGridColumnLevel *)level parentObject:(NSObject *)parentObject {
    return [level createFilter:parentObject inFilter:([self.grid.itemFilters objectForKey:(parentObject == nil? @"ROOT_FILTER" : parentObject)])];
}
-(void)onHeaderCellPanRecognizer:(id)sender {

    UIPanGestureRecognizer* recognizer = (UIPanGestureRecognizer*)sender;
    CGPoint location = [recognizer locationInView:recognizer.view];
    FLXSTouchEvent * flxsTouchEvent = [[FLXSTouchEvent alloc] init];
    flxsTouchEvent.localX = location.x;
    flxsTouchEvent.localY = location.y;
    flxsTouchEvent.target = recognizer.view;
    if ([recognizer state] == UIGestureRecognizerStateBegan) {
        //flxsTouchEvent.type = [FLXSTouchEvent TOUCH_DOWN];
        //[self onHeaderCellMouseDown:flxsTouchEvent];
    }
    else if ([recognizer state] == UIGestureRecognizerStateChanged) {
        flxsTouchEvent.type = [FLXSTouchEvent TOUCH_MOVE];
        [self onHeaderCellMouseMove:flxsTouchEvent];
        if(self.columnResizingCell){
            [self columnResizingHandler:flxsTouchEvent];
        }else if(self.columnDraggingDragCell){
            UIView* parent =   self.columnDraggingDragCell.superview;
            CGPoint locationInHeader = [recognizer locationInView:parent];
            UIView *hitView = [parent hitTest:locationInHeader withEvent:nil];
            flxsTouchEvent.target=hitView;
            [self calculateColumnDraggingDropTargetCell:flxsTouchEvent];
            flxsTouchEvent.target= recognizer.view;
            [self columnDraggingMouseMoveHandler:flxsTouchEvent];
        }
    }
    else if ([recognizer state] == UIGestureRecognizerStateEnded) {
        flxsTouchEvent.type = [FLXSTouchEvent TOUCH_UP];
        if(self.columnResizingCell){
            [self columnResizeMouseUpHandler:flxsTouchEvent];
        }else if(self.columnDraggingDragCell){
            [self columnDraggingMouseUpHandler:flxsTouchEvent];
        }
        [self onHeaderCellMouseOut:flxsTouchEvent];
    }
}
-(void)killResize
{
	if(self.resizeCursorID !=-1 )
	{
		self.resizeCursorID=-1;
        [self.grid removeEventListenerOfType:[FLXSTouchEvent TOUCH_MOVE] fromTarget:self usingHandler:@selector(onMouseMove:)];

    }
}

-(void)onHeaderCellMouseMove:(FLXSTouchEvent*)event
{
	if(self.columnDraggingDragCell /*&& event.buttonDown in IOS, button is always down*/)
	{
		[self calculateColumnDraggingDropTargetCell:event];
		return;
	}
	if(self.columnResizingCell ||self.columnResizingGlyph || !(([event.target isKindOfClass:[FLXSFlexDataGridHeaderCell class]]) || ([event.target isKindOfClass:[UITextView class]])  ))
	{
		[self killResize];
		return;
		//we're resizing or we are over something lese
	}
	FLXSFlexDataGridHeaderCell* cell = [event.target isKindOfClass:[FLXSFlexDataGridHeaderCell class]]?(FLXSFlexDataGridHeaderCell*)event.target:nil;
	//CGPoint ptx = CGPointMake(event.localX, event.localY);//[[Point alloc] init:event.localX :event.localY];
	if(!cell)return;
	if(![event.target isEqual: cell] && ([event.target isKindOfClass:[UIView class]]))
	{
	//	ptx=[cell globalToLocal:([((UIView *)event.target) localToGlobal:ptx])];
	}
//	BOOL onRightEdge=((cell.width-ptx.x)<=self.grid.columnLevel.headerSeparatorWidth );
//	BOOL onLeftEdge=(ptx.x<=self.grid.columnLevel.headerSeparatorWidth);
//	UIView<FLXSIFlexDataGridCell>* prevCel;
//	if(onLeftEdge|| onRightEdge)
//	{
//		if(!self.resizeCursorID==-1)
//		{
//			//if we're over a cell edge on the left side, we're resizing the column before it.
//			if(onLeftEdge)
//			{
//				prevCel = [self getCellInDirection:cell :[FLXSFlexDataGrid CELL_POSITION_LEFT] :NO :NO:YES:NO];
//				if(!prevCel || !prevCel.column || !prevCel.column.resizable)
//				{
//					return;
//				}
//			}
//			else if(onRightEdge)
//			{
//				if(!cell.column.resizable ||(cell.column.isLastUnLocked)
//					||cell.column.isLastRightLocked)
//				{
//					return;
//				}
//			}
////			Class* stretchCursorClass = [self.grid getStyle:(@"stretchCursor")];
////			resizeCursorID = [cursorManager setCursor:stretchCursorClass :[CursorManagerPriority HIGH] :0 :0];
//			[self.grid addEventListener:[FLXSTouchEvent TOUCH_MOVE]  :self :@selector(onMouseMove:)];
//            self.resizeCursorID=1;
//		}
//	}
//	else
//	{
//		[self killResize];
//	}
}

-(void)onMouseMove:(FLXSTouchEvent*)event
 {
     CGPoint pt = CGPointMake(0, 0);
     pt=[self.grid localToGlobal:pt];
     pt = [self.grid.headerContainer globalToLocal:pt];
     if(!self.columnResizingCell && ( pt.y>self.grid.headerContainer.height ||  pt.y<self.grid.headerContainer.height)  )
	{
		[self killResize];
	}
}

-(void)onHeaderCellMouseOut:(FLXSEvent*)event
{
}

-(void)columnDraggingMouseMoveHandler:(FLXSEvent*)event
{
	if ( !self.columnDraggingDragCell)
	{
		[self columnDraggingMouseUpHandler:event];
		return;
	}
     CGPoint pt = CGPointMake(0,0);
    if(!self.columnResizingGlyph)
	{
        self.columnDraggingDragCell.moving=YES;
        self.columnDraggingDropTargetCell=nil;
        FLXSFlexDataGridHeaderSeparator* sep = [[FLXSFlexDataGridHeaderSeparator alloc] init];
        self.columnResizingGlyph=sep;
        //self.columnResizingGlyph.mouseEnabled = NO;
		pt=[self.grid globalToLocal:([self.columnDraggingDragCell localToGlobal:pt])];
        [FLXSUIUtils addChild:self.grid child:(((UIView *) (self.columnResizingGlyph)))];
        [self.columnResizingGlyph.superview bringSubviewToFront:self.columnResizingGlyph];
        CGPoint pt1=CGPointMake(0,0);
		pt1=[self.columnDraggingDragCell localToGlobal:pt1];
        pt1=[self.grid globalToLocal:pt1];
		//var activeCellColor:*=[self.grid getStyle:(@"activeCellColor")];
		float movingcellht=self.columnDraggingDragCell.height;
        //self.columnDraggingDragCell.currentBackgroundColors= [[NSArray alloc] initWithObjects:self.grid.activeCellColor,self.grid.activeCellColor,nil];
        self.columnDraggingDragCell.height=self.grid.height-pt1.y;
		[self.columnDraggingDragCell invalidateDisplayList];
		[self.columnDraggingDragCell validateNow];
        self.columnDraggingGlyph = [[UIView alloc] initWithFrame:self.columnDraggingDragCell.frame];
        self.columnDraggingGlyph.backgroundColor =  self.grid.borderColor;
		/*columnDraggingGlyph.alpha=[self.grid getStyle:(@"columnMoveAlpha")];
		*/
        [FLXSUIUtils addChild:self.grid child:self.columnDraggingGlyph];
        self.columnDraggingDragCell.height=movingcellht;
        [self.columnResizingGlyph moveToX:pt.x y:pt1.y];
        [self.columnDraggingGlyph moveToX:pt.x y:pt1.y];
		[self.columnDraggingGlyph validateNow];

        [self.columnDraggingGlyph setActualSizeWithWidth:2 andHeight:(self.grid.height - pt1.y - self.grid.isHScrollBarVisible)];

		//[self.columnDraggingGlyph.graphics lineStyle:1 :([self.grid getStyle:(@"columnMoveResizeSeparatorColor")]||0x000000)]
        //[columnDraggingGlyph.graphics drawRect:0 :0 :columnDraggingGlyph.width :columnDraggingGlyph.height];

         self.startX=self.columnResizingGlyph.x;
	}
}

-(void)columnDraggingMouseUpHandler:(FLXSEvent*)event
{

	if (!self.columnDraggingDragCell)
		return;
	if(self.columnResizingGlyph && self.columnResizingGlyph.superview!=nil)
	{
		[FLXSUIUtils removeChild:self.grid child:(((UIView *) (self.columnResizingGlyph)))];
	}
	if(self.columnDraggingGlyph && self.columnDraggingGlyph.superview!=nil)
	{
		[FLXSUIUtils removeChild:self.grid child:(((UIView *) (self.columnDraggingGlyph)))];
	}
	if(self.columnDraggingDropTargetCell && (![self.columnDraggingDropTargetCell isEqual:self.columnDraggingDragCell]) && ([self.columnDraggingDropTargetCell isKindOfClass:[FLXSFlexDataGridHeaderCell class]]))
	{
        [self.grid shiftColumns:self.columnDraggingDragCell.columnFLXS insertBefore:self.columnDraggingDropTargetCell.columnFLXS level:self.columnDraggingDropTargetCell.level movingCg:NO ];
		if(self.columnDraggingToRight)
		{
            [self.grid shiftColumns:self.columnDraggingDropTargetCell.columnFLXS insertBefore:self.columnDraggingDragCell.columnFLXS level:self.columnDraggingDropTargetCell.level movingCg:NO ];
		}
	}
	else if(self.columnDraggingDropTargetCell && (self.columnDraggingDropTargetCell!=self.columnDraggingDragCell)
&& ([self.columnDraggingDropTargetCell isKindOfClass:[FLXSFlexDataGridColumnGroupCell class]])
&& ([self.columnDraggingDragCell isKindOfClass:[FLXSFlexDataGridColumnGroupCell class]]))
	{
		FLXSFlexDataGridColumnGroupCell* movingCGCell= ([self.columnDraggingDragCell isKindOfClass:[FLXSFlexDataGridColumnGroupCell class]])?(FLXSFlexDataGridColumnGroupCell*)self.columnDraggingDragCell:nil;
		FLXSFlexDataGridColumn* col ;
		if(self.columnDraggingToRight)
		{
			for(col in [self.columnDraggingDropTargetCell.columnFLXS.columnGroup getAllColumns])
			{
                [self.grid shiftColumns:col insertBefore:movingCGCell.columnFLXS level:self.columnDraggingDropTargetCell.level movingCg:YES ];
			}
		}
		else
		{
			for(col in [movingCGCell.columnGroup getAllColumns])
			{
                [self.grid shiftColumns:col insertBefore:self.columnDraggingDropTargetCell.columnFLXS level:self.columnDraggingDropTargetCell.level movingCg:YES ];
			}
		}
	}
    self.columnDraggingDragCell.moving=NO;
    self.columnDraggingDragCell=nil;
    self.columnResizingGlyph = nil;
    self.columnDraggingDropTargetCell=nil;
}

-(void)onHeaderCellMouseDown:(NSNotification*)ns
{
    FLXSTouchEvent* event = (FLXSTouchEvent*) [ns.userInfo objectForKey:@"event"];
    FLXSFlexDataGridCell* cell = [event.target isKindOfClass:[FLXSFlexDataGridCell class]]?(FLXSFlexDataGridCell*)event.target:nil;
	FLXSFlexDataGridHeaderCell* headerCell = [event.target isKindOfClass:[FLXSFlexDataGridHeaderCell class]]?(FLXSFlexDataGridHeaderCell*)event.target:nil;
	float eventLocalX = event.localX;//[cell globalToLocal:([[Point alloc] init:event.stageX :event.stageY])].x;
	BOOL onRightEdge=((cell.width-4-eventLocalX)<=self.grid.columnLevel.headerSeparatorWidth );
	BOOL onLeftEdge=(eventLocalX<=self.grid.columnLevel.headerSeparatorWidth);
	if(!onRightEdge&&!onLeftEdge)
	{
		if(self.columnDraggingDragCell||self.columnResizingCell/*||cell.isLocked*/)return;
		if(!cell.columnFLXS.draggable)return;

        self.columnDraggingDragCell= [event.target isKindOfClass:[FLXSFlexDataGridCell class]]?(FLXSFlexDataGridCell*)event.target:nil;
	}
	else if(headerCell)
	{
		if(self.columnDraggingDragCell||self.columnResizingCell)return;
		if(!cell.columnFLXS.resizable)return;
		headerCell.resizing=YES;
		headerCell.resizingPrevious=onLeftEdge;
        self.columnResizingCell=headerCell;
		if(!onRightEdge)
		{
            UIView<FLXSIFlexDataGridCell>* oCell = [self getCellInDirection:self.columnResizingCell direction:[FLXSFlexDataGrid CELL_POSITION_LEFT] dataOnly:NO editableOnly:NO scrollIfNecessary:YES hoverableOnly:NO ];
            self.columnResizingCell= [oCell isKindOfClass:[FLXSFlexDataGridHeaderCell class] ]?(FLXSFlexDataGridHeaderCell*)oCell:nil;
		}
//		[sbRoot addEventListener:[MouseEvent MOUSE_MOVE] :columnResizingHandler :YES :0 :YES];
//		[sbRoot addEventListener:[MouseEvent MOUSE_UP] :columnResizeMouseUpHandler :YES :0 :YES];
//		[sbRoot addEventListener:[SandboxMouseEvent MOUSE_UP_SOMEWHERE] :columnResizeMouseUpHandler :NO :0 :YES];
//		[systemManager deployMouseShields:YES];
        FLXSFlexDataGridHeaderSeparator* sep= [[FLXSFlexDataGridHeaderSeparator alloc] init];
        self.columnResizingGlyph = sep;
        //self.columnResizingGlyph.mouseEnabled = NO;
		CGPoint pt = CGPointMake(onLeftEdge?0:cell.width, 0);
		pt=[self.grid globalToLocal:([cell localToGlobal:pt])] ;
        [FLXSUIUtils addChild:self.grid child:(((UIView *) (self.columnResizingGlyph)))];

        self.columnResizingGlyph.backgroundColor =  self.grid.borderColor;
        [self.columnResizingGlyph.superview bringSubviewToFront:self.columnResizingGlyph];
        [self.columnResizingGlyph moveToX:pt.x y:0];
        [self.columnResizingGlyph setActualSizeWithWidth:2 andHeight:(self.grid.height - self.grid.isHScrollBarVisible)];
        self.startX=self.columnResizingGlyph.x;
	}
}

-(void)columnResizingHandler:(FLXSTouchEvent*)event
{
	if (!self.columnResizingCell)
	{
		[self columnResizeMouseUpHandler:event];
		return;
	}
    UIView* view = (UIView*)event.target;
    CGPoint pt = [view localToGlobal:CGPointMake(event.localX, event.localY)];
    pt = [self.grid globalToLocal:pt];
	/*Point* colPt = [[Point alloc] initWithType:(resizingCell.x-horizontalScrollPosition) :0];
	colPt = [self.grid globalToLocal:([self localToGlobal:colPt])];
	[resizeGraphic move:([Math min:([Math max:(colPt.x+20) :pt.x]) :((self.grid.width-20-self.grid.rightLockedContent.width))]) :0];
	*/
    float minWidth=self.columnResizingCell.columnFLXS ?self.columnResizingCell.columnFLXS.minWidth+1:20;
	float min= self.startX-self.columnResizingCell.width+minWidth;
	float max= self.grid.width-minWidth;
    [self.columnResizingGlyph moveToX:MIN(MAX(min, pt.x), max) y:0];
}

-(UIView<FLXSIFlexDataGridCell>*)getCurrentEditCell
{
    return self.editCell;
}


-(UIView<FLXSIFlexDataGridDataCell>*)editCell
{
	return self.grid.editCell;
}

-(void)setEditCell:(UIView<FLXSIFlexDataGridDataCell>*)val
{
    self.grid.editCell=val;
}

-(UIView*)editor
{
	return self.grid.editor;
}

-(void)setEditor:(UIView*)val
{
	self.grid.editor=val;
}

-(void)columnResizeMouseUpHandler:(FLXSEvent*)event
{
	if(!self.columnResizingCell)return;
	float change = self.columnResizingGlyph.x-self.startX;
	FLXSFlexDataGridColumn* colResizing = self.columnResizingCell.columnFLXS;
	if(self.columnResizingCell.resizingPrevious)
	{
		UIView<FLXSIFlexDataGridCell>* prevCel = [self getCellInDirection:self.columnResizingCell direction:[FLXSFlexDataGrid CELL_POSITION_LEFT] dataOnly:NO editableOnly:NO scrollIfNecessary:YES hoverableOnly:NO ];
		if(!prevCel || !prevCel.columnFLXS || !prevCel.columnFLXS.resizable)
		{
			return;
		}
		else
		{
			colResizing=prevCel.columnFLXS;
		}
	}
	if(self.grid.enableColumnWidthUserOverride)
	{
		colResizing.columnWidthMode=[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_FIXED];
		//so we do not recalculate widths in the future
	}
	if((!colResizing.isLocked) && (self.grid.forceColumnsToFitVisibleArea || (colResizing.level.nestDepth!=1)))
	{
		NSArray* filter=colResizing.isLeftLocked?[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_LEFT],nil]:
                colResizing.isRightLocked?[[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_RIGHT],nil]:
                        [[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE],nil];
		NSArray* cols=[colResizing.level getVisibleColumns:filter];
		NSMutableArray* colsAffected= [[NSMutableArray alloc] init] ;
		float elasticCount=0;
		BOOL colHit=NO;
		for(FLXSFlexDataGridColumn* col in cols)
		{
			if(colHit)
			{
				if(col.isElastic)
				{
					elasticCount++;
					[colsAffected addObject:col];
				}
			}
			if(!colHit)
			{
				colHit=(col==colResizing);
			}
		}
		float share = change/elasticCount;
		float removed=0;
		for(FLXSFlexDataGridColumn*  col in colsAffected)
		{
			if((col!=colResizing) && col.isElastic)
			{
				float toRemove = share;
				if(col.width-share < col.minWidth )
				{
					toRemove = col.width - col.minWidth;
				}
				col.width-=toRemove;
				removed += toRemove;
				if(self.grid.enableColumnWidthUserOverride)
				{
					col.columnWidthMode=[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_FIXED];
					//so we do not recalculate widths in the future
				}
			}
		}
		colResizing.width+=removed;
	}
	else
	{
		colResizing.width+=change;
		[self.grid.columnLevel adjustColumnWidths:-1 equally:NO ];
	}
	if(self.grid.variableRowHeight)
	{
		[self.grid rebuildBody :NO];
	}
	if(colResizing.isLocked)
	{
		[self.grid reDraw];
	}
	/*if(self.grid.columnLevel.nextLevel)
			[self.grid.columnLevel.nextLevel adjustColumnWidths];
	*/


	[FLXSUIUtils removeChild:self.grid child:(((UIView *) (self.columnResizingGlyph)))];
    self.columnResizingCell.resizing=NO;
    self.columnResizingCell=nil;
    self.columnResizingGlyph = nil;
    self.resizeCursorID=-1;
    FLXSEvent* evt= [[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent COLUMNS_RESIZED] andGrid:colResizing.level.grid andLevel:colResizing.level andColumn:colResizing andCell:nil andItem:nil andTriggerEvent:event andBubbles:NO andCancelable:NO ];
	[self dispatchEvent:evt];
	[colResizing.level dispatchEvent:evt];
	[self.grid invalidateCells];
    [self.grid dispatchEvent:[[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent COLUMN_STRETCH] andGrid:colResizing.level.grid andLevel:colResizing.level andColumn:colResizing andCell:nil andItem:nil andTriggerEvent:event andBubbles:NO andCancelable:NO ]];
}

-(void)snapToColumnWidths
{
	self.cellsWithColSpanOrRowSpan= [[NSMutableArray alloc] init];
	for(FLXSRowInfo* row in [self getRowsForSnapping])
	{
		if(row.isRendererRow || row.isPagerRow)
		{
			for(FLXSComponentInfo* cell in row.cells)
			{
				if([cell.component isKindOfClass:[FLXSFlexDataGridPagerCell class]]
                        || [cell.component isKindOfClass:[FLXSFlexDataGridLevelRendererCell class]])
				{
					cell.component.width=[[row.rowPositionInfo getLevel:self.grid] getSumOfColumnWidths:
                            [[NSArray alloc] initWithObjects:[FLXSFlexDataGridColumn LOCK_MODE_NONE],nil]];
				}
			}
		}
		else if(row.isColumnGroupRow)
		{
			for(FLXSComponentInfo* cgCellComp in row.cells)
			{
				FLXSFlexDataGridColumnGroupCell* cgCell = (FLXSFlexDataGridColumnGroupCell* )cgCellComp.component;
				if(cgCell)
				{
					[cgCell onColumnsResized:nil];
				}
			}
		}
		else
            [self snapRowToColumnWidth:row];
	}
	[self hideSpannedCells];
    self.cellsWithColSpanOrRowSpan= [[NSMutableArray alloc] init];
}

-(int)getColSpan:(UIView<FLXSIFlexDataGridCell>*)cell
{
	if(self.grid.colSpanFunction==nil)return 1;
	int colSp=1;

	UIView<FLXSIFlexDataGridDataCell>* fdgDCell=
        [cell conformsToProtocol:@protocol(FLXSIFlexDataGridDataCell)]?
        (UIView<FLXSIFlexDataGridDataCell>*)cell:nil;
	if(self.grid.colSpanFunction!=nil)
	{
		//colSp=[.grid colSpanFunction:cell];
        SEL selector = NSSelectorFromString(self.grid.colSpanFunction);
        id target = self.grid.delegate;
        colSp=[((NSNumber*(*)(id, SEL, UIView<FLXSIFlexDataGridCell>*))objc_msgSend)(target, selector, cell) intValue];

	}
	if(fdgDCell)
		fdgDCell.colSpan=colSp;
	return colSp;
}

-(int)getRowSpan:(UIView<FLXSIFlexDataGridCell>*)cell
{
	if(self.grid.rowSpanFunction==nil)return 1;
	int rowSp=1;
	UIView<FLXSIFlexDataGridDataCell>* fdgDCell= [cell conformsToProtocol:@protocol(FLXSIFlexDataGridDataCell)]?(UIView<FLXSIFlexDataGridDataCell>* )cell:nil;
	if(self.grid.rowSpanFunction!=nil)
	{
		//rowSp=[self.grid rowSpanFunction:cell];

        SEL selector = NSSelectorFromString(self.grid.rowSpanFunction);
        id target = self.grid.delegate;
        rowSp=[((NSNumber*(*)(id, SEL, UIView<FLXSIFlexDataGridCell>*))objc_msgSend)(target, selector, cell) intValue];
		if(rowSp>1)
			cell.rowInfo.rowPositionInfo.rowSpan=MAX(rowSp ,cell.rowInfo.rowPositionInfo.rowSpan);
	}
	if(fdgDCell)
		fdgDCell.rowSpan=rowSp;
	return rowSp;
}

-(float)getCellWidth:(UIView<FLXSIFlexDataGridCell>*)cell
{
	if(self.grid.colSpanFunction==nil
		|| ([cell isKindOfClass:[FLXSFlexDataGridHeaderCell class]])
		|| ([cell isKindOfClass:[FLXSFlexDataGridColumnGroupCell class]]))return cell.columnFLXS ?cell.columnFLXS.width:cell.width;
	int colSpan=[self getColSpan:cell];
    if(cell.hidden)return 0;
	if(colSpan==1)
	{
		return cell.columnFLXS ?cell.columnFLXS.width:cell.width;
	}
	[self.cellsWithColSpanOrRowSpan addObject:cell];

	NSArray* cols=[cell.level getColumns:[[NSArray alloc] initWithObjects:cell.columnFLXS.columnLockMode,nil]];
	if(colSpan==0)
	{
		//self means we need to span all columns to the right.
		if(!cell.isLocked)
		{
			return self.grid.bodyContainer.width+self.
                    grid.bodyContainer.maxHorizontalScrollPosition-cell.columnFLXS.x-self.grid.isVScrollBarVisible;
		}
		else if(cell.isLeftLocked)
		{
			return self.grid.leftLockedContent.width-cell.columnFLXS.x;
		}
		else
		{
			//right locked
			return self.grid.rightLockedContent.width-cell.columnFLXS.x;
		}
	}
	else
	{
		//self means we need to span the specified number of columns
		float w=cell.columnFLXS ?cell.columnFLXS.width:cell.width;
		float meIdx= [cols indexOfObject:cell.columnFLXS];
		for (float idx=meIdx+1;idx<MIN([cols count],(meIdx+colSpan));idx++)
		{
			FLXSFlexDataGridColumn* nextCol= [cols objectAtIndex:idx];
			w+=nextCol.width;
		}
		return w;
	}
}

-(float)getCellHeight:(UIView<FLXSIFlexDataGridCell>*)cell
{
	if(self.grid.rowSpanFunction==nil
		|| !(cell.rowInfo.isDataRow))return cell.height;
	FLXSRowInfo* row=cell.rowInfo;
	int rowSpan=[self getRowSpan:cell];
    if(cell.hidden)return 0;
	if(rowSpan==1)
	{
		return row.height;
	}
	if(rowSpan==0)
	{
		rowSpan= (int)[self.rows count];
	}
	[self.cellsWithColSpanOrRowSpan addObject:cell];
	//self means we need to span all rows to the bottom.
	float meIdx=[self.itemVerticalPositions indexOfObject:row.rowPositionInfo];
	float ht=row.height;
	for (float idx=meIdx+1;idx<MIN([self.itemVerticalPositions count] ,(meIdx+rowSpan));idx++)
	{
		FLXSRowPositionInfo* nextRow= [self.itemVerticalPositions objectAtIndex:idx];
		ht+=nextRow.rowHeight;
	}
	return ht;
}

-(void)hideSpannedCells
{
	for(UIView* largerCell in self.cellsWithColSpanOrRowSpan)
	{
        [largerCell.superview bringSubviewToFront:largerCell];
	}
}

-(NSArray*)getRowsForSnapping
{
	return [self getAllRows];
}

-(NSMutableArray*)getAllRows
{
    return self.rows;
}
-(void)snapRowToColumnWidth:(FLXSRowInfo*)row
{
//	float xSoFar=0;
	FLXSInsertionLocationInfo* loc=[[FLXSInsertionLocationInfo alloc] init];
	if(!self.grid.forceColumnsToFitVisibleArea)
	{
		/*row.cells.sort = [[Sort alloc] init];
		row.cells.sort.fields = [[[SortField alloc] initWithType:(@"colIndex")]];
		*/
        row.cells  = [[row.cells sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSNumber *first = [NSNumber numberWithInt:((FLXSComponentInfo *) a).colIndex];
            NSNumber *second = [NSNumber numberWithInt:((FLXSComponentInfo *) b).colIndex];
            return [first compare:second];
        }] mutableCopy];

	}
	/*FLXSFlexDataGridColumnLevel* lvl=[row.rowPositionInfo getLevel:self.grid];
	*/
for(FLXSComponentInfo* cell in row.cells)
	{
		if(cell.component)
		{
			UIView<FLXSIFlexDataGridCell>* tdgc= cell.component;
			FLXSFlexDataGridColumn* column=tdgc.columnFLXS;
			if(loc.contentX==0 && column && !column.isLocked)
				loc.contentX=column.x;
			float toSet=[self getCellWidth:tdgc];//column?column.width:cell.component.width;
			float origWidth=column?column.width:cell.component.width;
			if(!tdgc.isLocked)
			{
				/*if(tdgc.column&&tdgc.column.isLastUnLocked)
				{
					toSet=width-loc.contentX;
				}
				*/
cell.x=loc.contentX;
				loc.contentX+=origWidth;
			}
			else if(tdgc.isLeftLocked)
			{
				if((tdgc.columnFLXS &&tdgc.columnFLXS.isLastLeftLocked))
				{
					toSet=self.grid.leftLockedContent.width-loc.leftLockedContentX;
				}
				cell.x=loc.leftLockedContentX;
				loc.leftLockedContentX+=origWidth;
			}
			else if(tdgc.isRightLocked)
			{
				if(tdgc.columnFLXS &&tdgc.columnFLXS.isLastRightLocked)
				{
					toSet=self.grid.rightLockedContent.width-loc.rightLockedContentX;
				}
				cell.x=loc.rightLockedContentX;
				loc.rightLockedContentX+=origWidth;
			}
			//if(tdgc.visible)
            [tdgc setActualSizeWithWidth:toSet andHeight:([self getCellHeight:tdgc])];
		}
	}
	[self.grid placeComponents:row];
}

-(void)placeSortIcon:(NSNotification*)ns
{
    FLXSEvent *event = (FLXSEvent *)[ns.userInfo objectForKey:@"event"];
    FLXSFlexDataGridHeaderCell* headerCell = (FLXSFlexDataGridHeaderCell* )event.target;
	if([headerCell.level hasSort:headerCell.columnFLXS])
	{
		[headerCell placeSortIcon];
	}
}

-(void)selectAllChangedHandler:(FLXSEvent*)event
{
	[self onSelectAllChanged:event];
}

-(void)onSelectAllChanged:(NSNotification*)ns
{
    FLXSEvent* event = (FLXSEvent*)[ ns.userInfo objectForKey:@"event"];
	UIView<FLXSIFlexDataGridCell>* cell = (UIView<FLXSIFlexDataGridCell>*)event.target ;
	[self dispatchEvent:([[FLXSFlexDataGridEvent alloc] initWithType:event.type andGrid:cell.level.grid andLevel:cell.level andColumn:cell.columnFLXS andCell:cell andItem:nil andTriggerEvent:event andBubbles:NO andCancelable:NO ])];
}

- (void)sortByColumn:(FLXSFlexDataGridColumn *)col direction:(NSString *)direction {
	FLXSFilterSort* sort = [[FLXSFilterSort alloc] initWithSortColumn:col.sortFieldName andIsAscending:NO ];
    FLXSFilterSort* existingsort = (FLXSFilterSort *) [col.level getSortIndex:col return1:NO returnSortObject:YES ];
    if(direction!=nil)
	{
		sort.isAscending=([[direction lowercaseString] isEqual:@"ascending"]);
	}
	else if(!existingsort)
	{
		sort.isAscending=YES;
	}
	else
	{
		sort.isAscending=!existingsort.isAscending;
	}
	[col.level addSort:sort];
	if(col.level.nestDepth==1)
	{
		[self.grid rebuildHeader];
	}
}

- (void)onHeaderCellClicked:(FLXSFlexDataGridHeaderCell *)cell triggerEvent:(FLXSEvent *)triggerEvent isMsc:(BOOL)isMsc useMsc:(BOOL)useMsc direction:(NSString *)direction {
	if(!self.grid.allowInteractivity)return;

	FLXSFlexDataGridColumnLevel* lvl=cell.level;
	NSObject* cellData=cell.rowInfo.data;
	FLXSEvent* evt= [[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent HEADER_CLICKED] andGrid:lvl.grid andLevel:lvl andColumn:cell.columnFLXS andCell:cell andItem:nil andTriggerEvent:triggerEvent andBubbles:NO andCancelable:YES ];
	[self dispatchEvent:evt];
	[lvl dispatchEvent:evt];
	if([evt isDefaultPrevented])
	{
		return;
	}
	if(cell.columnFLXS.sortable)
	{
		FLXSTouchEvent* me=(FLXSTouchEvent*)triggerEvent;
        UIView* view = (UIView*)me.target;
		if(useMsc && (isMsc||(self.grid.enableSplitHeader && me && (me.localX>(view.width-self.grid.headerSortSeparatorRight)))))
		{
			//MCS
            [self sortByColumn:cell.columnFLXS direction:direction];
		}
		else
		{
			if(direction!=nil)
			{
				cell.sortAscending = ([[direction lowercaseString] isEqual:@"ascending"]);
			}
			else if([cell.columnFLXS.level hasSort:cell.columnFLXS])
			{
				cell.sortAscending = !cell.sortAscending;
			}
			else
			{
				cell.sortAscending = YES;
			}
			for(FLXSComponentInfo* oCell in cell.rowInfo.cells)
			{
				FLXSFlexDataGridHeaderCell* othercell = [oCell.component isKindOfClass:[FLXSFlexDataGridHeaderCell class]]?(FLXSFlexDataGridHeaderCell*)oCell.component:nil;
				if(othercell)
				{
					[othercell destroySortIcon];
				}
			}
            [self storeSort:cell.rowInfo.data column:cell.columnFLXS ascending:cell.sortAscending];
[self sortByCell:cell];
		}
		FLXSExtendedFilterPageSortChangeEvent* nested =
                [[FLXSExtendedFilterPageSortChangeEvent alloc] initWithType:[FLXSExtendedFilterPageSortChangeEvent FILTER_PAGE_SORT_CHANGE] andFilter:([self createFilter:lvl parentObject:(lvl.nestDepth == 1 ? nil : cellData)]) andBubbles:NO andCancelable:NO ];
		nested.cause = [FLXSExtendedFilterPageSortChangeEvent SORT_CHANGE];
		if(lvl.nestDepth==1)
			nested.filter.parentObject=nil;
		[lvl dispatchEvent:nested];
		if(lvl.nestDepth==1)
		{
			if(lvl.isClientFilterPageSortMode)
				[self.grid rebuildBody:NO];
		}
	}
}

- (void)storeSort:(NSObject *)item column:(FLXSFlexDataGridColumn *)column ascending:(BOOL)ascending {
	if(![_sortInfo hasHey:item])
	{
        [_sortInfo addItem:item value:[[FLXSSortInfo alloc] initWithSortColumn:column andSortAscending:ascending]];
	}
	else
	{
        FLXSSortInfo* srt = (FLXSSortInfo*)[_sortInfo getValue:item];
        srt.sortCol = column;
        srt.sortAscending = ascending;
	}
}

-(void)sortByCell:(FLXSFlexDataGridHeaderCell*)cell
{
	FLXSFlexDataGridColumnLevel* level = cell.level;
    [level setCurrentSort:cell.columnFLXS asc:cell.sortAscending];
	[cell createSortIcon:self];
}

- (NSArray *)filterPageSort:(NSArray *)flat level:(FLXSFlexDataGridColumnLevel *)level parentObj:(NSObject *)parentObj applyFilter:(BOOL)applyFilter applyPaging:(BOOL)applyPaging applySort:(BOOL)applySort pages:(NSArray *)pages updatePager:(BOOL)updatePager {
	FLXSFlexDataGridColumnLevel* columnOwner=level.columnOwnerLevel;
	if((columnOwner.currentSorts.count==0) && columnOwner.initialSortField)
	{
		for(FLXSFlexDataGridColumn* col in columnOwner.columns)
		{
			if(col.dataFieldFLXS == columnOwner.initialSortField)
			{
				[columnOwner setCurrentSort:col asc:columnOwner.initialSortAscending];
			}
		}
	}
	if(columnOwner.currentSorts.count>0 && applySort)
	{
		if([self.grid getLength:flat]>0)
		{
			flat= [FLXSExtendedUIUtils sortArray:flat sorts:columnOwner.currentSorts delegateForSortCompareFunctions:self.grid.delegate];
		}
	}
	FLXSFlexDataGridColumnLevel* lvl = level;
	FLXSFilter* filter = [self.grid.itemFilters objectForKey:parentObj==nil||level.reusePreviousLevelColumns||
            (lvl.nextLevel&&lvl.nextLevel.reusePreviousLevelColumns)?@"ROOT_FILTER":parentObj];
	if(self.grid.hasFilterFunction)
	{
		filter = [self.grid createFilter];
	}
	if(filter && applyFilter)
	{
		flat= [FLXSExtendedUIUtils filterArray:flat filter:filter grid:self.grid level:level hideIfNoChildren:self.grid.enableHideIfNoChildren];
	}
	if(updatePager && self.grid.updateTotalRecords)
	{
        self.grid.totalRecords=[self.grid getLength:flat];
	}
	if(level.enablePaging && applyPaging)
	{
		filter = [self.grid.itemFilters objectForKey:(parentObj?parentObj:@"ROOT_FILTER")];
		int pageIndex=filter?filter.pageIndex:0;
//        int totalRecords=flat.count;
		if(pages && pages.count==2)
			flat= [FLXSExtendedUIUtils pageArrayByPageNumbers:flat pageIndexes:pages pageSize:level.pageSize];
		else
            flat= [FLXSExtendedUIUtils pageArray:flat pageIndex:pageIndex pageSize:level.pageSize];
	}
	return flat;
}

- (FLXSFlexDataGridPaddingCell *)addPadding:(int)nestLevel row:(FLXSRowInfo *)row paddingHeight:(float)paddingHeight level:(FLXSFlexDataGridColumnLevel *)level forceRightLock:(BOOL)forceRightLock scrollPad:(BOOL)scrollPad width:(float)width {
	if(nestLevel>1)
	{
		FLXSFlexDataGridPaddingCell* pad= (FLXSFlexDataGridPaddingCell* ) [self.grid.rendererCache popInstance:level.nestIndentPaddingCellRenderer subFactory:(scrollPad ? level.scrollbarPadRenderer : level.nestIndentPaddingRenderer)];
		pad.rowInfo=row;
		pad.level = level;
		pad.forceRightLock=forceRightLock;
		pad.scrollBarPad=scrollPad;
        [pad setActualSizeWithWidth:(width == -1 ? level.maxPaddingCellWidth : width) andHeight:paddingHeight];
		FLXSComponentInfo* comp=[self addEventListeners:([self addCell:pad row:row existingComponent:nil ].componentInfo)];
		if(scrollPad)
		{
			comp.useComponentPosition=YES;
			pad.y=0;
		}
		return pad;
	}
	return nil;
}

-(void)drawRect:(CGRect)rect {
	if(_horizontalScrollPending!=-1)
	{
		[self gotoHorizontalPosition:_horizontalScrollPending];
		_horizontalScrollPending=-1;
	}
	//[super drawRect:rect];
}

-(void)getChildIds:(NSMutableArray*)arr
{
	for(FLXSRowInfo* row in self.rows)
	{
        for  (int i=0; i < row.cells.count; i++) {
            [arr    addObject:[NSNumber numberWithInt:(int)arr.count+1]];
		}
	}
}

-(NSArray*)getSelectedIds:(int)bodyStart
{
	NSMutableArray* arr=[NSMutableArray array];
	NSMutableArray* arr1=[NSMutableArray array];
	for(FLXSRowInfo* row in self.rows)
	{
		FLXSFlexDataGridColumnLevel* level=[row.rowPositionInfo getLevel:self.grid];
		BOOL selected=([level.selectedKeys containsObject:([level getItemKey:row.data saveLevel:NO ])]);
//		for(FLXSComponentInfo* comp in row.cells)		{
            for  (int i=0; i < row.cells.count; i++) {

			[arr addObject:[NSNumber        numberWithInt:(int)arr.count]];
//			UIView<FLXSIFlexDataGridCell>* cell=(UIView<FLXSIFlexDataGridCell>*)comp.component;
			if(selected)
			{
				[arr1 addObject:[NSNumber numberWithInt:(int)([arr count] +bodyStart) ]];
			}
		}
	}
	return arr1;
}

-(int)getChildId:(NSMutableArray*)arr :(UIView<FLXSIFlexDataGridCell>*)cell
{
	for(FLXSRowInfo* row in self.rows)
	{
		for(FLXSComponentInfo* comp in row.cells)
		{
			[arr addObject:[NSNumber        numberWithInt:(int)arr.count]];
			if(comp.component ==cell)
			{
				return (int)arr.count+1;
			}
		}
	}
    return 0;
}

- (UIView <FLXSIFlexDataGridCell> *)getChildAtId:(NSMutableArray *)arr id:(int)id {
	for(FLXSRowInfo* row in self.rows)
	{
		for(FLXSComponentInfo* comp in row.cells)
		{
			[arr addObject:[NSNumber    numberWithInt:(int)arr.count]];
			if(arr.count==id-2)
			{
				return (UIView <FLXSIFlexDataGridCell>*)comp.component;
			}
		}
	}

    return nil;
}

-(void)refreshCheckBoxes
{
	for(FLXSRowInfo* row in self.rows)
	{
		if(row.isDataRow || row.isHeaderRow)
		{
			for(FLXSComponentInfo* cell in row.cells)
			{
				UIView* comp = cell.component;
				if([comp isKindOfClass: [FLXSFlexDataGridCell class]])
				{
					FLXSFlexDataGridCell* tCell = (FLXSFlexDataGridCell*)comp;
					if([tCell.columnFLXS isKindOfClass:[FLXSFlexDataGridCheckBoxColumn class]])
					{
						[tCell initializeCheckBoxRenderer:tCell.renderer];
					}
				}
			}
		}
	}
}


- (void)setHorizontalScrollPolicy:(NSString *)horizontalScrollPolicyIn {
    _horizontalScrollPolicy = horizontalScrollPolicyIn;
    if([horizontalScrollPolicyIn isEqualToString: @"off"]){
        self.contentSize = CGSizeMake(self.bounds.size.width, self.contentSize.height);
    }

}

- (void)setVerticalScrollPolicy:(NSString *)verticalScrollPolicyIn {
    _verticalScrollPolicy = verticalScrollPolicyIn;
    if([verticalScrollPolicyIn isEqualToString: @"off"]){
        self.contentSize = CGSizeMake(self.contentSize.width,self.bounds.size.height);
    }

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
-(void)dispatchEvent:(FLXSEvent*)event
{

    [FLXSUIUtils dispatchEvent:event
                    withSender:self];
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver: self];
}
//End FLXSIEventDispatcher methods

+ (FLXSClassFactory*) levelRendererFactory
{
    if(!_levelRendererFactory)
        _levelRendererFactory = [[FLXSClassFactory alloc] initWithClass:[FLXSFlexDataGridLevelRendererCell class] andProperties:nil];
	return _levelRendererFactory;
}
+ (FLXSClassFactory*) labelFieldFactory
{
    if(!_labelFieldFactory)
        _labelFieldFactory = [[FLXSClassFactory alloc] initWithClass:[UILabel class] andProperties:[[NSMutableDictionary alloc]
                initWithObjects:[[NSArray alloc] initWithObjects:[UIColor clearColor], nil]
                        forKeys:[[NSArray alloc] initWithObjects:@"backgroundColor", nil]]];
    return _labelFieldFactory;
}
@end


