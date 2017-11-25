#import "FLXSFlexDataGridVirtualScrollEvent.h"
#import "FLXSFlexDataGrid.h"

static const NSString* VIRTUAL_SCROLL = @"virtualScroll";
@implementation FLXSFlexDataGridVirtualScrollEvent

@synthesize grid;
@synthesize recordsToLoad;

- (id)initWithType:(NSString *)type
           andGrid:(FLXSFlexDataGrid *)gridIn
  andRecordsToLoad:(NSArray *)recordsToLoadIn
        andBubbles:(BOOL)bubblesIn
     andCancelable:(BOOL)cancelableIn {
	self = [super initWithType:type
                 andCancelable:cancelableIn
                    andBubbles:bubblesIn
            ];
	if (self)
	{

		self.grid=gridIn;
		self.recordsToLoad=recordsToLoadIn;
	}
	return self;
}

+ (NSString*)VIRTUAL_SCROLL
{
	return [VIRTUAL_SCROLL description];
}
@end

