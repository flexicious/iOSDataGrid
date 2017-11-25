

#import <UIKit/UIKit.h>
#import "FLXSDemoVersion.h"
#import "iPadExampleViewControllerBase.h"

@interface iPadComboBoxViewController : iPadExampleViewControllerBase{
}
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet FLXSComboBox *flxsComboBox;

@property (strong, nonatomic) IBOutlet FLXSComboBox *flxsComboBox_employee;

- (IBAction)btnSetSelectedValueClickHandler:(id)sender;
- (IBAction)btnShowselectedValueClickHandler:(id)sender;

- (IBAction)btnClearSelectedValueClickHandler:(id)sender ;
@end
