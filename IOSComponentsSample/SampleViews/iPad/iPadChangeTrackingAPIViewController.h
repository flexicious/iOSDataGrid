

#import "iPadExampleViewControllerBase.h"

@interface iPadChangeTrackingAPIViewController : iPadExampleViewControllerBase
@property (strong, nonatomic) IBOutlet FLXSFlexDataGrid *flxsDataGrid;
@property (strong, nonatomic) IBOutlet UIToolbar *iPadToolBar;
@property (strong, nonatomic) IBOutlet UITextView *textView;

- (IBAction)btnGetChanges_clickHandler:(id)sender;
@end
