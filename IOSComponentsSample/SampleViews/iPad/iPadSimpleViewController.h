#import "iPadExampleViewControllerBase.h"

@interface iPadSimpleViewController : iPadExampleViewControllerBase
@property (weak, nonatomic) IBOutlet FLXSFlexDataGrid *flxsDataGrid;
-(NSString*)dataGridFormatCurrencyLabelFunction:(NSObject *)rowData :(FLXSFlexDataGridColumn *)col;
@end
