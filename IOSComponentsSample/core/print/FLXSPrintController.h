//#import "FLXSVersion.h"
//@class FLXSPrintOptions;
//@class FLXSPrintWindow;
//@protocol FLXSIExtendedDataGrid;
//@protocol FLXSIPrintable;
//@class FLXSEvent;
//@protocol FLXSIPrintPreview;
//@class FLXSFlexDataGrid;
//
//@interface FLXSPrintController : NSObject
//{
//}
//
//@property (nonatomic, weak) FLXSFlexDataGrid* extendedDataGrid;
//@property (nonatomic, weak) FLXSPrintWindow* printWindow;
//@property (nonatomic, weak) FLXSPrintOptions* printOptions;
//@property (nonatomic, assign) BOOL totalDirty;
//@property (nonatomic, assign) BOOL serverDataRetrieved;
//@property (nonatomic, strong) NSTimer* worker;
//@property (nonatomic, assign) BOOL pageShown;
//
//+(FLXSPrintController*)instance;
//
//-(FLXSPrintOptions*)printOptions;
//
//- (void)print:(UIView <FLXSIPrintable> *)printable printOptions:(FLXSPrintOptions *)printOptions;
//-(void)onPrintOptionsClose:(NSObject*)event;
//-(BOOL)checkColumn:(NSObject*)col :(FLXSPrintOptions*)printOptions;
//
//- (void)setupPrintWindow:(UIView <FLXSIPrintable> *)printable printOptions:(FLXSPrintOptions *)printOptions printWindow:(FLXSPrintWindow *)printWindow;
//-(void)cloneColumn:(NSArray*)cols :(NSObject*)col;
//
//- (void)calculateTotalPages:(NSObject *)iCollectionView hasColumnGroups:(BOOL)hasColumnGroups;
//
//- (BOOL)calculateSpillover:(FLXSPrintWindow *)printWindow printOptions:(FLXSPrintOptions *)printOptions iCollectionView:(NSObject *)iCollectionView whichPage:(NSString *)whichPage;
//
//- (FLXSPrintWindow *)createPrintWindow:(UIView <FLXSIPrintable> *)printable printOptions:(FLXSPrintOptions *)printOptions;
//-(FLXSPrintWindow*)instantiatePrintWindow;
//-(void)onPrintRequestDataRecieved:(FLXSEvent*)event;
//
//- (void)printWithOptions:(UIView <FLXSIPrintable> *)printable printOptions:(FLXSPrintOptions *)printOptions;
//-(void)onPrintWorkerTimer:(NSTimer*)event;
//-(void)printCurrentPage:(BOOL)add;
//-(void)onPrintWorkerTimerDelayedAsych:(NSTimer*)event;
//-(void)onPrintComplete;
//-(void)addCurrentPage;
//
//- (UIImage *)convertToImage:(UIView *)object printOptions:(FLXSPrintOptions *)printOptions;
//
//- (void)previewWithOptions:(UIView <FLXSIPrintable> *)printable printOptions:(FLXSPrintOptions *)printOptions;
//-(void)onPreviewClose:(FLXSEvent*)event;
//-(void)onPreviewPrintRequested:(FLXSEvent*)event;
//-(void)onPreviewPageOptionsChanged:(FLXSEvent*)event;
//-(void)onPreviewPageIndexChanged:(FLXSEvent*)event;
//-(void)onPreviewColumnsChanged:(FLXSEvent*)event;
//-(void)onDataGridColumnsResized:(FLXSEvent*)event;
//-(void)onDataGridRecreateRequest:(FLXSEvent*)event;
//
//- (void)generatePreview:(UIView <FLXSIPrintPreview> *)printPreview printWindow:(FLXSPrintWindow *)printWindow;
//-(void)gotoCurrentPage;
//
//@end
//
