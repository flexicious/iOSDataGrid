#import "FLXSFlexDataGridHeaderCell.h"
#import "FLXSFlexDataGridEvent.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSFlexDataGridColumn.h"
#import "FLXSTriStateCheckBox.h"
#import "FLXSRowInfo.h"
#import "FLXSCellUtils.h"
#import "FLXSFlexDataGridCheckBoxColumn.h"
#import "FLXSExtendedUIUtils.h"
#import "FLXSSelectionInfo.h"
#import "FLXSTouchEvent.h"
#import "FLXSFlexDataGridHeaderContainer.h"
#import "FLXSFilterSort.h"

@implementation FLXSFlexDataGridHeaderCell {
@private
    BOOL _resizing;
    BOOL _resizingPrevious;
    BOOL _sortAscending;
    BOOL _sortable;
    float _iconOffset;
}


@synthesize resizing = _resizing;
@synthesize resizingPrevious = _resizingPrevious;
@synthesize sortAscending = _sortAscending;
@synthesize sortable = _sortable;
@synthesize icon = _icon;
@synthesize sortLabel = _sortLabel;
@synthesize iconOffset = _iconOffset;
@synthesize accessibilityIdentifier = _accessibilityIdentifier;


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
    self.resizing = NO;
    self.resizingPrevious = NO;
    self.sortAscending = NO;
    self.sortable = YES;
    self.iconOffset = 0;
    [self addEventListenerOfType:[FLXSTouchEvent TAP] usingTarget:self withHandler:@selector(onHeaderClick:)];
}


-(void)setIcon:(UIView*)value
{
	_icon = value;
	[self placeComponent:self.renderer unscaledWidth:self.width unscaledHeight:self.height usePadding:YES ];
}

-(void)setSortLabel:(UIView*)value
{
    _sortLabel = value;
    [self placeComponent:self.renderer unscaledWidth:self.width unscaledHeight:self.height usePadding:YES ];
}

-(void)destroySortIcon
{
	if(self.icon && self.icon.superview!=nil)
	{
		[FLXSUIUtils removeChild:self.icon.superview child:self.icon];
	}
	if(self.sortLabel && self.sortLabel.superview!=nil)
	{
		[FLXSUIUtils removeChild:self.sortLabel.superview child:self.sortLabel];
		//[self.sortLabel removeEventListener:[FLXSTouchEvent CLICK] :onSortLabelClick :NO];
	}
	self.sortLabel=nil;
	self.icon=nil;
}


-(void)columnFLXS:(FLXSFlexDataGridColumn*)value
{
    super.columnFLXS =value;
	if(self.columnFLXS)
	{
        self.columnFLXS.x=self.x;
	}
}

-(void)onSortLabelClick:(FLXSTouchEvent*)event
{
	//self means we need to just swap the order of self
	FLXSFlexDataGrid* grid = self.level.grid;
	if(self.level&&self.level.grid.enableSplitHeader&&self.columnFLXS &&self.columnFLXS.sortable&&grid.enableSplitHeader)
	{
		[[grid getContainerForCell:self] onHeaderCellClicked:self triggerEvent:event isMsc:YES useMsc:YES direction:nil ];
	}
	else if(self.columnFLXS.sortable)
	{
		[grid multiColumnSortShowPopup];
	}
}

-(void)createSortIcon:(UIView*)container
{

	UIView* ic;
	if(self.icon)
	{
		[self destroySortIcon];
	}
	if(self.columnFLXS &&!self.columnFLXS.sortable)return;
	FLXSFlexDataGrid* grid=self.level.grid;
    UILabel* sl;
	if(self.level.grid.enableMultiColumnSort)
	{
		 sl=[[UILabel alloc] init];
//		sl.useHandCursor=!grid.enableSplitHeader;
//		sl.buttonMode=!grid.enableSplitHeader;
//		sl.mouseChildren=grid.enableSplitHeader;
//		sl.toolTip = [grid multiColumnSortGetTooltip:self];
        sl.text = [[self.level getSortIndex:self.columnFLXS return1:YES returnSortObject:NO ] description];
        sl.backgroundColor = [UIColor clearColor];
        //sl.styleName=[grid getStyle:(@"multiColumnSortNumberStyleName")];
	}
	UIView* p=(self.isLocked?self.isLeftLocked?(UIView*)grid.leftLockedHeader:(UIView*)grid.rightLockedHeader:(UIView*)container);
	if(self.sortAscending)
	{
		ic=[self.level createAscendingSortIcon];
		if(ic.superview != grid)
		{
			[FLXSUIUtils addChild:p child:ic];
			if(self.level.grid.enableMultiColumnSort)
				[FLXSUIUtils addChild:p child:sl];
		}
	}
	else
	{
		ic=[self.level createDescendingSortIcon];
		if(ic.superview != grid)
		{
			[FLXSUIUtils addChild:p child:ic];
			if(self.level.grid.enableMultiColumnSort)
				[FLXSUIUtils addChild:p child:sl];
		}
	}
	self.icon=ic;
	if(self.level.grid.enableMultiColumnSort) {
        sl.font = [sl.font fontWithSize:13];
        self.sortLabel=sl;
    }
	[self placeSortIcon];
}

- (void)setRendererSize:(UIView *)cellRenderer width:(float)w height:(float)h {
    if(self.level && self.level.grid.enableSplitHeader && self.columnFLXS.sortable && (![cellRenderer isKindOfClass:[FLXSTriStateCheckBox class] ]) )
	{
		w=w-self.level.grid.headerSortSeparatorRight;
	}
	else if(self.icon)
	{
		w=w-self.icon.width-5;
	}
    [super setRendererSize:cellRenderer width:w height:h];
}

-(void)destroy
{
	[self destroySortIcon];
	self.x=0;
	[super destroy];
    self.resizing=NO;
    self.resizingPrevious=NO;
    self.sortAscending=NO;
    self.sortable=NO;
	[self destroySortIcon];
}

-(BOOL)isSorted
{
    return self.icon != nil;
}


-(void)onHeaderClick:(FLXSEvent*)event
{
	if(self.level)
        [self dispatchEvent:[[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent HEADER_CLICKED] andGrid:self.level.grid andLevel:self.level andColumn:self.columnFLXS andCell:self andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ]];
}

-(void)refreshCell
{

	[super refreshCell];
if(!([self.columnFLXS isKindOfClass:[FLXSFlexDataGridCheckBoxColumn class]])
        && [self.renderer respondsToSelector:NSSelectorFromString(@"data")] && self.columnFLXS.headerRenderer!=nil)
    [self.renderer setValue:self.rowInfo forKey:@"data"];
    FLXSFilterSort* fs= [self.level hasSort:self.columnFLXS];
	if(fs)
	{
		self.sortAscending=fs.isAscending;
		[self destroySortIcon];
		[self createSortIcon:self.superview];
	}
    self.renderer.hidden=self.columnFLXS.hideHeaderText;

}
-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self placeSortIcon];
}

-(void)placeSortIcon
{
	if(self.icon)
	{
		//FLXSPoint* pt=[[FLXSPoint alloc] initWithX:(self.width-self.icon.width-3) andY:((self.height)/2)];
        CGPoint pt=CGPointMake((self.width-self.icon.width-6) ,((self.height)/2)-8);
		pt= [self.icon.superview globalToContent:([self localToGlobal:pt])];
//        [self.icon setActualSize:12 height:12];
        [self.icon moveToX:pt.x y:pt.y];
		if(self.sortLabel && self.level.grid.enableMultiColumnSort)
		{
			float right=self.level.grid.headerSortSeparatorRight;
            self.sortLabel.width=[[self.level.grid getStyle:(@"multiColumnSortNumberWidth") ]floatValue];
            self.sortLabel.height=[[self.level.grid getStyle:(@"multiColumnSortNumberHeight") ]floatValue];
			//pt=[[FLXSPoint alloc] initWithX:(self.width - right+2) andY:MAX(0 ,(((self.height-self.sortLabel.height)/2)-1))];
            pt = CGPointMake(self.width-right+3, MAX(0,9+((self.height-self.sortLabel.height)/2)));
			pt= [self.icon.superview globalToContent:([self localToGlobal:pt])];
            [self.sortLabel moveToX:pt.x y:pt.y];
		}
	}
}
- (void)setNeedsDisplay {
    [super setNeedsDisplay];

}
-(void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	[self drawSortSeparator];
}

-(void)drawSortSeparator
{
    if(self.level&&self.level.grid.enableSplitHeader&&self.columnFLXS &&self.columnFLXS.sortable)
	{
		float right=self.level.grid.headerSortSeparatorRight;
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context,
                [self.level.grid getStyle:(@"headerSortSeparatorColor")] != nil? [[self.level.grid getStyle:(@"headerSortSeparatorColor")] CGColor] : [[UIColor grayColor] CGColor]);
        CGContextSetLineWidth(context, 1 );
        CGContextMoveToPoint(context, self.width - right,3); //start at this point
        CGContextAddLineToPoint(context, self.width - right, self.height-3); //draw to this point
        CGContextStrokePath(context);


	}
}

-(id)getBackgroundColors
{
	NSObject * fromGrid=[FLXSCellUtils getBackgroundColorFromGrid:self];
	if(fromGrid!=nil)return fromGrid;
	if(self.currentBackgroundColors)return self.currentBackgroundColors;
	return [self getStyleValue:(@"headerColors")];
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

	FLXSTriStateCheckBox* tcb= [self.renderer isKindOfClass:[FLXSTriStateCheckBox class]]?(FLXSTriStateCheckBox*)self.renderer:nil;
	if(!tcb)return ;
	FLXSFlexDataGridCheckBoxColumn* col=(FLXSFlexDataGridCheckBoxColumn*)self.columnFLXS;
	if(col && col.enableLabelAndCheckBox)
	{
		tcb.label=col.headerText;
	}
	if(self.level.nestDepth!=1 )
	{
		[FLXSCellUtils initializeCheckBoxRenderer:self level:self.level.parentLevel];
		if(self.level.enableSingleSelect)
		{
			tcb.radioButtonMode=YES   ;
            tcb.userInteractionEnabled=NO;
		}
		return;
	}
	tcb.radioButtonMode=col.radioButtonMode;
    tcb.enableDelayChange=NO;
	//we dont want the delay timer
	if(col.radioButtonMode   || !col.allowSelectAll)
	{
		tcb.userInteractionEnabled=NO;
	}
	else
	{
		tcb.userInteractionEnabled=YES;
		NSArray* provider=[self.level.grid getRootFlat];
		if(self.level.grid.isClientFilterPageSortMode)
			provider = [FLXSExtendedUIUtils filterArray:provider filter:([self.level.grid getRootFilter]) grid:self.level.grid level:self.level hideIfNoChildren:NO ];
			tcb.selectedState=[self.level getSelectedKeysState:provider];
		if([tcb.selectedState isEqual:[FLXSTriStateCheckBox STATE_UNCHECKED]])
		{
			if(self.level.grid.enableSelectionExclusion)
			{
				if(self.level.grid.selectionInfo.hasAnySelections)
				{
					tcb.selectedState=[FLXSTriStateCheckBox STATE_MIDDLE];
				}
			}
			else if([self.level.grid getSelectedObjects :NO :NO].count>0)
			{
				tcb.selectedState=[FLXSTriStateCheckBox STATE_MIDDLE];
			}
		}
	}
}

-(void)onCheckChange:(NSNotification*)ns
{
    FLXSEvent* event = (FLXSEvent*)[ ns.userInfo objectForKey:@"event"];
	FLXSTriStateCheckBox* cb=(FLXSTriStateCheckBox*)event.target  ;
	if(!cb)return;
	if(self.level.nestDepth==1)
	{
        [self.level selectAll:cb.checked dispatch:YES provider:nil subset:nil useKeys:NO openItems:NO ];
        [self.level dispatchEvent:[[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent SELECT_ALL_CHECKBOX_CHANGED] andGrid:self.level.grid andLevel:self.level andColumn:self.columnFLXS andCell:self andItem:nil andTriggerEvent:event andBubbles:NO andCancelable:NO ]];
		
	}
	else
	{
		if(self.level.grid.enableSelectionExclusion)
		{
            [self.level.parentLevel selectRow:self.rowInfo.data selected:cb.checked dispatch:YES recurse:YES bubble:YES parent:nil ];
		}
		else
		{
			if(!cb.checked)
				[self.level.parentLevel selectRow:self.rowInfo.data selected:NO dispatch:NO recurse:NO bubble:NO parent:nil ];
			else
[self.level.parentLevel selectRow:self.rowInfo.data selected:YES dispatch:NO recurse:NO bubble:NO parent:nil ];
            [self selectLevel:self.level items:([self.level.parentLevel getChildren:self.rowInfo.data filter:NO page:NO sort:NO ]) checked:cb.checked];
		}
	}
    [self dispatchEvent:[[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent SELECT_ALL_CHECKBOX_CHANGED] andGrid:self.level.grid andLevel:self.level andColumn:self.columnFLXS andCell:self andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ]];
}

- (void)selectLevel:(FLXSFlexDataGridColumnLevel *)checkLevel items:(NSArray *)items checked:(BOOL)checked {
	for(NSObject* item in items)
	{
		[checkLevel selectRow:item selected:checked dispatch:YES recurse:YES bubble:YES parent:nil ];
	}
}


-(id)getRolloverColor
{
	return [self getStyleValue:(@"headerRollOverColors")];
}
 
-(NSString*)prefix
{
	return @"header";
}

-(BOOL)drawTopBorder
{
    //if we're at a nested level, grid does not draw horizontal lines,
    //and there is no filter row, we draw a line above us to seperate ourselves from the data item above.
    return (self.level && self.level.nestDepth>1 && ![[self.level.grid getStyle:(@"horizontalGridLines")] boolValue]
            &&(self.level.filterRowHeight==0)) ||
            [[self getStyleValue:(@"headerDrawTopBorder")] boolValue];
}

- (void)moveToX:(float)x y:(float)y {
    [super moveToX:x y:y];
	if(self.columnFLXS)
	{
        self.columnFLXS.x=x;
	}
}

@end

