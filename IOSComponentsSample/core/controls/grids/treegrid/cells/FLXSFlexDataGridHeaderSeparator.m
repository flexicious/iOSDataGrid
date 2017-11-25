#import "FLXSFlexDataGridHeaderSeperator.h"

@implementation FLXSFlexDataGridHeaderSeparator

@synthesize resizing;

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
    self.resizing=NO;
}



@end

