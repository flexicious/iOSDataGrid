#import "FLXSVersion.h"
/**
	 * Implemented by NumericRangeTextBox, Slider
	 * to enable them to participate in the Filtering Infrastructure.
	 */
@protocol FLXSIRangeFilterControl  <FLXSIFilterControl>
-(NSObject*)searchRangeStart;
-(NSObject*)searchRangeEnd;
@end

