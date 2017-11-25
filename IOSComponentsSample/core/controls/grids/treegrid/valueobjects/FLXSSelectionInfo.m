#import "FLXSSelectionInfo.h"
#import "FLXSLevelSelectionInfo.h"


@implementation FLXSSelectionInfo

@synthesize levelSelections;
@synthesize isSelectAll;

-(BOOL)hasAnySelections
{
    for (FLXSLevelSelectionInfo* level in levelSelections){
        if(level.selectedObjects.count>0)
            return YES;
        if(level.excludedObjects.count>0)
            return YES;

    }
    return NO;
}

@end

