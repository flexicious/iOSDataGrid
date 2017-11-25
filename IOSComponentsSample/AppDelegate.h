
#import <UIKit/UIKit.h>
#import "iPadDetailViewController.h"
#import "iPadThemePickerViewController.h"
#import "iPhoneThemePickerViewController.h"

@class iPadDetailViewController ;
@class iPhoneThemePickerViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate, ipadThemePickerDelegate, iPhoneThemePickerDelegate>

@property (strong, nonatomic) UINavigationController *navController ;

//default view controller is for iPhone, we swap it out if we see iPad with the nice collection view
@property (strong, nonatomic) iPadDetailViewController*iPadDetailVC;

@property (weak, nonatomic) FLXSExampleData * currentExample;


//theme picker stuff
@property (nonatomic, strong) iPhoneThemePickerViewController *iPhoneThemePickerVC;
@property (strong, nonatomic) UIPopoverController *iPadThemePickerPopoverVC;
@property (nonatomic, strong) iPadThemePickerViewController *iPadThemePickerVC;

-(void) applyTheme:(int)index;
-(void)showThemePicker:(UIBarButtonItem*)sender;
@end