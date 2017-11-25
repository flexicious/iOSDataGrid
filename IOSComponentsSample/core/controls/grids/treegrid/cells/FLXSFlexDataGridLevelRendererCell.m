#import "FLXSFlexDataGridLevelRendererCell.h"
#import "FLXSCellUtils.h"
#import "FLXSRowInfo.h"

@implementation FLXSFlexDataGridLevelRendererCell
-(id)init
{
	self = [super init];
	if (self)
	{
	}
	return self;
}


-(id)getBackgroundColors
{

	if(self.currentBackgroundColors)return self.currentBackgroundColors;
	NSObject * fromGrid=[FLXSCellUtils getBackgroundColorFromGrid:self];
	if(fromGrid!=nil)return fromGrid;
	return [self getStyleValue:(@"rendererColors")];
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
	return [self getStyleValue:(@"rendererRollOverColors")];
    return nil;
}

-(void)refreshCell
{
	[super refreshCell];
    if([self.renderer respondsToSelector:NSSelectorFromString(@"data")])
        [self.renderer setValue:self.rowInfo.data forKey:@"data"];
    if([self.rendererController respondsToSelector:NSSelectorFromString(@"data")])
        [self.rendererController setValue:self.rowInfo.data forKey:@"data"];

}

-(NSString*)prefix
{
	return @"renderer";
}

-(BOOL)drawTopBorder
{
    return NO;
}
@end

