#import "FLXSWrapperEvent.h"


@implementation FLXSWrapperEvent

@synthesize data;

- (id)initWithType:(NSString *)type andData:(NSObject *)dataIn andBubbles:(BOOL)bubbles andCancelable:(BOOL)cancelable {
	self = [super initWithType:type
                 andCancelable:cancelable
                 andBubbles:bubbles];
	if (self)
	{
		self.data=dataIn;
	}
	return self;
}


-(FLXSEvent *)clone
{
	FLXSWrapperEvent * e = [[FLXSWrapperEvent alloc] initWithType:self.type andData:self.data andBubbles:self.bubbles andCancelable:self.cancelable];
	return e;
}

@end

