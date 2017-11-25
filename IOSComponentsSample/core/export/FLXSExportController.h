@protocol FLXSIExtendedDataGrid;
#import "FLXSVersion.h"

#import "FLXSExportOptions.h"
@interface FLXSExportController : NSObject
{
}

@property (nonatomic, weak) FLXSExportOptions* exportOptions;
@property (nonatomic, weak) FLXSFlexDataGrid* grid;
@property (nonatomic, strong) UIPopoverController* popoverController;

+(FLXSExportController*)instance;

- (void)export:(FLXSFlexDataGrid *)grid exportOptions:(FLXSExportOptions *)exportOptions;

- (void)exportWithOptions:(FLXSFlexDataGrid *)grid exportOptions:(FLXSExportOptions *)exportOptions;
-(void)dispatchDataRequest;

- (void)runExport:(NSArray *)iCollectionView allOrSelectedPages:(BOOL)allOrSelectedPages;
-(void)onExportOptionsClose:(NSNotification*)ns ;


@end

