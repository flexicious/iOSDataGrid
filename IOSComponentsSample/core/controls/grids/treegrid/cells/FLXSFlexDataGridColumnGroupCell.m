#import "FLXSFlexDataGridColumnGroupCell.h"
#import "FLXSFlexDataGridColumnGroup.h"
#import "FLXSFlexDataGridEvent.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSFlexDataGridColumn.h"
#import "FLXSComponentInfo.h"
#import "FLXSCellUtils.h"

@implementation FLXSFlexDataGridColumnGroupCell {
@private
    BOOL _listenersAdded;
    BOOL _background;
    BOOL _wxInvalid;
}


@synthesize columnGroup = _columnGroup;
@synthesize listenersAdded = _listenersAdded;
@synthesize background = _background;
@synthesize wxInvalid = _wxInvalid;
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
    self.background = NO;
    self.wxInvalid = NO;
}



-(void)setColumnGroup:(FLXSFlexDataGridColumnGroup*) value
{
    _columnGroup = value;
	[self setNeedsDisplay];
}

-(void)destroy
{

	self.text=@"";
    self.background=NO;
	if(self.level)
	{
		_listenersAdded=NO;
		[self.level.grid removeEventListenerOfType:[FLXSFlexDataGridEvent COMPONENTS_CREATED] fromTarget:self usingHandler:@selector(invalidateWX:)];
		[self.level removeEventListenerOfType:[FLXSFlexDataGridEvent COLUMNS_RESIZED] fromTarget:self usingHandler:@selector(invalidateWX:)];
		if(self.columnFLXS)
		{
			[self.columnFLXS removeEventListenerOfType:[FLXSFlexDataGridEvent COLUMN_X_CHANGED] fromTarget:self usingHandler:@selector(invalidateWX:)];
		}
	}
	[super destroy];
}

-(void)onColumnsResized:(FLXSEvent*)event
{
	if(self.columnGroup)
	{
		NSArray* result=[self.columnGroup getWX];
		self.width= [result[0] floatValue];
        self.x= [result[1] floatValue];
		if(self.componentInfo)
            self.componentInfo.x=self.x;
		//y=columnGroup.y;
	}
	[self setNeedsDisplay];
}

-(FLXSFlexDataGridColumn*)columnFLXS
{
    return self.columnGroup ?self.columnGroup.startColumn:super.columnFLXS;
}


-(BOOL)drawTopBorder
{
	//if we're at a nested level, grid does not draw horizontal lines,
	//and there is no filter row, we draw a line above us to seperate ourselves from the data item above.
    return NO;
}

-(void)refreshCell
{

	[super refreshCell];
    [self onColumnsResized:nil];
	if(!_listenersAdded)
	{
		_listenersAdded=YES;
		[self.level.grid addEventListenerOfType:[FLXSFlexDataGridEvent COMPONENTS_CREATED] usingTarget:self withHandler:@selector(invalidateWX:)];
		[self.level addEventListenerOfType:[FLXSFlexDataGridEvent COLUMNS_RESIZED] usingTarget:self withHandler:@selector(invalidateWX:)];
		if(self.columnFLXS)
		{
			[self.columnFLXS addEventListenerOfType:[FLXSFlexDataGridEvent COLUMN_X_CHANGED] usingTarget:self withHandler:@selector(invalidateWX:)];
		}
	}
    self.text=self.columnGroup.headerText;
	//toolTip = [columnGroup expandCollapseTooltipFunction:self];
}

-(void)invalidateWX:(NSNotification *)ns
{
	_wxInvalid=YES;
	[self invalidateBackground];
	[self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect {
 	[super drawRect:rect];
	if(_wxInvalid)
	{
		[self onColumnsResized:nil];
		_wxInvalid=NO;
	}
	if(self.level && self.columnGroup && self.columnGroup.enableExpandCollapse)
	{
//		NSString* cls = [self.level.grid getStyle:(@"columnGroupOpenIcon")];
//		if ([self.columnGroup isClosed])
//			cls = [self.level.grid getStyle:(@"columnGroupClosedIcon")];
        //next version draw cls
        self.renderer.x = [[self getStyle:@"paddingLeft"] floatValue];
        self.renderer.width = self.width-[[self getStyle:@"paddingLeft"] floatValue]-
                [[self getStyle:@"paddingRight"] floatValue];
	}
}

-(id)getRolloverColor
{
	return [self getStyleValue:(@"columnGroupRollOverColors")];
}

-(NSString*)prefix
{
	return @"columnGroup";
}

-(id)getBackgroundColors
{
	NSObject * fromGrid=[FLXSCellUtils getBackgroundColorFromGrid:self];
	if(fromGrid!=nil)return fromGrid;
	if(self.currentBackgroundColors)return self.currentBackgroundColors;
	return [self getStyleValue:(@"columnGroupColors")];
}

-(id)getTextColors
{
	NSObject * fromGrid=[FLXSCellUtils getTextColorFromGrid:self];
	if(fromGrid!=nil)return fromGrid;
	if(self.currentTextColors)return self.currentTextColors;
	return [self getStyle:(@"color")];
}
-(void)setActualSizeWithWidth:(float)width andHeight:(float)height{
    [super setActualSizeWithWidth:width andHeight:height];
}


@end

