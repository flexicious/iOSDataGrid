#import "FLXSHtmlExporter.h"
#import "FLXSFlexDataGridColumn.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSConstants.h"

@implementation FLXSHtmlExporter

-(NSString*)writeHeader:(FLXSFlexDataGrid*)grid
{
	NSString* str=@"";
	if(self.nestDepth>0)
    //str+=@"<tr><td colspan='"+(grid['currentExportLevel'][.parentLevel getExportableColumns:nil :NO :exportOptions].length+1)+@"'>";

    str = [str stringByAppendingString:@"<tr><td colspan='"];
    NSString *tablewidth = (self.exportOptions && self.exportOptions.tableWidth != 0.0) ? [NSString stringWithFormat:@"width='%f'",self.exportOptions.tableWidth] : @"";
    
    str = [str stringByAppendingFormat:@"<table %@><tr>%@</tr>\r\n", tablewidth, [self buildTh:grid]];
    //str = [[str stringByAppendingFormat:@"%i",(int)[[((FLXSFlexDataGridColumnLevel *) [grid valueForKey:@"currentExportLevel"]).parentLevel getExportableColumns:nil deep:NO options:self.exportOptions] count]+1] stringByAppendingString:@"'>"];
//todo hari
//    //str+=@"<table " +((exportOptions&&exportOptions.tableWidth)?@"width='"+exportOptions.tableWidth+@"'":@"")+@"><tr>" + [self buildTh:grid] + @"</tr>\r\n";
	if(self.nestDepth>0)
    str = [str  stringByAppendingString:@"</td></tr>"];
		return str;
}

-(NSString*)buildTh:(FLXSFlexDataGrid*)grid
{
	NSString* str=@"";
	int colIndex=0;
	if(self.nestDepth>0)
        str = [[[str stringByAppendingString:@"<th width='"] stringByAppendingFormat:@"%d",(self.nestDepth*self.nestIndent)] stringByAppendingString:@"'></th>"];
		for(FLXSFlexDataGridColumn* col in grid.exportableColumns)
	{
		if(![self isIncludedInExport:col])continue;
        str  =[[[str stringByAppendingString:@"<th>"] stringByAppendingString:[FLXSExporter getColumnHeader:col colIndex:(colIndex++)]] stringByAppendingString:@"</th>\r\n"];
	}
	return str;
}

- (NSString *)writeRecord:(FLXSFlexDataGrid *)grid record:(NSObject *)record {
	NSString* str=@"<tr>\r\n";
	if(self.nestDepth>0 && !self.reusePreviousLevelColumns)
        str = [[[str stringByAppendingString:@"<td width='"] stringByAppendingFormat:@"%d",(self.nestDepth*self.nestIndent)] stringByAppendingString:@"'></td>"];
		for(FLXSFlexDataGridColumn* col in grid.exportableColumns)
	{
		if(![self isIncludedInExport:col])continue;
        str  =[[[[str stringByAppendingString:@"<td>"] stringByAppendingString:[self getSpaces:col spChar:(@"&nbsp;")]] stringByAppendingString:[self escapeHtml:([col itemToLabel:record:nil])]] stringByAppendingString:@"</td>\r\n"];
	}
    str =[str stringByAppendingString:@"</tr>\r\n"];
	return str;
}

-(NSString*)escapeHtml:(NSString*)val
{
    //return val?val.replace("\"\n","\"").replace(/"/g,"\"\""):"";
    return val?[[val stringByReplacingOccurrencesOfString:@"\"\n" withString:@"\""] stringByReplacingOccurrencesOfString:@"\"" withString:@"\"\""]:@"";
}

-(NSString*)writeFooter:(FLXSFlexDataGrid*)grid
{
    return @"</table>\r\n";
}

-(NSString*)contentType
{
     return @"text/html";
}

-(NSString*)name
{
    return [FLXSConstants PGR_EXPORT_TO_HTML];
}

-(NSString*)extension
{
	return @"html";
}
@end
