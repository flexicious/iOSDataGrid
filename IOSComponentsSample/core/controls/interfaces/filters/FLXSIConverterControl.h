#import "FLXSIFilterControl.h"
#import "FLXSVersion.h"
/**
* In addition to being a filter control, also encapsulates
* the logic of performing the comparisions and actual matching
* of the filter criteria.
*/
@protocol FLXSIConverterControl        <FLXSIFilterControl>
-(NSObject*)convert:(NSString*)val;
@end

