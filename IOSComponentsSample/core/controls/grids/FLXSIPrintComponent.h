#import "FLXSVersion.h"
/**
	 * @private
	 * A component that represents a print version of a IPrintable
	 */

@protocol FLXSIPrintComponent
-(BOOL)validNextPage;
-(void)nextPage;
@end

