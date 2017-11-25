#import "FLXSISelectFilterControl.h"
#import "FLXSVersion.h"
/**
* A control that has a list of values to choose from, but user can only choose 1 value
* Implemented by ComboBoxes and RadioButton Lists
* to enable them to participate in the Filtering Infrastructure.
*/
@protocol FLXSISingleSelectFilterControl  <FLXSISelectFilterControl>
-(NSObject*)selectedItem;
@end

