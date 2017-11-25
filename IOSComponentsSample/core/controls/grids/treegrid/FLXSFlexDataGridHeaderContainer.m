#import <QuartzCore/QuartzCore.h>
#import "FLXSFlexDataGridHeaderContainer.h"
#import "FLXSRowPositionInfo.h"
#import "FLXSComponentInfo.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSInsertionLocationInfo.h"
#import "FLXSRowInfo.h"
#import "FLXSIFlexDataGridCell.h"
#import "FLXSISelectFilterControl.h"
#import "FLXSComponentAdditionResult.h"
#import "FLXSFlexDataGridBodyContainer.h"
#import "FLXSExtendedFilterPageSortChangeEvent.h"
#import "FLXSFilterExpression.h"

#import "UIScrollView+UIScrollViewAdditions.h"
@implementation FLXSFlexDataGridHeaderContainer


-(id)initWithGrid:(FLXSFlexDataGrid*)grid
{

	self = [super initWithGrid:grid];
	if (self)
	{
		self.chromeType = FLXSRowPositionInfo.ROW_TYPE_HEADER;

		self.verticalScrollPolicy=@"off";
        self.horizontalScrollPolicy=@"off";
		[self addEventListenerOfType:(@"widthChanged") usingTarget:self withHandler:@selector(onWidthChanged:)];
	}
	return self;
}


-(void)onWidthChanged:(FLXSEvent*)event
{
	if(self.chromeType==[FLXSRowPositionInfo ROW_TYPE_PAGER])
	{
		FLXSComponentInfo* cellComp=[self getPagerCell];
		if(cellComp)
		{
			FLXSFlexDataGridPagerCell* cell=(FLXSFlexDataGridPagerCell* )cellComp.component;
			if(cell)
			{
                [cell setActualSizeWithWidth:([self getPagerWidth]) andHeight:cell.height];
				[cell invalidateDisplayList];
			}
		}
	}
}

-(void)onCellDropMouseMove:(FLXSEvent*)event
{
    //next version v1.2
//	if(grid.enableDrop && [DragManager isDragging])
//	{
//		UIView<FLXSIFlexDataGridCell>* cell = event.currentTarget as FLXSIFlexDataGridCell;
//		if(y>grid.bodyContainer.y)//i am below the container
//			[grid scrollToExistingRow:(grid.bodyContainer.verticalScrollPosition+cell.height) :YES];
//		else
//[grid scrollToExistingRow:(grid.bodyContainer.verticalScrollPosition-cell.height) :NO];
//	}
}

- (void)createComponents:(FLXSFlexDataGridColumnLevel *)level currentScroll:(int)currentScroll flat:(NSArray *)flat {
     if(flat==nil)
	{
        flat = self.grid.dataProviderFLXS;
		flat= [self filterPageSort:flat level:self.grid.columnLevel parentObj:nil applyFilter:YES applyPaging:NO applySort:YES pages:nil updatePager:NO ];
	}
    [super createComponents:level currentScroll:currentScroll flat:flat];
	float heightAdded;//self.height;
	float heightSoFar=0;
    float depth = [level getMaxColumnGroupDepth];
	if(self.chromeType==[FLXSRowPositionInfo ROW_TYPE_HEADER])
	{
		for(int i=1;i<depth;i++)
		{
			heightAdded= [((NSNumber *) [FLXSUIUtils max:([level getColumnGroupsAtLevel:i grps:nil result:nil start:0 all:NO ]) fld:(@"calculatedHeight") comparisonType:[FLXSFilterExpression FILTER_COMPARISON_TYPE_AUTO]]) floatValue];            
            
			FLXSRowPositionInfo* pos1= [[FLXSRowPositionInfo alloc] initWithRowData:flat andRowIndex:(i - 1) andVerticalPosition:heightSoFar andRowHeight:heightAdded andLevel:self.grid.columnLevel andRowType:[FLXSRowPositionInfo ROW_TYPE_COLUMN_GROUP]];
			heightSoFar+= heightAdded;
			[self processHeaderLevel:level rowPositionInfo:pos1 scrollDown:NO item:flat chromeLevel:[FLXSRowPositionInfo ROW_TYPE_COLUMN_GROUP] existingRow:nil existingComponents:nil ];
		}
	}
	NSMutableArray * colsWithoutCG= [[NSMutableArray alloc] init];
	for(FLXSFlexDataGridColumn* col in [level getVisibleColumns:nil])
	{
		if(col.columnGroup!=nil)
			[colsWithoutCG addObject:col];
	}
	heightAdded = [((NSNumber *) [FLXSUIUtils max:colsWithoutCG fld:(@"calculatedHeaderHeight") comparisonType:[FLXSFilterExpression FILTER_COMPARISON_TYPE_AUTO]]) floatValue];
	if(heightAdded==0)heightAdded=level.headerHeight;
    self.grid.currentPoint.leftLockedHeaderX = self.grid.currentPoint.rightLockedHeaderX=0;
	FLXSRowPositionInfo* pos= [[FLXSRowPositionInfo alloc] initWithRowData:flat andRowIndex:depth andVerticalPosition:heightSoFar andRowHeight:heightAdded andLevel:self.grid.columnLevel andRowType:self.chromeType];
    [self processHeaderLevel:level rowPositionInfo:pos scrollDown:NO item:flat chromeLevel:self.chromeType existingRow:nil existingComponents:nil ];
}

-(void)rootPageChange:(NSNotification*)ns
{
    FLXSExtendedFilterPageSortChangeEvent* evt= [[FLXSExtendedFilterPageSortChangeEvent alloc] initWithType:[FLXSExtendedFilterPageSortChangeEvent PAGE_CHANGE]];

	evt.triggerEvent= [ns.userInfo valueForKey:@"event"];
	[self dispatchEvent:evt];
}

-(void)onFilterChange:(NSNotification*)ns
{
    FLXSFilterPageSortChangeEvent* event =(FLXSFilterPageSortChangeEvent*) [ns.userInfo objectForKey:@"event"];
	[super onFilterChange:ns];
	FLXSExtendedFilterPageSortChangeEvent* evt= [[FLXSExtendedFilterPageSortChangeEvent alloc]
            initWithType:[FLXSExtendedFilterPageSortChangeEvent FILTER_CHANGE]];
	evt.triggerEvent=event;
	[self dispatchEvent:evt];
}

-(NSArray*)getRowsForRecycling
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self.rows count]];
    NSEnumerator *enumerator = [self.rows reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return array;
 }

-(float)maxHorizontalScrollPosition
{
	return self.grid.bodyContainer.maxHorizontalScrollPosition;
}

-(FLXSComponentInfo*)getPagerCell  {
    for(FLXSRowInfo* row in self.rows)
	{
		for(FLXSComponentInfo* cell in row.cells)
		{
			if([cell.component isKindOfClass:[FLXSFlexDataGridPagerCell class]])
			{
				return cell;
			}
		}
	}
	return nil;
}

-(UIView<FLXSIExtendedPager>*)getPager
{
    FLXSComponentInfo* cell =[self getPagerCell];
	if(cell && cell.component && ([cell.component isKindOfClass:[FLXSFlexDataGridPagerCell class]]))
		return(UIView<FLXSIExtendedPager>*) (cell.component).renderer;
	return nil;
}

- (FLXSComponentAdditionResult *)addCell:(UIView *)component row:(FLXSRowInfo *)row existingComponent:(FLXSComponentInfo *)existingComponent {
	FLXSComponentAdditionResult* result= [super addCell:component row:row existingComponent:existingComponent];
	result.horizontalSpill=NO;
	return result;
}


- (void)setFilterValue:(NSString *)col val:(NSObject *)val {
	for(FLXSRowInfo* row in self.rows)
	{
		for(FLXSComponentInfo* cell in row.cells)
		{
			UIView<FLXSIFlexDataGridCell>* fdg = cell.component;
			if(fdg && fdg.columnFLXS && [fdg.columnFLXS.searchField isEqual:col])
			{
				UIView<FLXSIFilterControl>* filterControl=(UIView<FLXSIFilterControl>* )fdg.renderer;
				if([filterControl conformsToProtocol:@protocol(FLXSISelectFilterControl)])
				{
					[[(UIView*)filterControl layer] display];
				}
				[filterControl setValue:val];
                [[(UIView*)filterControl layer] display];
				break;
			}
		}
	}
}

-(NSMutableArray*)getFilterArguments
{
    for(FLXSRowInfo* row in self.rows)
	{
		return (NSMutableArray*)[row getFilterArguments];
	}
	return [[NSMutableArray alloc] init];
}

-(BOOL)setFilterFocus:(NSString*)fld
{
    for(FLXSRowInfo* row in self.rows)
	{
		return [row setFilterFocus:fld];
	}
	return NO;
}

@end

