//#import "FLXSPrintExportOptions.h"
//#import "FLXSPrintOptions.h"
//#import "FLXSPageSize.h"
//
//
//@interface NameValue : NSObject
//@property (nonatomic, strong)NSString* name;
//-(id)initWithName:(NSString*)name1;
//@end
//
//@implementation NameValue
//@synthesize name;
//
//
//-(id)initWithName:(NSString *)name1{
//    self = [super init];
//    if(self) {
//        self.name = name1;
//    }
//
//    return self;
//}
//
//@end
//
//@implementation FLXSPrintOptions {
//@private
//    BOOL _preview;
//    BOOL _wasPreview;
//    UIView <FLXSIPrintPreview> *_previewWindow;
//    BOOL _printToPdf;
//    NSMutableArray *_printedPages;
//    FLXSPageSize *_pageSize;
//    FLXSClassFactory *_reportHeaderRenderer;
//    FLXSClassFactory *_reportFooterRenderer;
//    FLXSClassFactory *_pageHeaderRenderer;
//    FLXSClassFactory *_pageFooterRenderer;
//    FLXSClassFactory *_printComponentRenderer;
//    FLXSClassFactory *_printOptionsViewrenderer;
//    FLXSClassFactory *_printPreviewViewrenderer;
//    NSMutableArray *_availableColumns;
//    NSMutableArray *_columnsToPrint;
//    NSMutableArray *_columnWidths;
//    BOOL _includePageHeader;
//    BOOL _includePageFooter;
//    BOOL _includePrintHeader;
//    BOOL _includePrintFooter;
//    NSObject *_printExportParameters;
//    BOOL _modalWindows;
//    BOOL _printAsBitmap;
//    UIView *_printContainer;
//    UIView <FLXSIPrintable> *_printable;
//    UIView <FLXSIPrintComponent> *_printComponent;
//    NSMutableDictionary *_windowStyleProperties;
//    NSArray *_propertiesToTransfer;
//    NSArray *_stylesToTransfer;
//    BOOL _includeInvisibleColumns;
//    BOOL _asynch;
//    int _asynchTimeInterval;
//    BOOL _asynchDelayCapture;
//    FLXSPrintOptions *_printOptions;
//    FLXSPrintOptions *_pdfOptions;
//    FLXSExportOptions *_excelOptions;
//    FLXSExportOptions *_wordOptions;
//}
//
//
//@synthesize preview = _preview;
//@synthesize wasPreview = _wasPreview;
//@synthesize previewWindow = _previewWindow;
//@synthesize printToPdf = _printToPdf;
//@synthesize printedPages = _printedPages;
//@synthesize pageSize = _pageSize;
//@synthesize reportHeaderRenderer = _reportHeaderRenderer;
//@synthesize reportFooterRenderer = _reportFooterRenderer;
//@synthesize pageHeaderRenderer = _pageHeaderRenderer;
//@synthesize pageFooterRenderer = _pageFooterRenderer;
//@synthesize printComponentRenderer = _printComponentRenderer;
//@synthesize printOptionsViewrenderer = _printOptionsViewrenderer;
//@synthesize printPreviewViewrenderer = _printPreviewViewrenderer;
//@synthesize availableColumns = _availableColumns;
//@synthesize columnsToPrint = _columnsToPrint;
//@synthesize columnWidths = _columnWidths;
//@synthesize includePageHeader = _includePageHeader;
//@synthesize includePageFooter = _includePageFooter;
//@synthesize includePrintHeader = _includePrintHeader;
//@synthesize includePrintFooter = _includePrintFooter;
//@synthesize printExportParameters = _printExportParameters;
//@synthesize modalWindows = _modalWindows;
//@synthesize printAsBitmap = _printAsBitmap;
//@synthesize printContainer = _printContainer;
//@synthesize printable = _printable;
//@synthesize printComponent = _printComponent;
//@synthesize windowStyleProperties = _windowStyleProperties;
//@synthesize propertiesToTransfer = _propertiesToTransfer;
//@synthesize stylesToTransfer = _stylesToTransfer;
//@synthesize includeInvisibleColumns = _includeInvisibleColumns;
//@synthesize asynch = _asynch;
//@synthesize asynchTimeInterval = _asynchTimeInterval;
//@synthesize asynchDelayCapture = _asynchDelayCapture;
//
//
//-(id)init
//{
//	self = [super init];
//	if (self)
//	{
//		self.preview = YES;
//        self.wasPreview = YES;
//        self.printToPdf = NO;
//        self.printedPages = [[NSMutableArray alloc] init];
//        self.pageSize = [FLXSPageSize.PAGE_SIZE_LETTER clone];
////next version
////        self.reportHeaderRenderer = [[FLXSClassFactory alloc] init:PrinterHeader];
////        self.reportFooterRenderer = [[FLXSClassFactory alloc] init:PrinterFooter];#import "FLXSIPrintable.h"
////        self.pageHeaderRenderer = [[FLXSClassFactory alloc] init:PageHeader];
////        self.pageFooterRenderer = [[FLXSClassFactory alloc] init:PageHeader];
////        self.printOptionsViewrenderer = [[FLXSClassFactory alloc] init:PrintOptionsView];
////        self.printPreviewViewrenderer = [[FLXSClassFactory alloc] init:PrintPreview];
//        self.availableColumns = [[NSMutableArray alloc] init];
//        self.columnsToPrint = [[NSMutableArray alloc] init];
//        self.columnWidths = [[NSMutableArray alloc] init];
//        self.includePageHeader = YES;
//        self.includePageFooter = YES;
//        self.includePrintHeader = YES;
//        self.includePrintFooter = YES;
//        self.modalWindows = YES;
//        self.printAsBitmap = NO;
//        self.windowStyleProperties = [[NSMutableDictionary alloc] init];
//        self.propertiesToTransfer = [[NSMutableArray alloc] init];
//        self.stylesToTransfer = [[NSArray alloc] initWithObjects:@"textAlign",nil];
//        self.includeInvisibleColumns = YES;
//        self.asynch = NO;
//        self.asynchTimeInterval = 1;
//        self.asynchDelayCapture = NO;
//
////		windowStyleProperties[@"backgroundColor"]=@"#FFFFFF";#import "FLXSIPDFPrinter.h"
////		windowStyleProperties[@"paddingTop"]=@"20";
////		windowStyleProperties[@"paddingBottomFLXS"]=@"20";
////		windowStyleProperties[@"paddingLeft"]=@"20";
////		windowStyleProperties[@"paddingRight"]=@"20";
//	}
//	return self;
//}
//
//-(FLXSFlexDataGrid*)extendedDataGrid
//{
//	return (FLXSFlexDataGrid*)self.printable;
//}
//
//-(void)setExtendedDataGrid:(FLXSFlexDataGrid*)val
//{
//    self.printable = (UIView<FLXSIPrintable>*)val;
//}
//
//-(UIView<FLXSIPrintDatagrid>*)printDataGrid
//{
//	return (UIView<FLXSIPrintDatagrid>*)self.printComponent;
//}
//
//-(void)setPrintDataGrid:(UIView<FLXSIPrintDatagrid>*)val
//{
//    self.printComponent =(UIView<FLXSIPrintComponent>*)val;
//}
//
//- (void)loadFromPersistedString:(FLXSFlexDataGrid *)grid value:(NSString *)val {
//    NSArray* parts=[val componentsSeparatedByString:(@"~/")];
//    if([parts count]==8)
//    {
//        NSArray* cols= [FLXSUIUtils fromPersistenceString:[parts objectAtIndex:0]];
//        for(NSString* col in cols)
//        {
//            [_columnsToPrint addObject:[[NameValue alloc] initWithName:col]];
//        }
//        cols= [FLXSUIUtils fromPersistenceString:[parts objectAtIndex:1]];
//        for(NSString* col in cols)
//        {
//            [_columnWidths addObject:[self parseInt:col]];
//        }
//        _includePageFooter=[[parts objectAtIndex:2] isEqual:@"y"];
//        _includePageHeader=[[parts objectAtIndex:3] isEqual:@"y"];
//        _includePrintFooter=[[parts objectAtIndex:4] isEqual:@"y"];
//        _includePrintFooter=[[parts objectAtIndex:5] isEqual:@"y"];
//        _pageSize = [FLXSPageSize getByName:[parts objectAtIndex:6]];
//        _pageSize.isLandscape=[[parts objectAtIndex:7] isEqual:@"y"];
//        ;
//    }
//}
//-(NSNumber*)parseInt:(NSString*)string{
//    return [NSNumber numberWithInt:[string integerValue]];
//}
//-(NSString*)toPersistenceString:(FLXSFlexDataGrid*)grid
//{
//    NSString* buffer=@"";
//    NSMutableArray* colsToPrint = [[NSMutableArray alloc] init];
//    for(NameValue* item in _columnsToPrint)
//    {
//        [colsToPrint addObject:item.name];
//    }
//    NSString* delim=@"~/";
//    buffer= [[ buffer stringByAppendingString:[FLXSUIUtils toPersistenceString:colsToPrint]] stringByAppendingString:delim];
//    buffer= [[buffer stringByAppendingString:[FLXSUIUtils toPersistenceString:_columnWidths]] stringByAppendingString:delim];
//    buffer= [[buffer stringByAppendingString:(self.includePageFooter?@"y":@"n")] stringByAppendingString:delim];
//    buffer= [[buffer stringByAppendingString:(self.includePageHeader?@"y":@"n")] stringByAppendingString:delim];
//    buffer= [[buffer stringByAppendingString:(self.includePrintFooter?@"y":@"n")] stringByAppendingString:delim];
//    buffer= [[buffer stringByAppendingString:(self.includePrintFooter?@"y":@"n")] stringByAppendingString:delim];
//    buffer= [[buffer stringByAppendingString:self.pageSize.name]  stringByAppendingString:delim];
//    buffer= [buffer stringByAppendingString:(self.pageSize.isLandscape?@"y":@"n")];
//    return buffer;
//}
//
//+(FLXSPrintOptions*)create:(BOOL)toPdf
//{
//	FLXSPrintOptions* printOptions = [[FLXSPrintOptions alloc] init];
//	printOptions.printToPdf=toPdf;
//	return printOptions;
//}
//
//@end
//
