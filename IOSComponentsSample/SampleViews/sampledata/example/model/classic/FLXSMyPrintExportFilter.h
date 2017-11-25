 #import "FLXSMyFilter.h"

@class FLXSPrintExportFilter;
@class FLXSMyPrintExportOptions;

@interface FLXSMyPrintExportFilter : FLXSMyFilter
{
}

@property (nonatomic, strong) FLXSMyPrintExportOptions* printExportOptions;

-(id)initWithFilter:(FLXSPrintExportFilter *)filter;

@end

