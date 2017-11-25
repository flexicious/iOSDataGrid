#import "FLXSIExtendedDataGrid.h"
#import "FLXSCustomCsvExporter.h"
#import "FLXSFlexDataGridColumn.h"
@implementation FLXSCustomCsvExporter



-(NSString*)writeHeader:(FLXSFlexDataGrid*)grid
{

	return [[self buildHeader:grid] stringByAppendingString:@"\r\n"];
}

-(NSString*)buildHeader:(FLXSFlexDataGrid*)grid
{
	NSString* str=@"";
	int colIndex=0;
	int i=0;
	while(i++<self.nestDepth)
        str = [str stringByAppendingString:@","];
	for(FLXSFlexDataGridColumn* col in grid.exportableColumns)
	{
		if(![self isIncludedInExport:col])continue;
        str = [[str stringByAppendingString:[FLXSCustomCsvExporter escapeCsv:([FLXSExporter getColumnHeader:col colIndex:(colIndex++)])]] stringByAppendingString:@","];
	}
	//if([str indexOf:(@"ID")]==0)
    if([str rangeOfString:(@"ID")].location==0)
    {
		//http://support.microsoft.com/kb/323626
        str = [str stringByAppendingString:@""];
	}
	return str;
}

+(NSString*)escapeCsv:(NSString*)val
{
    return val? [[val stringByReplacingOccurrencesOfString:@"\"\n" withString:@"\""] stringByReplacingOccurrencesOfString:@"\"" withString:@"\"\""] :@"";
}

- (NSString *)writeRecord:(FLXSFlexDataGrid *)grid record:(NSObject *)record {
	NSString* str=@"";
	int i=0;
	if(!self.reusePreviousLevelColumns)
	{
		while(i++<self.nestDepth)
		{
            str = [str stringByAppendingString:@" ,"];
		}
	}
	for(FLXSFlexDataGridColumn* col in grid.exportableColumns)
	{
		if(![self isIncludedInExport:col])continue;
        str = [str stringByAppendingString:@"\""];
        str = [str stringByAppendingString:[self getSpaces:col spChar:@" "]];
         str =[ [str stringByAppendingString:[FLXSCustomCsvExporter escapeCsv:([col itemToLabel:record:nil])]] stringByAppendingString:@"\","];
	}
	if(str.length>0){
        NSRange range = {0,(str.length-1)};
        str = [str substringWithRange:range];
    }
    str = [str stringByAppendingString:@"\r\n"];
	return str;
}

-(NSString*)writeFooter:(FLXSFlexDataGrid*)grid
{
	return @"";
}

-(NSString*)contentType
{
    return @"application/vnd.ms-excel";
}

-(NSString*)name
{
    return @"Custom Excel";
}

-(NSString*)extension
{
	return @"csv";
}
@end

