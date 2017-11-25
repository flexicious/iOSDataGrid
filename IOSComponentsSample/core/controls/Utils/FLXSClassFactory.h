#import "FLXSVersion.h"


@interface FLXSClassFactory : NSObject

-(id)initWithClass:(Class)generatorIn andProperties:(NSMutableDictionary*)propertiesIn;
-(id)initWithNibName:(NSString*)generatorIn andControllerClass:(Class)controllerClass  withProperties:(NSMutableDictionary*)propertiesIn;

-(id)generateInstance;

@property (nonatomic, assign) Class generator;
@property (nonatomic, strong) NSString* nibName;
@property (nonatomic, strong) NSMutableDictionary *  properties;
@property(nonatomic, strong) NSMutableArray* columns;


@end