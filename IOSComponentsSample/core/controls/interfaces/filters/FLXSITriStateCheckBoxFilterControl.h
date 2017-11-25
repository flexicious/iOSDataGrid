#import "FLXSVersion.h"
/**
	 * Implemented by the Tristate checkbox
	 * to enable it to participate in the Filtering Infrastructure.
	 */
@protocol FLXSITriStateCheckBoxFilterControl         <FLXSIFilterControl>

@property (nonatomic, strong) NSString * selectedState;
@property (nonatomic, assign) BOOL allowUserToSelectMiddle;
@end

