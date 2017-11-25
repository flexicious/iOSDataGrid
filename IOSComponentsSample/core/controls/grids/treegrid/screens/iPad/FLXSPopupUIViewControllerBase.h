#import "FLXSVersion.h"

@interface FLXSPopupUIViewControllerBase : UIViewController

@property (strong, nonatomic) UIViewController *containerViewController;

- (void)initializeToolBar;

- (void)closePopup;

- (void)removeViewFromUIWindow;
@end