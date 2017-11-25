#import "FLXSXmlExporter.h"
#import "FLXSFlexDataGridColumn.h"
#import "FLXSConstants.h"

@implementation FLXSXmlExporter
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
	NSString* str=@"";
    str =[str stringByAppendingString:@"<records>\r\n"];
	return str;
}

- (NSString *)writeRecord:(FLXSFlexDataGrid *)grid record:(NSObject *)record {
	NSString* str=@"<record\r\n ";
	for(FLXSFlexDataGridColumn* col in grid.exportableColumns)
	{
		if(![self isIncludedInExport:col])continue;
        str = [[[[str stringByAppendingString:[col.dataFieldFLXS stringByReplacingOccurrencesOfString:@"." withString:@""]] stringByAppendingString:@"='"] stringByAppendingString:[self escapeXml:([col itemToLabel:record:nil])]] stringByAppendingString: @"'\r\n"];
	}
    str  =[ str stringByAppendingString:@"/>\r\n"];
	return str;
}

-(NSString*)escapeXml:(NSString*)val
{
	//return val?[val replace:(@"\"\n") :(@"\"")][ replace:(/'/g) :(@"&quot;")][ replace:(/</g) :(@"&lt;")][ replace:(/>/g) :(@"&gt;")][ replace:(/&/g) :(@"&amp;")]
//:@"";
    
    
return  val?[[[[[val stringByReplacingOccurrencesOfString:@"\"\n" withString:@"\""] stringByReplacingOccurrencesOfString:@"'" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"] stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]:@"";
                                                        
    
    
}

-(NSString*)writeFooter:(FLXSFlexDataGrid*)grid
{
    			return @"</records>\r\n";
}

-(NSString*)contentType
{
    			return @"text/xml";
}

-(NSString*)name
{
    return [FLXSConstants PGR_EXPORT_TO_XML];
}

-(NSString*)extension
{
	return @"xml";
}
@end

