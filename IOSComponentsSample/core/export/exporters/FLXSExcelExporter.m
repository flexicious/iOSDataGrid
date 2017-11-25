
#import "FLXSIExtendedDataGrid.h"
#import "FLXSExcelExporter.h"
#import "FLXSConstants.h"

@implementation FLXSExcelExporter


-(NSString*)extension
{
	return @"xls";
}

-(NSString*)name
{
    return [FLXSConstants PGR_EXPORT_TO_EXCEL];
}

-(NSString*)writeHeader:(FLXSFlexDataGrid*)grid
{

    NSString* str = @"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0f Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\n<style>\n</style>\n</head>\n<body>\n";
	return [ str stringByAppendingString:[[super writeHeader:grid] stringByReplacingOccurrencesOfString:@"<table " withString:@"<table border=1"]];
}

-(NSString*)writeFooter:(FLXSFlexDataGrid*)grid
{
	return [[super writeFooter:grid] stringByAppendingString:@"\n</body>\n</html>"];
}
@end

