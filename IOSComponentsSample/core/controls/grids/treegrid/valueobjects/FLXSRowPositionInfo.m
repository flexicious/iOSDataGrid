#import "FLXSRowPositionInfo.h"
#import "FLXSIExtendedDataGrid.h"
#import "FLXSFlexDataGridColumnLevel.h"

static const int ROW_TYPE_HEADER = 1;
static const int ROW_TYPE_FOOTER = 2;
static const int ROW_TYPE_PAGER = 3;
static const int ROW_TYPE_FILTER = 4;
static const int ROW_TYPE_DATA = 5;
static const int ROW_TYPE_FILL = 6;
static const int ROW_TYPE_RENDERER = 7;
static const int ROW_TYPE_COLUMN_GROUP = 8;

@implementation FLXSRowPositionInfo {
@private
    int _rowIndex;
    float _verticalPosition;
    float _rowHeight;
    int _rowType;
    int _levelNestDepth;
    int _rowSpan;
}
@synthesize rowData;
@synthesize string;
@synthesize virtualScrollLoadInfo;

@synthesize rowIndex = _rowIndex;
@synthesize verticalPosition = _verticalPosition;
@synthesize rowHeight = _rowHeight;
@synthesize rowType = _rowType;
@synthesize levelNestDepth = _levelNestDepth;
@synthesize rowSpan = _rowSpan;

- (id)initWithRowData:(NSObject *)rowDataIn
          andRowIndex:(int)rowIndexIn
  andVerticalPosition:(float)verticalPositionIn
         andRowHeight:(float)rowHeightIn
             andLevel:(FLXSFlexDataGridColumnLevel *)levelIn
           andRowType:(int)rowTypeIn {
	self = [super init];
	if (self)
	{
		//string = @"";

		self.rowData = rowDataIn;
        self.rowIndex = rowIndexIn;
        self.verticalPosition = verticalPositionIn;
        self.rowHeight = rowHeightIn;
        self.rowType = rowTypeIn;
        self.levelNestDepth = levelIn.nestDepth;

        //self.string = [@"" stringByAppendingFormat: @"%d:%d:%d:%d:%d:%d",rowIndex,verticalPosition,rowHeight,rowType,level.nestDepth,1];
	}
	return self;
}


-(FLXSFlexDataGridColumnLevel*)getLevel:(FLXSFlexDataGrid*)grid
{
	int depth=self.levelNestDepth;
	if(depth<1)
		return grid.columnLevel;
	FLXSFlexDataGridColumnLevel* level=grid.columnLevel;
	while(depth!=level.nestDepth)
	{
		level=level.nextLevel;
	}
	return level;
}
//
//-(int)rowIndex
//{
//	return [[self.string componentsSeparatedByString:@":"][0] integerValue];//[self parseInt:([string componentsSeparatedByString:(@":")][0])];
//}
//
//-(float)verticalPosition
//{
//    return [[self.string componentsSeparatedByString:@":"][1] integerValue];
//}
//
//-(int)rowHeight
//{
//    return [[self.string componentsSeparatedByString:@":"][2] integerValue];
//}
//
//-(int)rowType
//{
//    return [[self.string componentsSeparatedByString:@":"][3] integerValue];
//}
//
//-(int)levelNestDepth
//{
//    return [[self.string componentsSeparatedByString:@":"][4] integerValue];
//}
//
//-(int)rowSpan
//{
//    return [[self.string componentsSeparatedByString:@":"][5] integerValue];
//}
//
//-(int)verticalPositionPlusHeight
//{
//	return self.verticalPosition+self.rowHeight;
//}
//
//-(void)setRowIndex:(int)val
//{
//    self.string = [@"" stringByAppendingFormat: @"%d:%d:%d:%d:%d:%d",val,self.verticalPosition,self.rowHeight,self.rowType,self.levelNestDepth,self.rowSpan];
//}
//
//-(void)setVerticalPosition:(float)val
//{
//    self.string = [@"" stringByAppendingFormat: @"%d:%d:%d:%d:%d:%d",self.rowIndex,val,self.rowHeight,self.rowType,self.levelNestDepth,self.rowSpan];
//}
//
//-(void)setRowSpan:(int)val
//{
//    self.string = [@"" stringByAppendingFormat: @"%d:%d:%d:%d:%d:%d",self.rowIndex,self.verticalPosition,self.rowHeight,self.rowType,self.levelNestDepth,val];
//}

//public function get rowNestLevel():int{return rowType==FLXSRowPositionInfo.ROW_TYPE_RENDERER?levelNestDepth+1:levelNestDepth;}
//public function get isRendererRow():Boolean {return rowType==FLXSRowPositionInfo.ROW_TYPE_RENDERER}
//public function get isDataRow():Boolean {return rowType==FLXSRowPositionInfo.ROW_TYPE_DATA}
//public function get isHeaderRow():Boolean {return rowType==FLXSRowPositionInfo.ROW_TYPE_HEADER}
-(int)rowNestLevel
{
    return self.rowType==[FLXSRowPositionInfo ROW_TYPE_RENDERER]?self.levelNestDepth+1:self.levelNestDepth;
}
-(BOOL)isRendererRow
{

    return self.rowType==FLXSRowPositionInfo.ROW_TYPE_RENDERER;
}

-(BOOL)isDataRow
{
    return self.rowType==FLXSRowPositionInfo.ROW_TYPE_DATA;
}

-(BOOL)isHeaderRow
{
    return self.rowType==FLXSRowPositionInfo.ROW_TYPE_HEADER;
}

+ (int)ROW_TYPE_HEADER
{
	return ROW_TYPE_HEADER;
}
+ (int)ROW_TYPE_FOOTER
{
	return ROW_TYPE_FOOTER;
}
+ (int)ROW_TYPE_PAGER
{
	return ROW_TYPE_PAGER;
}
+ (int)ROW_TYPE_FILTER
{
	return ROW_TYPE_FILTER;
}
+ (int)ROW_TYPE_DATA
{
	return ROW_TYPE_DATA;
}
+ (int)ROW_TYPE_FILL
{
	return ROW_TYPE_FILL;
}
+ (int)ROW_TYPE_RENDERER
{
	return ROW_TYPE_RENDERER;
}
+ (int)ROW_TYPE_COLUMN_GROUP
{
	return ROW_TYPE_COLUMN_GROUP;
}
@end

