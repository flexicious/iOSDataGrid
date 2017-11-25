#import "FLXSMyPrintExportFilter.h"
#import "FLXSMyPrintExportOptions.h"
#import "FLXSDemoVersion.h"


@implementation FLXSMyPrintExportFilter

@synthesize printExportOptions;

-(id)initWithFilter:(FLXSPrintExportFilter *)filter
{
	self = [super initWithFilter:filter];
	if (self)
	{
		if(filter!=nil)
		{
			self.printExportOptions= [[FLXSMyPrintExportOptions alloc] initWithOptions:filter.printExportOptions];
		}
	}
	return self;
}


@end

