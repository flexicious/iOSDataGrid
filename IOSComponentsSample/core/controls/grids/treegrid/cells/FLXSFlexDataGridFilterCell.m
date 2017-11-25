#import "FLXSFlexDataGridFilterCell.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSCellUtils.h"
#import "FLXSIFilterControl.h"
#import "FLXSFlexDataGridColumn.h"

static  NSString* FILTER_CHANGE = @"filterChange";

@implementation FLXSFlexDataGridFilterCell


-(id)getBackgroundColors
{
	NSObject * fromGrid=[FLXSCellUtils getBackgroundColorFromGrid:self];
	if(fromGrid!=nil)return fromGrid;
	if(self.currentBackgroundColors)return self.currentBackgroundColors;
	return [self.level getStyleValue:(@"filterColors")];
}

-(id)getIconUrl:(BOOL)over
{
	return nil;
}

-(id)getTextColors
{

    NSObject * fromGrid=[FLXSCellUtils getTextColorFromGrid:self];
	if(fromGrid!=nil)return fromGrid;
	if(self.currentTextColors)return self.currentTextColors;
	return [self getStyle:(@"color")];
}

-(void)initializeCheckBoxRenderer:(UIView*)renderer
{
}

-(id)getRolloverColor
{
    if(self.columnFLXS) return [self.columnFLXS getStyleValue:(@"filterRollOverColors")];
	return [self.level getStyleValue:(@"filterRollOverColors")];
}

-(void)destroy
{
	UIView<FLXSIFilterControl>* iFilter= [self.renderer conformsToProtocol:@protocol(FLXSIFilterControl)]?(UIView<FLXSIFilterControl>*)self.renderer:nil;
	if(iFilter)
		[iFilter clear];

[super destroy];
}

-(void)refreshCell
{
    [super refreshCell];
	self.renderer.userInteractionEnabled = self.level.grid.allowInteractivity;
}

-(NSString*)prefix
{
	return @"filter";
}

-(BOOL)drawTopBorder
{ 
    //if we're at a nested level, grid does not draw horizontal lines,
    //and there is no filter row, we draw a line above us to seperate ourselves from the data item above.
    return (self.level && self.level.nestDepth>1 && ![[self.level.grid getStyle:(@"horizontalGridLines")] boolValue]
            &&(self.level.filterRowHeight==0)) ||
    [[self getStyleValue:(@"filterDrawTopBorder")] boolValue];
}

+ (NSString*)FILTER_CHANGE
{
	return FILTER_CHANGE;
}
@end

