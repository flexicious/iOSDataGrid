#import "FLXSVersion.h"
@interface FLXSLevelSelectionInfo : NSObject
{
}

@property (nonatomic, assign) int levelNestDepth;
@property (nonatomic, strong) NSArray* selectedObjects;
@property (nonatomic, strong) NSArray* excludedObjects;


@end

