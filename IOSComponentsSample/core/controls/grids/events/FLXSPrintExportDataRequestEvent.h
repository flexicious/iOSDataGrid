#import "FLXSEvent.h"
#import "FLXSFilterPageSortChangeEvent.h"
#import "FLXSPrintExportFilter.h"
#import "FLXSVersion.h"

/**
	 * Event fired when the filter, page or sort state of the grid changes.
	 */
@interface FLXSPrintExportDataRequestEvent : FLXSFilterPageSortChangeEvent
{
}


-(id)initWithType:(NSString*)type :(FLXSFilter *)filter :(BOOL)bubbles :(BOOL)cancelable;
-(FLXSEvent*)clone;
/**
* Dispatched only in server mode, when the grid needs to print or export more data than is currently
* loaded in memory.
*/

+ (NSString*)PRINT_EXPORT_DATA_REQUEST;
+ (NSString*)PRINT_EXPORT_DATA_RECD;
@end

