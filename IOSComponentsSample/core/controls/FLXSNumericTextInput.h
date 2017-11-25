#import "FLXSVersion.h"



#import <Foundation/Foundation.h>
#import "FLXSTextInput.h"
/**
 * A class that extends Text Input, but returns filter expressions where the
 * value is always an integer instead of text.
 * Restricts the input to integers.
 */

@interface FLXSNumericTextInput : FLXSTextInput
@end