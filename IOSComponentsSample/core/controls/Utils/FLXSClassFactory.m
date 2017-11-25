
#import "FLXSClassFactory.h"

@implementation FLXSClassFactory
-(id)initWithNibName:(NSString*)nibName andControllerClass:(Class)controllerClass withProperties:(NSMutableDictionary*)propertiesIn{
    self = [super init];
    if (self)
    {
        self.properties = propertiesIn;
        self.nibName  = nibName;
        self.generator = controllerClass;
    }
    return self;
}

-(id)initWithClass:(Class)generatorIn andProperties:(NSMutableDictionary*)propertiesIn{
    self = [super init];
    if (self)
    {
        self.properties = propertiesIn;
        self.generator  = generatorIn;

    }
    return self;
}
-(id)generateInstance{
    id instance=nil;
    if(self.nibName){
        UIViewController * vc =  [((UIViewController *)[self.generator alloc]) initWithNibName:self.nibName bundle:nil];
        instance = vc;

    }else{
        instance = [[self.generator alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    }

    for (NSString* key in self.properties){
        [instance setValue:[self.properties valueForKey:key] forKey:key];
    }
    return instance;
}
@synthesize generator;
@synthesize properties;
@end