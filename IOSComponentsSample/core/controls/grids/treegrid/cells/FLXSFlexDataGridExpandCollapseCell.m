#import "FLXSFlexDataGridExpandCollapseCell.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSExpandCollapseIcon.h"
#import "FLXSRowInfo.h"
#import "FLXSCellUtils.h"
#import "FLXSFlexDataGridColumn.h"

static const NSString* EVENT_EXPAND_COLLAPSE = @"expandCollapse";

@implementation FLXSFlexDataGridExpandCollapseCell {
@private
    BOOL _hasChildren;
    BOOL _open;
    BOOL _forceRightLock;
    int _colSpan;
    int _rowSpan;
    UIImageView *expandCollapseIcon;
}

@synthesize hasChildren = _hasChildren;
@synthesize open = _open;
@synthesize forceRightLock = _forceRightLock;
@synthesize colSpan = _colSpan;
@synthesize rowSpan = _rowSpan;

-(void)setHasChildren:(BOOL)value
{
     _hasChildren = value;
	if(self.level.grid.allowInteractivity )
	{
		if(self.rowInfo&&self.rowInfo.isFillRow)
			value=NO;
	}
    _hasChildren = value;

}

-(void)destroy
{
	[super destroy];
    self.open=NO;
    self.forceRightLock=NO;
}
-(void)refreshCell
{
	[super refreshCell];
    [self invalidateBackground];
	[FLXSExpandCollapseIcon refreshCell:(UIView<FLXSIExpandCollapseComponent>*)self];
}
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
    self.hasChildren = NO;
    self.open = NO;
    self.forceRightLock = NO;
    self.colSpan = 1;
    self.rowSpan = 1;
    expandCollapseIcon = [[UIImageView alloc]init];
    [self addSubview:expandCollapseIcon];
}

-(void)doClick
{
	[self onClick:nil];
}
-(UIImageView *) expandCollapseImageView{
    return expandCollapseIcon;
}
-(void)onClick:(NSObject*)event
{
	[FLXSExpandCollapseIcon doClick:(UIView<FLXSIExpandCollapseComponent>*)self];
}

-(void)drawRect:(CGRect)rect {
    BOOL shoudDraw=self.backgroundDirty;
    [super drawRect:rect];
    if(shoudDraw)           {
		[FLXSExpandCollapseIcon drawIcon:(UIView<FLXSIExpandCollapseComponent>*)self];
    }
}

-(id)getBackgroundColors
{
	 
    NSObject * fromGrid=[FLXSCellUtils getBackgroundColorFromGrid:self];
	if(fromGrid!=nil)return fromGrid;
	if(self.rowInfo&&self.rowInfo.isDataRow)return[ super getBackgroundColors];
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


-(BOOL)drawTopBorder
{

    //if we're at a nested level, grid does not draw horizontal lines,
    //and there is no filter row, we draw a line above us to seperate ourselves from the data item above.
    return [[self getStyleValue:[self.prefix stringByAppendingString:@"DrawTopBorder"]] boolValue]
            ||((self.rowInfo.isHeaderRow && self.level.nestDepth>1
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

-(id)getTextColors
{
    NSObject * fromGrid=[FLXSCellUtils getTextColorFromGrid:self];
	if(fromGrid!=nil)return fromGrid;
	if(self.currentTextColors)return self.currentTextColors;
	return [self getStyle:(@"color")];
    return nil;
}

-(BOOL)isLocked
{
    return self.columnFLXS ?self.columnFLXS.isLocked:self.forceRightLock || self.level.grid.lockDisclosureCell;
}

-(BOOL)isLeftLocked
{
	return self.columnFLXS ?self.columnFLXS.isLeftLocked:!self.forceRightLock&&self.level.grid.lockDisclosureCell;
}

-(BOOL)isRightLocked
{
    return self.columnFLXS ?self.columnFLXS.isRightLocked:self.forceRightLock||super.isRightLocked;
}

-(BOOL)isExpandCollapseCell
{
	return YES;
}

-(UIView<FLXSIExpandCollapseComponent>*)iExpandCollapseComponent
{
	return (UIView<FLXSIExpandCollapseComponent>*)self;
}

-(UIView<FLXSIFlexDataGridCell>*)cellFLXS
{
	return self;
}


+ (NSString*)EVENT_EXPAND_COLLAPSE
{
	return [EVENT_EXPAND_COLLAPSE description];
}
@end

