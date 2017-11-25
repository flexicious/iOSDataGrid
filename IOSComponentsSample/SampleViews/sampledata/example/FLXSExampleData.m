#import "FLXSExampleData.h"
#import "iPadExampleViewControllerBase.h"

@implementation FLXSExampleData {
@private
    NSString *_identifier;
    NSString *_name;
    NSString *_descriptionInformation;
    iPadExampleViewControllerBase *_viewController;
}

@synthesize identifier = _identifier;
@synthesize name = _name;
@synthesize descriptionInformation = _descriptionInformation;
@synthesize viewController = _viewController;

- (id) initWithIdentifier:(NSString *)identifier
andDescriptionInformation :(NSString *)descriptionInformation
                  andName:(NSString *)name
        andViewController:(iPadExampleViewControllerBase *)viewController {
    self = [super init];
    if (self) {
        self.name = name;
        self.identifier = identifier;
        self.descriptionInformation = descriptionInformation;
        self.viewController = viewController;

    }
    return self;

}
-(NSString*) imageName {
    //return [@"FLXSSampleDemoTile" stringByAppendingString:self.identifier]; commented by hari
    return self.identifier;
}

@end