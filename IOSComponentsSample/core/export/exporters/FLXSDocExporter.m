#import "FLXSDocExporter.h"
#import "FLXSConstants.h"

@implementation FLXSDocExporter


-(NSString*)contentType
{
    return @"application/msword";
}

-(NSString*)name
{
    return [FLXSConstants PGR_EXPORT_TO_WORD];
}

-(NSString*)extension
{
    return @"doc";
}
@end

