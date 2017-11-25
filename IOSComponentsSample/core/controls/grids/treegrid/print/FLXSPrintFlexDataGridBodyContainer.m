//#import "FLXSPrintFlexDataGridBodyContainer.h"
//#import "FLXSFlexDataGrid.h"
//#import "FLXSPrintFlexDataGrid.h"
//
//
//@implementation FLXSPrintFlexDataGridBodyContainer
//
//@synthesize currentPositions;
//
//-(id)initWithGrid:(FLXSFlexDataGrid*)grid
//{
//    //next version
////	self = [super init:grid];
////	if (self)
////	{
////		_currentPositions = [[NSMutableArray alloc] init];
////
////		horizontalScrollPolicy=@"off";
////		strong) NSString* verticalScrollPolicy=@"off";
////		_verticalMask=0;
////		_horizontalMask=0;
////	}
////	return self;
//    return nil;
//}
//
//
//-(CGSize)contentSize {
//    return (((FLXSPrintFlexDataGrid *) self.grid).totalPagesHeight>0)?CGSizeMake(super.contentSize.width,((FLXSPrintFlexDataGrid *) self.grid).totalPagesHeight):super.contentSize;
//}
//
//-(void)showPositions:(NSArray*)positions
//{
//	//next version
////    if(!positions)
////	{
////		_currentPositions=nil;
////	}
////	else
////	{
////		_currentPositions=positions;
////	}
////	_drawDirty=YES;
////	[self doInvalidate];
//}
//
//-(BOOL)drawRows:(BOOL)forceFiller
//{
//	//next version
////    if(_currentPositions==nil || [_currentPositions length]!=3)
////	{
////		//[return super drawRows:forceFiller];
////		[self removeAllComponents:YES];
////		return YES;
////	}
////	[self removeAllComponents:YES];
////	FLXSRowPositionInfo* start = _currentPositions[0];
////	FLXSRowPositionInfo* end = _currentPositions[1];
////	verticalScrollPosition=start.verticalPosition;
////	BOOL lastPage=((calculatedTotalHeight-verticalScrollPosition)<height) &&(calculatedTotalHeight>height);
////	grid.currentPoint.contentY = start.verticalPosition;
////	grid.currentPoint.contentX=grid.currentPoint.leftLockedContentX=grid.currentPoint.rightLockedContentX=0;
////	if(start!=nil && end !=nil)
////	{
////		[self drawRowsUsingCache:start :end :YES :YES];
////	}
////	if(fillerRows.length==0)
////	{
////		FLXSRowPositionInfo* filler=[[FLXSRowPositionInfo alloc] initWithType:([[NSObject alloc] init]) :(end?end.rowIndex+1:1) :0 :height :grid.columnLevel :[FLXSRowPositionInfo ROW_TYPE_FILL]];
////		[fillerRows addObject:([self processItem:filler :NO])];
////	}
////	if(fillerRows.length>0)
////	{
////		for(FLXSComponentInfo* item in fillerRows[0].cells)
////		{
////			if(item.component)
////			{
////				item.component.y=verticalScrollPosition;
////				item.component.height=height;
////			}
////		}
////	}
////	return YES;
//    return NO;
//}
//
//-(float)calculatedTotalHeight
//{
//    //next version
////	return _calculatedTotalHeight;
//    return 0;
//}
//
//@end
//
