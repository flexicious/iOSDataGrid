#import "FLXSFilterExpression.h"
#import "FLXSVersion.h"
/**
* This is a type of a filter control that is responsible
* for building its own filter expression. This makes it
* possible to write a control that
*  FilterExpression.
*/
@protocol FLXSIDynamicFilterControl       <FLXSIFilterControl>
-(FLXSFilterExpression *)filterExpression;
@end

