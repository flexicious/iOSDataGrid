#import "FLXSVersion.h"

@class FLXSComponentInfo;

@interface FLXSComponentAdditionResult : NSObject
{
}

@property (nonatomic, assign) BOOL horizontalSpill;
@property (nonatomic, assign) BOOL verticalSpill;
@property (nonatomic, weak) FLXSComponentInfo* componentInfo;


@end

