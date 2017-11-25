#import "FLXSVersion.h"
#import "FLXSClassFactory.h"
/**
	 * A class that is used as a key to group renderers that belong to specific factory and subfactory.
	 */

@interface FLXSFactoryKey : NSObject
{

}

@property (nonatomic, strong) FLXSClassFactory * factory;
@property (nonatomic, strong) FLXSClassFactory * subFactory;

- (id)initWithFactory:(FLXSClassFactory *)factory andSubFactory:(FLXSClassFactory *)subFactory;

@end

