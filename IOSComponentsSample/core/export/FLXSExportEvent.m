#import "FLXSExportEvent.h"

static NSString * BEFORE_EXPORT = @"beforeExport";
static NSString * AFTER_EXPORT = @"afterExport";

@implementation FLXSExportEvent

@synthesize exportOptions;
@synthesize textWritten;

+ (NSString*)BEFORE_EXPORT
{
	return BEFORE_EXPORT;
}
+ (NSString*)AFTER_EXPORT
{
	return AFTER_EXPORT;
}
@end

