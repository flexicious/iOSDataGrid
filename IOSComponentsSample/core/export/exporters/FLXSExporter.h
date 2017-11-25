#import "FLXSVersion.h"

#import "FLXSIDataGridFilterColumn.h"
#import "FLXSIExtendedDataGrid.h"
#import "FLXSUIUtils.h"
#import "FLXSClassFactory.h"
@class FLXSExportOptions;
@class FLXSFlexDataGridColumn;
@interface FLXSExporter : NSObject<UIDocumentInteractionControllerDelegate>
{

}

@property (nonatomic, assign) int nestIndent;
@property (nonatomic, weak) FLXSExportOptions* exportOptions;
@property (nonatomic, strong) NSMutableArray* allRecords;
@property (nonatomic, assign) int nestDepth;
@property (nonatomic, assign) BOOL reusePreviousLevelColumns;
@property (nonatomic,strong) UIDocumentInteractionController *documentInteractionController;

-(void)startDocument:(FLXSFlexDataGrid*)grid;
-(void)endDocument:(FLXSFlexDataGrid*)grid;
-(NSString*)writeHeader:(FLXSFlexDataGrid*)grid;

- (NSString *)writeRecord:(FLXSFlexDataGrid *)grid record:(NSObject *)record;
-(NSString*)writeFooter:(FLXSFlexDataGrid*)grid;
-(NSString*)contentType;
-(NSString*)name;
-(NSString*)extension;

+ (NSString *)getColumnHeader:(FLXSFlexDataGridColumn *)col colIndex:(int)colIndex;

+ (NSString *)getColumnHeaderUltimate:(FLXSFlexDataGridColumn *)col colIndex:(int)colIndex;

- (void)saveFile:(NSString *)body param1:(NSString *)param1;
/**
* Just in case in the client wants to customize the upload
* behavior of their exporters.
*/
-(void)uploadForEcho:(NSString*)body :(FLXSExportOptions*)exportOptions;
-(BOOL)isIncludedInExport:(FLXSFlexDataGridColumn*)col;

- (NSString *)getSpaces:(NSObject *)col spChar:(NSString *)spChar;


@end

