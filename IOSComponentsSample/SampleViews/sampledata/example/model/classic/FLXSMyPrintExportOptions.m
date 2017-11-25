#import "FLXSMyPrintExportOptions.h"
#import "FLXSDemoVersion.h"


@implementation FLXSMyPrintExportOptions

@synthesize printExportOption;
@synthesize pageFrom;
@synthesize pageTo;

-(id)initWithOptions:(FLXSPrintExportOptions*)options
{
	self = [super init];
	if (self)
	{
		printExportOption = [FLXSPrintExportOptions PRINT_EXPORT_ALL_PAGES];
		pageFrom = -1;
		pageTo = -1;

		self.printExportOption = options.printExportOption;
		self.pageFrom = options.pageFrom;
		self.pageTo = options.pageTo;
	}
	return self;
}


@end

