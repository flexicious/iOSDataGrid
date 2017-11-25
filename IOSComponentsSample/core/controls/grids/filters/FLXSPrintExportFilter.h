#import "FLXSVersion.h"

#import "FLXSFilter.h"

@class FLXSPrintExportOptions;
/**
	 * A class that extends the base filter object, but adds
	 * the additional properties, to store whether the user
	 * chose to print all pages, or specific pages of data.
	 *
	 * Please note, this is only required when the grid's
	 * filterPageSortMode is server.
	 */

@interface FLXSPrintExportFilter : FLXSFilter
{
}

@property (nonatomic, weak) FLXSPrintExportOptions* printExportOptions;


@end

