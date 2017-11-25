//#import "FLXSVersion.h"
//#import "FLXSFlexDataGrid.h"
//@class FLXSPrintOptions;
//@protocol FLXSIPrintComponent;
//@class FLXSClassFactory;
//@protocol FLXSIPrintDatagrid;
//@protocol FLXSIPrintArea;
//@protocol FLXSIExtendedDataGrid;
//@protocol FLXSIPrintable;
//@class FLXSEvent;
//
//@interface PrintWindow : UIView
//{
//
//}
//
//@property (nonatomic, strong) NSMutableArray* rowsOnPage;
//@property (nonatomic, weak) FLXSPrintOptions* printOptions;
//@property (nonatomic, strong) UIView <FLXSIPrintComponent>* printComponent;
//@property (nonatomic, strong) UIView <FLXSIPrintable>* printable;
//@property (nonatomic, strong) FLXSClassFactory* printComponentRenderer;
//@property (nonatomic, assign) BOOL printDataGridDirty;
//@property (nonatomic, strong) UIView<FLXSIPrintArea>* printerHeader;
//@property (nonatomic, strong) FLXSClassFactory* reportHeaderRenderer;
//@property (nonatomic, assign) BOOL printerHeaderDirty;
//@property (nonatomic, strong) UIView<FLXSIPrintArea>* printerFooter;
//@property (nonatomic, strong) FLXSClassFactory* reportFooterRenderer;
//@property (nonatomic, assign) BOOL printerFooterDirty;
//@property (nonatomic, strong) UIView<FLXSIPrintArea>* pageHeader;
//@property (nonatomic, strong) FLXSClassFactory* pageHeaderRenderer;
//@property (nonatomic, assign) BOOL pageHeaderDirty;
//@property (nonatomic, strong) UIView<FLXSIPrintArea>* pageFooter;
//@property (nonatomic, strong) FLXSClassFactory* pageFooterRenderer;
//@property (nonatomic, assign) BOOL pageFooterDirty;
//@property (nonatomic, assign) int currentPage;
//@property (nonatomic, assign) BOOL pageRecordsDirty;
//@property (nonatomic, assign) int totalPages;
//@property (nonatomic, assign) int firstPageRowCount;
//@property (nonatomic, assign) int middlePageRowCount;
//@property (nonatomic, strong) NSString* showing;
//
//
//-(void)createChildren;
//-(void)removeIfExists:(NSObject*)val;
//-(UIView<FLXSIPrintArea>*)printerHeader;
//-(void)printerHeader:(UIView<FLXSIPrintArea>*)val;
//-(FLXSClassFactory*)reportHeaderRenderer;
//-(void)reportHeaderRenderer:(FLXSClassFactory*)val;
//-(UIView<FLXSIPrintArea>*)printerFooter;
//-(void)printerFooter:(UIView<FLXSIPrintArea>*)val;
//-(FLXSClassFactory*)reportFooterRenderer;
//-(void)reportFooterRenderer:(FLXSClassFactory*)val;
//-(UIView<FLXSIPrintArea>*)pageFooter;
//-(void)pageFooter:(UIView<FLXSIPrintArea>*)val;
//-(FLXSClassFactory*)pageFooterRenderer;
//-(void)pageFooterRenderer:(FLXSClassFactory*)val;
//-(FLXSClassFactory*)pageHeaderRenderer;
//-(void)pageHeaderRenderer:(FLXSClassFactory*)val;
//-(UIView<FLXSIPrintArea>*)pageHeader;
//-(void)pageHeader:(UIView<FLXSIPrintArea>*)val;
//-(UIView<FLXSIPrintComponent>*)printComponent;
//-(void)printComponent:(UIView<FLXSIPrintComponent>*)val;
//-(UIView<FLXSIPrintDatagrid>*)printDataGrid;
//-(FLXSClassFactory*)printComponentRenderer;
//-(void)printComponentRenderer:(FLXSClassFactory*)val;
//-(void)commitProperties;
//-(int)getPageStart;
//-(int)getPageEnd;
//-(void)callValidate;
//-(float)getGridHeight;
//-(void)showFirstPage:(BOOL)validate;
//-(void)showLastPage:(BOOL)validate;
//-(void)showMiddlePage:(BOOL)validate;
//-(void)showSinglePage:(BOOL)validate;
//
//- (void)showHide:(NSObject *)val showHide:(BOOL)showHide;
//-(int)currentPage;
//-(void)currentPage:(int)val;
//-(int)totalPages;
//-(void)totalPages:(int)val;
//-(FLXSFlexDataGrid*)extendedDataGrid;
//-(void)extendedDataGrid:(FLXSFlexDataGrid*)val;
//-(UIView<FLXSIPrintable>*)printable;
//-(void)printable:(UIView<FLXSIPrintable>*)val;
//-(void)printOptions:(FLXSPrintOptions*)val;
//-(FLXSPrintOptions*)printOptions;
//-(NSArray*)printAreas;
//-(void)onColumnResize:(FLXSEvent*)event;
//-(void)onItemOpen:(FLXSEvent*)event;
//
//@end
//
