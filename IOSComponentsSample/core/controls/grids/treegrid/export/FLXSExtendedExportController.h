#import "FLXSExportController.h"
#import "FLXSVersion.h"

@class FLXSFlexDataGridColumnLevel;
/**
	 * The nested grid does not show an export options window.
	 * We directly run the export based on the data that is currently being
	 * displayed in the grid.
	 */

@interface FLXSExtendedExportController : FLXSExportController
{
}

@property (nonatomic, assign) float DEFAULT_TABLE_WIDTH; 

+(FLXSExtendedExportController*)instance;
/**
 * Run the actual export.
 */
-(void)doExport;
/**
*
* @param iCollectionView
* @param allOrSelectedPages
*
*/
- (void)runExport:(NSArray *)iCollectionView allOrSelectedPages:(BOOL)allOrSelectedPages;
/**
* Just build up the doc header, body, footer and ask server
* to buffer it back
* @param iCollectionView
*/
- (void)runNestedExport:(NSArray *)iCollectionView level:(FLXSFlexDataGridColumnLevel *)level;
-(int)getTotalRecords:(FLXSExporter*)exporter;
- (int)countLevels:(NSArray *)allRecords level:(FLXSFlexDataGridColumnLevel *)level;
- (NSString *)writeRecord:(NSObject *)obj level:(FLXSFlexDataGridColumnLevel *)level;
-(void)setExportLevel:(FLXSFlexDataGridColumnLevel*)level;

@end

