
#import "FLXSVersion.h"

#import <UIKit/UIKit.h>
#import "FLXSCheckBoxList.h"
#import "FLXSPopupUIViewControllerBase.h"

@class FLXSFlexDataGrid;

@interface FLXSSettingsViewController : FLXSPopupUIViewControllerBase
@property (weak, nonatomic) IBOutlet FLXSCheckBoxList *cbxColumns;
@property (weak, nonatomic) FLXSFlexDataGrid* grid;

@property (nonatomic, assign) BOOL filterVisible;
@property (nonatomic, assign) BOOL  footerVisible;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign)  BOOL enablePaging;
@property (nonatomic, assign)  BOOL enableFilters;
@property (nonatomic, assign) BOOL  enableFooters;
@property (weak, nonatomic) IBOutlet UISwitch *cbFooters;
@property (weak, nonatomic) IBOutlet UISwitch *cbFilters;
@property (weak, nonatomic) IBOutlet UITextField *txtPageSize;

- (IBAction)onOk:(id)sender;
- (IBAction)onCancel:(id)sender;

@end
