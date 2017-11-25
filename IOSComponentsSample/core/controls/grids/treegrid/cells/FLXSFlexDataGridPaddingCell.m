#import "FLXSFlexDataGridPaddingCell.h"
#import "FLXSCellUtils.h"
#import "FLXSRowInfo.h"
#import "FLXSRowPositionInfo.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSFlexDataGrid.h"


@implementation FLXSFlexDataGridPaddingCell {
@private
    BOOL _forceRightLock;
    BOOL _scrollBarPad;
}


@synthesize forceRightLock = _forceRightLock;
@synthesize scrollBarPad = _scrollBarPad;

-(id)init
{	self = [super init];
    if (self)
    {
        [self initCommon];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initCommon];
    }
    return self;
}
- (void)initCommon {
    [super initCommon];
    self.forceRightLock = NO;
}



-(void)destroy
{
    [super destroy];
	self.scrollBarPad=NO;
}

-(id)getBackgroundColors
{
	NSObject * fromGrid=[FLXSCellUtils getBackgroundColorFromGrid:self];
	if(fromGrid!=nil)return fromGrid;
	if(self.rowInfo&&self.rowInfo.isDataRow)return [super getBackgroundColors];
	if(self.rowInfo&&self.rowInfo.isFillRow)return [self getStyleValue:(@"backgroundColor")];
	if(self.rowInfo)
	{
		if(self.rowInfo.isHeaderRow)
		{
			return [self getStyleValue:(@"headerColors")];
		}
		else if(self.rowInfo.isPagerRow)
		{
			return [self getStyleValue:(@"pagerColors")];
		}
		else if(self.rowInfo.isFooterRow)
		{
			return [self getStyleValue:(@"footerColors")];
		}
		else if(self.rowInfo.isFilterRow)
		{
			return [self getStyleValue:(@"filterColors")];
		}
		else
		{
			BOOL odd=((self.rowInfo&&self.rowInfo.rowPositionInfo.rowIndex%2)==0);
            return [self getStyleValue:(@"alternatingItemColors")][odd?0:1];
		}
	}
	else
	{
		return [self getStyleValue:(@"backgroundColor")];
	} 
}

-(id)getTextColors
{
	return 0x000000;
}


-(BOOL)drawTopBorder
{

    //if we're at a nested level, grid does not draw horizontal lines,
    //and there is no filter row, we draw a line above us to seperate ourselves from the data item above.
    return [[self getStyleValue:[self.prefix stringByAppendingString:@"DrawTopBorder"]] boolValue] ||((self.rowInfo.isHeaderRow && self.level.nestDepth>1
            && !([[self.level.grid getStyle: @"horizontalGridLines" ] boolValue])
            &&(self.level.filterRowHeight==0))
            ||(self.rowInfo.isFilterRow  && self.level.nestDepth>1 && !([[self.level.grid getStyle: @"horizontalGridLines" ] boolValue]))
    );
}

-(NSString*)prefix
{
    return self.rowInfo?self.rowInfo.isHeaderRow?(@"header")
            :self.rowInfo.isPagerRow?(@"pager")
                    :self.rowInfo.isFooterRow?(@"footer")
                            :self.rowInfo.isFilterRow?(@"filter")
                                    :self.rowInfo.isRendererRow?(@"renderer"):@"":@"";
}

-(BOOL)isLocked
{
 	return self.scrollBarPad?NO:self.forceRightLock || self.level.grid.lockDisclosureCell;
}

-(BOOL)isLeftLocked
{
     return self.scrollBarPad?NO:!self.forceRightLock&&self.level.grid.lockDisclosureCell;
}

-(BOOL)isRightLocked
{
    return self.scrollBarPad?NO:self.forceRightLock||super.isRightLocked;
}

- (void)drawRightBorder:(float)unscaledWidth unscaledHeight:(float)unscaledHeight {

	if(self.level.nestDepth==self.level.grid.maxDepth || (self.scrollBarPad))
	{
        [super drawRightBorder:unscaledWidth unscaledHeight:unscaledHeight];
	}
}


@end

