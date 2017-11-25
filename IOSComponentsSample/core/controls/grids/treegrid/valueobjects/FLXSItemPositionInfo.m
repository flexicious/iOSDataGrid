#import "FLXSItemPositionInfo.h"
#import "FLXSFlexDataGridColumnLevel.h"


@implementation FLXSItemPositionInfo

@synthesize level;
@synthesize pageIndex;
@synthesize itemIndex;
@synthesize item;

- (id)initWithItem:(NSObject *)itemIn
          andLevel:(FLXSFlexDataGridColumnLevel *)levelIn
      andPageIndex:(int)pageIndexIn
      andItemIndex:(float)itemindexIn {
	self = [super init];
	if (self)
	{
		self.item=itemIn;
		self.level=levelIn;
		self.pageIndex=pageIndexIn;
		self.itemIndex=itemindexIn;
	}
	return self;
}

@end

