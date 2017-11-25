 #import <UIKit/UIKit.h>
 #import "iPadExampleViewControllerBase.h"

 @class FLXSFlexDataGrid;

@interface iPadNestedViewController : iPadExampleViewControllerBase
@property (weak, nonatomic) IBOutlet FLXSFlexDataGrid *flxsFlexDataGrid;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;

@end
