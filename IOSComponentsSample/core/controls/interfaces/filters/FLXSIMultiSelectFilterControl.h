#import "FLXSISelectFilterControl.h"
#import "FLXSVersion.h"
/**
*	Implemented by the MultiSelectComboBox
*  to enable it to participate in the Filtering Infrastructure.
*
*/
@protocol FLXSIMultiSelectFilterControl      <FLXSISelectFilterControl>
-(NSArray*)selectedItems;
@end

