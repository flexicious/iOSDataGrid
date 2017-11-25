#import "FLXSPrintExportOptions.h"

static  NSString* PRINT_EXPORT_CURRENT_PAGE = @"Current Page";
static  NSString* PRINT_EXPORT_ALL_PAGES = @"All Pages";
static  NSString* PRINT_EXPORT_SELECTED_PAGES = @"Selected Pages";
static  NSString* PRINT_EXPORT_SELECTED_RECORDS = @"Selected Records";

@implementation FLXSPrintExportOptions

@synthesize printExportOption;
@synthesize pageFrom;
@synthesize pageTo;
@synthesize popupParent;
@synthesize showColumnPicker;
@synthesize showWarningMessage;
@synthesize hideHiddenColumns;
@synthesize excludeHiddenColumns;
@synthesize saveFileMessage;

-(id)init
{
	self = [super init];
	if (self)
	{
		printExportOption = FLXSPrintExportOptions.PRINT_EXPORT_CURRENT_PAGE;
		pageFrom = -1;
		pageTo = -1;
		showColumnPicker = YES;
		showWarningMessage = YES;
		hideHiddenColumns = NO;
		excludeHiddenColumns = NO;
		saveFileMessage = @"File generated. Download?";

	}
	return self;
}


+ (NSString*)PRINT_EXPORT_CURRENT_PAGE
{
	return PRINT_EXPORT_CURRENT_PAGE;
}
+ (NSString*)PRINT_EXPORT_ALL_PAGES
{
	return PRINT_EXPORT_ALL_PAGES;
}
+ (NSString*)PRINT_EXPORT_SELECTED_PAGES
{
	return PRINT_EXPORT_SELECTED_PAGES;
}
+ (NSString*)PRINT_EXPORT_SELECTED_RECORDS
{
	return PRINT_EXPORT_SELECTED_RECORDS;
}
@end

