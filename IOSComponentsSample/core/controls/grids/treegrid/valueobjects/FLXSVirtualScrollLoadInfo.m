#import "FLXSVirtualScrollLoadInfo.h"
#import "FLXSRowPositionInfo.h"
#import "FLXSFlexDataGridColumnLevel.h"

@implementation FLXSVirtualScrollLoadInfo

@synthesize level;
@synthesize recordIndex;
@synthesize verticalScrollPosition;
@synthesize itemHeight;
@synthesize item;
@synthesize parent;
@synthesize rowType;

- (id)initWithLevel:(FLXSFlexDataGridColumnLevel *)levelIn
     andRecordIndex:(int)recordIndexIn
andVerticalScrollPosition:(float)verticalScrollPositionIn
      andItemHeight:(float)itemHeightIn
            andItem:(NSObject *)itemIn
          andParent:(NSObject *)parentIn
         andRowType:(int)rowTypeIn {
	self = [super init];
	if (self)
	{
		self.level=levelIn;
		self.recordIndex=recordIndexIn;
		self.verticalScrollPosition=verticalScrollPositionIn;
		self.item=itemIn;
		self.itemHeight=itemHeightIn;
		self.parent=parentIn;
		if(rowTypeIn==-1)
			self.rowType=[FLXSRowPositionInfo ROW_TYPE_DATA];
		else
            self.rowType=rowTypeIn;
	}
	return self;
}


-(int)levelNestDepth
{
    return level.nestDepth;
    
}

-(float)itemArea
{
    return level.rowHeight+itemHeight;

}

-(BOOL)isParentOf:(FLXSVirtualScrollLoadInfo*)child
{
	return (child.verticalScrollPosition+child.itemArea>self.verticalScrollPosition)
&& (child.verticalScrollPosition<self.verticalScrollPosition+self.itemArea)
&& child.levelNestDepth>self.levelNestDepth;
}

@end

