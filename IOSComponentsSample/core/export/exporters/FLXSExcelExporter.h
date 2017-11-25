#import "FLXSHtmlExporter.h"
#import "FLXSIExtendedDataGrid.h"
#import "FLXSVersion.h"

@interface FLXSExcelExporter : FLXSHtmlExporter

-(NSString*)writeHeader:(FLXSFlexDataGrid*)grid;
-(NSString*)writeFooter:(FLXSFlexDataGrid*)grid;
@end

