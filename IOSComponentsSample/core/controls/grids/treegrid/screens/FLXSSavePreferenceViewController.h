
#import "FLXSVersion.h"

#import <UIKit/UIKit.h>
#import "FLXSCheckBoxList.h"
#import "UIViewController+UIViewControllerAdditions.h"

@class FLXSFlexDataGrid;


@interface FLXSSavePreferenceViewController : UIViewController
- (IBAction)buttonPressCross:(id)sender;
- (IBAction)buttonPressClearSavedPreferences:(id)sender;
- (IBAction)buttonPressSavePreferences:(id)sender;
- (IBAction)buttonPressCancel:(id)sender;
@property (weak, nonatomic) FLXSFlexDataGrid* grid;
@property (assign, nonatomic) BOOL preferencesSet;
@property (assign, nonatomic) BOOL filtersEnabled;
@property (strong, nonatomic) NSString * preferenceName;
@property (assign, nonatomic) BOOL preferenceIsDefault;
@property (weak, nonatomic) IBOutlet UISwitch *cbPERSIST_COLUMN_ORDER;

@property (weak, nonatomic) IBOutlet UISwitch *cbPERSIST_COLUMN_VISIBILITY;

@property (weak, nonatomic) IBOutlet UISwitch *cbPERSIST_COLUMN_WIDTH;
@property (weak, nonatomic) IBOutlet UISwitch *cbPERSIST_FILTER;
@property (weak, nonatomic) IBOutlet UISwitch *cbPERSIST_SORT;
@property (weak, nonatomic) IBOutlet UISwitch *cbPERSIST_FOOTER_FILTER_VISIBILITY;
@property (weak, nonatomic) IBOutlet UISwitch *cbPERSIST_PAGE_SIZE;
@property (weak, nonatomic) IBOutlet UISwitch *cbPERSIST_PRINT_SETTINGS;
@property (weak, nonatomic) IBOutlet UISwitch *cbPERSIST_SCROLL;
@end
