#import "FLXSFactoryKey.h"


@implementation FLXSFactoryKey

@synthesize factory;
@synthesize subFactory;

- (id)initWithFactory:(FLXSClassFactory *)factoryIn andSubFactory:(FLXSClassFactory *)subFactoryIn {
	self = [super init];
	if (self)
	{
		self.factory=factoryIn;
		self.subFactory=subFactoryIn;
	}
	return self;
}


@end

