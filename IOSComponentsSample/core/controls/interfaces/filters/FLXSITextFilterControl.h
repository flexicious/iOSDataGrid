#import "FLXSVersion.h"
/**
	 * To be implemented by TextInput, TextArea, etc.
	 * To be used filter mechanism to setup text filter, e.g. user.FirstName begins with XYZ
	 */
@protocol FLXSITextFilterControl   <FLXSIFilterControl>
-(NSString*)text;
@end

