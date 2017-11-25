#import "FLXSExportOptions.h"
#import "FLXSCsvExporter.h"
#import "FLXSDocExporter.h"
#import "FLXSTxtExporter.h"
#import "FLXSXmlExporter.h"
#import "FLXSExportOptionsViewController.h"

static const int CSV_EXPORT = 0;
static const int DOC_EXPORT = 1;
static const int HTML_EXPORT = 2;
static const int TXT_EXPORT = 3;

@implementation FLXSExportOptions {

@private
    NSString *_exportFilePath;
}

@synthesize echoUrl = _echoUrl;
@synthesize exporters = _exporters;
@synthesize exportOptionsRenderer = _exportOptionsRenderer;
@synthesize exportOptionsView = _exportOptionsView;
@synthesize exporter = _exporter;
@synthesize useSaveFileMessage = _useSaveFileMessage;
@synthesize enableLocalFilePersistence = _enableLocalFilePersistence;
@synthesize copyToClipboard = _copyToClipboard;
@synthesize exportFileName = _exportFileName;
@synthesize printExportParameters = _printExportParameters;
@synthesize modalWindows = _modalWindows;
@synthesize tableWidth = _tableWidth;
@synthesize exportAllRecords = _exportAllRecords;
@synthesize useExcelExporter = _useExcelExporter;
@synthesize availableColumns = _availableColumns;
@synthesize columnsToExport = _columnsToExport;
@synthesize exportCollapsedRows = _exportCollapsedRows;
@synthesize grid = _grid;
@synthesize includeFooters = _includeFooters;

@synthesize exportFilePath = _exportFilePath;

-(id)init
{
	self = [super init];
	if (self)
	{
        self.echoUrl = @"http://www.flexicious.com/Home/Echo";

        self.exporters = [[NSMutableArray alloc] initWithObjects: [[FLXSCsvExporter alloc] init],
                [[FLXSDocExporter alloc] init],[[FLXSHtmlExporter alloc] init],[[FLXSTxtExporter alloc] init],
                [[FLXSXmlExporter alloc] init],nil];

        self.exportOptionsRenderer = [[FLXSClassFactory alloc] initWithNibName:@"FLXSExportOptionsViewController"
                                                            andControllerClass:[FLXSExportOptionsViewController class]
                                                                withProperties:nil];

        if(![FLXSUIUtils isIPad]){
            self.exportOptionsRenderer = [[FLXSClassFactory alloc] initWithNibName:@"FLXSiPhoneExportOptionsViewController"
                                                                andControllerClass:[FLXSExportOptionsViewController class]
                                                                    withProperties:nil];
        }

        self.exporter = [self.exporters objectAtIndex:0];
        self.useSaveFileMessage = NO;
        self.enableLocalFilePersistence = YES;
		self.copyToClipboard = NO;
        self.exportFileName = @"download";
        self.tableWidth = 0;
        self.exportAllRecords = NO;
        self.useExcelExporter = NO;
        self.availableColumns = [[NSMutableArray alloc] init];
        self.columnsToExport = [[NSMutableArray alloc] init];
        self.exportCollapsedRows = NO;
        self.includeFooters = NO;
        self.modalWindows=YES;

	}
	return self;
}

-(NSString*)exporterName
{
	return self.exporter.name;
}

+(FLXSExportOptions*)create:(int)exporterIndex
{
    FLXSExportOptions* myExportOptions = [[FLXSExportOptions alloc] init];
	myExportOptions.exporter = myExportOptions.exporters[exporterIndex];
	return myExportOptions;
}

+ (int)CSV_EXPORT
{
	return CSV_EXPORT;
}
+ (int)DOC_EXPORT
{
	return DOC_EXPORT;
}
+ (int)HTML_EXPORT
{
	return HTML_EXPORT;
}
+ (int)TXT_EXPORT
{
	return TXT_EXPORT;
}
@end

