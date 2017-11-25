
#import "FLXSSortInfo.h"
#import "FLXSFlexDataGridColumn.h"


@implementation FLXSSortInfo {

}
@synthesize sortCol = _sortCol;
@synthesize sortAscending = _sortAscending;

- (id)initWithSortColumn:(FLXSFlexDataGridColumn *)sortCol andSortAscending:(BOOL)sortAscending {
    self = [super init];
    if (self)
    {
        self.sortCol=sortCol;
        self.sortAscending=sortAscending;
    }
    return self;
}

@end