

#import "NSMutableArray+QueueAdditions.h"

@implementation NSMutableArray (QueueAdditions)
- (id) pop {
    // if ([self count] == 0) return nil; // to avoid raising exception (Quinn)
    id headObject = [self objectAtIndex:0];
    if (headObject != nil) {
         [self removeObjectAtIndex:0];
    }
    return headObject;
}

 - (void) push:(id)anObject {
    [self insertObject:anObject atIndex:0];
 }
@end