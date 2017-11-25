
#import <UIKit/UIKit.h>
#import "FLXSDemoVersion.h"
#import "iPadExampleViewControllerBase.h"

@interface iPadRadioButtonViewController : iPadExampleViewControllerBase{
    FLXSTriStateCheckBox *myCheckBox;
}
@property (strong, nonatomic) IBOutlet UIToolbar *ipadRadioButtonToolBar;
@property (strong, nonatomic) IBOutlet UIView *ipadRadioButtonView;
@property (strong, nonatomic) IBOutlet FLXSTriStateCheckBox *rbnOptionOne;
@property (strong, nonatomic) IBOutlet FLXSTriStateCheckBox *rbnOptionTwo;
@property (strong, nonatomic) IBOutlet FLXSTriStateCheckBox *rbnOptionThree;
@property (strong, nonatomic) IBOutlet FLXSTriStateCheckBox *tscbOptionOne;
@property (strong, nonatomic) IBOutlet FLXSTriStateCheckBox *tscbOptionTwo;
@property (strong, nonatomic) IBOutlet FLXSTriStateCheckBox *tscbOptionThree;

@property (strong, nonatomic) IBOutlet FLXSTriStateCheckBox *tscbOptionFour;

- (IBAction)rbnValueChangedHandler:(id)sender;
- (IBAction)rbnClickHandler:(id)sender;
@end
