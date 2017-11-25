#import <UIKit/UIKit.h>
#import "FLXSDemoVersion.h"
#import "iPadExampleViewControllerBase.h"
@interface iPadCheckBoxListViewController :iPadExampleViewControllerBase{
}
 @property (strong, nonatomic) IBOutlet FLXSCheckBoxList *flxsCheckBoxList_simple;
@property (strong, nonatomic) IBOutlet FLXSCheckBoxList *flxsCheckBoxList_complex;

@property (strong, nonatomic) IBOutlet UIView *backgroundView;

- (IBAction)btnSetSelectedValuesHandler:(id)sender;
- (IBAction)btnShowSelectedValuesHandler:(id)sender;
- (IBAction)btnClearSelectedValuesHandler:(id)sender;
@end
