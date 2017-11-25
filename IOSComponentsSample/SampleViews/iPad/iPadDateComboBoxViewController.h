
#import <UIKit/UIKit.h>
#import "FLXSDemoVersion.h"
#import "iPadExampleViewControllerBase.h"

@interface iPadDateComboBoxViewController : iPadExampleViewControllerBase{
}
 @property (strong, nonatomic) IBOutlet UIView *backgroundView;

@property (strong, nonatomic) IBOutlet FLXSDateComboBox *flxsDateComboBox;
- (IBAction)btnShowSelectedValuesClickHandler:(id)sender;
- (IBAction)btnSetSelectedValuesClickHandler:(id)sender;
- (IBAction)btnClearSelectedValuesClickHandler:(id)sender;
@end
