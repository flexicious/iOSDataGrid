#import <QuartzCore/QuartzCore.h>
#import "FLXSFlexDataGridPagerCell.h"
#import "FLXSCellUtils.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSRowInfo.h"
#import "FLXSItemLoadInfo.h"
#import "FLXSIExtendedPager.h"
#import "FLXSFlexDataGridContainerBase.h"

@implementation FLXSFlexDataGridPagerCell


-(id)getBackgroundColors
{
	if(self.currentBackgroundColors)return self.currentBackgroundColors;
	NSObject * fromGrid=[FLXSCellUtils getBackgroundColorFromGrid:self];
	if(fromGrid!=nil)return fromGrid;
	return [self getStyleValue:(@"pagerColors")];
}

-(id)getTextColors
{
	NSObject * fromGrid=[FLXSCellUtils getTextColorFromGrid:self];
	if(fromGrid!=nil)return fromGrid;
	if(self.currentTextColors)return self.currentTextColors;
	return [self getStyle:(@"color")];
}

-(id)getRolloverColor
{
	return [self getStyleValue:(@"pagerRollOverColors")];
}

-(BOOL)isLocked
{
	return YES;
}

- (void)setActualSizeWithWidth:(float)w andHeight:(float)h {
    [super setActualSizeWithWidth:w andHeight:h];
    [self setRendererSize:self.renderer width:w height:h];
	[self setNeedsDisplay];
}

-(void)destroy
{
	[super destroy];
}

-(void)refreshCell
{
    [super refreshCell];
	self.renderer.userInteractionEnabled= self.level.grid.allowInteractivity;
	UIView<FLXSIExtendedPager>* iPager=(UIView<FLXSIExtendedPager>*)self.renderer;
	iPager.dispatchEvents=NO;
	FLXSFlexDataGrid* grid = self.level.grid;
	iPager.pageSize = self.level.pageSize;
	NSObject* item = self.rowInfo.data;
	FLXSFilter* filter = [grid getItemFilter:self.level item:item];
	iPager.pageIndex = -1;
	//to ensure we redraw
	iPager.totalRecords = -1;
	//to ensure we redraw
	if(self.level.enablePaging)
	{
		if(self.level.nestDepth==1)
		{
			iPager.totalRecords = grid.totalRecords;
			iPager.pageIndex = filter&&filter.pageIndex>=0?filter.pageIndex:0;
		}
		else if(item&&!self.level.isClientFilterPageSortMode)
		{
			FLXSFlexDataGridContainerBase* container = [grid getContainerForCell:self];
			FLXSItemLoadInfo* loadInfo = [container findLoadingInfo:item level:self.level.parentLevel useSelectedKeyField:(self.level.childrenField.length > 0)];
			if(loadInfo)
			{
				iPager.totalRecords = loadInfo.totalRecords;
				iPager.pageIndex = loadInfo.pageIndex;
			}
		}
		else if(item && [item respondsToSelector:NSSelectorFromString(@"count")])
		{
			iPager.totalRecords = [[item valueForKey:@"count"] intValue];
			iPager.pageIndex = filter&&filter.pageIndex>=0?filter.pageIndex:0;
		}
		else if(item)
		{
			NSArray* result = [self.level.parentLevel getChildren:item filter:YES page:NO sort:YES ];
			if([grid getLength:result])
				iPager.totalRecords = (int)result.count;
			iPager.pageIndex = filter&&filter.pageIndex>=0?filter.pageIndex:0;
		}
	}
	iPager.dispatchEvents=YES;

}

-(NSString*)prefix
{
	return @"pager";
}

-(BOOL)drawTopBorder
{
    return  [[self getStyleValue:@"pagerDrawTopBorder"] boolValue];
}
@end

