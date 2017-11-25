#import "FLXSInsertionLocationInfo.h"
#import "FLXSFlexDataGridHeaderContainer.h"
#import "FLXSRowPositionInfo.h"


@implementation FLXSInsertionLocationInfo

@synthesize contentX;
@synthesize headerX;
@synthesize contentY;
@synthesize leftLockedContentX;
@synthesize rightLockedContentX;
@synthesize leftLockedHeaderX;
@synthesize leftLockedHeaderY;
@synthesize rightLockedHeaderX;
@synthesize rightLockedHeaderY;
@synthesize leftLockedFooterX;
@synthesize leftLockedFooterY;
@synthesize rightLockedFooterX;
@synthesize rightLockedFooterY;


-(void)nextChromeRow:(FLXSFlexDataGridHeaderContainer*)row
{
	leftLockedContentX=rightLockedContentX=leftLockedHeaderX=leftLockedFooterX=rightLockedFooterX=rightLockedHeaderX=0;
	if(row.chromeType==[FLXSRowPositionInfo ROW_TYPE_HEADER]
		||row.chromeType==[FLXSRowPositionInfo ROW_TYPE_COLUMN_GROUP]
		||row.chromeType==[FLXSRowPositionInfo ROW_TYPE_FILTER]
		)
	{
		leftLockedHeaderY+=row.height;
		rightLockedHeaderY+=row.height;
	}
	else if(row.chromeType==[FLXSRowPositionInfo ROW_TYPE_FOOTER]||row.chromeType==[FLXSRowPositionInfo ROW_TYPE_PAGER])
	{
		leftLockedFooterY+=row.height;
		rightLockedFooterY+=row.height;
	}
}

-(void)reset
{
	self.contentX=0;
    self.contentY=0;
    self.leftLockedContentX=0;
    self.rightLockedContentX=0;
    self.leftLockedHeaderX=0;
    self.leftLockedHeaderY=0;
    self.rightLockedHeaderX=0;
    self.rightLockedHeaderY=0;
    self.leftLockedFooterX=0;
    self.leftLockedFooterY=0;
    self.rightLockedFooterX=0;
    self.rightLockedFooterY=0;
}

-(id)init
{
	self = [super init];
	if (self)
	{
        self.contentX = 0;
        self.headerX = 0;
        self.contentY = 0;
        self.leftLockedContentX = 0;
        self.rightLockedContentX = 0;
        self.leftLockedHeaderX = 0;
        self.leftLockedHeaderY = 0;
        self.rightLockedHeaderX = 0;
        self.rightLockedHeaderY = 0;
        self.leftLockedFooterX = 0;
        self.leftLockedFooterY = 0;
        self.rightLockedFooterX = 0;
        self.rightLockedFooterY = 0;

	}
	return self;
}


@end

