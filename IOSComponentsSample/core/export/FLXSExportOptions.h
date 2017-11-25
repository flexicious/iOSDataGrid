#import "FLXSPrintExportOptions.h"
#import "FLXSClassFactory.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSVersion.h"

@class FLXSExporter;
@protocol FLXSIExtendedDataGrid;

@interface FLXSExportOptions : FLXSPrintExportOptions
{

}


@property (nonatomic, strong) NSString* echoUrl;
@property (nonatomic, strong) NSMutableArray* exporters;
@property (nonatomic, strong) FLXSClassFactory* exportOptionsRenderer;
@property (nonatomic, strong) UIView* exportOptionsView;
@property (nonatomic, weak) FLXSExporter*  exporter;
@property (nonatomic, assign) BOOL useSaveFileMessage;
@property (nonatomic, assign) BOOL enableLocalFilePersistence;
@property (nonatomic, assign) BOOL copyToClipboard;
@property (nonatomic, strong) NSString* exportFileName;
@property (nonatomic, strong) NSString* exportFilePath;

@property (nonatomic, strong) NSObject* printExportParameters;
@property (nonatomic, assign) BOOL modalWindows;
@property (nonatomic, assign) float tableWidth;
@property (nonatomic, assign) BOOL exportAllRecords;
@property (nonatomic, assign) BOOL useExcelExporter;
@property (nonatomic, strong) NSMutableArray* availableColumns;
@property (nonatomic, strong) NSMutableArray* columnsToExport;
@property (nonatomic, assign) BOOL exportCollapsedRows;
@property (nonatomic, weak) FLXSFlexDataGrid* grid;
@property (nonatomic, assign) BOOL includeFooters;

-(FLXSExporter*)exporter;
-(NSString*)exporterName;
+(FLXSExportOptions*)create:(int)exporterIndex;

+ (int)CSV_EXPORT;
+ (int)DOC_EXPORT;
+ (int)HTML_EXPORT;
+ (int)TXT_EXPORT;
@end

