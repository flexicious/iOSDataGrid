#import "FLXSFilterExpression.h"
#import "FLXSIFilterControl.h"
#import "FLXSVersion.h"
/**
* This is a type of a filter control that contains its own
* logic to determine whether or not the given object matches
* the filter criteria it encapsulates.  It will only work in
* filterPageSortMode="client", since in server mode, the expression
* will be blank.
* FilterExpression.
*/
@protocol FLXSICustomMatchFilterControl      <FLXSIFilterControl>
-(BOOL)isMatch:(NSObject*)item;
@end

