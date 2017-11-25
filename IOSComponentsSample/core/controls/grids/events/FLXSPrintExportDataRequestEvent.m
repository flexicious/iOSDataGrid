#import "FLXSPrintExportDataRequestEvent.h"
static NSString * PRINT_EXPORT_DATA_REQUEST = @"printExportDataRequest";
static NSString * PRINT_EXPORT_DATA_RECD = @"printExportDataReceived";

@implementation FLXSPrintExportDataRequestEvent


-(id)initWithType:(NSString*)type :(FLXSFilter *)filter :(BOOL)bubbles :(BOOL)cancelable
{
	self = [super initWithType:type :filter :bubbles :cancelable];
	if (self)
	{
	}
	return self;
}


-(FLXSEvent*)clone
{
	return [[FLXSPrintExportDataRequestEvent alloc] initWithType:self.type :(FLXSPrintExportFilter *) self.filter :self.bubbles :self.cancelable];
}
/**
 * Dispatched only in server mode, when the grid needs to print or export more data than is currently
 * loaded in memory.
 */
+ (NSString*)PRINT_EXPORT_DATA_REQUEST
{
	return PRINT_EXPORT_DATA_REQUEST;
}
/**
     * Dispatched only in server mode, when the grid needs to print or export more data than is currently
     * loaded in memory.
     * Event Type:com.flexicious.grids.events.PrintExportDataRequestEvent
     */

+ (NSString*)PRINT_EXPORT_DATA_RECD
{
	return PRINT_EXPORT_DATA_RECD;
}
@end

