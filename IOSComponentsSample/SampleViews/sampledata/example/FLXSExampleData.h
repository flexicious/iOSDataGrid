@class iPadExampleViewControllerBase;

@interface FLXSExampleData : NSObject
@property(nonatomic, strong) NSString *identifier;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *descriptionInformation;
@property(nonatomic, strong) iPadExampleViewControllerBase *viewController;

- (id) initWithIdentifier:(NSString *)identifier
andDescriptionInformation :(NSString *)descriptionInformation
                  andName:(NSString *)name
        andViewController:(iPadExampleViewControllerBase *)viewController;
@end