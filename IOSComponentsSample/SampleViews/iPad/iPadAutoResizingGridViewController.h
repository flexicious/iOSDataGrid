
#import "iPadExampleViewControllerBase.h"

@interface iPadAutoResizingGridViewController : iPadExampleViewControllerBase

@property (strong, nonatomic) IBOutlet UIToolbar *iPadToolBar;
@property (strong, nonatomic) IBOutlet FLXSFlexDataGrid *flxsDataGrid;

- (IBAction)addItem:(id)sender;
@end
