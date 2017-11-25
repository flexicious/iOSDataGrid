#import "FLXSClassFactory.h"
#import "FLXSFlexDataGridColumnGroup.h"
#import "FLXSFlexDataGridColumn.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSUIUtils.h"
#import "FLXSFlexDataGridColumnGroupCell.h"
#import "FLXSFlexDataGrid.h"

static FLXSClassFactory* static_FLXSFlexDataGridColumnGroupCell;

@implementation FLXSFlexDataGridColumnGroup {

}


@synthesize columnGroupCellRenderer = _columnGroupCellRenderer;
@synthesize parentGroup = _parentGroup;
@synthesize columnGroups = _columnGroups;
@synthesize startColumn = _startColumn;
@synthesize calculatedStart = _calculatedStart;
@synthesize calculatedEnd = _calculatedEnd;
@synthesize columns = _columns;
@synthesize endColumn = _endColumn;
@synthesize calculatedHeight = _calculatedHeight;
@synthesize headerText = _headerText;
@synthesize headerWordWrap = _headerWordWrap;
@synthesize headerAlign=_headerAlign;
@synthesize level = _level;
@synthesize depth = _depth;
@synthesize y = _y;
@synthesize columnGroupRenderer = _columnGroupRenderer;
@synthesize enableExpandCollapse = _enableExpandCollapse;
@synthesize expandCollapsePositionFunction = _expandCollapsePositionFunction;
@synthesize expandTooltip = _expandTooltip;
@synthesize collapseTooltip = _collapseTooltip;
@synthesize expandCollapseTooltipFunction = _expandCollapseTooltipFunction;
@synthesize groupedColumns = _groupedColumns;
@synthesize collapseStateColumn = _collapseStateColumn;
@synthesize useLastColumnAsCollapseStateColumn = _useLastColumnAsCollapseStateColumn;

-(id)init
{
	self = [super init];
	if (self)
	{
		_columnGroupCellRenderer = [FLXSFlexDataGridColumnGroup static_FLXSFlexDataGridColumnGroupCell];
		_columnGroups = [[NSMutableArray alloc] init];
		_calculatedStart = nil;
		_calculatedEnd = nil;
		_columns = [[NSMutableArray alloc] init];
		_calculatedHeight = -1;
		_headerWordWrap = NO;
		_depth = 0;
		_y = 0;
		//_expandCollapsePositionFunction = @selector(defaultPositionFunction:);
		_expandTooltip = @"Expand";
        _collapseTooltip = @"Collapse";
		//_expandCollapseTooltipFunction = @selector(defaultExpandCollapseTooltipFunction:);
		_groupedColumns = [[NSMutableArray alloc] init];
		_useLastColumnAsCollapseStateColumn = YES;

	}
	return self;
}

-(FLXSFlexDataGridColumnGroup*)rootGroup
{
	return self.parentGroup?self.parentGroup.rootGroup:self;
}

-(float)width
{
	return [FLXSUIUtils sum:([self getAllColumns]) fld:(@"width")];
}

-(FLXSFlexDataGridColumn*)startColumn
{
	return self.calculatedStart?self.calculatedStart:[self getColumnAtExtremity:YES];
}


-(NSArray*)children
{
	return [self getAllColumns];
}

-(void)setChildren:(NSArray*)val
{
	self.columns=(NSMutableArray*)val;
}

-(void)setColumns:(NSArray*)value
{
	[self invalidateCalculations];
	_columns=(NSMutableArray*)value;
	if([value count] >0)
	{
		self.startColumn = value[0];
		self.endColumn = value[[value count] -1];
		if(self.useLastColumnAsCollapseStateColumn)
			self.collapseStateColumn=self.endColumn;
	}
}

-(NSArray*)columns
{
	return [_columns mutableCopy];
}

-(void)invalidateCalculations
{
	if(self.calculatedEnd || self.calculatedStart )
	{
        self.calculatedEnd=self.calculatedStart=nil;
		if(self.parentGroup)[self.parentGroup invalidateCalculations];
	}
}

-(void)invalidateCalculationsDown
{
    self.calculatedEnd=self.calculatedStart=nil;
	for(FLXSFlexDataGridColumnGroup* cg in self.columnGroups)
	{
		[cg invalidateCalculationsDown];
	}
}

-(FLXSFlexDataGridColumn*)endColumn
{
	return self.calculatedEnd?self.calculatedEnd:[self getColumnAtExtremity:NO];
}


-(float)height
{
	return self.calculatedHeight;
}

-(float)calculatedHeight
{
	return _calculatedHeight==-1?self.level?self.level.rowHeight:50:_calculatedHeight;
}
-(void)setCalculatedHeight:(float)calculatedHeight{
    _calculatedHeight = calculatedHeight;
}
-(void)setLevel:(FLXSFlexDataGridColumnLevel*)value
{
	_level = value;
	for(FLXSFlexDataGridColumnGroup* cg in self.columnGroups)
	{
		cg.level=value;
	}
}

-(FLXSClassFactory *)headerRenderer
{
	return self.columnGroupRenderer;
}

-(void)headerRenderer:(FLXSClassFactory*)value
{
    self.columnGroupRenderer = value;
}

-(NSString*)defaultExpandCollapseTooltipFunction:(UIView <FLXSIFlexDataGridCell>*)cell
{

	if(!self.enableExpandCollapse)return @"";
	if ([self isClosed])
	{
        return [[[NSArray alloc] initWithObjects:self.expandTooltip , @" " , self.headerText,nil] componentsJoinedByString:@""];
	}
	else
	{
        return [[[NSArray alloc] initWithObjects:self.collapseTooltip , @" " , self.headerText,nil] componentsJoinedByString:@""];
	}
}

-(CGPoint)defaultPositionFunction:(FLXSFlexDataGridColumnGroupCell*)cell
{
    return CGPointMake(2 ,cell.height/4);
}

-(BOOL)isClosed
{
	NSArray* cols=[self getAllColumns];
	if(cols.count==0)return NO;
	if(!self.collapseStateColumn)self.collapseStateColumn=cols[0];
	for(int i=0;i<cols.count;i++)
	{
		if(((FLXSFlexDataGridColumn *)cols[i]).visible && cols[i]!=self.collapseStateColumn)
		{
			return NO;
		}
	}
	return YES;
}

-(void)openColumns
{
	for(FLXSFlexDataGridColumn* col in [self getAllColumns])
	{
		col.visible=YES;
		col.calculatedMeasurements =[[NSMutableDictionary alloc]init];
	}
	[self.startColumn.level invalidateCache];
    self.startColumn.level.wxInvalid=YES;
	[self.startColumn.level.grid reDraw];
}

-(void)closeColumns  {
	if(!self.collapseStateColumn)self.collapseStateColumn=self.startColumn;
	for(FLXSFlexDataGridColumn* col in [self getAllColumns:nil])
	{
		col.visible=(col==self.collapseStateColumn);
		col.calculatedMeasurements =[[NSMutableDictionary alloc]init];
	}
	if(self.collapseStateColumn.level)
	{
		[self.collapseStateColumn.level invalidateCache];
        self.collapseStateColumn.level.wxInvalid=YES;
		[self.collapseStateColumn.level.grid reDraw];
	}
}

-(void)initializeGroup
{
	for(FLXSFlexDataGridColumnGroup* cg in self.columnGroups)
	{
		cg.parentGroup=self;
		[cg initializeGroup];
	}
	BOOL hit=NO;
	if(self.columnGroups.count==0)
	{
		for(FLXSFlexDataGridColumn* col  in self.level.columns)
		{
			if(col==self.startColumn)
			{
				hit=YES;
			}
			else if (col==self.endColumn)
			{
				col.columnGroup=self;
				return;
			}
			if(self.startColumn==self.endColumn)
			{
				if(self.startColumn)
				{
                    self.startColumn.columnGroup=self;
				}
				return;
			}
			if(hit)
			{
				col.columnGroup=self;
			}
		}
	}
}

- (void)initializeDepthY:(int)dpIn yIn:(float)yIn {
	if(_y==0)
		_y=yIn;
	if(_depth==0)
		_depth=dpIn;
	dpIn=dpIn+1;
	yIn=yIn+self.height;
	if(self.columnGroups.count>0)
	{
		for(FLXSFlexDataGridColumnGroup* cg in self.columnGroups)
		{
			if(!cg.level)cg.level=self.level;
            [cg initializeDepthY:dpIn yIn:yIn];
		}
	}
}

-(NSArray*)getWX
{
    if(!self.startColumn)return [[NSArray alloc] initWithObjects: [NSNumber numberWithFloat:-1 ],[NSNumber numberWithFloat:-1 ],nil];
    return self.endColumn&&self.endColumn.visible?
            [[NSArray alloc] initWithObjects: [NSNumber numberWithFloat:self.endColumn.x+ self.endColumn.width - self.startColumn.x ],
                            [NSNumber numberWithFloat:self.startColumn.x ],nil]
             : [[NSArray alloc] initWithObjects: [NSNumber numberWithFloat:self.startColumn.width ],
                            [NSNumber numberWithFloat:self.startColumn.x ],nil];

}
-(NSArray*)getAllColumns{
    return [self getAllColumns:nil];
}

-(NSArray*)getAllColumns:(NSMutableArray*)result
{
    if(!result)result= [[NSMutableArray alloc] init];
	for(NSObject* col in _columns)
	{
		if([result indexOfObject:col]==NSNotFound)
			[result addObject:col];
	}
	for(FLXSFlexDataGridColumnGroup* colG in self.columnGroups)
	{
		[colG getAllColumns:result];
	}
	return result;

}

-(FLXSFlexDataGridColumn*)getColumnAtExtremity:(BOOL)left
{

    if(left && self.calculatedStart)
		return self.calculatedStart;
	if(!left && self.calculatedEnd)
		return self.calculatedEnd;
	FLXSFlexDataGridColumn* least;
    FLXSFlexDataGridColumn* col;
	if(self.columnGroups.count>0 && self.columns.count==0)
	{
		for(FLXSFlexDataGridColumnGroup* colGroup in self.columnGroups)
		{
			FLXSFlexDataGridColumn* col = [colGroup getColumnAtExtremity:left];
			if(!least&&col)least=col;
			if(col)
			{
				if(left && least.colIndex>col.colIndex)least=col;
				if(!left && least.colIndex<col.colIndex)least=col;
			}
		}
	}
	else if(left)
	{
		for( col in _columns)
		{
			if(col.visible)
			{
				least=col;
				break;
			}
		}
	}
	else if(!left)
	{
        NSArray * reverse = [[_columns reverseObjectEnumerator] allObjects];
        for( col in reverse)
		{
			if(col.visible)
			{
				least=col;
				break;
			}
		}
	}
	if(left)
		self.calculatedStart=least;
    else
		self.calculatedEnd=least;
	return least;
}

-(FLXSFlexDataGridColumnGroup*)clone:(FLXSFlexDataGridColumnLevel*)newLevel
{
	FLXSFlexDataGridColumnGroup* newCg = [[FLXSFlexDataGridColumnGroup alloc] init];
	if(_startColumn)
	{
		int startColIndex=(int)[[self.level getPrintableColumns:nil deep:YES ] indexOfObject:_startColumn];
		FLXSFlexDataGridColumn* newStartCol = [newLevel getPrintableColumns:nil deep:YES ][startColIndex];
		newCg.startColumn = newStartCol;
	}
	if(_endColumn)
	{
		int endColIndex=(int)[[self.level getPrintableColumns:nil deep:YES ] indexOfObject:_endColumn];
		FLXSFlexDataGridColumn* newEndCol = [newLevel getPrintableColumns:nil deep:YES ][endColIndex];
		newCg.endColumn = newEndCol;
	}
	for(FLXSFlexDataGridColumnGroup* cg in self.columnGroups)
	{
		[newCg.columnGroups addObject:([cg clone:newLevel])];
	}
	newCg.columns = _columns;
	newCg.headerText=self.headerText;
	newCg.level=newLevel;
	return newCg;
}

-(BOOL)isColumnOnly
{
     return self.columnGroups.count==0&& _columns.count>0;
}

-(NSArray*)groupedColumns
{
	return [_groupedColumns count]==0?self.columns:_groupedColumns;
}

-(void)setGroupedColumns:(NSArray*)value
{
	_groupedColumns=[value mutableCopy];
    NSMutableArray* cols= [[NSMutableArray alloc] init];
    NSMutableArray* colgs= [[NSMutableArray alloc] init];
	for(NSObject* val in value)
	{
		FLXSFlexDataGridColumnGroup* grp = [val isKindOfClass:[FLXSFlexDataGridColumnGroup class]]?(FLXSFlexDataGridColumnGroup *)val:nil;
		if(grp)
		{
			for(NSObject* col in [grp getAllColumns])
				[cols addObject:col];
			[colgs addObject:grp];
		}
		else
		{
            ((FLXSFlexDataGridColumn *)val).columnGroup=self;
			[cols addObject:val];
		}
	}
	self.columns=cols;
    self.columnGroups=colgs;
}



-(float)yPlusHeight
{
	FLXSFlexDataGridColumnGroup* cg=self;
	float retVal=0;
	while(cg!=nil)
	{
		retVal+=cg.calculatedHeight;
		cg=cg.parentGroup;
	}
	return retVal;
}

+ (FLXSClassFactory*)static_FLXSFlexDataGridColumnGroupCell
{
    if(static_FLXSFlexDataGridColumnGroupCell==nil)
        static_FLXSFlexDataGridColumnGroupCell= [[FLXSClassFactory alloc] initWithClass:[FLXSFlexDataGridColumnGroupCell class] andProperties:nil];
    return static_FLXSFlexDataGridColumnGroupCell;

}
@end

