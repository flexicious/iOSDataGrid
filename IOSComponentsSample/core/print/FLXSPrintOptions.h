//#import "FLXSVersion.h"
//#import "FLXSClassFactory.h"
//#import "FLXSIExtendedDataGrid.h"
//@class FLXSPageSize;
//@protocol FLXSIPrintPreview;
//@protocol FLXSIPrintDatagrid;
//@protocol FLXSIPrintable;
//@protocol FLXSIPrintComponent;
//
//@interface FLXSPrintOptions : FLXSPrintExportOptions
//{
//}
//
//@property (nonatomic, assign) BOOL preview;
//@property (nonatomic, assign) BOOL wasPreview;
//@property (nonatomic, strong) UIView<FLXSIPrintPreview>* previewWindow;
//@property (nonatomic, assign) BOOL printToPdf;
//@property (nonatomic, strong) NSMutableArray* printedPages;
//@property (nonatomic, strong) FLXSPageSize* pageSize;
//@property (nonatomic, strong) FLXSClassFactory* reportHeaderRenderer;
//@property (nonatomic, strong) FLXSClassFactory* reportFooterRenderer;
//@property (nonatomic, strong) FLXSClassFactory* pageHeaderRenderer;
//@property (nonatomic, strong) FLXSClassFactory* pageFooterRenderer;
//@property (nonatomic, strong) FLXSClassFactory* printComponentRenderer;
//@property (nonatomic, strong) FLXSClassFactory* printOptionsViewrenderer;
//@property (nonatomic, strong) FLXSClassFactory* printPreviewViewrenderer;
//@property (nonatomic, strong) NSMutableArray* availableColumns;
//@property (nonatomic, strong) NSMutableArray* columnsToPrint;
//@property (nonatomic, strong) NSMutableArray* columnWidths;
//@property (nonatomic, assign) BOOL includePageHeader;
//@property (nonatomic, assign) BOOL includePageFooter;
//@property (nonatomic, assign) BOOL includePrintHeader;
//@property (nonatomic, assign) BOOL includePrintFooter;
//@property (nonatomic, strong) NSObject* printExportParameters;
//@property (nonatomic, assign) BOOL modalWindows;
//@property (nonatomic, assign) BOOL printAsBitmap;
//@property (nonatomic, strong) UIView* printContainer;
//@property (nonatomic, strong) UIView<FLXSIPrintable>* printable;
//@property (nonatomic, strong) UIView<FLXSIPrintComponent>* printComponent;
//@property (nonatomic, strong) NSMutableDictionary* windowStyleProperties;
//@property (nonatomic, strong) NSArray* propertiesToTransfer;
//@property (nonatomic, strong) NSArray* stylesToTransfer;
//@property (nonatomic, assign) BOOL includeInvisibleColumns;
//@property (nonatomic, assign) BOOL asynch;
//@property (nonatomic, assign) int asynchTimeInterval;
//@property (nonatomic, assign) BOOL asynchDelayCapture;
//
//
//-(FLXSClassFactory*)printDataGridRenderer;
//
//- (void)loadFromPersistedString:(FLXSFlexDataGrid *)grid value:(NSString *)val;
//-(NSString*)toPersistenceString:(FLXSFlexDataGrid*)grid;
//+(FLXSPrintOptions*)create:(BOOL)toPdf;
//@end
//
