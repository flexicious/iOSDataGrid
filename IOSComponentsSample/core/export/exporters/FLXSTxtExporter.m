#import "FLXSTxtExporter.h"
#import "FLXSFlexDataGridColumn.h"
#import "FLXSConstants.h"

@implementation FLXSTxtExporter
-(id)init
{
	self = [super init];
	if (self)
	{
	}
	return self;
}



-(NSString*)writeHeader:(FLXSFlexDataGrid*)grid
{
    return [[self buildHeader:grid] stringByAppendingString:@"\r\n"];
            
}

-(NSString*)buildHeader:(FLXSFlexDataGrid*)grid
{
	NSString* str=@"";
	int colIndex=0;
	for(FLXSFlexDataGridColumn* col in grid.exportableColumns)
	{
		if(![self isIncludedInExport:col])continue;
        str  =[[str stringByAppendingString:[FLXSExporter getColumnHeader:col colIndex:(colIndex++)]] stringByAppendingString:@"\t"];
	}
	return str;
}

- (NSString *)writeRecord:(FLXSFlexDataGrid *)grid record:(NSObject *)record {
	NSString* str=@"";
	for(FLXSFlexDataGridColumn* col in grid.exportableColumns)
	{
		if(![self isIncludedInExport:col])continue;
        str  =[[str stringByAppendingString:[col itemToLabel:record:nil]] stringByAppendingString:@"\t"];
	}
	if(str.length>0){
        NSRange range = {0, (str.length-1)};
        str = [str substringWithRange:range];
        }
    str =[str stringByAppendingString:@"\r\n"];
	return str;
}

-(NSString*)writeFooter:(FLXSFlexDataGrid*)grid
{
	return @"";
}

-(NSString*)contentType
{
    return @"text/plain";
}

-(NSString*)name
{
    return [FLXSConstants PGR_EXPORT_TO_TEXT];
}

-(NSString*)extension
{
	return @"txt";
}
@end

