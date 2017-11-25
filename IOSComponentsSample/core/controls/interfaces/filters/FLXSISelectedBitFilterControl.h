#import "FLXSVersion.h"
/**
	 * Implemented by CheckBoxes, TriStatecheckboxes and RadioButtonList
	 * to enable them to participate in the Filtering Infrastructure.
	 */
@protocol FLXSISelectedBitFilterControl       <FLXSIFilterControl>
-(BOOL)selected;
@end

