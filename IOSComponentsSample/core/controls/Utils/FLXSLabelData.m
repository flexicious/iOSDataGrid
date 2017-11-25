#import "FLXSLabelData.h"


@implementation FLXSLabelData {

@private
    NSString *_name;
}

@synthesize label;
@synthesize data;

@synthesize name = _name;

-(id)initWithLabel:(NSString *)labelIn andData:(NSString *)dataIn {
    self = [super init];
    if (self)
    {
        self.label=labelIn;
        self.data =dataIn;
    }
    return self;
}

@end